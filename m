Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F4606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=joP9XZIC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F9C10EE95;
	Mon, 26 Oct 2026 11:28:07 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2254110E241
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn8ZFm0Ai3c4XFxPLSeRnA/TVcy6h/HOavKsO9MPI6E6cKAaRpiyeD3DNYTl+gIi//oiJ/QapCt+zYw510Or6rwDwa/63AM9QPCb2c7SeoZfpE6rVpXurQlSZsMCXheE016DeXWw6q1Et/SHk4GwveWOF7fsdpyIyKU0cbaGf6qGgaKq8ps7RHdJePcW6C6HztGRQ9xHXJpE0Pimc0OBPR7howTLk174ZxsDjXxkHHTYVU0Rds6EK8i8th/+qxyBWTLUcoZzYMNpXPw3EQshkW3AvndbevNtmU5NKdfiywLyJdT0wb4+XwmTOSR1fZrpEjc7YrCfVgVCZep5yWkEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So4fW6ybaQc4dz2Va/Gvaipogw/0fZz+6r4VBcbu/+M=;
 b=XGxGLIdPl/7xJhs3N4awcN4vzpWqsNaEP7nUsmvQhkjV5sOFAOanqapJZPk06NLKG8+oqaaTPcYpoVpnqh7HckeqLpNiwu9l1paiGTd+lxoMZGkGvqFqmykcspwQ7SpNK4wimABqBxngcaKFJgzz1fgJdXma/JHzqAAgIQ1iwUdVIYsUl5LpaEnkrFF/LDG7LvheoPUgmQtqNFac54KFuF53MYJC2uud0plumbK4oSZOu83PNG9DYJP5rZPAQ1hz9Z3j4e9uJZAiSMZ6RTDWmOMXxhYsG2JDsUQCXLfw75gkiGHb94crhvu7Y75iIZBMujjaz+ohpHP/aqFSTwiZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So4fW6ybaQc4dz2Va/Gvaipogw/0fZz+6r4VBcbu/+M=;
 b=joP9XZICx5peOfjNfPDJcj9UY3FMgvW/v7xnt2OD/KXdSTaXPa1grvgi+5GzVwasNbwWvxbHVZFYFEQwwYBqg/wqbRORDLR5uzG421CYh88F9xYwqjW49JM+K1LPxvbCI6q9HadNAAxruC0qvysu5VksardEegsFw0bLC/xXQg7j0anCiX1DySSUbDsRwrEqJyQwZUggwLW+oSFrWofI7ovwFZ5NKihXCYEdUK8Z/SnB2AfkbtQXrh3t06uhhozGb+lH8Z7WYFhiEtFbgIPBg45LB3MFfIcLfczcEKd7WgV+iQls9ylnjD4C6a3swJCIBwT2PwZTMtPRTSLC/8GVOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:27:57 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 11:27:57 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 20:27:43 +0900
Subject: [PATCH] drm/tegra: Fix missing DMA unmap for PRIME buffers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-tegradrm-prime-unmap-fix-v1-1-97a23d6dc251@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMBCE4Vcpe3bBJFLBVxEPSTvWFRLDpi1C6
 bu76mEO3xz+jRpU0OjSbaRYpcmrGNyho+ERywSW0Uz+6Htn43TiGZPGUTNXlQxeSo6V7/LmkHw
 fzvAhOkdWqAq7f/Xr7e+2pCeG+Zukff8AfCUEXH8AAAA=
