Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05807C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 22:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3855610F9B2;
	Fri,  3 Jul 2026 22:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JvD9OLEG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C7010F9B2;
 Fri,  3 Jul 2026 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
 :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=alJyYzXPrjrW+fze2BEqVVAidt8/0vL+0wACtUJNxOg=; b=JvD9OLEG7RuXOzzmi63hrMgrXd
 mcn3I7r213toSRGSASXT6rjnafc9o+N6DkMWeYzeRsOCcRiSy3/jLDqxQk7DLwip36IRb0cszZqtT
 ++X0RY4c0MAaRIOqKtbyaDVG8d1d8DEGXkOHJeQaPyELhxxqsJwQuZwy748L0aa3sQY6ShFl2sGYq
 xk1qf0xxI3PdpRB541FfzL319566oxgtwl6QAFozXNrsnAPiopPcbZvPQHNwu07mzT+tlhfa7IxpQ
 Oc/JTSXkbmEHVE9MrJRS7ZzkU/HLFMvTS64aWBy1qLQqSlaS8gVbP8KZThBksn61Q+M2uPjTwvtvG
 8lEu4SOg==;
Received: from [187.43.145.169] (helo=[127.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfmTq-008fEP-Fb; Sat, 04 Jul 2026 00:35:30 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Fri, 03 Jul 2026 19:30:56 -0300
Subject: [PATCH] drm/amdgpu: update comment for amdgpu_ttm_bo_eviction_valuable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-amdgpu-ttm_mem_evict_first_comment-v1-1-ea160651e4f3@igalia.com>
X-B4-Tracking: v=1; b=H4sIACA4SGoC/yXNQQ6CMBCF4auQWdtkQNKqVzGmgTLgmEwh7WBMC
 Hen6vJbvP9tkCkxZbhVGyR6c+Y5FtSnCsKzixMZHoqhwcaiw7PpZJiW1aiKFxJfJkH9yCmrD7M
 IRTUXizXZ1l1bdFBCS6KRP7+T++PvvPYvCvotw74fXXNG9oYAAAA=
X-Change-ID: 20260703-amdgpu-ttm_mem_evict_first_comment-8601e6479407
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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

Since commit 3756310e9fe1 ("drm/ttm: Use the LRU walker for eviction"),
ttm_mem_evict_first has been removed and ttm_bo_evict_first does not
call eviction_valuable.

Remove the list of callers from the comment, since that is prone to be
outdated.

While at it, document the function parameters.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 16c060badaee..1e44be64f38d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1477,10 +1477,10 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
  * amdgpu_ttm_bo_eviction_valuable - Check to see if we can evict a buffer
  * object.
  *
- * Return true if eviction is sensible. Called by ttm_mem_evict_first() on
- * behalf of ttm_bo_mem_force_space() which tries to evict buffer objects until
- * it can find space for a new object and by ttm_bo_force_list_clean() which is
- * used to clean out a memory space.
+ * @bo: The buffer object to evict
+ * @place: the placement we need to make room for
+ *
+ * Return true if eviction is sensible.
  */
 static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 					    const struct ttm_place *place)

---
base-commit: 903f8773ee96c5dc5fb9aec65227f39fd3e7a1dc
change-id: 20260703-amdgpu-ttm_mem_evict_first_comment-8601e6479407

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

