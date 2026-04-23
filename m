Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF9CFAD3E5
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 00:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8C010E2EA;
	Thu, 23 Apr 2026 00:52:21 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331F510E2EA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:52:17 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-Rk-ZGCMvPuGIX5EMFfqjjw-1; Wed,
 22 Apr 2026 20:46:07 -0400
X-MC-Unique: Rk-ZGCMvPuGIX5EMFfqjjw-1
X-Mimecast-MFC-AGG-ID: Rk-ZGCMvPuGIX5EMFfqjjw_1776905167
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E243E1956089; Thu, 23 Apr 2026 00:46:06 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0759B30001A1; Thu, 23 Apr 2026 00:46:04 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Subject: [PATCH 3/4] nouveau: add HDMI FRL training API and retrain event
 handling
Date: Thu, 23 Apr 2026 10:42:15 +1000
Message-ID: <20260423004552.3289884-4-airlied@gmail.com>
In-Reply-To: <20260423004552.3289884-1-airlied@gmail.com>
References: <20260423004552.3289884-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6qckStmgotL2jm91twvnU1gac2rGByqOoWpV9L14t3c_1776905167
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Dave Airlie <airlied@redhat.com>

Add the nvif/nvkm plumbing for HDMI 2.1 Fixed Rate Link training and
FRL retrain event notification from GSP-RM firmware.

Wire format: NVIF_OUTP_V0_HDMI_FRL (0x51) method with head and frl_rate
parameters, dispatched through the acquired IOR table in uoutp.c.

Backend: r535 GSP-RM implementation using SET_HDMI_FRL_CONFIG (0x73029a)
RM control with NVVAL-encoded FRL rate. Training attempts real link
training first, falling back to fake LT on failure.

Events: Register for NV2080_NOTIFIERS_HDMI_FRL_RETRAINING_REQUEST (18)
from GSP, propagated as NVKM_DPYID_FRL_RETRAIN / NVIF_CONN_EVENT_V0_FRL
through the existing connector event infrastructure.

FRL is automatically cleared when HDMI output is disabled.

This was claude code assisted.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/include/nvif/if0011.h |  1 +
 drivers/gpu/drm/nouveau/include/nvif/if0012.h | 10 +++
 drivers/gpu/drm/nouveau/include/nvif/outp.h   |  1 +
 .../drm/nouveau/include/nvkm/engine/disp.h    |  8 ++-
 drivers/gpu/drm/nouveau/nvif/outp.c           | 16 +++++
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |  1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/uconn.c  |  3 +
 .../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c  | 20 ++++++
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 65 ++++++++++++++++++-
 .../nvkm/subdev/gsp/rm/r535/nvrm/disp.h       | 26 ++++++++
 10 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0011.h b/drivers/gpu/dr=
m/nouveau/include/nvif/if0011.h
index 3ed0ddd75bd8f..3dfbcd1238fc0 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/if0011.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/if0011.h
@@ -26,6 +26,7 @@ union nvif_conn_event_args {
 #define NVIF_CONN_EVENT_V0_PLUG   0x01
 #define NVIF_CONN_EVENT_V0_UNPLUG 0x02
 #define NVIF_CONN_EVENT_V0_IRQ    0x04
+#define NVIF_CONN_EVENT_V0_FRL    0x08
 =09=09__u8 types;
 =09=09__u8 pad02[6];
 =09} v0;
diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gpu/dr=
m/nouveau/include/nvif/if0012.h
index dc0a5c372f511..84145d22c2593 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/if0012.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
@@ -57,6 +57,7 @@ union nvif_outp_args {
 #define NVIF_OUTP_V0_LVDS          0x40
=20
 #define NVIF_OUTP_V0_HDMI          0x50
+#define NVIF_OUTP_V0_HDMI_FRL      0x51
=20
 #define NVIF_OUTP_V0_INFOFRAME     0x60
 #define NVIF_OUTP_V0_HDA_ELD       0x61
@@ -192,6 +193,15 @@ union nvif_outp_hdmi_args {
 =09} v0;
 };
