Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D313C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7226310E283;
	Tue, 15 Sep 2026 08:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QAO9cMoX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E0110E283
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1Z6ISdItVk0sLqlBoXphJCxUXxHI6t1FMSkmL+Bb8IK1nHkQnoCMJejDDylmHttEsxUnxOCHnVDyaNAizwuG+HpM+KLF0vOGjl32j1blMNVgVtM2Q8gu3bR6o/s0t57Qfsd+KKys7mwIoffM9X9lj/MdgkI5z7yH/a9HL5F6mx0Nnc8fScYXvxoS45xHJ7/FJZyPkpqhuOaolkXyp7pxUkgKrFgsVtpPEeNK8YRzQlhL3vGPZRnzoxXL7b2RPx/qv4ym+e8qLhBtDCSUYTlnINJX9Hm6qesGUjdaIQlS4U0BGNKYVJjP4wuawFw/WdN81ceL0bbjBODmAJpgzC9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6Z9q7GuObzb1jbh3Skdq2+RIdsW0t6Z0gWP7ZHjxNo=;
 b=p7/QSDr/FGgtBjewmbWi1RWtQKWYxtgtOMpHkZTCbjY5QANhla9kKiwrEVrz3greqpOqz/LBGx5bgy5UVp/ZRk1cwDaTo1qMSHbTyxpOAVpf3b+W/QEh4HECX5/yq99oxWDza6DEmxorwH3WlnSPboUZrCHtPkwGnPsOPa6MeuLMdoFdP1E/sle9Xo4catwzz6sEWItSvOVpOhm7TjXGs/FBeaH59r6t4PIIgSAyaFRz1JzayNSbu0AXoUie3qR22BR5GYzAKxrV8jCM0oh0OgPbss6TCeMmEig/ATckH8uJsblzDJ2k2bzhSJy8jPljzGzR3CBsxUNnOX0oDKUfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6Z9q7GuObzb1jbh3Skdq2+RIdsW0t6Z0gWP7ZHjxNo=;
 b=QAO9cMoXtaYDjBPNaG8DpVFhUSOoyZZlOUHJuFH0SPHqxcA+HAXwMR4ff5PWYVEWaoyhCOJnFKFH59hfH0I5YrCOOof9iOaT4ugzCNbYkQGdgI/tMxxd1mqLW+xCriEhI1NWc64k2Mi+OTJu5O8ypQfwKhvGPaqg2eQkV//O6vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:47:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 08:47:04 +0000
Message-ID: <465500e6-ec7d-4039-8b2f-750b9f441327@amd.com>
Date: Tue, 15 Sep 2026 10:46:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dma-buf: validate the attachment before asserting its
 reservation lock
