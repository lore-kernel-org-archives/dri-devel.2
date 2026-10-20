Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF2C606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewgb/7Of
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C08810F379;
	Tue, 20 Oct 2026 08:10:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F5710F37A
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:10:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F34141AED;
 Tue, 20 Oct 2026 08:10:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792483813;
 b=iXCkFy7bGBZe2MlC1LMszJtLU+ytnNReTgSETk6mMxPKr7aJUOXg5+j7vEitdy20yT47
 Q/nyijYB6pUBEZ1MdCEY5nKAf4fOR5HCQgUErl62DjMyf8S1u1dCHu5zBTZ1A6FxtP3IU
 /q2bTOOGTBGhKbWJuviJsVL5Guo9PV7gcg75HLCctm/ltbwPzwITnvYIskYiEip7JYu31
 Rf6SrM0PrzNU0+SGewlZUcE2marEyNE31FVEPmmULK0j8A509RPUWe91KI8Sm0BSXplWq
 0AQWFbi/sdSN+TUNOwlBRSZJhnTyfVeuzduMzFF+Hh7m7N6O9pvoaxKSxbMUgzAtAZg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483813;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=T6wuasYP+5ayvHMAL7nKThPJDLo93/+fiRJi56xfeoc=;
 b=nrUSKcOQ4zxNjpwqo36z4TdMTP0TtZZtpyGFEs3Vomo3ZFjmzM8aSN+xoQCk7J5yLojl
 vDW34fXNSiUinok7GL/AuIzgIjge8c9N8hL0xVsIvu8sA5r3z80qXdIPsMTreqGrz77zu
 y0q5ERZ9f5sLgIRRcF7xlC4iF2MYrp4CNLHCyLaHU82g0l14SsbKH4anmHkukLCtKQa1t
 3Dc8UijnjpYCk8KJusKTgvll8sfdVYgXMKavzxlyTy+swOqRq4hBBBN2FmjTj4xfJYACm
 piHBV03/62I6ZVhZPFHoFgYLYR0eTq7CH+anfndXbzpEgz6JIOwD6aXfio2LHl38cGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A30FA1F000D3;
 Tue, 20 Oct 2026 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792483813;
 bh=T6wuasYP+5ayvHMAL7nKThPJDLo93/+fiRJi56xfeoc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ewgb/7Ofmvzu0+gGHaqWqeTNIvP80zYaq59JmodAQoxk9DVzs2O6sUDnkJoX5a2Rk
 LJL9fiE5K33GQ+oRTuy+WLOsmmIT4maomAUWrNgYJQ5Co7gyaj/ulxOW8FSfQiZ+MY
 jEp7etxjjR8outkcSdDVnehEtqrtvokfirt34cwEfwRIkh2XdSHzn3whzUQT9xCwXt
 DrRyJ++YudWxh+JVokY/CY8LEAAaKW2YaMA0toA7vMlQmIpaVtbzQC3wfbMcGjo1nE
 JVZ1xHXQFcfTnpKvbvW8PoYfiMtpovKExuzFndq5lZ3+Q1zFS7eJhmbipggv8Bj6r7
 Tzd/RRyPTSW5A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E235E430BB;
 Tue, 20 Oct 2026 08:10:11 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 20 Oct 2026 03:10:08 -0500
Subject: [PATCH v3 2/2] drm/tegra: Support YVU formats
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-tegra-drm-yvu420-v3-2-7f19a834ba98@gmail.com>
References: <20261020-tegra-drm-yvu420-v3-0-7f19a834ba98@gmail.com>
In-Reply-To: <20261020-tegra-drm-yvu420-v3-0-7f19a834ba98@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483811; l=2859;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=GKwERrdCz3L4Vqnj4OsOVIE3z6vkoOXkX6XTWWhZRfE=;
 b=H/dRF2XpiGrSuf6M/oSZsqBE4Hd0Ig5GpEdOOqJta54JvKAerLEtHG2YEmohmKtIEZG7fCjgG
 FXwyjGuCMYrD3tjModifI+47oCoIQilGdsCzVvOm9+VAPwnNrtQfbUx
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: webgeek1234@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aaron Kling <webgeek1234@gmail.com>

YVU420 is used by AOSP for video playback among other things. YVU422 and
YVU444 can be trivially supported in the same manner, so add them as
well.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    |  7 +++++++
 drivers/gpu/drm/tegra/hub.c   |  2 ++
 drivers/gpu/drm/tegra/plane.c | 24 ++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 39c2e920d76a6..be913f2609077 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1282,6 +1282,8 @@ static const u32 tegra20_overlay_formats[] = {
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YUV420,
 	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
 };
 
 static const u32 tegra114_overlay_formats[] = {
@@ -1309,6 +1311,8 @@ static const u32 tegra114_overlay_formats[] = {
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YUV420,
 	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
 	/* semi-planar formats */
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV21,
@@ -1349,6 +1353,9 @@ static const u32 tegra124_overlay_formats[] = {
 	DRM_FORMAT_YUV420, /* YU12 */
 	DRM_FORMAT_YUV422, /* YU16 */
 	DRM_FORMAT_YUV444, /* YU24 */
+	DRM_FORMAT_YVU420, /* YV12 */
+	DRM_FORMAT_YVU422, /* YV16 */
+	DRM_FORMAT_YVU444, /* YV24 */
 	/* semi-planar formats */
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV21,
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 5a86f8260f136..ac4542e54d7dd 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -51,6 +51,8 @@ static const u32 tegra_shared_plane_formats[] = {
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YUV420,
 	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
 };
 
 static const u64 tegra_shared_plane_modifiers[] = {
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 757bc552809fe..79ef5fc1b3678 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -433,14 +433,38 @@ int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_uv)
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
 
+	case DRM_FORMAT_YVU422:
+		if (!swap_uv)
+			return -EINVAL;
+
+		*format = WIN_COLOR_DEPTH_YCbCr422P;
+		*swap_uv = true;
+		break;
+
 	case DRM_FORMAT_YUV444:
 		*format = WIN_COLOR_DEPTH_YCbCr444P;
 		break;
 
+	case DRM_FORMAT_YVU444:
+		if (!swap_uv)
+			return -EINVAL;
+
+		*format = WIN_COLOR_DEPTH_YCbCr444P;
+		*swap_uv = true;
+		break;
+
 	case DRM_FORMAT_NV12:
 		*format = WIN_COLOR_DEPTH_YCbCr420SP;
 		break;

-- 
2.54.0


