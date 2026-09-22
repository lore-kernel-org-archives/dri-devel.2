Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305D2C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8635510EA4E;
	Tue, 22 Sep 2026 12:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i01rFyrL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cTped5bN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5121010EA4E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:10:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBPZ9q2869443
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WmuNBCn2WcfbClZ5XMSuk70NP23bX3kKvNdyJ4b97To=; b=i01rFyrLz8Io7eud
 ZDHIioglcZTF0Sri/5VWhE2RsAQ192uXjBkODwYl8QZqw2A2ex8I/WFnfC4KG0Ad
 88440la7uJRDqxeXHjkqwL6T9A15948QmHnVIOIy5II9NWrOFGqkrMeW01JxHlzK
 JTbrnnr0ttguVzFe15ntBpGDSUPxHlYNPgmpG/4tjVuJKYfBiySPl0NhJPYqj/dl
 86dhfYA8sfMUbqyuJ5N5snars3PxjRvchmMWmV/m22Iv2Wq1DN3wW1KPftiFJCM/
 gmvHHLphfDoF7GaH0q4X69oBpTSNycyAAAeWL4/HBARNpwodMq0B3h/9yckTqsbg
 zRgIfw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guj111v1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:10:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2df375fb9b2so34036385ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790079052; x=1790683852;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WmuNBCn2WcfbClZ5XMSuk70NP23bX3kKvNdyJ4b97To=;
 b=cTped5bNLlwiH77F4bULaJgvgsxvRMgRiTL5CE8VRxcYy3Viycy2ZtrEDQNRG8xYGe
 nUJIGoL7YJBYyI9tAUeeCXE/p+eWhDyLi1qBSY0bR6Y1PQ+5u2BwdsOD8yZntqPt9NSk
 ieSDcgkFb4/PfPh0xQ4fHpsLzQl7J/c28xr/HaAy5hxMRPuDXbqgyrg1/YEcNnUZZZ7g
 lz1taE/J5aUkh7aT6bpdew3VRjpimWq001SsyTveqnNgfr8NrJtOi0mooE0mx4nivQ9V
 bGYx1tLkLIPcjGjTnrhstkw1Vd0jueUiP1TjeaxHo7gvfU7eBlNYGDPpU5CL5Zxs8osR
 c1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790079052; x=1790683852;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WmuNBCn2WcfbClZ5XMSuk70NP23bX3kKvNdyJ4b97To=;
 b=NrIDcZiSMb+KWUPlQGX7w5BTFGWg0jTHR9qgXIedXLC4o/KT1Zt4bG6VR6haZf/s3M
 w9hpVPG4/bVHtGTqnbgQQwIax09ItgQNUaOsXbfosd9tu4Kad17Hylledpi8s04wGwtN
 V71SLQfMpMHMNI+REVRf+FRo1IBBHmRn32jQ1lFD6xyDLkZqvnApwJZnDaJRgZh18XQ/
 N/VYEBHVGFRKlNuOHI71YRzfUW79/yh15qzEJmldYMrCq8Kw+oDGC69tpz58HO/n8g5Z
 67W8b2kAxbBgAp3i5q438cTpC0pT0eFxucadGGxWF/wnBu2TTKSSTF+Xv+eNzBc+cYMK
 2J/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwddiSOQy9t4TdahUlKZZhpTD4/j1eLtN5bivAigfkC77gSnvd5C1tC4o5Yuw7PkZJNOkKvceBVnlc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++na3wUevDQCEwd9CW7FAZop3kickCqDwWIhCnLx0ErKS1fDeYWo
 dLXTaj+66/kXGcTgOBJ3u45ZJVHbAaPkLFzO0HchnzJU+KRDfmFzNGyiCGo6kodU4kY6HFCvvJF
 4mOA59eluI37iKF4O76SHMgnYqREx3vsfzeS5BgAkq8OqRabrrWBB5vO9Q6DzTKs2AwISazs=
X-Gm-Gg: AYBFou0DSXoKEe39fhvr5lavERWSRbCyblTnEamOoHgArvV/OOsmvJD6Q8GgmfC4tJi
 TLdIPyeDpNeRoLe11ZKqUN9honH4WxNpV2z0XV59HwWAXP75DwGcybCBASRdTYOvr6kuqUQOUJe
 6jyoX/MQXEfQHzk81VCUogYFR4pKgC94fGLqQD/vHPgPKpt5y7dgEh3DH8YAg982Upkp6CGdWOn
 T+sPhcKppIvPMi3QnzEMrS458vL9+jrhSIZ8gSZExWvpKVW5zDPOJpxiKhqAi+/hItUEaXSiDY6
 sRbH1C513JK8kdac2cvlaAjOJ6tBzQwh02eWOoCoGNks2qh5u/KWDmt/iJSFcaKuWihWtofQwyp
 3zSYh/4T8ULHnPioc4r5gFVxjTPpQza/7HJXmebHxb6VgfGBeIUlVktANijRtUvTNR95exdq9T7
 gW41MjDzHPtVZQljAMpg==
X-Received: by 2002:a17:903:28f:b0:2db:8c12:6b03 with SMTP id
 d9443c01a7336-2df609ad83fmr11047215ad.8.1790079051448; 
 Tue, 22 Sep 2026 05:10:51 -0700 (PDT)
X-Received: by 2002:a17:903:28f:b0:2db:8c12:6b03 with SMTP id
 d9443c01a7336-2df609ad83fmr11046765ad.8.1790079050851; 
 Tue, 22 Sep 2026 05:10:50 -0700 (PDT)
Received: from [10.79.116.160]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e612c9ca7sm6295940eec.17.2026.09.22.05.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 05:10:50 -0700 (PDT)
Message-ID: <df0a5e79-f2a2-4f74-868b-8f6291accb04@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 17:40:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dma-buf: system_heap: Set allocation orders for larger
 page sizes
