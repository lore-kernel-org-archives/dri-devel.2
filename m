Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97052CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BB0113090;
	Mon,  1 Jun 2026 09:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nclO3RPp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D47F113089;
 Mon,  1 Jun 2026 09:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQ0q5dfcjaxdukmrbZFdwmFkYsF8uV8kNkdgsV7Q+L+KVgUK2EIDeOGr3gw0xcZKMJxc2OyJjuqApPDzIxazvHXVYRwEK8TK8qBZ95VwZdDhMvN9bCgftfMjyoQMEHa+LB/X87gnyfhLnF9/azzOmsiKYNxeozHG7J8Gac+RdJcwcBNVI1iiWSSe+luqz1hhsU+lcGuzx54P6KIHhL+2RvZFuXCm2T2YShW1X5n9EoHlsY5953IaBtBMhlF+WBgqQpNGGVm17boqucJlCiU9zCkfoGZLhy4qUBga+6DQ1Bnz9Y06vSHfosP+HKMaqDrPMH7xTjldpEdO0cQuVTv1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL0ua0svvp6pWV91cJ8QKIMUQCFNHBbZxpoKpaDT5dE=;
 b=hVJxSu7f6ZL6yTQkMvTy77QntxzNKztidIL35+Gk1hPYxDBo++7rBFUYQOHb3ADX0jFeJPKk26KAPRY0LNb72oTfe+bXjLgknzX6yr8DoR91fUlI762J4qW8EscQKLnSSEBDV6ND9W9B8gPlgLTVkQGx6eFy5KQdAIarlnYFSmvUmCs2yo1D2xuFY9Mksx+do4z164foPhWPChivJpm5aL+w9owKGlzvY+uJ6LyekUveNP57xnxa8XJag2CYZZIz/JVA/EZ+GdfIt5FICNxYKq+5B1VX/5zvpRRQUS2PObvqNC1szVFpmIr3dKR9FiBI/I3rAl7xKlAV+TiLxWZtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL0ua0svvp6pWV91cJ8QKIMUQCFNHBbZxpoKpaDT5dE=;
 b=nclO3RPpoCYyMGzkp5xQz1vFcp29z4odDw3srnj89gimK04RvV5cxlfjhTYMXTRi9LcxUnwMHZefb5a+9scHq3n8pBoSENDkl9fVxD4lwbJbG/sjhadNeut2DxFeICC1Me9ZXPZLKsxZOoSTrZcXT88uZND+JRXMJk+Wkmc0XE4=
