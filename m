Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECD4CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 00:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CBAE10E133;
	Thu, 25 Jun 2026 00:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B80/P+ks";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF58410E133
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 00:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782348261; x=1813884261;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=dOjHZQ+edFJfX59xQ/mL27dJW7KAZ9nRUxC79MFXRPQ=;
 b=B80/P+ksuFp1lQ00sapbb/U1pMulrIYm98Yy1IaMQO+0VrZCCRCXCkGJ
 +ZmZ1/zw0JbJKY56RtSVEbPmHA0VSBXPdBUQTdCvdTkhhd3fqc3sJguf3
 x/bGPDCIZoyd4qiuGt0Y+nc2WcZKf+AXiTnotS1wk0+CXb+4uqTbHgzRS
 LiaTFM80zx5KgMfbinHa5awt7//JJmElGkvPQ08gqO502iULpnGJqaqwE
 3jg6kGkh0rXaUPJEBubrZ6VOA0Iu0JFymmMMI1i3kdRsCpaZiOcUxeF5E
 2wcBUkwJR38nbaLYEWOTOZS/TbxJglaoBiU0Fjk8fpC8EojxRacZnIJJy w==;
X-CSE-ConnectionGUID: Kd4ouul3S+O3vT9JU5tMeg==
X-CSE-MsgGUID: u8vAIj3iT56tkdr9mQvb/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100547207"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; d="scan'208";a="100547207"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 17:44:20 -0700
X-CSE-ConnectionGUID: C8rPzSARQ/KhXEamGNlOXw==
X-CSE-MsgGUID: mkq/2o7ISxyItxQ2r3OqXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; d="scan'208";a="254063420"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 17:44:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 17:44:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 17:44:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 17:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/qjEkE2tOS99NeUhcq8T3AW7K7VugyVkOEPQwj24JwMSU58Z2vhj0Ie/sxW3xM7QQbKqfyJ29NJ36ePnUvRIMikujTLpFpzZ6vqYryN/IXrLOf0rnLRmKPpLTa9RRgKtlUaH98gOf+aPbSITrQ5Jo+fUR6N2kilgIBURrM77EzpD/xdfyTiSnmjbmn7r6ePuVDTw2gdgoClF4Cs6M5t5gIRSvkDCQjWqHzcZBnmO1BXC7NT22kzqdB0PW015mHGtzicsDTGgVzpNRZZc2zZt4MuYceq8wpwQu2eXnkDh1u1pUCqNOyXSDYzQM5HmJlJilCTsi2BIAaO4KJR9jTdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwTDxZ3zKu77bO3il/20XYZx7ZyrU5ImIOkIqi34QaM=;
 b=voaQ+T1B7IOZc7iV2NszmrRryZPxD2yUrqCZGeIaVaoPsw2EHGoLeTg0EYJFBqzz2F5XzNi0HwzQlL+qZbEZIMabTYrhCvBsKuElwT925eCqI8AZeOdfaOgeXoFGbH/0t7QbrZ76Tqu/iZc+XnnAUD51I6oNHV0pLnGrC/5IMmw/72BZ0eY/OfYlr+YwKZ/xD6fBAQiGXmVe7pbV/b19q/ZYoDRx2lgxl2QP/9+W3A4AyjXt7pzTmwxopk9psMCXsc72fqjFfMt+M0Z6kRSXBfobth/HCv+V5f9h7/V0lmqH31PpkF5DMiMCMUls/zdcMsTEMhrzbYWJ7zY6xnVzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM3PPF9EFFC957B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f40)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 00:44:07 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.014; Thu, 25 Jun 2026
 00:44:07 +0000
Date: Wed, 24 Jun 2026 17:44:05 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <christian.koenig@amd.com>
CC: <phasta@kernel.org>, <simona@ffwll.ch>, <sumit.semwal@linaro.org>,
 <tvrtko.ursulin@igalia.com>, <dakr@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH 06/10] drm/xe: stop using dma_fence_is_signaled_locked
