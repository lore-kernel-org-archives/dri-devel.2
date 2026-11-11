Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F8606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=irDrH+iL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E661C10E242;
	Wed, 11 Nov 2026 08:18:58 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5526410E242
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASufgGZPLl1g/rbE/CxqW7swUTep2raswLcEHX5xvq1JOKcNrvKLqfHpkxSbnE/ab9tm/KSo3XUZjj/KL1NYT2qajC07uVSNR/XmMlLITgj/xzlNz9XDuxYzhRVPlMvqMnevR1nAc8dHGae+gz+UcwVsFvLutXXWSyJihed59MeK2Wcak9gPXVZ48KFNtny+Xv3ToXI2nnfndiakx2knnmUGNVsSRGjf920sI0tjokBfveTp1QgU3fhyCman0SelXW0+iHjJ/N0316RXNO1ZO3+PTycD0g9kar74O16FuGkNv7QvWmyGM6BK3Tfm/xjezjvHYoVoJ3moBovfllHDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrShLJ88cqiFfMjHf5yF10atqk/pMhGbbvLtXygq+N8=;
 b=tdFDJDZ5uXTcLu3q/JroZAhFCcX8fIBzVTRwRRbX6zUBqzw/vLoTjVgWqLaZq0CwYTzoDK3VpKla1lKP+Ha1hz83zb+lqSKlO9EB9u8aiCHnShBNKuoCEOHS1wnnILhpc+G+kj51t58/zQeIxQ1h9/wan5LCQ5a9z1NhIdu5oP105Vgalq7pBjjlMVwcQwYagawRUYVdw7LG1L6wYzluR1ooJW9lNDOkQavJd2+B8kP8F5p2qkTlANUMRD2S3I/HvLKsKpTuByndRAsxKHzwuKdx9va3M/P7e6ZotBcYeloIGlQrLwhnkZEiZCialL+RS8p0tCEnrk4ts661Chl90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrShLJ88cqiFfMjHf5yF10atqk/pMhGbbvLtXygq+N8=;
 b=irDrH+iLGXG5RPPMz1yUavBV9mYuKbvIAhmWO2upuvHiKuEZv6wMTvtiX3ygQNRZgC2TbhDAL1d2iE8JoDZFlAw1Jwcwy/kp7Cup/X36xKGTA/cHNy90tC7IwLCc2TuoCHZF/ilcv1MM+4vHRVAo7kUFwK+cfTa/1YGcwuKyMgI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:18:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:18:48 +0000
