Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FCCC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5F710E1B0;
	Fri,  4 Sep 2026 13:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cMBgerhh";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 823EE10F90E
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:59:59 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-499db1740e4so327175e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788526798; x=1789131598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G/WcwZhKQetLuVj0VCLbzfxuQncGS/yqg6oOZ6MnNyQ=;
 b=cMBgerhh5M++NVKxPT7IIDKJCFEuT/KZnDf8fGdNxT7o5YXCQ0vnTPFxXC4i+R2ufc
 I7p6hTWAKFMF9C6qsUtQzbhwzDfdE/QZ7dHqPbXcoMOfolSRUINR/B0aEC1TTEr48sPZ
 ErZksFT2mel6jtjMqObLhsK6o4GpRLffPLD4sGRh9L9DDMnKBoRnyTwqeXc6oDLp0yMs
 8SQ1ANsl6sVNW9bZQcx+Sdu/o6QzmKqgh4G2j7Kmp+6vaJHi3Fls2Hm+nUYnWT9zBJR4
 OTzSEm+n4PpdFe/a3FJRPlqam3kmXIurGDEvpdGgpYzgbKkyDfmESWHrcvK4tNm7Moaa
 XlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526798; x=1789131598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G/WcwZhKQetLuVj0VCLbzfxuQncGS/yqg6oOZ6MnNyQ=;
 b=hBe7UxTf8DsSJhPD48rf+FQBJDmoTPyk5/iczAy8xKSXhMGH8G1Lr5HEzSltmJJvLU
 Jc8VHTo1bChR9C4OV75u2dp5tP5zcOupK5WiK3DbwYRhlmqb8BdKAAbGf0uNPQANZVEw
 nGhUEm6grIUWP9cntINDz+xFNO7ITAv8f6AXwRT8iX3vxd6/F/Gu5iSHLlD50GJebO4W
 Hu811lZU1NYrHMHOnzZYG7Y9FCnoSpMz9eC8Si4ajC7NSEp/OwLI5oJmNPDSozlaU+jk
 Q+WUeRaU92/DID3O1NbYfxF6XTRA+a4nUvF9u6kjyY4c3udHNCj7w9P394LWdrKkOOsh
 mTzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvI1+VGnnK+lZcmzxKoBtXHCVH6GL2722vYuoElwU/o+SQ3e/CfdOXcf9gIz1jlsvraWdq9diTH/8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltC0qBC4QT4Vk6c2qxDC+8kFAstprF0DktrGbDriEv6jwKcl/O
 kgyxN7EtqVXaMD49xQY9thL6K8GGWG5JAR8Y9PjIJQrsu7WuE6LQWEPt0dyXUA==
X-Gm-Gg: AYBFou0QBqx5ow049L23eQgt7FJFY7RY7zmpxxxDkZxeuLJM7f2Ff7LkIM7dm0ZVhoi
 qgVTEFRSuKnywxM/3QNLby6bmBVU52h8na1PKOY/6zlnQhukT05WMbug6pFFUyVKFGUs2KqvvSH
 t4bLlm5aNErVCi4o6byz3g6xSmE2+6RlWf3RshKAkKtf7QRd+6dOAYfMh6MXk+/+Mxlg4CYwcPG
 y2Hp788RQVIOyjQ3PMCki/ORmD1csil9xyNWqgVz95INCAHFA+twomsRD6T4UBGkZiTHsUegRbt
 9OLQ5WFm8LMNeAU0H6kQOnYn9keRHfqG1QGwfvQpgl9wT/Ox7Hvqm2fWvCD399XG9O+OXNb7dsD
 eQzdPC49zeiwouRAxh6b1BXGJZ1xrID/uxO1o+BYHtvbrNiJenoeVKiaXm/8tdqlOK3qz1uSXTd
 l+jgtshyupDOH/IPENtwWL3I5+cHC/0zynZXP9t9CGj3qDHkoIGCmHX0AhDWPJTHQMpNjclRl4O
 eicoVzLANz+5YYZ7KgSXElz/AFTeswRjI+k/d+ehAV1b9r5fava8cLnuy2ZdqAFpP65Bw2DNdyB
 hwbG5HrJMKyatc0=
