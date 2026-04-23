Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB98FAD3E7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 00:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06CF10EAC3;
	Thu, 23 Apr 2026 00:52:21 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9632910E2EA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:52:19 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-TrbcG8IWMAaKZNJ9IVPFkg-1; Wed,
 22 Apr 2026 20:46:10 -0400
X-MC-Unique: TrbcG8IWMAaKZNJ9IVPFkg-1
X-Mimecast-MFC-AGG-ID: TrbcG8IWMAaKZNJ9IVPFkg_1776905169
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB03E1800464; Thu, 23 Apr 2026 00:46:09 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B09D630001A1; Thu, 23 Apr 2026 00:46:07 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Subject: [PATCH 4/4] nouveau: wire up HDMI FRL in the display frontend
Date: Thu, 23 Apr 2026 10:42:16 +1000
Message-ID: <20260423004552.3289884-5-airlied@gmail.com>
In-Reply-To: <20260423004552.3289884-1-airlied@gmail.com>
References: <20260423004552.3289884-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TO1VCBftgsWbhvcEusHdiDVc3dB4t4DpI4rwJVz0wvs_1776905169
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Integrate HDMI FRL (Fixed Rate Link) support into the nouveau display
frontend for Turing+ GPUs with GSP-RM firmware:

- Select FRL protocol and trigger link training during SOR enable for
  modes at >=3D 594 MHz on FRL-capable sinks
- Pick minimum sufficient FRL rate rather than always using maximum
- Report FRL bandwidth caps in TMDS link bandwidth for mode validation
- Set flush_disable for FRL outputs (link training happens post-flush)
- Skip SCDC TMDS config when using FRL signaling
- Register FRL retrain events on HDMI connectors and handle retrains
- Clear FRL state on encoder disable
- Move shared FRL rate table and max rate helper to nouveau_encoder.h

This was claude code assisted.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 36 +++++++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.c | 60 +++++++++++++++------
 drivers/gpu/drm/nouveau/nouveau_connector.h |  1 +
 drivers/gpu/drm/nouveau/nouveau_display.c   | 10 +++-
 drivers/gpu/drm/nouveau/nouveau_encoder.h   | 31 +++++++++++
 5 files changed, 117 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouv=
eau/dispnv50/disp.c
index 6c3a8712d38ab..ed71ad6d38c27 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -60,6 +60,7 @@
 #include <nvhw/class/cl887d.h>
 #include <nvhw/class/cl907d.h>
 #include <nvhw/class/cl917d.h>
+#include <nvhw/class/clca7d.h>
=20
 #include "nouveau_drv.h"
 #include "nouveau_dma.h"
