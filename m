Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C08C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9FC10EE0C;
	Thu, 30 Jul 2026 08:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XGXiX6J4";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E002F10EE0C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:04:11 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-46f88060e8dso160078f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785398650; x=1786003450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cYZOW4+rPj/CMFn0uRjVqgsz7yPpvLWpF6+UtZMyKrk=;
 b=XGXiX6J4ktWif/8/nhff3R2irUw3xrKIOYrXVB5W9I9McstQ+ZaC1nD8IMkfKg2LUS
 7NKrWJEnI4waO6StVOihPj6Auh88RGu2+qR4Kan7mDuysn9aYC/DQs8xQhGdyPZGiOqJ
 P0meT7l69BD6dlYjh5Utw3rIlEGeFgKSuqCdwme1z9j90mDNpZ2UcF65kFyTpnMo7KgL
 XLp5zezFXXBEU8PUFmRE22KLYcoEbsHIAzrQ+xJkZCX4rykR3D91GxF0l7D7tJy8vVrZ
 WFyLq4+qKXq4IVqBrD72f/zgx77yBL3gSS4V0MrEJ6yjRZ1eMoZIONlNPrLvfbLUSWt/
 KJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785398650; x=1786003450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cYZOW4+rPj/CMFn0uRjVqgsz7yPpvLWpF6+UtZMyKrk=;
 b=KoJ7My5X2NCS0hXQ78Gj98TRYf4/KFs/LgmIt3ItDZXGJHiqDYEVAzc1SJuFu2KIvB
 qN2hLh/vV3mGkNIyQ/QKlBDXFPV/JfsRdKwnPHqkFpHHmeH3KH/czm6U07kGbNv321nW
 8GfTvOuofs1lD6B0ZVA7LPpmZR8xI6PpiGlsIH9qnQtkJojoT31fiRe72HDw9rRuja58
 NyMQQPE/plEz6h8KqFawArAUgXoyM5Utn7JCY2US4oOhixUQwHzc+k41aV2aYJco3D6W
 tkcG00TNT+yEYPk0/hmlt80cP91NqVhkv8OfPfzTn61kBe6WQJBE6c23TkEHAmwJBER6
 0ibA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX8gfDweZ2MQQe6Le0zVVy2JXJyu9nPSUG/4QJVJXkER9D5K3CMWpAJaBZ0DM0QOGEhcwxhmeehbU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7g611agQCGdxyOKuU1RgEzwncuCUYLQPJ73QfwuCr/MKYGqIn
 nYZJOImFDLdOU2nSHdb7hFgIkVJP3DIWVKpWJpOwO7mhHXPV4kBzhRGT
X-Gm-Gg: AR+sD131aYbb+pxyRg0ck8JEM1+Dem12A4pT3rCGOiu6nr8uDxR9/j6+rpZnllpm5UT
 AAgf3YtlIacXM8wKcvWKSc92bIGGD6xro86AzKp0fc47oBoblVl+l0MMWgBVkm6DD3MTi2Ul0FJ
 bBX+U2UF78yxitWZ8wh0PeBUg2HhS7zgg/ewPqI6e3NTgWQY1HBjksaU7dkvXua54pYZxoiajls
 8QHYOiPddVveP8yurfED6IWkULleyG/dvVA+slHiY7ca3uYdV0q+3Rf2w7n2ObpMbniu+lmpJci
 yfg7B4vPcg0NJ2uxNIttrE2JlbyAyfFI6qa+9fWQiDqhdIDwdzAiMqix+CgvgyV3buu2IT2KIAX
 siuqnmKILCczqsGc+gosHvL9aIKigzeAmWau9grJduN7PGKJayWEDfOTGR6vCVCMtp7opE6kCKT
 3kubzdGTf5flnMI/DG3oOPo1KKQRqK6sql2XwCRkW/02isIUH2YDHrVgTKIEzg/pL8K4pePeuCB
 8l3lyQt1UJWd1KmMc7j18faaQmxpPLQZLKrYuuWOKWCp7/MIi+P4zZGo2BYNXdZt58IY2EgYa/q
 xf4V
X-Received: by 2002:a05:600c:46cb:b0:495:6274:56bd with SMTP id
 5b1f17b1804b1-49800ed4c5cmr19802285e9.4.1785398649931; 
 Thu, 30 Jul 2026 01:04:09 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8A5A00BF2D55A7591B4173.dsl.pool.telekom.hu.
 [2001:4c4e:1b8a:5a00:bf2d:55a7:591b:4173])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e4055sm3347685f8f.13.2026.07.30.01.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:04:09 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 0/2] accel/rocket: fix shared-device lifecycle on probe
 failure and unbind
Date: Thu, 30 Jul 2026 10:03:52 +0200
Message-ID: <20260730080355.177422-1-royalnet026@gmail.com>
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
(confirmed via the per-core IRQ counters moving to that core); and a
MobileNetV1 inference run via the Teflon TFLite delegate stays
bit-identical to the stock driver throughout.

The series applies on top of Guangshuo Li's pending fix, on which
patch 1 depends textually (reviewed on-list earlier today):
https://lore.kernel.org/dri-devel/20260708062845.716487-1-lgs201920130244@gmail.com/

Igor Paunovic (2):
  accel/rocket: release the shared device's devres on teardown
  accel/rocket: keep core slots stable across unbind and rebind

 drivers/accel/rocket/rocket_device.c |  2 ++
 drivers/accel/rocket/rocket_device.h |  3 +++
 drivers/accel/rocket/rocket_drv.c    | 40 ++++++++++++++++++++++++++++++----
 drivers/accel/rocket/rocket_job.c    | 11 ++++++-----
 4 files changed, 47 insertions(+), 9 deletions(-)

--
2.53.0
