Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54797FF885D
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FF110F6DA;
	Fri, 24 Apr 2026 22:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WXY0yWo7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0209E10F6CF;
 Fri, 24 Apr 2026 22:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5QdfvPRQt6FuYQIrq7rENuwvOJqHmxjVp9kUXPFOwI/aCAISUOh+57LQnp/ZNmsF83pKfrTLnqh3cKxtINVdwKKkHq9OyNQQM7pGbe+jZPmLM3VdX6ds3arKpNJQG1zsRZSpFF9PHA5juNvQQOYCg0f+8LDVR5jFRIDtXLva9Vx8W0SLNA7hiAiU3iQPby2YE7qVzzOsykxx96VswamvuTcLxGvxPGcSFMfvH6Rl8jFKzyC7I9xn0MTbZa05YP/XiBZrJL4lOC60FnpZ8co+l+jl94Nb5aO8vh6GYgqgn4LBDYhCjniJkmf4LwJEkNiFk7uUKHqWmoB/AXDzHqSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm4BTx3641M/2FY2vgWdNDoVM77S6ucHirgD/DVX9ig=;
 b=vfnYgZrgXgXqoI4SKPbw/OId6I+AvSEjuKKhqtYpLK19B/VL0Rk4GRqLcZmwi5f27bkPhBHrabXngEgeBQsT/HKlzSGVQ57Qsk29Lmu3RUcDpaHuLmCJ5WOtWsJ3xYGTJMo9qxpXY9gNHpBE350y2vhZHcL1n30KglAVQgrgpP7Vj5zUNh3Zt7Al4CkK9jaD1kIQA77ATsWtoxK5uDxnhqcW4bOsq+fYnAykQvdx+hBxpC3wywvoRgAq4RmSi0r4CQjWeOs83H/if3z85pQPerHNo70xK+hqVmh7Hr7UNyZ4LDLjAH/3x40PHH7l6zBfnfLlN1LAW9RjPumqIDkXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm4BTx3641M/2FY2vgWdNDoVM77S6ucHirgD/DVX9ig=;
 b=WXY0yWo7BQefLutjoTF+zcb/TqtRK+49Z+fmpJ+ze2sy9NKqH8p+wYB/R1zXOxoWfSQRASFqDMqdLVYRUWAcN96YtSHvZ0hk7pT5sDSThXC8Mxra5pYeREdVBK2DwmeuxZ05lFguIlFcIYE1+Cz3R066P3nNqXaxHjrXdOPoXgU=
Received: from CH5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:1f4::24)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 22:10:12 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::62) by CH5PR04CA0016.outlook.office365.com
 (2603:10b6:610:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Fri,
 24 Apr 2026 22:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:12 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v3 1/8] backlight: add kernel-internal backlight API
Date: Fri, 24 Apr 2026 17:09:46 -0500
Message-ID: <20260424220953.167058-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424220953.167058-1-mario.limonciello@amd.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d4fbef-f7c8-436c-b4e5-08dea24e419b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: E4TpsTunTBB/S0ixwlgsNHGWqTyfUVq0QPuE8dX/lsqx0hO6j1Jd/u8bwkiUeTL14kpT/mU6wIz++qzmyo/klP41bgP223os1DCemRgaTR7yKvo33GHgbPocswCF1/IfsCL6gznD2Xz72v+t2rnIHpuG3sGvegiabY9UaJgCwtt7qzs5ihM4HG+c7pCAs5Fqn6fAokaHzu+yUesJ72t0TB1ZrTpSJVpY+mqfI9X/CmbOro44HqhdkAuzg+Ykp6ar+2i/SOOwuA8CtrM54RDKdvf56FLw11FsTgThxPCczkmOF/xPAVM2keIx6j9NMhiRAeLXH8gsFy5krVoRdkRD1Q9MfKPMmfAZYg7W7sC/LshOK//2D01iBDYUwV5L+0nZWeQj7xRI7fcvebcolm1MpgpdLcFMJrBgd+mytgBwsjvZEUChdIBfgedPimDQRvOYbRLA+sSnC4CmOdfI9he7jf1uTIzMwT/GDS8waCHWzwW5IquahbBhTwNfA5Y8+9YJ8luWksSTLSIvJX68LIkLDXs9SexIK9JdM422nKR7xw5SjgwmCVd14Db9to3IUYrlWe67p5Tet2kUtvmvOvrITwL6kbH43OTDhoMMZmwe7vJgp6ZsUzqVKwEoTu6dSFx6P2nLFu9lnY57H0JFGD7Nz/sYFf/lBuRXZsUCgNHUBlHh6Xn7hVM5CvlNThpETb6fJn8KJ9ipJtYkxJwBamZy6FMiGtp0wSsYG35JI6KVO/NGKxxllt9BsfqyIqUmbRSmBs7GC0hPC/bwEGB5mIb/6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BEZLJwGOjDivhJM2IAebECZ1Vq+X34/CTZ6mtDZzBWtz1HBUXfe0bAy/37G1LntPrnaKdEFW5N0wJIqrvn5mEnms+1iX/qaxbAp+vafJPSo1aOvqliJiTzmIuFJLuK33GDycFsIk36qn4hN/ghMzglIZGviIRms23XIYzwzN1NcOc/NH+v4TbQebZsTntEOdd5rcrJDO5Si8bLJ8UwBfVLbq+RM9uqT5HpH55I9BobMCFXHNWwmVzAQ3Bpyne19oEE/wsATMjvJwLawY2c1tFyzbTBE558l1rzV9ZY1BBEkj8/fWib0HgdsqEpL+SCfTQXy5/0cNzTEiDb6OSL5FmvFZJ5s7ki+7DHZEX9219Ay1imsFIqXzyGOvrAqOHbU+CRREVgtYvZOwpsL3WE5xJSuS8BJxP3b0UfqwEBaCI8TNUMUJF+NtGLB76spHgOcg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:12.4749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d4fbef-f7c8-436c-b4e5-08dea24e419b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
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