=20
+union nvif_outp_hdmi_frl_args {
+=09struct nvif_outp_hdmi_frl_v0 {
+=09=09__u8 version;
+=09=09__u8 head;
+=09=09__u8 frl_rate;
+=09=09__u8 pad03[5];
+=09} v0;
+};
+
 union nvif_outp_infoframe_args {
 =09struct nvif_outp_infoframe_v0 {
 =09=09__u8 version;
diff --git a/drivers/gpu/drm/nouveau/include/nvif/outp.h b/drivers/gpu/drm/=
nouveau/include/nvif/outp.h
index 55c02a34f381e..22681b14add4f 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/outp.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/outp.h
@@ -93,6 +93,7 @@ int nvif_outp_lvds(struct nvif_outp *, bool dual, bool bp=
c8);
=20
 int nvif_outp_hdmi(struct nvif_outp *, int head, bool enable, u8 max_ac_pa=
cket, u8 rekey, u32 khz,
 =09=09   bool scdc, bool scdc_scrambling, bool scdc_low_rates);
+int nvif_outp_hdmi_frl(struct nvif_outp *, int head, int frl_rate);
=20
 int nvif_outp_infoframe(struct nvif_outp *, u8 type, struct nvif_outp_info=
frame_v0 *, u32 size);
 int nvif_outp_hda_eld(struct nvif_outp *, int head, void *data, u32 size);
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h b/drivers/g=
pu/drm/nouveau/include/nvkm/engine/disp.h
index 7903d7470d194..4736f07a266b9 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
@@ -18,12 +18,14 @@ struct nvkm_disp {
 =09=09struct nvkm_gsp_object objcom;
 =09=09struct nvkm_gsp_object object;
=20
-#define NVKM_DPYID_PLUG   BIT(0)
-#define NVKM_DPYID_UNPLUG BIT(1)
-#define NVKM_DPYID_IRQ    BIT(2)
+#define NVKM_DPYID_PLUG       BIT(0)
+#define NVKM_DPYID_UNPLUG     BIT(1)
+#define NVKM_DPYID_IRQ        BIT(2)
+#define NVKM_DPYID_FRL_RETRAIN BIT(3)
 =09=09struct nvkm_event event;
 =09=09struct nvkm_gsp_event hpd;
 =09=09struct nvkm_gsp_event irq;
+=09=09struct nvkm_gsp_event frl_retrain;
=20
 =09=09u32 assigned_sors;
 =09} rm;
diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/=
nvif/outp.c
index 60479c884b2dc..828c312536d41 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -222,6 +222,22 @@ nvif_outp_infoframe(struct nvif_outp *outp, u8 type, s=
truct nvif_outp_infoframe_
 =09return ret;
 }
=20
+int
+nvif_outp_hdmi_frl(struct nvif_outp *outp, int head, int frl_rate)
+{
+=09struct nvif_outp_hdmi_frl_v0 args;
+=09int ret;
+
+=09args.version =3D 0;
+=09args.head =3D head;
+=09args.frl_rate =3D frl_rate;
+
+=09ret =3D nvif_mthd(&outp->object, NVIF_OUTP_V0_HDMI_FRL, &args, sizeof(a=
rgs));
+=09NVIF_ERRON(ret, &outp->object, "[HDMI_FRL head:%d frl_rate:%d]",
+=09=09   args.head, args.frl_rate);
+=09return ret;
+}
+
 int
 nvif_outp_hdmi(struct nvif_outp *outp, int head, bool enable, u8 max_ac_pa=
cket, u8 rekey,
 =09       u32 khz, bool scdc, bool scdc_scrambling, bool scdc_low_rates)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h b/drivers/gpu/d=
rm/nouveau/nvkm/engine/disp/ior.h
index 3ba04bead2f9c..fba24625b6882 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
@@ -75,6 +75,7 @@ struct nvkm_ior_func {
 =09=09void (*infoframe_avi)(struct nvkm_ior *, int head, void *data, u32 s=
ize);
 =09=09void (*infoframe_vsi)(struct nvkm_ior *, int head, void *data, u32 s=
ize);
 =09=09void (*audio)(struct nvkm_ior *, int head, bool enable);
+=09=09void (*frl_train)(struct nvkm_ior *, int head, int frl_rate);
 =09} *hdmi;
=20
 =09const struct nvkm_ior_func_dp {
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/disp/uconn.c
index 23d1e5c27bb1e..e1e2760833ad5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
@@ -43,6 +43,8 @@ nvkm_uconn_uevent_gsp(struct nvkm_object *object, u64 tok=
en, u32 bits)
 =09=09args.v0.types |=3D NVIF_CONN_EVENT_V0_UNPLUG;
 =09if (bits & NVKM_DPYID_IRQ)
 =09=09args.v0.types |=3D NVIF_CONN_EVENT_V0_IRQ;
+=09if (bits & NVKM_DPYID_FRL_RETRAIN)
+=09=09args.v0.types |=3D NVIF_CONN_EVENT_V0_FRL;
=20
 =09return object->client->event(token, &args, sizeof(args.v0));
 }
@@ -122,6 +124,7 @@ nvkm_uconn_uevent(struct nvkm_object *object, void *arg=
v, u32 argc, struct nvkm_
 =09=09if (args->v0.types & NVIF_CONN_EVENT_V0_PLUG  ) bits |=3D NVKM_DPYID=
_PLUG;
 =09=09if (args->v0.types & NVIF_CONN_EVENT_V0_UNPLUG) bits |=3D NVKM_DPYID=
_UNPLUG;
 =09=09if (args->v0.types & NVIF_CONN_EVENT_V0_IRQ   ) bits |=3D NVKM_DPYID=
_IRQ;
+=09=09if (args->v0.types & NVIF_CONN_EVENT_V0_FRL   ) bits |=3D NVKM_DPYID=
_FRL_RETRAIN;
=20
 =09=09return nvkm_uevent_add(uevent, &disp->rm.event, outp->index, bits,
 =09=09=09=09       nvkm_uconn_uevent_gsp);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/disp/uoutp.c
index 202fdc73f7cab..2245fbd2d1e94 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -239,6 +239,23 @@ nvkm_uoutp_mthd_infoframe(struct nvkm_outp *outp, void=
 *argv, u32 argc)
 =09return -EINVAL;
 }
=20
+static int
+nvkm_uoutp_mthd_hdmi_frl(struct nvkm_outp *outp, void *argv, u32 argc)
+{
+=09union nvif_outp_hdmi_frl_args *args =3D argv;
+=09struct nvkm_ior *ior =3D outp->ior;
+
+=09if (argc !=3D sizeof(args->v0) || args->v0.version !=3D 0)
+=09=09return -ENOSYS;
+=09if (!ior->func->hdmi || !ior->func->hdmi->frl_train)
+=09=09return -EINVAL;
+=09if (!nvkm_head_find(outp->disp, args->v0.head))
+=09=09return -EINVAL;
+
+=09ior->func->hdmi->frl_train(ior, args->v0.head, args->v0.frl_rate);
+=09return 0;
+}
+
 static int
 nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *argv, u32 argc)
 {
@@ -257,6 +274,8 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *argv=
, u32 argc)
 =09=09return -EINVAL;
=20
 =09if (!args->v0.enable) {
+=09=09if (ior->func->hdmi->frl_train)
+=09=09=09ior->func->hdmi->frl_train(ior, args->v0.head, 0);
 =09=09ior->func->hdmi->infoframe_avi(ior, args->v0.head, NULL, 0);
 =09=09ior->func->hdmi->infoframe_vsi(ior, args->v0.head, NULL, 0);
 =09=09ior->func->hdmi->ctrl(ior, args->v0.head, false, 0, 0);
@@ -518,6 +537,7 @@ nvkm_uoutp_mthd_acquired(struct nvkm_outp *outp, u32 mt=
hd, void *argv, u32 argc)
 =09case NVIF_OUTP_V0_RELEASE      : return nvkm_uoutp_mthd_release      (o=
utp, argv, argc);
 =09case NVIF_OUTP_V0_LVDS         : return nvkm_uoutp_mthd_lvds         (o=
utp, argv, argc);
 =09case NVIF_OUTP_V0_HDMI         : return nvkm_uoutp_mthd_hdmi         (o=
utp, argv, argc);
+=09case NVIF_OUTP_V0_HDMI_FRL     : return nvkm_uoutp_mthd_hdmi_frl     (o=
utp, argv, argc);
 =09case NVIF_OUTP_V0_INFOFRAME    : return nvkm_uoutp_mthd_infoframe    (o=
utp, argv, argc);
 =09case NVIF_OUTP_V0_HDA_ELD      : return nvkm_uoutp_mthd_hda_eld      (o=
utp, argv, argc);
 =09case NVIF_OUTP_V0_DP_TRAIN     : return nvkm_uoutp_mthd_dp_train     (o=
utp, argv, argc);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drive=
rs/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 2fb7cc83852f9..a4a9462d59027 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -552,6 +552,46 @@ r535_sor_hdmi_ctrl(struct nvkm_ior *sor, int head, boo=
l enable, u8 max_ac_packet
 =09WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
 }
=20
+static int
+r535_sor_frl_train_one(struct nvkm_ior *sor, int frl_rate, bool fake_lt)
+{
+=09struct nvkm_disp *disp =3D sor->disp;
+=09NV0073_CTRL_SPECIFIC_SET_HDMI_FRL_LINK_CONFIG_PARAMS *ctrl;
+=09int ret;
+
+=09ctrl =3D nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
+=09=09=09=09    NV0073_CTRL_CMD_SPECIFIC_SET_HDMI_FRL_CONFIG,
+=09=09=09=09    sizeof(*ctrl));
+=09if (IS_ERR(ctrl))
+=09=09return PTR_ERR(ctrl);
+
+=09ctrl->displayId =3D BIT(sor->asy.outp->index);
+=09ctrl->data =3D NVVAL(NV0073_CTRL, HDMI_FRL_DATA, SET_FRL_RATE, frl_rate=
);
+=09ctrl->bFakeLt =3D fake_lt;
+=09ctrl->bDoNotSkipLt =3D true;
+
+=09ret =3D nvkm_gsp_rm_ctrl_push(&disp->rm.objcom, &ctrl, sizeof(*ctrl));
+=09if (ret) {
+=09=09nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
+=09=09return ret;
+=09}
+
+=09ret =3D ctrl->bLtSkipped ? -EIO : 0;
+
+=09nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
+=09return ret;
+}
+
+static void
+r535_sor_frl_train(struct nvkm_ior *sor, int head, int frl_rate)
+{
+=09if (!frl_rate)
+=09=09return;
+
+=09if (r535_sor_frl_train_one(sor, frl_rate, false))
+=09=09r535_sor_frl_train_one(sor, frl_rate, true);
+}
+
 static const struct nvkm_ior_func_hdmi
 r535_sor_hdmi =3D {
 =09.ctrl =3D r535_sor_hdmi_ctrl,
@@ -559,6 +599,7 @@ r535_sor_hdmi =3D {
 =09.infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
 =09.infoframe_vsi =3D gv100_sor_hdmi_infoframe_vsi,
 =09.audio =3D r535_sor_hdmi_audio,
+=09.frl_train =3D r535_sor_frl_train,
 };
=20
 static const struct nvkm_ior_func
@@ -1383,6 +1424,21 @@ r535_outp_new(struct nvkm_disp *disp, u32 id)
 =09return 0;
 }
=20
+static void
+r535_disp_frl_retrain(struct nvkm_gsp_event *event, void *repv, u32 repc)
+{
+=09struct nvkm_disp *disp =3D container_of(event, typeof(*disp), rm.frl_re=
train);
+=09Nv2080HdmiFrlRetrainingRequestNotification *frl =3D repv;
+
+=09if (WARN_ON(repc < sizeof(*frl)))
+=09=09return;
+
+=09nvkm_debug(&disp->engine.subdev, "event: frl retrain displayId %08x\n",=
 frl->displayId);
+
+=09if (frl->displayId)
+=09=09nvkm_event_ntfy(&disp->rm.event, fls(frl->displayId) - 1, NVKM_DPYID=
_FRL_RETRAIN);
+}
+
 static void
 r535_disp_irq(struct nvkm_gsp_event *event, void *repv, u32 repc)
 {
@@ -1465,6 +1521,7 @@ r535_disp_fini(struct nvkm_disp *disp, bool suspend)
 =09nvkm_gsp_rm_free(&disp->rm.object);
=20
 =09if (!suspend) {
+=09=09nvkm_gsp_event_dtor(&disp->rm.frl_retrain);
 =09=09nvkm_gsp_event_dtor(&disp->rm.irq);
 =09=09nvkm_gsp_event_dtor(&disp->rm.hpd);
 =09=09nvkm_event_fini(&disp->rm.event);
@@ -1706,7 +1763,7 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 =09=09=09return ret;
 =09}
=20
-=09ret =3D nvkm_event_init(&r535_disp_event, &gsp->subdev, 3, 32, &disp->r=
m.event);
+=09ret =3D nvkm_event_init(&r535_disp_event, &gsp->subdev, 4, 32, &disp->r=
m.event);
 =09if (WARN_ON(ret))
 =09=09return ret;
=20
@@ -1720,6 +1777,12 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 =09if (ret)
 =09=09return ret;
=20
+=09ret =3D nvkm_gsp_device_event_ctor(&disp->rm.device, 0x007e0002,
+=09=09=09=09=09 NV2080_NOTIFIERS_HDMI_FRL_RETRAINING_REQUEST,
+=09=09=09=09=09 r535_disp_frl_retrain, &disp->rm.frl_retrain);
+=09if (ret)
+=09=09return ret;
+
 =09/* RAMHT. */
 =09ret =3D nvkm_ramht_new(device, disp->func->ramht_size ? disp->func->ram=
ht_size :
 =09=09=09     0x1000, 0, disp->inst, &disp->ramht);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/disp.h b/=
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/disp.h
index 7b7539639540a..f6c7f0b96a48b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/disp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/disp.h
@@ -184,6 +184,12 @@ typedef struct Nv2080DpIrqNotificationRec {
     NvU32 displayId;
 } Nv2080DpIrqNotification;
=20
+#define NV2080_NOTIFIERS_HDMI_FRL_RETRAINING_REQUEST               (18)
+
+typedef struct {
+    NvU32 displayId;
+} Nv2080HdmiFrlRetrainingRequestNotification;
+
 #define NV0073_CTRL_CMD_SYSTEM_GET_CONNECT_STATE (0x730122U) /* finn: Eval=
uated from "(FINN_NV04_DISPLAY_COMMON_SYSTEM_INTERFACE_ID << 8) | NV0073_CT=
RL_SYSTEM_GET_CONNECT_STATE_PARAMS_MESSAGE_ID" */
 typedef struct NV0073_CTRL_SYSTEM_GET_CONNECT_STATE_PARAMS {
     NvU32 subDeviceInstance;
@@ -393,6 +399,26 @@ typedef struct NV0073_CTRL_SPECIFIC_SET_HDMI_SINK_CAPS=
_PARAMS {
 #define NV0073_CTRL_CMD_SPECIFIC_SET_HDMI_SINK_CAPS_DSC_MAX_FRL_RATE_SUPPO=
RTED_4LANES_10G (0x00000005U)
 #define NV0073_CTRL_CMD_SPECIFIC_SET_HDMI_SINK_CAPS_DSC_MAX_FRL_RATE_SUPPO=
RTED_4LANES_12G (0x00000006U)
=20
+#define NV0073_CTRL_CMD_SPECIFIC_SET_HDMI_FRL_CONFIG (0x73029aU)
+#define NV0073_CTRL_SPECIFIC_SET_HDMI_FRL_LINK_CONFIG_PARAMS_MESSAGE_ID (0=
x9AU)
+typedef struct NV0073_CTRL_SPECIFIC_SET_HDMI_FRL_LINK_CONFIG_PARAMS {
+    NvU32  subDeviceInstance;
+    NvU32  displayId;
+    NvU32  data;
+    NvBool bFakeLt;
+    NvBool bDoNotSkipLt;
+    NvBool bLtSkipped;
+    NvBool bLinkAssessmentOnly;
+} NV0073_CTRL_SPECIFIC_SET_HDMI_FRL_LINK_CONFIG_PARAMS;
+#define NV0073_CTRL_HDMI_FRL_DATA_SET_FRL_RATE                            =
               2:0
+#define NV0073_CTRL_HDMI_FRL_DATA_SET_FRL_RATE_NONE       (0x00000000U)
+#define NV0073_CTRL_HDMI_FRL_DATA_SET_FRL_RATE_3LANES_3G  (0x00000001U)
+#define NV0073_CTRL_HDMI_FRL_DATA_SET_FRL_RATE_3LANES_6G  (0x00000002U)
+#define NV0073_CTRL_HDMI_FRL_DATA_SET_FRL_RATE_4LANES_6G  (0x00000003U)
+#define NV0073_CTRL_HDMI_FRL_DATA_SET_FRL_RATE_4LANES_8G  (0x00000004U)
+#define NV0073_CTRL_HDMI_FRL_DATA_SET_FRL_RATE_4LANES_10G (0x00000005U)
+#define NV0073_CTRL_HDMI_FRL_DATA_SET_FRL_RATE_4LANES_12G (0x00000006U)
+
 #define NV0073_CTRL_SET_OD_MAX_PACKET_SIZE     36U
=20
 #define NV0073_CTRL_CMD_SPECIFIC_SET_OD_PACKET (0x730288U) /* finn: Evalua=
ted from "(FINN_NV04_DISPLAY_COMMON_SPECIFIC_INTERFACE_ID << 8) | NV0073_CT=
RL_SPECIFIC_SET_OD_PACKET_PARAMS_MESSAGE_ID" */
--=20
2.53.0

