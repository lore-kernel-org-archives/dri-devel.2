Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DEFCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7363210F278;
	Fri, 12 Jun 2026 06:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+CEAO5C";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C83910F278
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igXVTIiXYrQwH5ZR6rXV3KwQJMhsxpkvFgvYNsBnaUqTOWiXrWxC3MWJJYmrzT7hCVgywQk1wqBmZixXfPpEJiN6hpiLko+dGvrfkmrozNJgKJCjVtHJSfP/IxDukxJixmrCK3lqjNSDyoDnwd5sBPZhJWlMzN11LZlQfqRc5iaaIs5ndKHZxY+Uv+GIZeFrxfILbv3IYOSOVlSv21ZsBB5Y1fkyG2323kjfN8al8YBtvY/H4JUz1sqNE09RruEH6wzdYgFSBh75sbYn04LZVbsljdrLhnLg/uzuPoSipVL6EhZ6pKAQKQSqQC40B5Eq5CNWB/5pW0yV6z87zGCc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzqTCg0R/p/QmE0fyh51kTb4TZfSQtZuIW3Vl4GkIAs=;
 b=J5l1vpU+Rh3m8XPdGWntSsEJujJiiTvJnNuT/FUFOswslb23FDmHZ7ji+AoHGnK4qo//At18aeYbxAOiI2RtzB2P30ZLvXwdols168QpK9yv0g+s373AecWGlL/Hab00mMvrnDZ0yw8UdB9Iqf/bvJB/vrEvIHufk/MaJhWJNUkC4eRo3FbgRALsZVsl3/C9maotdnTdIlELMeNF+RyHXebHVaBwu3LXM12VYXyVWFY0ynDL11n4VKrge+6YGZBKBqm3aeCCbwXuh/YG/RUme/vICdpACBjipH5oYM/PfwX22i4/i4JcDxs3gfzItMEsYLGOvYC/tfuh+n1glKBNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzqTCg0R/p/QmE0fyh51kTb4TZfSQtZuIW3Vl4GkIAs=;
 b=q+CEAO5CDrYZBo3LZCpDp6RrWcd5yT9fUqCeI3+4CtwmJHgtm51/X/jMcX8bgxnsMKlXzyRi8A8XiNlG/4wSN3p9UHLki0DgR5ftvmNDVa3/zah7x9iI2fWHPSmKhurnQkAYkaSfvM34LJm9EcQM8qukS21FdxZem/OoTUQiib4TXWVePFKllMtG3rzDZGiy/lVtKa3NPM3rTwJNTC6UdOsIuwt19WoWC5Dt5dt0RJNTTIvWPt+wNgcJAFl3UnkDWcjwvDop9wAOo4niQxje2DmLsUnFfJ1ut77+WLLgmqyQoqWt1zyF/5FQ3ed7jPA8TLkKxoaLXgwfBE4G+Ez1LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:33:48 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:33:48 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 12 Jun 2026 15:32:31 +0900
