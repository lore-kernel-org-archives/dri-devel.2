Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A27F44855
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E4910E951;
	Fri, 10 Apr 2026 12:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cOQz8leK";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B55810E951
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrqpBvK2m43WXwD3kvKS6sy3zyFPTS9VKiDluHUf8Yi6pt3gBErGiTSdmdAlXoSpqHY9FnWLOb/yedaDabt9NZe2x6WQO3yjM694F84SUdhA6s3jlnCfgpDhJRCIY7UigLbwNjrph7NHdN1DRJFBd+nnJC62pAG3aB3+prLiToLGAnHfzgoXclBJ5hJvYRIw9MuichKu5nKvqYdFtLp2b9YQKYOjCFul7bKUNLBCJAPC+JB25OWzKYad4fljP8VU79Nyo7FcyzH/I1kdrVXOyWiqRiG/8rbqTOC4d9DFLWJdFO0Tz6oKlKms0oyLuLdqxbUzU5fVsRAnd29wKgj2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkR6FL23Rbktt/TwqNYkS7MzUc9aaeHy3S+ohwdeLMM=;
 b=X0UijeQPXoXsZczhnDcTMbQtFpSA4RpKnzGPqojXK9dEOHu4agH92+gMF/ujLnjyxjuuH/7ujQtNHZXPc7OCoBkmptGAEY7bNXLikSedJOCbB/d4u+fgD/QwTAS/Hm4TeKASNXyGzCNTc+SsL/8CaXUByFybODNW+UGcGEwAppx0YyUXt5PvEx3gOhBvCUPxqlKQHrM1dBLX8Z0JlqmAsfQwJqhVJFu3m0GPKzVW2mZ3ELh6rXkaLzn57Vc+uTLqMYNQ/Dz2eaI2zDVAO110bmUiZ18qX/tvumO4Odn08VleTrGh4Frl6o3GNLLZwVOzq6EOH82R8oif+SFcyezS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkR6FL23Rbktt/TwqNYkS7MzUc9aaeHy3S+ohwdeLMM=;
 b=cOQz8leKh0Wtdjlh/WtfnTr7FwM3gC9FFVhdkoJrLTVa+dXucGnU0N4sNKRAmSPbU24J7BPI2MCUpC4kiAx7OwIgeF9nUQnOFS4GYuRshubgK0Xnncf57S3u5wdIfcAosu04Eh9rd72BHhdLmuZR88Z4Lg3hwYcPVmrKoYO1A0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 10 Apr
 2026 12:44:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 12:44:04 +0000
