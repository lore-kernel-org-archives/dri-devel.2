Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3DEC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B08410E639;
	Tue, 22 Sep 2026 08:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jWhYfh1X";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F4A10E61F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:29 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e82ea30faso2294725e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064088; x=1790668888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qmb5ZYsqks7WEIdeRWH6smgklDya3V2PeA5rJDQKGQU=;
 b=jWhYfh1XuNAitFvWf/XODS7XpjT7s8xSIhvJ+xLd6xigjQJlxyn4Gsdncs6q0ANbZb
 RJJ/edgJ/GQ3gdqYmaAk96n0ePZwNVblFrONL/oVz1Hp2klx460tPZL+SDsjd8CxItX4
 7hGXY6WHDC55pmsuLFPlqXE4ipW7cmZZVtp3zV7QNuS44BNTX7zIhgBp0sHsXVzkTy06
 ep96gPmWzOTX3AmHIW47cX2Z1gpbrcihxVr8Y/XrNOorOpkKdl4+ef1c5sdwKe/4mypG
 DNs26OP7AGgVdKVDcdpfRtmRvT+bqMs6cz6QJHG0WfnIOw3jXrvA2A4MBqlAah/BKobW
 15nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064088; x=1790668888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qmb5ZYsqks7WEIdeRWH6smgklDya3V2PeA5rJDQKGQU=;
 b=E2xTy+c3QtQRdesjKFh28fRvXJvM4u3sCw7b2e8nQKPZOvS0Pm6n0ATJxR/ZOqFfpt
 KZMligCGHseBmhseBjA8H2RcLCCqbdMlIcHEVidSWmHLwx4FudraUvoMT71/xumSGHsR
 xncMEI6efPLjDSblhPq6Px2X4hupWw1NTOLLeL8DWRJLfq42yEQiaYLpsJJtZpwHQtuw
 Rm15IbH7HEfGuJ608o1VI0hT8T32JNQnqtt4RlYLsQhEpqLq6JWB0bK6QFSCezlt2/Jp
 TzNG48hV8ycGrxYXMKouTgDx/YVod+/3ZgkpBER/IjHFGWRbTSX7Hayh48S2ayu3lVMB
 Rplg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmOYmPN4s+TvverrteD6xeRE32Njmp2TcpCZZNBu3SoeQa3RmCkOWUlXOpIPGI0G++763JI7yYmD8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lq7NPH5bVLIlmApeKCDx8p9IQq3Zes/s3ieTok9dCQAOfp9q1k
 /mFUWKeSBb1IlTYwkx2jcPJ1RVqVMlXo7le8WDvbDSFphMlHR3+HbYRp
X-Gm-Gg: AYBFou0PXk8fHiykcZ2rmCYQy3/PR0p6y7OTYRbE/SW3USwryfQdwCiMB67Bj2T8Zoa
 IvJjz1iSJeQsGbBQOgIVuPt7kouV1BAJj6a/LyVZtRF6k5zIVwTthI5+AjuHk++mqWNBfRM7vEl
 oO8cFF6X7P+fCDFKWfMr2trZDpaxvRvIX4Yt2xuVNlkGLfnJa0uo5xRgiQMYb+WtHhga8pO+x0P
 Hk6ULNWtZOOIUFhbrfozi2vp6T0tBljJqvZIBHIxN5AyTF47McQaGh1TziG8me4SyNxoW1b4X1o
 yvF05ktp7J5R4WTDDnmuaRwrVJ6jof5Xdd3YgGTVMUJyJAIlectiyIdIbvqwRBTSULa/P+EMdT0
 4a8cHqsD7/1CcIkUImHQBvygVMqyK4kJneYU6GsIz0gTmYUW/FtFHawJsRckMHhlLHPG7mhcyew
 A13a/1LtNSkpwtYJHRzQsQuhWWiu5+wOew4yRn2WBp2k9B0FfrjyFBQ9PDJJnQgdEOreIzXjL5E
 10tPgwrpE+97jy7ToXT7dP0bjeDlz1TTmo8TN6esUfOfaIm5xbjk1T7HjfNEO10Gz3k3cOSFGEl
 7dY=
X-Received: by 2002:a05:600c:354e:b0:49e:479b:c13b with SMTP id
 5b1f17b1804b1-49fc7dff668mr165624765e9.1.1790064085766; 
 Tue, 22 Sep 2026 01:01:25 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:25 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 01/11] accel/rocket: search every core slot when a core is
 removed
Date: Tue, 22 Sep 2026 10:01:04 +0200
Message-ID: <20260922080114.44662-2-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
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

This does not make unbinding a single core out of several work: probe
still takes num_cores as the slot to fill, and rocket_open() still
reaches for cores[0] whether or not anything is there. The fourth patch
takes care of both.

Found by unbinding and rebinding all three cores on an Orange Pi 5 Plus.
With this applied the cores land in slots 0, 1 and 2 every time, whichever
order they are bound in, and the shared supply goes back to a single user
after each round.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Jiaxing Hu <gahing@gahingwoo.com> # RK3576, two cores
Tested-by: Sidong Yang <sidong.yang@furiosa.ai> # RK3588, 3 cores
---
Two paragraphs changed from the standalone posting, which this series
supersedes: the one on unbinding a single core now points at patch 4
instead of saying what is left, and the round counts are dropped from
the last one. Posting:
https://lore.kernel.org/r/20260904125936.26234-1-royalnet026@gmail.com
The two Tested-by tags are from that thread. The round counts were
taken on a kernel that carried the use-after-free fixed in 8/11; they
were re-measured with the whole series applied, see the notes on patch
4 and the cover letter. The single-core unbind and rocket_open() cases
in that paragraph are 2/2 of the lifecycle series, now rebased into
this one as patch 4:
https://lore.kernel.org/r/20260731064933.12548-3-royalnet026@gmail.com

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

