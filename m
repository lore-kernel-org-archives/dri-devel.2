Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6F606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=HPewYBtj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFB510E9A8;
	Sat, 21 Nov 2026 13:13:04 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07E8B10E9A8
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:12:56 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266775; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:ei7rzkFTuYZBoUsHXU8+vq1qbeav
 WPI9BLLfndi69EDUwXK1faDctXiCJ3QVGxqmI6l4GnryWtTZCZV7TmrmnAXt+mG5ZdR7l00EfhG
 zbPgQK5FHQ5DkuaoNStVm3sng87NdXKl5ZUyXy55SUoOkorsiniBjAMMnHLn6uPXUP17uZ1oy+d
 iQZYwMG1UP4x+4xnkueQfcmjWjRyFX0CVS1wfvxz7MKJBk1p0MFF/J642AuvEgDWWTPQ6Wq3qI0
 gkRg4gIa/vjvrYF7SzW20CBLwgt87eAt6Ido14oayDV+A2blK6mUe5Jx66C5f3bRzLihvT7ywAk
 OpBpLXPvDWzzKg==;
Message-Instance: m=1; h=sha256: IA6M6AnHru730nHGjSV/QZRcsRk1v7nDf96U7EmkVxU=:
 3gmFuk88r+TEMOo8Hu1Cv0B3AjyicGxM4X1ssCna1XA=, sha512:
 TGevX46hVLwJeQGsle1fSBgLFPo5sH9Zfmr76W2KFi833ajVLk8XdrY8ShuzmSW216wHRxp50d0p1xeyYl2E+A==:
 vbgXe+QBDUQMVI7Czb8VkP2s039/KPEsBHsieT/ewzKaZ/zJ/0eMxHHARBtjmoLPG+o2UR42Vncfe/bLckcjJw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266775; x=1795871575; i=jan.claussen10@web.de;
 bh=Oz9NN2xjKXVzfs+md6+ZxDIzOOIlE3ZGdRvIbf5aLT0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HPewYBtj9CTlH3SSNeQmXf0hRFUESpK/06+5gktkVmfeu1X7CP06qNsnoDQEKKXq
 1MAKTz2KuYWq86MfgTFFXaSF8tPbEeHCwzObLBkdHCaH6mSn4JnFpjGFFDu0U/iDy
 juIdHB0QOGYkDnR3spuvE7DP41Vot1Lqs5sCPZiLzAXtTuHsfoF0jGFcemqFIoO3x
 CSidkgnbtgsFcDMges+/o3dZ18PApy4mQeo4wxhiYE661KlDarlxKMRssqgGGKoHt
 LlGQYkLnTr3Aa+bYeZQDlWjn9H2/Xk+g7yBxu8llIcfXNZEfJNqW6QMXxQQ1ov1uz
 tRRhVXcOOiEqPntANg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpTxo-1yKKL51gGy-00ZbSj; Sat, 21
 Nov 2026 14:12:55 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] drm/rockchip: vop2: Select the CSC matrix from the DRM
 colorimetry
Date: Sat, 21 Nov 2026 14:11:00 +0100
Message-ID: <20261121131126.3358-7-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121131126.3358-1-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TkQNOeUgg1S8riaX/jMnRFOz6q+KwYfJKUFzc5FMrSay4M4DOSP
 c/fOesUtWhycEcUIwEgYv97Z+Vpah97kVCITyeuSqj0v5RIEFFyMMSK/DN7aFGdY6DuDJdf
 iiop5794f2f/NCJtReJw2/93Nyq4GvYx/u+q239Rn2W3diJpWeYDA4f1cqK9bj1KQCi3p99
 LRKv3CJ8rYJMGcalYsclg==
