Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAABDC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25BA410E9A4;
	Tue,  8 Sep 2026 04:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rOO/h4vl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA5610E990;
 Tue,  8 Sep 2026 04:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaMBGfLc0aqSOfykMrg/NrVkoq5R/9dcmpZCh6TqKNfAo4f7x81UnB9p0iz3CRIGCoTeexmJVmneH6bxXgfo0BTrcSswa3WCBk78nWF9NpnWfkzhbjfGuxSJN3So5szPtMXuEOirv/xvYfuCCRYjQS7AcSJvMqyKbGgKPbu9xNL3kERIzsSuUER2Gk2pC4vJGP66JGqLdHGPRTKcEA7jJ/h+pE/QJMG4VHfEW6usk1EYEsvRDhwLK0Yplin1qU5BE/0fI71JcenbnjMmcK58XVOwRnSbxap5FQDdnB/28vK2EmN9Mih4TPpxi1YmwkbhF/kX391AukbWQCL5lo8b+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXUZPw4IjaV/Jl3g1rLVIpFoaFec43nRPQco+bmpwks=;
 b=qFx9v92QlIvY42m+L3+tP9n5cZnrovb9Qs5b5ptdjzF0uhubJNMiFb6TlSPAWWG0Q1dfRln3l9oWhItYJYuRZ+2x884VhluRC7jBqfL+Icm+O5q2k7aVHhE8Hhjy+P4aX6k2oIQJaAX3vP4TyaSq7R9FtAvKpfrA62Pusx7hZhacprQk/QKRtNDBK/HuLAb7gBnUUmIJhnKm6QJwgxYDrIlWbVZLSwg9eAYcMJQenEveF7eweFc+GVXWxZdt7QUA6raF619qxA+Moqq8jQmctbiULygMYLCXYKCINXNY5aeITfLoP8pukBdQRM961EW5LonW+aqPZT8a/GLGPkAMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXUZPw4IjaV/Jl3g1rLVIpFoaFec43nRPQco+bmpwks=;
 b=rOO/h4vlNfyVfnNRW4S+Vjvqi0fMrVtEgmrgDkFZKq4uiKKEfR/aRIKYZqTQkQRp2v54oQGiLq6Pig6moEd8jneLBDgS9i2i1oB81KvqH23ibj+96UemNfhsyNM5mpaFuLAsgkoXw2V3cQYL+ZziE+urnsIdha/snDKBnveBK+o=
Received: from CY8PR12CA0048.namprd12.prod.outlook.com (2603:10b6:930:49::11)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 04:40:56 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::ae) by CY8PR12CA0048.outlook.office365.com
 (2603:10b6:930:49::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:40:56 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:40:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v8 01/14] Revert "backlight: Remove notifier"
Date: Mon, 7 Sep 2026 23:40:22 -0500
Message-ID: <20260908044035.62093-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908044035.62093-1-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cefb87-82cd-42a8-9d0d-08df0d635f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Jf2RGqxfx7d1stFKhcI5wSdfgJY+CtPDHJ/JDdTbdEVXSYrt7Qp/d08wYjeom5Yv9AH/xPrwv8bYoI+bBzCCw+gP4+0XyYIQsKK/Kg3uvKXkgEMWxXr5hlgnrqqNCCihsqPwTOa4C1aB44enA8842pbZ+pBS3KOoYra5gnl8SnhG5l/Gz6Bdj7u2Ez5/FG7YXcaBg9hY1R29YNeJVcDUAFpTqT3D4ZDbTTw9ln8WMBCv9n4bcVGdNDyrmsqEjJOgYIz0bMMSXM5KNQ7rOiOMEYgPSYRVPf8uZdSz7H4aJx1EGb/V7lci1myT1j9vz64gfhNhcXntGbk/o5W5QR9MXpt7Yvg3B2soqPoVstsKPpkyhoQgljoN9rRyj3sFn+m1oSIY4CTM+sDDMvSIkkDRS8iKL0ADKvH9Dfz6EQrTIIcpJWkdjj7MTUPMF/k+M9bgfgBYC1jOSKnVDoS+k1dE+ZkwM3lMxR0fwhsmOJOxZPCS/kVeQIli8+bZneYvoIsgVYcDY59Tjz/j/Vb++ymSo0foP7Udb7VmRFmWuM5KrmseiC3GbL/KFsGyVU8RXMvP2CNU+gjzxdnEB+jl46OfrRKhDR+RMmVcOLVW+miKkZfRzRmO4eQOuvUPLY8+2pCiRumI+1iPxvbBqEO5GKkmIvROFxe9T8voo8H6JO00PQbPMiksEOkc8VP56NvI98H9KINPRZlVSX1Eo8KrMF39MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cc7N0xv6YZGCTNusLeydAURUaaGt64ZGejiLKWfqi7qNQ6Ancxzc88baBvspnnoSoEUylcVgJJEfwGdc6fPyQdkvxzyeVyF2aQX+DtniKlv1O+0ZAnvJK0TkPjpzqUMPWhYeRGXhqQ8IYXn6c+8SN2+l74dSBn5YiI2Zy/6cPCOpY8OdoY8di1+q/9EZjp3Q5y50MFKrd7fHLh4Xt6c3HWkBpC63vzLHm81rL1h0nfysLDRntjLzwrc54nRjGRaPyAus7bv1Pp9hmN7Y2qad+omhZnb2n/RYzB8Oj2+yEl4slC+vtwtsYRGZza2eYp5mcb0fo5UljRKiqWX96qPwcM5W+CCaZiFoFRGq0DJMYflCtRN2Hmk+RFPCZK+BzXKabqjepfAvY0n/qsYKYP/t2jDcNrR1PPji0migcT9q8rkDCx/One9PwXT+htrpVAA5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:40:56.2377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cefb87-82cd-42a8-9d0d-08df0d635f64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525
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

