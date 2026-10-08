Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0D5CA6015
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5A310FB9B;
	Thu,  8 Oct 2026 20:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ml6Mi1Bl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2416A10FB8B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 20:57:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C238E43E45;
 Thu,  8 Oct 2026 20:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B51FC2BCFC;
 Thu,  8 Oct 2026 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791493051;
 bh=F5UjN9HXlLEjjYyQ+yoqVz6zc2suZB5cBhuDsOppt48=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Ml6Mi1BlBy14h+jQKsBXtvdnYK4H2KorldGZd/qaEDNC4h2P3C15fKVBaQ3Nvb1R/
 SAeEMRppFBlItjSVOsSULlaKIeimZv6JqH/Ks5etkLO4FLgqiStDMAD7E+6lj8/rIO
 IqAikgBjIN//LBKwkItvL4zEqTgPgDEVRFTV0Z9Pwit+MAcpUnU824y0YUWRICAbxJ
 wEVDRoJ3kSzKWPp1jK0oqYETG43gD4I+VNQNR2m86rRzyW6+11/Ec4OD2Fi3Xwcdw4
 N2+8UMxTswJm5pmjqpvYP4abIxe1ldGzmyC55d3xywAE4tFYreyLA/rp0ZdQTdKCV2
 RsAB1a46u6ILw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF4DCA6017;
 Thu,  8 Oct 2026 20:57:31 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 08 Oct 2026 15:57:22 -0500
Subject: [PATCH 2/2] drm/tegra: Support YVU420
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tegra-drm-yvu420-v1-2-dc1c443c00f3@gmail.com>
References: <20261008-tegra-drm-yvu420-v1-0-dc1c443c00f3@gmail.com>
In-Reply-To: <20261008-tegra-drm-yvu420-v1-0-dc1c443c00f3@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791493050; l=1951;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=5JMtXM0jjpFsOI4uENHL4iJMvTDIKKwSfTKJuRBvkas=;
 b=TCZBOmlW0u8sls/GRhoH1qHVzzRBs9csHtQoTz/FBhEQbMD+Xe3OJoc5g2oGg4aBMywcrOCGR
 UloP488ja6ICbxYmlkhDz/4gn6x77seo4fYvUnTEVH9tgtA7QQqZUgl
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Aaron Kling <webgeek1234@gmail.com>

This format is used by AOSP for video playback among other things.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    | 2 ++
 drivers/gpu/drm/tegra/hub.c   | 1 +
 drivers/gpu/drm/tegra/plane.c | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 76d3841a17b8b..57146c41c0972 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1312,6 +1312,7 @@ static const u32 tegra114_overlay_formats[] = {
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YUV420,
 	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU420,
 	/* semi-planar formats */
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV21,
@@ -1352,6 +1353,7 @@ static const u32 tegra124_overlay_formats[] = {
 	DRM_FORMAT_YUV420, /* YU12 */
 	DRM_FORMAT_YUV422, /* YU16 */
 	DRM_FORMAT_YUV444, /* YU24 */
+	DRM_FORMAT_YVU420, /* YV12 */
 	/* semi-planar formats */
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV21,
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 6427155ac4fdf..f176badfd922b 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -51,6 +51,7 @@ static const u32 tegra_shared_plane_formats[] = {
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YUV420,
 	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU420,
 };
 
 static const u64 tegra_shared_plane_modifiers[] = {
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index f4feec62ac023..3802afff569ea 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -432,6 +432,14 @@ int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_uv)
 		*format = WIN_COLOR_DEPTH_YCbCr420P;
 		break;
 
+	case DRM_FORMAT_YVU420:
+		if (!swap_uv)
+			return -EINVAL;
+
+		*format = WIN_COLOR_DEPTH_YCbCr420P;
+		*swap_uv = true;
+		break;
+
 	case DRM_FORMAT_YUV422:
 		*format = WIN_COLOR_DEPTH_YCbCr422P;
 		break;

-- 
2.54.0


