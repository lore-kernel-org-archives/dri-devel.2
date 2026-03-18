Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBBA1077612
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C059E10E7B6;
	Wed, 18 Mar 2026 19:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="TgCZIB3F";
	dkim-atps=neutral
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch
 [185.70.43.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E96710E791
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773826872; x=1774086072;
 bh=pp3XZb0ALhTP7LyMnVusUzUvvZEvNzyavN4uuB4T2gk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=TgCZIB3FYcuhgLiyqxCnROt5SGZHW2ZV8qQddZd18qOJVzdSwxjMWNA3n2L33r3Kr
 gRvXQdzzzSw4M/Tysrbp9S8j9Eq4IV8u9jHpC6cL/rREJOpEdV642dSzOvVye7eBOD
 DG5QFLsXJuj7BDQcJG+Moc79u/mep3yUVrtqilAeWbz8G9jRxiE+qxwT2wbujAVU4S
 1dfn72rfiokGqOGcBoTrzF7IgfP7ffv5k7ln4QK622S82ucCuf7KCBXmiB04AO+h0N
 viSgKpaDH0AZm5ARdTgw0JgD4d0/irXbwWnZx6ng6P0wfFahBG7VHreGa5rL6lFBNx
 /w5UneVSx1d0Q==
Date: Wed, 18 Mar 2026 09:41:09 +0000
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
Subject: [PATCH 3/3] drm/msm/dpu: fix video mode DSC INTF timing width for non
 8 bit panels
Message-ID: <20260318-dsi-rgb101010-support-v1-3-6021eb79e796@pm.me>
In-Reply-To: <20260318-dsi-rgb101010-support-v1-0-6021eb79e796@pm.me>
References: <20260318-dsi-rgb101010-support-v1-0-6021eb79e796@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 00294e59a403e87f8b55690d224023b92ed5dd9a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

Using bits_per_component * 3 as the divisor for the compressed INTF
timing width produces constant FIFO errors for panels such as the BOE
BF068MWM-TD0 which is a 10 bit panel.

The downstream driver calculates the compressed timing width by
dividing the total compressed bytes per line by 3 which does not depend
on bits_per_component. Switch the divisor to 24 to match downstream.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers=
/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 0ba777bda253..9b046a0e77aa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -122,19 +122,21 @@ static void drm_mode_to_intf_timing_params(
 =09}
=20
 =09/*
-=09 * for DSI, if compression is enabled, then divide the horizonal active
-=09 * timing parameters by compression ratio. bits of 3 components(R/G/B)
-=09 * is compressed into bits of 1 pixel.
+=09 * For DSI, if DSC is enabled, use a fixed divisor of 24 rather than
+=09 * bits_per_component * 3 when calculating the compressed timing width.
+=09 *
+=09 * This matches the downstream driver and is required for panels with
+=09 * bits_per_component !=3D 8.
 =09 */
 =09if (phys_enc->hw_intf->cap->type !=3D INTF_DP && timing->compression_en=
) {
 =09=09struct drm_dsc_config *dsc =3D
 =09=09       dpu_encoder_get_dsc_config(phys_enc->parent);
+
 =09=09/*
 =09=09 * TODO: replace drm_dsc_get_bpp_int with logic to handle
 =09=09 * fractional part if there is fraction
 =09=09 */
-=09=09timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) /
-=09=09=09=09(dsc->bits_per_component * 3);
+=09=09timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) / 24;
 =09=09timing->xres =3D timing->width;
 =09}
 }

--=20
2.53.0


