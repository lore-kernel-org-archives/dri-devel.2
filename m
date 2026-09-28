Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B009DC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064C410E7F8;
	Mon, 28 Sep 2026 08:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iwxwY45R";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954CB10E7C2;
 Mon, 28 Sep 2026 08:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX54M3hktGc9GyGqd47GTMYMzy4IN8iqI33R4WE35ayNKvvgvnW+HWnZfNpASqm1dZ44hUDjImZkg4KA7rKog+VbzHVZAZ6wxoYR6G1cGb5gD9PlyNQ0X7RzD8NYHOtfp59Y/6f+SmGG1LzFSykNXq+8G5nWwaoucqNJ0UXqpWVDSvUtEYH8bm8lI0RjqIHM2sn5d4oWsYwRaC/upTjphaRJ7+TZ22/vUE33Q7TF3zL5M6epzhA7GMWdeHM+rP6mNudLSeO0kU8bowRTRsp+DDwCL7d5hwFpGuzTTlRdWNZjub3zNSc8xu63hF4O3fzkuEGZvDxjFG0ulnuU7FIrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RovxITBg8xZMBi9bkz6zomsyJFfSuUnE6xmtqAhYogg=;
 b=eBLbsMCz0WC1wDGdxUbL8IE+XE3NrhDc92eVIGLmgL0ZeA4/HcAOaY2/H4Rfdk1zA0DTA+yEeGyC0CldpYC4ZFhdYAiGb4VLzbaLp7zy0XQ7TAitefO4efWzS7rEmLDMG4DakrQOd5aRxg8v6JKDgeQcUfNhHr2KjBXlJ8k83CUwf09FmyYs3/1+hBnn7JhTmnhCcx/9DjVhv3FchjIZXQUOulujliSmBraX4h+elGbqKbcyf9J9ZsmLPiZR9yuYbd+XVHet+TvnVj+zw2eDHYGjsmZ5EA43AkVsh2cJXIHN6ZM+UQAtJzHEhgGu5yhGXXjX2Ui1FqE/Xf+opib3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RovxITBg8xZMBi9bkz6zomsyJFfSuUnE6xmtqAhYogg=;
 b=iwxwY45RefabrjNQ3v2nkFgP2S/o3UEbbxt6y4hwRMg8VpycTqBdyoW4DaCgtd4+V/bjEhbHhQivcx+fdJEBq4zfKUykWFOUip6Fetn1f9SgdeTOBqNuhMBNS/9h8R7mSKvvcyoCuu1NrhvMSLV8jZWFq0iHyuyK2Ny2YpQmbsI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN3PR12MB9594.namprd12.prod.outlook.com (2603:10b6:408:2cb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 08:19:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:18:56 +0000
Message-ID: <17bf71c6-2442-4eaa-847d-29ef625870bd@amd.com>
Date: Mon, 28 Sep 2026 10:18:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "dma-buf: Make DMABUF_DEBUG default to y on
 DEBUG_KERNEL kernels"
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Bryan O'Donoghue <bod.linux@nxsw.ie>, Dmitry Baryshkov <lumag@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Rob Clark <robin.clark@oss.qualcomm.com>
References: <20260926022026.10539-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260926022026.10539-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN3PR12MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: 46924fed-f49b-4666-dcb8-08df1d3923f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2S8ff6KYCRZacGSFd/suZCvPxXsZK4ggs2gNYeekXZxZ+02T1buVHBVsanvJVR/RJHxDE0H/Ly2dfkmxf/UbzgxUbxET+jtzCd5yv2KAti4yYUS+Blfvl7QBxCJaz4GfAmRdilj26/jK5cZ6K04q7uADqxSs30RKcehYFMutK5dAC5GcZiDYxzy0A8V4L9Sx6ws4y3zczUia9i2maDENi2f/Ve2IzV9FGen7h2dvzdUa6ZYUXEjJtVXZplqY4Ne8cCCGPI771XCBpgX2OgLBED+29+lxlz9bbm2/rZw5mHQQA7dLwZ7RlhDW2TZ4mwzp1KGl7tEnazguwNO2+jfE2j59QCm93mbFeD/udAN3bLAasrRGeW/WIVJS8os/sfy4LjC3/FhIru8EFpA/3bArejyBfxqL2f4mJXOu1h0kYE4TlTlONIKrIuM+I0JjZr3hTWc1EwyafifQM701lWN5dIJrLT2/fWdLRvJaHmdHrPQVLAr+PZi8yt/X8jqy2Z++CfGooRskaB9yX2DgDiuChs/n1ao/0e6lsWJQMzWkS0k4AUq58IvhU5iqElTmSQU6Yphs+yrn40Ee87B/QH5inZFEFOG/mMEcN8rphBo/Or18WYuhMF0yjpNMv+OSz2NM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEE2ME5rMlpIWWtIOHlRZFpReW5nS0tWS3JoS2FHRWVrVWptY0lBVmhhMVNj?=
 =?utf-8?B?SVlwbUVWdXozMFZXWFQwKzRwaXZjanR1dTFvQ29FOVk2UWNPTnR4QmpJZThL?=
 =?utf-8?B?SzE5eEh2cDFzeW1rNnZUZU90TXVTNWZlQm1jMm9EVWQwajVlRWk0MHl0b3E0?=
 =?utf-8?B?NlBQYVdCSSs4QTI0QzhtRlBPZTBNbkhRanUvMGdHMUJkdkFKejVsWFR4SEtn?=
 =?utf-8?B?ZVR6TmNZRkZwVlVFOFlmcmE1QVF0UVpRc1ZtbUM0NndsazF1L1JxK1puKys3?=
 =?utf-8?B?VGdMQ0xiUzBrMit4a2FETHB4ZTlEVm5ybGFvamxJaTdPZ3NLVTRkd1pFV2tk?=
 =?utf-8?B?b3ZoSkNzVE9jQVBlcEV2TWFvLy8rU25NcDh2N2t3dlJ1bDA4WnQ1RFhHQXQ3?=
 =?utf-8?B?ZzRTRk44UDlacVpraHA3OTJlRW9Oa0J2cWRZZFlnek1UT3hmb0pkU3BCV3lu?=
 =?utf-8?B?YUlLcXlES1NiUVZSYklkWlY3Ky9JRWUySkY4T3p6MDR5MVBiS0VqV2lnbHJq?=
 =?utf-8?B?TzFlTVNwbzAwMmM4ZGpndXlKb2hCb3FMdDJJS1RmNDRVOTYrUmljcFlTQ0FQ?=
 =?utf-8?B?T2U0a0hiY0NmcUl1TkdrRFRiU0djOEcySlJYbGRvazlZN2t5WWlPQm13KzBU?=
 =?utf-8?B?S201UjhwdHQ5Z1NWTFZZa0xHY0xHbnpPMDFROHJnVEQ4ZEExVWFkYS82amdM?=
 =?utf-8?B?YjJZY1l2YThNaHE2ZSt3amdLbUViWG1lbmRkZFNsWVNSRE4xNVZWYUJaQmlW?=
 =?utf-8?B?YThLeU0xanlFWHVyN3RnYjFBR1c2UU1NdTN1V2xhVGdSdVR0dnMwU0V1L1M0?=
 =?utf-8?B?eEdXcWFlY0pNdkJ0bUdzRnI1UE9hUUt0blNBS3QreVkrSFlnbGdabld5R2g1?=
 =?utf-8?B?MmwyTENsM3BjNGROVFFSbG01VGlTdVpqdkNIdlNpUW04dUVTTGdvUHpzQnZx?=
 =?utf-8?B?M3RJTTNGNEtTbXVoazU5T2NuVjNNWVp4eHRrZVpwU3A4MnBrRStNNlJMcmdZ?=
 =?utf-8?B?VFd1RVkwWEgxSlFoYko0N2ZKbHp0TDFwS29RYXRmT2VQQnhld0JGVTV2cUtS?=
 =?utf-8?B?UXdKSEpkWTRNWmNUZjVEam03T2p3ZlB0bjdvRUJEdzdjNDk3VXNEUnRodmV0?=
 =?utf-8?B?SXpSQ1FybFpHTjg3Wm1iS2IxU3JpK083eHRDZjNqR3VybEUwMXUydmtNWW9U?=
 =?utf-8?B?MkRGalRJY29MM2xHdnZZRS9na3hMcEM2bk11dzJPakxLaktlUkhMNU1UaGlj?=
 =?utf-8?B?cUNFSEU3U0pyQWtWRFQwVnJDU2pLMVBuRnlKZnl4NFkvNzJlNmJqUWptTngy?=
 =?utf-8?B?ZHAweG5RMGFSSllMRVFrOS9RUk9CWFMrNEJCM2dkVzBJZDRnL3JDaWJOVVhu?=
 =?utf-8?B?bG9GM3RHeVBTeFMxb3kvUHJJaVFRdFFUWWNNRGd1U3BXYmdOVHZVemJGVVor?=
 =?utf-8?B?N3lESGgxZjJQYW12aTg3M21qd0JVdVpjbUFvTTBIaWMyUER6bWVtRVlZdWEr?=
 =?utf-8?B?NlBwb09JU1Y5bXJDYkZhLzBhQ1hrbHR0NDhHbkVDbUFIZWNYMHVjZDB3T0gz?=
 =?utf-8?B?dnl5YlVwWXhwdjU2V2orS0VxRmhpV1ZJSDZLU2Jib1RtS3g4Q3RlV0lNdjBG?=
 =?utf-8?B?dEhRR2pvenN1RHppckVjalhsTWorWE5lRk5kUTkxUVhPbXM0MjE1L3NDMHhP?=
 =?utf-8?B?bWJZemVCV3FsaVgvUUg3Zlp2T0NGNmNaWDdoVHMyZmR5bVpvY1Y3NXdHOGZF?=
 =?utf-8?B?VTVyUStEWEE5TElNa3l6U2djcFZPZXJ4bTZ0YzNuMFRjS3RNZ2x2VlQxbCth?=
 =?utf-8?B?U1AwVzdTbnEreWFFVm9GMXR1UHdqUFVZVnREZHlic3hFUmYwTTFrRlZpcHh1?=
 =?utf-8?B?bzQyMWNvQU9YcjBHdHV3MmtCVGZTVGk2dHI3UlN4VFRpSklKVUVDQlNFd2Zo?=
 =?utf-8?B?QzM4VDQrMHFsYlQwUkx6a3M0b2o0QU9SdXkxc0hDLyttNVkyZ3lDZjBsaDhX?=
 =?utf-8?B?ekhmUDF3YStQajNGMCtPS0NrT3RpR0Vpak9DcEhscVEwWjhOK1ZYOGxWYWtP?=
 =?utf-8?B?ZnVVNWJ3TU05LzFoMW5KU3NqR0I5RmlncjZLVDNqTjdkNyt0dW5zTGRSbHB6?=
 =?utf-8?B?RDJhWXRQSElSeCs2YkdWK3JOdFp1cEVuc3g5NVpvS1h3d1NST2NLLzBIa2hm?=
 =?utf-8?B?bnFUWEhXQ2MvM3dlenZpeGxQUDB5WStsMGZTQ3FiQ0FyRE9LVzlaUmpMdWF0?=
 =?utf-8?B?MnBiK0RqSFNpa0owRWcva3NWek0vQUtrZEF6b0xyalhRa3RSQmdwVjM4allD?=
 =?utf-8?Q?XhM4ZfOGrErxMx11kL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46924fed-f49b-4666-dcb8-08df1d3923f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:18:56.6124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLqIR8Ix12qoY/jHS+ptqZS+eI1eMzV7Ce9hnIiPGeUFDl67REvHKY0bLQcuqSwX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9594
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

On 9/26/26 04:20, Jianfeng Liu wrote:
> That commit fixed a dangling reference in the DMABUF_DEBUG default
> and thereby enabled the option - and with it the page-stripping
> sg_table wrapper that dma_buf_map_attachment() hands to importers -
> on every kernel with DEBUG_KERNEL=y, i.e. virtually every distro
> kernel.
> 
> drm/msm is broken by the wrapper.  Both of msm's map paths consume
> sg->length and sg_phys() of the attachment sg_table:
> msm_iommu_pagetable_map() for the per-process GPU pagetables, and
> iommu_map_sg() (via iommu_map_sgtable()) for scanout.  The wrapper
> zeroes sg->length and strips the page pointers, so mappings of
> imported dma-bufs silently map nothing, and userspace observes
> arm-smmu translation faults from UCHE, e.g. during hardware video
> decode (clapper, chromium) on Adreno systems:
> 
>   gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
>   type=TRANSLATION source=UCHE
> 
> Bisected on a Snapdragon X1E78100 laptop as v7.3-rc3 good,
> v7.3-rc4 bad, culprit 143755bdabaa9.
> 
> Switching msm to sg_dma_address()/sg_dma_len() is not a trivial fix
> either: those fields are only valid for sg_tables that msm has
> dma-mapped itself, which native non-MSM_BO_WC objects' sg_tables
> are not, so the conversion needs more work.  The msm maintainer has
> therefore requested restoring the previous default for v7.3, to be
> revisited once msm no longer consumes struct page and sg->length of
> imported sg_tables.

Yeah as I said before the problematic part is MSM here. We have enforced correct driver behavior for over 5 years now when that option is enabled.

What we can do is to mark MSM as broken and/or give a warning in MSM when DMABUF_DEBUG is enabled and you try to import a DMA-buf.

But making the check not default to enable on debug kernels is not an option. This check here is exactly to point out broken drivers and you can manually disable it.

Regards,
Christian.

> 
> Link: https://lore.kernel.org/linux-arm-msm/20260923074256.9357-1-liujianfeng1994@gmail.com/
> Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Karl Mehltretter <kmehltretter@gmail.com>
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
>  drivers/dma-buf/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index e4f078a326a41..7efc0f0d07126 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -43,7 +43,7 @@ config UDMABUF
>  config DMABUF_DEBUG
>  	bool "DMA-BUF debug checks"
>  	depends on DMA_SHARED_BUFFER
> -	default y if DEBUG_KERNEL
> +	default y if DEBUG
>  	help
>  	  This option enables additional checks for DMA-BUF importers and
>  	  exporters. Specifically it validates that importers do not peek at the
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> branch: revert-dmabuf-debug-for-7.3
> 

