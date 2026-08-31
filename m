Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7CAC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144DD10EAFD;
	Mon, 31 Aug 2026 21:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hcNSbiqP";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290F010E1CE;
 Mon, 31 Aug 2026 21:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLNQZ1U4ySVSnMoWp4855Wu5AxP+LkcFrnVMzuz49fFaBvP4CToytv1RjGhwMR3MuTIjwMsSmoNPN7FHPvS9RwoVbvFIm+gI6DgXdAHtxdOdRGWGFtUrszX98YKr1SErdDz5ITdPUZglWljwvnxDDU8QL6x9z3qQxZ/nC5QJD8jm2dixL/C0P2fho6G4vbWZ4F148dNOeW9x75KQJvRXgejKogUyn5YkBXNPy/OuTRdNRc9e42VXY8qFSe3YoVKuowG9GIbXOWrHSjTu20BhUYvjhT3bs6Oeh9K+gzHFra3eQb9R3LZdaO4FzJRJ48dB7kbe3prA4TLAP1E0apNhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXUZPw4IjaV/Jl3g1rLVIpFoaFec43nRPQco+bmpwks=;
 b=e8oqYiz9iovzezIST8/HpByhm/d8BcU1Rg8vk/RsuMI7piVWEvldOvkNmkEoZqdtPxexg0SDZgQ5Yp7LJcm0BfyS6O9PudtTLsYy13OczPLo+2SaC/Ij+dONHaUAF6RrNIXhaLVd4jKpLYxp2f0BGXKxulF4q806FL+/LU5rZrlG3MSY8920qxW9lDLgkOH2YRFmg5DFQ1zGSV+kxh0e5RnC7vkso40N1Am7P74J128ptPV3esEUiyASemSAyA01p0ok0JWRs10UfwbwWQJhrvnqzyq/ztopcnh+0qDL8SFkzirr4NSvoBi3GyjcvhkegnlTqAPlMGzeAdmsugStAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXUZPw4IjaV/Jl3g1rLVIpFoaFec43nRPQco+bmpwks=;
 b=hcNSbiqPShBCHf7XUlTL403DfUZ6bvtN+MP/Q0k5Ey7hhpWe4KfkcHtRdHgbZ48cMGoUbWdkzlU6snEmvUVh2fg0539RkaItXX0HJFlunb/bKM8Dyn+RsqOmHSZWzvmUMZbY3Fi2CNJ5TRRfaISv+9MRYmVau6nuLJTTO9rG3SY=
Received: from BN0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:e4::11)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:05:51 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::89) by BN0PR02CA0006.outlook.office365.com
 (2603:10b6:408:e4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:05:51 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:05:49 -0500
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
Subject: [PATCH v7 01/12] Revert "backlight: Remove notifier"
Date: Mon, 31 Aug 2026 16:05:20 -0500
Message-ID: <20260831210531.2334221-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831210531.2334221-1-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: bf08eeb6-2006-4074-ce08-08df07a3a34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KXctJJE6T4tSLSfzD55A1FV4a7C2ogQd2o/8diKpAzOCoPox5zCpXvB4zBE3K9dVQpqD4MmTh0YHvBCz9pGkNw25nqOHep6k8DcRFjQG4kYGMe9kCm9rXL6u+yxAHGzma2JFMLFMLyAOcRruPSZ5CimIlkiPnrN25HRHyvGsRXArMJ4VuA0wKAbDtd4yzULer0/tAA5VAkJSxIfKGLd8caQ/U4nRCjetd/6vSQhLw9Nc5mGjgbHSGqC/v2jokWyRPB3yLBfMXUzvWu/j4W6sennt9RmLJIKz0hZdv+qV5hQ/q1JNUaRhGrFz9z+/+z0qEV8rdBrNPOwX6GdCOud2bVb7CrmgfRaNYouGPh5l0K45FgARn3OYs12XMR9iCPqAruPZpVHkqJvnLeIwD8kwC0kXtUDfjR0rEVny5p94RaCQQovQPBNVMOvU8GhSD7f+8XvRpeJ8eyzU3CseaGQBqBRqU2Lfmousx2SgJDrsCxXZKcdOG7R+rO3DDE8dYhP09+UDaP61P1zheBroMAjoHZLjXSJXFomv1PyWXA5Z70RKq/ruty61ARnoP6NbXRfpu0TyUnqrLwiQaaMz4D7Hu/PnXe1RLU3Z7wJ2g2TT1YE2KCBNnoHxgvIxmz1GwD0HIQNdtQmbSa14+4z9ote/VV8Yw4xL3fAsSXkZwB2hkFn+mvWRqkBQoEhBN4k1BJhtDcQnRLHZDvfB08KSQTFsBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HNUWLkFUKWdFf2GwOZ1eMOibDh2OwP8mM9BmulaObrEzA4ke79iItf6pj0OFQ6LH8ZMbXKkzpv1hfkV1WD9kX+E10kSAAiDFRQatlKPKYbx0ZoDsTkp/RG2FfKsoZ26y6i3rANh/r0V1sGErVmRvglbvb9UcUTQNjPKt3YYTsCoRchTtsf7+5+JRfxnAJjRS83jNSu6gkrk1ti0csFLNhWGM/Xi0SWboU/+7/EEXFcn8vJHcQpTu2V18fMfy5r6wfi++iXJ0gDm/uyW2jISvBR4OKz0IF7smrXQCqdqhuTGWIJBMAftdBVUvUIB2ogYQrWMgpXbTd9p9jOAKtjE6CmcId9DoW8/9TOtfZvqrbMXLZOMhNOs4IPKkYoMDzTfEI8AxcdanHldflAmpCZLLMp3b/gqVB2FtQeJtWSVgiPiDyEUa6dQtvHpH2ceXulbp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:05:51.0369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf08eeb6-2006-4074-ce08-08df07a3a34e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
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