From: David Herrmann <dh.herrmann@gmail.com>

So far backlights have only been controlled via sysfs. However, sysfs is
not a proper user-space API for runtime modifications, and never was
intended to provide such. The DRM drivers are now prepared to provide
such a backlight link so user-space can control backlight via DRM
connector properties. This allows us to employ the same access-management
we use for mode-setting.

This patch adds few kernel-internal backlight helpers so we can modify
backlights from within DRM.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

V2: Marta Lofstedt <marta.lofstedt@intel.com>
- rebase
- minor edit for checkpatch warning

Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>

V3: Mario Limonciello <mario.limonciello@amd.com>
 - rebase
 - Use guard(mutex)

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/video/backlight/backlight.c | 60 +++++++++++++++++++++++++++++
 include/linux/backlight.h           | 16 ++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index ab87a5e3dbf70..c3673bee6d9cf 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -513,6 +513,66 @@ static int devm_backlight_device_match(struct device *dev, void *res,
 	return *r == data;
 }
 
+/**
+ * backlight_device_lookup - find a backlight device
+ * @name: sysname of the backlight device
+ *
+ * @return Reference to the backlight device, NULL if not found.
+ *
+ * This searches through all registered backlight devices for a device with the
+ * given device name. In case none is found, NULL is returned, otherwise a
+ * new reference to the backlight device is returned. You must drop this
+ * reference via backlight_device_unref() once done.
+ * Note that the devices might get unregistered at any time. You need to lock
+ * around this lookup and inside of your backlight-notifier if you need to know
+ * when a device gets unregistered.
+ *
+ * This function can be safely called from IRQ context.
+ */
+struct backlight_device *backlight_device_lookup(const char *name)
+{
+	struct backlight_device *bd;
+	const char *t;
+
+	guard(mutex)(&backlight_dev_list_mutex);
+	list_for_each_entry(bd, &backlight_dev_list, entry) {
+		t = dev_name(&bd->dev);
+		if (t && !strcmp(t, name)) {
+			backlight_device_ref(bd);
+			return bd;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(backlight_device_lookup);
+
+/**
+ * backlight_set_brightness - set brightness on a backlight device
+ * @bd: backlight device to operate on
+ * @value: brightness value to set on the device
+ * @reason: backlight-change reason to use for notifications
+ *
+ * This is the in-kernel API equivalent of writing into the 'brightness' sysfs
+ * file. It calls into the underlying backlight driver to change the brightness
+ * value. The value is clamped according to device bounds.
+ * A uevent notification is sent with the reason set to @reason.
+ */
+void backlight_set_brightness(struct backlight_device *bd, unsigned int value,
+			      enum backlight_update_reason reason)
+{
+	guard(mutex)(&bd->ops_lock);
+	if (bd->ops) {
+		value = clamp(value, 0U,
+			      (unsigned int)bd->props.max_brightness);
+		dev_dbg(&bd->dev, "set brightness to %u\n", value);
+		bd->props.brightness = value;
+		backlight_update_status(bd);
+	}
+	backlight_generate_event(bd, reason);
+}
+EXPORT_SYMBOL_GPL(backlight_set_brightness);
+
 /**
  * backlight_register_notifier - get notified of backlight (un)registration
  * @nb: notifier block with the notifier to call on backlight (un)registration
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index d905173c7f73c..7e4fee65fddd9 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -429,6 +429,22 @@ static inline void backlight_notify_blank_all(struct device *display_dev,
 { }
 #endif
 
+struct backlight_device *backlight_device_lookup(const char *name);
+void backlight_set_brightness(struct backlight_device *bd, unsigned int value,
+			      enum backlight_update_reason reason);
+
+static inline void backlight_device_ref(struct backlight_device *bd)
+{
+	if (bd)
+		get_device(&bd->dev);
+}
+
+static inline void backlight_device_unref(struct backlight_device *bd)
+{
+	if (bd)
+		put_device(&bd->dev);
+}
+
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
 /**
-- 
2.43.0