UI-OutboundReport: notjunk:1;M01:P0:NGMpoMjqEHg=;A1fO59lL8QcUvTvkE2dMR6K+ynh
 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
 Dw==
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The color_space field in struct rockchip_crtc_state holds V4L2 colorspace
values, a leftover from the vendor kernel. The DP and DSI2 encoders only
ever set V4L2_COLORSPACE_DEFAULT, so VOP2 always ends up with BT.709.
An HDMI encoder that wants to honour the connector colorspace property
would have to translate DRM colorimetry into V4L2 values, only for VOP2
to map them back to a CSC matrix.

Store the connector's enum drm_colorspace in the CRTC state instead and
pick the CSC matrix from DRM_MODE_COLORIMETRY_* directly. Since
DRM_MODE_COLORIMETRY_DEFAULT is 0, the zero-initialised state keeps the
current BT.709 behaviour and the encoder assignments can go.

No functional change.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |  3 --
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |  2 -
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 37 +++++++------------
 4 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi2-rockchip.c
index 6db88665060d..87bab11d6f8a 100644
=2D-- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
@@ -23,8 +23,6 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
=20
-#include <uapi/linux/videodev2.h>
-
 #include "rockchip_drm_drv.h"
=20
 #define PSEC_PER_SEC			1000000000000LL