X-Change-ID: 20261026-b4-tegradrm-prime-unmap-fix-3b2637e23a11
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: aaef9f36-d42d-4128-53e7-08df33542efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10070799003|18002099003|6133799003|56012099006|11063799006|5023799004|261021121427099003|261021123027099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: xjAN8ttw8W9hJbM6PVeRHeuKIVovwGKzlgiwcWVHKq5aiCApjLcdwb1qG4dvOD8DEzsSZK1xMAZz/wNVQu8R9sQTxdNCQPQZ/JW7N5fKx1YLmJipfMPmNfYVB2UlVYri/9zgtdEB9mIhf7G6f5Vaau/ZAg9nWFNdImFGF9SatD8fAV9D5bvGRQJGj+b3SxYhJ+yPXYqRN6HtIbdSwWtfW1xYjlMKcuMG0WDbVqghP4Ot7PmGkXgl1FfvCBIRhGU0Gm1BAguaBx4RrXalhrvZ7mT5CfcQ3qAThLkrNYoUsd7XWQscBKnqT4A2pfScH68y7U68UWDtLihWDeLK+LbcH2IF9cCNJV/VwGVzMsyY0goUraEIFI+PNxhKYPyzDttgszd7ngnKDEb3952jfghN+hb2k0Khvt+VTXlKA7JM0YbbfTW64ReXVl/Ml+Hu8JPco4ZuJ1baT4WVDkVU2pgGD07Oc7gQC68sa0pX/cADGJ2J52WRSibiJntHHDqvlV98tXLk9oVNKOP5S819751y+9SArbuzU2W2g5Pqeh7iI3QskPpw59iMyCf221AgRVSCfCKruwxgGnqUWP1C6cApBYqvNp30AF7Cec3TrMOz79SClcWsvWB6mkLWMYQu3VBLeY5jcDfLBloKX335zBD/UKvllR/S0pQa+5T3YcRIFOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(18002099003)(6133799003)(56012099006)(11063799006)(5023799004)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0xOMFFEenhCWHh6aVB2QWJtVjJ2YWRtc1NraGl3WkdrNDgzY2xIdytkbnEv?=
 =?utf-8?B?ejZxakNiSTc1QzZFa0NtSFFtbHRpd21tMmpiY3RjeFdEOWdTNG9uclFQbW5U?=
 =?utf-8?B?cVZwaEJYYm83b0dlbUpnSXZFQklUbkxNbE5aSlRpQ0MwNEVGVnhESUo1MWlh?=
 =?utf-8?B?TituSGd6ZWFJdGRoTEEwb1Fsb0RtZXRPQklBWnMwaHhKV0JPWDdyVTNqMmd5?=
 =?utf-8?B?cDc4TkUrSWdWTlBZeGN6VldwV1RGKzFWWHNNQ3FxMFl1WGQycWRscUJMT04r?=
 =?utf-8?B?dW1MSWEyM1p3bE11MHZFN2hjcnNqRHN1U3hKUkFCYXVJTkJhRVNvVlFuOG9S?=
 =?utf-8?B?T3p0c0J0Z0RVZy9YbzhpalB3SGQyalpxdmFVeGFQdExxcnpsdy9scndqem1j?=
 =?utf-8?B?YVlZZ1hwNVNuRXdFVU1ONFBtWkdxeXB3RTIwSWtRN1lkemZiWXhjNVpLeGt5?=
 =?utf-8?B?bDQ2bklON1lrSFh1NzhNRml3dU9haVNGYm9iSGIweXFXVUlSd3VVSFRia2RX?=
 =?utf-8?B?VnM0VjRBSi92RGp1R09GbXVieTkxNGFDVlZlRlp6TUY2d01aYk5UQjN6SUtS?=
 =?utf-8?B?TXlGa3doSWdGeG1KUGI2R1pHVTM1UXpodVFXKzhoeVBMZEtTRXZCbXRyOWp5?=
 =?utf-8?B?RjRxT0dLZkVsaHRReUxFckNibFBKc2tOZHJOWWE0MUJNSnI5Q0VnYzlXRHJ4?=
 =?utf-8?B?R25OR1lXNTV1bUMxNGN0dWY5MWI4Y0N4NnI1eEhRaC9jclA3L21lc1RGSlVh?=
 =?utf-8?B?U0swdGZWaEp2c3hmaUFNM1ZabjhvMkRLMWJybUt3VkxrQjJabGI1VSsxY2pU?=
 =?utf-8?B?aCs2T3ZySTkrNEprWFR3aWYwVEQxV0JKZktwcnl4Smsyb3A0V1FTUTJ5S3dq?=
 =?utf-8?B?RnAyMGFXclBIZytKZFVnWGw5d3RqdmdWY3ZBZWVudzJSM0dRaTVwTGhYRTNs?=
 =?utf-8?B?SzFBSlk1SForYnpiWTRZWGV4bHFvalhaZFRFZVBIVFE0U1lqakgyQlFjL1Ju?=
 =?utf-8?B?MnEwQTFQWGZjQnREMkU5QkpuWkRFZ2hZY0pBY29kK014WWoxUnZ4Q2dQQjg2?=
 =?utf-8?B?Q0Rqc3d4T0hxTEorYytQa2N6cG4vRWI0blJxUHR4dHd4UHdCSjVvMFA3eTZr?=
 =?utf-8?B?dGkrSGdjRlMzb3g5ODBCYm9JdUxJNVhvRXRITk05MDRTZ2NCS0ZBN3B2TnZC?=
 =?utf-8?B?UEJSMzRyamI0Q2xpYlZDbzRyWFdDbWZpSmd6YW5zQlVkalg2MGFPeWw1MXJE?=
 =?utf-8?B?V2ZxMDRWakNEMjZLb3pLZ1ZmYkFrczJSNW5rTU9BdUUwYWdmYjZja3NzaDhk?=
 =?utf-8?B?ZUMybWE5czdZMFlORDBnNHFUcHEyakV1Szd0UHVDNEZkbGNYMG5zU2YveWk0?=
 =?utf-8?B?NUUyL2dXeU1Fb091ZisreW43TDF4WTMrR0JqYmJwdVFWM2xYZnJDeC9zR2gw?=
 =?utf-8?B?bjhWWlpTc1ZDNWRVRW92ZHpjQnd0T1ArQ2JTMk5adVhGazgzN2VqWXp5YWU2?=
 =?utf-8?B?ekRVTDJnbjJZaVdGOCt5V1ZFblE3Y2xScS9rT3VZSXdaamtOUnNMTXpTWGpr?=
 =?utf-8?B?VTg0MUhrUDRYTmpBWmRpOVZEUDJxR3g1Um5INHUxM2gxMVU5YWszeFhRY2lq?=
 =?utf-8?B?VmMwaFNlcGsxU09JVEx4ZXNDY0g1ZGc1MFZ2L2VvMjRlV3hUajlzL2NQZnJV?=
 =?utf-8?B?RG9qczlpTUVwckZYVHNGYlVlZ01GQlh2d3YyQmlTYURyVE11cmdPbVVSQmx6?=
 =?utf-8?B?S3B1MGVwM2JYTm55MkNyKzRCb0hYUUZ5WFBCeDRIcjJVV0ZuZjZjam1jemtl?=
 =?utf-8?B?eUtvV21vcFNGcm1vR2QxYldoWEs2SExnQUYyQnlXdHZpc1F4Z2hjem9aenlB?=
 =?utf-8?B?eVUzU2JvSmRNZUkvVkF3WU9pWjJGajNWS0JyMlEySzcxS1A2cHhHemV2b05C?=
 =?utf-8?B?TTlmeE5XaGI0YmJiTXlVenVQeGpIYzF2RGlMUGRmbk81WWtFWjFwMFZjM1pK?=
 =?utf-8?B?ZFRVOGtzNXZEMGo0ci92c0dhOW9IUFBpZ1QzcU5DRnZKWlFPOUMzVTVoYmo2?=
 =?utf-8?B?bWJlZkJkdk5ZTE16Rkpha2FKL2JMR29QZlFjeGljSEcrYjRoVkEvdTVzM3JJ?=
 =?utf-8?B?ckEzWUFVbWdyeXlha204QXhaaUNucVNjYkRxN0NDVDA2VWZUMllubGN3ejNL?=
 =?utf-8?B?WEFmTENNV1VMYk8wRm8vU01GWDc5TUFjUnlpdk8wbWoxS2pNM1dNMjFHU0xu?=
 =?utf-8?B?a0ZKZ1NOeHM2VlIzSitjSnovMStObDRhVFluRHBUZVV6c0JCL0syMmxCdDNq?=
 =?utf-8?B?OWxxVjJhb0s0VGUydFY1cGo0S2llSWl1MndMTlJnZlY3aWIvWnBMVHlRWnFS?=
 =?utf-8?Q?NtaCvcv8rvtSWR5g1Q4srG4/QrGIAxjpuGZXmgdZ7y0Ab?=
X-MS-Exchange-AntiSpam-MessageData-1: ZND5TBajsueFFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaef9f36-d42d-4128-53e7-08df33542efc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:27:56.9981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avXgL7vVmnSAIwf+FmL4gA4T5McRkf29a7yYSx8vGf6X3y8sHdd07u7u0cjI5Rh5ggMeaHExOuITpeijAUun9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tegra_gem_prime_unmap_dma_buf only invokes DMA unmap if the buffer was
allocated via drm_gem_get_pages. Fix it to unmap in all cases.

Fixes: 8b5a3c17a277 ("drm/tegra: gem: Always map SG tables for DMA-BUFs")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/gem.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index f76af733ea79..c10e7fb8e978 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -663,11 +663,7 @@ static void tegra_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
 					  struct sg_table *sgt,
 					  enum dma_data_direction dir)
 {
-	struct drm_gem_object *gem = attach->dmabuf->priv;
-	struct tegra_bo *bo = to_tegra_bo(gem);
-
-	if (bo->pages)
-		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
+	dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 
 	sg_free_table(sgt);
 	kfree(sgt);

---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261026-b4-tegradrm-prime-unmap-fix-3b2637e23a11

