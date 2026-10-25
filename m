Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45905606A31F
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4OrdcG9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DABF10E25E;
	Sun, 25 Oct 2026 22:34:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE98510E25E
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:34:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E575D600AA;
 Sun, 25 Oct 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792967673;
 b=SHewheyRtZfuxriB3dDwwINejOql8VII8VlA1cyANGzovt9mkSUIVIbKH6pRtF7vS+gB
 R76pP8a1fpPfETi7QiHO7c6Hxrh53ZdD+zh/mcrt1YJtDtpM6IbqmlPH6lQ9CIcvhlXKy
 72qrSyBhFdAvgSkk7f4EOwo0um70cKBV5ekC+s4AAVWi+j6aoatdjmXPQ5W68snVqfeLQ
 KxHcglmkabOy9iH1hFaDSqrl3F5nqROYFs6fYhgTkIVR4s8/yY7MjtgRh+kDcPsP1VSYD
 WtJ+3XROU4ysg0tJXdcuWe/ULgtWD0WXP2taFZyDSvCB2f/hVTqQXsULpLUAxTsdqHQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792967673;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=iWpP69MVDriPAkNSdmiVW0K+EO0TbrPe1mDsjukcdE0=;
 b=bd/qHYRn0WaeRW3dSujmGUr7D5yrkoLsWCBP25a12GdwC1yCteS9zUcTJeZ2JHT88lSK
 9OnPOPeN7AMHs09HXYFzT5TDduQaunLbVFnz621D6tewWbwT66ZNFytPNjxWflnwXerk5
 VEhKdYJPf4rLcyexIUZdyqqHggLyUbESuQ8ANnOkKZmhLru/hpXJnB0vbBW5E8l/jjjxL
 zxEGlTsr0tKaMYA/WL3w5L6ZJXfr1Kx5Mwu7X5a7zwP9LaDB5Zk1cjXyPzhq9cFnkVj+Y
 vAR53mNjGyM5ioQgdBsJ8lcvLahBwyOta7z5LoHfltxx7vkq8qOI/X2SrBgzLm70Qyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1C3C01F01829;
 Sun, 25 Oct 2026 22:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792967673;
 bh=iWpP69MVDriPAkNSdmiVW0K+EO0TbrPe1mDsjukcdE0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=P4OrdcG9c7bSJQ0PjRt2HrN8fB22+bR2e1rTvF86A6tt5wqT6RhpPd76AVwnn6/Z8
 0IJFjbIUng2QNhvU7U2SU+pLKEVVHJwzHl1zrXRDVWy6QZHRYpCcu/6prZZDI+xgBJ
 XnTD029oqawBKL+4d6t2VBcyis01bASEKtf+u5c32YfPBzguvNb5vjW2TVKzwL6fFh
 KOH5E78lRfK8X6kXh1bD/SGZFexPwv2Lr35TN2vQO0rBty3640JZZjtWSXfyL1jjBD
 OJfM2Ra9NtJEoHoP3rEOi/qJqqbJUru1sdlGnHGryZtTwTHnEwpAfJ1tFg26y9Ssa0
 8HzXzLA9rFFsQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8B0FE44AFA;
 Sun, 25 Oct 2026 22:34:32 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 25 Oct 2026 17:34:30 -0500
Subject: [PATCH v4 2/2] drm/tegra: Support YVU formats
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261025-tegra-drm-yvu420-v4-2-30b3bb0d0752@gmail.com>
References: <20261025-tegra-drm-yvu420-v4-0-30b3bb0d0752@gmail.com>
In-Reply-To: <20261025-tegra-drm-yvu420-v4-0-30b3bb0d0752@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792967672; l=2852;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=8hGc03SYXizHw33ULcwZEIrKQWKQjAVy5h5uRAdlKuo=;
 b=1D6RRONTaL2oH0hlIrVl+UBp4c9XG3985eezteFQ4tHkYjh2vAO8O+zne7rWV0vOR/nGd+92O
 OZmtRuge0pXDhOs68QBNrmG3SUErtE6s9OoSfiaNvR7UCSmW34tooOg
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
YVU444 can be trivially supported in the same manner, so add them where
supported as well.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    |  7 +++++++
 drivers/gpu/drm/tegra/hub.c   |  1 +
 drivers/gpu/drm/tegra/plane.c | 24 ++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

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
index 5a86f8260f136..46756c749e674 100644
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
2.56.0