Received: from CY5PR19CA0105.namprd19.prod.outlook.com (2603:10b6:930:83::18)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 09:32:31 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:930:83:cafe::88) by CY5PR19CA0105.outlook.office365.com
 (2603:10b6:930:83::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 09:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 09:32:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 04:32:30 -0500
Received: from yocto.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 04:32:28 -0500
From: Kunal Zodape <kunal.devanandzodape@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rahul Kumar <Rahul.Kumar1@amd.com>, Prateek Gupta
 <Prateek1.Gupta@amd.com>, Kunal Zodape <kunal.devanandzodape@amd.com>
Subject: [PATCH] drm/amdgpu: use ACK polling for page-write completion
Date: Mon, 1 Jun 2026 09:32:26 +0000
Message-ID: <20260601093226.1255621-1-kunal.devanandzodape@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c64ac72-2972-4d1c-fdfc-08debfc0b43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hxYupnWlGfEBlLAFQh+EJT0N8ohXONmLeEYS15mnbMUh98dzi2V43Zj6Yji93zQPsI+XgPtTK12K7soT6GVdJ3M81AUuQbIM8NL8/ym8K3qmyxNl/UfLrviOYHOy9j+ScRNcbXY2jatv6/8PEledGJuH5+7z66TSezUqX53G1FBuys8Az1ZtEHmBbLvAgyWOBC2ZPDVYoeY5TcJ3OHhtKb0Fb1muE+MBHQJWdtVJvol+69CuS4NhLhFSmGWgpF2ZXRkhBT28IgcolUnNj6H4Duac6fgaTEEjff8kqcqRVJSTs4BNL1MPAeFJ108Q0gsDnDVHIJlMaAFFKNoqZjciOoYCElIYxuEKtqVr2POUVP2Kf5gmGTzh06Dugjm85AChinAN1XpZFgSL/MwC6sZvGc/PKblDK+kqGlU5ZO9evGgor25p9Qy2nyck0jpnwfyDPpx2Q8T3aa2zLBRBotiRepZaGABiwlkl5LHSkiflNiGvjBT8gM14F9fQGnSE4i2tgcKP3ZVzxfQ7s/FVxTXfKF9eBByiZ3ZUqBefsX+qODDARXZ+ro0Fe4+ESg1IVaX26Sy31HLxnkgLqvNVKqVN5fYceFN1YgzDLMLSa85vqKsR2t1i7h1JhLtP6W6NOkIUcJuKOwAY8gSk+P2KCq7cxmJLObDs8q8TfaEe0/u7I0X/72HvogEuHbbGw72BSRpegTPpBaWe7lYXZaHM+Yd+WbB9mMtcAekbIyGiH1o1hJg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mt4UMu8hYbyFswUtIGcYblNj3+lgnmaCNc0jXnHOQrHKv1zaBAu8FBWnQQ0C2fhrDACkXkXbPSo5D0ybXS+yx1Bg7ZX+gUgLDQTQCwmIC7oRMynATL5MBl/q9fO0Z2p6geYdMDFa7723CPhTE9KZ2NO78KtpHGBjUg4D99kGOH303bwmWDfiyEzGO84PR9PcdsGZu3cxnkjvzFM7I2s4BcppnMQAAc5dFj32w/+eOHteA/wK/Djqd+WDW5uIkfp6/7j4o8skfPMVJ2de6IUh5PL1LsuAcq8/3WWusmxCo1dgrozdEuGH4i2EhZAHnbzuJ8jj2Fhup7cGMLIk0lwmvZ0G8cYvAEv/8ghRQypsXYoxaDY0YkK6WYC6KN3G9KzTVGDmZY8svtqSLIu3ohsDWJwOJmIcVQDS8wR9bamsyLi+Kx+cJPPnzTRfiEzSkfLm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:32:31.1320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c64ac72-2972-4d1c-fdfc-08debfc0b43b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

The EEPROM write path currently waits a fixed 10 ms after each page
write to cover the maximum write-cycle time.

Replace the fixed delay with ACK polling so the driver can continue as
soon as the EEPROM finishes its internal write cycle. Since the SMU I2C
adapter used for these EEPROM accesses does not support zero-length
transfers, poll readiness with an offset-only dummy write.

Keep the existing 10 ms timeout as the upper bound for the polling loop.

Tested on MI200 (ALDEBARAN) with ras_eeprom_reset confirming clean
write/read-back with no I2C errors.

Signed-off-by: Kunal Zodape <kunal.devanandzodape@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 28 +++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 8cd69836dd99..53be5a31c40c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -153,15 +153,27 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 			break;
 
 		if (!read) {
-			/* According to EEPROM specs the length of the
-			 * self-writing cycle, tWR (tW), is 10 ms.
-			 *
-			 * TODO: Use polling on ACK, aka Acknowledge
-			 * Polling, to minimize waiting for the
-			 * internal write cycle to complete, as it is
-			 * usually smaller than tWR (tW).
+			ktime_t timeout = ktime_add_ms(ktime_get(), 10);
+
+			/* Poll for ACK to detect when the self-timed
+			 * internal write cycle has completed, as per
+			 * Acknowledge Polling described in the AT24CM02
+			 * datasheet, Section 7.4. The SMU I2C adapter
+			 * used by these EEPROM paths does not support
+			 * zero-length messages, so use an offset-only
+			 * dummy write to probe for the ACK. The address
+			 * pointer update is harmless because each real
+			 * transfer reprograms it before use.
 			 */
-			msleep(10);
+			do {
+				r = i2c_transfer(i2c_adap, &msgs[0], 1);
+				if (r == 1)
+					break;
+				usleep_range(100, 200);
+			} while (ktime_before(ktime_get(), timeout));
+
+			if (r != 1)
+				break;
 		}
 	}
 
-- 
2.17.1