@@ -268,7 +266,6 @@ dw_mipi_dsi2_encoder_atomic_check(struct drm_encoder *=
encoder,
=20
 	s->output_type =3D DRM_MODE_CONNECTOR_DSI;
 	s->bus_flags =3D info->bus_flags;
-	s->color_space =3D V4L2_COLORSPACE_DEFAULT;
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/r=
ockchip/dw_dp-rockchip.c
index b23efb153c9e..412796435af6 100644
=2D-- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -10,7 +10,6 @@
 #include <linux/media-bus-format.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/videodev2.h>
=20
 #include <drm/bridge/dw_dp.h>
 #include <drm/drm_atomic_helper.h>
@@ -62,7 +61,6 @@ static int dw_dp_encoder_atomic_check(struct drm_encoder=
 *encoder,
 	s->output_type =3D DRM_MODE_CONNECTOR_DisplayPort;
 	s->bus_format =3D bus_format;
 	s->bus_flags =3D di->bus_flags;
-	s->color_space =3D V4L2_COLORSPACE_DEFAULT;
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm=
/rockchip/rockchip_drm_drv.h
index 4705dc6b8bd7..9c0d744ed95b 100644
=2D-- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -56,7 +56,7 @@ struct rockchip_crtc_state {
 	bool yuv_overlay;
 	u32 bus_format;
 	u32 bus_flags;
-	int color_space;
+	enum drm_colorspace colorspace;
 };
 #define to_rockchip_crtc_state(s) \
 		container_of(s, struct rockchip_crtc_state, base)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/dr=
m/rockchip/rockchip_drm_vop2.c
index bfb384142568..41035bf27491 100644
=2D-- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -33,8 +33,6 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
=20
-#include <uapi/linux/videodev2.h>
-
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_vop2.h"
 #include "rockchip_rgb.h"
@@ -647,20 +645,13 @@ static void vop2_setup_scale(struct vop2 *vop2, cons=
t struct vop2_win *win,
 	}
 }
=20
-static int vop2_convert_csc_mode(int csc_mode)
+static enum vop_csc_format
+vop2_convert_csc_mode(enum drm_colorspace colorspace)
 {
-	switch (csc_mode) {
-	case V4L2_COLORSPACE_SMPTE170M:
-	case V4L2_COLORSPACE_470_SYSTEM_M:
-	case V4L2_COLORSPACE_470_SYSTEM_BG:
-		return CSC_BT601L;
-	case V4L2_COLORSPACE_REC709:
-	case V4L2_COLORSPACE_SMPTE240M:
-	case V4L2_COLORSPACE_DEFAULT:
-		return CSC_BT709L;
-	case V4L2_COLORSPACE_JPEG:
-		return CSC_BT601F;
-	case V4L2_COLORSPACE_BT2020:
+	switch (colorspace) {
+	case DRM_MODE_COLORIMETRY_BT2020_RGB:
+	case DRM_MODE_COLORIMETRY_BT2020_YCC:
+	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
 		return CSC_BT2020L;
 	default:
 		return CSC_BT709L;
@@ -707,8 +698,8 @@ static void vop2_setup_csc_mode(struct vop2_video_port=
 *vp,
 	struct rockchip_crtc_state *vcstate =3D to_rockchip_crtc_state(vp->crtc.=
state);
 	int is_input_yuv =3D pstate->fb->format->is_yuv;
 	int is_output_yuv =3D is_yuv_output(vcstate->bus_format);
-	int input_csc =3D V4L2_COLORSPACE_DEFAULT;
-	int output_csc =3D vcstate->color_space;
+	enum drm_colorspace input_csc =3D DRM_MODE_COLORIMETRY_DEFAULT;
+	enum drm_colorspace output_csc =3D vcstate->colorspace;
 	bool r2y_en, y2r_en;
 	int csc_mode;
=20
@@ -797,10 +788,10 @@ vop2_rgb2yuv_get_matrix(enum vop_csc_format csc)
 }
=20
 /* Convert an RGB (16bpc) to YUV444 (16bpc). */
-static void vop2_rgb16_to_yuv16(int v4l2_cs, u16 r, u16 g, u16 b,
-				u16 *y, u16 *cb, u16 *cr)
+static void vop2_rgb16_to_yuv16(enum drm_colorspace colorspace,
+				u16 r, u16 g, u16 b, u16 *y, u16 *cb, u16 *cr)
 {
-	enum vop_csc_format csc =3D vop2_convert_csc_mode(v4l2_cs);
+	enum vop_csc_format csc =3D vop2_convert_csc_mode(colorspace);
 	const struct rgb2yuv_matrix *m =3D vop2_rgb2yuv_get_matrix(csc);
 	s64 rs =3D r, gs =3D g, bs =3D b;
 	s64 ys, cbs, crs;
@@ -1652,7 +1643,7 @@ static void vop2_bgcolor_setup(struct drm_crtc *crtc=
, bool force,
 	u32 val;
=20
 	if (!force && old_crtc_state->background_color =3D=3D bgcolor &&
-	    old_vcstate->color_space =3D=3D new_vcstate->color_space)
+	    old_vcstate->colorspace =3D=3D new_vcstate->colorspace)
 		return;
=20
 	/*
@@ -1660,7 +1651,7 @@ static void vop2_bgcolor_setup(struct drm_crtc *crtc=
, bool force,
 	 * format when operating in YUV overlay mode, and RGB otherwise.
 	 */
 	if (new_vcstate->yuv_overlay) {
-		vop2_rgb16_to_yuv16(new_vcstate->color_space,
+		vop2_rgb16_to_yuv16(new_vcstate->colorspace,
 				    DRM_ARGB64_GETR(bgcolor),
 				    DRM_ARGB64_GETG(bgcolor),
 				    DRM_ARGB64_GETB(bgcolor),
@@ -2140,7 +2131,7 @@ static int vop2_crtc_state_dump(struct drm_crtc *crt=
c, struct seq_file *s)
 	seq_printf(s, "\tbus_format[%x]: %s\n", vcstate->bus_format,
 		   drm_get_bus_format_name(vcstate->bus_format));
 	seq_printf(s, "\toutput_mode[%x]", vcstate->output_mode);
-	seq_printf(s, " color_space[%d]\n", vcstate->color_space);
+	seq_printf(s, " colorspace[%d]\n", vcstate->colorspace);
 	seq_printf(s, "\tbackground color (10bpc): r=3D0x%x g=3D0x%x b=3D0x%x\n"=
,
 		   DRM_ARGB64_GETR_BPCS(cstate->background_color, 10),
 		   DRM_ARGB64_GETG_BPCS(cstate->background_color, 10),
=2D-=20
2.56.0