To: Davidlohr Bueso <dave@stgolabs.net>, sumit.semwal@linaro.org,
 phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com,
 tjmercier@google.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-4-dave@stgolabs.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260914212258.2657788-4-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:208:32a::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f246353-1134-4925-2673-08df1305ea8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5Ay/2gORyr5Qi9Qj9iQFCOS7rp0SB42jmZUXRze8stJbpVcvPHlVulFIqvUOsLPRBlpd83OQ8EkvN/gHHvZ7p2mPyODPWsI4yGBTwprIKmERaMfPaXkJEAeOHpmC/2YpM94E+xl79SBU/ujITwfm8JXrwhyz/RlvY8YC57ya4xvreYGnZKJ1NGhBfSkXZQ/hzMvdZk+BxQqcKmUBKEE45mjuWigDrzqB3dzBSRv29hsRAvgnr8I69Kmt6LqltDfUpkF2fVBGWR4Rtr8tZO1gIgVkPQtoPIRBUPLjMiiDlK471xQ1xn+85k/YPneSNKi11m5kABkvz0K7bM9qD+iT+ppoAs0ns0OkaNvxOl5gpPGrJLCG8itg8PSk2xtqvzTo4BY9ldi33qvcXKFFm0pbez5RRgKO9OSz2QEo0irebj/eYBSTwjUnfIDC/7qmRtZnjFYOsMrl1O9zxe8gUyvj+Pmly5BBMwTkWAXFrOAW8yHXEt/G62s60KveSXrhX9BLe6n3tvuWIMG3+yXSPCakBd0knXCfphwUjx+gjKb857G94EbQT9OCJVbcsTKuoHIb7tDSsBnkXmJauBxbzp0RxWMFDvOYngQ5tw/ukNe+TWsrT/mSeSLdg1/BbXHTccuGqM6zh8CjXm0AlJmA3hp7dw6pLPt0AISCNU9Cf1nOj6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2QwUFNsaVRHekliUHVBbEFPcFlaUzFlUVJITFhHVTIzdHlVMUg3bmJHV3Qx?=
 =?utf-8?B?N3FRV1ZJQU91Y2JEZTBTMUhrNEZIRUp5UmRVZE9md01mc21kVm9IZkE3WnFH?=
 =?utf-8?B?UDJ1cm9VZ0pYSFo4dzYwMXpCSWZ3YTNCdUlTMEFBS1ZYVFp5eFVHMTNLWmJo?=
 =?utf-8?B?WnI2dExxMmFZckhMcExYM1Rnd1FrdmhIdFhXVitTa0lWRGNjU3BkcjJLd2FI?=
 =?utf-8?B?blEzdi9DMVVLSEtvZFdDZlo4ZWkzNUFUenpYeVl3MktVZERFclAybmJIVmxH?=
 =?utf-8?B?N3hSaS9ZOHpPTGR1Ty9TdGNsNUV1a2hiQnpGd3JLWEUrSzZzYkVzdTJ2SGVu?=
 =?utf-8?B?dE5iQU9jNXQzQ2J6d2l3d0xHb2hpZ09semg4anNUM3I2TU12WFR1a0o0SDFP?=
 =?utf-8?B?TVJIdERsU295eHRROEZUV1FoMEh0ekV1c0J2UjhLakNSMjdkbS9kUk9ScVN1?=
 =?utf-8?B?blQxbWZWUUpvUUhGSnYrNTVndE1rSDNNRDgwL2hCVjVvamNUYU9OS21GdTdL?=
 =?utf-8?B?VnhzTEs3NVhSTERXL20rQkhyK2ZVSTJWOG5ybWxIQStOZEM3V2txSkdnZ0ZL?=
 =?utf-8?B?bWVVUGxyTENVUkt4VlBCckNpaC8vaHkwQWV2M09nQXBveUtZWGJxaXlMMGVD?=
 =?utf-8?B?OW9kb09qNmxZcWF0eklPUG5NbFA5MUQvRXVaem5tYmdhR0lKNFFFUHVQaVZm?=
 =?utf-8?B?dmI4a2NWT3NOaEJBNE5hcjVKc0ZIUFFxN0M5T0JXM2NSYnA0M0crZnlpbmdy?=
 =?utf-8?B?enplak5UbWtDVnhJTDB0NjZ4RnVPNHV3ZUFJTlNmd2NyQWZzWnpkcGYzQjRz?=
 =?utf-8?B?TFNWa2ZDOHZzb2hHNFc4YmQ1Zkgya1ptVmFYNEc3L2ZEcW9NeU9BczNlMUNO?=
 =?utf-8?B?VU01NkZQOVMvdTJDbjRDVWFnVWI1UTV5UFN0V1F4TWxQdExzMVdzQXNvK0FD?=
 =?utf-8?B?Q0tFT05Ha3lTcHBYVVc1MHdSMXFkRU5zUnhpdmJWTzhVMmp4TzRaQnhQVzlM?=
 =?utf-8?B?ZGxMOCtSVWh3elJJVHRsT2p6WTdveWxYQUtWWUY0WVNTUDU4VTJJWTBDTnIy?=
 =?utf-8?B?OGpJQ3NCc2ZzUUN1RVhjWEtZVWRsamZ1N1czbVFWWFU5N2RRQTBQcmdLSFF0?=
 =?utf-8?B?YXdXMUFPZmxDVEhVYnRtUE9sdC9aUURraS9VcGU2NnNwSi9NMkNBd2czeDlr?=
 =?utf-8?B?Qm1yWG0vWVRhMVFkYTNwN1QydERvNzBROHBybm9rYlZWOUxxZ3hGZUs2SVFh?=
 =?utf-8?B?cVlaQWlRQSs0azB0MCtRMUNmWTVidjlxQ3ZTbm1kM3BVejJCY1FYdC9hM1dY?=
 =?utf-8?B?RS9HWUJNODFROC96RXEvVVNCOWRuMll5NjFJaFpLNWZtM2lnUzhRU1pTTW9F?=
 =?utf-8?B?c014bklyTGJBZGdjSGMxS2FNOGlNWlNXYlpOeFdPMjU2ZzIwYkdJN05Wc3pY?=
 =?utf-8?B?Y3RLdVFEdGNXZkJ5OU44SVBwNGprNUZLR0lSN3FzSWphMlR0MmI5VHduMGVp?=
 =?utf-8?B?RnU4KzA0RjdtU0Q3VWQyVjZuRDFkNDNueGExWkQvaElzVDg4TlpucWVSOGxM?=
 =?utf-8?B?VTFVVzVCRHdDckh6SlFCRnlQMDBqUWV2aHdjdGxGQk1GakNreE1ab0JXR0Ri?=
 =?utf-8?B?eVQyV1FVSktHM2VtVlNqWXhoaWMxYXNLNjRCcWJseHY1eEo4Skwralhya1pB?=
 =?utf-8?B?TnZrd2JLSmFFNUp2QWVZNzZ6S0txU1pkNllwRWtpdmE5UlkzMmtSVkxKSWUz?=
 =?utf-8?B?NStBMUJoQ2RxY0tXM0sxUVB2RVFMMHkraDllWDZTSGpZaHBJTzk0cHdxQ0hh?=
 =?utf-8?B?Q1cxTHZsTXc0WUpaaHZya2wyVTJZOXJIQlJGejNiYXJqczhwODBOVk5neDRr?=
 =?utf-8?B?OHU5MXE1ZlBTQ0lzQjF0UWphcWVQaGVudzhKYU43NFQvZS9zV0xzQ0FObmlO?=
 =?utf-8?B?Z2pINjJCNGNBdVFMYzE1SXlEaXdlajVpcjZISmVxalhTTzNIZ3ZyMHlpOVp2?=
 =?utf-8?B?N3BhUGpEaFlGUVRGelRUTTdGZlZJcmZ3SDZPWUE4KytPd2VjUjcwemU3K1FC?=
 =?utf-8?B?SGdKaFBMeXd6TU1DcXI2bUp0NTN5YlZaMHF5OHJxNTVXVnNmV2JIdEgvbmRN?=
 =?utf-8?B?NjRGNHFBWDZjQXVtMWkrcElSeUxLRDlJdVBlcmZobklnRGNtblpEZ3ZIZVk1?=
 =?utf-8?B?a2lEc2J2bGxoZVAyRktLL1VjZ21nQWxIYzNWaWtWOTZ0OUxXUEdheWduUXYx?=
 =?utf-8?B?NXUyY3dZcWpNQVZhSEZiV0ZnVGZ2enoxS011RlR1MzZkWjRpdGR4VjkrYVVu?=
 =?utf-8?Q?P1OhEeokKKXvgVChu+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f246353-1134-4925-2673-08df1305ea8a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:47:04.2388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9tb/BqMzc8q8BlA6a6z5/UyDwJENyJ1Lxnhs5xWPdg0cEDIxIg6+7R2T363wuI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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

On 9/14/26 23:22, Davidlohr Bueso wrote:
> dma_buf_phys_vec_to_sgt() asserts the reservation lock before its
> NULL checks run. Validate first, then assert.
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Good catch, but in general please put bug fixes as first one in a patch set.

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/dma-buf/dma-buf-mapping.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 833be519e1e6..12674d89b23e 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -111,12 +111,12 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
>         size_t i;
>         int ret;
> 
> -       dma_resv_assert_held(attach->dmabuf->resv);
> -
>         if (WARN_ON(!attach || !attach->dmabuf || !provider))
>                 /* This function is supposed to work on MMIO memory only */
>                 return ERR_PTR(-EINVAL);
> 
> +       dma_resv_assert_held(attach->dmabuf->resv);
> +
>         dma = kzalloc_obj(*dma);
>         if (!dma)
>                 return ERR_PTR(-ENOMEM);
> --
> 2.39.5
> 

