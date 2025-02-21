#include "scripts\common.as"
{
  obj.EnumObjects(CUG_GROUP_MULTIPLE, table);

  for (u32 i = 0; i < table.size(); i++) {
    list(table[i]);
  }

  LOG(obj.GetName());

  if (@obj == @Root::Get()) {
    LOG("Done!");
  }
}

void listF(Object @obj = CUG_DEV_SEL_OBJ()) {
  obj.EnumObjects(CUG_GROUP_MULTIPLE, table);

  for (u32 i = 0; i < table.size(); i++) {
    list(table[i]);
  }

  LOG(obj.GetName());

  if (@obj == @Root::Get()) {
    LOG("Done!");
  }
}

App @FindApp() {
  return cast <App>(Root::Get().FindObject("", App::StaticGetClass(), 3));
}

void main(void) {
  for (int i = 0; i < 10; i++) {
    LOG("Hello! " + i);
  }

  App @app = FindApp();
  if (@app != null) {
    LOG("App name = " + app.GetName());
  }
}

void Test() {
  TestLog("tararara");
}
