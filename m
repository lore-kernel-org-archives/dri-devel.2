Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593E606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cSmaCZUJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7104810E037;
	Tue,  3 Nov 2026 18:42:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D8E10E037
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=m6JbAA6AIoatTx3W2iR+oEUPKCoQ/RbwBBVTyBm0yuw=; b=cSmaCZUJTwdZ8a/fXUuh8MiQ72
 SzuFjS73W79d6BBS6sifALhVglPqETWlxMI/8gJDUM/yPWV0jxmEyorSaoEBJVu/EzAkkNQC15V1O
 oiZYGkbrH+yG7xWYie2tx1M51BLwaC+EeE8S1xJOZfwP9C2MJyQWX+TsA2EsjY9W52YU+oXVu0scc
 jkKV/ys4KGs5Tnup2xTSTO+3Me0S6kl75zlJQ4VMWZUrP9qnoDtCK1QNkpVpJnksWVXJWpEzbVfIe
 WtognEhyLI1go03/4DEBTiH6S6TGifoJiYJeeyt8Hi6wTOHUJXRLyjQ2MbeEmuJMEHXLGg36F5wNR
 VNQzyGgA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xOJSV-00000003Sko-2Imn; Tue, 03 Nov 2026 18:42:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: patches@lists.linux.dev
Cc: Randy Dunlap <rdunlap@infradead.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v4] drm/exec: drm_exec.h: eliminate kernel-doc warnings
Date: Tue,  3 Nov 2026 10:42:02 -0800
Message-ID: <20261103184205.2867179-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Repair kernel-doc comments to avoid kernel-doc warnings:

Warning: include/drm/drm_exec.h:149 No description found for return value of 'drm_exec_is_contended'
Warning: include/drm/drm_exec.h:162 function parameter '_exec' not described in 'drm_exec_retry'
Warning: include/drm/drm_exec.h:162 Excess function parameter 'exec' description in 'drm_exec_retry' (did you mean one of: '_exec')

Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend
v3: rebase & resend
v4: rebase & resend

Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org

 include/drm/drm_exec.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20261102.orig/include/drm/drm_exec.h
+++ linux-next-20261102/include/drm/drm_exec.h
@@ -143,7 +143,7 @@ drm_exec_retry: __maybe_unused;						\
  * drm_exec_is_contended - check for contention
  * @exec: drm_exec object
  *
- * Returns true if the drm_exec object has run into some contention while
+ * Returns: true if the drm_exec object has run into some contention while
  * locking a GEM object and needs to clean up.
  */
 static inline bool drm_exec_is_contended(struct drm_exec *exec)
@@ -153,7 +153,7 @@ static inline bool drm_exec_is_contended
 
 /**
  * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
- * @exec: drm_exec object
+ * @_exec: drm_exec object
  *
  * Unconditionally retry the loop to lock all objects. For consistency,
  * the exec object needs to be newly initialized.
