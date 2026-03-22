Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A43FC72C4
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 14:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0911310E275;
	Sun, 22 Mar 2026 14:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="fznH3kr9";
	dkim-atps=neutral
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8383110E260
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1774189878; x=1774449078;
 bh=TZXkJdJ9ML2LISNVgOvnIHtIpHF+r1CvhpF/XXj5VkM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fznH3kr9VZB2EpPfs4eXrgsfIKUfoOgBLHHWte2GxA3jjakHFIoAIMNOUutg4ZpJd
 nBs/0QYDCUffBLXH4UDJw98Gr2tJqSKK/9Sbxy7+jheye68+SRtePWcEolK/wCNwuh
 ysUoSTUNGlrVWYr5nkOOoLIK3Jc3I29DNftnuwoSYQlUgPDr+Bwhg/yXAAzbgJcT6K
 wOSP24Gjhn2cZwBDCS9mvczqHwtSiubFiiuVhRMeThdcq/gIJkKTUovp0Rtz9lWFl7
 beeca7lrQBeOhd1EPbCzdWZIjmPGhxuMInwVu18E7VF/vVgoEYFESwAu7zopJm60rO
 p5ex2htrQoHWw==
Date: Sun, 22 Mar 2026 14:31:13 +0000
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Jonathan Marek <jonathan@marek.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH RFC] drm/msm/dpu: calculate data_width like downstream
Message-ID: <20260322-fix-data-width-calc-v1-1-128880f5a067@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: b2250f69380c06374677a845eaed5e451dbd539b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Derive INTF data_width from dce_bytes_per_line rather than
timing->width when DSC is enabled. Use DIV_ROUND_UP to avoid
rounding errors.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
This patch changes the data_width calculation to match downstream,
and avoids needing to change the divisor for timing->width to /24.

However I am not sure if this is a correct approach, but at least
with this I get the same values for data_width as downstream now:

data_width w/ no widebus
before: 288
after: 360

data_with w/ widebus
before: 144
after: 180

This was tested with the BOE BF068MWM-TD0 on the Nothing Phone (3a),
it would be greatly appreciated if someone from QCOM could weigh in
on if this is a correct approach.

Tested with kmscube and getting 120FPS, also note that this was
tested with a few other changes:

(drm/msm/dsi: fix hdisplay calculation when programming dsi registers)
(drm/msm/dsi: fix pclk rate calculation for bonded dsi)
(drm/msm/dsi: fix bits_per_pclk)
(drm/msm/dsi: fix hdisplay calculation for CMD mode panel)
---
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 23 +++++++++++++++++-=
----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  1 +
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers=
/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 0ba777bda253..ba810f26ea30 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -10,6 +10,7 @@
 #include "dpu_formats.h"
 #include "dpu_trace.h"
 #include "disp/msm_disp_snapshot.h"
+#include "msm_dsc_helper.h"
=20
 #include <drm/display/drm_dsc_helper.h>
 #include <drm/drm_managed.h>
@@ -136,6 +137,7 @@ static void drm_mode_to_intf_timing_params(
 =09=09timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) /
 =09=09=09=09(dsc->bits_per_component * 3);
 =09=09timing->xres =3D timing->width;
+=09=09timing->dce_bytes_per_line =3D msm_dsc_get_bytes_per_line(dsc);
 =09}
 }
=20
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/=
msm/disp/dpu1/dpu_hw_intf.c
index 7e620f590984..de6b5b0f70c4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -173,13 +173,26 @@ static void dpu_hw_intf_setup_timing_engine(struct dp=
u_hw_intf *intf,
 =09data_width =3D p->width;
=20
 =09/*
-=09 * If widebus is enabled, data is valid for only half the active window
-=09 * since the data rate is doubled in this mode. But for the compression
-=09 * mode in DP case, the p->width is already adjusted in
-=09 * drm_mode_to_intf_timing_params()
+=09 * If widebus is disabled:
+=09 * For uncompressed stream, the data is valid for the entire active
+=09 * window period.
+=09 * For compressed stream, data is valid for a shorter time period
+=09 * inside the active window depending on the compression ratio.
+=09 *
+=09 * If widebus is enabled:
+=09 * For uncompressed stream, data is valid for only half the active
+=09 * window, since the data rate is doubled in this mode.
+=09 * For compressed stream, data validity window needs to be adjusted for
+=09 * compression ratio and then further halved.
 =09 */
-=09if (p->wide_bus_en && !dp_intf)
+=09if (p->compression_en && !dp_intf) {
+=09=09if (p->wide_bus_en)
+=09=09=09data_width =3D DIV_ROUND_UP(p->dce_bytes_per_line, 6);
+=09=09else
+=09=09=09data_width =3D DIV_ROUND_UP(p->dce_bytes_per_line, 3);
+=09} else if (p->wide_bus_en && !dp_intf) {
 =09=09data_width =3D p->width >> 1;
+=09}
=20
 =09/* TODO: handle DSC+DP case, we only handle DSC+DSI case so far */
 =09if (p->compression_en && !dp_intf &&
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/=
msm/disp/dpu1/dpu_hw_intf.h
index f6ef2c21b66d..badd26305fc9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -35,6 +35,7 @@ struct dpu_hw_intf_timing_params {
=20
 =09bool wide_bus_en;
 =09bool compression_en;
+=09u32 dce_bytes_per_line;
 };
=20
 struct dpu_hw_intf_prog_fetch {

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260322-fix-data-width-calc-c44287df08b8

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


