Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9F7FAD3E5
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 00:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C160710E2DC;
	Thu, 23 Apr 2026 00:52:13 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Thu, 23 Apr 2026 00:52:11 UTC
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6690F10E2DC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:52:11 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261--SG59XNgNfeJCjA3UyWvKw-1; Wed,
 22 Apr 2026 20:46:02 -0400
X-MC-Unique: -SG59XNgNfeJCjA3UyWvKw-1
X-Mimecast-MFC-AGG-ID: -SG59XNgNfeJCjA3UyWvKw_1776905161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B221195608E; Thu, 23 Apr 2026 00:46:01 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75BCC30001A1; Thu, 23 Apr 2026 00:45:59 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Subject: [PATCH 1/4] nouveau: move HDMI sink caps to outp level for GSP-RM
Date: Thu, 23 Apr 2026 10:42:13 +1000
Message-ID: <20260423004552.3289884-2-airlied@gmail.com>
In-Reply-To: <20260423004552.3289884-1-airlied@gmail.com>
References: <20260423004552.3289884-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2rHuoQFmTr97qTg9AYWG_Y-caUXxVEZJ-ESvOLiETYI_1776905161
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

NVIDIA's driver sends SET_HDMI_SINK_CAPS during connector detection
(ApplyNewEdid), not during modeset. Move this RM call from the IOR-level
scdc callback to a new outp-level hdmi_sink_caps method that doesn't
require an acquired SOR.

Add nvif_outp_hdmi_sink_caps() routed through the noacquire dispatch
table and call it from nouveau_connector_detect() for TMDS outputs on
Turing+. Remove r535_sor_hdmi_scdc and its .scdc entry from r535_sor_hdmi
since GSP now gets sink caps at detect time. The gm200 hardware scdc
callback is preserved for direct register writes on pre-GSP chips.

This was claude code assisted.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/include/nvif/if0012.h | 11 ++++
 drivers/gpu/drm/nouveau/include/nvif/outp.h   |  2 +
 drivers/gpu/drm/nouveau/nouveau_connector.c   | 11 ++++
 drivers/gpu/drm/nouveau/nvif/outp.c           | 19 +++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/outp.h   |  2 +
 .../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c  | 23 +++++++--
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 51 +++++++++----------
 7 files changed, 89 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gpu/dr=
m/nouveau/include/nvif/if0012.h
index bde9bfae8d11f..89cfac7ef3a54 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/if0012.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
@@ -43,6 +43,7 @@ union nvif_outp_args {
=20
 #define NVIF_OUTP_V0_DETECT        0x00
 #define NVIF_OUTP_V0_EDID_GET      0x01
+#define NVIF_OUTP_V0_HDMI_SINK_CAPS 0x02
=20
 #define NVIF_OUTP_V0_INHERIT       0x10
 #define NVIF_OUTP_V0_ACQUIRE       0x11
@@ -165,6 +166,16 @@ union nvif_outp_lvds_args {
 =09} v0;
 };
=20
+union nvif_outp_hdmi_sink_caps_args {
+=09struct nvif_outp_hdmi_sink_caps_v0 {
+=09=09__u8 version;
+=09=09__u8 scdc;
+=09=09__u8 scdc_scrambling;
+=09=09__u8 scdc_low_rates;
+=09=09__u8 pad04[4];
+=09} v0;
+};
+
 union nvif_outp_hdmi_args {
 =09struct nvif_outp_hdmi_v0 {
 =09=09__u8 version;
diff --git a/drivers/gpu/drm/nouveau/include/nvif/outp.h b/drivers/gpu/drm/=
nouveau/include/nvif/outp.h
index bc122a5ba7df7..240e1f80ed539 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/outp.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/outp.h
@@ -66,6 +66,8 @@ enum nvif_outp_detect_status {
=20
 enum nvif_outp_detect_status nvif_outp_detect(struct nvif_outp *);
 int nvif_outp_edid_get(struct nvif_outp *, u8 **pedid);
+int nvif_outp_hdmi_sink_caps(struct nvif_outp *, bool scdc, bool scdc_scra=
mbling,
+=09=09=09     bool scdc_low_rates);
=20
 int nvif_outp_load_detect(struct nvif_outp *, u32 loadval);
 int nvif_outp_acquire_dac(struct nvif_outp *);
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/=
nouveau/nouveau_connector.c
index cc239492c7f0b..eae37d938f3bc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -48,6 +48,7 @@
=20
 #include <nvif/class.h>
 #include <nvif/if0011.h>
+#include <nvif/outp.h>
=20
 struct drm_display_mode *
 nouveau_conn_native_mode(struct drm_connector *connector)
@@ -637,6 +638,16 @@ nouveau_connector_detect(struct drm_connector *connect=
or, bool force)
 =09=09nouveau_connector_set_encoder(connector, nv_encoder);
 =09=09conn_status =3D connector_status_connected;
=20
+=09=09if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_TMDS &&
+=09=09    drm->client.device.info.family >=3D NV_DEVICE_INFO_V0_TURING) {
+=09=09=09struct drm_hdmi_info *hdmi =3D &connector->display_info.hdmi;
+
+=09=09=09nvif_outp_hdmi_sink_caps(&nv_encoder->outp,
+=09=09=09=09=09=09hdmi->scdc.supported,
+=09=09=09=09=09=09hdmi->scdc.scrambling.supported,
+=09=09=09=09=09=09hdmi->scdc.scrambling.low_rates);
+=09=09}
+
 =09=09if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_DP)
 =09=09=09drm_dp_cec_set_edid(&nv_connector->aux, nv_connector->edid);
=20
diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/=
nvif/outp.c
index 8cf4775a0a1eb..d66f437587ff3 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -461,6 +461,25 @@ nvif_outp_edid_get(struct nvif_outp *outp, u8 **pedid)
 =09return ret;
 }
