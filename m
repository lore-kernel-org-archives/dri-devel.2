Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF2C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C23910F7CC;
	Fri, 10 Jul 2026 07:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqks0vgI";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5D010F7C8
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4RhXqAY4FPZNJUThRQVDNpTeyspnhdKg2yP5Zv+55gTBTU3ZJipGCZP5Nk3JPIxe8bq7gXTFP1L6qAfWN/i2oQqdde5OkxpoLraaF2s2Z7ggfTR/zF70CC0PW0VHDHqv142UrVuRGne6Q9GGtBUsQv8Mo8YDof0ZceUvKR++BrpvJinajq2/mOj7uV2PHZQViabgAFMmgeqQEY1ZO/PeW9q8dK26DChshGeJn6URcws/2NVnhDosOYZf79ZTQzI9ngisFMAG+h0AQFBl4SyWtdQiH+FIlW8t+TU4qjl3vqlj1nQZHXawe1AINJjSjpjEzrQDCfAFyVw4+kDj1fO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZTHU2OHErg4j0fM23tYV4wUQ2qeS69Yrg98Tb6UPqA=;
 b=aa8ohjhCZSHTZ3dQt7ZQ7JAsHKCPmJrYzqQ64/BdAWr3pNxMCHARaq2vz+bwSLbG8MkiZVGN/ikejEmkgWtQrurSSk4BBtpdlwNgJqbJddJc/ons1LmHSy2XJHV5SKES7e+3Xd6AojMV2L0slwRE7QOeHmXvECZxgIGD03apyedvcpfOM/Y3dQyASN1kkNEoj5vctHMwillWCkw8M6wGKL+FS4TxSmS99840bPgvuKKsQiAJiZj7jDGZXCD3Exdaak3gXzSKI6KhVvN2fOM+DFYZe9xj8e883s4K0g1Y+cuIF2d3ZePCm1mwNDbYWdhxX+HILnCqJQ5vCL1oQNgHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZTHU2OHErg4j0fM23tYV4wUQ2qeS69Yrg98Tb6UPqA=;
 b=eqks0vgI+rP/1gXdCTnEjIN74y8oUsL8/3shJM9s0DCRZv4t81a7PpOZTq+re3RDHxXpmHgYveNAyIzr4FXzPN9ulNbK73LOEhk275wuM+GqF65VptUVPsksMKws7db6mbHdz8s4kLiT0wSCr3X5z4sYiP7n7lAP5cBAnoZ/Hooo1qC1oVMXmoeeFCpzj0lg0F4fFvAFzlJu7i4jUrTed2OmJO4qni8m2pdPYLVKvhsAxEDdBrebvfvZmnR09oDVO2wl3oxZxl18SkWK7h15Qhznz8L6CL/ihmWbRU2x03jiGz8dL6ENCVB5MvJIJxiNMIZAOy6ot44DifHv93ydXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DSVPR12MB999124.namprd12.prod.outlook.com (2603:10b6:8:38b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 07:15:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 07:15:07 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 10 Jul 2026 16:14:32 +0900
Subject: [PATCH 2/2] gpu: host1x: Add option for disabling context stealing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-host1x-ctxsteal-v1-2-b1f8f6b37cc5@nvidia.com>
References: <20260710-b4-host1x-ctxsteal-v1-0-b1f8f6b37cc5@nvidia.com>
In-Reply-To: <20260710-b4-host1x-ctxsteal-v1-0-b1f8f6b37cc5@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS7PR01CA0249.jpnprd01.prod.outlook.com
 (2603:1096:604:24b::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DSVPR12MB999124:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dbce80-ca32-46c0-b6a5-08dede52f8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LWPB3ysQXT7ENS61HhnVzHiRTtGxEgIrG4AqGkIc2CTMy/Wz62f4L3Ulkg2rOa65mx7Dd/KWq5oz6qI6bkFBwPXpD+7UOvQo88S6sGlb5zSfiw+ZhruTcGS6zwzHBxCjzms3Hj2SHSf0jzaGbwwk0h5cBOV8kTQ7h1fZ8FzbByJe314IlYD3m9hgLvQtZ7bBz/2XYH4FAd/CoJ60Z1AOpunuHxXtxoJXIKgcG7GVukikyNb/D6HLktabiuxJPb2oIwg8VHLIJbOrEx/V6plwg/JPi5DP3RBabv2B9zRUdifMsfqNuIh60OPn//kiTqQDtlp2bTQlk6/d6nJeUKrhYfA6h96JsGoL9lXrSxcQ0wDqN2tGiPDCc61tXHTv2lGUxcbRQ6FqIt0PGoPhXvyK0oyCogQGKkgUBwmLNalcggoVM+mU56+oJCMsWk/LSq21E/zhW5BK9JDldFtG9Gd2KjxY7Z2LlUiTsbmk9VaRiWAKNff5IdyicYQFGQSwZSEeSzRfW36aQasoklIto/etrPHEWlUOaXXMGX1N93lGYgsIJox6PR8LpRvYyvlvjdYof9w2Lg8psdbW48BDw+xQJki4KsirnyEJ8fcbdobTv/ugWK8vrRpcSERnz+L8V341VTkCsz0uLk7NQjaDbi9NHBPqV2QRM42TYwPJlgDzXMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEM2Zy8yY2tSdC9Jb3FOTjdQVlZoZkNwNE1OMlBxTW5JYkN6STZiT3Bkek1Q?=
 =?utf-8?B?TmZUNTV4TkJnYVhVYkUzL1FYRXgySGQzTzdiWmJockd6ZXJKN1lKUS9mU1or?=
 =?utf-8?B?bDI1SjZvb2V1MEtScTRuV25vL1JMaHRCNXdxejJveUpteUFJRXdSc1Bld1Rk?=
 =?utf-8?B?MVdZcG5qYUZvcEcyRFhyQmROR2cwaVpFWWx0ZWorS2hSZTduMmJ6Z0E2Y3dQ?=
 =?utf-8?B?bnJldUpzU3BzQ3VZMDluMnJYWHlGbENRNmQvcWZPbjg5UXFPSUtjQXJ2SzNw?=
 =?utf-8?B?K1RLS2dMRWcyaHE0aEV4NFBwNXJnRnpGaWtoZFN6ZWhFd3IvMllJcy94d3dY?=
 =?utf-8?B?bHQ4RTdsWFZXYkxRU1Z2NEx4WFdzYi93S1pCVUpTL1dpWmoyTXd3ekkvYkFY?=
 =?utf-8?B?cmp4dFhScDdqWVVVZ1NKcWpjaE94OWZJdElvdUtTR1R1UVRSaElMZFRYYkR1?=
 =?utf-8?B?OExFUHkxOTBXVE1XY1htdzgxV0tXZ0xPNHU1QzFsUHlOMTN4a3FwZ1drU0xF?=
 =?utf-8?B?VXdGRUVqL1h2UFRKSDBUY3BxcjB5Mlp3WE42RlJwazdUeXRxUGxPVElhU3hl?=
 =?utf-8?B?bkR3NUYvODBYaUg5VmxnZy85Y3JvV1VnVWpMNzZMT0xYSmJxa0dQQXUwd3lM?=
 =?utf-8?B?WWJ1ZFRESG5XdUFZT0R5VTlCTXVNb2ZNYnBlaEF3VUFPMGMvV0ZFdFhOQVhD?=
 =?utf-8?B?ZUVsVEUxVVFNZ1M2azBNTHNsc0h3TTF1NXR0T1pSN2FQaGlhSXI0YjZPWisw?=
 =?utf-8?B?Wi9Gbnh6NC92TjZvOEhPLzlWMUtnbExyM1crZGxVbkVIejJwVUpqdkRHZXpI?=
 =?utf-8?B?UmxkVS9DQisydUdvcllDK0g1bWlQU0ptZld2VktYU2tvci9VRmdzOFZpV3Na?=
 =?utf-8?B?Mndhc0JxTXphejl6bDd1WTB3cDAvQ253eURlZXpSLzZ0L0kzVndWTHRERUpE?=
 =?utf-8?B?c3lkekZ1Z2RZSCtWeE0wd3M4VU1lQ2gwNzE4ZGZBcVhPQVM4NEZjZG5CN2xP?=
 =?utf-8?B?U3JIck9nemhFNzdmc0pZcllIYWx5WURhRUIyMUJZWnVUUGxLazhxakc2RTUr?=
 =?utf-8?B?TGJqbkRMRDRsdlNOU1RPT3N2dmtORmRHc00xbHRJZmZQc0ZXQnliMUxLQXVY?=
 =?utf-8?B?d1c2RVdXOHdKRjZGMFphWFcrTzVYWmNhd0RTQ1pIZzNKWlkxYkVuZkZDNTEx?=
 =?utf-8?B?UURFeit1amdZOTVhUWJUd0ZYMXpwZk5MbU4yZEgxWmJHMHZxeVllcE5CYXBs?=
 =?utf-8?B?UlpQTnljRVAvS2dUODExS2Q0dzhiWmd6UnNwSEZJYjJtODdGNFBuWG84eWxx?=
 =?utf-8?B?dnRJZjVSc2s1MkpBTDM0S2JvWWxJY1BVU1I3RzlVWU9ONU5MK0U0KzdvWTZF?=
 =?utf-8?B?THc0N3ZqS3RtRDZBbndrQU1DeklIczBwZkdFeis0SEd1WGp6OUpreHVrdXZP?=
 =?utf-8?B?ejNRZW81MkpncHgwL0hzQkpndnRTYnMvWGR0WUlvb0NXR0YyOXNHaHdmOVlm?=
 =?utf-8?B?c29qcU9MaUxwazFsbWJaNFNHUU01bE1hK0lVVXBJZXNBSld0UGpaUDByS2xF?=
 =?utf-8?B?dFM0QkhONFVMTWJoVDFYS2J5OXM1eE1QZEtNMHlNeTRUZVBmZG1LQXd2TEFu?=
 =?utf-8?B?TnpyTkNCS0NkbU5BV2w4dHVuZ3lnRDRqbnZwMlBJeFdXUXpUOGtpOWVLcHZP?=
 =?utf-8?B?eHVpbFVxRXBvaFVtMFlUQ2JESzc4QlVSUGEwMThPWFhPQjZHR0xsNUVPYUda?=
 =?utf-8?B?L0V1dVdycjZuZFNIM1NQOThSR1V1clBtWDJUR0VETlBJMHZDSzhUZkROYmpU?=
 =?utf-8?B?eDlON0hWSXJQcnBzbXJucVFoWkJGSWxOYWtoc1owck9JTEg4SUV6MEttdnRK?=
 =?utf-8?B?VzU4bEMvdy9EMjdSQmJobmN1U0wyTEFPZFAyV2RzS2dDa3U4VjRqSVg2MDBO?=
 =?utf-8?B?ZWRUaXlLU0NGZDhLdmxLNU9oUHVnNzZQMkV6dWFONnd6dTNDOEtSbHcrZkdj?=
 =?utf-8?B?cC9PalV0RG90eUpFcnVnM0NSa1lCQVBxdWg2V09RSzJEakprN21Qd0trZjNw?=
 =?utf-8?B?N1RTTTI0QUtEUlpyTWpVajVGVlp0U0ViNE1ybWxZdURSRTVLcUJQbnUrblBx?=
 =?utf-8?B?NnlacStIVUx3U0RZd3hTNFpmU3A5a1ZReW9jekRkVTg3eWR4NmR3RDIveWVP?=
 =?utf-8?B?cHdNdDJXYSttNVgyU293Q0JCMVY2U0hsOFdoNFo2QjdMNTA3dzIzeTk0Witk?=
 =?utf-8?B?RUNtaXV3R2JrOTFKeDNsN2FRV3NPenU3bER3dUV6WFUycGR6UlBYNzdoZENm?=
 =?utf-8?B?OG9rd0lva0dzWXNGRTlicmJKbDFscS9aUmg3ZWVGZldrSFRVeTZkWVNWa25z?=
 =?utf-8?Q?EwpX58IwY0yKJ55VXd77Q933YOlRqS1zQxqB5AQPolmsN?=
X-MS-Exchange-AntiSpam-MessageData-1: q0k63C7S8rrjsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dbce80-ca32-46c0-b6a5-08dede52f8ad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:15:07.4843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yrCcN75c8Jzs4ktrMQnmEKNbdS3+N6ogA9EQNQhmkCC4+krGQOyDXhkqSsZ7yedg4JoGRb8rLYh5kxCRvQ/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999124
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

Add kernel module parameter to allow disabling context stealing in cases
where reliability and consistency is preferred.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/context.c | 62 +++++++++++++++++++++++++++++++++-----------
 include/linux/host1x.h       |  1 +
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index 8c159076d0fa..ddc293a5810c 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/moduleparam.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pid.h>
@@ -15,6 +16,10 @@
 #include "context.h"
 #include "dev.h"
 
+static bool static_context_alloc;
+module_param(static_context_alloc, bool, 0644);
+MODULE_PARM_DESC(static_context_alloc, "If enabled, memory contexts are allocated immediately on channel open and cannot be relinquished while a channel is open");
+
 static void host1x_memory_context_release(struct device *dev)
 {
 	/* context device is freed in host1x_memory_context_list_free() */
@@ -167,7 +172,7 @@ host1x_memory_context_alloc_hw_locked(struct host1x *host1x, struct device *dev,
 
 	/* Steal */
 
-	if (!can_steal)
+	if (!can_steal || static_context_alloc)
 		return ERR_PTR(-EBUSY);
 
 	list_for_each_entry(ctx, &can_steal->owners, entry) {
@@ -221,6 +226,7 @@ struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
 {
 	struct host1x_memory_context_list *cdl = &host1x->context_list;
 	struct host1x_memory_context *ctx;
+	int err;
 
 	if (!cdl->len)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -236,6 +242,17 @@ struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
 	refcount_set(&ctx->ref, 1);
 	INIT_LIST_HEAD(&ctx->mappings);
 
+	if (static_context_alloc) {
+		err = host1x_memory_context_active(ctx);
+		if (err) {
+			put_pid(ctx->pid);
+			kfree(ctx);
+			return ERR_PTR(err);
+		}
+
+		ctx->static_alloc = true;
+	}
+
 	return ctx;
 }
 EXPORT_SYMBOL_GPL(host1x_memory_context_alloc);
@@ -281,6 +298,11 @@ int host1x_memory_context_active(struct host1x_memory_context *ctx)
 	hw = host1x_memory_context_alloc_hw_locked(ctx->host, ctx->dev, ctx->pid);
 	if (PTR_ERR(hw) == -EBUSY) {
 		/* All contexts busy. Wait for free context. */
+		if (static_context_alloc) {
+			dev_warn(ctx->dev, "%s: all memory contexts are busy\n", current->comm);
+			err = -EBUSY;
+			goto unlock;
+		}
 		if (!retrying)
 			dev_warn(ctx->dev, "%s: all memory contexts are busy, waiting\n",
 				 current->comm);
@@ -418,24 +440,11 @@ void host1x_memory_context_unmap(struct host1x_context_mapping *m)
 }
 EXPORT_SYMBOL_GPL(host1x_memory_context_unmap);
 
-/**
- * host1x_memory_context_inactive() - mark a memory context as no longer in use
- * @ctx: memory context
- *
- * Drop one active reference taken by host1x_memory_context_active(). When the
- * last active reference is dropped, the backing hardware context becomes
- * eligible to be stolen by another context, and any waiters are woken.
- *
- * Must be called exactly once for each successful
- * host1x_memory_context_active().
- */
-void host1x_memory_context_inactive(struct host1x_memory_context *ctx)
+static void host1x_memory_context_inactive_locked(struct host1x_memory_context *ctx)
 {
 	struct host1x_memory_context_list *cdl = &ctx->host->context_list;
 	struct hw_alloc_waiter *waiter;
 
-	mutex_lock(&cdl->lock);
-
 	if (refcount_dec_and_test(&ctx->hw->active)) {
 		/* Hardware context becomes eligible for stealing */
 		list_for_each_entry(waiter, &cdl->waiters, entry) {
@@ -450,6 +459,26 @@ void host1x_memory_context_inactive(struct host1x_memory_context *ctx)
 			 */
 		}
 	}
+}
+
+/**
+ * host1x_memory_context_inactive() - mark a memory context as no longer in use
+ * @ctx: memory context
+ *
+ * Drop one active reference taken by host1x_memory_context_active(). When the
+ * last active reference is dropped, the backing hardware context becomes
+ * eligible to be stolen by another context, and any waiters are woken.
+ *
+ * Must be called exactly once for each successful
+ * host1x_memory_context_active().
+ */
+void host1x_memory_context_inactive(struct host1x_memory_context *ctx)
+{
+	struct host1x_memory_context_list *cdl = &ctx->host->context_list;
+
+	mutex_lock(&cdl->lock);
+
+	host1x_memory_context_inactive_locked(ctx);
 
 	mutex_unlock(&cdl->lock);
 }
@@ -478,6 +507,9 @@ void host1x_memory_context_put(struct host1x_memory_context *ctx)
 	struct host1x_memory_context_list *cdl = &ctx->host->context_list;
 
 	if (refcount_dec_and_mutex_lock(&ctx->ref, &cdl->lock)) {
+		if (ctx->static_alloc)
+			host1x_memory_context_inactive_locked(ctx);
+
 		if (ctx->hw) {
 			list_del(&ctx->entry);
 
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 07f7dd6fb4dd..46bb71d23266 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -462,6 +462,7 @@ struct host1x_memory_context {
 	struct pid *pid;
 
 	refcount_t ref;
+	bool static_alloc;
 
 	struct host1x_hw_memory_context *hw;
 	struct list_head entry; /* Entry in hw_memory_context's list */

-- 
2.53.0

