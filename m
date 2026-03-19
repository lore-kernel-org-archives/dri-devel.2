Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FD8FB5EAA
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 04:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1770110E875;
	Thu, 19 Mar 2026 04:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="bRiJ6h6G";
	dkim-atps=neutral
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5605A10E875
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 04:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773892810; x=1774152010;
 bh=FIhqYnvDqEqh4gLmHXirrSB58x2I5CZdQyjrMqWKARE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bRiJ6h6GjafcuLXpdRNN3yMXVTX20R+K1o6gxuUj94OzzguM7/st66UTjCRNLI6xz
 yqgSDgQjUQZFHd/mUj78CJCaPTYNJBUBAT4mm7QmXGBGYL5hk6Eq9Vq46oIDtfHfi+
 tRZ8Jsj942bc99Mpl/ItCyUU79AtsWqokxOyfBXOd/aeS4ZuV1Dk+UjDjnnp4z+lqp
 orPkXRyFXZ3ECYTptRCX5DsdVg9Ybfqi1UBshyzFwEsanDbDUEvf+rTChXYvjN9/s4
 cWDp9RhxDf/Zn2E1Q2CORzbUoTKb0CXx9rs5/djmOoMmeCaa13cIcZq48aGtZ8HYnI
 A13F6Mc0xCyRw==
Date: Thu, 19 Mar 2026 04:00:05 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH v2 2/3] drm/msm/dsi: Add support for RGB101010 pixel format
Message-ID: <20260318-dsi-rgb101010-support-v2-2-698b7612eaeb@pm.me>
In-Reply-To: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 333f197c982a3645d0cf94f99cb8a44c643d3a4c
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

Add video and command mode destination format mappings for RGB101010,
and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits to accommodate
the new format value.

Make sure this is guarded behind MSM_DSI_6G_VER >=3D V2.1.0 as anything
older does not support this.

Required for 10 bit panels such as the BOE BF068MWM-TD0.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 8 ++++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h             | 1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c            | 9 +++++++++
 drivers/gpu/drm/msm/registers/display/dsi.xml | 5 ++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/ds=
i_cfg.c
index bd3c51c350e7..6a7ea2183a3b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -133,6 +133,7 @@ static const struct msm_dsi_config msm8998_dsi_cfg =3D =
{
 =09.io_start =3D {
 =09=09{ 0xc994000, 0xc996000 },
 =09},
+=09.has_rgb30 =3D true,
 };
