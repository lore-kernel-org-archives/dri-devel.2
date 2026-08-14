Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA068C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0F510E0A5;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ITcQ2BW7";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B30D10E465
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:00:21 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so712857b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786701621; x=1787306421; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CEq/gI0mam4/U63KJoUcke2lMf2q5gb8Kb5V1dW24Zo=;
 b=ITcQ2BW77HJNZswSmi18W+PVGCgdaMEl8pQE99lU1fXeeWtenKYObfRpsLxw8XdQzJ
 I89ZImlGyTolUPaZXwLBaKwZud4bEl/VOcXmaPcjNI8iOhpGpmpHfz0uyAeK17/Oju3v
 lM46g48delpIweBHIrjbIvgRphAkz+RmDOUchfG4o+rSg55gqF4OY4AUSAEqqfxZ9IZI
 clEmXIpQ/e5Mjz2DCuJckbHByeP5JnrBv0ZK+Ab3BRbC6z87q+onuVtkh7kXQXXo7pXR
 6VwINULPyxDZYsaOuvAOFyl4bj4jSD4KqfNfYcMaQ/flyUFBezLSzpLDzUdhf6x+z3FC
 FvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786701621; x=1787306421;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CEq/gI0mam4/U63KJoUcke2lMf2q5gb8Kb5V1dW24Zo=;
 b=W8rmzDiPar7TeVwYC6rETXf+49XL4cILRJVkOorVl4jjRMn7I4lTLYLg8kMoPYL3Y9
 6vC1AC8jYRclb4ijORncKTBUrS6IfIyW7sBpGE5L+/T5M5ymA4pa0xZm8hHQZm6CfiUU
 QK6nYN06drSyChBNmROmTv66G371d7sqHWM819TneexgunrjtkcyGPq4gvyYbl0c4r/z
 AVs4oE3hgQ0WDGhF4eoRRTj4Ogzifjd8v4QWA2wK8DUb+YsCwL+LQd/CVDd6MedJGd0y
 dNZYjGK7tpZOO1zTuto3X7LQn1lQb+58IUhI0tesiiJaEJ+u3FH09pVfgojE9LwDE2b4
 Gb7A==
X-Gm-Message-State: AOJu0YwiDezs1IK3BEEI5r0H0gCR/YTIh5CGr6DzysTQo7L+Y3xDdKV/
 nvawRcuwFipGMt7aiSbhksWDvZzSveRkG5RffFvnU1SiX2IYvWPXaeDQ
X-Gm-Gg: AR+sD11CC4fWNkO005+tNkLwMq+47NbMhjYdiTfRCopGtLTtQBAsU815isnPKzniaa8
 SEGkLLKg2le+ALlF8vyqKLVNfuXCuSQJ2/EUWCGjL+jFRwUDy4arxSRDSNZB2z9QH7c8VhKb2K7
 qEphCsMR6XY5FDo04Fz3DjU3EBhFfx49xFRkFuvv8pHCDnXRHL73GipBu1LJ0hf88QHBdK5lIyA
 kq2Rprr/hYj/ooHn5AEFSjUmnotzr8sbb7vplahmWCiax+mBRWvltX9g8tuZpybCjOcjGc2QF6n
 PPrWGp4woXys0mUpLabvpj0yvXUZDRe16lbAbzzmVuXxiXaa0xiBMz8hd10BR9ZsovdHjIuKTcW
 ddsC9NJt1E1xdZKOwlOQrUDjwwcU39N6suXanrY4HLGtKCo10ooCWfG90St3TxmCLDgRk6ctjNE
 TCouZq0s7qxjjL3niO3HAClMKmoPyBYBpJwqQNPdZ1344DxMpfGOZLZUh7cIAfrK7F
X-Received: by 2002:a05:6a00:338f:b0:848:467d:293a with SMTP id
 d2e1a72fcca58-84fde38d267mr5281242b3a.35.1786701620572; 
 Fri, 14 Aug 2026 03:00:20 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517cfeb3cesm243681b3a.3.2026.08.14.03.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:00:20 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 18:00:05 +0800
