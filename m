Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20FCF9D0E7
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 226E510E00A;
	Tue, 14 Apr 2026 16:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AmEUIrua";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEB910E00A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtSKl39axp6y6FIBjSqWxnGtv/3zJV+QPEJJkpl36Ue7I6QQsoifeB+VgVhIIPYwjCg6aoeepsaY0t7YAzKAzCLs/j2abe/zKjyi9T4aufuh4rd9CynkzbXEvq6VqM4QbNRdVcgDWkvHHqkwwN+ALucBHki8ah5ZRjD6cSMiKJSctzGVF01hiSp3Vf+41pr2zHiMS72s7gl9yA5WtCAQnu5VvjBP+v/APkxkNN140dwcZUqEDBZJZgLG8w7JfBBWc5X06wQ90fiTwp26Dp/Ch08OdT77e0rwAMDHh+zlRZh/IN1Udsa3vPHXUnl8quN4qvG/gG+taylT8IRY+T3Lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ1ukwrE/1nPYmibEiJ5awcPcFjBbLKl+bXanDUBMRg=;
 b=ylwCP84QEhwqNiw0M8vpxH2O+DyWnah6rMsRaD8ZL2N4u41D1WgZ2U1bHvoHgxgjU/ndwrfzTlUPhiFr76jgJXkVTXDMNp+w9cQ4rSQzhCyaEjry+c/qbxJe0eB3OIeoGx+R4lpY/YuWQTJfcofILqjHgc9Di8NXgzXdJ/oqrizv2/+fXT1aasLGbrYcmZd2BW9g4+ChKIlgGm4CLYwPg486QCdWcRfmhTkMDmVzNOSdjtj8tU4Ocpf3Bnc95S0FFP4GfWmP1PhvZBWtSoti6v3UmGZWRiAYndmn8UBN1+XEyTkipU9XMju2oM9VQ1bZIccf/hZm+stPRfN5vifpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ1ukwrE/1nPYmibEiJ5awcPcFjBbLKl+bXanDUBMRg=;
 b=AmEUIruarQyVxy5Ph6KMrPRh5yZogD2SJq0Vqpjp/mT5szp+iwVFO7kLA6JLnKPWxPUWwpcuG3yj/AzWyz/ieL+KkYKkTlUy6oxx+7v6fFONFm6KOru9RrzHK5/6wa71eCN1lGwpd/ISa8lRomy/pwT1+bW5C2FyLqOLpC+SHfw=
Received: from BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Tue, 14 Apr
 2026 16:56:28 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::73) by BL0PR02CA0017.outlook.office365.com
 (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 16:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 16:56:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 11:56:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 09:56:26 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 11:56:26 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix fatal_error_info layout in firmware
 interface
Date: Tue, 14 Apr 2026 09:56:24 -0700
Message-ID: <20260414165625.788853-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7e53d8-80f3-4b99-aa12-08de9a46c4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: h7yIQjxkNt8Wr1YhprMntB7BB5lphRG7Hl3mOzn7txpWXnDk3qC9CwvgvJkCSNE67A+B9CTORfJrqZ9/DDijDNGYTXgIIlCJC3KsEAO4pKdIDz8mY/zjmZGI2jIn3e5XlczxVgzZaJHn/EXmxgVL7eUbjS3t5JwHcGD/TH710AOuAUeOpV8k2CdpGK6O8tgW9MevHpMSOFTknRpPYgTCO4NglqYMU1LOfEjSvZ6h7BI2wUd6zDnfN0G6iAuxxfTyOgCBkrx1StBUBMuBUcLA9Nh5WHCiBijRk3buEUhztWL2oYYI/wXkdUuvrL9DjaXEvZWHdYfy7KtVnN495avakY6BHqWmAERjY8IM/30Xd7gFD2rwVibUfAZQ4i7C9vfMPVuUuEpDu1PnKkSDi8iD9Lhw/bWhRjzbjR3tPabfXHq22pCnpFWE72y6JPsUB3g9Tlmb2rpAx/IyItuT8APRICXNlBi1ErB02m3z59UbVwmClVg9ZsYA1s1a3Ecln8F1pXdyEJDL3HFiAdIZqsEMAnVS03culUqtlDOLHGCkwRY94NYxFHSUae6HxGbrmGULMb+o7mg4mOJUGg6w/LKApJKyQL5EZHLX08DWpeQ8C14Bsn2LlmqUmN6sRRQbdNbo7v8kEZ8k5h0fi8+d7rswRlPC24LqEhfablKXVimA+2E0+VN3m+L+qAQZBUb/pCzo8ehjEKxEQ3Y6QeD76DZc51DGUybdeYgBYY7SYEk1XGJUicDyIKkRool3XtOJZbNQ8orSqC5zclGZxvceQexCcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LDMGZHkgDukRrBFC4bPPVjvOFVE9hYzMJXdlI0rdbJ6w+BBBk9CVOsft1fpD/5C0q7ISOH5rT2svz5217FDy/NJSCuaOxs4VsFip8n8rDQZBSks7+RV20xu4/p/aTJXSAPJ7IAXPLRWW1LDUMKk8zDpoBbo+lbpc2SULKdbzoZvAnCYaHFdsCqQCJVUpI7Vk8m4JjTsIK3zpG5jxh9lIOwYxpAt2WhT8tELNR1A1zS99GVtrccwoLQcPffihHV4aTSFy2qIoF/6dIPcd/HVwqDfqTJvzWp9zTJkSgBoldPw8PSeNIhLSTOwkCT+iis1lD6OpdHGjvPZ32A6jNbD39vIJn8/svL065aGbRwchODzfFgopGBgsjUCU/Miuc7ntr5O2aubNxk1q/u0X1CR88hLja7VMpT/D82uqO5vAun4ORgrmUtBVf51R46QzHO5K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:56:27.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7e53d8-80f3-4b99-aa12-08de9a46c4e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
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

From: Max Zhen <max.zhen@amd.com>

Adjust struct fatal_error_info to match the expected driver/firmware
interface layout.

The structure is used to retrieve debug information from firmware when
a command becomes stuck on the device. The reserved field currently
uses 128 u32 entries, which makes the structure larger than intended
and causes the layout to no longer match the firmware definition.

Reduce the reserved array size from 128 to 127 entries so the
structure matches the expected interface format.

Fixes: 25854131c04a ("accel/amdxdna: Support retrieving hardware context debug information")
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_msg_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
index fc2e99510980..b10552c627ee 100644
--- a/drivers/accel/amdxdna/aie2_msg_priv.h
+++ b/drivers/accel/amdxdna/aie2_msg_priv.h
@@ -461,7 +461,7 @@ struct fatal_error_info {
 	__u32 exception_pc;       /* Program Counter at the time of the exception */
 	__u32 app_module;         /* Error module name */
 	__u32 task_index;         /* Index of the task in which the error occurred */
-	__u32 reserved[128];
+	__u32 reserved[127];
 };
 
 struct app_health_report {
-- 
2.34.1

