Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E361CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01B210F288;
	Fri, 12 Jun 2026 06:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ut0tl5Sf";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012017.outbound.protection.outlook.com
 [40.107.200.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435BC10F288
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWOyY7q6zyIi/FY85xAN2z0qO4MK5Ztd4B/J4b1KIpP0NQvoC+FVCuNF5/DcnJddmeugeqd76KLyvbhy6s4l0zyb5TtCGBaLBvvIIChdc9QiOdOjgce6rDriz/ROBmSUC8Y7sA+qPkIQ1E3ohtQzUeaL7o+r0rxi76eaQfGxH7WMU87AjvgZ3+XMw5lWhTZ1lbpQawkw+YFJ3OpNLjAtV+Mp5j0oa3y5ELX6jtmqAUiWyuOqBm4eP36Jmzrv9Zc8IDoUhfGT37fhJ4fnvjfML0alyU98bKNV8CcABsbYlDyJEeUdyvD+irQP/s+lTkSnvn02XipyD6hXS+SgzwKnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XazvoovfNWfP5yrB6CKq9CPFtIYAO8XSX8SHYr0ImRM=;
 b=EY5TM5zztO/J5EsE/Wit7t2O9mPOtlS361pGO0Fi+sw4/mqiHCZOijws6CPQtwS/sjhq0LNh+IttpQ5TYy7vWd3EVbQZfG0GOmWXv5aG6x1YbU6ZehfTN55nswTjIvi1zo2bB4E0syMvxygktAJqtisEfFxeXyvFB366/jmZNE9jX/D0w5wnRY0v81Jw2tYYjC+YNXiQJgo7GdTpDxY5yBTPH22oHH+DJoYLCCuu419m9LHLlHSKUthRfwiES+VJgfAoCNo1HdW9Pf4g9SiIHuig66kw8SC/b2saUJrNcatfdZYPTPPTPsa5L1NDUa7XHWH7VCRBQq/9KgjY2YpRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XazvoovfNWfP5yrB6CKq9CPFtIYAO8XSX8SHYr0ImRM=;
 b=Ut0tl5Sf0lSzbKaP8/Dw/mYFg/nDeWxrqTZEVdFkPtVEkMBGEIojRMm0PK5iyRudxY4JkoFuoHQDp5TAGaZe0LpzOTYHMUr6vm0IfN/uWdUF9mm5cCgzBi19CDdX3y0gk7jFfCId/9j4KSk4T+kiNgPkCaJiyTSnVlxMTrlfulPANnB5JLej/cU19YJzx5Zg0qUcXFDUAnboIKB6wqE37rXY5gop+pGBh2pETCFtjiuaTrEQjXSpn1NJzCLWLL4BhBP2k35ZDqlc6SH6/4/MUfrOFyQoaJAQFlD6nTYRogx/moQJIFIBZzeCquZ/CT9dFs7VczD8hW5c8djso8NiAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:33:53 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:33:53 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 12 Jun 2026 15:32:32 +0900
Subject: [PATCH 4/7] gpu: host1x: Add Tegra264 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-t264-host1x-v1-4-8d934987de67@nvidia.com>
References: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
In-Reply-To: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4fa5ab-9f22-4ffb-f277-08dec84c9253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|10070799003|376014|366016|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: T9dpqJwP+HMEJcr6DU8c7WtYV8DtN+8oPlHpKUYa/pOBi0j5o76bKNFWAy+pibzqfiJ/gTWz3uTn6xqvLsI2e/wcdrJk+c1scv2+0bPT7OzjlbtVrLwGy9q2JhY1KL8U1F+y3J61F8XdwnDjO06Jm+5zk/frL5w+RDIZWHGWzFkpSwRHdc0YzpHfEBcpJpLLvggEKgvGDmzovw3qAp0/7lwXtYgXhdCAoaR/4wuJPkwbICwDcZcluGfcgSogLsCxqsbUrZpaFFwsLePS+6RA27zyKyHKMhBmOqTcKqG11vQ05q+iMovllAW/0xBOoBISG3HRoatpcK0jWifBKHSvubRHpno5NMV/pP+CLqhzslH22JPFPKqYviGRc8qjNJKQtxH2VZNuao7L01j6FcpML5qmgwj7cFiBp+ArcYvlnKRyQnLSRYvDv0zXqa1G7iItHPE+efqzg2WczfYWFuPwbaWyQNJ8/Lhqp1EWOqxjPFBv0NbyRhFyBrZj6qYmraofXaum6toQaaRmZhtDtsBErg6l6kE0gqu8zmDuh2EMHDSvKpZzGSRWrjiVxkZLRXKLJEMjpR7u+Yzff+xSWGgNI/yLZbZbvDY6llfKsJVh+8CUDpeDH5LD3EvMRyXBp5/HxHkfW+u2bOjHqfSi5N1oaV2gREv3m+nz5d+LvYkEDkUgiXXQHQgm5RRXZEk+lJWciRCrXKkEVc4IMtjqo13izP99ljSiQ2n7qkL+8g4vvHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(10070799003)(376014)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlR2cUlrYTZXamcyVXdvc0Y1eWJRWHJKN0xFVEpQZDV1eGlOaDBVRzJoOEIz?=
 =?utf-8?B?OXFrQmRvcEZ4SkVQYXF5RVg1RUx1eDIzVytNQkozVEtSSC8wQlZWcHZLK3RH?=
 =?utf-8?B?VFNJbzlFbzJFUHdhdUNFYmV4NU9RbklERTRqUEZoQmZsblNITytjbDgrdGxh?=
 =?utf-8?B?REJUcHNGRzcvTm9ra3pWUlFadTFIZWYvdGVlZDArcTdUVjRpUk9DUnhVUk5M?=
 =?utf-8?B?eUM2dXBrTEc0aTVENkNRaTlKWlZwazFpN2hOSmgvY2h4RG94QVB0RStyY2hK?=
 =?utf-8?B?VGJCYzc2YzdIVVZVanoyMWhEYmI3aEtSY09xL0ZTdmk4UDd4OFBmSm9VT3Zt?=
 =?utf-8?B?VFlGVTRTbkNZNnhVU0NkWUdPWGdidmlJcTFuMkhYalI4UDhwUEU1NVd2Q0lO?=
 =?utf-8?B?bDMwS3BndmR3Y2VZTnozRTVwNWs3Q3k5S2NoNW9ud2xxRnkrTmlGZUdFRkVG?=
 =?utf-8?B?ZkhMN2k2U1RRUTBLNkFTTHlhSVRERi9uUWVhby9UVElRY0FQZEl4ODVIOEUy?=
 =?utf-8?B?eXFjM08wNHVRMFVUYVFFOW1JejAxNVRwY0ZCdVVTRVJhb0xpc3NQZ3YzdHlj?=
 =?utf-8?B?REo0MGwrbVJZNWtvWVNYTFUyVkZ5bU15R3VUcHFkc0hlcUpUZUtjc0lIY2Z0?=
 =?utf-8?B?V3JEa2FPTzhUL3lodTl5c2JRNmhIeVFQRUpQa3o1ZmY0aGR6N2dsdFVPQnkw?=
 =?utf-8?B?clZ2Z08yNEh6QWtyQ2c5TGJVMjgwM080dVpvMWIzaVU0Qjl2N0hIVDdDeG5o?=
 =?utf-8?B?QUtUVjVSTm5KQ2FCd2MxazNrQWN2VGM0dXpuTHRwTTlFd2ZtRE9na01JdWxo?=
 =?utf-8?B?RUh4cTMwNnVTWnNjTjB4a0x2K1FJanVjZFBKdm85U2JPanlvYnVoYU9rWHlt?=
 =?utf-8?B?QnpZSTBIZ3dSQnpYMEF5MkdtSjBUTXpZT0t6MzF0WGp2TXBHK3VjSWZHRFNx?=
 =?utf-8?B?SmZXU2ZCRWRXTnc4dTl1S3RCR0kxWDdZeGlETFVTbVpuMm5RZFVSV2NyTG9m?=
 =?utf-8?B?Rys5RjEwa2ZOZ3V4c28wOWhGSFRwMkM3NUg5NHM4ZVFzanlQVEZZNmllb3FP?=
 =?utf-8?B?WWVjSWZXemxiVVZ2RjhmYUp5bzQwREFOUDdKREYraGZKZGtaRkxOLzFSemk0?=
 =?utf-8?B?UlQ1S00rS0l6ckc4enFzMlZCRFh0NlJiTnQxTnM4bSsrczZjRjRhcWo2NElH?=
 =?utf-8?B?RDE3N3AreUtEaWQ2cFpGWWlxOE9lQ0Y4dnFTYk5zOElGVUdld25EdTk1N2VU?=
 =?utf-8?B?ekRpQnFuRFU2cG0raDJaY2txS2JZNjMzajVYc3BxRHdrZ0h1aDU3QnpBS2lx?=
 =?utf-8?B?Y3ZaaUJzVlhHMGNsTXpxSjVDNUVKQ25xT1pLaTRlK0Q1NE9uOHFydFpsZDZm?=
 =?utf-8?B?djdNaUlPYjNsUGZKSklWeThIS2xqVzFaR2paNWZqbzlqSnVnMUszZ3RuQlNK?=
 =?utf-8?B?MmVFSmV5MldNNVFzMjhJKzN6cWdrQjlYYkhkR2huckxLQ2FJVkZ4MUZ2WnF1?=
 =?utf-8?B?VWdEVnIvNlo3eDNDaVcrZEhoeXJIaGpQaXNQd1R4cG1teDNTNlZVZnlTQURS?=
 =?utf-8?B?N0VNaDBwT3BxZERxdFkvMjZLV0swNlhpdmNQYWtmZlJDSy90bncrODhCcHNS?=
 =?utf-8?B?NUJwbStYd3FrNVYyR0FxRXRBVUlFaGRiZ0c2NjBwbzBLR08vL3FwU3I0TlFL?=
 =?utf-8?B?aUhEMWJGbXovQklOYXR1U1cwanZqZTlzbWcvdDJKUGNJejlRSGdXUnhvM2Jt?=
 =?utf-8?B?M2drZ0JNZUhSRkFCa0dPS2Y0Zk5iU2xDbXlvVHZKVmh2NytxMFdWVk9nbDVD?=
 =?utf-8?B?ZVpraTBGbCthKzl0SUtYd01VaHZMZHF2RWxWKzVJaTROVmozbkU0VkN0NHM5?=
 =?utf-8?B?ZnJZc1NDVmVGVVRPMmRQTTBlZ09MUlVVc0JQTjFhT0FnOUZBd1N5cWY5VVkr?=
 =?utf-8?B?LyswWFdxaTJ2SGN0VXlzM21ZOUYwVC8zcG95cmtLQlJRcVVJa0pHa0hNa1Vz?=
 =?utf-8?B?OVZIQUlnYzYwdllRWjV3cGtxT1RhaEthVEV1UFlBZzRUQkVIMS9Ib0orT2J4?=
 =?utf-8?B?OXZMK1RmaVhZN3ByeU5CUDFORHVmckthd1ZidkhqYTAxUXM5REt4aHpiTC9P?=
 =?utf-8?B?UHNoYlVhVGUrUjZwN0ZLZFhjRlQzYlNMWXRpcUNHV0JscE9tU0NyeG10RWVt?=
 =?utf-8?B?Sk1QTjZlUGRxNEY3VXJObVB3NTdQSDZlRVFVc0hnMys4T2dJRkJmY1B6NVNN?=
 =?utf-8?B?WGdSZHh4d2RVM2V1RW5FdHl3N2lMZ1crbmtMMGJSb09HUzJoRStHSDNJbG5C?=
 =?utf-8?B?azQ0bnh2cjBweDExM0Fya3IyU2c4UjlCUjh3N3NZNDM1Qms5b0RjRmFtcGhP?=
 =?utf-8?Q?fKK1BWdiV9aXgWNrhVvsK9fn+DRpRQHk7sI367ZT5mr+H?=
X-MS-Exchange-AntiSpam-MessageData-1: 73TD1WT7Cq3JrQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4fa5ab-9f22-4ffb-f277-08dec84c9253
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:33:53.2828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTaK63xhsRnAMPL3L2CyzgVHlc+eaXeVyM1atbou9jfo2siPElx9R27RRJHJ7qUEIwxlg/ztuzi6+Qrb0iKeIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

