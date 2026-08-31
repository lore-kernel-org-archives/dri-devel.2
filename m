Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2E6C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962AD10E1CB;
	Mon, 31 Aug 2026 03:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="yr/kjK3Z";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C672310E1CB
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 03:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=r3ivgzgQ3H3Cv28ue3PZBn1qMGJDA9aPlpOpK/M16fI=; b=yr/kjK3ZM9uKYRDOvWbX2PlFPN
 D6rcfSiGsvmyznCKHGzBbtQxOw1gwJaJLrwt09LDcPD485sFZj3A1sEemg5ZT4bvHScDXWnzsiKgJ
 oPJOxlRkL1ewllhKJCXh8uPiexoJWE1RThQh/QUz8ZU64byXIcFhOv3Z/7KRhJxVHaWvJDCQU6/eI
 lO5E34tZZG7ThsZyVEB5kIdGzCadJ8oF3k7JModCj8IF25Sul1WI8e7ad0D81QGF38bW+OX3m2gxa
 R2TT2v7kEn5PfgoVn3eafCsf4EMxnGT3nKT3kfuWOtaZk+L7ri4OSpNe+cf1xgnS8w+vicD6/v76v
 iBuss8fw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x0sU2-00000008ON0-3Zk5; Mon, 31 Aug 2026 03:14:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/exec: drm_exec.h: eliminate kernel-doc warnings
Date: Sun, 30 Aug 2026 20:14:52 -0700
Message-ID: <20260831031454.3406855-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

Repair kernel-doc comments to avoid kernel-doc warnings:

Warning: include/drm/drm_exec.h:146 No description found for return value of 'drm_exec_is_contended'
WARNING: include/drm/drm_exec.h:157 function parameter '_exec' not described in 'drm_exec_retry'
WARNING: include/drm/drm_exec.h:157 Excess function parameter 'exec' description in 'drm_exec_retry'

Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend
v3: rebase & resend

Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org

 include/drm/drm_exec.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260828.orig/include/drm/drm_exec.h
+++ linux-next-20260828/include/drm/drm_exec.h
@@ -140,7 +140,7 @@ drm_exec_retry: __maybe_unused;						\
  * drm_exec_is_contended - check for contention
  * @exec: drm_exec object
  *
- * Returns true if the drm_exec object has run into some contention while
+ * Returns: true if the drm_exec object has run into some contention while
  * locking a GEM object and needs to clean up.
  */
 static inline bool drm_exec_is_contended(struct drm_exec *exec)
@@ -150,7 +150,7 @@ static inline bool drm_exec_is_contended
 
 /**
  * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
- * @exec: drm_exec object
+ * @_exec: drm_exec object
  *
  * Unconditionally retry the loop to lock all objects. For consistency,
  * the exec object needs to be newly initialized.