=20
 static const char * const dsi_sdm660_bus_clk_names[] =3D {
@@ -152,6 +153,7 @@ static const struct msm_dsi_config sdm660_dsi_cfg =3D {
 =09.io_start =3D {
 =09=09{ 0xc994000, 0xc996000 },
 =09},
+=09.has_rgb30 =3D true,
 };
=20
 static const char * const dsi_v2_4_clk_names[] =3D {
@@ -173,6 +175,7 @@ static const struct msm_dsi_config sdm845_dsi_cfg =3D {
 =09=09{ 0xae94000, 0xae96000 }, /* SDM845 / SDM670 */
 =09=09{ 0x5e94000 }, /* QCM2290 / SM6115 / SM6125 / SM6375 */
 =09},
+=09.has_rgb30 =3D true,
 };
=20
 static const struct regulator_bulk_data sm8550_dsi_regulators[] =3D {
@@ -188,6 +191,7 @@ static const struct msm_dsi_config sm8550_dsi_cfg =3D {
 =09.io_start =3D {
 =09=09{ 0xae94000, 0xae96000 },
 =09},
+=09.has_rgb30 =3D true,
 };
=20
 static const struct regulator_bulk_data sm8650_dsi_regulators[] =3D {
@@ -203,6 +207,7 @@ static const struct msm_dsi_config sm8650_dsi_cfg =3D {
 =09.io_start =3D {
 =09=09{ 0xae94000, 0xae96000 },
 =09},
+=09.has_rgb30 =3D true,
 };
=20
 static const struct msm_dsi_config kaanapali_dsi_cfg =3D {
@@ -214,6 +219,7 @@ static const struct msm_dsi_config kaanapali_dsi_cfg =
=3D {
 =09.io_start =3D {
 =09=09{ 0x9ac0000, 0x9ac3000 },
 =09},
+=09.has_rgb30 =3D true,
 };
=20
 static const struct regulator_bulk_data sc7280_dsi_regulators[] =3D {
@@ -230,6 +236,7 @@ static const struct msm_dsi_config sc7280_dsi_cfg =3D {
 =09.io_start =3D {
 =09=09{ 0xae94000, 0xae96000 },
 =09},
+=09.has_rgb30 =3D true,
 };
=20
 static const struct regulator_bulk_data sa8775p_dsi_regulators[] =3D {
@@ -246,6 +253,7 @@ static const struct msm_dsi_config sa8775p_dsi_cfg =3D =
{
 =09.io_start =3D {
 =09=09{ 0xae94000, 0xae96000 },
 =09},
+=09.has_rgb30 =3D true,
 };
=20
 static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops =3D {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/ds=
i_cfg.h
index 5dc812028bd5..15cb9b46fadf 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -48,6 +48,7 @@ struct msm_dsi_config {
 =09const char * const *bus_clk_names;
 =09const int num_bus_clks;
 =09const resource_size_t io_start[VARIANTS_MAX][DSI_MAX];
+=09bool has_rgb30;
 };
=20
 struct msm_dsi_host_cfg_ops {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/d=
si_host.c
index db6da99375a1..34fd0dc5f7c7 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -757,6 +757,7 @@ static inline enum dsi_vid_dst_format
 dsi_get_vid_fmt(const enum mipi_dsi_pixel_format mipi_fmt)
 {
 =09switch (mipi_fmt) {
+=09case MIPI_DSI_FMT_RGB101010:=09return VID_DST_FORMAT_RGB101010;
 =09case MIPI_DSI_FMT_RGB888:=09return VID_DST_FORMAT_RGB888;
 =09case MIPI_DSI_FMT_RGB666:=09return VID_DST_FORMAT_RGB666_LOOSE;
 =09case MIPI_DSI_FMT_RGB666_PACKED:=09return VID_DST_FORMAT_RGB666;
@@ -769,6 +770,7 @@ static inline enum dsi_cmd_dst_format
 dsi_get_cmd_fmt(const enum mipi_dsi_pixel_format mipi_fmt)
 {
 =09switch (mipi_fmt) {
+=09case MIPI_DSI_FMT_RGB101010:=09return CMD_DST_FORMAT_RGB101010;
 =09case MIPI_DSI_FMT_RGB888:=09return CMD_DST_FORMAT_RGB888;
 =09case MIPI_DSI_FMT_RGB666_PACKED:
 =09case MIPI_DSI_FMT_RGB666:=09return CMD_DST_FORMAT_RGB666;
@@ -1698,6 +1700,13 @@ static int dsi_host_attach(struct mipi_dsi_host *hos=
t,
 =09if (dsi->lanes > msm_host->num_data_lanes)
 =09=09return -EINVAL;
=20
+=09if (dsi->format =3D=3D MIPI_DSI_FMT_RGB101010 &&
+=09    !msm_host->cfg_hnd->cfg->has_rgb30) {
+=09=09DRM_DEV_ERROR(&msm_host->pdev->dev,
+=09=09=09      "RGB101010 not supported on this DSI controller\n");
+=09=09return -EINVAL;
+=09}
+
 =09msm_host->channel =3D dsi->channel;
 =09msm_host->lanes =3D dsi->lanes;
 =09msm_host->format =3D dsi->format;
diff --git a/drivers/gpu/drm/msm/registers/display/dsi.xml b/drivers/gpu/dr=
m/msm/registers/display/dsi.xml
index c7a7b633d747..e40125f75175 100644
--- a/drivers/gpu/drm/msm/registers/display/dsi.xml
+++ b/drivers/gpu/drm/msm/registers/display/dsi.xml
@@ -15,6 +15,7 @@ xsi:schemaLocation=3D"https://gitlab.freedesktop.org/free=
dreno/ rules-fd.xsd">
 =09=09<value name=3D"VID_DST_FORMAT_RGB666" value=3D"1"/>
 =09=09<value name=3D"VID_DST_FORMAT_RGB666_LOOSE" value=3D"2"/>
 =09=09<value name=3D"VID_DST_FORMAT_RGB888" value=3D"3"/>
+=09=09<value name=3D"VID_DST_FORMAT_RGB101010" value=3D"4"/>
 =09</enum>
 =09<enum name=3D"dsi_rgb_swap">
 =09=09<value name=3D"SWAP_RGB" value=3D"0"/>
@@ -39,6 +40,7 @@ xsi:schemaLocation=3D"https://gitlab.freedesktop.org/free=
dreno/ rules-fd.xsd">
 =09=09<value name=3D"CMD_DST_FORMAT_RGB565" value=3D"6"/>
 =09=09<value name=3D"CMD_DST_FORMAT_RGB666" value=3D"7"/>
 =09=09<value name=3D"CMD_DST_FORMAT_RGB888" value=3D"8"/>
+=09=09<value name=3D"CMD_DST_FORMAT_RGB101010" value=3D"9"/>
 =09</enum>
 =09<enum name=3D"dsi_lane_swap">
 =09=09<value name=3D"LANE_SWAP_0123" value=3D"0"/>
@@ -142,7 +144,8 @@ xsi:schemaLocation=3D"https://gitlab.freedesktop.org/fr=
eedreno/ rules-fd.xsd">
 =09</reg32>
 =09<reg32 offset=3D"0x0000c" name=3D"VID_CFG0">
 =09=09<bitfield name=3D"VIRT_CHANNEL" low=3D"0" high=3D"1" type=3D"uint"/>=
  <!-- always zero? -->
-=09=09<bitfield name=3D"DST_FORMAT" low=3D"4" high=3D"5" type=3D"dsi_vid_d=
st_format"/>
+=09=09<!-- high was 5 before DSI 6G 2.1.0 -->
+=09=09<bitfield name=3D"DST_FORMAT" low=3D"4" high=3D"6" type=3D"dsi_vid_d=
st_format"/>
 =09=09<bitfield name=3D"TRAFFIC_MODE" low=3D"8" high=3D"9" type=3D"dsi_tra=
ffic_mode"/>
 =09=09<bitfield name=3D"BLLP_POWER_STOP" pos=3D"12" type=3D"boolean"/>
 =09=09<bitfield name=3D"EOF_BLLP_POWER_STOP" pos=3D"15" type=3D"boolean"/>

--=20
2.53.0


