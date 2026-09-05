Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0473CC624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559E910E61A;
	Sat,  5 Sep 2026 15:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JYYp7i41";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2EE10E61A
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 15:04:57 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48435ae9ca4so227423f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788620695; x=1789225495; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NM2S1Q42b15aXVJKX75peJvXAR4lZmt0uA+gclfAVgo=;
 b=JYYp7i41knQd5G5wXuI/RbKF52AlZ+/ShwhjsJ5wP5PBjHIEePGvPgVmcIptAAdR+F
 FdG4GQFq7CiyUwY/F/YBOYcTrxduN1ZNanjBKwjFaE8Ll+tHb7h388dzs1grVzmkXRze
 hKVPBox4RSMlUwaEcE7MjqnC8o8bcpdh+cXGHiYQkXq6zTXTOyIqUOcRV2xZNeFkE5v8
 AzAuq2j8GkhzbVsYZtkKKcjCJnYo9CI4OXjU2YyUbY6MIU67zgnosDKcXFSFRUaGgZg1
 v5pkyno4Ur0yTRfD5evCIvBHj9vkEzNBcYBMSHL5P2NUitbefzsVv+HcnrL9aZdx5ilw
 u+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788620695; x=1789225495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NM2S1Q42b15aXVJKX75peJvXAR4lZmt0uA+gclfAVgo=;
 b=rL0A3eN5dJVF/4fa5m7kEv/O1Rc4ZA7A8427L/9Q/pGuBczc7QJCAA1sg5WYKQtNiE
 49BvGIl/NOVi85CjQz2/xV5EFW5HsBAFQUwB8O3MOHxBJDJS6zYas3JMqtM7+GGtrr7D
 QknCi+Kiq1R5hLwH1c/L6GyYwygsOiJ4JBfEB+WqCvUfXCJtQQNAAA5W6YRZz0qlIndx
 FGU6Q5Bg7K8//nP1aILfEjQiWw6W9WDPFhgSEbUnjcLj8cpBM2z1roU393TInDRynWJR
 l05XmFb4dHTJXI3LxSWq5Uwn2L2FrG/P+SpSA44CD7MWFH9sybgPIkU4/GH457k8fWoc
 byWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDi212q9AN+avOydIAnmkw+JrskSKVy1GxsKd9BzMNxiwHe59jQAHqsu+aDYM9gD6yn8yF6CCCt+M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngcS2KaT/DKE54TaTws4S9QVIdaiRz+M0BR0Zpan8qd0zHpSro
 15ulcaFauhoikTeG2LyGDIeKifk7ge+UIYU/TvszqrzdqZP1QKLp5Dpx
X-Gm-Gg: AYBFou2YTwXki/SbqH6GpJBs5YZJGIoEHGulwgyDGIv4yfi7y9KsKfbH67ZWo/HMOiL
 UgAmwNQVuxC8z5hrrkD8TqSTKJcDq2BB4J2jJt+yOrID/AgVTYVL7JUNcMW2o3sLZUojh13vkyr
 wNmbkv+Dt8p+JkZzMWmPbgVxR4pRwpyXncle1PY8wdpDEVnf4cdF4C4wCaqUcAq12vfQMbj0NEq
 jIjVpyqfCzYhpUvGyQx2AkjGlPzPsXev0YmOENySJMs88WLam1i7BnUw8Wx7f67loKwShBZC6Zu
 HqJKG5oN8gAmfahkRz77GV5faq4QqICNijpaLY4jRSx3qNuhTMEI/rP1td6THv86E3xbWD+p0Vh
 /gEYBoihiIW7vpGrvAQK3LQMvMUCwTdrWXEMa6uYbKo4dfQ/zrNkSxN7A+YVm21774nAGvdqEIQ
 V8mt6d4LK0BUZy3QPVe08mbbPXSFiNOS9j6+wJeOKfxDsUqmSD54zAnw1c3JXD2RopsM9IXLwb1
 VVO0PW0xMAdnWkXau4xYofOJWIkA1oMamCK8TGzPhIg44y55MddrSdH3+ejEQxoS3k=
X-Received: by 2002:a05:600c:34c5:b0:499:cef6:104c with SMTP id
 5b1f17b1804b1-49cf823c012mr101940875e9.1.1788620695367; 
 Sat, 05 Sep 2026 08:04:55 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B950E0061C002CD703C2CBB.dsl.pool.telekom.hu.
 [2001:4c4e:1b95:e00:61c0:2cd:703c:2cbb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75cd8d0sm142811705e9.2.2026.09.05.08.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 08:04:55 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Sidong Yang <sidong.yang@furiosa.ai>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] accel/rocket: search every core slot when looking up a
 scheduler
Date: Sat,  5 Sep 2026 17:04:32 +0200
Message-ID: <20260905150432.7477-1-royalnet026@gmail.com>
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

sched_to_core() walks rdev->cores[] up to rdev->num_cores, and
rocket_remove() decrements num_cores for every core it removes. Unbind a
core that is not the last one and the cores behind it fall outside the
search, so sched_to_core() returns NULL for a core that is still bound and
still running jobs. Neither caller checks the result:

  rocket_job_run():      rocket_fence_create(core), core->dev
  rocket_job_timedout(): dev_err(core->dev, "NPU job timed out")

Unbinding the middle core of the three on an RK3588 while three clients are
submitting to all of them faults twice, once from the surviving core's
job queue and once from its reset work:

  KASAN: null-ptr-deref in range [0x0000000000000220-0x0000000000000227]
  Workqueue: fdad0000.npu drm_sched_run_job_work [gpu_sched]
  pc : rocket_job_run+0x234/0x838 [rocket]
  Call trace:
   rocket_job_run+0x234/0x838 [rocket]
   drm_sched_run_job_work+0x2cc/0xad8 [gpu_sched]
   process_one_work+0x640/0x14f0

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  Workqueue: rocket-reset-2 drm_sched_job_timedout [gpu_sched]
  pc : rocket_job_timedout+0xf0/0x1e0 [rocket]
  Call trace:
   rocket_job_timedout+0xf0/0x1e0 [rocket]
   drm_sched_job_timedout+0x188/0x6a0 [gpu_sched]

Both are the third core: the workqueue names are its device and its
core->index, and it was left at slot 2 while num_cores had dropped to 2.

Search all the slots that were allocated, the way find_core_for_dev() now
does. A core that is still bound is then found, and the two callers get
the pointer they already assume they have.

This does not make unbinding one core out of several safe. An open client
keeps an entity pointing at the scheduler of the core that went away:
drm_sched reports it as not ready for every job that lands on it, and the
client waits in dma_fence_default_wait for a fence that will never signal.
Stopping the NULL dereference is what belongs in a fix; the rest wants
more thought.

Reported-by: Sidong Yang <sidong.yang@furiosa.ai>
Closes: https://lore.kernel.org/dri-devel/apwUewaRnoTNXHCt@rock-5b-plus/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/rocket_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 3141f210fcd1b..a6c24dfe0563a 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -283,7 +283,7 @@ static struct rocket_core *sched_to_core(struct rocket_device *rdev,
 {
 	unsigned int core;
 
-	for (core = 0; core < rdev->num_cores; core++) {
+	for (core = 0; core < rdev->max_cores; core++) {
 		if (&rdev->cores[core].sched == sched)
 			return &rdev->cores[core];
 	}

base-commit: a9f09b5ea0c3db1e2d4c0f8d3ebdd612d8aa0366
prerequisite-patch-id: 519bcdfdde80d902309c8346f749ebc4bb6b29c0
-- 
2.43.0

