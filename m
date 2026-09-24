Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7ADC98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5094910F641;
	Thu, 24 Sep 2026 15:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VbYrzxuS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d7PHVV4s";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1CE10F641
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:08:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4rwQ803909
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m6uvMXrWYMbfA6d98gbVQNc+gFGbtIP3RdcI1buo8eY=; b=VbYrzxuSMgNMrHSI
 WAeO8y2dyFs249KDV0lyEir7DstiIyRpH75gTMvFNvYyw51ZSEfTz0CmsuH2u9Uy
 h1vveTPzeSgVcIWjOTOQNKHrbVrVPr6Kl1egknwrp7IJ02NoCR6UmcMAHjvv40fX
 j+j0C2hyA5OtHY0fkO+V1j+XoNAwHP/kJjWsmtrv2sWn6o6oYvQrfNz/Mhk6mXdS
 4ENpeGDQ9aENWF83NfewA/5Eter6P+5makhAmheYUOcz3decyFAOlhkP1eRUKoD5
 OgtJ9s55IcaVSPcrfuKDzcmi3sXVV1gnDMgG2MUxkYCYTjiNVFcMIev+USufwBp+
 JrN8TQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1sc97s9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:08:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39e3c10ac70so3329894a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790262523; x=1790867323;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m6uvMXrWYMbfA6d98gbVQNc+gFGbtIP3RdcI1buo8eY=;
 b=d7PHVV4sND3nSk2QSoXvyMdhznF7nrRQMlqwFfgxBN/pl9jwh1rCiYR7ekU6TiR8DD
 v2ri5bl4Y2hDu02muZO2gse3TAEPQtyuttZ1mzEYKAwmiktls4M+KaQpG9aqLq0YzF5i
 EML0KMJxQ4yu0dQDls9Nqwas3mUC7FZ37Qhj8LWRiB0u3oCyyUENxgISQeBhapFkFh7G
 yLp2b628YAfyPruGYvN1bB+lXPqwFGD02DFgPd4vIUcYLZ2S6PDTvGqpLwPYOxqoCEM1
 U81GkdyhWAqbbn7XOClDPDSfZHBvyxbH+nKltnDtfQpWizFtbsg7WRH/l7vYJJHkRMrt
 xI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790262523; x=1790867323;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m6uvMXrWYMbfA6d98gbVQNc+gFGbtIP3RdcI1buo8eY=;
 b=H5mu2Wotwwsa0/6TXncAl0ZvKddXhTtj6VR8v/Y0ZlbekTCG6SPczPX23d4SvP1SqL
 TUCsXI2ELGfrxk4mFyv3NCVD/n1GcKgtpP0lFuR9ru4pyjaa77o4JKQTKiV97RedMhLJ
 Ghp3y4D0n1Og6Ws4fVJ6cXS03bSb4mtnjRqniF+XKknUqNOMHILQ6/KJBXCKGzH2L9/K
 3v/KwPvwEj3Vq7B0PD7n2XbBnaYCnaj1V26oK6012tu0W7Wg+bv2qNzoxHMexY+uXYtL
 omAZCL27YxhyiYfy4nALHM4pO77pWrhFg6BhKW+UwNuHrgBMC/8UPhkrUv6dFbM2WnbA
 0tlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaBIM8CV2ghtIUc7OQZXgRLRrrLyjZ8i/dsVfo7vxrOdbCFTAvaFRJ3mBm4wkPRcNOkmwNEeodIhI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nR1+/WXmqoY6GIlqjCGrgiFZS97HcccieXQLxvzEbvgzIrvpFG
 qUIWRdKxKPHhkrvpr9ELRP8+gN2ZwqX7Y4Q0/7you28+oJkqBwqbYpWQSmL9xHYx2R0Gvkf5InY
 qyskcFpaDeOp3BXbCVkwSSwyr9DecdTxAam5Mz3kmyqt2w8bmNuzZRW0kicHzuAczkQdQQ/Q=
