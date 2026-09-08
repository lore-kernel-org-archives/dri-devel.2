Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF62C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C19710EC3E;
	Tue,  8 Sep 2026 14:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TGEg/6/h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0021510EC3E
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:47:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27F6E601F6;
 Tue,  8 Sep 2026 14:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787881F00AC4;
 Tue,  8 Sep 2026 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788878822;
 bh=ixnxrk5qpDTpigZLp3uD/lHCRkB/I4eyrWwO5tjXUoE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TGEg/6/hKkq5GmNaEm5Hv505exOKHYOz4knFU58bLQJMogL3hWt3VNYjAk1A6b7Wf
 FJ9kpKXiiF/Jii8+RS3X2N0nZdhFBfju4XOyRvuxTbi2RDyNzFgc5dAIu5eN6xwdoQ
 yodhxn6OdjoHfNiNVWanqylqHZPdweejZcauayhFyfAXo7pYJZT5mBRK7e4iFGcVcu
 +aSxSlEPVsQs0vEiwalKF1bTiioCzGAy8PxjCv8dUsS13VXCltyZ7F9/XJP8v4mQch
 N/SBtKIZat6kcG9+xUWs42CPWIhjYtdkhPmPO6LNp4RMly5/r4jo+8t41HI2q6IqQZ
 ZF3Y4nXb3bIQA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:46:32 +0200
Subject: [PATCH v4 01/41] drm/simple-kms: Remove unused reset_plane hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-no-more-plane-reset-v4-1-a31b3fcfc989@kernel.org>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wJGWE06mB1wVOA3lCSZFLHVGSt9/u+aQxc8RiX0FhaA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkL5M/aZpT+uyVS1rEz7ttS8yMH5jV8cg/fZfWOPzRVT
 rz24TqOjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRuYaMDSdtnyec9V6q82je
 7Ez906Gvs7buncI98XP21SnFG8pLLN+durOec6LKmkssoQxrb1qt/cdYX/gqhqsmKitsnbccu8G
 cW1/mTnK+MnXyblHBVdHiEkf9BQukHnQZnxZ98GPRmvimHKdnAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Commit 7f879284390c ("drm/simple-kms: Switch to atomic_create_state")
replaced drm_simple_kms_plane_reset() with
drm_simple_kms_plane_create_state(), removing the only user of the
reset_plane hook. However, the hook itself was left behind in struct
drm_simple_display_pipe_funcs.

Remove it.

Fixes: 7f879284390c ("drm/simple-kms: Switch to atomic_create_state")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_simple_kms_helper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index 4a4a840d84f1..2b31c25c57a9 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -40,11 +40,10 @@ struct drm_simple_display_pipe_funcs {
 	int (*enable_vblank)(struct drm_simple_display_pipe *pipe);
 	void (*disable_vblank)(struct drm_simple_display_pipe *pipe);
 	struct drm_crtc_state * (*duplicate_crtc_state)(struct drm_simple_display_pipe *pipe);
 	void (*destroy_crtc_state)(struct drm_simple_display_pipe *pipe,
 				   struct drm_crtc_state *crtc_state);
-	void (*reset_plane)(struct drm_simple_display_pipe *pipe);
 	struct drm_plane_state * (*create_plane_state)(struct drm_simple_display_pipe *pipe);
 	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe);
 	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
 				    struct drm_plane_state *plane_state);
 };

-- 
2.55.0