Message-ID: <ajx51f6y9t3ER0te@gsse-cloud1.jf.intel.com>
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <20260624122917.2483-7-christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624122917.2483-7-christian.koenig@amd.com>
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM3PPF9EFFC957B:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb9e346-dba2-4274-9353-08ded252dd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ZvtOr7BaYwXx3VRQ305ukYTPUQWrd6KWD8gQ7Mla4O5+in9OPb81deBKu1JgxTMBgt/qt6YKX1WsM8jUxowFGdknS7E3bIYK09vf1EnZ8M0/LBJCAdlL6xcUc1dFDpMYOVMrov6VRUklx7FuNrj9nKcKNhUoFeZ5YXhZGsg+WK0PINqqenj3oVLzjO5nD3wBOkCGxSvgCW97M1I8NKfsfs+xsTPZmIfRhe5m1I5qglXzGwdwGax8DLa8GjL3q33EfVFVV3GTTtyg92eLBsl7VKWSb7XMJCaqPKwqtx1RdxW71tTNEy4kfXZgTRhJZbGua0C9kdy2tWxVzV3A5xO5UeBKzg0C5BViqI5LDhKBxAAWrugylEmyWSdJC9kOf3I9Sl19L2iBe0dkItY97nlbLljTWfybGKv7DwMOYisEBbY7wtAjRXG646DtSwD1DAWqco9IRXml0H2WutrZ16yO4Tb1VINQ5jII1TsNUv2FZaybWxnSrGSx4W3X2bPha5O5Wq6y4UDBvOpeLfAB5gnk7DoJKiBhher7knwgDWJeG1VeApvqQ9xMQRSnTQAky5warQ5soARu2LLQYqgdZBmtTMRsKQl8SlNPLi7awCEEr8Yg0662cIivFrWdQQd3KjWrcJBw1reiP/lzo9Hx4YuwDzG56v1k8dpaeuAMZly/tfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ND9cp7IqYGUE9QeTGG0ZYBnyUO+Dj7ZzVIxZZ1WB6Za0Gv8ZdBwdcM0xyb?=
 =?iso-8859-1?Q?V5vcy5WnmQGS+0orkOfV/ZQUjpCcroVMzlferFhJMUPsO/m/eecUPGR0Lr?=
 =?iso-8859-1?Q?b3f8kCvWMJT6ClNoSHqEd4ki3sQqcAAEX9NZSQcpBXn71IFXUkzDNTgteO?=
 =?iso-8859-1?Q?lBqY9l1s8jEGQzDbiNUjKh+DZINmgaBcQuHDY3HdG9qRyP+/WQiglHioD2?=
 =?iso-8859-1?Q?/aDVLc8nX8/IHo4S8BQEEu+/1NAXETl/DPzZ3lZEyjwPmbT9o0gInximiR?=
 =?iso-8859-1?Q?tQp2DCZsHg08XN0yPxNrXAS/3YoWkyRsOTD+K2CdWoIx6rLsRNsk6p8QOd?=
 =?iso-8859-1?Q?IbNFIzes39Nbd/+uLJcTBauDst1SUsQ2bFd/1qZ5vEVUAFwJRXEPUrWylv?=
 =?iso-8859-1?Q?j4UlIbRm9MFFkNZDIvD9LNDZYdc6VokyU+t43TmdBwWjMxadTbk/9jM48f?=
 =?iso-8859-1?Q?lFQ3oW8DwkG78dQcYBKaHlWK3lf7gu6PCH2ec2nGQIe3sKVKGH9A47CEGk?=
 =?iso-8859-1?Q?lVjRAw+ILO8Ty/U/9JiP0AhZp/11Uijw5v+q6uxKGRUutcE5VmEX6KVM3H?=
 =?iso-8859-1?Q?YrRnQSLO31X+JTS8lWFqXMg5FapMQiQfhyTgLum7ULh2VCg+fTXHXxbydn?=
 =?iso-8859-1?Q?VXCeWBuVjQTVe8hTu0iEoY5agg7BuK8oM/9L/cZU9Kvd4KjeYkUCDwbhWT?=
 =?iso-8859-1?Q?39k17OQ8xanj5KrnoXSqD1W/oER3Fsfyf3hB5FUXMjwvamTIuKDOFMG+Ia?=
 =?iso-8859-1?Q?DIuJu1c7PcHOW34LrBI0mJNDse4ibzdLPQ5a+yL4JLdess5c1BS19m1S3c?=
 =?iso-8859-1?Q?LfZ+0gnCfIVOo4eSGEFU3D0by5Ayig+h52OldGmEaUgGG7f8Gt0IeZb3go?=
 =?iso-8859-1?Q?IubiEGWdqX2DyGMQnWbDnj/TFa17O2FDfJQ3f+iFPR1KDGdfwSzgmWirgS?=
 =?iso-8859-1?Q?2bUpxyjkEtgwEaKpujeINBOlM7uIG9i2EivVEC/Jjyul9UzZqBu6mvUcdX?=
 =?iso-8859-1?Q?XpSC6mF+EnM4d6tzu3QLk49+MOUlRJGaJq9pF1IDZfqWsl7KwC1EW9eAHm?=
 =?iso-8859-1?Q?TG3CbIdSOuV/2L6vaBGmBtPwG5N6i6AP6lUxdJmyCYX2ql+jAFGiV+YgqF?=
 =?iso-8859-1?Q?LtM4ZxnQz0gcDvwuqrS16+9E9Jtzw2QK1ZUgqZTWdxH0ll7juxGj5TcS+2?=
 =?iso-8859-1?Q?VFVo3ePMcSlaqd2Bxq3YoztwPm8vgkUu8UehfELLyh98teCqRryIThvsbo?=
 =?iso-8859-1?Q?MNEW83A0BADU2sgc5OMc8uNfhi2HT8zP/iUn3Rx0t0vhFir8n40tEnD6pV?=
 =?iso-8859-1?Q?2mFn986Oz6H0Wam/CizRAq+jWmdWVW6Nro34poNm+emftc7bxBaj//wVa5?=
 =?iso-8859-1?Q?c4L3fQyfiuk8ClSAAd0lzEIiy/H/m6Mqzbirwk5hM9ONE9V3fXed4uUqOk?=
 =?iso-8859-1?Q?w+lhJs+Ut1i6dREdu6PDP83FfaqL493TgkTdZOxBk9Rsp1ZhnZp91+pNg7?=
 =?iso-8859-1?Q?/cbTpOrX8vKC2jOZ0JZJx5LmR2+/hs9TkhmFDZlfCW/+BHTR2JKwByB8ds?=
 =?iso-8859-1?Q?Fz4cYTuwTZFc22Ht4heT0+UobzE46aGHsUikgpGS1e3QKk5UVLyfdhBVAr?=
 =?iso-8859-1?Q?UEcwjxFM769f/ZEa3cSY7IEe0OTanvuVcfsDL+zpLthCAbX2mwBjePc+Lr?=
 =?iso-8859-1?Q?g06bx6Rzz5S9Pqce5LciqNlXthd5BEHoDdqck2Y6KPBanKnZzYlLmMvtgr?=
 =?iso-8859-1?Q?ffXyEfGSNezT2q5sOychLF+v7xBF0zsj34SnjvWQwAMWJRuCI0xFgRsMeZ?=
 =?iso-8859-1?Q?lGqcUBjf4w=3D=3D?=
