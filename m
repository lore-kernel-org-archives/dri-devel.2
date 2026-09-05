Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFE8C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C9310E1D3;
	Sat,  5 Sep 2026 13:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qCxDbWbk";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29ABC10E1D3
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 13:56:42 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482e1b429f7so69367f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788616600; x=1789221400; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qv5CI8QgjHSQGUAsYpHOyJ+UdzvD7BcP4G3r/lK7tFY=;
 b=qCxDbWbks1cdPpw0VeHey0D8aGzQhXU3B03xr7Bfu4+ZAOaTRYMzBP8HuZ+AwxVgNw
 bce/v4WIEoRLEU/tZBjzH6ePlDq4qNTheuANQg+tEDkETpyanvqXlzjbb4lzuEkbUahK
 vUnCIWGvSJixcV4FvhI1XpjJxV4ZJdQd1/bFwfL70ps5ZhnkwDuZa1oonJeh1EYqyMZi
 sQvhLVo7PrsSf7GEZDkCucsuH7/9KAK7g1+ngzEc3hTtVcMR9kmYe9/csIhiA18LIMM/
 kCw9BJh6H6GF48AdkP/dnonIsVbpKy+4FSfc/NXcuZSC98AYl5yKsYycqBAa8yhK4vMK
 4RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788616600; x=1789221400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qv5CI8QgjHSQGUAsYpHOyJ+UdzvD7BcP4G3r/lK7tFY=;
 b=oB7v1uRjeVjfUO2bqr1vkEwz8PuGHdOfarPhFLgoIZ6LTA6e2gBIkrGP9RCgOOmfIL
 jPjIyRWKDyXaloQwDx+cqI32m9StCQ9Dx1lnTSZiXzWaKpYzXjmJktNwib7I+eXZ6OTO
 rBWuOR9OQOhw7hxcVqMLpREMGtQrQdomM6kvk7iALb97g0WjN2bbNTb2Cv/sc40GvShY
 cmFtKrswsFZ1Jz4gn3VKv5rjIxMxbxVrpkcYjlEs/Zs9ptGwrRD8xrM/gZ+u+uBO1LCf
 1EM2K1AgkvywS+iTU8lo+45sx9dfQiRnoKvV0G2lp6HJFKYJZKPhwdhOkSvY7KkOupin
 d0Vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ1JnQ0p2q3piHc+RS8bnoy1OxdY5TNuuHu5IDUUl4Svucb3A1C8s4zwbgl64tRVGEKaWHieTGFNs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lu95mAHim/mfmPh7lxBPF2UZZD7tn8qE71O1ng4yFPL4dNOjy8
 IX7C00h14vuwl3SkKoDo025emVd/Kw9Sb2kMrb+I5rPNQwV9RU8IIvwg
X-Gm-Gg: AYBFou2oZZrM4YLcQwqaIJJXVUE/HTKJhaPZ2EM5ZmZRAdxVplYZ/WP4bN59LoPbKHF
 NecuJW6ELKjkU4op3wXeQthrK2kyE8ygPN/JQSiypPMfMdVReDjw9CnmPHv6j35+ccq+ib7zODZ
 /IMjKRf/pcbEf6pIDuurQMj2mvWLpiWLMKRhYtKk8b+FykjfX5hN6P8dmzR62AVOeGSKDzUG0b4
 TLj7whN5X/riIpb9brBViiZI8v4H1MPuvcIlcNPFdmoEHVl+ASA8MdsGSlOko0KjSr9ETLwjf8f
 3lfkv0phNMrM7qt77cSyirFDHOZ5/RF4LsnygGX9FjbKCF9avtPQdoTSImaKsv9e4NGG0udzIxc
 ZaBx4rA9SOHW05gbUzV5QvIij/w42Pi6yXPvlq5CXiC9+nMioIVJWtwGyvPLQqoQ57mFYK3ZyMC
 0nuMI8vzP32UPwmZgOcWYynCrWLjGzzhsiNyiaAr74vObtgHianvXLTCUsK6oTYjZhq7VI/Ocb4
 UA0jKYBkSN3APs6hcmKpjJxmCXHtB3zML3GrGYvh2xJcFvtO19Om2u1VbW5uoVHAqgu
