Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B23FAD3E6
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 00:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4480610EA79;
	Thu, 23 Apr 2026 00:52:17 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Thu, 23 Apr 2026 00:52:13 UTC
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F084C10E2EA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:52:13 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-aJ9JTpKpP3-9pcqZTqUDAw-1; Wed,
 22 Apr 2026 20:46:04 -0400
X-MC-Unique: aJ9JTpKpP3-9pcqZTqUDAw-1
X-Mimecast-MFC-AGG-ID: aJ9JTpKpP3-9pcqZTqUDAw_1776905164
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20EED1956080; Thu, 23 Apr 2026 00:46:04 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51F7530001A1; Thu, 23 Apr 2026 00:46:01 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Subject: [PATCH 2/4] nouveau: add FRL and DSC parameters to HDMI sink caps
 interface
Date: Thu, 23 Apr 2026 10:42:14 +1000
Message-ID: <20260423004552.3289884-3-airlied@gmail.com>
In-Reply-To: <20260423004552.3289884-1-airlied@gmail.com>
References: <20260423004552.3289884-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SxVv_5uKjLejLsiYZmBEkmkPR5ACpvbOBt65rT-P5Xk_1776905164
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

Extend the outp-level hdmi_sink_caps method with max_frl_rate and
dsc_1p2 parameters so GSP firmware can be informed about the sink's
HDMI 2.1 FRL and DSC capabilities at detect time.

Add nouveau_hdmi_get_frl_rate() helper to convert drm_hdmi_info
lane count and per-lane rate into the FRL rate index (1-6) expected
by the RM SET_HDMI_SINK_CAPS command.

This was claude code assisted.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/include/nvif/if0012.h |  4 +++-
 drivers/gpu/drm/nouveau/include/nvif/outp.h   |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c   | 24 ++++++++++++++++++-
 drivers/gpu/drm/nouveau/nvif/outp.c           |  9 ++++---
 .../gpu/drm/nouveau/nvkm/engine/disp/outp.h   |  2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c  |  3 ++-
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 22 ++++++++++++++++-
 7 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gpu/dr=
m/nouveau/include/nvif/if0012.h
index 89cfac7ef3a54..dc0a5c372f511 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/if0012.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
@@ -172,7 +172,9 @@ union nvif_outp_hdmi_sink_caps_args {
 =09=09__u8 scdc;
 =09=09__u8 scdc_scrambling;
 =09=09__u8 scdc_low_rates;
-=09=09__u8 pad04[4];
+=09=09__u8 max_frl_rate;
+=09=09__u8 dsc_1p2;
+=09=09__u8 pad06[2];
 =09} v0;
 };
=20
diff --git a/drivers/gpu/drm/nouveau/include/nvif/outp.h b/drivers/gpu/drm/=
nouveau/include/nvif/outp.h
index 240e1f80ed539..55c02a34f381e 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/outp.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/outp.h
@@ -67,7 +67,7 @@ enum nvif_outp_detect_status {
 enum nvif_outp_detect_status nvif_outp_detect(struct nvif_outp *);
 int nvif_outp_edid_get(struct nvif_outp *, u8 **pedid);
 int nvif_outp_hdmi_sink_caps(struct nvif_outp *, bool scdc, bool scdc_scra=
mbling,
-=09=09=09     bool scdc_low_rates);
+=09=09=09     bool scdc_low_rates, int max_frl_rate, int dsc_1p2);
=20
 int nvif_outp_load_detect(struct nvif_outp *, u32 loadval);
 int nvif_outp_acquire_dac(struct nvif_outp *);
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/=
nouveau/nouveau_connector.c
index eae37d938f3bc..870b467d35e17 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -560,6 +560,23 @@ nouveau_connector_set_edid(struct nouveau_connector *n=
v_connector,
 =09}
 }