Subject: [PATCH v2] drm/nouveau/svm: drain fault handler before freeing
 svmm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-nouveau-svm-svmm-uaf-v2-1-8e6590519f07@gmail.com>
X-B4-Tracking: v=1; b=H4sIACTnfmoC/4WNQQ6CMBBFr0Jm7RjaKhpX3sOwGMoANZaSljYaw
 t2leAAXf/GS//9bILA3HOBWLOA5mWDcuIE8FKAHGntG024MspRVeRUKRxcTU8SQbI7FSB02je5
 UJaszEcE2nTx35r3fPuofh9g8Wc/5KzcGE2bnP7s3idz7o0gCBcpWCSFbpos63XtL5nXUzkK9r
 usX6v8BRsoAAAA=
X-Change-ID: 20260813-nouveau-svm-svmm-uaf-bbcf36265aaa
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786701615; l=3566;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=Xa5VtHj3w4sPlc/TppIcRh1BbFj+6tLTdDnsIWhMORY=;
 b=TBxXokJK8M7vP1OhEP1hGzukGoCRT8H3Zet+dNfTg4l0/uLvvpsPxPmHtEGUTfqyZsKlDo9E4
 ofOpy7NU5suA8CQXNc7SFLTq0vitYWUEzCqlR4zth9V1vglhRYM545G
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

The SVM fault handler nouveau_svm_fault() looks up each fault's
nouveau_svmm under svm->mutex, caches it in the fault array, then drops
svm->mutex and dereferences the svmm across blocking faults
(mmu_interval_notifier_insert(), hmm_range_fault()).

nouveau_svmm is not refcounted. On DRM file close nouveau_svmm_fini() ->
mmu_notifier_put() frees it asynchronously via call_srcu() without
waiting for the handler, and mmget_not_zero() pins the mm, not the svmm.
flush_work() on the fault buffer otherwise runs only at device removal
and suspend, never on close, so a fault handled concurrently with a close
can dereference a freed svmm.

The instance is already unlinked by nouveau_svmm_part() earlier in the
same close, so no new fault can resolve to it. Drain the handler in
nouveau_svmm_fini() before the free, guarding the flush with a NULL check
on drm->svm: on device teardown nouveau_svm_fini() runs first and frees
drm->svm (NULL) after blocking the notify and flushing the buffer, so the
handler is already drained; on per-client close drm->svm is alive and the
flush runs.

Fixes: eeaf06ac1a55 ("drm/nouveau/svm: initial support for shared virtual memory")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Changes in v2:
- Fix a NULL deref introduced in v1: guard flush_work() with a NULL
  check on drm->svm.  On device teardown nouveau_svm_fini() frees
  drm->svm before the per-client svmm teardown, so nouveau_svmm_fini()
  would deref NULL (reported by Sashiko AI review); the handler is
  already drained there, so there is nothing left to flush.
- Tighten the commit message and the code comment; no functional change.
- Link to v1: https://patch.msgid.link/20260813-nouveau-svm-svmm-uaf-v1-1-2d3112dea734@gmail.com

To: Lyude Paul <lyude@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..a87406d3da30 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -304,6 +304,19 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
 {
 	struct nouveau_svmm *svmm = *psvmm;
 	if (svmm) {
+		struct nouveau_svm *svm = svmm->vmm->cli->drm->svm;
+
+		/* The fault handler caches svmm pointers under svm->mutex and
+		 * dereferences them after dropping it, across blocking faults.
+		 * The instance is already unlinked (nouveau_svmm_part), so drain
+		 * the handler before the free to release any in-flight reference.
+		 *
+		 * On device teardown nouveau_svm_fini() ran first and freed
+		 * drm->svm (NULL) after draining the buffer; nothing to flush.
+		 */
+		if (svm)
+			flush_work(&svm->buffer[0].work);
+
 		mutex_lock(&svmm->mutex);
 		svmm->vmm = NULL;
 		mutex_unlock(&svmm->mutex);

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-svm-svmm-uaf-bbcf36265aaa

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

