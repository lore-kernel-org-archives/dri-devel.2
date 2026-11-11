Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017A60A261E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=fqI228fj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F51A10E67D;
	Wed, 11 Nov 2026 15:05:43 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C2D10E433
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=pvYGyDM41CtG+ZavgCjkAA3/Hw2iamtu4en7xYQPXxM=; t=1794409536; x=2109769536; 
 b=fqI228fjNyds/qB7u/ILGR9kwHVggBN4cdEsEf8S1EZW/bK7Jo46eR+E3SbU85j/K/gvUjZgAma
 cgk5zl9tL29JYLAeQwX7lIR3VCdtc+SjwadNXzVYysFNMCyq9nKiIzkQMX9CjeAMNW+F4q6fpWy2A
 U1mPcEQFDrxiLywGPai+ENqJWZmhIC3NX0w2nbz7Nobbf6PePKGvhDs6EMv+XczJ6lVMn9FKtjt6m
 eirWPjyzzZDJNdVnbtYPduCad0q6UnoOku+gcg5yRO3EdEMRj2XZHm41k4u3XYXK2Z1ua4wGRITil
 K7b1906MlUS/n0wR+1ZWDm4TPkevslGCcm9A==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xR9tE-008sMR-FQ; Wed, 11 Nov 2026 16:05:32 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 11 Nov 2026 12:05:20 -0300
Subject: [PATCH v2 2/4] drm/vc4: Rebuild the V3D interrupt mask on every
 power transition
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-vc4-irq-cleanup-v2-2-aa757bb742f2@igalia.com>
References: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
In-Reply-To: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3819; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=SDpuHUkpkO/PGY6DCPnerRl9iTaIOfjN7htzH20BJZs=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9IQ1jHTY7K9s8FUrK4f1fEEQEslw85OjBMY42
 fuF6ZMufGiJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavSENQAKCRA/8w6Kdoj6
 qrmxB/9EM4Ji3uUAQirro+sNX2PzsvD9wFZo3dt/Cmm6yjrwrKFkd9EnG2THPwPciWHNNxgD+Hb
 WkVEMOpRgmddlGWRhQtGicTouN+EKZwSVI/Zy/xvrBG8O4ZW33okU0nJRdbRIey9G292fzL5XeV
 R+zoR4f/tLQsaQIVKhylmPM6Lj4wEw1/VbEnAqxRkQoFmonJxHxx9eZOH5XnbCvE6ZQtYbXDFz/
 TJb6XsZ3IOKsWN7ZDTqDJJ3MIeTfYgo4sLJuOABhCvCxRTeXr49mKbcuD3xi5wM5dnQLHS5C2S6
 TZXK18Fr6u0N44ATffGSPh0tkoa/ByudO3Qj+exLsGcsLPEo
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The out-of-memory interrupt is armed once, by bin_bo_alloc(), when the
binner BO is allocated. vc4_irq_disable() masks it on the way down,
vc4_irq_enable() brings back only the render bits, and bin_bo_alloc() does
not run again for a binner BO that is still referenced. An overflow after
an autosuspend therefore raises nothing and the binner stalls, until the
hangcheck resets the GPU and arms the interrupt again.

Therefore, derive the out-of-memory bit in vc4_irq_enable() from whether a
binner BO exists, which is the condition bin_bo_alloc() was standing in
for.

While here, clear the complement of the wanted mask while enabling.
V3D_INTENA and V3D_INTDIS are set/clear registers and the driver only ever
set bits, so a source left enabled will stay enabled and can reach
vc4_irq(), which returns IRQ_NONE for anything outside the three bits it
handles.

Fixes: 35c8b4b2c0fe ("drm/vc4: Allocate binner bo when starting to use the V3D")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index c00a3e7c1358..d7aa698526dc 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -53,10 +53,6 @@
 #include "vc4_regs.h"
 #include "vc4_trace.h"
 
-#define V3D_DRIVER_IRQS (V3D_INT_OUTOMEM | \
-			 V3D_INT_FLDONE | \
-			 V3D_INT_FRDONE)
-
 static void
 vc4_overflow_mem_work(struct work_struct *work)
 {
@@ -249,6 +245,7 @@ void
 vc4_irq_enable(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	u32 mask = V3D_INT_FLDONE | V3D_INT_FRDONE;
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
@@ -256,10 +253,18 @@ vc4_irq_enable(struct drm_device *dev)
 	if (!vc4->v3d)
 		return;
 
-	/* Enable the render done interrupts. The out-of-memory interrupt is
-	 * enabled as soon as we have a binner BO allocated.
+	/* Arming the OOM interrupt before there is a binner BO would raise an
+	 * interrupt nothing can clear.
 	 */
-	V3D_WRITE(V3D_INTENA, V3D_INT_FLDONE | V3D_INT_FRDONE);
+	if (vc4->bin_bo)
+		mask |= V3D_INT_OUTOMEM;
+
+	/* Clear any pending interrupts someone might have left around for us. */
+	V3D_WRITE(V3D_INTCTL, mask);
+
+	/* Enable our set of interrupts, masking out any others. */
+	V3D_WRITE(V3D_INTDIS, ~mask);
+	V3D_WRITE(V3D_INTENA, mask);
 }
 
 void
@@ -274,14 +279,14 @@ vc4_irq_disable(struct drm_device *dev)
 		return;
 
 	/* Disable sending interrupts for our driver's IRQs. */
-	V3D_WRITE(V3D_INTDIS, V3D_DRIVER_IRQS);
-
-	/* Clear any pending interrupts we might have left. */
-	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
+	V3D_WRITE(V3D_INTDIS, ~0);
 
 	/* Finish any interrupt handler still in flight. */
 	disable_irq(vc4->irq);
 
+	/* Clear any pending interrupts we might have left. */
+	V3D_WRITE(V3D_INTCTL, ~0);
+
 	cancel_work_sync(&vc4->overflow_mem_work);
 }
 
@@ -324,15 +329,12 @@ void vc4_irq_reset(struct drm_device *dev)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
 
-	/* Acknowledge any stale IRQs. */
-	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
-
-	/*
-	 * Turn all our interrupts on. Binner out of memory is the only
-	 * one we expect to trigger at this point, since the reset cleared
-	 * the overflow memory address and none has been supplied yet.
+	/* bin_bo_alloc() may arm OUTOMEM between the bin_bo check and the
+	 * INTDIS write in vc4_irq_enable(), which would then mask it again.
 	 */
-	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
+	scoped_guard(mutex, &vc4->bin_bo_lock) {
+		vc4_irq_enable(dev);
+	}
 
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	vc4_cancel_bin_job(dev);

-- 
2.56.0

