Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1571CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50CDD10F24D;
	Thu, 25 Jun 2026 10:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ApHSSYb2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3282110F24D
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4P14zHU6z6uC+bc9hkLzyWI/1MbKJQacZfL8gSiK2NQJEP1aLoTLUYzxxvuwZq9ZFQKpisygfW0yvP2KyeBMmfhGPHGlNA/16Bi3L4V3jcVp4T2VfI5plvavmd/EWRDXrLnH2vibSwgKIh8HjuCMqZkv7JEyRAyvaTrJ9ppjLbKc4KwupfEiOz+m+9+P5eSpyRDDn0DUY3bDcwzfc2urNtI8aGWKstRqP2tOwRBZkrQAdvHsqtYhwuSbP+lx46NJfQFHjA62cg5/UdxtjrB2Fy82oipFm77MyvOFdj9etP5lqEShXqrXWOS0AD/anRp54Xk4UQd3TqcFh4ZvWhJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEMD5NoY06wPL+gNgcISilYpatnOjqwNLDnveG+zwx0=;
 b=F6x2eH5mVp+gGl8y82TdebIGlyF0edFEiktBkCQgV3OWV+uv9Nrr6EBt/nsNMoqoUNQkuz/SrnuIrtD8D4+G2mRCVbL3EgEdxUd4wmcsmq6Sdn9mdRHEACYSB8J3X8WPWogZh4adF0emtHRHBaOgMTJU7pNNdDb936QAfgM75DFEUZCJGimAnMI53yonArqtmM+ajd0pSkY/VIEWZY0zDrCbM5S5w+MzXXpU09sCj87W/R7sMsRKveu5XPPS2S8zvAUf3E96bcya5nRN24mwUhrS7tehPBO9akpKH8E6nnTUfdEqqdHu4jLJxTNnJEAKmyqfXOrNC5yv8xFXyOFNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEMD5NoY06wPL+gNgcISilYpatnOjqwNLDnveG+zwx0=;
 b=ApHSSYb2koLDDzqpI6e68LFGfqbnmvQRWE6GP+Eh7A00smGeP/thlAKZPbhDenSsh7vT7iNpgHmsxT/RggP87tMfJ5OsO4iAk0eqS/yvJX+js+kM4iwkujZHrqQDu7gvKNSsy2ZMp5S2u+9WjU7XG+3FVJr+Yx3HlEWcbjOYqd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 10:49:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 10:49:04 +0000
Message-ID: <5867fd98-f8ed-4892-a48a-eaefb4c76900@amd.com>
Date: Thu, 25 Jun 2026 12:48:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udmabuf: serialize the sg_table cache under the
 reservation lock
