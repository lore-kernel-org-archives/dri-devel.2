Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818CEFAD3F3
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA5A10E453;
	Fri, 24 Apr 2026 04:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RCGeZMqx";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5281D10E26E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 04:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQBa6+mTodTnA5bDMDkkQbJBGPCqvOc0RSl4Zwv5cCGWLyaFuwjCSGXAQbbi2gIwnNL61kZdZXnRcbueju7TPmWx/Krcpt+SDah6wwaKEytJMBlwxM3ftlaERo5qdRItVtgGGqG+ZJXNlHxtpJ6Zz+okSP+eLXpsthQ86iZnvM4aAGVNfp7RrkXjy2LVOSrnsqixSWDfiNsKhNjtlmAbAEbIXb3gSZQB7MIh79BiFyOVrdJU47H23ckZTuZUKPxFlgdfJQsIS0RvRmeeTb5XFpVkCkTNa9UghcDs2pkOPHI2qFUQZVCnpD2mmJSE5i8esfwB0RVhpWa+7Onf/YFgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2zVUt4CFkwXKID8OIDTYbUgkf2LNKTxR7oEqC8OBlc=;
 b=IB5juEOPzHg9mhF/qOx8kxji87M3wTtYD3R0KlH4wm7JzJa/qDUNxJn3uJV7AmCbDmC1l+DdRRlf3A5HaT0V48nE5VL7r0uVZiVYIEWZPDtl7PCvOnYn6Z4NgwfTaaRNiZgviTlWS/UQ9cvk+BuMl10DR+nyDJkrysJivw++1Q4+gB8EUCQ+GZkmRKAR8T9/ORCXtHPmF4lWkI99TfJ0bkUSMnjNJ7J4ihG5gE71wQTKPmooBBZgzkRpYxi0/yd+lTefaCWxgVgEgVwjDe4A6z14lAFflwiyljVwwkcJKHkew5MKy5xn4hfFy1D2X2NoyIwertZWx0Lo9zbzbkkYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2zVUt4CFkwXKID8OIDTYbUgkf2LNKTxR7oEqC8OBlc=;
 b=RCGeZMqx6N7TYL836L5Soyzus1ocyxboUX/ANGfcN6G/qw0H/Kb/IFMxuAb02r7iv7qrcBkWr3ATQlk8ULltHTEIk3tikeOZV/5+BFmijgamrgNd7JInUqmtMfrlOOkj1Ov+qbgXSUq6lUjkrq+3SbbjqVbU/X52WyM133QyK08=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 04:08:33 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::79) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 24 Apr 2026 04:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 04:08:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 23:08:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 23:08:32 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 23:08:32 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Nishad Saraf <nishads@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 2/3] accel/amdxdna: Add configuring low and medium power
 mode
Date: Thu, 23 Apr 2026 21:08:23 -0700
Message-ID: <20260424040824.2253607-2-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424040824.2253607-1-lizhi.hou@amd.com>
References: <20260424040824.2253607-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b145263-a9b5-48c0-bd16-08dea1b726b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: afYROnTjBpCF5Me8vojEZzBbZXzjaiOIz8VM1bfix4O8EKH+/+bDIS830yPTNIw55zJMo2D0z6rJvU/lUiTyjO8lACajW9wwQJB++4e4BDuSY1C2CoKVCwnAgv4R+VaJn2TceDerstx53vQ8PPm8eCQ4kSQ27zQdDvjHPvTlrNNHC23jadDXPlveFXG/lN8JzI52CAcbhVxBFWJBTZCGEFqapYo0Mu+4NoRAKDkKnVpR0lwU1s1KhfbBdppQbX3fbipdhr5fkuW2hKBtM1YKWqKxsytD5PCh9Kmn0d2ewUf0YaXaPwxpOzivT0Z03ksoZ9Vsf7GWsp3qbmSkXoY6IGL6q7kMsIAey6RN0rtVzj1D3GQcShrogQXW+172UMzWSR5Ba5GMZslJwiWbzS2kziSe07YX/Nd0GH7DUerMxvczQg6tpauuwM/iwiaIdYpywGLanUUnS+fZy0eYc2vTgnuKkg0aG9mQ1G8WNTtdXgNIoB+ofSkQhkt1rVolEbun89yAnJhTYtWC2h95VQ4t+/5VOx7hev8kkyaYkTEp5NlGN/mN+pde+H6NBnF9zcBT8haxHKVNYvZw35HKR3ltiGuXSEjx8nO3ayu9bEqumGBysjYg5ZtFFlbtktJHKjfe5ufFcMW0Z7b8c0bac/cgjeBBkO1pkYpOv6+eBhq7ttiI6ZMT/3yGQ8RETOI8VEwCLvWgYZ9FPdVABb9cmkIENRp36vYutPbJoQXlasecQztK3sPvugbisXw8XK4urHEJDd88xJ8sNGcU5BRWwc+41g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5nK2FqQy1BjSKUbI/hZPN9SnRCjzd1LqW9kfj1mjVqcGxqMAsScqyDLzJCJzM1xw9S29SgRYJWBHrEJ0UON1pnoGC9rxUWb6cjneCJgA73B4jDlqnAjceTkSjJidBU3klC3G0hL0qcmLlKbLO6awi7RlIvr0NzJC5XAa1CD1aNVCyikGebh1M5J3oKtnsk3wDF8KcXGkpfEs+reNYv+Vk43hDq0DQfHhORsw4yMfDHq+jAXfuoylLw6VCkxlJZZrLw8aTiWIFxMRpUlTJVi+FUNME+54+7CmAKqNxdeUs6L6yP0VjpUh9BlMaSrYFoNvppd+6w9E/zg7GYYHNpYCoWuxyyRO8yiAbs71G7Pg5Y6o0a1+kmGh/uLUhanenhgru3uigNd9SjQbM8apmpwpNGQQMy/CcsC/Ybtcmw9BfPQ0INfWO7vPYTv+Ll5SMb4j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 04:08:33.3416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b145263-a9b5-48c0-bd16-08dea1b726b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

From: Nishad Saraf <nishads@amd.com>

Add support for POWER_MODE_LOW and POWER_MODE_MEDIUM.

Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
index d9ccd7fc8a6d..4fe6030d2c41 100644
--- a/drivers/accel/amdxdna/aie2_pm.c
+++ b/drivers/accel/amdxdna/aie2_pm.c
@@ -108,6 +108,14 @@ int aie2_pm_set_mode(struct amdxdna_dev_hdl *ndev, enum amdxdna_power_mode_type
 		clk_gating = AIE2_CLK_GATING_ENABLE;
 		dpm_level = ndev->dft_dpm_level;
 		break;
+	case POWER_MODE_LOW:
+		clk_gating = AIE2_CLK_GATING_ENABLE;
+		dpm_level = 0;
+		break;
+	case POWER_MODE_MEDIUM:
+		clk_gating = AIE2_CLK_GATING_ENABLE;
+		dpm_level = ndev->max_dpm_level / 2;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.34.1

