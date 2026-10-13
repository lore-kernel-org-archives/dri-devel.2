Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE41CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E7E11218F;
	Thu, 15 Oct 2026 07:58:32 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E7D710F91F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:58:19 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5bcbb82dbadso2488251e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791914297; x=1792519097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8aeCNO0JEn5DlzGCCPHU4ZKMFsT29OC2uQSdbwfSAMA=;
 b=IAR3M2Uwad5k8RQ0VKHjpjqX3aI1VGxAq7T6KROSsv5ijqyY1wsIo5duHWNgrIIxe0
 56u+3qm43GIbuNt2CvhDY0tZih2d07Arp5wH6vaH0yT2Q0L0nwcHWrS01WXe6qXsaBte
 HrX6vV6KGdnYgE/VCaYXpKxadGdo/YRslI9/nA+jwCOGmOheqtv5110yIr80c4UG0lJd
 A+I3koWybMOj+8btja1sdbpAE5wZj9XpEA2kNMFOr/lJDV1sN58A/wNRX6ktR9M27+FT
 BvPjvmk/KaGik+arrqISLiFMtdvIjsGnOi1gUiHiWOm3VnIL+TegWAS8Q2W8RCN7vBHT
 /j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791914297; x=1792519097;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8aeCNO0JEn5DlzGCCPHU4ZKMFsT29OC2uQSdbwfSAMA=;
 b=KCd656Q4Ogn9wr7q4/ZWMDBEk2pIHl9jLsPipxRkPE5qEaS1UZVz7U3emXgyPNjHwv
 I2UpsZ/4YqZGVHkrcNvVeKC/Q5bHAgWgnu9X3cZzmr/880k0/1PZwK2dhskwL+oSSAtv
 3gjfGE8ebi/q+6bojCPTMCtqaIMjzW1bUa/HWOyhLzD1Ktz7NN9ladwuVG0CA0JuNwlP
 3z9VOlXyI1vr009hVO/0nHJ2beunTMpnlbfqCMMAiole7GFdfgY0MvIEaU7ENg221qni
 Au6hCrI93EkH+nluIc7JfEOvfHbuvHlxp9fzo9wURMeApnE+hOpL9LiysTxCQhhb7QZy
 Hgvw==
X-Gm-Message-State: AFq9FYKWlwyiQp3E9i+q6YfmLkOvKYvOaIycwdDtq78llZtyDbBlP6P7
 eCatBQr3wNObWeboDkVo2265ZjFuGr3+Dipq3H5rqpmCp9U6PucuG0SKUJJx6rBRQAk=
X-Gm-Gg: AYBFou3XE9UjsO640IFHAYgujt7EPRthEPebTN3O9s1Z6WADARjhLexhWBaEPGMSnM8
 qi1auneTizrj3JZPg8DViOS5/9aX+AjksVtn/KqvdOeXXNRyfDJh1cU4o96VU+Vbp3Hm6WqeEVC
 F5JiEJgKaUZ8C9s6tLN3kxgEVkUdK4X6bdv2aTgib3QQxv5h7oIJG/Lynh9fXqp804OBBs1BUhU
 WSktIKHB5QnpIBaNrmyoXBVGHuZmUIJZpmgtFUjd/vZWeBMgSEto7w9PNM6KZuRwnY3MRTlHFhJ
 dWutgIqlZnEfS+5Dwjs5QyBNDIy0WyoP1lRsAQ3TmYoZ14YJePPnR2JVR8OkGOwjGdea0PS80wv
 vYf7deqQIG0/X7aMQzlppIIOd3W5LGyocXw6uj7jF07Neu4Cp9E3GTjF1b9zulOiV29GV5O1ITj
 ArnpAuUHSqMZ3L0kC+/xZN1Qth3tbPjEt3EPmN2Vv3CAP/rXO5hA89R8qwNnE3cqfIZz/yXaL8v
 Q/easMyR1RgANdhRl2oI6R5hQqVA1r44zb1KAGl0QJX4nmru5NFoeTMzBU2HYQLs1EppOJqCvWn
 996UczWTYg==
X-Received: by 2002:a05:6512:308b:b0:5bc:b0f3:8a40 with SMTP id
 2adb3069b0e04-5bcde6bf6a5mr4304974e87.11.1791914296802; 
 Tue, 13 Oct 2026 10:58:16 -0700 (PDT)
Received: from ukrainer-HP-Pavilion-dv6.IceIQ ([159.26.120.41])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d88252sm90358e87.52.2026.10.13.10.58.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:58:16 -0700 (PDT)
From: ukrainer8 <kolomiiec@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/radeon: retry UVD v1 init on failure after resume
Date: Tue, 13 Oct 2026 20:57:51 +0300
Message-ID: <20261013175753.37344-1-kolomiiec@gmail.com>
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
