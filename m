Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDFDCDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1311F10E4CF;
	Mon, 22 Jun 2026 06:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="H7utaY8R";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B21C10E4CA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkoMorQFIJZ/UUzqNrGg6usmXAk84AIdtTbieBP6D49Uzk0YuV+eUtKEa8Q57BtIjnzpI7gK3JEXCXGHIbLJLUpKe7IS9ytfH0ASeKvz6OKiZRRxZ66XKh01O61CiAT8NQ2/lbNAuAvsyP33b1mdXlWLR/I3woclrqg0/2KlXwUKU5AT1g8yWA/+rdUOkDnK7pRdJAWxC8DKodi9J5NGf0exEHV6vwTOe2aJYI6HGvv3lNl5twxvU4tW2UAjoKhuYjnBH2OG9gxY4mQ+FTRdtR6vt6KC7oGWelbgoyLRztpRubDtuhdeZrN4+zPPFeglLz9+CrQTAzvol2naYKwAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XazvoovfNWfP5yrB6CKq9CPFtIYAO8XSX8SHYr0ImRM=;
 b=T0UWEOJW5fY/6VfS1Jg1xf9sFU4d5HlcdF31j1ejk+bQWYqhJpna+USBTnv5IQdlZEzkNzKwS/pD4BYxHG3SGhK/i39hel+sFBbLyt5+TpPXDH2rFaYznyPrRt55uc/nhiO4/HdlOAyXgHzYb5HwVYkKSeY82lXnbU3b5VuklvooZKay+oAnsvVWp87m8Wr/kR04oTghU3zV3t4jkE/cr5FmU5GQ8o6AAmdWcUWtYsEbMMf4t4vTBw5h55eaky/l9I8kq2CKC7J2CGxyXilH5ExNfpDYyTHPS8MGWxDRxKFXi7AaZR/MuUZbiGiXfAmxxcvgR+8/VHZnxeCrT/5TUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XazvoovfNWfP5yrB6CKq9CPFtIYAO8XSX8SHYr0ImRM=;
 b=H7utaY8Ry4AHZYZhxWu1izJY/+5vHIMgLpNL6RFGk/GsfD6BkMGguCAlshHt4XGC1ajaJVpWE6/+oviVGTLAGIDc66f3MEYv6w6kQ61onvJPTWTJp0Hb0kExfofLkJnphmX6BH8/Rxc6gfKdN9KOKkZikhMDZx+0pBRvcuDNM6hMU65uXoJxvX9EGhHL0gPgqjmsQLkISncfsOUcQ0zyy7pxiRKX8uiFmqdCpZszkA7B9X0gvryC0kDYGJqPUBUnazus20NnRj8s9MokpSH4b7vtXjgZx+P2zpKilqxtxZU4DkGH5f63nP4pPZIMi0w1XXLHiKJxAzSfUJN7gPyqFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:58:09 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:58:09 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 15:57:41 +0900
