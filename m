Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDF0C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F005110E1E8;
	Tue, 30 Jun 2026 13:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QawnBqQR";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C7710E1E8
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixsGHJ+J/HYWB6/75GapNCs5ZddhCHPC1sjXeNk0Kka2dKBsao0ub7NbeVEm/JK3TDMlboJLypKKYyQLzTHaFp3ch6q8ySGh/X2xQsWDwI6Jk2cqoAwkM1hQTsC77EFBaZ2NxJ6ElVxvSJe7D+/hBhZJMIUrkMI1KKZt+Ai+Z03aD0AlVUd6LCdCmnCpLnZAAAeWCBpbhAShDZzFWcANS7CmoFgFR0MYLhYxX67Mxr7Nn2MRAFmRWVO48u+sUDhaJkWaF01EE6eQZIDVoRasvS3wdZ1BDuRH/M8t/zV5fY+d4P5Mbcr/AwClO5l5stwhVnPpEGh5eiTJVy4vJhE3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk/m6R7y2C+hRNzBUxuUJIUR/ate7yHy/QsoybP/krU=;
 b=Ie4MUsagSOI1ykD6tTDSfEBQHKW2jUl7GvaAtFEEYGmmf5dwyosxsgOmVPwz4CRnvPrUhouDvrzGAb2+P+FmCxhdjPaiIoDh/vdQ/OwMvqERac80F0jsr1ZSKK3/pRZ1NPQat619a94vVNWgHtbsDPr/jrhfz+C3IBDMo8zgyM45iL1+VpJHk3DY4RD2QyCNPLjfHUiPoU4sVq1t7lcvtukXB2Ub0r9RGSkaMiHyOJ28kEeW8bmBphSwUXBPiVe9En6JMqizc6wa2akrJVViN0Pvm/2q/fwCiP4qZHyj1OungjlgJmVaHpUN1HwDIXMpklW47CFTZBZUq4Xtw9ZrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk/m6R7y2C+hRNzBUxuUJIUR/ate7yHy/QsoybP/krU=;
 b=QawnBqQRaOdG9aoeNcrabXGz7hwHKJv2w2Yz8qLE1V7oBiu59WGO+MPVtYogZ42ODTmqLKxbAB7PjSUDK1uBR1F+cODKvLKODEcwj/Iij8FC4Rj2X7cP1B91lYMQz+YO7Fpp/aS4zP6gWng1b89ghLauSUtA+3Z87/P8CS/vA6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 13:42:15 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:42:15 +0000