This reverts commit 5461f3fd74a89757f95f351eb0bc26aafc2a2e91.
The backlight notifier support is needed in order to add backlight
control support into DRM connectors.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/video/backlight/backlight.c | 42 +++++++++++++++++++++++++++++
 include/linux/backlight.h           | 22 +++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index fc9bb303e8c5f..4401f6294ccc8 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -65,6 +65,7 @@
 
 static struct list_head backlight_dev_list;
 static struct mutex backlight_dev_list_mutex;
+static struct blocking_notifier_head backlight_notifier;
 
 static const char *const backlight_types[] = {
 	[BACKLIGHT_RAW] = "raw",
@@ -415,6 +416,9 @@ struct backlight_device *backlight_device_register(const char *name,
 	list_add(&new_bd->entry, &backlight_dev_list);
 	mutex_unlock(&backlight_dev_list_mutex);
 
+	blocking_notifier_call_chain(&backlight_notifier,
+				     BACKLIGHT_REGISTERED, new_bd);
+
 	return new_bd;
 }
 EXPORT_SYMBOL(backlight_device_register);
@@ -484,6 +488,9 @@ void backlight_device_unregister(struct backlight_device *bd)
 	mutex_unlock(&pmac_backlight_mutex);
 #endif
 
+	blocking_notifier_call_chain(&backlight_notifier,
+				     BACKLIGHT_UNREGISTERED, bd);
+
 	mutex_lock(&bd->ops_lock);
 	bd->ops = NULL;
 	mutex_unlock(&bd->ops_lock);
@@ -507,6 +514,40 @@ static int devm_backlight_device_match(struct device *dev, void *res,
 	return *r == data;
 }
 
+/**
+ * backlight_register_notifier - get notified of backlight (un)registration
+ * @nb: notifier block with the notifier to call on backlight (un)registration
+ *
+ * Register a notifier to get notified when backlight devices get registered
+ * or unregistered.
+ *
+ * RETURNS:
+ *
+ * 0 on success, otherwise a negative error code
+ */
+int backlight_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&backlight_notifier, nb);
+}
+EXPORT_SYMBOL(backlight_register_notifier);
+
+/**
+ * backlight_unregister_notifier - unregister a backlight notifier
+ * @nb: notifier block to unregister
+ *
+ * Unregister a notifier previously registered with
+ * backlight_register_notifier().
+ *
+ * RETURNS:
+ *
+ * 0 on success, otherwise a negative error code
+ */
+int backlight_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&backlight_notifier, nb);
+}
+EXPORT_SYMBOL(backlight_unregister_notifier);
+
 /**
  * devm_backlight_device_register - register a new backlight device
  * @dev: the device to register
@@ -674,6 +715,7 @@ static int __init backlight_class_init(void)
 
 	INIT_LIST_HEAD(&backlight_dev_list);
 	mutex_init(&backlight_dev_list_mutex);
+	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
 
 	return 0;
 }
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index f29a9ef1052e7..015183d129f96 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -13,6 +13,8 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+struct notifier_block;
+
 /**
  * enum backlight_update_reason - what method was used to update backlight
  *
@@ -64,6 +66,24 @@ enum backlight_type {
 	BACKLIGHT_TYPE_MAX,
 };
 
+/**
+ * enum backlight_notification - the type of notification
+ *
+ * The notifications that is used for notification sent to the receiver
+ * that registered notifications using backlight_register_notifier().
+ */
+enum backlight_notification {
+	/**
+	 * @BACKLIGHT_REGISTERED: The backlight device is registered.
+	 */
+	BACKLIGHT_REGISTERED,
+
+	/**
+	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
+	 */
+	BACKLIGHT_UNREGISTERED,
+};
+
 /** enum backlight_scale - the type of scale used for brightness values
  *
  * The type of scale used for brightness values.
@@ -388,6 +408,8 @@ void devm_backlight_device_unregister(struct device *dev,
 				      struct backlight_device *bd);
 void backlight_force_update(struct backlight_device *bd,
 			    enum backlight_update_reason reason);
+int backlight_register_notifier(struct notifier_block *nb);
+int backlight_unregister_notifier(struct notifier_block *nb);
 struct backlight_device *backlight_device_get_by_name(const char *name);
 struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
 int backlight_device_set_brightness(struct backlight_device *bd,
-- 
2.43.0

