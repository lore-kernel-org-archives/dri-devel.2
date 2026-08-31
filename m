Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708D3C624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9C410E868;
	Mon, 31 Aug 2026 13:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L3actPbe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D5D810E86B;
 Mon, 31 Aug 2026 13:39:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22D85602BE;
 Mon, 31 Aug 2026 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C471F00A3E;
 Mon, 31 Aug 2026 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183547;
 bh=8+edGIJKj0yaz/K1D2wKNEO+Y4qQ65VpvuBinHaH44U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L3actPbe9oQC0Nyii5NbXj8sxTw735P5tHRUE8JG0YyZuKbDk6+l/GZFc794CpoA5
 /YRbFfmTYogcayATZYLmzLOnpp1S8E/obZAG3TzwDqu6T8+fB05vTpKBI7s/8+BDMJ
 9ljPi80fsRBNmSb7ZSKB1D1p6KUbl3icAKllMRfWaGJDlwwWfZvrmHPCEWZif7iJio
 f234lphhBiBR4VQPEKGSbL/U3aWH8w+34wggwBZvmAyycJCeapPle/3+xmTnYtOv22
 IE1Sl2dMiuASRhAeyqrStrTb+HqLQkYwRi2lCpiIdxiNbeDEX7B/EHCuZHZbKKIj3R
 wm8nrJXVAqvfw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ivan Lipski <ivan.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 sunpeng.li@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] drm/amd/display: Initialize dsc_caps to 0
Date: Mon, 31 Aug 2026 09:23:10 -0400
Message-ID: <20260831133314.4125787-162-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Ivan Lipski <ivan.lipski@amd.com>

[ Upstream commit d18ecfee5187e3b2dbff7e67dda8b2f54ff5231c ]

[Why&How]
If we don't do that we make DSC decisions based on random
inputs, which might result in disallowing DSC when the
monitor and HW support it.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background searches finished and matched the earlier analysis:

- **Fix not in this tree:** `git log` for `Initialize dsc_caps` /
  `dsc_caps = {0}` returned nothing — the patch isn’t in v6.18.44 yet,
  but the bug is still there (`struct dsc_dec_dpcd_caps dsc_caps;` at
  line 7168).
- **b4 dig:** No result, since the commit isn’t present locally to look
  up.

**Verdict stands: YES** for backport to this 6.18.y tree — one-line
zero-init fix for uninitialized DSC caps used during mode setup on
AMDGPU.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4f53297786623..8445b13549c17 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7165,7 +7165,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	int preferred_refresh = 0;
 	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
 #if defined(CONFIG_DRM_AMD_DC_FP)
-	struct dsc_dec_dpcd_caps dsc_caps;
+	struct dsc_dec_dpcd_caps dsc_caps = {0};
 #endif
 	struct dc_link *link = NULL;
 	struct dc_sink *sink = NULL;
-- 
2.53.0