=20
+int
+nvif_outp_hdmi_sink_caps(struct nvif_outp *outp, bool scdc, bool scdc_scra=
mbling,
+=09=09=09 bool scdc_low_rates)
+{
+=09struct nvif_outp_hdmi_sink_caps_v0 args;
+=09int ret;
+
+=09args.version =3D 0;
+=09args.scdc =3D scdc;
+=09args.scdc_scrambling =3D scdc_scrambling;
+=09args.scdc_low_rates =3D scdc_low_rates;
+
+=09ret =3D nvif_mthd(&outp->object, NVIF_OUTP_V0_HDMI_SINK_CAPS, &args, si=
zeof(args));
+=09NVIF_ERRON(ret, &outp->object,
+=09=09   "[HDMI_SINK_CAPS scdc:%d scrambling:%d low_rates:%d]",
+=09=09   args.scdc, args.scdc_scrambling, args.scdc_low_rates);
+=09return ret;
+}
+
 enum nvif_outp_detect_status
 nvif_outp_detect(struct nvif_outp *outp)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h b/drivers/gpu/=
drm/nouveau/nvkm/engine/disp/outp.h
index ebd2f499b4b1d..fd54c17ba4d6d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
@@ -95,6 +95,8 @@ struct nvkm_outp_func {
=20
 =09int (*detect)(struct nvkm_outp *);
 =09int (*edid_get)(struct nvkm_outp *, u8 *data, u16 *size);
+=09void (*hdmi_sink_caps)(struct nvkm_outp *, bool scdc, bool scrambling,
+=09=09=09       bool low_rates);
=20
 =09struct nvkm_ior *(*inherit)(struct nvkm_outp *);
 =09int (*acquire)(struct nvkm_outp *, bool hda);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/disp/uoutp.c
index 377d0e0cef848..84381ba71ebaf 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *argv=
, u32 argc)
=20
 =09if (!ior->func->hdmi ||
 =09    args->v0.max_ac_packet > 0x1f ||
-=09    args->v0.rekey > 0x7f ||
-=09    (args->v0.scdc && !ior->func->hdmi->scdc))
+=09    args->v0.rekey > 0x7f)
 =09=09return -EINVAL;
=20
 =09if (!args->v0.enable) {
@@ -473,6 +472,21 @@ nvkm_uoutp_mthd_edid_get(struct nvkm_outp *outp, void =
*argv, u32 argc)
 =09return outp->func->edid_get(outp, args->v0.data, &args->v0.size);
 }