@@ -774,6 +775,20 @@ nv50_audio_enable(struct drm_encoder *encoder, struct =
nouveau_crtc *nv_crtc,
 /*************************************************************************=
*****
  * HDMI
  *************************************************************************=
****/
+static int
+nv50_hdmi_pick_frl_rate(struct drm_hdmi_info *hdmi, unsigned clock)
+{
+=09int max_rate =3D nouveau_hdmi_get_max_frl_rate(hdmi->max_frl_rate_per_l=
ane,
+=09=09=09=09=09=09     hdmi->max_lanes);
+=09int rate;
+
+=09for (rate =3D 1; rate <=3D max_rate; rate++) {
+=09=09if (nouveau_hdmi_frl_max_clock[rate] >=3D clock)
+=09=09=09return rate;
+=09}
+=09return max_rate;
+}
+
 static void
 nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc=
,
 =09=09 struct nouveau_connector *nv_connector, struct drm_atomic_state *st=
ate,
@@ -794,7 +809,8 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct no=
uveau_crtc *nv_crtc,
 =09max_ac_packet -=3D 18; /* constant from tegra */
 =09max_ac_packet /=3D 32;
=20
-=09if (nv_encoder->i2c && hdmi->scdc.scrambling.supported) {
+=09if (nv_encoder->i2c && hdmi->scdc.scrambling.supported &&
+=09    !(mode->clock >=3D 594000 && hdmi->max_frl_rate_per_lane)) {
 =09=09const bool high_tmds_clock_ratio =3D mode->clock > 340000;
 =09=09u8 scdc;
=20
@@ -848,6 +864,11 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct n=
ouveau_crtc *nv_crtc,
 =09nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, args=
, size);
=20
 =09nv_encoder->hdmi.enabled =3D true;
+
+=09if (mode->clock >=3D 594000 && hdmi->max_frl_rate_per_lane)
+=09=09nv_encoder->hdmi.frl_rate =3D nv50_hdmi_pick_frl_rate(hdmi, mode->cl=
ock);
+=09else
+=09=09nv_encoder->hdmi.frl_rate =3D 0;
 }
=20
 /*************************************************************************=
*****
@@ -1585,6 +1606,7 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, =
struct drm_atomic_state *st
 =09=09nvif_outp_hdmi(&nv_encoder->outp, head->base.index,
 =09=09=09       false, 0, 0, 0, false, false, false);
 =09=09nv_encoder->hdmi.enabled =3D false;
+=09=09nv_encoder->hdmi.frl_rate =3D 0;
 =09}
=20
 =09if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_DP)
@@ -1780,7 +1802,9 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, s=
truct drm_atomic_state *sta
 =09=09    nv_connector->base.display_info.is_hdmi)
 =09=09=09nv50_hdmi_enable(encoder, nv_crtc, nv_connector, state, mode, hda=
);
=20
-=09=09if (nv_encoder->outp.or.link & 1) {
+=09=09if (nv_encoder->hdmi.frl_rate) {
+=09=09=09proto =3D NVCA7D_SOR_SET_CONTROL_PROTOCOL_HDMI_FRL;
+=09=09} else if (nv_encoder->outp.or.link & 1) {
 =09=09=09proto =3D NV507D_SOR_SET_CONTROL_PROTOCOL_SINGLE_TMDS_A;
 =09=09=09/* Only enable dual-link if:
 =09=09=09 *  - Need to (i.e. rate > 165MHz)
@@ -1852,6 +1876,10 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, =
struct drm_atomic_state *sta
 =09=09head->func->display_id(head, BIT(nv_encoder->outp.id));
=20
 =09nv_encoder->update(nv_encoder, nv_crtc->index, asyh, proto, depth);
+
+=09if (nv_encoder->hdmi.frl_rate)
+=09=09nvif_outp_hdmi_frl(&nv_encoder->outp, nv_crtc->index,
+=09=09=09=09   nv_encoder->hdmi.frl_rate);
 }
=20
 static const struct drm_encoder_helper_funcs
@@ -2525,7 +2553,9 @@ nv50_disp_outp_atomic_check_clr(struct nv50_atom *ato=
m,
 =09=09=09return PTR_ERR(outp);
=20
 =09=09if (outp->encoder->encoder_type =3D=3D DRM_MODE_ENCODER_DPMST ||
-=09=09    nouveau_encoder(outp->encoder)->dcb->type =3D=3D DCB_OUTPUT_DP)
+=09=09    nouveau_encoder(outp->encoder)->dcb->type =3D=3D DCB_OUTPUT_DP |=
|
+=09=09    nouveau_encoder(outp->encoder)->hdmi.frl_rate ||
+=09=09    old_connector_state->connector->display_info.hdmi.max_frl_rate_p=
er_lane)
 =09=09=09atom->flush_disable =3D true;
 =09=09outp->clr.ctrl =3D true;
 =09=09atom->lock_core =3D true;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/=
nouveau/nouveau_connector.c
index 870b467d35e17..8a9d20fd041ab 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -396,6 +396,7 @@ static void
 nouveau_connector_destroy(struct drm_connector *connector)
 {
 =09struct nouveau_connector *nv_connector =3D nouveau_connector(connector)=
;
+=09nvif_event_dtor(&nv_connector->frl);
 =09nvif_event_dtor(&nv_connector->irq);
 =09nvif_event_dtor(&nv_connector->hpd);
 =09kfree(nv_connector->edid);
@@ -560,21 +561,23 @@ nouveau_connector_set_edid(struct nouveau_connector *=
nv_connector,
 =09}
 }
=20
-static int
-nouveau_hdmi_get_frl_rate(u8 max_frl_rate_per_lane, u8 max_lanes)
+bool
+nouveau_hdmi_frl_retrain(struct nouveau_connector *nv_connector)
 {
-=09switch (max_lanes) {
-=09case 3:
-=09=09switch (max_frl_rate_per_lane) {
-=09=09case 3: return 1;
-=09=09case 6: return 2;
-=09=09}
-=09=09return 0;
-=09case 4:
-=09=09return max_frl_rate_per_lane / 2;
-=09default:
-=09=09return 0;
-=09}
+=09struct nouveau_encoder *nv_encoder;
+=09struct nouveau_crtc *nv_crtc;
+
+=09nv_encoder =3D find_encoder(&nv_connector->base, DCB_OUTPUT_TMDS);
+=09if (!nv_encoder || !nv_encoder->hdmi.frl_rate)
+=09=09return true;
+
+=09if (!nv_encoder->crtc)
+=09=09return true;
+
+=09nv_crtc =3D nouveau_crtc(nv_encoder->crtc);
+=09nvif_outp_hdmi_frl(&nv_encoder->outp, nv_crtc->index,
+=09=09=09   nv_encoder->hdmi.frl_rate);
+=09return true;
 }
=20
 static enum drm_connector_status
@@ -663,10 +666,10 @@ nouveau_connector_detect(struct drm_connector *connec=
tor, bool force)
 =09=09=09=09=09=09hdmi->scdc.supported,
 =09=09=09=09=09=09hdmi->scdc.scrambling.supported,
 =09=09=09=09=09=09hdmi->scdc.scrambling.low_rates,
-=09=09=09=09=09=09nouveau_hdmi_get_frl_rate(hdmi->max_frl_rate_per_lane,
+=09=09=09=09=09=09nouveau_hdmi_get_max_frl_rate(hdmi->max_frl_rate_per_lan=
e,
 =09=09=09=09=09=09=09=09=09 hdmi->max_lanes),
 =09=09=09=09=09=09hdmi->dsc_cap.v_1p2 ?
-=09=09=09=09=09=09=09nouveau_hdmi_get_frl_rate(hdmi->dsc_cap.max_frl_rate_=
per_lane,
+=09=09=09=09=09=09=09nouveau_hdmi_get_max_frl_rate(hdmi->dsc_cap.max_frl_r=
ate_per_lane,
 =09=09=09=09=09=09=09=09=09=09  hdmi->dsc_cap.max_lanes) : 0);
 =09=09}
=20
@@ -1085,6 +1088,12 @@ get_tmds_link_bandwidth(struct drm_connector *connec=
tor)
 =09=09=09const int max_tmds_clock =3D
 =09=09=09=09info->hdmi.scdc.scrambling.supported ?
 =09=09=09=09594000 : 340000;
+=09=09=09int frl_rate =3D nouveau_hdmi_get_max_frl_rate(
+=09=09=09=09info->hdmi.max_frl_rate_per_lane,
+=09=09=09=09info->hdmi.max_lanes);
+=09=09=09if (drm->client.device.info.family >=3D NV_DEVICE_INFO_V0_TURING =
&&
+=09=09=09    frl_rate > 0)
+=09=09=09=09return nouveau_hdmi_frl_max_clock[frl_rate];
 =09=09=09return info->max_tmds_clock ?
 =09=09=09=09min(info->max_tmds_clock, max_tmds_clock) :
 =09=09=09=09max_tmds_clock;
@@ -1244,6 +1253,16 @@ nouveau_connector_irq(struct nvif_event *event, void=
 *repv, u32 repc)
 =09return NVIF_EVENT_KEEP;
 }
=20
+static int
+nouveau_connector_frl(struct nvif_event *event, void *repv, u32 repc)
+{
+=09struct nouveau_connector *nv_connector =3D container_of(event, typeof(*=
nv_connector), frl);
+=09struct nvif_conn_event_v0 *rep =3D repv;
+
+=09nouveau_connector_hpd(nv_connector, rep->types);
+=09return NVIF_EVENT_KEEP;
+}
+
 static int
 nouveau_connector_hotplug(struct nvif_event *event, void *repv, u32 repc)
 {
@@ -1476,6 +1495,15 @@ nouveau_connector_create(struct drm_device *dev, int=
 index)
 =09=09=09=09nvif_conn_dtor(&nv_connector->conn);
 =09=09=09=09goto drm_conn_err;
 =09=09=09}
+=09=09} else if (type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
+=09=09=09ret =3D nvif_conn_event_ctor(&nv_connector->conn, "kmsFrlRetrain"=
,
+=09=09=09=09=09=09   nouveau_connector_frl, NVIF_CONN_EVENT_V0_FRL,
+=09=09=09=09=09=09   &nv_connector->frl);
+=09=09=09if (ret) {
+=09=09=09=09nvif_event_dtor(&nv_connector->hpd);
+=09=09=09=09nvif_conn_dtor(&nv_connector->conn);
+=09=09=09=09goto drm_conn_err;
+=09=09=09}
 =09=09}
 =09}
=20
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/=
nouveau/nouveau_connector.h
index 0608cabed058e..d522dbc5678ef 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -126,6 +126,7 @@ struct nouveau_connector {
 =09u64 hpd_pending;
 =09struct nvif_event hpd;
 =09struct nvif_event irq;
+=09struct nvif_event frl;
 =09struct work_struct irq_work;
=20
 =09struct drm_dp_aux aux;
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/no=
uveau/nouveau_display.c
index d71dcfc6ee66b..96e66d04f75e2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -456,17 +456,23 @@ nouveau_display_hpd_work(struct work_struct *work)
 =09=09nv_connector->hpd_pending =3D 0;
 =09=09spin_unlock_irq(&drm->hpd_lock);
=20
-=09=09drm_dbg_kms(dev, "[CONNECTOR:%d:%s] plug:%d unplug:%d irq:%d\n",
+=09=09drm_dbg_kms(dev, "[CONNECTOR:%d:%s] plug:%d unplug:%d irq:%d frl:%d\=
n",
 =09=09=09    connector->base.id, connector->name,
 =09=09=09    !!(bits & NVIF_CONN_EVENT_V0_PLUG),
 =09=09=09    !!(bits & NVIF_CONN_EVENT_V0_UNPLUG),
-=09=09=09    !!(bits & NVIF_CONN_EVENT_V0_IRQ));
+=09=09=09    !!(bits & NVIF_CONN_EVENT_V0_IRQ),
+=09=09=09    !!(bits & NVIF_CONN_EVENT_V0_FRL));
=20
 =09=09if (bits & NVIF_CONN_EVENT_V0_IRQ) {
 =09=09=09if (nouveau_dp_link_check(nv_connector))
 =09=09=09=09continue;
 =09=09}
=20
+=09=09if (bits & NVIF_CONN_EVENT_V0_FRL) {
+=09=09=09if (nouveau_hdmi_frl_retrain(nv_connector))
+=09=09=09=09continue;
+=09=09}
+
 =09=09connector->status =3D drm_helper_probe_detect(connector, NULL, false=
);
 =09=09if (old_epoch_counter =3D=3D connector->epoch_counter)
 =09=09=09continue;
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/no=
uveau/nouveau_encoder.h
index dce8e5d9d4964..7eefbf4a09205 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -72,6 +72,7 @@ struct nouveau_encoder {
 =09struct {
 =09=09struct {
 =09=09=09bool enabled;
+=09=09=09int frl_rate;
 =09=09} hdmi;
=20
 =09=09struct {
@@ -164,6 +165,36 @@ enum drm_mode_status nv50_dp_mode_valid(struct nouveau=
_encoder *,
 =09=09=09=09=09const struct drm_display_mode *,
 =09=09=09=09=09unsigned *clock);
=20
+/* nouveau_connector.c */
+bool nouveau_hdmi_frl_retrain(struct nouveau_connector *);
+
+/* Max pixel clock (kHz) at 8bpc for each FRL rate, after 16b/18b encoding=
. */
+static const unsigned nouveau_hdmi_frl_max_clock[] __maybe_unused =3D {
+=09[1] =3D 333333,   /* 3L=C3=973G */
+=09[2] =3D 666666,   /* 3L=C3=976G */
+=09[3] =3D 888888,   /* 4L=C3=976G */
+=09[4] =3D 1185185,  /* 4L=C3=978G */
+=09[5] =3D 1481481,  /* 4L=C3=9710G */
+=09[6] =3D 1777777,  /* 4L=C3=9712G */
+};
+
+static inline int
+nouveau_hdmi_get_max_frl_rate(u8 max_frl_rate_per_lane, u8 max_lanes)
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
 struct nouveau_connector *
 nv50_outp_get_new_connector(struct drm_atomic_state *state, struct nouveau=
_encoder *outp);
 struct nouveau_connector *
--=20
2.53.0