X-Gm-Gg: AYBFou1gkwWyRA5kv4paTv19oIBgmDl+pVmls2X4YNWdUaJuU+6jNXTq0WvB4IJ4xmK
 j5p8HrPMgmzlDZrgkNe7rU8+bCpX1COCLU73FF/Z5wtkzLLHEdIo6cStnnrpHSZe5TNPfymnzoQ
 Brwrp04GV3PkIEt395ORygReXc/b8vdN/X89nl2+2OcLRUN19qus4v+thTqmIllYnODaBYwZ4P6
 O/AZHarTjPvsd9obo1yfUjGTBzUqVeIzvk8h19/E5W0inVznku0ZOSnRWZCxrkfh+DEAjujPTsp
 xx4l5foJV5P/atMcwQxV+HD035t6UKnaffowCYEVpbwSlxHvYBnXqvyyqftOg+b1Z+n1PPtmRlA
 hN65du4JdPKT9oguh59eiFVgioY0C
X-Received: by 2002:a17:90b:4fca:b0:3a0:910e:84aa with SMTP id
 98e67ed59e1d1-3a098d45437mr2341935a91.12.1790262517618; 
 Thu, 24 Sep 2026 08:08:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4fca:b0:3a0:910e:84aa with SMTP id
 98e67ed59e1d1-3a098d45437mr2341497a91.12.1790262512327; 
 Thu, 24 Sep 2026 08:08:32 -0700 (PDT)
Received: from [192.168.1.5] ([122.177.242.55])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0812c87e9sm4090441a91.3.2026.09.24.08.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 08:08:31 -0700 (PDT)
Message-ID: <b8234908-56da-45e9-9e80-0e28f770646e@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 20:38:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] ttm/pool: enable memcg tracking and shrinker. (v3)
Content-Language: en-US
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 tj@kernel.org, christian.koenig@amd.com, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, mkoutny@suse.com,
 david@fromorbit.com, qi.zheng@linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Waiman Long <longman@redhat.com>, simona@ffwll.ch,
 intel-xe@lists.freedesktop.org, akhilpo@oss.qualcomm.com,
 robin.clark@oss.qualcomm.com, prahladk@google.com, olv@google.com,
 Pranjal Shrivastava <praan@google.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-6-airlied@gmail.com>
From: Pranjal Arya <pranjal.arya@oss.qualcomm.com>
In-Reply-To: <20260706052330.1110909-6-airlied@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZNP7_8wNv6XAddMXpMjAAWGHtdPJhxQs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfXyW7fl6JyZKJV
 +Voq4oGCjanep9336hnBQWB69mmqMOHy/F2FKJKBeBLd4Mnvp4PqmE1a+367Jwe8icdtWZ+gHB9
 mS6p2PxFdNSBfWuWl7SFfSJb8Ig9vXnfeMjYnOeK4bWbh+z5yUOZbGhlexFO83lT7KlZmeLDdda
 FemQs5Alp1SZQfdVvJWqGZF7YK5iAxgnt3fUjGdpp3O2OwWZQeKSrVns2q19WdTUH4V9oyScogR
 jGo59jUfvZvS3Xwx4qOMDsXdFbaOm+In/dzMbH9Fcd3Npr2g05oSZgwAExbQA6mJ98LKK/TqnCk
 6AZJr2OAiEJSjysMdSagnu4vtGdYTgOo4rzHNVTtV6cDb3njP/jv4tlsWIuslN+MYg/Bv3EmH75
 3A0hj8LegrMyiU1b1r0biYBxpPiH1Lbm3J7CHA2H31nY9Q2o4ZOahEYgnzIx+k0ckf3npE66vjJ
 engxSqXXA5YHUcd/J1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfX0iQWN9GeKojs
 5eZhdSTRR3fujbCmEOzxf+qPQT2G5bpc5TiQcChwNAwqB4dhB178r8SUXbq14hug4u1VCjFIOsL
 RB9lng3Ay7zDpdIpfh3lLNzmzsE7Yns=
