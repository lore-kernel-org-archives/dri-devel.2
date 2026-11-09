Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05435606A331
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=D5rNEJa1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6604610F457;
	Mon,  9 Nov 2026 17:14:08 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5536410F457;
 Mon,  9 Nov 2026 17:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uci14pLt24oa4vPXThZ6N0TumIy44zwhVKe6jzYM11gvKibpn0UlcCjpPsrh/zCHCM23VJEo+399Ug9a+G/HTXCAMJ6OPszcBWsRITiVW9cxlUTh3QwLW/ubZr52xW8aHXdvpbp1MN8VZNsYi+Tr3fkGSSsTf8kImiZFovgNJjjKk6lvbxsvuPL3rDT8OKrlcUkie5R79t/czrIn1uT1DjAwmBGexVS2KiHwO//1vcaRlGCMzTb/1dsiSMhb81YRlGp5q8s+k41Q915jLoGim2RpZVUsVdKVuHR5NuzvGAwaG3R0Xq8idctYLYpPtRW/iUcnJUi+tYCIHbb2U+idCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRaqHFzNYgfeSdDuQJOemDmKXLex1oxMeAO5v9Iyzm4=;
 b=fY5ckiiFfyIIHskAUjf2npdyGg+8NYbnI5Goj4B3Zj2H98hr6SgwkoPmuiRJtjgUlWmxgPiOfcnVb3/a6WmZ/tpbpkdjX5iwh5BJjVWTqBBo2jm/Pdw4QY2tTxyMYXzcZDXFlm0kbmgBQrG1nTSryY1DwDrgmEqeZMCVKXlxiNKeUHVEiRUTPkguT5XAOc71wcs7k2ds4OcMYwNEoBZAU/NO/ejihExyxFKx4UW/aS4AKIfPG142HMEJHxu/V2B8YNPO+sBFuePn5cVQkmD43Et1suS/w101r8j4x5t8eIgRJpABQJSYOP2FJJYr+m6VU6HHcKy8wR6A7hZQDOrIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRaqHFzNYgfeSdDuQJOemDmKXLex1oxMeAO5v9Iyzm4=;
 b=D5rNEJa1JgbDjT4X3YUT8/QoATGduaRftInh33ACsVy7Ov+vVTQ4mTDi6w7Y538fqrtqraQe8KHZhHmK7n1JKmmoh9B0QqjTL7yarrfpxtodIfLCJu9zz9+PKPeeYMlcu0mgRBef9S6uTKyVaBtsUXwEcseUDKeb/Sny3p/D9AM=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 17:13:57 +0000
Received: from CO1PEPF0001885E.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::af) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Mon, 9
 Nov 2026 17:13:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885E.mail.protection.outlook.com (10.167.249.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 17:13:57 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 11:13:54 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sashiko-bot <sashiko-bot@kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/6] drm/amdkfd: avoid NULL kfd_process_device in
 kfd_profiler_pmc
Date: Mon, 9 Nov 2026 18:13:20 +0100
Message-ID: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885E:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d8db0d-5563-44c9-a4d3-08df3e84d719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|10067099003|13003099007|11063799006|261009223027099003|261102123227099003|261021121427099003|261021123027099003|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info: +AXKcDTTgR4wY+rnR1HnU56MUUPTb7SQOL7g5zTM7h6QAQAGrl/+WbCda/WS//wNpXyAKIBgadNc7UM+qxGY5Hl+/wsZ52hn1bmkcN5jV0L14bQ1lWD0PUaWmDZ0laFilzqxiIwyoBQFsJtE0hMU5RfznLXmj715vPkvo+IQzq3ACK8bPCcLQthlABMZQb83YJLkOjntCAge4CbeRaqMCLF/N2kkq/rNlP45mogzl2mNwqWQJTGdPfHixWUxHCjBbNnYrFGF244uh8hSRo9zZYJ3pQMCzh9BvIdPJ5wgsWMR5eqA84JT8LqkpXcFJ9m8cT7kNtdX2z99MM57kJQJs+K1zg8D2YpzXbeVV1uimOsskwdjCnuIwTPJ37ns1yQlzSdKkdGCHU1eP61sxNpi0uNE9UBxVjNTY9TpviNOPoeeycfhrLcoKPO16xcSZrSQFN7yfaEpKdlKvXBMemMmGlIr7tQulU8q2s96s+eBuokH21FPCRJ69VPY+bdJCX0N9IcuvylFlWYFLEHSh1B72nyGQ7XjVAkXQpTLX8DXgS3CCvJ1kPniSf7DrMXN8EkYhp0rG2e1BusMWa5zmuDZcb1kCwfXxXA79M1s60XW+7zy232UbjRZd2WhcwUplTI7k/YiKphzYtm4GtO20ENGjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(10067099003)(13003099007)(11063799006)(261009223027099003)(261102123227099003)(261021121427099003)(261021123027099003)(56012099006)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gVBzRh304tIIYD6BpVd2ojBx9gROmTTbaFgp/Z+kWtvNJNaldPmWnq84hCfwW2SCrG/M3UdkvJP4A0+umym6t2iDxf89558wxgB5e8hYOffC9HynISEuNcncnKRHYZSkrvMmeyDYp2l3g418dqvhh9IHRInmMXG2iCCDckJ1f47ygvZQFk4DrYsGTmjoyTxks2lcmHndHZnvM0mwAv1PzGJ0l3mIc+uztwyw5OBceLloabwt9FaXzbjnZdhLXlbJf08FPMrynzkJbnLYgIUwQyt0qw6JHTAunoYZjMcdgoOGuOOCRdHcdfarXWcm3pldLSRQ0E9XiQZ6SrgpFzJEsEYXSFZqJ0wrxKnIvjrjBEGv3R3vtR7zQ5wpH46U/S8YtvQlBCi8gqPxTZ+NcM/2kUn2ja+Ve7FUQbXrde2bJ1TN8mWpHVVvuX0yr1yinDGW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:13:57.3835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d8db0d-5563-44c9-a4d3-08df3e84d719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All other callers of kfd_process_device_data_by_id deal with
a possible NULL return value except kfd_profiler_pmc.

Check it after the mutex unlock and return -EINVAL as others
place do.

Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com?part=4
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6c710e4a5220..ad086240a6dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3463,8 +3463,10 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
 	/* Enable/disable perfcount if requested */
 	mutex_lock(&p->mutex);
 	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
-	dqm = pdd->dev->dqm;
 	mutex_unlock(&p->mutex);
+	if (!pdd)
+		return -EINVAL;
+	dqm = pdd->dev->dqm;
 
 	dqm->ops.set_perfcount(dqm, args->perfcount_enable);
 	return status;
-- 
2.43.0

