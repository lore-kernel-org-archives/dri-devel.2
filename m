Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67884606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LAWd8dUM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD9E10F30B;
	Tue, 20 Oct 2026 07:36:49 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2431610E883
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:49:29 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-3a20f06cce6so28950761fa.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792421367; x=1793026167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0G8FTT1Wj06imgLkxW4XHE20VAVXyNK1yK9qofsj0lg=;
 b=LAWd8dUMZWfDe6Zy1NHDgWYXxWNmjTTqvEkkGFLAWL0FEfLcXz99IOFGIJZunzmeTl
 5BMmbjpU4fPfp3O049YH7DvsMK52UR7Ys7L6ZGw8/4j1ZgfwkBZIyt/Cuwy54Cd7MRyG
 UPCEjRFfZUmtEcgPzgB/6VH89zj2n6ayc25LaCTMuqaE6gehIwGeuGKuqkrV5A9b+7IT
 7FWJpJG4GOejZOB8YfV8NrB0b6lC1mAP7lUyMXzVeyDz9v+xJG63F/yKT2sMY+WqFeAV
 2DKV8yKQjSqULuFt8QMjU2AX2qKGjCxJBDNebwPjg97BTF6KtWmXxlNe3QoZBifK5Kov
 Qa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792421367; x=1793026167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0G8FTT1Wj06imgLkxW4XHE20VAVXyNK1yK9qofsj0lg=;
 b=guK+QI5SmDTlzcgqPfZ4Cq0hjHvxOr0RZ/Et2qGvn00GED39FBD+tIeOvdQVQlqgde
 K8d+hYnIJL1cQIEV8k4ubD/+jbOZmeEBeTqpnsNzEYlPjy7Fv6+RPngx4hS/GjP0eFpd
 TDO02JNjiSzzCO+Vw1kqNblQ3iOLblquMvA/r5h20lapY6OgcZKE3pbtptOMRo/bkT5p
 ZCeYfTa0mgLPSgWwTXmLcIIEL57oH3Ig1EwX2xZEs6tZbjA7cOhBvgHj7bqttm/wuB82
 yZuunsBaVKZgmSTTMvrwOj/aarG1/kmOdvF4LYbGQpCTtcCijtCzaQI218PK287prpOI
 Virg==
X-Gm-Message-State: AFq9FYLmcqzZIR7m0iVh4aq93aA/bCu6ZqjBc5+RQA4NRf3aBSQ9INTt
 y3aiH/5Mv2aT7+9AuV2+5Pk4VoAQEnSr8FicFf+/lQDGKzMQgYHywbRVe7iE71wQhMY=
X-Gm-Gg: AYBFou1MyFUCIVe3iwmZ2/5SeLQiriUwyTLAuExUIFLx+AVhk/dmyK39yDnrg6VWj0N
 Uko+7LLIBprXSmGpe65G6tNqFgkpL3pB+tI7qpf03+zZwlHO5VfWzNuCbTcUqulPF9SNvYLC4uO
 VOObpeoDS6NpeT3sKge15Coxzr+dWo2KQBtatlvvwHr1WRMHxMKncZar6U8pZjN4GKVZO5LyxHM
 HOCgtcI6WXvXdHuN2LuCPh8CrKGfOp+ZSi8+VtANA9O1COcO4vn/v5bwKYL/EdHWWzCMaI6IW43
 htS7dP0+FiRpRIljQEISKkph+Exg6zu/mD9wHXwWukJrvKR/s+pA8dzHlYTNUixU80+J0S4COOE
 iyYD/+dT4pX9qQzeIcumwysSkHR1pUr0mcqWJG0+/PoqnHKj/2yX/0HpQM1m6IfrY/yBv85+ICL
 i5Dwdbkv/tkVcSGqiWwCruLrW6NpNqsBIb3U1dhD97jby44tGaJsmeUVrJKXbBC/mKaUWiE7f4H
 H6VQhjNtSYKMZR39rUz5BzZJGXZmdniQ+sxdZZPuNi4GlLgp+VxjJqQTk2qaaDrvs4MpSkyANDW
 zF3aB0pr
X-Received: by 2002:a05:651c:2123:b0:3ab:481b:5bc with SMTP id
 38308e7fff4ca-3ab481b10fbmr4442441fa.3.1792421366632; 
 Mon, 19 Oct 2026 07:49:26 -0700 (PDT)
Received: from ukrainer-HP-Pavilion-dv6.IceIQ ([159.26.120.41])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab16d7ddd0sm26651471fa.4.2026.10.19.07.49.23
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 07:49:23 -0700 (PDT)
From: ukrainer8 <kolomiiec@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
Date: Mon, 19 Oct 2026 17:49:16 +0300
Message-ID: <20261019144916.108589-1-kolomiiec@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume from
suspend intermittently fails the UVD ring test:

    radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0xCAFEDEAD)
    radeon 0000:01:00.0: failed initializing UVD (-22).