X-Received: by 2002:a05:600c:34c5:b0:499:cef6:104c with SMTP id
 5b1f17b1804b1-49cf823c012mr40540685e9.1.1788526797556; 
 Fri, 04 Sep 2026 05:59:57 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135287435e9.3.2026.09.04.05.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:59:56 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jiaxing Hu <gahing@gahingwoo.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH] accel/rocket: search every core slot when a core is removed
Date: Fri,  4 Sep 2026 14:59:36 +0200
Message-ID: <20260904125936.26234-1-royalnet026@gmail.com>
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

rocket_remove() decrements rdev->num_cores for each core it removes,
while find_core_for_dev() searches slots 0 to num_cores - 1. Unbinding
the cores in the order they were bound therefore loses the last one: by
the time it is removed the search range has already shrunk past its
slot, so find_core_for_dev() returns -1 and rocket_remove() gives up
without doing anything.

num_cores never reaches zero, rocket_device_fini() never runs, and the
file-scoped rdev keeps pointing at a device that is going away. Binding
the cores again starts from that stale count, because rocket_probe()
takes rdev->num_cores as the slot to fill. On an RK3588, which describes
three cores, the second round lands on slots 1, 2 and 3 while rdev->cores
was allocated with room for three:

  rocket fdab0000.npu: Rockchip NPU core 1 version: 1179210309
  rocket fdac0000.npu: Rockchip NPU core 2 version: 1179210309
  rocket fdad0000.npu: Rockchip NPU core 3 version: 1179210309

The write to rdev->cores[3] is past the end of the array.

Nothing in tree reads the core array often enough to notice, so the
overrun is silent today. It turned up while testing a devfreq series on
top of this, where a worker walks every core a few times a second, and
UBSAN caught the first bool it read out of the overrun entry:

  UBSAN: invalid-load in drivers/accel/rocket/rocket_devfreq.c:47:10
  load of value 5 is not a valid value for type '_Bool'
  Workqueue: devfreq_wq devfreq_monitor

Record how many slots were allocated and search all of them. Every core
is then found on removal, num_cores reaches zero, the device is torn down
and a later bind starts from a clean rdev.

This does not make unbinding a single core out of several work. probe
still takes num_cores as the slot to fill, so rebinding one core while
its siblings stay bound would write over a slot that is already in use,
and rocket_open() still reaches for cores[0] whether or not anything is
there. Both of those want more thought than a fix should carry.

Found by unbinding and rebinding all three cores on an Orange Pi 5 Plus.
With this applied, 25 unbind/rebind rounds and 5 module unload/reload
rounds run clean there: the cores land in slots 0, 1 and 2 every time,
whichever order they are bound in, and the shared supply goes back to a
single user after each round.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/rocket_device.c | 2 ++
 drivers/accel/rocket/rocket_device.h | 1 +
 drivers/accel/rocket/rocket_drv.c    | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1e72c5f..efd004194c1af 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -31,6 +31,8 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 		if (of_device_is_available(core_node))
 			num_cores++;
 
+	rdev->max_cores = num_cores;
+
 	rdev->cores = devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KERNEL);
 	if (!rdev->cores)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index ce662abc01d3d..c62d567010696 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -19,6 +19,7 @@ struct rocket_device {
 
 	struct rocket_core *cores;
 	unsigned int num_cores;
+	unsigned int max_cores;
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883e..2bcfe4ab3c68f 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -223,7 +223,7 @@ static int find_core_for_dev(struct device *dev)
 {
 	struct rocket_device *rdev = dev_get_drvdata(dev);
 
-	for (unsigned int core = 0; core < rdev->num_cores; core++) {
+	for (unsigned int core = 0; core < rdev->max_cores; core++) {
 		if (dev == rdev->cores[core].dev)
 			return core;
 	}
-- 
2.43.0