To: Juan Yescas <jyescas@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: baohua@kernel.org, dmitry.osipenko@collabora.com, jaewon31.kim@samsung.com,
 surenb@google.com, kaleshsingh@google.com
References: <20250417201913.2393655-1-jyescas@google.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20250417201913.2393655-1-jyescas@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A656BZGmbB9k3LclpLNLQ_UA2YUkLLva
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE3NiBTYWx0ZWRfX4A/zA3Hghlvh
 kGWe5ve7XsBJMygPIG6MwDddBGlwYpzHyGWnKa9cJVy1lvQ8q3gdONrkwUV0xr01oeM4nXioDKq
 Y4gjfVpLFQjDMlKdFUfUQjt56AHpyxM=
X-Proofpoint-ORIG-GUID: A656BZGmbB9k3LclpLNLQ_UA2YUkLLva
X-Authority-Analysis: v=2.4 cv=atQnmiZV c=1 sm=1 tr=0 ts=6ab2704c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=F0MHshuycdHDXIU-fbcA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE3NiBTYWx0ZWRfX9yjY+qShqj5f
 4+ZJI4AVcZNAogvK/8n2Je2qzNanwqRwzep9spwkI10JXjoJas69ecCQ5ye4m2xtiCRROTIZmL0
 Kn2Ap9+MxvBEeTWmyAplMvXKUhXpZDHiZ9HvKOtmIknbvr/hmRJdu/8N3UFVRnU0IST0yGr1CJT
 frZnbcwcjG/YNSm1MXQgTXHwEoRZTfKM34SayGTFUJNdALnl70hqzFobEZxl/YIzF6C45VQQE29
 AFfwAgqE/kzixq2jbCL1FKwYHAtEcGEQ6qp51ik3k9/Ge9BLiP+hSgfxoot0iXq5XDyhJQxVwZI
 rrfnTHFuhpjNYgrTQtZ5lkfmxRy49tVIGDgt+43pHlw/dLDxr61Vl/sgneqHeNJJu5ufKIejft4
 cDge2W3vuK51gzQBlCQkkkGh+HAY7GECTyAobRijHCvFo89CCCcXw5IQTeBTKH6FK9GZXSyCU6T
 cYkWjEAtAuEtNqCzRCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220176
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

On 4/18/2025 1:49 AM, Juan Yescas wrote:
> This change sets the allocation orders for the different page sizes
> (4k, 16k, 64k) based on PAGE_SHIFT. Before this change, the orders
> for large page sizes were calculated incorrectly, this caused system
> heap to allocate from 2% to 4% more memory on 16KiB page size kernels.
> 
> This change was tested on 4k/16k page size kernels.
> 
> Signed-off-by: Juan Yescas <jyescas@google.com>
> Acked-by: John Stultz <jstultz@google.com>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> ---
> 
> Changes in v2:
>   - Add John's Acked-by tag.
>   - Add TJ's Reviewed-by tag
>   - Use dma-buf: system_heap: in the subject since this is specific to the
>     system heap, as per TJ.
>   - Remove extra space in if statement.
> 
> Changes in v3:
>   - Remove defines for the orders as per Christian.
>   - Update the order array for 64k page sizes as per TJ
> 
>  drivers/dma-buf/heaps/system_heap.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index 26d5dc89ea16..8c10c0f2b473 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -18,6 +18,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/scatterlist.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  
> @@ -44,14 +45,28 @@ struct dma_heap_attachment {
>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>  				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
>  				| __GFP_COMP)
> -static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
>  /*
>   * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
>   * to match with the sizes often found in IOMMUs. Using order 4 pages instead
>   * of order 0 pages can significantly improve the performance of many IOMMUs
>   * by reducing TLB pressure and time spent updating page tables.
> + *
> + * Note: When the order is 0, the minimum allocation is PAGE_SIZE. The possible
> + * page sizes for ARM devices could be 4K, 16K and 64K.
> + */
> +#if (PAGE_SIZE == SZ_64K)
> +static gfp_t order_flags[] = {HIGH_ORDER_GFP, LOW_ORDER_GFP};
> +/* 1MiB allocs are calculated with (2 ^ (20 - PAGE_SHIFT)) * PAGE_SIZE = 1MiB */
> +static const unsigned int orders[] = {20 - PAGE_SHIFT, 0};
> +#else
> +static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
> +/*
> + * 1MiB allocs are calculated with (2 ^ (20 - PAGE_SHIFT)) * PAGE_SIZE = 1MiB
> + * 64KiB allocs are calculated with (2 ^ (16 - PAGE_SHIFT)) * PAGE_SIZE = 64KiB
>   */
> -static const unsigned int orders[] = {8, 4, 0};
> +static const unsigned int orders[] = {20 - PAGE_SHIFT, 16 - PAGE_SHIFT, 0};
> +#endif
> +
>  #define NUM_ORDERS ARRAY_SIZE(orders)
>  
>  static struct sg_table *dup_sg_table(struct sg_table *table)
> @@ -318,7 +333,7 @@ static struct page *alloc_largest_available(unsigned long size,
>  	int i;
>  
>  	for (i = 0; i < NUM_ORDERS; i++) {
> -		if (size <  (PAGE_SIZE << orders[i]))
> +		if (size < (PAGE_SIZE << orders[i]))
>  			continue;
>  		if (max_order < orders[i])
>  			continue;

Hello Juan,
I've posted a respin of the patch by extending upon your work,
Can you please review?
Aplogies for adding signed-off by, will drop it in v2.

Link -
https://lore.kernel.org/all/20260921-dma_buf_improvement-v1-1-23d82e771dec@oss.qualcomm.com/