Message-ID: <c427afeb-15eb-4a46-aa6c-fe24631d24ae@amd.com>
Date: Fri, 10 Apr 2026 14:43:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: fix htmldocs error for dma_buf_attach_revocable
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: leon@kernel.org, broonie@kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org
References: <20260410123703.937822-1-sumit.semwal@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260410123703.937822-1-sumit.semwal@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d36420-d736-4201-13e3-08de96fed94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Ymld9jD4OTITreIkS1vU6TXZ6veo15s7+rKI4i3BSfaIgygaTuveuutuFiA+HUcul8jzoLOELCEVjVz+peXaHnX7E5L3eNITc8/zJjnFKANTFHLGksytfTF0Ril6Q2vugADqTm1qI/m4rlSwe0bjPaVc3uDt+74OTsB5g8tZmp/ljAvZx0NfYs2jEnrfRO6lwFaL7/jkpjfHajM9G8TC3nej4ds/9oUNBKWo1cH6HgNMWbomdxtmvxeFJUS/p8WFpUb4NYsXmIY9qwWM6423fpYAnEDQb8p4Jb2I8TY1wNYqkWYfSWaAxPqPUxRTIrPR52YN7eBkFzcVpRKwymP6wWkvfuoNojGh8wwHbEGLzZJfcFfNgzqBCG0QMUfIdPt/B1DVm+t+3gCPpU9bS3j6nB3IHFjg1oy4xmIC2mmCfW536MUq0oBFQrXjSA3eTfTvxPQAQt5IoJQ5+Xwif+43SxbOZu/dOevWbS6+niPsaEATUkK3LupBeAfQXuLhAR2mFk1CkTTCrGqSuf13AD6uZjtN5hdjSv5Bynp3WQg+SNtiMj+tmRBALi8Nx1ATEAr33pzWzPMN1u4gQsYj3VpyC6iSDN3Ll9ChfchYN/PohfG+79VhGIp8gOWVg6x52eENKKATIIdWOl7CzhKb7fUTlUQ01NBLdSnxqtbggkfK6Kb1UHC9tFbeT4Izfev74jcBt7JAfa7cW+NJUD2BDQT9G5wL9coLdE+78pJ+Z/vOxkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clB0L2x5N3JOcW9hZzRqNURPVXdyMENYaGM2YnJVSExHTGg2SUs1STJuNmdL?=
 =?utf-8?B?aDg4OUE4ZWRTMG00YUZ1WUN6MFBCN05KKzIxNTNxdjBiOXBmVEJaVU5nTnF4?=
 =?utf-8?B?bzZBK3VydDh4Z3ZaakF1SFQvWXZNbTg4R0hveWJGYlMwYk5lREx5eUtUT0xy?=
 =?utf-8?B?LzhSd056blNjVU1RK3NKN3pMeUI1Q04wTk9iTVN3T0FmVXlZUVRzL2ZlN0E4?=
 =?utf-8?B?b3VvMWNqSmlDT3l1MHZyUXMrUEIxWllYZ0phOUUzNldpWFNOY0hMYWFxNC9v?=
 =?utf-8?B?NmtCQW9XNFJYYU5IWGtKRWJ6T0ZETnVFSWovUjYxK2JFU3JaR3hmT3QrejY3?=
 =?utf-8?B?eEUrMHpFYXBPekd4Sno2VzhSTlh6a1lJOEN3TjdvbXc5cDc0UFB1OGxnQ1Fs?=
 =?utf-8?B?VVZlSXUxTUJwUDRvSDZFb1NXODU5WmV3SFc5VTFaTDM5c0tyZGdGTFkwTFFj?=
 =?utf-8?B?RmJVY3RuQ0VGeXVOZGIzaWZBRzhZbXRTaDVwR3lmVDdsZWNsZ1N0RWM1Z09L?=
 =?utf-8?B?WkhZbE02cGthc3NUV2FHWGszTWJJRzgzakZmK3VtRXZIeWhEYTl4ZlVGS2tU?=
 =?utf-8?B?UjNhTkJnTitDd2M1TWs2aXd1MTRIZkhmVXV6RXo3QmV6Y3FveitYeUlHN1p3?=
 =?utf-8?B?UWU3YVlLc1Eyb0VDU3hFbG9YUDRHRk1NZVM0RmhuUGNEblNkV2xGRFVBcWth?=
 =?utf-8?B?SzlWNFVaQUlXU2VQR2dtQU1nTGJmZk0zSlN5RWQza000a2hYSGlUZldTL01a?=
 =?utf-8?B?NHpaYm8yQ1ZuSlhka3pSbUxOY1VFNVFTRmk3N2VuVkhYV0tBSXRnNlFtTkRP?=
 =?utf-8?B?ZWs3T1RsTDFjOUo5YytEZ1hZYk9zdm9YMVhJRUdXSG9YaE50RTlKZFJjVVJB?=
 =?utf-8?B?UnhQc3VwaEJQVVVtT0FKU0NXREJvMzZTMU4yamdqRU9UZGxXSHUxY3VGVEJE?=
 =?utf-8?B?cGxaYXBmMW85OXJwWFVpYlFxMjg2VzlLR0RBYkZVaW53OTUwV043Q1VkUHVY?=
 =?utf-8?B?T2RwQU1Nbm84L0U2Zkp1Y2xjUW93OVMwUDl0UklWMCtJMTgvTWd3RHNaRUVz?=
 =?utf-8?B?U002RmhydDhBd1FKb2k0eGdJdk5JazBuM2xIUFdUMnVocC9YbXpZZk9pZFF6?=
 =?utf-8?B?MnVxRmxwTEJ2M3pMUXEwRWxhTHQvNTk4OFdTM3gwZjFKdHorQXBCQ0xvbG5z?=
 =?utf-8?B?YWp3d1Z0cnJuZU5zaFZBdm5HTU92OFJoOXR2QVIwUHZhVm5IVVVEWlY2Zy9m?=
 =?utf-8?B?cjZiUm1NTUdEOXFzeGI3VFpVM2FoWGoyTm1jSS9vREpsanl5d2Zuek5yRlVw?=
 =?utf-8?B?WXhqSmlTeHdVR09QYm5hcGhESVJFSlBNK25waVgxL3NvVlRnSzhOaHVNcVZD?=
 =?utf-8?B?a0dxUUIyRERlYm1rS0tJQWVVNHlEWk9XR2JXRnowTUd5Z2oxSEVSSHVsUWdP?=
 =?utf-8?B?VzdJL3c5TzFFelpVTmJ6ZWdyRkU0ek9EQWJlT1hOZkRyT1IzWXFwanBiMUw4?=
 =?utf-8?B?THduazUxMmxZenAzMWFab2hRd0NnVFBoSERLUzUxUFR1MjBCV3I4cVdSMnd3?=
 =?utf-8?B?N21GNXlTMThtT1NEaDdGY1hURkJlSFNzUVZGUkFlc1NET3liV3RXM2w5bFJS?=
 =?utf-8?B?SkxpSFJPSGFZVGdwSFBvdDM2Mm9BSHVLaU93RXI0UXBRYUE1RUxCQTd5ekZ3?=
 =?utf-8?B?d24zN3V4ZlpPM3g5TCsxTUkwMEdydkVXS1cyZTEwbWJSeGFmVXRKR1A4aVl5?=
 =?utf-8?B?RWZSVjFrZWlQaEk3TnpUMFY5ajR3NCtjekNkMG9vMHEwYzkrU1FWNHkwUW1V?=
 =?utf-8?B?T3pSYllXMzFuRWpLUXRvNVBKUHZIaTg0aFBDK2Fxd1VYcEk1QkRqSFI4RTlK?=
 =?utf-8?B?ZFZKM2RaQ0NDZmxZUDBQcnpVVy9Yd3k5Y0hNaU5HOGtKNWZtTUxGK0tRQk1H?=
 =?utf-8?B?QnJlS2pHRkdFdnlzNTkvUUNRNjQyNnVuRGhidFg5cThVbkFBZlZvdzdablVV?=
 =?utf-8?B?SkZsWFUvZTdCbFJEU2phV2NUTTh2NXA5bE0xdm5WN2xvZ2hIeXZtZUQzZUxI?=
 =?utf-8?B?QVVJYnZ2dlBCMjZ4ZDl0MVF5U2psVXlGVHZrcldybUFoTytYY0RIb0NDeCtm?=
 =?utf-8?B?NWY4Z3Mxdkw2VmdvWHpRU3doWkNNZklyNHdiN01WVEhUbi9rSjg3V0pwMWlV?=
 =?utf-8?B?eXVNU2hla21GUUhtSjlrL0VkcUYyMlRPU3FpY3grclRyZFJJdjBCa0lVdTRh?=
 =?utf-8?B?THd4NXZzTXJQamE3VFF5eUNJdFp5emU2RTlyVGM4eVlCVVZ5QytNdTVmNUpK?=
 =?utf-8?Q?prgV7RIoTdx02GPgk3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d36420-d736-4201-13e3-08de96fed94b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 12:44:04.6748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKQJHBL9iZxe2Pl+ylEDwNIdPBB9qWfuimC40g8HOKCN7FPqUR6Yd65T0qlCyMOO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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

On 4/10/26 14:37, Sumit Semwal wrote:
> linux-next testing showed this htmldoc error due to a missing extra
> line in the comments; add it.
> 
> Fixes: be6d4c9e9d714 ("dma-buf: Add dma_buf_attach_revocable()")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/dma-buf/dma-buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index a202a308c079..532c3f14bf9d 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1353,6 +1353,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_attach_revocable, "DMA_BUF");
>   * Upon return importers may continue to access the DMA-buf memory. The caller
>   * must do two additional waits to ensure that the memory is no longer being
>   * accessed:
> + *
>   *  1) Until dma_resv_wait_timeout() retires fences the importer is allowed to
>   *     fully access the memory.
>   *  2) Until the importer calls unmap it is allowed to speculatively

