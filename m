Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CA606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=Eu9SThFI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D59710E9FC;
	Sun,  1 Nov 2026 11:58:18 +0000 (UTC)
Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8478F10E1E8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:52:24 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=mmKeCbjE3ZYA5V9Lf0Tb2oYgIWNEyo0oHto3fq9oodU=; 
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793364742; v=1; x=1793969542;
 b=Eu9SThFI0vbLgW1BjP/SVNqN1MR3fWC0/ZzPGdQWIpjo/zcHumq7dUvB5zagfXCuKLegBMdE
 su3XXo8AM6sGoiZpLxBpurEQ5zRms6zLE3H5ZlHPlP+71b5bHILcdqsm+GDmmMCX5URC+IDZiAY
 1RTaOEZtCpAmUOsQumbcYuxxgRVFAXkHG3bcTpxAG6e8TpXHWMuRTJ6BB2tW4U3aH8KobfTu9KQ
 UM/xa5MQhrubXwFEvp/IZHdCZT1pmRbsy7SFzG76AKhqlDd81VRpEXXHbzSDi3/oKXoWnNex5RU
 Ju/RxnANmcFXhBtc+s5uHjrLHfs6OruD2pk44PaZVTGaA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 1a8150d0f62198a2;
 Fri, 30 Oct 2026 12:51:20 +0000
X-Mizu-Trace-ID: 1a8150d0f62198a2
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 20:51:16 +0800
From: Weijie Yuan <kernel@wyuan.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Tomasz =?iso-8859-1?Q?Pakula?= <tomasz.pakula.oficjalny@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/exec: Fix the drm_exec_retry parameter documentation
Message-ID: <554e4d14309801a497408a33dc696519597ed941.1793364084.git.wy@wyuan.org>
References: <4b9b0f01c86a84b4666a1ba38a085c7b84e9a585.1793364084.git.wy@wyuan.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9b0f01c86a84b4666a1ba38a085c7b84e9a585.1793364084.git.wy@wyuan.org>
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When running 'make htmldocs', Sphinx complains:

WARNING: ./include/drm/drm_exec.h:162 function parameter '_exec' not described in 'drm_exec_retry'
WARNING: ./include/drm/drm_exec.h:162 Excess function parameter 'exec' description in 'drm_exec_retry' (did you mean one of: '_exec')
WARNING: ./include/drm/drm_exec.h:162 function parameter '_exec' not described in 'drm_exec_retry'
WARNING: ./include/drm/drm_exec.h:162 Excess function parameter 'exec' description in 'drm_exec_retry' (did you mean one of: '_exec')

If duplicate, please ignore.

Thanks.

-- >8 --
From: Weijie Yuan <wy@wyuan.org>

drm_exec_retry() takes _exec, but its kernel-doc describes exec.
This produces missing and excess parameter description warnings.

Use the macro parameter's actual name in the comment.

Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer")
Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 include/drm/drm_exec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index c92d69a2c793..5a2a8438f094 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -153,7 +153,7 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
 
 /**
  * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
- * @exec: drm_exec object
+ * @_exec: drm_exec object
  *
  * Unconditionally retry the loop to lock all objects. For consistency,
  * the exec object needs to be newly initialized.
-- 
2.56.0.438.g30c3f27cb8

