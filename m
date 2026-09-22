Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415D0C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1756110E978;
	Tue, 22 Sep 2026 08:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUoaaOHy";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260EA10E61F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:41 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71974de4so2797625e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064099; x=1790668899; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUwmXn/jLJ9RJT7pjA9WmiefPpGzIu17sEQJkrs8eXE=;
 b=nUoaaOHyq0NCLKgi4qrHORfwUxZgs1Q8+3NKKel1NpB1+I/r6lZTv4EUi1x9X8zhJK
 DCWxClQXfeLJRZ3IObb1of9/m9yGRt9pRAo7b/FYJj7sUKpnzY4oLt7LVKsTJk7aIYzV
 3d9eepXDnRyxWlv3knaD2m1lviS/ERZcZo9Sy6L6D11fBA3bC754Fif6LDfoR5rBePcB
 7oiIkOI30ocLwfJqLmG++gBqr2eTmyLYTcBhQhuxO02pv+djFrk6c2BAxJUAmTsxzLwI
 ifBPlqx30O8UcyT4MPiUg6wDzw4R930ptlraC4sSCccRVuA8Z9u2fNUtBaI/SzkXQprY
 kFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064099; x=1790668899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUwmXn/jLJ9RJT7pjA9WmiefPpGzIu17sEQJkrs8eXE=;
 b=ePmXFHKmowtTAjHDg/GYFNtEjwGshfUF+nm/uYQ2tS3mrGXOHX8C1aiB6e4zfmiVs9
 08kipLOuMaWrKl/gbHtz9ereQvPwFM+srtX00HmkDU4U4q4KmVHRd7WoMUg2Gg3KqVdg
 811YnihC0Tfz5aGguclar4kDQDMZyXjnw7+p13Q1W/5MKdrwr2PK6pYc/IYbQq5hicCA
 Lgli5T+4LATYnGpaa8MMF206Lxek9XHGQGDmhdJcAqvoVWnQ0l7UFrXZEFRaYciXasDK
 GFYcZehfHQbVTqDYNaJJ/xBOO/XVjERlVT96RV8qjF9YMOFSytxq8LrrFJPdSUKLK6Hz
 5Rbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxevScqwJPLbSWa1Cg6ea4FkEcaJsIFAaV5gGrkvaQA9VzdJv9QcNYt1EefzUscjjU3XFBnCzDXqKQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lf/rGhlMHYFZb/JaljQvZsAr3uE8SgMyFai+6G4ScU/SWlj1pM
 egTVGd9rtCEtsNVjTKVCeEaVj+z9He8AT2NjtpwJrz25EB4LyChF7kMY
X-Gm-Gg: AYBFou2XlHzTAIkBJBvwcJ78909xPcfhBUP2ipJ+eN1BNBfeAbAynDqkwnaVghYc9ut
 /LQQ++meOQygySz7ojmoB6Gn1yiHehBHuNQ4FH59YWTn3TAKIPZNpgD5Yz56QCbVtkcg2SMJ8yg
 HfFb9RoQUd4TPjC29Qa/pXBY4PkMXxExYF/lPb5Crp77mGPaU7pUW0DRld4HeXId5ySoEXqfqmV
 4tXuv9Zupp4LpyB3OPniiG36BwortB7HR/Nbct9wkV+/7vuxf77lKs/1Cv+MCU/vahDIdVJU9JQ
 3ZKyYjdxovn8ecFe0LWVaUe9I1YGBKeGKVyeSEFLtsOrGgLuYhZJGV4Lf1aMv/LlXu1mKRb+6Oo
 H+CART1IAa79rvhCdDATVi0GUaATUDA77dLJKpD1nUGwiirO6+ZaPrDPnXO+zYKDNYyuFIn7dhq
 a2O60tR3dJLjgA2ahzVMn9Bo6t+fmlDlISGOZaX+sO3skt/cLfEfRT5MI6QGJRp4acRHuRslJkk
 1MnuOflvvrp7I5FnF8HDLmv9ulKfwO80+eYY2mbZAhFcx7M+rhOyyvLWzd1HSSHzBNp8LlIX/eF
 tx8=
X-Received: by 2002:a05:600c:a00a:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49fc7b83237mr163730805e9.0.1790064099450; 
 Tue, 22 Sep 2026 01:01:39 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:39 -0700 (PDT)
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
Subject: [PATCH v2 10/11] accel/rocket: register a devfreq cooling device
Date: Tue, 22 Sep 2026 10:01:13 +0200
Message-ID: <20260922080114.44662-11-royalnet026@gmail.com>
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

With devfreq driving the NPU clock, a thermal zone can now throttle the NPU
by capping that clock. Register the cooling device so a devicetree can bind
it to a zone.

The _em variant is used, not because there is an energy model today but so
that there will be one the day a power coefficient for this NPU is
measured. There is none now: the NPU core nodes carry no
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

Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v2: wording only, for the shared table.

 drivers/accel/rocket/rocket_devfreq.c | 25 +++++++++++++++++++++++++
 drivers/accel/rocket/rocket_devfreq.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/accel/rocket/rocket_devfreq.c b/drivers/accel/rocket/rocket_devfreq.c
index 871fa370eb432..c81887734de77 100644
--- a/drivers/accel/rocket/rocket_devfreq.c
+++ b/drivers/accel/rocket/rocket_devfreq.c
@@ -3,6 +3,7 @@
 
 #include <linux/clk.h>
 #include <linux/devfreq.h>
+#include <linux/devfreq_cooling.h>
 #include <linux/ktime.h>
 #include <linux/minmax.h>
 #include <linux/of.h>
@@ -446,6 +447,25 @@ int rocket_devfreq_init(struct rocket_device *rdev)
 		goto err_remove_table;
 	}
 
+	/*
+	 * Thermal throttling is optional, so a kernel built without
+	 * DEVFREQ_THERMAL keeps a working NPU rather than a failed probe.
+	 *
+	 * The _em variant is used so that the driver is ready for an energy
+	 * model the day a power coefficient for this NPU is measured. There is
+	 * none today: the NPU core nodes have no dynamic-power-coefficient,
+	 * the vendor does not publish one, and inventing a number would be
+	 * worse than having none. Without it the EM registration inside is
+	 * skipped and throttling is step-wise, with no power model for IPA to
+	 * use.
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
@@ -468,6 +488,11 @@ void rocket_devfreq_fini(struct rocket_device *rdev)
 
 	dev = rdevfreq->owner->dev;
 
+	if (rdevfreq->cooling) {
+		devfreq_cooling_unregister(rdevfreq->cooling);
+		rdevfreq->cooling = NULL;
+	}
+
 	devfreq_remove_device(rdevfreq->devfreq);
 	rdevfreq->devfreq = NULL;
 
diff --git a/drivers/accel/rocket/rocket_devfreq.h b/drivers/accel/rocket/rocket_devfreq.h
index 65a9de6d37389..26a3749078b9f 100644
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