X-Exchange-RoutingPolicyChecked: cbcxS+a6UgCIZntjixQqV1dv9LOm8eMKImQvXH3bc75Yl0yrVnwa3Z2Le8uQLs4x8DGoZn8YNiNCO8+Ah9HgSWeByrA6k4oqmu45ItW9Fn6TdlYakfBpx4U02cN+DGcvputk/JsSkA5DNEq8ZsSfqdKTkde9rqx5tasRLV8fMxUie+aMNsgaOhN4jAVGhOpD7zr6ruEIn4ARIe44H6yDwr6cClhCIiQH/DzJ8OR39lEsgteDjLaKWs+oDd20tNHFuZLF3qTXQxy7IHzSBmYOv7xwuKXiWv4iUpxKDU5p3CbXLpWdrO2ISKkMWe/uPgor7ZIqawGdwcdJF/gmedUXKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb9e346-dba2-4274-9353-08ded252dd32
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 00:44:07.4760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuGETLbEd96mzALfm89Gxn/9W+1x1NU9OpUtiog/+LG4jcgp4tdyuNRNdsn4cjinPdZpqdEABHVqgDPBbD7RyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9EFFC957B
X-OriginatorOrg: intel.com
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

On Wed, Jun 24, 2026 at 01:13:30PM +0200, Christian König wrote:
> This use case is a bit more complicated since the irq worker is
> actually the one signaling the fence.
> 
> The patch should not indroduce any functional change, but the code can
> probably be cleaned up quite a bit after the full patch set lands.
> 

