Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1676CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48001112184;
	Thu, 15 Oct 2026 07:57:13 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFA210E2B8
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:40:09 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-3a9a2cfe1d4so21606881fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791913207; x=1792518007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2tz8g1Yqqo1JjbR59LpHagpXLtRLsb44/aec+ClQyYg=;
 b=Fiqd286IO13ZRN4PC6TiQCWOnXeLEraBmo5TXQPxLSXAAvt6h39Lgna0zHIfgEqglx
 /BJPEJNe+X5JGxvgNHsOuVjxTM41UPc/idoLKLDj9P3BY9jWwG0EuAZTqIGmveNdoMkD
 sbaHYeXEH8KbM3smLLiR/5uK31A1mfN1DtPgI2tX8D9NGHiYFuNp0AS2bqiZS/Dc0vN9
 qOerSs/it7SVf6B8o3P031xaTcA8cbn0sm/fFKe/T0brOdrm03aSd/XHroQCXyOkMYUI
 k5s3pL9JTmWb4dePtUiey2kVX2yDBYQ9ETi+blk+0vg/CG9YQMxOkyoqSZMTYacpWI7P
 6NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791913207; x=1792518007;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2tz8g1Yqqo1JjbR59LpHagpXLtRLsb44/aec+ClQyYg=;
 b=nSJEuF5QwaKmgxeIEfsJ1/kpDIp5sOopxPZGuudzsZfrqQ0zTCgA5CHKtoMaPv/JeZ
 ZdKCcaEwWsYrbRO8AWAkDq0d03bMbmlcjVv6ZDABYC2dDGB07JQJuEyNJzWXmrf6+/l+
 x75TmZ7j+Jw8nnfrtFHRDoDg+aOso8wY+V6V1nz42P24n75+Y/vS5TBWdamnJ4zxrVra
 NyNjH4/qnc7grwvN0h0eriSY9kkdZTrDZWsOMhHZMVJH1AdFhPvW2idjNS6CPcux+9Rm
 f+qIumQQ7Z9Ygui5grSB3oKjYEKIV/iCybe7BzbqQcu8K8SzBaTDrI3nZUhoDKlXJKjL
 Mr/g==
X-Gm-Message-State: AFq9FYJQPqppQAknxQp1ajBeI59dXe4ikpUwn2K4OlN1xYzXOExF/dSf
 7V/Ru0MXcoB2nLe2dDRIF09sxMSRYZuX3CM9I67rgGlkANRSnzcX59KDKXqwElwjWtc=
X-Gm-Gg: AYBFou1qFM7eLqOIKXb9hTs6q9/mr0qbC3uzoFxGwUxqGC7p5U4RJuG8Rmh915jKZDt
 0ihyx+EbhSeVaUtmQAW8pFRelr/FAdwfae5dS+MRIbFq0kd+dUlnPjp8Xct2ylpn//XkcP2e1Ps
 Fe1cdrRpl+iHzt5oNLh0QeMmYk0twgUBjEPangSEeB/2su/dFn/XPUsTnpHJ6GkLYe7rYqDjYSK
 YLFhAUOGgd1S4O9Ah+hqDrAR5jByo19RNHLns+7MVG9UJmNgV/6qfGXzCr2X0tKTypwn31c4UnJ
 NlC6G+z0auOcMF1UPz9r1bYpvq6unzLy3D8JHXBdpqznxTHT8jxMKYI1/IIal1Fk/1lf7QKOw3Y
 /P4fu5hKETi/9h7NN45Gbirpg5YfbPreiL8qy4jNY0moipqk9iaxLSWe6bFURbD7B+ZZKE+3joB
 TW+tV4bR7KuZ3bDiX3VXtyb95p5o38/japjGWuuaP6a1ncbonHJzgRCrP9oErrwO6sY8450Hou9
 4DzxomnmCSbUYZSbHqsrNnn6FzFL7iLhu0jipdqqNlXgLc9MyQyOFpe0SXXTFjxg54XM9MIB4dA
 eKaHPFenYPiLBWflA2Cg5F2BtNZtWHFZSCbRRq1A
X-Received: by 2002:a2e:be91:0:b0:3a9:787a:139c with SMTP id
 38308e7fff4ca-3a9c5714367mr33166221fa.25.1791913207207; 
 Tue, 13 Oct 2026 10:40:07 -0700 (PDT)
Received: from ukrainer-HP-Pavilion-dv6.IceIQ ([159.26.120.41])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cd7d6fsm36886411fa.33.2026.10.13.10.40.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:40:06 -0700 (PDT)
From: ukrainer8 <kolomiiec@gmail.com>
X-Google-Original-From: ukrainer8 <ukrainer8@users.noreply.github.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/radeon: retry UVD v1 init on failure after resume
Date: Tue, 13 Oct 2026 20:39:44 +0300
Message-ID: <20261013173946.33042-1-ukrainer8@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

From: ukrainer8 <kolomiiec@gmail.com>

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
hardware state at entry, not a skipped call. The single 100 ms ring-test
window right after VCPU boot simply races the hardware coming out of
D3 + ASIC reset.

Retry the init sequence instead of giving up: on failure of clock setup,
VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
try again (up to 3 attempts). Each retry logs the failing step and the
attempt number, which also makes future reports of this failure mode
self-diagnosing.

On the same machine the patched driver went 6/6 OK, with the log showing
the ring test failing on attempts 1-2 and succeeding on attempt 3 — i.e.
the retry caught exactly the failure the stock driver used to declare
fatal.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
Link: https://bugs.launchpad.net/bugs/1865130
Tested-by: ukrainer8 <ukrainer8@users.noreply.github.com>   # Radeon HD 5650M, kernel 7.0.0
Signed-off-by: ukrainer8 <ukrainer8@users.noreply.github.com>
---
Resent with git-send-email; the previous copy was mangled by my mailer
(pointed out by Alex Deucher). Same patch, no code changes.
 drivers/gpu/drm/radeon/uvd_v1_0.c | <diffstat>
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -158,24 +158,45 @@
 {
 	struct radeon_ring *ring = &rdev->ring[R600_RING_TYPE_UVD_INDEX];
 	uint32_t tmp;
-	int r;
+	int r, retry;
 
-	/* raise clocks while booting up the VCPU */
-	if (rdev->family < CHIP_RV740)
-		radeon_set_uvd_clocks(rdev, 10000, 10000);
-	else
-		radeon_set_uvd_clocks(rdev, 53300, 40000);
+	/* after resume the first ring test can race with the hardware; retry */
+	for (retry = 0; retry < 3; retry++) {
+		/* raise clocks while booting up the VCPU */
+		if (rdev->family < CHIP_RV740)
+			r = radeon_set_uvd_clocks(rdev, 10000, 10000);
+		else
+			r = radeon_set_uvd_clocks(rdev, 53300, 40000);
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
+		uvd_v1_0_stop(rdev);
+		if (retry < 2)
+			mdelay(20);
 	}
+	if (r)
+		goto done;
 
 	r = radeon_ring_lock(rdev, ring, 10);
 	if (r) {