=20
+static int
+nouveau_hdmi_get_frl_rate(u8 max_frl_rate_per_lane, u8 max_lanes)
+{
+=09switch (max_lanes) {
+=09case 3:
+=09=09switch (max_frl_rate_per_lane) {
+=09=09case 3: return 1;
+=09=09case 6: return 2;
+=09=09}
+=09=09return 0;
+=09case 4:
+=09=09return max_frl_rate_per_lane / 2;
+=09default:
+=09=09return 0;
+=09}
+}
+
 static enum drm_connector_status
 nouveau_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -645,7 +662,12 @@ nouveau_connector_detect(struct drm_connector *connect=
or, bool force)
 =09=09=09nvif_outp_hdmi_sink_caps(&nv_encoder->outp,
 =09=09=09=09=09=09hdmi->scdc.supported,
 =09=09=09=09=09=09hdmi->scdc.scrambling.supported,
-=09=09=09=09=09=09hdmi->scdc.scrambling.low_rates);
+=09=09=09=09=09=09hdmi->scdc.scrambling.low_rates,
+=09=09=09=09=09=09nouveau_hdmi_get_frl_rate(hdmi->max_frl_rate_per_lane,
+=09=09=09=09=09=09=09=09=09 hdmi->max_lanes),
+=09=09=09=09=09=09hdmi->dsc_cap.v_1p2 ?
+=09=09=09=09=09=09=09nouveau_hdmi_get_frl_rate(hdmi->dsc_cap.max_frl_rate_=
per_lane,
+=09=09=09=09=09=09=09=09=09=09  hdmi->dsc_cap.max_lanes) : 0);
 =09=09}
=20
 =09=09if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_DP)
diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/=
nvif/outp.c
index d66f437587ff3..60479c884b2dc 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -463,7 +463,7 @@ nvif_outp_edid_get(struct nvif_outp *outp, u8 **pedid)
=20
 int
 nvif_outp_hdmi_sink_caps(struct nvif_outp *outp, bool scdc, bool scdc_scra=
mbling,
-=09=09=09 bool scdc_low_rates)
+=09=09=09 bool scdc_low_rates, int max_frl_rate, int dsc_1p2)
 {
 =09struct nvif_outp_hdmi_sink_caps_v0 args;
 =09int ret;
@@ -472,11 +472,14 @@ nvif_outp_hdmi_sink_caps(struct nvif_outp *outp, bool=
 scdc, bool scdc_scrambling
 =09args.scdc =3D scdc;
 =09args.scdc_scrambling =3D scdc_scrambling;
 =09args.scdc_low_rates =3D scdc_low_rates;
+=09args.max_frl_rate =3D max_frl_rate;
+=09args.dsc_1p2 =3D dsc_1p2;
=20
 =09ret =3D nvif_mthd(&outp->object, NVIF_OUTP_V0_HDMI_SINK_CAPS, &args, si=
zeof(args));
 =09NVIF_ERRON(ret, &outp->object,
-=09=09   "[HDMI_SINK_CAPS scdc:%d scrambling:%d low_rates:%d]",
-=09=09   args.scdc, args.scdc_scrambling, args.scdc_low_rates);
+=09=09   "[HDMI_SINK_CAPS scdc:%d scrambling:%d low_rates:%d max_frl_rate:=
%d dsc_1p2:%d]",
+=09=09   args.scdc, args.scdc_scrambling, args.scdc_low_rates,
+=09=09   args.max_frl_rate, args.dsc_1p2);
 =09return ret;
 }
=20
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h b/drivers/gpu/=
drm/nouveau/nvkm/engine/disp/outp.h
index fd54c17ba4d6d..17698b9ea7186 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
@@ -96,7 +96,7 @@ struct nvkm_outp_func {
 =09int (*detect)(struct nvkm_outp *);
 =09int (*edid_get)(struct nvkm_outp *, u8 *data, u16 *size);
 =09void (*hdmi_sink_caps)(struct nvkm_outp *, bool scdc, bool scrambling,
-=09=09=09       bool low_rates);
+=09=09=09       bool low_rates, int max_frl_rate, int dsc_1p2);
=20
 =09struct nvkm_ior *(*inherit)(struct nvkm_outp *);
 =09int (*acquire)(struct nvkm_outp *, bool hda);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/disp/uoutp.c
