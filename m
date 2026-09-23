Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A70CC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DE910EF87;
	Wed, 23 Sep 2026 08:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4COAFWss";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5DB10EF66;
 Wed, 23 Sep 2026 08:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lenqgBmgwcLfp/Ogk9ZF8wJsIP3SEvyoLJTqWwzjYTaRiNRitcc6RBo0zQ4gP2ko1js+7acrlxdpva2QQLpaab75A5CDqOsCVfFTgJi4YvS3jktpXMxWtve+8ZMEkXK6po6lS9x+DW6b98SGSFLOJbDyz+YWosGMuObAkLBlH352nKuGB4rsIUdvxRH/T+SL3K/7jbuOVT+C3egJGD0XgrC4axcHaZlYJlJMrWyo4w2kyz4czQevUg2scXQDPpY8WJ2bWeiqSM6gSyw/mKOYhEcvVO4eSATLUbnkIxPq7tTv1597WBszxdgFFBOykmow2PAXeOC6Ak4CQUO2zUbSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwJHULXrUqe3nJ1D9ShD1Iz5v9mjdwj9roFfAm9+b5k=;
 b=MqdqFSPUAOBmgy1bbvmiVmSKCO04OszTeoIRv34NY6EwAQRCHE0PxsfaV/RiOOYRlxzAKlrudAl3hXAbepQTs5Uo+TJDBU4TNzkTdr099P2cNh2eOmZLGWbirvI3rqlrfnSXo0bXDHJGtkF/AzLwTaewSVKolTnD/2GFITS+Q2yZMGu0Dwd9CGPm5AOnapXWTfoqZTOqICCi0LaGkhhYNAsnHj9kV3wHYr91du3jRIaSknc6bZip/P7SEiURdomNz8XfpON7BQtnZoFgBPwvB++8Wg2kctP99MZgfmPqUQ829PYJmHfdYsGkL27OAcBeV5pNT19uM/leaCQgVcPUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwJHULXrUqe3nJ1D9ShD1Iz5v9mjdwj9roFfAm9+b5k=;
 b=4COAFWss5kIw03jr4Ir5xjq/h3xyTV1oiUto3aDEymFLNXeO4uuiSXq9mRA9NZu3I9yGHnnIrgJBGT1V9UwsfA2HOZq+CbcROu4mdQqpklGvRgXXVfJTr+qJas+0mWkMbOH/Lf4n1+XNxZeprxLEhbC0Gq0DQF6dFlY2Inh5yGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 08:03:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:03:26 +0000