=20
+static int
+nvkm_uoutp_mthd_hdmi_sink_caps(struct nvkm_outp *outp, void *argv, u32 arg=
c)
+{
+=09union nvif_outp_hdmi_sink_caps_args *args =3D argv;
+
+=09if (argc !=3D sizeof(args->v0) || args->v0.version !=3D 0)
+=09=09return -ENOSYS;
+=09if (!outp->func->hdmi_sink_caps)
+=09=09return -EINVAL;
+
+=09outp->func->hdmi_sink_caps(outp, args->v0.scdc, args->v0.scdc_scramblin=
g,
+=09=09=09=09   args->v0.scdc_low_rates);
+=09return 0;
+}
+
 static int
 nvkm_uoutp_mthd_detect(struct nvkm_outp *outp, void *argv, u32 argc)
 {
@@ -522,8 +536,9 @@ static int
 nvkm_uoutp_mthd_noacquire(struct nvkm_outp *outp, u32 mthd, void *argv, u3=
2 argc, bool *invalid)
 {
 =09switch (mthd) {
-=09case NVIF_OUTP_V0_DETECT     : return nvkm_uoutp_mthd_detect     (outp,=
 argv, argc);
-=09case NVIF_OUTP_V0_EDID_GET   : return nvkm_uoutp_mthd_edid_get   (outp,=
 argv, argc);
+=09case NVIF_OUTP_V0_DETECT         : return nvkm_uoutp_mthd_detect       =
  (outp, argv, argc);
+=09case NVIF_OUTP_V0_EDID_GET       : return nvkm_uoutp_mthd_edid_get     =
  (outp, argv, argc);
+=09case NVIF_OUTP_V0_HDMI_SINK_CAPS : return nvkm_uoutp_mthd_hdmi_sink_cap=
s (outp, argv, argc);
 =09case NVIF_OUTP_V0_INHERIT    : return nvkm_uoutp_mthd_inherit    (outp,=
 argv, argc);
 =09case NVIF_OUTP_V0_ACQUIRE    : return nvkm_uoutp_mthd_acquire    (outp,=
 argv, argc);
 =09case NVIF_OUTP_V0_LOAD_DETECT: return nvkm_uoutp_mthd_load_detect(outp,=
 argv, argc);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drive=
rs/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 6e63df816d855..fa20a0c633653 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -468,31 +468,6 @@ r535_sor_dp =3D {
 =09.audio =3D r535_sor_dp_audio,
 };
=20
-static void
-r535_sor_hdmi_scdc(struct nvkm_ior *sor, u32 khz, bool support, bool scram=
bling,
-=09=09   bool scrambling_low_rates)
-{
-=09struct nvkm_outp *outp =3D sor->asy.outp;
-=09struct nvkm_disp *disp =3D outp->disp;
-=09NV0073_CTRL_SPECIFIC_SET_HDMI_SINK_CAPS_PARAMS *ctrl;
-
-=09ctrl =3D nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
-=09=09=09=09    NV0073_CTRL_CMD_SPECIFIC_SET_HDMI_SINK_CAPS, sizeof(*ctrl)=
);
-=09if (WARN_ON(IS_ERR(ctrl)))
-=09=09return;
-
-=09ctrl->displayId =3D BIT(outp->index);
-=09ctrl->caps =3D 0;
-=09if (support)
-=09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
SCDC_SUPPORTED, TRUE);
-=09if (scrambling)
-=09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
GT_340MHZ_CLOCK_SUPPORTED, TRUE);
-=09if (scrambling_low_rates)
-=09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
LTE_340MHZ_SCRAMBLING_SUPPORTED, TRUE);
-
-=09WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
-}
-
 static void
 r535_sor_hdmi_ctrl_audio_mute(struct nvkm_outp *outp, bool mute)
 {
@@ -580,7 +555,6 @@ r535_sor_hdmi_ctrl(struct nvkm_ior *sor, int head, bool=
 enable, u8 max_ac_packet
 static const struct nvkm_ior_func_hdmi
 r535_sor_hdmi =3D {
 =09.ctrl =3D r535_sor_hdmi_ctrl,
-=09.scdc =3D r535_sor_hdmi_scdc,
 =09/*TODO: SF_USER -> KMS. */
 =09.infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
 =09.infoframe_vsi =3D gv100_sor_hdmi_infoframe_vsi,
@@ -1242,6 +1216,30 @@ r535_tmds_edid_get(struct nvkm_outp *outp, u8 *data,=
 u16 *psize)
 =09return ret;
 }
=20
+static void
+r535_outp_hdmi_sink_caps(struct nvkm_outp *outp, bool scdc, bool scramblin=
g,
+=09=09=09 bool low_rates)
+{
+=09struct nvkm_disp *disp =3D outp->disp;
+=09NV0073_CTRL_SPECIFIC_SET_HDMI_SINK_CAPS_PARAMS *ctrl;
+
+=09ctrl =3D nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
+=09=09=09=09    NV0073_CTRL_CMD_SPECIFIC_SET_HDMI_SINK_CAPS, sizeof(*ctrl)=
);
+=09if (WARN_ON(IS_ERR(ctrl)))
+=09=09return;
+
+=09ctrl->displayId =3D BIT(outp->index);
+=09ctrl->caps =3D 0;
+=09if (scdc)
+=09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
SCDC_SUPPORTED, TRUE);
+=09if (scrambling)
+=09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
GT_340MHZ_CLOCK_SUPPORTED, TRUE);
+=09if (low_rates)
+=09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
LTE_340MHZ_SCRAMBLING_SUPPORTED, TRUE);
+
+=09WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
+}
+
 static const struct nvkm_outp_func
 r535_tmds =3D {
 =09.detect =3D r535_outp_detect,
@@ -1249,6 +1247,7 @@ r535_tmds =3D {
 =09.acquire =3D r535_outp_acquire,
 =09.release =3D r535_outp_release,
 =09.edid_get =3D r535_tmds_edid_get,
+=09.hdmi_sink_caps =3D r535_outp_hdmi_sink_caps,
 };
=20
 static int
--=20
2.53.0