X-Proofpoint-ORIG-GUID: ZNP7_8wNv6XAddMXpMjAAWGHtdPJhxQs
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab53cfb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=vns1kw985HQoUlfYC5jDDw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=sNYUgXJB5znyIbqxCBwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240062
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



On 7/6/2026 10:52 AM, Dave Airlie wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> This enables all the backend code to use the list lru in memcg mode,
> and set the shrinker to be memcg aware.
> 
> It adds the loop case for when pooled pages end up being reparented
> to a higher memcg group, that newer memcg can search for them there
> and take them back.
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> 
> ---
> v2: just use the proper stats.
> v3: fix objcg check to return void
> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 124 +++++++++++++++++++++++++++------
>  mm/list_lru.c                  |   1 +
>  2 files changed, 102 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index f12b68812081..01b6ff2d8144 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -144,7 +144,9 @@ static int ttm_pool_nid(struct ttm_pool *pool)
>  }
>  
>  /* Allocate pages of size 1 << order with the given gfp_flags */
> -static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> +static struct page *ttm_pool_alloc_page(struct ttm_pool *pool,
> +					struct obj_cgroup *objcg,
> +					gfp_t gfp_flags,
>  					unsigned int order)
>  {
>  	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> @@ -172,7 +174,10 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>  		p = alloc_pages_node(pool->nid, gfp_flags, order);
>  		if (p) {
>  			p->private = order;
> -			mod_lruvec_page_state(p, NR_GPU_ACTIVE, 1 << order);
> +			if (!mem_cgroup_charge_gpu_page(objcg, p, order, gfp_flags, false)) {
> +				__free_pages(p, order);
> +				return NULL;
> +			}
>  		}
>  		return p;
>  	}
> @@ -209,8 +214,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>  static void __free_pages_gpu_account(struct page *p, unsigned int order,
>  				     bool reclaim)
>  {
> -	mod_lruvec_page_state(p, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE,
> -			      -(1 << order));
> +	mem_cgroup_uncharge_gpu_page(p, order, reclaim);
>  	__free_pages(p, order);
>  }
>  
> @@ -317,12 +321,11 @@ static void ttm_pool_type_give(struct ttm_pool_type *pt, struct page *p)
>  
>  	INIT_LIST_HEAD(&p->lru);
>  	rcu_read_lock();
> -	list_lru_add(&pt->pages, &p->lru, nid, NULL);
> +	list_lru_add(&pt->pages, &p->lru, nid, page_memcg_check(p));
>  	rcu_read_unlock();
>  
>  	atomic_long_add(num_pages, &allocated_pages[nid]);
> -	mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
> -	mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
> +	mem_cgroup_move_gpu_page_reclaim(NULL, p, pt->order, true);
>  }
>  
>  static enum lru_status take_one_from_lru(struct list_head *item,
> @@ -337,20 +340,56 @@ static enum lru_status take_one_from_lru(struct list_head *item,
>  	return LRU_REMOVED;
>  }
>  
> -/* Take pages from a specific pool_type, return NULL when nothing available */
> -static struct page *ttm_pool_type_take(struct ttm_pool_type *pt, int nid)
> +static int pool_lru_get_page(struct ttm_pool_type *pt, int nid,
> +			     struct page **page_out,
> +			     struct obj_cgroup *objcg,
> +			     struct mem_cgroup *memcg)
>  {
>  	int ret;
>  	struct page *p = NULL;
>  	unsigned long nr_to_walk = 1;
> +	unsigned int num_pages = 1 << pt->order;
>  
> -	ret = list_lru_walk_node(&pt->pages, nid, take_one_from_lru, (void *)&p, &nr_to_walk);
> +	ret = list_lru_walk_one(&pt->pages, nid, memcg, take_one_from_lru, (void *)&p, &nr_to_walk);
>  	if (ret == 1 && p) {
> -		atomic_long_sub(1 << pt->order, &allocated_pages[nid]);
> -		mod_lruvec_page_state(p, NR_GPU_ACTIVE, (1 << pt->order));
> -		mod_lruvec_page_state(p, NR_GPU_RECLAIM, -(1 << pt->order));
> +		atomic_long_sub(num_pages, &allocated_pages[nid]);
> +
> +		if (!mem_cgroup_move_gpu_page_reclaim(objcg, p, pt->order, false)) {
> +			__free_pages(p, pt->order);
> +			p = NULL;
> +		}
>  	}
> -	return p;
> +	*page_out = p;
> +	return ret;
> +}
> +
> +/* Take pages from a specific pool_type, return NULL when nothing available */
> +static struct page *ttm_pool_type_take(struct ttm_pool_type *pt, int nid,
> +				       struct obj_cgroup *orig_objcg)
> +{
> +	struct page *page_out = NULL;
> +	int ret;
> +	struct mem_cgroup *orig_memcg = orig_objcg ? get_mem_cgroup_from_objcg(orig_objcg) : NULL;
> +	struct mem_cgroup *memcg = orig_memcg;
> +
> +	/*
> +	 * Attempt to get a page from the current memcg, but if it hasn't got any in it's level,
> +	 * go up to the parent and check there. This helps the scenario where multiple apps get
> +	 * started into their own cgroup from a common parent and want to reuse the pools.
> +	 */
> +	while (!page_out) {
> +		ret = pool_lru_get_page(pt, nid, &page_out, orig_objcg, memcg);
> +		if (ret == 1)
> +			break;
> +		if (!memcg)
> +			break;
> +		memcg = parent_mem_cgroup(memcg);
> +		if (!memcg)
> +			break;
> +	}
> +
> +	mem_cgroup_put(orig_memcg);
> +	return page_out;
>  }
>  
>  /* Initialize and add a pool type to the global shrinker list */
> @@ -360,7 +399,7 @@ static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
>  	pt->pool = pool;
>  	pt->caching = caching;
>  	pt->order = order;
> -	list_lru_init(&pt->pages);
> +	list_lru_init_memcg(&pt->pages, mm_shrinker);
>  
>  	spin_lock(&shrinker_lock);
>  	list_add_tail(&pt->shrinker_list, &shrinker_list);
> @@ -403,6 +442,31 @@ static void ttm_pool_type_fini(struct ttm_pool_type *pt)
>  	ttm_pool_dispose_list(pt, &dispose);
>  }
>  
> +/*
> + * This function doesn't currently check dma32, because no driver using this
> + * support dma32. This should be added and debugged when that changes.
> + */
> +static void ttm_pool_check_objcg(struct obj_cgroup *objcg)
> +{
> +#ifdef CONFIG_MEMCG
> +	int r = 0;
> +	struct mem_cgroup *memcg;
> +	if (!objcg)
> +		return;
> +
> +	memcg = get_mem_cgroup_from_objcg(objcg);
> +	for (unsigned i = 0; i < NR_PAGE_ORDERS; i++) {
> +		r = memcg_list_lru_alloc(memcg, &global_write_combined[i].pages, GFP_KERNEL);
> +		if (r)
> +			break;
> +		r = memcg_list_lru_alloc(memcg, &global_uncached[i].pages, GFP_KERNEL);
> +		if (r)
> +			break;
> +	}
> +	mem_cgroup_put(memcg);
> +#endif
> +}
> +
>  /* Return the pool_type to use for the given caching and order */
>  static struct ttm_pool_type *ttm_pool_select_type(struct ttm_pool *pool,
>  						  enum ttm_caching caching,
> @@ -432,7 +496,9 @@ static struct ttm_pool_type *ttm_pool_select_type(struct ttm_pool *pool,
>  }
>  
>  /* Free pages using the per-node shrinker list */
> -static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
> +static unsigned int ttm_pool_shrink(int nid,
> +				    struct mem_cgroup *memcg,
> +				    unsigned long num_to_free)
>  {
>  	LIST_HEAD(dispose);
>  	struct ttm_pool_type *pt;
> @@ -448,7 +514,11 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
>  	if (!pt)
>  		return 0;
>  
> -	num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
> +	if (!memcg) {
> +		num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
> +	} else {
> +		num_pages = list_lru_walk_one(&pt->pages, nid, memcg, pool_move_to_dispose_list, &dispose, &num_to_free);
> +	}
>  	num_pages *= 1 << pt->order;
>  
>  	ttm_pool_dispose_list(pt, &dispose);
> @@ -777,6 +847,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  	bool allow_pools;
>  	struct page *p;
>  	int r;
> +	struct obj_cgroup *objcg = memcg_account ? tt->objcg : NULL;
>  
>  	WARN_ON(!alloc->remaining_pages || ttm_tt_is_populated(tt));
>  	WARN_ON(alloc->dma_addr && !pool->dev);
> @@ -794,6 +865,9 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  
>  	page_caching = tt->caching;
>  	allow_pools = true;
> +
> +	ttm_pool_check_objcg(objcg);
> +
>  	for (order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
>  	     alloc->remaining_pages;
>  	     order = ttm_pool_alloc_find_order(order, alloc)) {
> @@ -803,7 +877,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  		p = NULL;
>  		pt = ttm_pool_select_type(pool, page_caching, order);
>  		if (pt && allow_pools)
> -			p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
> +			p = ttm_pool_type_take(pt, ttm_pool_nid(pool), objcg);
>  
>  		/*
>  		 * If that fails or previously failed, allocate from system.
> @@ -814,7 +888,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  		if (!p) {
>  			page_caching = ttm_cached;
>  			allow_pools = false;
> -			p = ttm_pool_alloc_page(pool, gfp_flags, order);
> +			p = ttm_pool_alloc_page(pool, objcg, gfp_flags, order);
>  		}
>  		/* If that fails, lower the order if possible and retry. */
>  		if (!p) {
> @@ -960,7 +1034,7 @@ void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt)
>  
>  	while (atomic_long_read(&allocated_pages[nid]) > pool_node_limit[nid]) {
>  		unsigned long diff = atomic_long_read(&allocated_pages[nid]) - pool_node_limit[nid];
> -		ttm_pool_shrink(nid, diff);
> +		ttm_pool_shrink(nid, NULL, diff);
>  	}
>  }
>  EXPORT_SYMBOL(ttm_pool_free);
> @@ -1214,10 +1288,14 @@ static unsigned long ttm_pool_shrinker_scan(struct shrinker *shrink,
>  					    struct shrink_control *sc)
>  {
>  	unsigned long num_freed = 0;
> +	int num_pools;
> +	spin_lock(&shrinker_lock);
> +	num_pools = list_count_nodes(&shrinker_list);
> +	spin_unlock(&shrinker_lock);
>  
>  	do
> -		num_freed += ttm_pool_shrink(sc->nid, sc->nr_to_scan);
> -	while (num_freed < sc->nr_to_scan &&
> +		num_freed += ttm_pool_shrink(sc->nid, sc->memcg, sc->nr_to_scan);
> +	while (num_pools-- >= 0 && num_freed < sc->nr_to_scan &&
>  	       atomic_long_read(&allocated_pages[sc->nid]));
>  
>  	sc->nr_scanned = num_freed;
> @@ -1406,7 +1484,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  	spin_lock_init(&shrinker_lock);
>  	INIT_LIST_HEAD(&shrinker_list);
>  
> -	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
> +	mm_shrinker = shrinker_alloc(SHRINKER_MEMCG_AWARE | SHRINKER_NUMA_AWARE, "drm-ttm_pool");
>  	if (!mm_shrinker)
>  		return -ENOMEM;
>  
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 36662d02ff96..2ccc3317cff9 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -627,6 +627,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
>  		return 0;
>  	return __memcg_list_lru_alloc(memcg, lru, gfp);
>  }
> +EXPORT_SYMBOL_GPL(memcg_list_lru_alloc);
>  
>  int folio_memcg_list_lru_alloc(struct folio *folio, struct list_lru *lru,
>  			       gfp_t gfp)

Hi Dave, all,

Thanks for the series. The user facing memcg counters, the objcg
plumbing and the memcg aware charging at BO create and destroy look
correct to me. While going through the series, I got curious about
one specific choice made for keeping pool pages charged to their
giving cgroup and partitioning the pool's list_lru per nid and memcg
as a consequence.

The layering concern:
The kernel's memory hierarchy has a consistent convention: the
lower layers of the allocator stack are memcg agnostic shared
infrastructure, and memcg accounting sits above them tracking who
currently owns live memory. For example:
- The buddy allocator has no per cgroup partitioning of freelists.
Cgroups don't have different views of buddy serveing everyone
identically.
- The slab layer's freelists are memcg agnostic. The freed object
sits uncharged in the slab cache and the next kmalloc + __GFP_ACCOUNT
from any cgroup gets charges at that boundary.

The TTM pool is logically another layer of the same kind of shared
reuse infrastructure. It exists specifically to amortize the cost
of memory allocations, the same way slab exists to amortize
object shape init across kmalloc and kfree. kmem_cache is
analogous to ttm_pool_type, each having its own freelist. By the
layering convention, the pool should be memcg agnostic in storage
where any cgroup can put a page in, any cgroup can take a page out,
and charging happens at the boundary where the page becomes a
live BO owned by a cgroup.

Patch 05 diverges from this: mem_cgroup_move_gpu_page_reclaim(NULL,
p, pt->order, true) in ttm_pool_type_give keeps pool pages charged
as NR_GPU_RECLAIM to the giving cgroup, and list_lru_init_memcg
partitions the list_lru per nid and memcg. That's the same shape as
partitioning buddy's freelists or slab's per CPU caches per cgroup,
which we wouldn't do.

Consequences of the divergence:
The consequences that follow from this specific choice and that
wouldn't apply if the pool followed the buddy/slab convention:
1. Pool storage is now partitioned M ways for M memcgs.
2. ttm_pool_type_take needs a parent walk (while loop climbing
parent_mem_cgroup) to enable any cross cgroup reuse instead of serving
from common pool which opposite to the intention of having
global resource.
3. Long lived sibling cgroups can't share cached pool pages
because their common ancestor holds no pages of its own, so the
parent walk terminates empty. For example, A memcg can hold 500 MB
of cached pool pages for a week while idle. B ramps up beside it, walks
up looking for cached pages, finds every ancestor's sublist empty, and ends
up paying cost for every page it needs, even though physically identical
pages are available in common pool.
4. MM driven reclaim invokes the shrinker M memcg x N numa nodes
times via shrink_slab_memcg's per memcg bitmap walk.
5. ttm_pool_shrink has two branches: memcg=NULL uses
list_lru_walk_node (one call, all sublists). A specific memcg
uses list_lru_walk_one (one sublist per call). TTM's own
pool cap enforcement in ttm_pool_free takes the flat branch
whereas ttm_pool_shrinker_scan always passes sc->memcg and takes
the per-cgroup branch (M x N calls per reclaim cycle). If pool pages
followed the buddyslab convention, the shrinker wouldn't need to be
memcg aware and both callers would use the flat walk.

Questions:
1. What's the motivation for keeping pool pages charged rather
than following the buddy and slab convention? If it's guarding
against a cgroup launders BOs through the pool to stay under
memory.max pattern, note that try_charge_memcg fires on every
take ( from pool or buddy ) under either accounting model, so a
cgroup cannot exceed memory.max by cycling through the pool
in the first place. The pool_node_limit merely caps the total
system wide pool memory to prevent absolute pool growth. If it's
memory.current stability, that's not preserved for slab either.
kfree drops the originating memcg's memory.current immediately.
2. If keeping the pool charged is the right choice, is the plan
to accept the layering deviation and document it, or is there
a longer term direction where the pool moves back to
memcg agnostic storage?

I do not intend to block it. The patch does what it says
and I'm keen to see GPU memcg accounting land. Just want
the rationale for architectural choice in case I have missed
something or if design needs reconsideration.

Thanks,
Pranjal Arya
Qualcomm