Message-ID: <fe3a4297-f300-451d-9763-0b3016706111@amd.com>
Date: Wed, 23 Sep 2026 10:03:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/2] dma-buf: keep DMABUF_DEBUG off by default
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, freedreno@lists.freedesktop.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Karl Mehltretter <kmehltretter@gmail.com>
References: <20260923074256.9357-1-liujianfeng1994@gmail.com>
 <20260923074256.9357-2-liujianfeng1994@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923074256.9357-2-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea54156-8de6-4d0d-aecf-08df194925c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 9ekffflhBCx6uxh/xf32orR1uAdoiEaRJnv4FtnS+cxx520OdoACxIT2m0Gu1eradp/ABYHHXdldoUKP0P57c6Y8MCSXh6ysBHrUaazBJKeVAjuIukwKhB1uMqT80PdtMo7xq9cXVyk5/JKqBJZqfbICAmn7NAREWeTgBdKZP6AmLHpxro1oeg38DuSeoxcu4nT2S8/mVxms8cEJfN7Iop9XAGZpGwIGoGEj6pNK+fy+Iu+sd+wvhNF2B5hO+h2jzH6GhSApH/0nHxvUHcBotfb0EB6fjIMjDBnqRQtVnjjbalbO/ttz4i3qaI+fLKw029JYeaQxyL2opJeJsPN+q0FAQaX1nbucgzL/AJnlZx5Qy6fkX5L+xDy4fKTVwi6Uhf+YW0WNBQVB4Dhpa6hsq7ca9dk5+n4kXvcFCLDYhTcQGLhK5ZlMgI2T132WznwuOApSnOdBT9X4E2UCSTBdPVz+frX5y6KkDDs/yjy4o5m6ms+aey5g2HdDlH9QibPyUaejCy+2Xn19X8M4d9D9RL2AHSmaBOxk13A6vvBzZdeH7cRWjfGL1j8o9MV2kA2qdi8KKTjLUeQLA85Pcs/OgDhOBoE5q5619jkcfGsRfN2VO/nS2/svO3OxJ4AsPDmdyNAnHn2mWSbUU7+irnZDMiHwiRwt5E8HZ3P/D0GGwTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRidzVMOTBkZjNvWDcwSGliZXVyRVBiL3RLWTJkL1FmczNia1NuTjRTbjcx?=
 =?utf-8?B?U1g2RVRuUjNXZ21kRDJRQms1c01EU3VSTzFkVEoyNUZVZDl0WGthRlBrY2tu?=
 =?utf-8?B?WVkzeWFUOTNNUnZ3Y0x5Mk8wZDUrMzR6UWs0N09QTjlGZktRU0NlYSszZWlY?=
 =?utf-8?B?QjVoeEFHcG91dURZMDcvWklZeDR5cXZ4OHkrLzFoTU5mQkpnd1ZseURWakdK?=
 =?utf-8?B?MnRrMi9QdDM5cXNwQzlCTmh0TlhGbkJsRU1Pd0RFTCs5VVBrVmxtNHdWczFJ?=
 =?utf-8?B?L3hVVFRoVEQyZU5kMTVkSDNtZmZmS1ZRVFN1YWZkVUhQYWJtNnFYQVJHQWRY?=
 =?utf-8?B?R1ZSY0RoQ0ROeHhZcERMYkVmSTkrSUNpNk83VjgrWHl5M05Ed2RSQmc3Wmlh?=
 =?utf-8?B?TndROUx5OSs0ckVZREJtNG1GMlBTdThvbWs5eFlYSE15SFRFQnJZTXJpVU5o?=
 =?utf-8?B?K2tKVHVqK0VPOWhaZDlwb1ZSOUxjWEdZcldGenFNbVkzclFnVjBOb0MycUhT?=
 =?utf-8?B?OFdXa1d3ZUF4bytIbG9qeVdMRkljTS9YTzI0MS90NmpKYVBtL3pMbVdCYXh1?=
 =?utf-8?B?L2R4UFRNbzBPMkVUSjdhQjI3MkVBZHFmbnp2ME1LVXlWYUtoZEpLTGhxZVdJ?=
 =?utf-8?B?QWxsd3J3bHl3ZDluZkNUajI2d3prZ1MxTUM3dnBTVUVyK0NhVDZueHdnRHJ2?=
 =?utf-8?B?bjR5eFdSNmNHMkFUbkdOeEpNVlYvVkVWcWNvcU9wR3IyenlxS0QyUTVUaTdO?=
 =?utf-8?B?dFlZVUU2cmdWQXc1SlY1UlE0NmI1NENtbDNNaUdiKzhtTG1rM0RhRDBMWTBB?=
 =?utf-8?B?TzlKVG1HV2YwM1NpbzNIY2pqRk9iaGpsaFNDdkFDdzlPdndVb1Avd05UVkNk?=
 =?utf-8?B?aVh2enI1Y1UrQkN2djhuSHEybWxKK3R1UW1tMzZRWHAyOUVQbWF2VDdMd3hZ?=
 =?utf-8?B?UkFyZnViSFk4VUcvcWovSnhhQU1jakVGYXFvbnNUaWJWVVcxQXRIbVZLTUh2?=
 =?utf-8?B?Y2RzTlZLT2FxZWhtTUlJUlROZUNPNTVGZ0R1MlB3VXRMbVFoN2ZrdkRJNHBp?=
 =?utf-8?B?Qlh2Vmt1ZTZqN0s0a0I2UFJHYTloa0kyWk50a0Q2RXcrZ0NwOU1iYkU2UWFW?=
 =?utf-8?B?TENWUEgxSGgwak1HaktXbUlUNXNOempid2FFUFdSNkxuZEF0N1hROUZBTWtN?=
 =?utf-8?B?UXlrTWhzaEtia2pKREdMc0s5ai9SeTR4VjlqaXVtMkFYRnQzeTdka29DNjlF?=
 =?utf-8?B?Z004eUZqbXFiYVRaTkhjVzNGSlBSbXlWV0hjcTFkZGszYjk2L2syeWtJTUtV?=
 =?utf-8?B?UTFTTzl1bU9aZWttNE9jUUVEdmxITS9mbGpGYk9lbkpIQ0trWjE3K0RmUmtQ?=
 =?utf-8?B?ZDd0UDE1S1RucHc4WFlmS0FFUzd3RFFLYVRBYUZhV2ZIY1dHZlhZcEJjdE5k?=
 =?utf-8?B?UG9VT0psRDJYa3I3YXJkRGhzV09uOVB1TU1xdUdhK2ZZaFBSL0h6VnFTMUVN?=
 =?utf-8?B?QktEWElZalZnZ3JWMW1XTDgzWkRaK0JNcDhuTU9OLzI1Q1VwRkpZaFNPYzdS?=
 =?utf-8?B?THY5NTFZcmVObEo0dlFldUpvMUtPaWoyWHVaL20rZFBLZWQ5UENEbjg4NWRw?=
 =?utf-8?B?ZHJRWFZseGZ4OHl1RDlGRk4yNGE5bTlFV0o1cDNSZjljN1RRc2NQVitGUm9x?=
 =?utf-8?B?TXBzcmRuT1NNQWVpR1JEUEFBZk1tcEsydEZ0N3hwZFFCcFZ3c2lab1ZpTkEz?=
 =?utf-8?B?QVd2L2pJRkhsTTdCZzVRZkpLbWR3bEpucEI0YmJ2MWdlYTVhZGRFbFJIb3l4?=
 =?utf-8?B?QTZSbUlEb2p3aTBVVDk5VGV0N21NS2pvcUJqMCtoTTRxaWVINy9iRVd0TDUx?=
 =?utf-8?B?enN3VHU1YjN2TDdRVTYvVUc0MzUzNkJMUFlLN0dvNkFxS1JoYU5KVWUvSWZz?=
 =?utf-8?B?RWxGTWtzcmg2QUlGS3dNMFIvNE1DcGxZWTdXRDJxQWMwVXRoNHB2dlArQlUx?=
 =?utf-8?B?eU40eGlST2ZTQjVtK3VSaWc1MUVJQXRNQWR6NERUbXpEMWx5MzNDcEtKUmJ5?=
 =?utf-8?B?SUtSM2dxUTdtRjd2VzU4bEg1U3IrbG5KQ3JkWTA5Z1plUForYjNJUmpKMGJh?=
 =?utf-8?B?YkhlNDhuTEp2YXpmSEVvb0tZS1JQN0U2WU9yOUdBR25xcGZranlobCt2Y3Zr?=
 =?utf-8?B?dGJDOXlLdzdqekFsSkoxNWJJQXhYSzYvSkQ0d1VVa0EvbDRuOFJZbkZ1Y0I2?=
 =?utf-8?B?S3RndUxrS21uNGV3MGZSVHg5cThjazJrbEpMR0RjL1dLZXFpNGE3QUFqRjRw?=
 =?utf-8?Q?tUAreIR3hLYCCAjWRE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea54156-8de6-4d0d-aecf-08df194925c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:03:26.8371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEMman8ulaQugxz95TQ0xYcyHXIDpICzT/FxljpBxoqrlJfyFQ6pMqIAeCLcRF2R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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