Most likely - this is pretty old code largely untouched from the
original Xe implementation - will look at this after this series lands.

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/xe/xe_hw_fence.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
> index 14720623ad00..a4e0278559b8 100644
> --- a/drivers/gpu/drm/xe/xe_hw_fence.c
> +++ b/drivers/gpu/drm/xe/xe_hw_fence.c
> @@ -16,6 +16,8 @@
>  
>  static struct kmem_cache *xe_hw_fence_slab;
>  
> +static struct xe_hw_fence *to_xe_hw_fence(struct dma_fence *fence);
> +
>  int __init xe_hw_fence_module_init(void)
>  {
>  	xe_hw_fence_slab = kmem_cache_create("xe_hw_fence",
> @@ -47,6 +49,16 @@ static void fence_free(struct rcu_head *rcu)
>  		kmem_cache_free(xe_hw_fence_slab, fence);
>  }
>  
> +static bool xe_hw_fence_signaled(struct dma_fence *dma_fence)

Maybe just forward declare this function to keep git blame intact?

Matt

> +{
> +	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
> +	struct xe_device *xe = fence->xe;
> +	u32 seqno = xe_map_rd(xe, &fence->seqno_map, 0, u32);
> +
> +	return dma_fence->error ||
> +		!__dma_fence_is_later(dma_fence, dma_fence->seqno, seqno);
> +}
> +
>  static void hw_fence_irq_run_cb(struct irq_work *work)
>  {
>  	struct xe_hw_fence_irq *irq = container_of(work, typeof(*irq), work);
> @@ -60,7 +72,9 @@ static void hw_fence_irq_run_cb(struct irq_work *work)
>  			struct dma_fence *dma_fence = &fence->dma;
>  
>  			trace_xe_hw_fence_try_signal(fence);
> -			if (dma_fence_is_signaled_locked(dma_fence)) {
> +			if (dma_fence_test_signaled_flag(dma_fence) ||
> +			    xe_hw_fence_signaled(dma_fence)) {
> +				dma_fence_signal_locked(dma_fence);
>  				trace_xe_hw_fence_signal(fence);
>  				list_del_init(&fence->irq_link);
>  				dma_fence_put(dma_fence);
> @@ -120,8 +134,6 @@ void xe_hw_fence_ctx_finish(struct xe_hw_fence_ctx *ctx)
>  {
>  }
>  
> -static struct xe_hw_fence *to_xe_hw_fence(struct dma_fence *fence);
> -
>  static struct xe_hw_fence_irq *xe_hw_fence_irq(struct xe_hw_fence *fence)
>  {
>  	return container_of(fence->dma.extern_lock, struct xe_hw_fence_irq,
> @@ -142,16 +154,6 @@ static const char *xe_hw_fence_get_timeline_name(struct dma_fence *dma_fence)
>  	return fence->name;
>  }
>  
> -static bool xe_hw_fence_signaled(struct dma_fence *dma_fence)
> -{
> -	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
> -	struct xe_device *xe = fence->xe;
> -	u32 seqno = xe_map_rd(xe, &fence->seqno_map, 0, u32);
> -
> -	return dma_fence->error ||
> -		!__dma_fence_is_later(dma_fence, dma_fence->seqno, seqno);
> -}
> -
>  static bool xe_hw_fence_enable_signaling(struct dma_fence *dma_fence)
>  {
>  	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
> -- 
> 2.43.0
> 
