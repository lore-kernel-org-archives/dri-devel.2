Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0647CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 22:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FFF210E37A;
	Mon, 18 May 2026 22:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DRMe8GJ9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A3410E09B;
 Mon, 18 May 2026 22:17:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EF4F343CAE;
 Mon, 18 May 2026 22:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32911C2BCB7;
 Mon, 18 May 2026 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779142643;
 bh=2byBZ7K9TFGi279fR4cU+LvkzjbAdmFJbPPXhJHi/og=;
 h=From:Date:Subject:To:Cc:From;
 b=DRMe8GJ9sRVOyuVrnmUVJ7QxRmRD1w9H4qhOiYdA4yCgrvGUT2+wnMMgrG+1jJRpz
 QVZbXcKKqelR3ILk8NZuvOkQQaH5ppyjXs9LUwYrPTzazw/AAxRRv65Qb00mn1uh13
 L8uZAeY18nqUnhO+UR/b179QmBGPXRFYkS9fR3cZNuWyFrjGq3WkFQs9G9o79fpbYm
 POWoXgsAfIBZaoQC+5ZoyjGEEUkgA3esSdC95Mcahtb0V2DA/5kbREtKBHopnWw++B
 6OTsH2g6WBIzxQUDiWQVxmit1WEOaABhp0MFwmD6RYiGUP2lJBhk78cP5cyV7UDeAh
 6TK/m0MxpmLdQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 18 May 2026 15:17:14 -0700
Subject: [PATCH] drm/msm: Restore second parameter name in purge() and evict()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-drm-msm-fix-c23-extensions-v1-1-0833559418c7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQrCMBCE4auUfXahSYwUryI+mHRat5Ao2VYKp
 Xc31ccfZr6NFEWgdG02KviIyivXMKeG4vORR7D0tcm29tJ603FfEidNPMjK0TrGOiMfL2UTog/
 mbOGdowq8C+rqh9/u/9YlTIjzIdK+fwE754OxfgAAAA==
X-Change-ID: 20260518-drm-msm-fix-c23-extensions-1bc5b142e533
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Daniel J Blueman <daniel@quora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746; i=nathan@kernel.org;
 h=from:subject:message-id; bh=2byBZ7K9TFGi279fR4cU+LvkzjbAdmFJbPPXhJHi/og=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnc/R9UrV9GMav3RZuWpCmsMiiZVRIY+H/fZ9XTS/9MT
 vhxZd3WjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRCZcY/ml9OSycliWrHVmz
 Zvbxu3eSTNWVD7Hu0tp0yMmnJfzbjdWMDLunm57Se1ptwLOwe8rj8u+7bCeb63boFNiHRokl1bv
 E8AEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
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

After commit 3392291fc509 ("drm/msm: Fix shrinker deadlock"), all
supported versions of clang warn (or error with CONFIG_WERROR=y):

  drivers/gpu/drm/msm/msm_gem_shrinker.c:105:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
    105 | purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
        |                                                          ^
  drivers/gpu/drm/msm/msm_gem_shrinker.c:117:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
    117 | evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
        |                                                          ^
  2 errors generated.

With older but supported versions of GCC, this is an unconditional hard error:

  drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'purge':
  drivers/gpu/drm/msm/msm_gem_shrinker.c:105:35: error: parameter name omitted
   purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
                                     ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'evict':
  drivers/gpu/drm/msm/msm_gem_shrinker.c:117:35: error: parameter name omitted
   evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
                                     ^~~~~~~~~~~~~~~~~~~~~~~

Restore the parameter name to clear up the warnings, renaming it
"unused" to make it clear it is only needed to satisfy the prototype of
drm_gem_lru_scan().

Cc: stable@vger.kernel.org
Fixes: 3392291fc509 ("drm/msm: Fix shrinker deadlock")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 6e39e4e578bb..8f118b5185a1 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -102,7 +102,7 @@ with_vm_locks(void (*fn)(struct drm_gem_object *obj),
 }
 
 static bool
-purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
+purge(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
 {
 	if (!is_purgeable(to_msm_bo(obj)))
 		return false;
@@ -114,7 +114,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
 }
 
 static bool
-evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
+evict(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
 {
 	if (is_unevictable(to_msm_bo(obj)))
 		return false;

---
base-commit: db339b6bc9f234b4883eb02946ea01d8d9faa11c
change-id: 20260518-drm-msm-fix-c23-extensions-1bc5b142e533

Best regards,
--  
Cheers,
Nathan