index 84381ba71ebaf..202fdc73f7cab 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -483,7 +483,8 @@ nvkm_uoutp_mthd_hdmi_sink_caps(struct nvkm_outp *outp, =
void *argv, u32 argc)
 =09=09return -EINVAL;
=20
 =09outp->func->hdmi_sink_caps(outp, args->v0.scdc, args->v0.scdc_scramblin=
g,
-=09=09=09=09   args->v0.scdc_low_rates);
+=09=09=09=09   args->v0.scdc_low_rates, args->v0.max_frl_rate,
+=09=09=09=09   args->v0.dsc_1p2);
 =09return 0;
 }
=20
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drive=
rs/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index fa20a0c633653..2fb7cc83852f9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1218,7 +1218,7 @@ r535_tmds_edid_get(struct nvkm_outp *outp, u8 *data, =
u16 *psize)
=20
 static void
 r535_outp_hdmi_sink_caps(struct nvkm_outp *outp, bool scdc, bool scramblin=
g,
-=09=09=09 bool low_rates)
+=09=09=09 bool low_rates, int max_frl_rate, int dsc_1p2)
 {
 =09struct nvkm_disp *disp =3D outp->disp;
 =09NV0073_CTRL_SPECIFIC_SET_HDMI_SINK_CAPS_PARAMS *ctrl;
@@ -1236,7 +1236,27 @@ r535_outp_hdmi_sink_caps(struct nvkm_outp *outp, boo=
l scdc, bool scrambling,
 =09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
GT_340MHZ_CLOCK_SUPPORTED, TRUE);
 =09if (low_rates)
 =09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
LTE_340MHZ_SCRAMBLING_SUPPORTED, TRUE);
+=09switch (max_frl_rate) {
+=09case 1: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_C=
APS, MAX_FRL_RATE_SUPPORTED, 3LANES_3G); break;
+=09case 2: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_C=
APS, MAX_FRL_RATE_SUPPORTED, 3LANES_6G); break;
+=09case 3: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_C=
APS, MAX_FRL_RATE_SUPPORTED, 4LANES_6G); break;
+=09case 4: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_C=
APS, MAX_FRL_RATE_SUPPORTED, 4LANES_8G); break;
+=09case 5: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_C=
APS, MAX_FRL_RATE_SUPPORTED, 4LANES_10G); break;
+=09case 6: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_C=
APS, MAX_FRL_RATE_SUPPORTED, 4LANES_12G); break;
+=09default: break;
+=09}
=20
+=09if (dsc_1p2) {
+=09=09ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SINK_CAPS, =
DSC_12_SUPPORTED, TRUE);
+=09=09switch (dsc_1p2) {
+=09=09case 1: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SIN=
K_CAPS, DSC_MAX_FRL_RATE_SUPPORTED, 3LANES_3G); break;
+=09=09case 2: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SIN=
K_CAPS, DSC_MAX_FRL_RATE_SUPPORTED, 3LANES_6G); break;
+=09=09case 3: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SIN=
K_CAPS, DSC_MAX_FRL_RATE_SUPPORTED, 4LANES_6G); break;
+=09=09case 4: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SIN=
K_CAPS, DSC_MAX_FRL_RATE_SUPPORTED, 4LANES_8G); break;
+=09=09case 5: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SIN=
K_CAPS, DSC_MAX_FRL_RATE_SUPPORTED, 4LANES_10G); break;
+=09=09case 6: ctrl->caps |=3D NVDEF(NV0073_CTRL_CMD_SPECIFIC, SET_HDMI_SIN=
K_CAPS, DSC_MAX_FRL_RATE_SUPPORTED, 4LANES_12G); break;
+=09=09}
+=09}
 =09WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
 }
=20
--=20
2.53.0

