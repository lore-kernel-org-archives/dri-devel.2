Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA890C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF4110E1EE;
	Fri, 10 Jul 2026 16:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="dRmbwzYE";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1FAC10E1EE
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=+Dc0Mlljv4/uI7y+secKBl9+3xwsIwOCPbCIrJSm/EM=; b=dRmbwzYEX/npJ3txVlAJovfSIG
 IRWDO0AinB/9R5WKy6kX1t3ib9QgB8OZEXaZOto7n7aG9SdVXQRUQmhZJPVl6vrAEoQsgiw0Ofz+C
 je2TbWN3/IBdASpRK3eubn3saACReoGfI2QVnupu6oP0xF7oGeEG/dbzPId8RopvNzgUyq6yBDh+q
 g2nKxOD+Eb6lqpHXz1RLoCVX8E7wll6Y6/kJgEKdB++w/l+tDplOgK2PauqVuYkO6Y7gdssXa5k7d
 hoOpfDQFweRfttpN8STCAjK+tjwLKu1LVX5pUlU9iOTef6y7a0Opov86Crpa9mdK0OT40xH9A7qi2
 GgfOBfmA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wiEEQ-00000005ILm-1I7j; Fri, 10 Jul 2026 16:37:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2] drm/exec: drm_exec.h: eliminate kernel-doc warnings
Date: Fri, 10 Jul 2026 09:37:38 -0700
Message-ID: <20260710163740.953914-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
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

Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

 include/drm/drm_exec.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/include/drm/drm_exec.h
+++ linext-2026-0710/include/drm/drm_exec.h
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
