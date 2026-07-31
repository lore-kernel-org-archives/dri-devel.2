Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BB1C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E76710F166;
	Fri, 31 Jul 2026 06:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CA5NQL8X";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F8F810F166
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:49:58 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f25e3fe44so57415f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785480596; x=1786085396; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vsR6hWzy4D9+PPoxqFEdaQVVVEVdpxP3yoc1mBPPEeI=;
 b=CA5NQL8XAzfh235tnCR6URM/yrr94rJZPOwA7FfuvfdbXJf5SJ3zTC7x+1hpeRc+X/
 rLN7MU+oynu+HBG2/PlZ3/EgI+LS2uve/sBwoXay0dLtp6yLPXnGZl44oJBdJ5yD9+qI
 k4npClHNLEyjGIWjoHBkngey5663D2HIUJvX2tZl0JJywSaoVWgoUYyjPVWHEcEhxp4m
 QISIEo0ZhSQdv+JNMGBiftI29TCn1TzP19CzNrojypnBllDa+bXO2C6oW/GIWrpTF8ij
 yOaWpKhiiCHKCTwlvnkn1LplRKFBXgjl/B6VUNbC2KPghTQXDq6Pue60olsC0W/Hs7tU
 G2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785480596; x=1786085396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vsR6hWzy4D9+PPoxqFEdaQVVVEVdpxP3yoc1mBPPEeI=;
 b=hGOjdO676zlu6o0ttkLxdgG9wkk3RvlDKzesSq3zLmDuhuLm2Zt+H+75IQDaTEr2dY
 STpUetPbFI+6+WLyaSXtdk6qrOqUp4UqTtUFyOHf8aL071W3iTSS6scsQ9Mul7rdL6dg
 A4dpKwgl2BgbcImpUu22BrupR4m43+Ew92d/7AmRGd08SmTX5cP1tsiqCc1BHGM+mVaD
 RpJS08W7Cir2msVXUsj2Jqsi+QzderpYZ+iA1zyVkinSp5Eu4CGTW0LzMRmU2jYzxqCu
 5dDEZKFID+/xFNvCiiC3kgrm9bZW1b1/37jE06DrieLWS3o/VXWVMslDOVC7qDECe184
 kgjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqidHVfl3fG1lRJYRHNceF030yJM1pHW8tM5P6LcmIaLHSD6H41ajLbZpf0c4+cNA8HsMxxTaiXE2k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3wNNrueK+FQB2/KRZ8gjPhAQprDgZcS/a8Ak1DEAQlrPT9WCa
 CGwjkp3r1/PxG/BPVJ30Gpy0b0V002Nu2eSBOiG/oLFfXTDHBHUAc9zP
X-Gm-Gg: AR+sD11jLP9eCsz38BjVuUkOV13CisVzEPeCPV65ejpxPffn5rCvs/pILmsZd8Zu/EI
 pB+m5SlTqGQ80GK9i9MRQj/2UE5CPNPa9MG1D2hIP1KaMYNc5bfqSa0btxr3Pn2fwR1v2cZ0Qtg
 /qyBghHKKveXi0JTm1ljCdeRH/jvjRdvLf5LJTh3fTi12ZlSVnzXwx4qkMZ19o4+BHzIB5orQam
 LVhYBP/I5lZ4OOjNaUqM5BhUdGgSc83y4ucgQvRvCZPThqgKz08/oma15jbtpQYWB1KgdLcnX1D
 xztBqKugzVMMaqtpN0Bb56wOhLk32a9/ub7LYUFSEASf7KrRCqfSH3qhX9vxjLfTKoZf9Ov2hlz
 Lp6R5K5VzuZ8gQW8XqMXmi3nVa3ZGha28mSgxzwarXgxbbefCRgg+Fai2Ks9qainMB59QkPAVHw
 Mt2ZS/tBuVfX26GMu2a8Fbt2EyWtNPXkZI4EqEGnlFgYx+gF8qVm0ybDcAj+IWNl/kyRik7pbB9
 TfVPml+L6nzugFQ81b+JVlhFbplQgtCySmrnnaBXSbO1S2wGacaeDiyn0RuWTR6fOr9bw==
X-Received: by 2002:a5d:64ed:0:b0:47f:7e91:3d55 with SMTP id
 ffacd0b85a97d-47fd2b3e820mr2256719f8f.2.1785480596373; 
 Thu, 30 Jul 2026 23:49:56 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8B8B0053881A2C61CA978D.dsl.pool.telekom.hu.
 [2001:4c4e:1b8b:8b00:5388:1a2c:61ca:978d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2abbsm1212753f8f.9.2026.07.30.23.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 23:49:55 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 0/2] accel/rocket: fix shared-device lifecycle on probe
 failure and unbind
Date: Fri, 31 Jul 2026 08:49:31 +0200
Message-ID: <20260731064933.12548-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

The rocket driver keeps a single shared DRM device on a driverless
"rknn" platform device: the first core to probe initializes it, the
last one to go away tears it down. This series fixes two independent
bugs in that lifecycle. Both were flagged by the Sashiko AI review on
my clks patch; I verified each by hand against the code and then on
hardware before writing the fixes.

Patch 1 releases the devres of the shared device on teardown. Today
every fini/re-init cycle leaks the previous rocket_device and pins its
accel minor - observable as /dev/accel/accel0 coming back as accel1,
then accel2, on unbind/rebind cycles of all cores.

Patch 2 makes the per-core slot bookkeeping stable across unbind and
rebind in any order. Today unbinding a lower-numbered core makes
higher-numbered ones unfindable (their runtime PM callbacks start
returning -ENODEV), a later unbind of such a core is silently skipped,
and a subsequent bind overwrites a slot whose IRQ handler and DRM
scheduler are still live.

Verified on RK3588 (Orange Pi 5 Plus, all three cores): the
unbind/rebind matrix keeps /dev/accel/accel0 stable and every core
findable; single-core operation works from the highest slot alone
(confirmed via the per-core IRQ counters moving to that core); the
forced-init-failure path releases its slot cleanly; and MobileNetV1
inference via the Teflon TFLite delegate stays bit-identical to the
stock driver throughout.

The series applies on top of Guangshuo Li's pending fix, on which
patch 1 depends textually (reviewed on-list):
https://lore.kernel.org/dri-devel/20260708062845.716487-1-lgs201920130244@gmail.com/

v2:
 - patch 2: clear the slot's .dev when rocket_core_init() fails -
   with .dev as the liveness marker a failed init left a
   half-initialised core visible to lookups and made
   rocket_job_open()'s live-slot walk overflow its allocation by one
   entry (Jiaxing Hu); make the never-initialised slot skip in
   sched_to_core() explicit; document the synchronous-probe assumption
 - patch 1: unchanged
v1: https://lore.kernel.org/dri-devel/20260730080355.177422-1-royalnet026@gmail.com/

Igor Paunovic (2):
  accel/rocket: release the shared device's devres on teardown
  accel/rocket: keep core slots stable across unbind and rebind

 drivers/accel/rocket/rocket_device.c |  2 ++
 drivers/accel/rocket/rocket_device.h |  3 +++
 drivers/accel/rocket/rocket_drv.c    | 41 ++++++++++++++++++++++++++++++++----
 drivers/accel/rocket/rocket_job.c    | 13 +++++++------
 4 files changed, 53 insertions(+), 10 deletions(-)

--
2.53.0