To: hexlabsecurity@proton.me, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org
References: <20260625-b4-disp-67d1f3db-v1-1-a47fb9edab9e@proton.me>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260625-b4-disp-67d1f3db-v1-1-a47fb9edab9e@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:208:530::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9b9b5d-39f9-46fb-5b72-08ded2a75f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: KUJeBfSA6AAvJkfcepxDU8tqq4GGkCpYErUtB+Xe6taoa0pSrj2dDQh/a1uikzY9FjhRPgZNg88EsdNHTCpUuybonA2z9DP4FOFLhuqc8xpxrGf8Hwra52y7PLDJ9ZvFoB/qDQLYaiSsiVUBlrmWLGDJiX8QBV89Nzo+bYGY+SUK2IojqtLwWCxG/2Hd4bcep/WRwSewB5d11SXXBD8Ty7Mg4tnsNAb4aPuhCSdZPXy6IKnZW3wtAGvqOW0hy8oSubee42VZ9PdM0b57VrAseuqmZoo8PTHY65XIFhHCdZq/OloCDr7JwdqfLOwObanEHqOuiRRVUs0i8pHI+0StJQbUV8pjf9ILqIsw66QxAjBrt++vEwEGhOFbf6wDRJw2jKXTHIwvv3MH7AbBvCGCFM6HleM9Ykjl2FctSGaLwPEzNyEOmufjFE78Sv1hmSvT+VREIfuS5VIrSJN4tfmZm0Y6AtqvgaO6LmNKXspDVDKuio/JSPbyHv1GAFhX4mGpOMugywL5e8bNevbPzwsN3+x4YaoBbxp2GYLWwVnVZ3YLLQhbL5tZj4sQM+59NR7ueKPze+b/iGVSlmJXrrOJDZ6Pn3Q8p7doZ1P9xXkCc4B9WFjurUNq+MZTw1uX934RWhzM9DxFE7FJc70r4K3M27d1Nt+Axu/OQjmIrJDdckM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3J2NE5hRWZLb2N0MFRhVTlUc0FDQmtVMi9COFFVQjFRK1ZyY21oS1FSWjNK?=
 =?utf-8?B?VUNSMFB5VlI5VnBIRTNWVzF4emExOWFkak4yTkFSTWhVQWdqTzlTRm0zalMx?=
 =?utf-8?B?MTRUQTNuVTlpMGxjYXNWUTZPTW56K0RQYk45eWppZjUwVDBOdlZsT1pNZW5h?=
 =?utf-8?B?aENsb0NET1VrdGxSWHYvYmw4MnZnL0gvTm15OEdvc1dHcnlWOXRkaWM4VHdJ?=
 =?utf-8?B?UGVlSHZtU0RnWWhKbWwrZWNCUjBnWVV5U0MvRXJma1YyLzlPOFpzVUdjU3VY?=
 =?utf-8?B?YWFHYVhnZjZCUm5yWkRKbEFEOVZ2WHdtN0M0NlVCcDFrc0ZoWWZabHVCcWdS?=
 =?utf-8?B?UzhHanR1T1FVWHJaWlBYUmFtYmZQQTUva3FZWm5JK1BPOVNkdXBaaWZaRkNN?=
 =?utf-8?B?aHNKY2FoVkl0aHA0aVFwc3lLWkpKWm5DWDRsbFJ0N1JzcFE5UWxlRXBIT3NJ?=
 =?utf-8?B?ZlRaRjJHeVB1TlZGcTNHZy95Q0hhK0lRZEx6Zm1TS1FKT2ZUWUpPdkEzU1lC?=
 =?utf-8?B?RlB4SDcyRk9pOFN1elhJZHpSYlN3MW9Nc3AveTRPWktsMVF2ZU5BWTlvZTVR?=
 =?utf-8?B?TXZ6cGUwYThwcTRWVnErNlJBZVFCZS9pL004OU12NkN4U2drN3pxNDdhMXcx?=
 =?utf-8?B?ZlZmN29XbGpmLzlIRmtUTXVNSm9uTCtZazE5a0RUOFhVVWF3ZFFnS2REQk1j?=
 =?utf-8?B?d1puWGpicHFOaElTZlpQZFo3YkxuSnlnVjhHdW5qYnhMcEJoZ2RESlVySDNZ?=
 =?utf-8?B?MGNETE4wamtqU0ZrTEM4WlhmK29kS1ZYTXlzK1I5b0t6RGdPdTE1c2RkRjZG?=
 =?utf-8?B?MDl2OE00RTl6bmpzUGpHMGlxS0M0MVpVUXFodm81cWhaWTFwdm1INFZrOFoz?=
 =?utf-8?B?bW1JRXoxTExLWTJ6Y2FLcE8zTDFReHoyVDMxcGwzZ1BSREZtREdaOXN1SE43?=
 =?utf-8?B?WGErRjIxWStoQnp6THIyaUhCbFBhOWZ3ajRuWHVLWExlVVZSTmJlWS93YkdR?=
 =?utf-8?B?WHdFMVFQVldsME5zNUZCVFprN3hVeHZxN0ZpdDZZcUN3M29ndDJqdlkxSVNq?=
 =?utf-8?B?QXdRb1FDeFZicnJqRStmN3ZmRUZ2S2JHcmVIS3RDdWVWNFQ0Q3dKQ09rZE1j?=
 =?utf-8?B?VWc3b2JSemFJZnlqSXNaTVhOcnVqZnArRitua1ZGcGQ4eUdxWExtZnNLMVVB?=
 =?utf-8?B?bzFWTVBKTDcxNEFZUHIzanRRN2FQTmhFaDlsZTNpV3JoekpZb01idkxqdTFZ?=
 =?utf-8?B?YU5kZ3dmSVJQUjFUMDI3TE5MbDFUcXk2ODYwMmdadjVFUjFzalFlNlUxWVhQ?=
 =?utf-8?B?bFZUcW5wU3NDY3pjN1p3YjB2aHp4cmRXUGpxT0Q5OWttVWNMaWoyc3ZDNkpX?=
 =?utf-8?B?cXI4VmZtR2JnUXRDaTlKNlczMlRPd3JoZlZHVUNZVDB5Slk2UWpDbkV5anRS?=
 =?utf-8?B?Tk1najNJTVNYVkFpWjU1TkN6TGRIM1NVMm9ySnQ3TmZQM2ZsQ3pzSGM4MHZt?=
 =?utf-8?B?U043MXB5TjdRVndOaDd5eDlxQnFHS05RNWRiVXVOZTk0TitqZ1RwMVFPY1Rt?=
 =?utf-8?B?b2NrL0l2cmdZUjZ5bGdVVkcwZEM0VTNNVEtKMC92MkRXN2NrV0N0QU5IQlpM?=
 =?utf-8?B?NS9Lc3h2TFZyQ00xTTY0WFF0OG5GaFNxaHQ2UFhlMHRWYTh4WnNiMkpvemlp?=
 =?utf-8?B?VnRDNXd0VWhrV2pTUFdRT0xTR0NCQUVIY3VVWkNlY2toTWFCTGNXanBha3h1?=
 =?utf-8?B?Y0JJbnllSDFQVVZJczJxeHhxcXdMd2tKU3ZUdm51dWxTNmt5WTZJaldzZGNW?=
 =?utf-8?B?L09veXdVZUlYUGx3SWcvNnpvOGNPYml3ZytnWHlSRTMyYXRsR0d0ZXNVS0Rr?=
 =?utf-8?B?QW5jWDJJekRyMFhWdUwrc1hYblhhTkpCY0QxRkN6UXUxWVJoOXhhQk9lN00w?=
 =?utf-8?B?M1hteDNTSWc4VDhWbEgvUU5iajFBNjZ2bjB3ZGVEU0lQeFFEa3ZvQTZXaEpE?=
 =?utf-8?B?RWk2TmsxVWE1MjR6VjkrSDljSjAxaU5ueFAwTTUyY20ySml2VHkzZXgxcjdm?=
 =?utf-8?B?OHMra1dtczVTd0s5R1ZDczlJTlh3SEI2a09hbzlEYWdncGJnSDk2Z2YzSEln?=
 =?utf-8?B?NHZlLzhhQks4NExZVXcrbEo3ay9vMXFzZ3NqTXdGd0ZmMWROcVZIZXNwSng1?=
 =?utf-8?B?MXdZaTViUGJVd3ZlNzh6WnBMMm9Wby9NbXdZbUp0bFQzQ3hMRU5RZUJQVkJ1?=
 =?utf-8?B?KzZKRUNIOUtBa3ZDdjFkUE96YmRWSHkvb1lFYm5sQ1NscTNtNTRqVVdWQ3Ev?=
 =?utf-8?Q?hoZI9aYPloXFQ/N/SK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9b9b5d-39f9-46fb-5b72-08ded2a75f91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:49:03.9526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTR8iQzzi8XVxEXUXsrm/wHzjDwQ8AMf/7DhQTOlGV6JZeV3XuGhTdoA8CKghgTN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707
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