Subject: [PATCH 3/7] gpu: host1x: Correctly parse linear ranges of context
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-t264-host1x-v1-3-8d934987de67@nvidia.com>
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
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4PR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: ff88d5a4-d019-442f-aede-08dec84c8faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|10070799003|376014|366016|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 0uytUszEl9KeXuHyZaY4L3Qp7ajq9xL/t/uZHpf2SYn2sQiiJSgw5b55sm9eCKZDq+0E8PuYK1YFggLqKQMdie8GoBKqLk70RQnHNGrF6vLrt4OV0XOdAvOqNlz7DyF9g16OXT1p9A7XksqBgiexJq+/6W7nxvcWJMZO0sDW1qABUWPDoCYssQS+DykxntNTwC9HAoCJWrnPo3c/llk4cgtHHNYkIIMfErv7LrN2ucFBifSTVu44cfaaC2IzcEkjvXxJTDnCE6atn3ALAUNDRdVsMnnzCIImMx9+U2F0TcVCuBGmwEeKWqqTdxnvPvdcJB2kQc+mRt6V074vzxoPNQREwbOgXQLrJzUtNyzjdXtdd5IT5WdMbWXEijOvTcBflNDT5jdPY0W6QlPFId4/amiK5mgFzBDsnQfWzYTpGP7ZzYxlQgp7AXUIZ+7BruOjBfa5EA4UmK2BkMJKNYiSrvX/aOIxyV4n4BSMU8pQ47W4FReF2wpui7ArVxyLfGCDGV0Uj8vUHgS/J1kkwqsmeZXW8GX+wMenkEeNQB5xsBVk5N9Vct3UWaTPB3MzBqEli8pKWTHbpkXRcsnpvFrTQE6sfIcYQDbtLMhWW+qLrIBewZX4DyP3Yn2r5eKIlWMAaGwpnwDvsFbabmj8peQcHrGE6OcyXK5+Gzxplrj365kfXnUGaGL8vz44x+iojM4bBpPxTyCjx3GYqYJnk5NykCqkSRZ7wzt2FGTLOLtPwCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(10070799003)(376014)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJLeHBsUzBCTmVYYTNRZHltblhSdnplRGtnblQzei9sdldLWXdPdFpVSmdN?=
 =?utf-8?B?R25taGxaZlZqMk9XbDFwdnd0UGRRNHF4RlE5SHpPOHF0eXp2YVB6Z2NNYVNw?=
 =?utf-8?B?eW9peDhIVENFSXl1Vk1teW1WeDZjeTIvMHVEQlpEZkJPUElabjEzTWhjTkhE?=
 =?utf-8?B?dDg4UFpZWTB2SFhCcFN2Sm5ESHhWNTkrR2hHRGFqVm5VNFd3VVNpNXRNTCtH?=
 =?utf-8?B?YklESWhKSVhNSXZQc3dNaWxQRlN6RnRtL0dpczlDRVJCaGN5VUtxVEdqaEVR?=
 =?utf-8?B?Y2JqYTA3YkNHelBEUGd2aElIL0V4dEVMNFpZOGYvemtBd09RalFyaHU3aDRi?=
 =?utf-8?B?S2FGa1BnRFc1dHF6VmgxRnRldVRhclhYdVF3S3plc3BqQVNSRnBNNnpYSTEr?=
 =?utf-8?B?TWJzQ1NvMkk5MUUrWm5hb0pwN0tTZUJyVlI3R2o5bld5NmIwR2RHem1VbU1C?=
 =?utf-8?B?bDJCQzVaUXVac3kzOFVQK1A0L21pVWZhRFEzc3JTQ1owTHdZZ0p0RGNqbitr?=
 =?utf-8?B?dnhadVB1ZXdhUmltVDBZYldMM29EemlEL04vdklJbTF0bmNZNTkybnlubHl1?=
 =?utf-8?B?T21IbXVaY1c1UFhUMGVqME5LdkJCeVdPUlZkN3hqNTE3enlKMTJWd3VTU3Zr?=
 =?utf-8?B?YWl4SmNCQi9pbkRwR1V0bmFBYWJITnZnMFExbUpQWCtyRFAwRVJwYjBwTG8x?=
 =?utf-8?B?NHgrWjhzTG55VmJTTWQreEpnUFBUYlNHa3JXMmh5Q05adFkrYWlHekZWazBw?=
 =?utf-8?B?bU9pUUpiY1JaVnJya0lhb01uemdGcVNDTGRxTy9LaFBFb1BMSHY4YTE5bHlF?=
 =?utf-8?B?NDA3SndBOTJKT2YxbVhsVGl1RW9uVUl2WDR0RlJLTGUrRWU1Y2NobGU2R09h?=
 =?utf-8?B?cGNkNTQ0MHBabURzYkRIRW1kVUV2U216aC9IcUJkakVNZDU3VlVSR2owaUVE?=
 =?utf-8?B?akovRVIyQ0hydjlTZDNlaHhybTloVUZLT1gzUm9kcis2eDFYYVppN0oxNGw2?=
 =?utf-8?B?M3JxVElHeEkwTXFNemFCcFpWM0JjLzBPVFQ4TGQvaUJBY0xhQW1GZUloTjV6?=
 =?utf-8?B?a0o0YWFaRWFiWnBoS05VaHViYkt5SVpZYzFoSFZrT3E5UFZZdFlNek1GWUYx?=
 =?utf-8?B?Q3E1S21NK0F1R3JLZUxFUHFYd3E5OEorUi9tSkhKYTJuUkJvK21LNGJQQ1Ax?=
 =?utf-8?B?dmI3VEVuQkcxVko4YzFnMGtkTHJQUGFHUWluNCswQWpUNm5yVjBNVmdUZHlE?=
 =?utf-8?B?NFFYT0QvYUx2aGw5U0o4Rkl3d1NXc21hZTF2SDBxOSt3YlNHeElUQ25URUVU?=
 =?utf-8?B?SitpZ05hR2d6ZEorRWQ1QkFRUnJNNEc1NktUTEhkcTkrMUY1WUVxbTZidXh5?=
 =?utf-8?B?K2JiZEs5ejA2cHNTZjFnRlR1aWxRQi9vbklKKzNkQzZTODdoVXlueDZZRzdj?=
 =?utf-8?B?T0U4VnFaZGovMHdDaVV1ZGlFQUVoZVhUbnFGQXpCMVJPcnpLdWgyUXR4c2pS?=
 =?utf-8?B?WHlFbWZoWldVazZDR296L01MT0c3alE5RFFOeFc2Y2p3cGF6R2Y2MFVXU01p?=
 =?utf-8?B?eEpLdXFoMmsvc2h6ZmdyQk0yR2xuTXZ4dUZLaU1LRHErazRYd2JMNU5EOXlw?=
 =?utf-8?B?dU1MbGdPNGZXOG9ZQzI4RjFVZlI1WU5JOElPbTVPMTQ0Q3lLNjZFZEdMSGRB?=
 =?utf-8?B?b0pRMXVtdmhBUlU1QUVTZzQ2K0NhUkdxbXpUSVF0VkJEYjBZMW9XRmIwTVBa?=
 =?utf-8?B?VUZ1NEhYUzB0V2U5KzZTbjdGY2VpVXdlekJyNHQ4Wm5DemJRRzcrNU15ZWRC?=
 =?utf-8?B?YlVaaWMyM3pmNGRvR1FkQmg0RXJ6SGFINWhEdVF0TmJvYkpvK1hicERnTVdO?=
 =?utf-8?B?L0JzL1F2NGJ3TEQ3RE5BYXhqQkpldkgzT2xDQVQxa2wwSnRUMGZCV3Y2T0dR?=
 =?utf-8?B?Ym1TVEFaZWZGWTdOTGdKKzBHQXd1Q0lpLzJXQWI3YlZzK0NxOXNZQVQ2YXc2?=
 =?utf-8?B?RXZkdzZubkNBL3lndUNDNGVkY3UySUFrMlJRL0hBZFhXSVQ4V3VmNkR4NThn?=
 =?utf-8?B?MUlDVGNudGo2bFhlajNnYThiYTFTY1NIeDI5K0VSckMxb0NZS09mbWJTTE5M?=
 =?utf-8?B?QmF4dVVvdmlHU3pTTjR3MTV0b1Rzb04xcmgwWHpjcWxHMDI1R1pTNHJiV3RB?=
 =?utf-8?B?d01reHZ3RXVhaitSTDhFb3cwMU9oM0tRRGp5b3JsT2tlc3Y2ZldqLzRzN0RZ?=
 =?utf-8?B?dEF4SUQ1alA2VnNJalE2Y2U0RGRSQUNKbkdYbi9mbWpwdkVOTTJFVmkwd2dB?=
 =?utf-8?B?RjVOc09pNGxzMWZzYWd2cXR1YU5aWHBSWjRFN3FEb05GQVlSWUkvZG9ab1Zy?=
 =?utf-8?Q?eopfqjADTsXGCf2c2sOWZynYvdnes1aqapqlZgYhwMnVC?=
