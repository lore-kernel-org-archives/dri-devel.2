Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E501094463
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 07:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121B310E0B1;
	Sat, 21 Mar 2026 07:52:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="eknKBfQV";
	dkim-atps=neutral
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch
 [79.135.106.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86BE10E270
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1774079547; x=1774338747;
 bh=dD/BPKC5aT9eeNrRI4lDwbK6ytFidptagGuSLLMES4o=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=eknKBfQVua+/Zdc28IunDljWoOvc5nliyhT01KEmw4mQkJCHjuibI0mVWrtFPKj5U
 /OIFurwyox9ea50rPTjtymtK54ZAXDwp5CUQo13qR4+Rg8AA89rEegNDclGvAX89Uh
 qwfAOUMsPW9GJJvsBvd1scxBgZv/YvsTLSDu4uVvVRf6QqTi7IwFcHUylP74aSwnRN
 KHsF/iU6SALN5MbMAudKOg/KDW7aaObvYiEGZQI7UJfg6HDcW0spnyLKy/7RKoTe1O
 /jhWDUE7ufguxkDwXv3uk2lQ/dhpIdI3KabkPaWXk/oZcdA9EZHU9puwoWt3BBxWzE
 YTrzGp/BRdFaA==
Date: Sat, 21 Mar 2026 07:52:19 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 1/5] drm/mipi-dsi: add RGB101010 pixel format
Message-ID: <20260321-dsi-rgb101010-support-v4-1-eb28ecebbfe8@pm.me>
In-Reply-To: <20260321-dsi-rgb101010-support-v4-0-eb28ecebbfe8@pm.me>
References: <20260321-dsi-rgb101010-support-v4-0-eb28ecebbfe8@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 776e05140780a2062676c01f53cd0cd9a48b1f1e
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

Add MIPI_DSI_FMT_RGB101010 for 30 bit (10,10,10 RGB) pixel format,
corresponding to the packed 30 bit pixel stream defined in MIPI DSI
v1.3 Section 8.8.17.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 include/drm/drm_mipi_dsi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 3aba7b380c8d..a822e9e876af 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -140,6 +140,7 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(str=
uct device_node *node);
 #define MIPI_DSI_HS_PKT_END_ALIGNED=09BIT(12)
=20
 enum mipi_dsi_pixel_format {
+=09MIPI_DSI_FMT_RGB101010,
 =09MIPI_DSI_FMT_RGB888,
 =09MIPI_DSI_FMT_RGB666,
 =09MIPI_DSI_FMT_RGB666_PACKED,
@@ -235,6 +236,9 @@ extern const struct bus_type mipi_dsi_bus_type;
 static inline int mipi_dsi_pixel_format_to_bpp(enum mipi_dsi_pixel_format =
fmt)
 {
 =09switch (fmt) {
+=09case MIPI_DSI_FMT_RGB101010:
+=09=09return 30;
+
 =09case MIPI_DSI_FMT_RGB888:
 =09case MIPI_DSI_FMT_RGB666:
 =09=09return 24;

--=20
2.53.0


