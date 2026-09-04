Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E7FC79F89
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69A810E54F;
	Fri,  4 Sep 2026 13:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETjtW/BT";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6F710F90E
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:09:35 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49b96433ca3so328375e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788527374; x=1789132174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G+f52AKxDAlw/HpKk7FcOocDLK6B8oOeUPjxL8dkr0A=;
 b=ETjtW/BT77Z8ev/ZZn+iFk2NohdHPlZPaIlYyEWDYCOhkpAkFp94etjoSSEpu8p3zM
 EDI1bm2soVDDBAAGoYsmCgn+3fa29/biHnht+bZ/WxVseBMqis2TvmoEW9IrIXk7uroD
 m/0dUirCCSbqnVfVEAXg9TvmbTjwtBbPDu+6kYKsTxz5EJ83Ve1h6HBfq1Puktv3+U/1
 fnUVcFGHA29p175PLwDk9KYzvqBFowc/Idm03GY9a8A+WTlTNY3ZXY70EnjechNHCKTJ
 KnHh8oMmeyh/68zogd6Tjf8zIeQppFQFmXUj4svmttdGq6otzR0JX7xq0db88JE6okYh
 x6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527374; x=1789132174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G+f52AKxDAlw/HpKk7FcOocDLK6B8oOeUPjxL8dkr0A=;
 b=FYO0E4OZqDlOwZtEh+M3UPKpQ7ltl+VAm6GOSZmUcz4piSRVQi/zd0jRa+dXLepk8Z
 5kaNsRsr3muAu/updmsVabi5XuzAd8XqShGKD+0qNegiV9dQsIdkuyTiJio3yMf37CJB
 aNsQwap950K1PBcICYCKJr0nQAppF5PRfpGXtE/PGzm9EWtWLy/0ffnFz7UaE9fJI72w
 A6J8xTVzJoIdL/ksl3wL321WRKlG/Q1zlFjyOw4hmlmU0GA0nZDuFC7bl6+tUtuTXTuP
 HbTF/7VruGZ3NQ6HGj1z6oAVtvMbtoh/duA6QmTODppf/DtVJ2/ilo8lFSSslL4MTESK
 EzrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2xQrysl7ietrvsVkUJuSEaamr2cr7dJe6+MFGOxiGbJ1iwh7AOhYI2bulk+WGYJl3P/j86gvz5SM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lS3V+LYNEUKPd3VyuA51oBodF3yWDmgeA3xOaMA7iXoHoWumLr
 cWNPc0Ha8/eS48uXK0Zq9TGXGUBhFje9bGfVE9D26Ktc1tDW+b8Kq+ZC
X-Gm-Gg: AYBFou03jTHsSu/lMED+kDraKLpZwo3nc6hrHXJNRIEzlxXKJ2GUp4MqdKZUtEOxwCf
 hmVNpO1Q4wE9S57n1JB30fLtHLwmnzNvKw7bCQoUIGG4Z7wrTMJnPsj6D4hSdVd/Nfj7oOM2J32
 3gaaDsGk8xoP0+GXUbb0iYKcCFD1LEgMu/ifit8auJTM+Frr476rYHIsqRQJisXwMIS5h+GnewW
 oP9YCl3bGrNW5fXsY9r98fbPLDrJ/Jrr6bJyla9wGgOaa2z3HDLW0W6ZGqEiEY6n/bI11rPxIcq
 mMMWdCDT16lEFu5V5r/M++wOsvEISNq8Ppt1Lxkd6UrB6Wb3x8iOdEYrJxbRbz5zQOEoXSG+uxj
 RmJEET+DakL0/SzhrQmGd0qSINvviXSzz7mspq5kaQFnMnjoTzRBMHuNT2H7qu8g9m2A0Nwwql9
 n+HtKwfLrTcJac2S3JbPn9kO/1hsKZpfM0ihMEAEUUW7dtN7h+SrYiZzOLKCM9fDak8T5cT68nP
 lroBSidLQC/SrX3vAljM8vkoaaUkMFip+5tld5IKaWZww1zUeRA5OxhG1/5kv/7j4Q4BKlMJeAq
 olUx