X-Received: by 2002:a05:600c:c48f:b0:49b:9241:7ff0 with SMTP id
 5b1f17b1804b1-49d010c4f64mr47995125e9.0.1788616600147; 
 Sat, 05 Sep 2026 06:56:40 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B950E00B62CC1B9060BE3C4.dsl.pool.telekom.hu.
 [2001:4c4e:1b95:e00:b62c:c1b9:60b:e3c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm10523155f8f.11.2026.09.05.06.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 06:56:39 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jiaxing Hu <gahing@gahingwoo.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] accel/rocket: number the cores by devicetree position,
 not bind order
Date: Sat,  5 Sep 2026 15:56:12 +0200
Message-ID: <20260905135612.7324-1-royalnet026@gmail.com>
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

rocket_job_hw_submit() programs the S_POINTER registers of a core with an
extra bit derived from core->index, the way the vendor driver derives it
from the hardware number of the core. rocket_probe() sets core->index to
the slot the core takes in rdev->cores[], which is the order the cores
bind in.

The two agree only while the cores that bind are a prefix of the core
nodes in the devicetree, in devicetree order. Unbind them and bind them
back with a different core first, have one core's probe deferred behind a
sibling's, or disable a core other than the last one, and every task
submitted to a core whose slot is not its hardware number times out after
500 ms. The reset that follows does not help, and the inference finishes
with wrong output.

Observed on an Orange Pi 5 Plus, over all six bind orders of the three
cores: only the devicetree order ran clean. The other five produced 27 to
140 "NPU job timed out" within a single six-second inference, with a
bit-exact oracle rejecting the output, or throughput falling from 130 to
1.95 inferences per second. The timeouts land on the cores whose slot is
not their hardware number, in proportion to the tasks the scheduler hands
them, and in both directions of the mismatch.

Number the cores by their position among the core nodes in the devicetree
instead, which is what the hardware number is.

The wrong value has been assigned since the driver was added, but it only
reached the hardware once the extra bit was introduced, hence the Fixes
tag below.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/rocket_core.h |  5 +++++
 drivers/accel/rocket/rocket_drv.c  | 31 +++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca9..46ed8352a79d2 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -30,6 +30,11 @@
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	/*
+	 * Hardware number of the core: its position among the core nodes in
+	 * the devicetree. Not an index into rdev->cores[] - that slot is what
+	 * find_core_for_dev() returns.
+	 */
 	unsigned int index;
 
 	int irq;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883e..e2cde31443ffa 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -157,10 +157,39 @@ static const struct drm_driver rocket_drm_driver = {
 	.desc			= "rocket DRM",
 };
 
+/*
+ * The extra bit that rocket_job_hw_submit() sets in the S_POINTER registers
+ * is the hardware number of the core, which is its position among the core
+ * nodes in the devicetree: a disabled core keeps its number. The slot a core
+ * takes in rdev->cores[] is the order the cores happened to bind in, and the
+ * two only agree while the cores that bind are a prefix of those nodes, in
+ * devicetree order. Every task submitted to a core whose slot is not its
+ * hardware number then times out.
+ */
+static int rocket_core_hw_index(struct device *dev)
+{
+	struct device_node *np;
+	int index = 0;
+
+	for_each_matching_node(np, dev->driver->of_match_table) {
+		if (np == dev->of_node) {
+			of_node_put(np);
+			return index;
+		}
+		index++;
+	}
+
+	return -ENODEV;
+}
+
 static int rocket_probe(struct platform_device *pdev)
 {
+	int index = rocket_core_hw_index(&pdev->dev);
 	int ret;
 
+	if (index < 0)
+		return index;
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -176,7 +205,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
-	rdev->cores[core].index = core;
+	rdev->cores[core].index = index;
 
 	rdev->num_cores++;
 

base-commit: a9f09b5ea0c3db1e2d4c0f8d3ebdd612d8aa0366
-- 
2.43.0