On 9/23/26 09:42, Jianfeng Liu wrote:
> [Sie erhalten nicht häufig E-Mails von liujianfeng1994@gmail.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Commit 143755bdabaa9 ("dma-buf: Make DMABUF_DEBUG default to y on
> DEBUG_KERNEL kernels") fixed a dangling reference in the DMABUF_DEBUG
> default, which had the side effect of enabling the option (and with it
> the page-stripping sg_table wrapper handed to importers) on every
> kernel with DEBUG_KERNEL=y - i.e. virtually every distro kernel.
> 
> drm/msm is broken by this: it maps imported dma-bufs into the GPU's
> own pagetables with iommu_map_sgtable(), which needs the struct page
> of the attachment sg_table, and it fills the GEM object's page array
> through drm_prime_sg_to_page_array().  With the debug wrapper in
> place both silently produce garbage (the wrapper zeroes sg->length,

Interesting point, we should probably change that.

> so the page iterator yields nothing and an uninitialized array is
> kept).  The VM_BIND map job then fails asynchronously after userspace
> has already enqueued GPU work referencing the mapping, which shows up
> as an arm-smmu translation fault from UCHE, e.g.:
> 
>   gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
>   type=TRANSLATION source=UCHE
> 
> This breaks hardware video decode (clapper, chromium) on Adreno
> systems; bisected on a Snapdragon laptop as v7.3-rc3 good,
> v7.3-rc4 bad, culprit 143755bdabaa9.
> 
> Revert the default until importers that legitimately need to build
> phys-based mappings have been converted.

Well that won't work like this, pointing those things out is exactly what DMABUF_DEBUG is made for.

What MSM is doing here is not allowed at all and can break badly. We gave drivers 5 years to get that fixed and I'm now pushing for completely deprecating that hack.

See patch 84335675f2223cbd25d0de7d38ecc7d40b95bd4a:

Author: Simona Vetter <simona.vetter@ffwll.ch>
Date:   Fri Jan 15 17:47:39 2021 +0100

    dma-buf: Add debug option

When MSM needs the struct page then it must import a shmemfd and not a DMA-buf. What we could do is to either fix MSM or mark it as broken.

Regards,
Christian.

> 
> Fixes: 143755bdabaa9 ("dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL kernels")
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
>  drivers/dma-buf/Kconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index e4f078a326a41..b3c581ef4c987 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -43,7 +43,14 @@ config UDMABUF
>  config DMABUF_DEBUG
>         bool "DMA-BUF debug checks"
>         depends on DMA_SHARED_BUFFER
> -       default y if DEBUG_KERNEL
> +       # NOTE: keep this default n.  The page-stripping sg_table wrapper that
> +       # this option installs for importers breaks drivers that build a
> +       # second-stage IOMMU mapping (phys -> iova) from the attachment sg_table
> +       # and therefore still need the struct page, e.g. drm/msm with its
> +       # per-process GPU pagetables.  Until those importers are fixed, making
> +       # this default y breaks hardware video decode and GPU workloads out of
> +       # the box on affected systems.
> +       default n
>         help
>           This option enables additional checks for DMA-BUF importers and
>           exporters. Specifically it validates that importers do not peek at the
> --
> 2.47.3
> 

