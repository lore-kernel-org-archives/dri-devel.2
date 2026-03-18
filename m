Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C748FCD0D9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39EB10E73F;
	Wed, 18 Mar 2026 08:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="Y2LADrkC";
	dkim-atps=neutral
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E5F10E2EB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773819182; x=1774078382;
 bh=Wy7pmybLcN2EzDYfooh+oiFyI7YbhcMFju9H5ENgtVI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Y2LADrkCf8lllWlZ9vKGIPTzW8ZRniVnXdoqByJztTOKg4HhBQBqZhPuhVv1Io7cq
 IPBF7C53yR1e2YC/g/eOFWjlJKkDTOryK1T4bHI3ApXPrCGtfD3T4gUAOTJ4wATmQH
 +piLr85kuSZY5rL0erFA487BND7Du9XQYsC0EBgMSMXKzLfmYL6ZT00BxREGODjh1/
 4B8LHcPjmw17IlniRdJbPjDpNSp831gO23mu1kt/nUi2TLyjNys2ScUkLm4cdny23w
 5C/93nUpWMjOHvn1IiGiju74r8Op7SIpj/rv5ryDre+kg15+GFgs0IKa67fq5BceHC
 ayu+E3Kn/R/OA==
Date: Wed, 18 Mar 2026 07:32:58 +0000
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
Subject: [PATCH 1/2] drm/mipi-dsi: add flag for sending all DSC slices in one
 packet
Message-ID: <20260318-dsi-dsc-slice-per-pkt-v1-1-1bd66b7f9e0c@pm.me>
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
References: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: e025ce9a6b601b1cd23397e38e9cee7c0f03c5db
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

The MIPI DSI v1.3 spec defines two modes for transporting compressed
pixel data: one slice per packet or multiple slice widths in a single
packet (Section 8.8.24 Figure 40).

Add a MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag that panel drivers can
set to indicate that all DSC slices for a line should be packed into a
single packet. When unset should default to 1 slice per packet.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 include/drm/drm_mipi_dsi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 3aba7b380c8d..d3ad8c5d3ebe 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -138,6 +138,8 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(str=
uct device_node *node);
 #define MIPI_DSI_MODE_LPM=09=09BIT(11)
 /* transmit data ending at the same time for all lanes within one hsync */
 #define MIPI_DSI_HS_PKT_END_ALIGNED=09BIT(12)
+/* pack all DSC slices for a line into a single packet */
+#define MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT=09BIT(13)
=20
 enum mipi_dsi_pixel_format {
 =09MIPI_DSI_FMT_RGB888,

--=20
2.53.0