Message-ID: <1e7fe0eb-2b06-4db0-98b1-3535218847b3@amd.com>
Date: Wed, 11 Nov 2026 09:18:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
To: Kang Chen <k.chen@smail.nju.edu.cn>,
 Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "T.J. Mercier" <tjmercier@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a99bd62-8c6c-44bb-8baf-08df3fcc6939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|10067099003|11063799006|261028144727099003|261009223027099003|261026140227099003|261102123227099003|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Y9hFjwbqX1fTJItek3QCl6txaj0c1w1fBXuFTzWCSOa6xHl7lsRzkFeAeBk5S7UXuOqbmIKFstm22SODF5/ZMNsOPrymQLv6EqZvQc66rvaakVzpnZgQnTkrItOfrZ6q6p3ocXjCE/a+aAjJgPyq7MMlughEEhFRQn2L8qOlR+PVhj2CsSglKPzxcuzMq7x+nhWOiYsfzyXAmENpI6S5FK1ZS9CYqrBSzu7XxtpkoLASy1We0NqdYsoB9zXEiaQVSAqe3usYfhiiwHxwa+plWtB+b9g07AdvKSwjLNo3TSfLUzZVtjMG5KkDVT9XO+ApmFnZJ1/7J2SbK6aKJZa6uXIcWwyzrW9Aw8eYTNKz8pSTfSPyCYHEhtv2f84NlYhQi5IFbCQQHaEMzv59IJKdZX8jn7D240T26jdGhlwLZ8eqtaEuL4NOnusfD25PISxx3EMc5FfPnX0w6RZIpEYDnLvykZvc7IdwhA9uPzkum5G/3gHz9S7OGExbBgPjOVwDZDCzTO0XEXMgpmOzSqAryBKNHJsoVB1Giuu6/YU1pMwZ/SpPceGiTCbXx5e0UkFYIoQwUSM/flT/+A4s8v2+BEx5EF45xRnABuP/hbAGaLkD//INSOPTYKrby4/qVbbLaGCnRALmRUq49iyrsk+eJgLzV/k80otS7yGL1O9M/fA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(261028144727099003)(261009223027099003)(261026140227099003)(261102123227099003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhtWXVtVWdCdk5CbUtmWDVydWl4NWorWmYwcmx6eUxHc01ERFVFYmZXWW81?=
 =?utf-8?B?Uzk0OUZNVUUzTWNkMHZQNk0rMEt4aENKdTU0R0c1UENnYVdrZ0hDVFZqMmlt?=
 =?utf-8?B?d1orb08xVG1PQklLL25zUU1PRTIxQ1Y3cGtPU1BteDJlVGlQdWs2WE1adk4r?=
 =?utf-8?B?N2NYNkFFY2R0Vk0xRVBKWkN3WGJFZFU1VDh3WldpZTFIdzRvM1FZYmRwVjI3?=
 =?utf-8?B?YTZIbENnQUhORGEra0tkQ2pVN2JIYlE1U0plWWZkdUdsbHZad3ZVRVFtOFMy?=
 =?utf-8?B?RFBiQXk3cVB5QW5lTXRyRzBNL3doQUEzMUxsS2ZhZWJYVHRqSWlUU3doblZJ?=
 =?utf-8?B?M2JubnIxWmsrZ1VqN1QzUmhvdlFtUCtWeXh3UnFoQ1Fta3ZxRGoxbEFqVHFl?=
 =?utf-8?B?T1B0ZDN6RndyRDRack54bkZsNUJodjcwY050RGxIUHBZQTdYM005RnphZERT?=
 =?utf-8?B?bVFqU1FHOEpZdnpwcTMzdG9mRU56MlMrcVFkMEJzV3JXbTBEaDNxVCtHWjdQ?=
 =?utf-8?B?dDRNZDZsMS9EMGFNa3dHNkdQaEZxM0JzNSt0UEVqUWlIRmJGdytFcWRISHd5?=
 =?utf-8?B?NWxaTnowOU9LOXVJUUE4RitwRFdOWTZNMG5LK1EycmEwdlJTeU5HM09GdTRV?=
 =?utf-8?B?b3ZGTnp3d1QwTWFHRkNac2IvOFhyVWh4bExFZEZXckNjOFdqVm9VakRRdjBz?=
 =?utf-8?B?SG5DRUVpaTRFeFFrY0dHaVpWREszWk9TWUN1TlhBRytFVDdRY2MvdUUrN2xx?=
 =?utf-8?B?MGZtaXNySXNpNzVvbytNdjRXYjRPOXpqK0ZwR0F4TXpMeXZMZ050bHBHUVM0?=
 =?utf-8?B?SFdaOFptWThDZHVET1ExYVliVDUxNzJCbENNcGlYcW13TGQ3T1d1Y05SeXB3?=
 =?utf-8?B?Q25LWDhKK2tEQ3NiU0R0Y2hKV29HZ2VDRmQzeDhNdFJSWGZhZlBVNTVWaHJ5?=
 =?utf-8?B?MDVMRXpReEMxM2FFVXlsWHZZcC9sNExDaEJad2dxMkhXYkxLeUE0TXdtN21T?=
 =?utf-8?B?bmNFeUtUOCtPYzhVbHArVi9OUDN5TmZ5SktHZDhyZWkybXVpSmNlMkZmcXRy?=
 =?utf-8?B?cmZSV1g5Y3F5MUpUVnFvRzZVSk5FZW1icHY1b2pYQmZaYjdXNHhNdnZSVmdx?=
 =?utf-8?B?QVNLNEtwVzU0YmZpUlhIZXBTZmxsUFp5VnJPM3V1S3BGbE9FZVEyb3NXWHBv?=
 =?utf-8?B?eFJBakFsK3ZaMk5Pa0phTUZlMExhU0R5UTJHVjIxQUx4TWpOY0JWcE5kUDBG?=
 =?utf-8?B?YUczRjlhTVBPM1dxUkpCRHFoY2MvWVUwTDhVR2ZlV0JjWHRLNzM5M3pVUlhu?=
 =?utf-8?B?cHlsSjJST2lKZFVqTkVzdHdBV2MwcUhySHE2SElVQzlMTG4yL3A0L0tRM1dE?=
 =?utf-8?B?SzRKL1Q5akRMbGlBOEpEN1UzN2tTczgzeVlyZkpVUEt5cnFrQzIyK0l2a3BF?=
 =?utf-8?B?MWRDa3dSN1VUNmZFRlg3MzB4QTU0TDljTm5aUkU5eVBQWkh5TlhLeGhDYzBM?=
 =?utf-8?B?QU9DVmc1dWpLSkhPNTRKNzQyZ05Jd1J2emxIdms4UUpyUmUzNnJKcWtjY2Fy?=
 =?utf-8?B?ZHY0ZWtjWTRleXZKN3JVVWhob2RRaUFkTEE3QWZFY0ltbTdQbkVqK0RIUUdG?=
 =?utf-8?B?NGVvenQ5VXFhM09yYUwvZjAwcDFuY25UZWRaeWo3TXc0dDNhYjU1OGViZGk5?=
 =?utf-8?B?RFN6eWVYN3h3bkRITGxKOXFVdnJwa3lZdlVSVXBSdUdCL0lwSzdBL2xvWTJu?=
 =?utf-8?B?WFN2QlJPeWkxdFVNVzZ2dk9JOGp0M2VpeHgrSEVyMGY3aWpqWWdhYXZscFVF?=
 =?utf-8?B?bDVsK0t3SElvcHQ5QUovNTB4VVBKUW01eUMzRkVNZTZWRGtobSswTWxiOUhZ?=
 =?utf-8?B?WklITi9nRlNxbHhkR3ZGbEJKMUZ0OXhmTGdENzA0SDdaNjZwczdCS0gyVmxL?=
 =?utf-8?B?dlE0bzZ0UTN6TDZCTU9pYmFvMHkxdVRqTVZMNjVvSTZWSGU5eFFNS2M2MVow?=
 =?utf-8?B?RWxGT04vd3pFd1pSSzRuVnZ0VGVOUXN4aUwxQTNpL29RTHozK3dwUnBEdndJ?=
 =?utf-8?B?Znd4WDAyVXhOc1BXSjBDanFVaENlSEE4ZFdUOWNwT1JTZjQ0UGt0bVI0a2kv?=
 =?utf-8?B?ZVJsTitsVjB5TlJmbnppRmVYaUxySmQ1RUkreGVucmc2VWlWOVRkSGppUEdm?=
 =?utf-8?B?NUdKSkpoZFdlUWdkc3prcGRDekFmR05Ua2FPaXd4WVM2cFRNM3A3cXMwSlBT?=
 =?utf-8?B?bE5reUtoL25weGRQYmJwMDF4dU5ZMHNRR3ZWYXFNbEI2NENsR2xuWHkyZFIr?=
 =?utf-8?Q?ytsMznO05HjUMteTtD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a99bd62-8c6c-44bb-8baf-08df3fcc6939
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:18:48.2942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFqbuovGKa1j/mxgfeQJf4x047zHndh2Sihxhj+KTIWmRip5/c9LzhrFwqjDwyuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adding T.J. to comment.