On 6/25/26 08:10, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> begin_cpu_udmabuf() builds and caches ubuf->sg with an unserialised
> check-then-set, and end_cpu_udmabuf() reads the same field unlocked. The
> core invokes both cpu-access hooks without holding the reservation lock and
> DMA_BUF_IOCTL_SYNC is unlocked, so concurrent SYNC ioctls on a shared
> udmabuf fd race on ubuf->sg: two begins can both observe NULL and both call
> get_sg_table(), and the later store orphans the earlier table and its DMA
> mapping, which release_udmabuf() never frees. Each won race permanently
> leaks an sg_table and an unbalanced DMA mapping.
> 
> Serialize both hooks under the buffer's reservation lock, as panfrost and
> panthor do. dma_buf_begin/end_cpu_access() already annotate might_lock() on
> that lock, so taking it here matches the documented contract.
> Single-threaded callers are unaffected.
> 
> Fixes: 284562e1f348 ("udmabuf: implement begin_cpu_access/end_cpu_access hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> Same leak-with-dangling-pointer class as CVE-2024-56712 (export_udmabuf()
> error path) -- a distinct site the 2024 fix does not cover.
> 
> udmabuf is the only exporter that lazily builds its sg_table cache inside the
> cpu-access hook without serialising the check-then-set. The exporters that do
> comparable in-hook cache work all take a lock first: panfrost and panthor
> dma_resv_lock() (both hooks), omapdrm omap_obj->lock around its lazy page-get,
> the dma-heaps buffer->lock, and the TTM/GEM exporters (amdgpu, i915, xe) their
> object's reservation lock. tegra and videobuf2 take no lock here because they
> only sync an sg_table built earlier, so there is nothing to serialise.
> 
> Confirmed with an out-of-tree A/B exercising the begin/begin race: this driver
> built as a module with get_sg_table()/put_sg_table() counting allocations
> against frees, driven by a userspace racer that creates 3000 udmabufs and fires
> DMA_BUF_IOCTL_SYNC(SYNC_START) from N threads on each shared fd.
> 
>   arm                            leaked sg_tables (of 3000 buffers)
>   vulnerable, 4 threads          4761
>   control, 1 thread              0
>   patched (resv lock), 4 threads 0
> 
> One sg_table and its DMA mapping leak per won race; the single-thread control
> does not leak, isolating the race; with the lock the lazy-init runs once per
> buffer (3000 allocations, zero leaked). end_cpu_udmabuf() is locked for the
> same field too: an unlocked end could otherwise observe the transient IS_ERR
> store begin makes before resetting ubuf->sg to NULL, and dereference it. In a
> tighter 5000-iteration loop the unpatched leak runs around 15-20 MB/s of slab.
> ---
>  drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d65..702ae13b97d1 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -226,6 +226,8 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>         struct device *dev = ubuf->device->this_device;
>         int ret = 0;
> 
> +       dma_resv_lock(buf->resv, NULL);

