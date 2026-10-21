Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0819606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y7z9xyDa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B69B112437;
	Thu, 22 Oct 2026 09:41:16 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4526110E1D9
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 21:37:24 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so723183f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792618642; x=1793223442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l+wW5y3oLkACw7iMTJygQDIUG0x1gkmsDhwfnY1QE0Q=;
 b=Y7z9xyDahCO5SnmM8owmTB2l9WChoz1sSyN90nWZ5H/qkHVFkgWzrJgQckqsf7eVxT
 o2BTQISeFJCPQaIX6FLRUwVvg9C+kp2Afyla1atiygp0cGN/MBhAy9iMLcmwthdRy7WH
 CeBKC/Ju3RuxYlPevDJk3wKajnVLvmeJhdKRn4rpHO0FR/6z3GNqCscMWsEVfpEVt0Jb
 fRI8OhdeDzjgXqINp+LVBuZmwbmoFuOSflEiTv5ETLMATwAKtUVMCyADPOC40EQevBvE
 /MzjMRRAxrgLZHL2HiJ8Grq7SY1Lg0Sc2sJpP1t+qlHUODeP7dtKAui9y8jUxrtKyvET
 Ln+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792618642; x=1793223442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l+wW5y3oLkACw7iMTJygQDIUG0x1gkmsDhwfnY1QE0Q=;
 b=wI2drlajsNmRhO/S9DPVZdLx+Ua1WFKPREsQEaBDmhaoOEQbOI4dIlebJvOuZ2EimC
 d/lwPE+1XPaAyV1XErAiLVDCnzk36IhB/UIqy8auSqQTOXuJmpRetLONlGfdUhyOqD7i
 YsfI+vH/n9y2jGjas7GqQ0DVMmUeLdOYald/dOa+Z1LsdO7ZUI6wkachuO34Pjpc2aiO
 CnzLuqUpZ9Au/XEGVFwdTKR5rgRORnqalPvPd+wcyLTygaUPZl3bPcfFaNZhderH8xtl
 fKZVAVxBTeNkGEKhNq/cwM2hOJDcnFm8UYGDnBM9Q02dKvmwKkvvkb1yURnNVggmVKt0
 tsJQ==
X-Gm-Message-State: AFq9FYJV8s46io9IyVS5/wktR5oxPMe9mm1PgW4N7dbAJTIW1XnQoAGX
 R/mJfG6FPsf7+heZg5FCo/6vgNHlP387CcCebwkzN3EmxG/ISPo5tXbgBMkcA+FhU0W89A==
X-Gm-Gg: AYBFou394w4hnyRwpmwcdle+nISIXgn8E32KtuCFWf1CYtzCupgHIdHSMzWrvywihZR
 TU8T7iEB8hFAu8xkN/J+Mv0V2p5a7O14o6iLhyXEpJHSBwyP/bPsdudQ/L4ZoZm/XiNpPk6LqiT
 ffS+xdeUbQkabUMOUukq+3GkVmpcd8fT6AoWjbJrX4fbYEA0/wOeZ6+xZ9c5Vt0zJrW7ZjmgWld
 TW4M4XUP1Ypop6ptTZIU1rPDYZDB1oOqfo0f0JSv7QkmOh4lQ7LJ2ZF2Hu3EWiSbo5k6Gg1Bgbb
 RayoT3liypBUMElSKvGl/q4RNMArVqk6XIz392Uj8tF/vPz7YJEd+E/bxeAAMcg/dkoZjpqv3OU
 7IX2PY3kz32pdL70V3STUhv/IHiPwGaA0A4rBVxVn5jLzT7Bau+9UogxSPm+HxlN5MfhBkwrwHq
 ZEGvVgvGlOnVOcDG6HGAVgDceh4JHbhkZiers8nrhirAMrNoKhQNc5whT+lVvfiXOg65Qt+7Ntb
 sAX+MHOi8+xneQL7evQ7SDY87Ueid0K5/gcsvF0rKkgSVDjUn6asria3Cr8McQ2AcMILUlMGhDW
 AxdZErllR1w+7AWT9vb5zHbRZnPVdl862qZtFw9BxjHhZhdLdrB6iA==
X-Received: by 2002:a05:6000:480b:b0:48e:261b:a49d with SMTP id
 ffacd0b85a97d-48e2649da02mr7021255f8f.15.1792618642414; 
 Wed, 21 Oct 2026 14:37:22 -0700 (PDT)
Received: from localhost.localdomain ([159.26.120.41])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25833b9asm8435172f8f.33.2026.10.21.14.37.21
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 14:37:21 -0700 (PDT)
From: ukrainer8 <kolomiiec@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/radeon: retry UVD v1 init on failure after resume
Date: Thu, 22 Oct 2026 00:36:35 +0300
Message-ID: <20261021213635.235393-1-kolomiiec@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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

Retry the init sequence instead of giving up: on failure of clock setup,
VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
try again (up to 3 attempts). uvd_v1_0_stop() runs only when clock setup
succeeded - MMIO writes to an unclocked UVD block can cause a PCI bus
master abort and hard-hang the system. Each retry logs the failing step
and the attempt number, which also makes future reports of this failure
mode self-diagnosing.

On the same machine the patched driver went 6/6 OK across repeated test
runs, with the retry catching exactly the failures the stock driver used
to declare fatal.

v3: dropped the warm-up cycle and the widened poll window per Sashiko AI
review and our own measurements (neither prevented first-attempt
failures); kept the guarded retry loop.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
Link: https://bugs.launchpad.net/bugs/1865130
Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel 7.0.0
Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
---
v1 -> v2: guard uvd_v1_0_stop() behind successful clock setup (Sashiko AI
review: MMIO on an unclocked block can hard-hang the system).
v2 -> v3: dropped the silent warm-up cycle and the 2000 ms poll window.
Our measurements agree with the review: the wider window changed nothing
(first attempt fails fast, not by timeout) and the warm-up did not prevent
first-attempt failures (5/6 cycles) - the retry loop already does
stop+settle+retry. What remains is the minimal guarded retry.
 drivers/gpu/drm/radeon/uvd_v1_0.c | 40 ++++++++++++++++++++++++++--------------
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -158,24 +158,48 @@
 {
 	struct radeon_ring *ring = &rdev->ring[R600_RING_TYPE_UVD_INDEX];
 	uint32_t tmp;
-	int r;
+	int r, retry, clk_err;
 
-	/* raise clocks while booting up the VCPU */
-	if (rdev->family < CHIP_RV740)
-		radeon_set_uvd_clocks(rdev, 10000, 10000);
-	else
-		radeon_set_uvd_clocks(rdev, 53300, 40000);
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
 
-	r = uvd_v1_0_start(rdev);
-	if (r)
-		goto done;
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
