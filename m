Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40352CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC92D11320C;
	Mon,  1 Jun 2026 11:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="reZ9rcC7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013033.outbound.protection.outlook.com
 [40.93.196.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533AB11320B;
 Mon,  1 Jun 2026 11:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoSMsVgPBjwTDQiQXEn2WXyOdJrpKxLwCr0Tbuw9fuSjFGaW8Z5a9G0+RzcWeCQwt0IiRQFBZPPWmBtihhiFYoI2nE57o3GgBrmW9cjfPKGOPu/vdSiHxzYtyPELmi4vQnEpxS+j5tRUSd6fHYDF0TRP8xlJtlP2uTyI9bKWCrxehuAV0OWKTmpBvVP5mcifxmUQux+3zZEw2N8SeVl1L7BitB7SGbJUweBmfcwotUyTD0PWB5QvoGlYHYXqu69vXFpZQdi4UVQlhoRv/Szo3HapppP9Pkyd3pil9eI2dAbEvBGu06W+JRrI7Kr0+UXlfSowd/1iY7Xqg/RFGoYcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IKbyPys2yxTeF8iXXi3atdl0vgXHzvqJlNRKYAj3P4=;
 b=h/nlWoj2TB5g+z1J6MesJOLrMDxKgqwStiv5HgDuGqBytu3y/A8blGR1MbYjgL6E65x2yNcJ9BaZHUo8X0PujWgzW2Q3AT8x88N2fC0OZXDROXqwy75LPL/aebUB7ur+zBiKsvZebGOFymFdMt42efB3Axl7WbKSZ9ksZ1s6/3Sqn0bqmhyYfo+pw7LmoDfY6VwP+UTmAU/AVe3AHYfIsAIRzD2PUZfJwJ2oLeOqnv2Lu2ilsWcbgi6fZsRG78OMJuDJLl3wyojODjsdJw8MwnBF5U6mtN32znXStHiAKODeMVyj2LF2wO+PYoKACllSA6K9OZKlleAZqHEuYZySzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IKbyPys2yxTeF8iXXi3atdl0vgXHzvqJlNRKYAj3P4=;
 b=reZ9rcC7lWLARE5wVcowl0yhHezA4IUe8II2E5IUqdlUCw56UuoHdi9ZeK3f3EDTsl71UvMfwDEfzujpc1YJOvhKXuNoxRCgmSbnAzPJI98zAFJtnTjOmfdh2SxeQ4rq+mfV0IC94S7bUelANq3RnZXr1+8qX6VovOKtoZDJhC4=
Received: from BL1PR13CA0342.namprd13.prod.outlook.com (2603:10b6:208:2c6::17)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 11:23:44 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::2e) by BL1PR13CA0342.outlook.office365.com
 (2603:10b6:208:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Mon, 1
 Jun 2026 11:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:23:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 06:23:43 -0500
Received: from yocto.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 06:23:40 -0500
From: Kunal Zodape <kunal.devanandzodape@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rahul Kumar <Rahul.Kumar1@amd.com>, Prateek Gupta
 <Prateek1.Gupta@amd.com>, Kunal Zodape <kunal.devanandzodape@amd.com>
Subject: [PATCH v2] drm/amdgpu: use ACK polling for page-write completion
Date: Mon, 1 Jun 2026 11:23:36 +0000
Message-ID: <20260601112336.2277724-1-kunal.devanandzodape@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260601093226.1255621-1-kunal.devanandzodape@amd.com>
References: <20260601093226.1255621-1-kunal.devanandzodape@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ef131e-bbe8-4467-3a80-08debfd03d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: j2OtpVNc4EqpdmNqLIHIcyYIaXnYda4VS3MnCedX2fBXCZP7XpH91uEpMcB7yRHLg4gkhNql00rlkzoWbJ2Elt4JLWHrhlHUSxjcoiC91udee64wYCAIZSjmJgCmMc6ZJ54/89/p0Ezy2Z21Z8DhNumPsccgTODEAdGA9WEGRy7rjtoj72qFDy7zdS3n414+E0HQzq8dkfpyL+Qv7iE6vtx1j5H9yctjeRpLGUNYKjK/Ck3QfKs5wlaFzTXCsA6ZrwhuAGfH9DfJCeIJc4qQPCDH+VdTlL2g63qWjXfahzIEwjWSMHe6koYfMS4ZsSn8IAYLIhPkJ2AgI3apYh8VKE3RmS8gOW9lVJ10VUSORQkFwQF9ni+a03iicq86A8/nJcRaYs0e2TOH2god5kXIgPibqhJ0CPJiZQfVAoh64JO/qIFwXM8U+oAK55SWj1cvb5mInhTYmxSCmle9OqUrHh8QmjaUd06f5IhcO1N1IGwCrkojjH08XjApz96H3VRTeC0Lc5pahrdxpzhFoVwOw3wMshLDcuGGcg8iPtq6zU/LB3/YOaVaC3S6pMJN0lOOKBbU04SWtKsE9s5WoPimvXUEcob6lrmrZfVNNpATgIFn9Uf/KH3qtFBRC2zZHkd40YmFhcBI/9X6REbMixI3e4OQ4AgZw1jFQMW+db0FHsh0c4xC2lXbFdve3mEQJ9IPp1VFiVcCQq9UqyGUbl7wUcs91UkDAKwJC3ZLe8c92cc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: njuCieNnMervDUfsbCHkAh/qRR8+U4Em0Kw5j1Z6XhShsSM47zpGv7L1K6KQdAbCeOmRUoXvaKfQ1dfPB8x+MBVLtOXHLYDbbC9uIl5Z7bKlUxItYGZDiRaNSKE2cviV6gLQAe7N5gJ9FQNSCc8nHlrl9soKDQVLh+G2b0qWu9Y+1WlXENjw59NPI/OQHyTYzeaIRxkM7NugrdINdHWGTgdQ+1hEw2K50ZwdKXak4cUaKJVi7s6BXgit0TwIMQKuqZlp9LhTstVEGNXiXnTmqHca46QiUNgtPD+leYi4HMcqRg7D4irgbd2Q5Nf6ubz3fqdsxMrBDGdXpsAEKrEf3kcNHEgiieoZzAzwt3ug40HS8r1r69++j7C0dUntA+VbSKim/UOkj7uvekHhTG2UM1TJ4DkoIuT641DkbYyHMHMTPENEv3QcugnRiLjhV3PP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:23:43.8894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ef131e-bbe8-4467-3a80-08debfd03d82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

Suggested-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Kunal Zodape <kunal.devanandzodape@amd.com>
---
v2: Use read_poll_timeout() instead of open-coded ktime + do-while loop
    as suggested

 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 27 +++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 8cd69836dd99..9dc538073bb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <linux/iopoll.h>
 #include "amdgpu_eeprom.h"
 #include "amdgpu.h"
 
@@ -153,15 +154,25 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 			break;
 
 		if (!read) {
-			/* According to EEPROM specs the length of the
-			 * self-writing cycle, tWR (tW), is 10 ms.
-			 *
-			 * TODO: Use polling on ACK, aka Acknowledge
-			 * Polling, to minimize waiting for the
-			 * internal write cycle to complete, as it is
-			 * usually smaller than tWR (tW).
+			int ret;
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
+			ret = read_poll_timeout(i2c_transfer, r,
+						 r == 1,
+						 200, 10 * USEC_PER_MSEC,
+						 false,
+						 i2c_adap, &msgs[0], 1);
+			if (ret)
+				break;
 		}
 	}
 
-- 
2.17.1