Regards,
Christian.

On 11/10/26 13:51, Kang Chen wrote:
> bpf_iter_dmabuf_next() uses kit->dmabuf == NULL to mean "iteration has
> not started".  dma_buf_iter_next() also returns NULL at the end of the
> list, so a next() call after exhaustion restarts from the list head.
> 
> The verifier relies on the iterator contract that once next() returns
> NULL it keeps returning NULL: process_iter_next_call() marks the
> iterator DRAINED and treats the result of later next() calls as the
> constant zero.  A restarted dmabuf iteration therefore hands the BPF
> program a kernel pointer while the verifier believes R0 == 0.
> 
> Use an invalid pointer value as the drained sentinel so the iterator
> state keeps its one-pointer ABI, and skip dma_buf_put() for it.
> 
> Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> ---
>  kernel/bpf/dmabuf_iter.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> index cd500248abd9..a2b7c38f9ae6 100644
> --- a/kernel/bpf/dmabuf_iter.c
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -156,6 +156,13 @@ struct bpf_iter_dmabuf_kern {
>         struct dma_buf *dmabuf;
>  } __aligned(8);
> 
> +/*
> + * The iterator state is one pointer wide because struct bpf_iter_dmabuf is
> + * part of the generated vmlinux.h ABI.  Use an invalid pointer value as the
> + * "drained" sentinel instead of growing the state.
> + */
> +#define DMABUF_ITER_DONE       ((struct dma_buf *)1L)
> +
>  __bpf_kfunc_start_defs();
> 
>  __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
> @@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit = (void *)it;
> 
> +       /*
> +        * The verifier assumes that an iterator which returned NULL keeps
> +        * returning NULL (see process_iter_next_call()).  Without this check
> +        * the NULL left by the last dma_buf_iter_next() would be interpreted
> +        * as "not started" and the iteration would restart from the list head.
> +        */
> +       if (kit->dmabuf == DMABUF_ITER_DONE)
> +               return NULL;
> +
>         if (kit->dmabuf)
>                 kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
>         else
>                 kit->dmabuf = dma_buf_iter_begin();
> 
> +       if (!kit->dmabuf) {
> +               kit->dmabuf = DMABUF_ITER_DONE;
> +               return NULL;
> +       }
> +
>         return kit->dmabuf;
>  }
> 
> @@ -185,7 +206,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit = (void *)it;
> 
> -       if (kit->dmabuf)
> +       if (kit->dmabuf && kit->dmabuf != DMABUF_ITER_DONE)
>                 dma_buf_put(kit->dmabuf);
>  }
> 
> --
> 2.34.1
> 