Message-ID: <c790dbb3-72ab-4d86-ad63-bffce5809bee@amd.com>
Date: Tue, 30 Jun 2026 08:42:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: explicitely forbid exposing pages from
 get_user_pages()
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 sumit.semwal@linaro.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 lizhi.hou@amd.com, Max.Zhen@amd.com, airlied@gmail.com,
 karol.wachowski@linux.intel.com
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260630080112.1117341-1-christian.koenig@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260630080112.1117341-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:806:126::8) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd7b79c-9dae-4d32-58d8-08ded6ad656e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: KQN4Az+bPPPJPzdXkV28Ih9b0MvWudi8vrfxEl2tiQu8KKWtNbwEfFdbI3AtWzWeJFsYNkWepDeNvT67L/QlFIuDJ3J7gelzAEMT2bTAZs5RRlTtXT+TYYy050pjQRwcqyplSIHxiHSEFkrN4AbyZBF1o7yjjznkWBJXYbDOXAP52grDL3wqsdVUr+RxNXRxbYlj5qvoxpZrkaBK1gcGlaSWhZ+CemzKx/gdmJHqY44fgALEI8q+OR+KPDEd3/TQKQ+IJV8wFF8aPv7hQQcjbL1Mx50KAFnP+mrZikdodJWsVs+RpNINsvfsJY5AScguO8Yxmwmx0FgLsf4APOpN3G5LRSninA8EmsU43dPb9ctYlYDOuJkuX0RZ9c030J8NaH9VRtgYCwKw25RIAs6PHCkR7xdtXvFviLw986SrFmazj40TGjUpuSleBbaxa8n3dgmX+KHWqJe7CcKAYPFET8S0r5NbzDz2FEAVM6aqGuytYyx1RrntBU0IwBBFO557mZcO05pMgZend9YDQSDIN25devkGwVemgyyDHfSEtvPBLkoNW+PAxXfab6C95wSyEpbN9iUy1DGXYiHb0hk4r3PfBdvlFK1Rq8MrPx0viCq1yjRjjO7xGAYFo3hQkaQuig5YP2/uULfEo53A6nJTh3v/PCNYjP8EJM3oA2LsjQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNSUytEWUNvK2RjNWczSHc4VGdhZitRM2RKRXI3L3gyV3llaUxTdjlLbGM1?=
 =?utf-8?B?Qk9mb3dlbWhyR1JTZW1PNk9saEdIQVZjcWRKWHRtdU5CZ3VGamRsOSs0YlI3?=
 =?utf-8?B?bVR1cG8rTS9DRzBSQlVXYTBadGVXZFJMUURmcmY1TVJlYnlvT3ROTEQveWJD?=
 =?utf-8?B?aTV6UmJVN010eFU0QmFYbjZHQkxrSHpkT1NZNlRMRVVtdFR2U0lVd01CYS92?=
 =?utf-8?B?R3h0emk4RnlNWi81Kzg5WmcweEt5a2RocnhYOHpBZUNHRlZnZUlUTjk0b3FH?=
 =?utf-8?B?UHE3eTBPLzNtWFdmSlRBVjRXNGZqWjB2ZkZDNHhaUXdHQ2tuanNRT29kQ3hR?=
 =?utf-8?B?SjRYTXVvWDJtTWgwNVRaQXAvWmw4TW5yeCtFTWxFREVjNTZKNkZOV1pJVW56?=
 =?utf-8?B?blNyUlVFbk1tU0tjYWNNa0hqMFZwNk1OZ0NhR0hXMHc5V0VvN2hzdFQ5WXNI?=
 =?utf-8?B?eU1CbENPTGdpKzZnMXozaFMrZHIyYS95VVhobWh2cXd2WXkxcVk2cXZ1azRD?=
 =?utf-8?B?WjgxQ1hFSnhJVGE2T0NUbDRkWWNPQk1IeTN3dVFjRGUzclVnVDJtakNvL00v?=
 =?utf-8?B?QXowY1dDdlZKMlJBcFI1Z3RjQW1DSFNJMnFvcnl5SllHclJZOWMxdE5FSHYy?=
 =?utf-8?B?ZDRLZlFndklGTmNyNTYxdHV6bkNrWllQdGlpOVdpTWdsYmtzQ3VzNE1JU2ZQ?=
 =?utf-8?B?clZzRGNJTHpNOGVUUDI0VVA5dWpSVElVNFY1SlllbnFYZElYd3gzQTNrMkQz?=
 =?utf-8?B?bFIyY2U3eFNFaDRqODlCVDlmbGVsK3AxTUV4VnJkKzQzdGV3cG1JR29RQjdN?=
 =?utf-8?B?Q3hVaHl5U25IZGZCb3ZsSUdJUlAyYzg2K2p3dGNwUktoUU9HeWQzbm5HSXJ0?=
 =?utf-8?B?QXhqd0hyb3ZteUxGODBTY2hiQ2tJcHpRTnBvb3N2bjFoRXJ4TkdxYTBucUFx?=
 =?utf-8?B?SjdWSGlzbGV1NmVuZDlhanp2M1FPRXZyUXpsL3BxTGZBRFcrREhKQ1pwdFpp?=
 =?utf-8?B?M2c4cE1VTHV2UlpzbFpoQXVhWlNVR2tPMVRVU2E1NEI2ZkcwcmErcVRWUUlw?=
 =?utf-8?B?c3I2UkVMN2M5NkErb0tLOHREenJKYzl2WnlxN3kwbUtrQUJhZ1A2Y09VWkVT?=
 =?utf-8?B?b2l2VDEyRXAvUU5Pa3FSbzNCbmdneHpHMEEyMVJMT29CWVhIajhsNmhFa2I3?=
 =?utf-8?B?dnk2RWxTTjJVSk1mUW5BVHpncUREL29yQjR5UmxvK0F4ZkNOQUh2THBkQS9O?=
 =?utf-8?B?clZQSUpnRGw2YUcwVS85ZzZ6aWNVRlo1K2d1cUZ0RysyckJQd3dZT1ZONEY5?=
 =?utf-8?B?d2VCcmxodlRqSHlKZTFJUjVyS0pGWTJ2UlBDeEZPaFBYMVF2YVFVYzduenRt?=
 =?utf-8?B?bGRDRnpvZzIrNng2K0s0Yk1sc0NrMUNBTnZsdEdUYlNoWExzNUxXWlE1Y1pp?=
 =?utf-8?B?TlFNZVB5MktZdXRuUytrVjY0MGhNVWpxK25zNDFVT0JVRFNLTVVtVXdiSDBj?=
 =?utf-8?B?WlQxK3REb0FpZkFyVm5yemg2ekd5YVh0V1FTOUlhOTFTNXcrY1NqTmk2d3A0?=
 =?utf-8?B?aHpuSkI2MzZJWUlnWGRqdHBOMHdoUzJLTUNra0JnQ2doWDdjRTVxd3FaM25w?=
 =?utf-8?B?MUl4a1MwaG9oTWdxTnR1SmhkQU1pYnJSSTd4NjZZWDE5ME1sVnZUSm5EaHh6?=
 =?utf-8?B?TGNlZlowWUNiRFF4M0ZHSFBNdUJkeWpEby8zTkFRQnpZZVplTnpyU3lJNGVZ?=
 =?utf-8?B?a2laQnlFZ3JpanpaeG95YTdIYU5aUzVlWDE1L3lzLytJOTR4bkt6NXFQUmxF?=
 =?utf-8?B?elVDNTN1bXBZK0FPZ21ybVdVSzVrWC9wOEVCRGZZSVZSWkRWMWxKcUtiMDR6?=
 =?utf-8?B?dnp4YjlGVnF3bit4bnhDZjUxaWNnd1VBMkJ0Y0RJM1hZNmJoMEZBdW1EVzJQ?=
 =?utf-8?B?Tm1iTi9GeWRhc1FESGdxSEswOFVPWllZdnNGRWl3WHU2djVmWTdORmFlcHpV?=
 =?utf-8?B?U1I5Q2FNOEkvTkd1YVpzTXlkeXYwRFVUZXhCUW9HaURzTFJReDNXMnhaMEJn?=
 =?utf-8?B?THdENzd4RDNKVWx1dTRQbGtSRnJzRmdKbmZidzcwMjVhMTlhTlBXaHJTR2Z3?=
 =?utf-8?B?RnlaTEZEdzUxRG9NaHZrRzQ0QnpZTXR0Y3VCeUs1aGpNZXM2dUtiMXE2anBy?=
 =?utf-8?B?MXR0NlUyRHg5eFlXYnFIZmV5a29FRUlSNThCa09rckdCNXRqeGZUUmZMSFNJ?=
 =?utf-8?B?eDZDSldLTnUwd290VFNBR1BxVGRzTXYvODNRWGdWa2xaSEZxT1dHV0lWNFpa?=
 =?utf-8?Q?Bk2997nMLmLTDD1LBZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd7b79c-9dae-4d32-58d8-08ded6ad656e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:42:15.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTr0j/CPNuJBNf2ifsmOvhRjo83PqvsvVsSgJZEZLOV6GJ3ij9ebqJCZ1HDnqv+JVMDIes+1QPMeU/zgCxzduA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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



On 6/30/26 03:01, Christian König wrote:
> We recently had another incident where two drivers put pages they got from
> get_user_pages() into a DMA-buf and cause quite a number of problems.
> 
> Explicitely document that this is not something exporters can do.

I think it would be a good idea to send this up to 
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/drm.md 
as well.

That's what Sashiko uses and it will help flag this in case it happens 
in future.

> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-buf.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 71f37544a5c6..aa5af4f439c2 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -685,6 +685,14 @@ static struct file *dma_buf_getfile(size_t size, int flags)
>    *
>    * For the detailed semantics exporters are expected to implement see
>    * &dma_buf_ops.
> + *
> + * It is explicitely forbidden for exporters to expose buffers they don't "own"
> + * as DMA-buf. This includes pages acquired by get_user_pages() or other import
> + * mechanism. Not following this rule can create numerous security problems.
> + *
> + * It is also strongly discouraged to expose the same backing store through
> + * multiple DMA-bufs at the same time. This eventually creates aliasing and
> + * cache coherency problems which are extremely hard to debug and fix.
>    */
>   
>   /**