X-MS-Exchange-AntiSpam-MessageData-1: 1AkOuG+om0ECJA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff88d5a4-d019-442f-aede-08dec84c8faf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:33:48.8028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 726U4YynYQ9qBt571BgzgIci6h6aui0o2awgFZE4zRqMi4sfTjlgPoXLySMSzy+ZMFxPnE/TQIcV11JRw10/+w==
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

The previous parsing of the iommu-map property assumed each context
device has its own one-length entry in the device tree. This has worked
fine so far, but on Tegra264 larger numbers of context devices are
usable, so it's better to support linear ranges as well.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/context.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index d50d41c20561..52ca663902ad 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -23,7 +23,7 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 	struct host1x_memory_context_list *cdl = &host1x->context_list;
 	struct device_node *node = host1x->dev->of_node;
 	struct host1x_memory_context *ctx;
-	unsigned int i;
+	unsigned int devs, i;
 	int err;
 
 	cdl->devs = NULL;
@@ -34,7 +34,16 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 	if (err < 0)
 		return 0;
 
-	cdl->len = err / 4;
+	devs = 0;
+
+	for (i = 0; i < err / 4; i++) {
+		u32 length;
+
+		of_property_read_u32_index(node, "iommu-map", i * 4 + 3, &length);
+		devs += length;
+	}
+
+	cdl->len = devs;
 	cdl->devs = kzalloc_objs(*cdl->devs, cdl->len);
 	if (!cdl->devs)
 		return -ENOMEM;

-- 
2.53.0