Subject: [PATCH v2 4/7] gpu: host1x: Add Tegra264 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-t264-host1x-v2-4-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
In-Reply-To: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Santosh BS <santoshb@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS7PR01CA0111.jpnprd01.prod.outlook.com
 (2603:1096:604:258::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 486b0f78-03c4-487a-b354-08ded02b9e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: jvjklnHzQuFchywivBfBubfHGiTWCTqghtGMCRiHYLtqFQL4jn7hHMCngeS0nxf0MWPk9LiwaA+rumt8H5FVJ1FzxF/74oWV+WovxDKOars2hGbZpInuR2ePBV3y6n6WNWjuHT9toUQ0iczripK0HqwsvVT3GXfhYxNcwXdhKIntIE6ntwLOJozuHr1hjZAv0nHfCbOz7M+X6h63VMlebfkzyB7u/U06MytDQgmy+y/gfHjKTLh+tWHyapF44nkomE/18VdE9bysrgYmyHVf1eQ9u3UE/93Mmb23ZwGFi2rY1xRybtGGaUMS6Hs85oAuJMrxFcVOSzXPeQk6L7SBf8tpt53ga9f+rKvgjJYuHvX55mHp3ytdWH2KG2Rsh6FCyFe9JHPL6dBmoi3ol1a+Fzz60R//uBjEAzxgnVf1JUWuS8ez0ZSktXCNgKlDX1E5wEExUJlNqR8TR73BxZBoXwX9lLEvkDNVGeW2CShBv6FxRBx4iP0RqVTWIN61v8eq1zx/quMq4qcJOdPT7ywA/aVW0VOZ6vUHOLWIcWfzDzCeHoxAzAn9MsEhqIejFX36lxlYC3u3+0TqTeNSaeG2HUStz4MliDL2Odqk7+LWeGqGoljJJ5wZytCQdqocHXjzIDG9JbtpANjeCu3d8FLMAR50fDuTmCOIaZ5lWjHsw9fVBXFJiEjc9hloOn8/TRu5NfZJWALxOuWR2xDdv+C1mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVB3Rzdod2ZiOThGSFc4R1NtT09KS3hRN1FROXlMTU91VXg3WkpYcVVkcEhL?=
 =?utf-8?B?bUg1aFZLR2tYUkpZWnlGQWhPZ0V1U2VNdHMyd01PNTgrU1hTMm1nUnFoeGUy?=
 =?utf-8?B?b1Fpa2FhcGdic2tZSnZTdUY5VlVENkFPaFJJb3FMQU5HVDVHaWNPbFMwVFk2?=
 =?utf-8?B?Y1RoQzFuYUtvWW9IWGIzeHJ5S1JFQUt3bkVXNm9lOWlYT2pRS2lkcXpPQzZE?=
 =?utf-8?B?em81blFtcE41Q2xUbkMrQVJlZmthakhucjFoTmw4ZVNqYllMeTZKK0ZZMkgy?=
 =?utf-8?B?TU5DanRhMldybzJuZVF1QWoyUTN3Nm5nTXNWc2dWY1NqYXZiUCtxeU93MGR6?=
 =?utf-8?B?SnFlazdnNXk3TEpoSGtoUEFJT3lmeHZyb2FnT1kvZ3NXVU5SSzNIaVlPazRu?=
 =?utf-8?B?YkJUWnYvb0FYWDVpODVBZW9sWDZMUUNpRWdrd09yMjhRMHdYai9TSXZLU0dJ?=
 =?utf-8?B?c2VRL3FBNWRsY0ZsMHBBUFIzdE5iOU81SUhBS0d6Sk53anNqOUg2bnZCT1lR?=
 =?utf-8?B?NVg3c3Z1MUVDaDBxS1cxWHFsZjNVaU5GQXV2cFB5U1UrYW5xOGRsb2lUWkVF?=
 =?utf-8?B?R1pMSUZBVUtUd2R2enBvYThQTUE5Mk5EZnVxY1NZVEtsNkhVU3NRNlNJdEFR?=
 =?utf-8?B?c2lyeEROMnFGcDlnSFVuZXFhSXVkS0Y5NkNpdnM5M1Q1U1cwNE12ME5meXFi?=
 =?utf-8?B?Q1BUSXRRMWcxLzVLS2JHYVVHMVdoMGNlaS9OYjRhdDRDQUdyNE53dUV6RUZz?=
 =?utf-8?B?Y3FtcUFqWURxK3BqNUt3ZTVJQnpXTGtEc0psNk5BanhMeUpWcytscW5tK3FY?=
 =?utf-8?B?SSt3dStYNWFVQXhLMFVnSHZ0NXB4cGZ5bTZXS1pMQXVRSU5sZW9LRTl3R2tU?=
 =?utf-8?B?dERJVTNTOGo3ZXdnL0dBejdYbjljN0kxc2R1UURpK1Frck10SHR3a3pjbFUw?=
 =?utf-8?B?WjRlbVZ0eW41UGE3NHc0dXh1NnRrc2cvVVZ1QUdTbG8zVHBudi9BSitxeEtO?=
 =?utf-8?B?cTBVWGVlOTNVckdmbzJSb1VxVlBRRjZCeVVrZVBYd0d5c21nZmtKRkM1dU5j?=
 =?utf-8?B?V2c4cXVsOXY4ZVlkY1lJRG9hUitEYWhPdVpuUlZmRmNaZmd6RkFJMUJKYUln?=
 =?utf-8?B?OWRxdU9sVExIeVV1aVA4YWl3aVgwL0ZyOWRJREp3OVYxWTA5cWJKSmdsL2pv?=
 =?utf-8?B?b3VZOXlob1NnSlBIMXExbnZyRXQ2YlZ4ODYzckM1S2VGK2xDanJ0d1hzMHdI?=
 =?utf-8?B?d05Mb0JFeFZMMHk0RUF3NEZNOW1NNnoyL0dzSlBvYmY3M0hKMkxSeXZaZ05B?=
 =?utf-8?B?QjI4RUZQcWtvYlJXOWlwK0dvYkhxUVc2NlhWMTZ3b0FOcmZJMFJpYTJwRUw4?=
 =?utf-8?B?N0s2ZUREbi9HZStJME1OaWpFUlhobWc4dWxlR3Uyd0xyMGxJL29DOGRBT3Vz?=
 =?utf-8?B?b09idlJiNXhlVWFOTThFVHFuNEM5eXVGUVE5dXBsM0RyUDczVjZBckhPOTNW?=
 =?utf-8?B?NkdVdVRER216aHRhZ3hlVUI5VXpnbDltdEpONTdxYm13SU52dWp0dGxJNmlK?=
 =?utf-8?B?YnhYSEFscWE2R3hNUHNmZ0Y4eEJsS29xMVdsb0pUUnZobXlxOTdkQXZQaHF6?=
 =?utf-8?B?eUdqdzZsK0ErTnFoSlE1RVRYWE92MHpweHkwZXNuRHhRZmpOa2NpckZaN3h0?=
 =?utf-8?B?Y2VVTm01WVdnV3JrWW5CcGdqcmc0cnI2dWczQitRTURrU2FaWUdNTDdMMTB3?=
 =?utf-8?B?OWs1d1RGZlBJMWJkanBRWndJMkk0ZUVSWFRNeUp0bURHbHNidk9yelJ4TG15?=
 =?utf-8?B?akpmYkl6YVpUY1F5b2VDQVF2ZDZkZmhDb051ZDNuNEpjdjQ3M29OdkxoTVNP?=
 =?utf-8?B?czkrcysrbTNVWHVEamlBT01mRklDRDlna1lrMGhvTkIzdTV5bTVOQjJNeW1P?=
 =?utf-8?B?cnZvZlhMVEk4Q2ZoOFo1RXZ5TmY5b1ZSV2NmRG4xbmNjRkR0SzE3ZzZ1MFdi?=
 =?utf-8?B?cS85U2JPRjVzL3ZGVTRmZVNIYTVxcDhlaEFCOGM4VTR6QVBwRzlROWlTLzUx?=
 =?utf-8?B?UHNLRWhDd2todG5VYnVBNENXTk8wVFNwa25wSGVlM0Nrdm9HQUt1TEdBUVUx?=
 =?utf-8?B?UzF1SlhlNUlXRmt2RlQxalRsaW5sYkl4M2UzMlZ3L1N1a2hPNkFWWVNQQ0NY?=
 =?utf-8?B?NThHYzN5R0JWY21od1dPaG1VMzIzZStvTldvdlh3Qll5SkVLT1FKTDdnQ1hJ?=
 =?utf-8?B?RG9mOVltWFRpakp5elBwWTU4Z0dwNkZnV2sxSmVXQWlxL0lPUFVMM01oS0pL?=
 =?utf-8?B?MWhPZGtBUDJWOHJjRnV3S0ljK1d2WkZFYVQ5bFhJTm81LzJiN3l3QkpSVnZS?=
 =?utf-8?Q?hdcA/0vS3vfWIdS7tVfF9/tpSsN3V0334TVqm5vuf0nWi?=
X-MS-Exchange-AntiSpam-MessageData-1: ldL9iA7wvd3ZoA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486b0f78-03c4-487a-b354-08ded02b9e4a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:58:09.1955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieE16/Y1pIHXvAI8Jq7Q1fHBfxyzO5j17EZYE7/FgIY/nlSaDeL5T3hxq+q3qoWldbNIz+DB+g6W7H+K30zTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

From: Santosh BS <santoshb@nvidia.com>

Add device data and chip headers for Tegra264.

Signed-off-by: Santosh BS <santoshb@nvidia.com>
Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/Makefile                    |   3 +-
 drivers/gpu/host1x/dev.c                       |  41 ++++++
 drivers/gpu/host1x/hw/cdma_hw.c                |  12 +-
 drivers/gpu/host1x/hw/host1x10.c               |  33 +++++
 drivers/gpu/host1x/hw/host1x10.h               |  15 ++
 drivers/gpu/host1x/hw/host1x10_hardware.h      |  21 +++
 drivers/gpu/host1x/hw/hw_host1x10_common.h     |   6 +
 drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h |  10 ++
 drivers/gpu/host1x/hw/hw_host1x10_uclass.h     | 181 +++++++++++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x10_vm.h         |  36 +++++
 10 files changed, 352 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
index fead483af0b4..b684fbf73841 100644
--- a/drivers/gpu/host1x/Makefile
+++ b/drivers/gpu/host1x/Makefile
@@ -17,7 +17,8 @@ host1x-y = \
 	hw/host1x05.o \
 	hw/host1x06.o \
 	hw/host1x07.o \
-	hw/host1x08.o
+	hw/host1x08.o \
+	hw/host1x10.o
 
 host1x-$(CONFIG_IOMMU_API) += \
 	context.o
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 3f475f0e6545..d2c64728f804 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -41,6 +41,7 @@
 #include "hw/host1x06.h"
 #include "hw/host1x07.h"
 #include "hw/host1x08.h"
+#include "hw/host1x10.h"
 
 void host1x_common_writel(struct host1x *host1x, u32 v, u32 r)
 {
@@ -287,7 +288,47 @@ static const struct host1x_info host1x08_info = {
 	.reserve_vblank_syncpts = false,
 };
 
+static const struct host1x_sid_entry tegra264_sid_table[] = {
+	{ /* SE1 MMIO     */  .base = 0x1650, .offset = 0x90,  .limit = 0x90  },
+	{ /* SE2 MMIO     */  .base = 0x1658, .offset = 0x90,  .limit = 0x90  },
+	{ /* SE4 MMIO     */  .base = 0x1660, .offset = 0x90,  .limit = 0x90  },
+	{ /* SE1 ch       */  .base = 0x1738, .offset = 0x90,  .limit = 0x90  },
+	{ /* SE2 ch       */  .base = 0x1740, .offset = 0x90,  .limit = 0x90  },
+	{ /* SE4 ch       */  .base = 0x1748, .offset = 0x90,  .limit = 0x90  },
+	{ /* VIC ch       */  .base = 0x1790, .offset = 0x30,  .limit = 0x30  },
+	{ /* VIC MMIO     */  .base = 0x1688, .offset = 0x34,  .limit = 0x34  },
+	{ /* TSEC MMIO    */  .base = 0x1690, .offset = 0x30,  .limit = 0x34  },
+	{ /* VI MMIO      */  .base = 0x1698, .offset = 0x800, .limit = 0x800 },
+	{ /* VI_THI MMIO  */  .base = 0x16a0, .offset = 0x30,  .limit = 0x34  },
+	{ /* ISP MMIO     */  .base = 0x1680, .offset = 0x800, .limit = 0x800 },
+	{ /* ISP_THI MMIO */  .base = 0x16a8, .offset = 0x30,  .limit = 0x34  },
+	{ /* VI2 MMIO     */  .base = 0x16b8, .offset = 0x800, .limit = 0x800 },
+	{ /* VI2_THI MMIO */  .base = 0x16c0, .offset = 0x30,  .limit = 0x34  },
+	{ /* ISP1 MMIO    */  .base = 0x16c8, .offset = 0x800, .limit = 0x800 },
+	{ /* ISP1_THI MMIO */ .base = 0x16d0, .offset = 0x30,  .limit = 0x34  },
+};
+
+static const struct host1x_info host1x10_info = {
+	.nb_channels = 63,
+	.nb_pts = 1024,
+	.nb_mlocks = 24,
+	.nb_bases = 0,
+	.init = host1x10_init,
+	.sync_offset = 0x0,
+	.dma_mask = DMA_BIT_MASK(40),
+	.has_wide_gather = true,
+	.has_hypervisor = true,
+	.has_common = true,
+	.num_sid_entries = ARRAY_SIZE(tegra264_sid_table),
+	.sid_table = tegra264_sid_table,
+	.streamid_vm_table = { 0x1004, 128 },
+	.classid_vm_table = { 0x1404, 25 },
+	.mmio_vm_table = { 0x1504, 25 },
+	.reserve_vblank_syncpts = false,
+};
+
 static const struct of_device_id host1x_of_match[] = {
+	{ .compatible = "nvidia,tegra264-host1x", .data = &host1x10_info, },
 	{ .compatible = "nvidia,tegra234-host1x", .data = &host1x08_info, },
 	{ .compatible = "nvidia,tegra194-host1x", .data = &host1x07_info, },
 	{ .compatible = "nvidia,tegra186-host1x", .data = &host1x06_info, },
diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma_hw.c
index 3f3f0018eee0..e43a9cf20c27 100644
--- a/drivers/gpu/host1x/hw/cdma_hw.c
+++ b/drivers/gpu/host1x/hw/cdma_hw.c
@@ -246,23 +246,24 @@ static void timeout_release_mlock(struct host1x_cdma *cdma)
 	 * so it turns out that if we don't /actually/ need MLOCKs, we can just
 	 * ignore them.
 	 *
-	 * As such, for now just implement this on Tegra234 where things are
-	 * stricter but also easy to implement.
+	 * As such, for now just implement this on Tegra234 and above where things
+	 * are stricter but also easy to implement.
 	 */
 	struct host1x_channel *ch = cdma_to_channel(cdma);
 	struct host1x *host1x = cdma_to_host1x(cdma);
 	u32 offset;
 
 	switch (ch->client->class) {
+	case HOST1X_CLASS_VIC:
+		offset = HOST1X_COMMON_VIC_MLOCK;
+		break;
+#if HOST1X_HW == 8
 	case HOST1X_CLASS_NVJPG1:
 		offset = HOST1X_COMMON_NVJPG1_MLOCK;
 		break;
 	case HOST1X_CLASS_NVENC:
 		offset = HOST1X_COMMON_NVENC_MLOCK;
 		break;
-	case HOST1X_CLASS_VIC:
-		offset = HOST1X_COMMON_VIC_MLOCK;
-		break;
 	case HOST1X_CLASS_NVJPG:
 		offset = HOST1X_COMMON_NVJPG_MLOCK;
 		break;
@@ -272,6 +273,7 @@ static void timeout_release_mlock(struct host1x_cdma *cdma)
 	case HOST1X_CLASS_OFA:
 		offset = HOST1X_COMMON_OFA_MLOCK;
 		break;
+#endif
 	default:
 		WARN(1, "%s was not updated for class %u", __func__, ch->client->class);
 		return;
diff --git a/drivers/gpu/host1x/hw/host1x10.c b/drivers/gpu/host1x/hw/host1x10.c
new file mode 100644
index 000000000000..2800f309bf6f
--- /dev/null
+++ b/drivers/gpu/host1x/hw/host1x10.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Host1x init for Tegra264 SoCs
+ *
+ * Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+/* include hw specification */
+#include "host1x10.h"
+#include "host1x10_hardware.h"
+
+/* include code */
+#define HOST1X_HW 10
+
+#include "cdma_hw.c"
+#include "channel_hw.c"
+#include "debug_hw.c"
+#include "intr_hw.c"
+#include "syncpt_hw.c"
+
+#include "../dev.h"
+
+int host1x10_init(struct host1x *host)
+{
+	host->channel_op = &host1x_channel_ops;
+	host->cdma_op = &host1x_cdma_ops;
+	host->cdma_pb_op = &host1x_pushbuffer_ops;
+	host->syncpt_op = &host1x_syncpt_ops;
+	host->intr_op = &host1x_intr_ops;
+	host->debug_op = &host1x_debug_ops;
+
+	return 0;
+}
diff --git a/drivers/gpu/host1x/hw/host1x10.h b/drivers/gpu/host1x/hw/host1x10.h
new file mode 100644
index 000000000000..577f6ff3dff5
--- /dev/null
+++ b/drivers/gpu/host1x/hw/host1x10.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Host1x init for Tegra264 SoCs
+ *
+ * Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef HOST1X_HOST1X10_H
+#define HOST1X_HOST1X10_H
+
+struct host1x;
+
+int host1x10_init(struct host1x *host);
+
+#endif
diff --git a/drivers/gpu/host1x/hw/host1x10_hardware.h b/drivers/gpu/host1x/hw/host1x10_hardware.h
new file mode 100644
index 000000000000..abbead8190b1
--- /dev/null
+++ b/drivers/gpu/host1x/hw/host1x10_hardware.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Tegra host1x Register Offsets for Tegra264
+ *
+ * Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef __HOST1X_HOST1X10_HARDWARE_H
+#define __HOST1X_HOST1X10_HARDWARE_H
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+
+#include "hw_host1x10_uclass.h"
+#include "hw_host1x10_vm.h"
+#include "hw_host1x10_hypervisor.h"
+#include "hw_host1x10_common.h"
+
+#include "opcodes.h"
+
+#endif
diff --git a/drivers/gpu/host1x/hw/hw_host1x10_common.h b/drivers/gpu/host1x/hw/hw_host1x10_common.h
new file mode 100644
index 000000000000..48a632672a47
--- /dev/null
+++ b/drivers/gpu/host1x/hw/hw_host1x10_common.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#define HOST1X_COMMON_VIC_MLOCK			0x4060
diff --git a/drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h b/drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h
new file mode 100644
index 000000000000..8c9069caffa8
--- /dev/null
+++ b/drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#define HOST1X_HV_SYNCPT_PROT_EN			0x172c
+#define HOST1X_HV_SYNCPT_PROT_EN_CH_EN			BIT(1)
+#define HOST1X_HV_CH_MLOCK_EN(x)			(0x1708 + (x * 4))
+#define HOST1X_HV_CH_KERNEL_FILTER_GBUFFER(x)		(0x1718 + (x * 4))
+#define HOST1X_HV_SYNCPT_VM(x)				(0x0 + 4 * (x))
diff --git a/drivers/gpu/host1x/hw/hw_host1x10_uclass.h b/drivers/gpu/host1x/hw/hw_host1x10_uclass.h
new file mode 100644
index 000000000000..abe83e67fa83
--- /dev/null
+++ b/drivers/gpu/host1x/hw/hw_host1x10_uclass.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+ /*
+  * Function naming determines intended use:
+  *
+  *     <x>_r(void) : Returns the offset for register <x>.
+  *
+  *     <x>_w(void) : Returns the word offset for word (4 byte) element <x>.
+  *
+  *     <x>_<y>_s(void) : Returns size of field <y> of register <x> in bits.
+  *
+  *     <x>_<y>_f(u32 v) : Returns a value based on 'v' which has been shifted
+  *         and masked to place it at field <y> of register <x>.  This value
+  *         can be |'d with others to produce a full register value for
+  *         register <x>.
+  *
+  *     <x>_<y>_m(void) : Returns a mask for field <y> of register <x>.  This
+  *         value can be ~'d and then &'d to clear the value of field <y> for
+  *         register <x>.
+  *
+  *     <x>_<y>_<z>_f(void) : Returns the constant value <z> after being shifted
+  *         to place it at field <y> of register <x>.  This value can be |'d
+  *         with others to produce a full register value for <x>.
+  *
+  *     <x>_<y>_v(u32 r) : Returns the value of field <y> from a full register
+  *         <x> value 'r' after being shifted to place its LSB at bit 0.
+  *         This value is suitable for direct comparison with other unshifted
+  *         values appropriate for use in field <y> of register <x>.
+  *
+  *     <x>_<y>_<z>_v(void) : Returns the constant value for <z> defined for
+  *         field <y> of register <x>.  This value is suitable for direct
+  *         comparison with unshifted values appropriate for use in field <y>
+  *         of register <x>.
+  */
+
+#ifndef HOST1X_HW_HOST1X10_UCLASS_H
+#define HOST1X_HW_HOST1X10_UCLASS_H
+
+static inline u32 host1x_uclass_incr_syncpt_r(void)
+{
+	return 0x0;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT \
+	host1x_uclass_incr_syncpt_r()
+static inline u32 host1x_uclass_incr_syncpt_cond_f(u32 v)
+{
+	return (v & 0xff) << 10;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT_COND_F(v) \
+	host1x_uclass_incr_syncpt_cond_f(v)
+static inline u32 host1x_uclass_incr_syncpt_indx_f(u32 v)
+{
+	return (v & 0x3ff) << 0;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT_INDX_F(v) \
+	host1x_uclass_incr_syncpt_indx_f(v)
+static inline u32 host1x_uclass_wait_syncpt_r(void)
+{
+	return 0x8;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT \
+	host1x_uclass_wait_syncpt_r()
+static inline u32 host1x_uclass_wait_syncpt_indx_f(u32 v)
+{
+	return (v & 0xff) << 24;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_INDX_F(v) \
+	host1x_uclass_wait_syncpt_indx_f(v)
+static inline u32 host1x_uclass_wait_syncpt_thresh_f(u32 v)
+{
+	return (v & 0xffffff) << 0;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_THRESH_F(v) \
+	host1x_uclass_wait_syncpt_thresh_f(v)
+static inline u32 host1x_uclass_wait_syncpt_base_r(void)
+{
+	return 0x9;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_BASE \
+	host1x_uclass_wait_syncpt_base_r()
+static inline u32 host1x_uclass_wait_syncpt_base_indx_f(u32 v)
+{
+	return (v & 0xff) << 24;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_BASE_INDX_F(v) \
+	host1x_uclass_wait_syncpt_base_indx_f(v)
+static inline u32 host1x_uclass_wait_syncpt_base_base_indx_f(u32 v)
+{
+	return (v & 0xff) << 16;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_BASE_BASE_INDX_F(v) \
+	host1x_uclass_wait_syncpt_base_base_indx_f(v)
+static inline u32 host1x_uclass_wait_syncpt_base_offset_f(u32 v)
+{
+	return (v & 0xffff) << 0;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_BASE_OFFSET_F(v) \
+	host1x_uclass_wait_syncpt_base_offset_f(v)
+static inline u32 host1x_uclass_load_syncpt_base_r(void)
+{
+	return 0xb;
+}
+#define HOST1X_UCLASS_LOAD_SYNCPT_BASE \
+	host1x_uclass_load_syncpt_base_r()
+static inline u32 host1x_uclass_load_syncpt_base_base_indx_f(u32 v)
+{
+	return (v & 0xff) << 24;
+}
+#define HOST1X_UCLASS_LOAD_SYNCPT_BASE_BASE_INDX_F(v) \
+	host1x_uclass_load_syncpt_base_base_indx_f(v)
+static inline u32 host1x_uclass_load_syncpt_base_value_f(u32 v)
+{
+	return (v & 0xffffff) << 0;
+}
+#define HOST1X_UCLASS_LOAD_SYNCPT_BASE_VALUE_F(v) \
+	host1x_uclass_load_syncpt_base_value_f(v)
+static inline u32 host1x_uclass_incr_syncpt_base_base_indx_f(u32 v)
+{
+	return (v & 0xff) << 24;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT_BASE_BASE_INDX_F(v) \
+	host1x_uclass_incr_syncpt_base_base_indx_f(v)
+static inline u32 host1x_uclass_incr_syncpt_base_offset_f(u32 v)
+{
+	return (v & 0xffffff) << 0;
+}
+#define HOST1X_UCLASS_INCR_SYNCPT_BASE_OFFSET_F(v) \
+	host1x_uclass_incr_syncpt_base_offset_f(v)
+static inline u32 host1x_uclass_indoff_r(void)
+{
+	return 0x2d;
+}
+#define HOST1X_UCLASS_INDOFF \
+	host1x_uclass_indoff_r()
+static inline u32 host1x_uclass_indoff_indbe_f(u32 v)
+{
+	return (v & 0xf) << 28;
+}
+#define HOST1X_UCLASS_INDOFF_INDBE_F(v) \
+	host1x_uclass_indoff_indbe_f(v)
+static inline u32 host1x_uclass_indoff_autoinc_f(u32 v)
+{
+	return (v & 0x1) << 27;
+}
+#define HOST1X_UCLASS_INDOFF_AUTOINC_F(v) \
+	host1x_uclass_indoff_autoinc_f(v)
+static inline u32 host1x_uclass_indoff_indmodid_f(u32 v)
+{
+	return (v & 0xff) << 18;
+}
+#define HOST1X_UCLASS_INDOFF_INDMODID_F(v) \
+	host1x_uclass_indoff_indmodid_f(v)
+static inline u32 host1x_uclass_indoff_indroffset_f(u32 v)
+{
+	return (v & 0xffff) << 2;
+}
+#define HOST1X_UCLASS_INDOFF_INDROFFSET_F(v) \
+	host1x_uclass_indoff_indroffset_f(v)
+static inline u32 host1x_uclass_indoff_rwn_read_v(void)
+{
+	return 1;
+}
+#define HOST1X_UCLASS_INDOFF_INDROFFSET_F(v) \
+	host1x_uclass_indoff_indroffset_f(v)
+static inline u32 host1x_uclass_load_syncpt_payload_32_r(void)
+{
+	return 0x4e;
+}
+#define HOST1X_UCLASS_LOAD_SYNCPT_PAYLOAD_32 \
+	host1x_uclass_load_syncpt_payload_32_r()
+static inline u32 host1x_uclass_wait_syncpt_32_r(void)
+{
+	return 0x50;
+}
+#define HOST1X_UCLASS_WAIT_SYNCPT_32 \
+	host1x_uclass_wait_syncpt_32_r()
+
+#endif
diff --git a/drivers/gpu/host1x/hw/hw_host1x10_vm.h b/drivers/gpu/host1x/hw/hw_host1x10_vm.h
new file mode 100644
index 000000000000..75f5b881c561
--- /dev/null
+++ b/drivers/gpu/host1x/hw/hw_host1x10_vm.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#define HOST1X_CHANNEL_DMASTART				0x0000
+#define HOST1X_CHANNEL_DMASTART_HI			0x0004
+#define HOST1X_CHANNEL_DMAPUT				0x0008
+#define HOST1X_CHANNEL_DMAPUT_HI			0x000c
+#define HOST1X_CHANNEL_DMAGET				0x0010
+#define HOST1X_CHANNEL_DMAGET_HI			0x0014
+#define HOST1X_CHANNEL_DMAEND				0x0018
+#define HOST1X_CHANNEL_DMAEND_HI			0x001c
+#define HOST1X_CHANNEL_DMACTRL				0x0020
+#define HOST1X_CHANNEL_DMACTRL_DMASTOP			BIT(0)
+#define HOST1X_CHANNEL_DMACTRL_DMAGETRST		BIT(1)
+#define HOST1X_CHANNEL_DMACTRL_DMAINITGET		BIT(2)
+#define HOST1X_CHANNEL_CMDFIFO_STAT			0x0024
+#define HOST1X_CHANNEL_CMDFIFO_STAT_EMPTY		BIT(13)
+#define HOST1X_CHANNEL_CMDFIFO_RDATA			0x0028
+#define HOST1X_CHANNEL_CMDP_OFFSET			0x0030
+#define HOST1X_CHANNEL_CMDP_CLASS			0x0034
+#define HOST1X_CHANNEL_CHANNELSTAT			0x0038
+#define HOST1X_CHANNEL_CMDPROC_STOP			0x0048
+#define HOST1X_CHANNEL_TEARDOWN				0x004c
+#define HOST1X_CHANNEL_SMMU_STREAMID			0x0084
+
+#define HOST1X_SYNC_SYNCPT_CPU_INCR(x)			(0x6400 + 4 * (x))
+#define HOST1X_SYNC_SYNCPT_THRESH_CPU0_INT_STATUS(x)	(0x6600 + 4 * (x))
+#define HOST1X_SYNC_SYNCPT_INTR_DEST(x)			(0x6684 + 4 * (x))
+#define HOST1X_SYNC_SYNCPT_THRESH_INT_ENABLE_CPU0(x)	(0x770c + 4 * (x))
+#define HOST1X_SYNC_SYNCPT_THRESH_INT_DISABLE(x)	(0x7790 + 4 * (x))
+#define HOST1X_SYNC_SYNCPT(x)				(0x8080 + 4 * (x))
+#define HOST1X_SYNC_SYNCPT_INT_THRESH(x)		(0xa088 + 4 * (x))
+#define HOST1X_SYNC_SYNCPT_CH_APP(x)			(0xb090 + 4 * (x))
+#define HOST1X_SYNC_SYNCPT_CH_APP_CH(v)			(((v) & 0x3f) << 8)

-- 
2.53.0