Good catch, but we eventually wait for HW to finish while holding this lock.

So if possible lock it interruptible here.

Apart from that looks good to me,
Christian.

> +
>         if (!ubuf->sg) {
>                 ubuf->sg = get_sg_table(dev, buf, direction);
>                 if (IS_ERR(ubuf->sg)) {
> @@ -238,6 +240,8 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>                 dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
>         }
> 
> +       dma_resv_unlock(buf->resv);
> +
>         return ret;
>  }
> 
> @@ -246,12 +250,18 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
>  {
>         struct udmabuf *ubuf = buf->priv;
>         struct device *dev = ubuf->device->this_device;
> +       int ret = 0;
> +
> +       dma_resv_lock(buf->resv, NULL);
> 
>         if (!ubuf->sg)
> -               return -EINVAL;
> +               ret = -EINVAL;
> +       else
> +               dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
> 
> -       dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
> -       return 0;
> +       dma_resv_unlock(buf->resv);
> +
> +       return ret;
>  }
> 
>  static const struct dma_buf_ops udmabuf_ops = {
> 
> ---
> base-commit: 7eed1fb17959e721031555e5b5654083fe6a7d02
> change-id: 20260625-b4-disp-67d1f3db-0082918fdcb5
> 
> Best regards,
> --
> Bryam Vargas <hexlabsecurity@proton.me>
> 
> 