Cold boot always succeeds; resume succeeds only in about half of the cycles
(42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts per
6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD stays
dead for the rest of the session and hardware video decode silently falls
back to CPU.

The resume path runs the same full asic startup as cold boot
(evergreen_resume() -> evergreen_startup()), so the difference is the
hardware state at entry, not a skipped call. Field data shows the first
ring instance after resume is dead functionally, not by timeout: the ring
test fails fast and deterministically, and only a full stop+init cycle
revives the engine.

Fix this the way the Windows driver effectively does it: silently cycle
the engine once (clocks up, start, stop, 20 ms settle) before testing,
then run the init sequence in a retry loop - on failure of clock setup,
VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
try again (up to 3 attempts). Each retry logs the failing step and the
attempt number, which also makes future reports of this failure mode
self-diagnosing. The ring-test polling window is widened from 100 ms to
2000 ms as spare capacity; the early-exit poll keeps healthy hardware on
the fast path.

On the same machine the patched driver went 6/6 OK across repeated test
runs, with the warm-up absorbing the dead first instance and zero error
lines in dmesg.

v2: guard uvd_v1_0_stop() behind successful clock setup, per Sashiko AI
review - MMIO writes to an unclocked UVD block can cause a PCI bus master
abort and hard-hang the system.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
Link: https://bugs.launchpad.net/bugs/1865130
Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel 7.0.0
Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
---
v1 -> v2: keep the clock-setup result in a separate variable and only
call uvd_v1_0_stop() when clocks were actually raised (Sashiko AI review).
Also folded in the silent warm-up cycle and the wider ring-test window
validated in field testing since v1.
 drivers/gpu/drm/radeon/uvd_v1_0.c | 57 ++++++++++++++++++++++++++-------------
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -158,24 +158,58 @@
 {
 	struct radeon_ring *ring = &rdev->ring[R600_RING_TYPE_UVD_INDEX];
 	uint32_t tmp;
-	int r;
+	int r, retry, clk_err;
 
-	/* raise clocks while booting up the VCPU */
+	/* warm-up: silently cycle the engine once (like the Windows driver),
+	 * the first ring instance after resume is dead functionally */
 	if (rdev->family < CHIP_RV740)
 		radeon_set_uvd_clocks(rdev, 10000, 10000);
 	else
 		radeon_set_uvd_clocks(rdev, 53300, 40000);
+	uvd_v1_0_start(rdev);
+	uvd_v1_0_stop(rdev);
+	mdelay(20);
 
-	r = uvd_v1_0_start(rdev);
-	if (r)
-		goto done;
+	/* after resume the first ring test can race with the hardware; retry */
+	for (retry = 0; retry < 3; retry++) {
+		/* raise clocks while booting up the VCPU */
+		if (rdev->family < CHIP_RV740)
+			clk_err = radeon_set_uvd_clocks(rdev, 10000, 10000);
+		else
+			clk_err = radeon_set_uvd_clocks(rdev, 53300, 40000);
+		r = clk_err;
+		if (r)
+			drm_warn(&rdev->ddev, "radeon: raising UVD clocks failed (%d), attempt %d\n",
+				 r, retry + 1);
+
+		if (!r) {
+			r = uvd_v1_0_start(rdev);
+			if (r)
+				drm_warn(&rdev->ddev, "radeon: starting UVD failed (%d), attempt %d\n",
+					 r, retry + 1);
+		}
 
-	ring->ready = true;
-	r = radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
-	if (r) {
-		ring->ready = false;
-		goto done;
+		if (!r) {
+			ring->ready = true;
+			r = radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
+			if (r) {
+				ring->ready = false;
+				drm_warn(&rdev->ddev, "radeon: UVD ring test failed (%d), attempt %d\n",
+					 r, retry + 1);
+			}
+		}
+
+		if (!r)
+			break;
+
+		/* MMIO is only safe when the block is actually clocked */
+		if (!clk_err)
+			uvd_v1_0_stop(rdev);
+		if (retry < 2)
+			mdelay(20);
 	}
+	if (r)
+		goto done;
 
 	r = radeon_ring_lock(rdev, ring, 10);
 	if (r) {
@@ -421,7 +455,8 @@
 int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 {
 	uint32_t tmp = 0;
-	unsigned i;
+	/* after resume the ring buffer controller needs ~1.5-2s to settle */
+	unsigned i, timeout = 2000000;
 	int r;
 
 	WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
@@ -434,14 +469,14 @@
 	radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
 	radeon_ring_write(ring, 0xDEADBEEF);
 	radeon_ring_unlock_commit(rdev, ring, false);
-	for (i = 0; i < rdev->usec_timeout; i++) {
+	for (i = 0; i < timeout; i++) {
 		tmp = RREG32(UVD_CONTEXT_ID);
 		if (tmp == 0xDEADBEEF)
 			break;
 		udelay(1);
 	}
 
-	if (i < rdev->usec_timeout) {
+	if (i < timeout) {
 		drm_info(&rdev->ddev, "ring test on %d succeeded in %d usecs\n",
 			 ring->idx, i);
 	} else {