X-Received: by 2002:a05:600c:a40e:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49cf9b8baffmr34000785e9.2.1788527373810; 
 Fri, 04 Sep 2026 06:09:33 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135575435e9.3.2026.09.04.06.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:09:33 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 6/7] accel/rocket: register a devfreq cooling device
Date: Fri,  4 Sep 2026 15:08:57 +0200
Message-ID: <20260904130858.27803-7-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904130858.27803-1-royalnet026@gmail.com>
References: <20260904130858.27803-1-royalnet026@gmail.com>
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

With devfreq driving the NPU clock, a thermal zone can now throttle the NPU
by capping that clock. Register the cooling device so a devicetree can bind
it to a zone.

The _em variant is used, not because there is an energy model today but so
that there will be one the day a power coefficient for this NPU is
measured. There is none now: the NPU node carries no
dynamic-power-coefficient, Rockchip does not publish one, and a made-up
number would be worse than no number. devfreq_cooling_em_register() logs
the missing model at debug level and registers the cooling device anyway,
so what this gets today is step-wise throttling with no power model for the
IPA governor to use. Measuring the coefficient is follow-up work.

Registration is allowed to fail. A kernel built without DEVFREQ_THERMAL
gets a stub that returns an error, and losing throttling is not a reason to
refuse to drive the NPU at all, so the failure is logged and probe carries
on. The cooling device is unregistered by hand before the devfreq device it
is attached to goes away.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/rocket_devfreq.c | 24 ++++++++++++++++++++++++
 drivers/accel/rocket/rocket_devfreq.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/accel/rocket/rocket_devfreq.c b/drivers/accel/rocket/rocket_devfreq.c
index 9d923a0b6ea30..86bc34819a187 100644
--- a/drivers/accel/rocket/rocket_devfreq.c
+++ b/drivers/accel/rocket/rocket_devfreq.c
@@ -3,6 +3,7 @@
 
 #include <linux/clk.h>
 #include <linux/devfreq.h>
+#include <linux/devfreq_cooling.h>
 #include <linux/ktime.h>
 #include <linux/minmax.h>
 #include <linux/of.h>
@@ -404,6 +405,24 @@ int rocket_devfreq_init(struct rocket_device *rdev)
 		goto err_remove_table;
 	}
 
+	/*
+	 * Thermal throttling is optional, so a kernel built without
+	 * DEVFREQ_THERMAL keeps a working NPU rather than a failed probe.
+	 *
+	 * The _em variant is used so that the driver is ready for an energy
+	 * model the day a power coefficient for this NPU is measured. There is
+	 * none today: the NPU node has no dynamic-power-coefficient, the vendor
+	 * does not publish one, and inventing a number would be worse than
+	 * having none. Without it the EM registration inside is skipped and
+	 * throttling is step-wise, with no power model for IPA to use.
+	 */
+	rdevfreq->cooling = devfreq_cooling_em_register(rdevfreq->devfreq, NULL);
+	if (IS_ERR(rdevfreq->cooling)) {
+		dev_info(dev, "no devfreq cooling device (%pe), NPU will not be throttled\n",
+			 rdevfreq->cooling);
+		rdevfreq->cooling = NULL;
+	}
+
 	return 0;
 
 err_remove_table:
@@ -426,6 +445,11 @@ void rocket_devfreq_fini(struct rocket_device *rdev)
 
 	dev = rdevfreq->owner->dev;
 
+	if (rdevfreq->cooling) {
+		devfreq_cooling_unregister(rdevfreq->cooling);
+		rdevfreq->cooling = NULL;
+	}
+
 	devfreq_remove_device(rdevfreq->devfreq);
 	rdevfreq->devfreq = NULL;
 
diff --git a/drivers/accel/rocket/rocket_devfreq.h b/drivers/accel/rocket/rocket_devfreq.h
index bdf8e89ed3761..d5876d62a0b7c 100644
--- a/drivers/accel/rocket/rocket_devfreq.h
+++ b/drivers/accel/rocket/rocket_devfreq.h
@@ -10,9 +10,11 @@
 
 struct rocket_core;
 struct rocket_device;
+struct thermal_cooling_device;
 
 struct rocket_devfreq {
 	struct devfreq *devfreq;
+	struct thermal_cooling_device *cooling;
 	struct devfreq_simple_ondemand_data gov_data;
 
 	/*
-- 
2.43.0

