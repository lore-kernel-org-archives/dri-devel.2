Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6125AF8A171
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84E910E1CF;
	Thu, 16 Apr 2026 12:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="YWvqLByp";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0542210E1CF
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1776344116;
 bh=wyXlV1QjTrvOnV0yjeB7w668Ayoqi+Gfb6YUV6x3bks=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YWvqLBypVemQeFv2zuoplMs3aJkJC8/L9F6Pxgz9B+5FY7P42+CDHbkoE2G1BUXX4
 IskW3lcUJI6zjC/GkphqXrFVQtSDngusEeWGy9obPT6of3tPcQCM9TtM9SXrns02Tj
 +e12pfn9OBPsMfxUPpa7dCXghZ3ZkZaZGTg86/SWxqyf9g3MhI9e7aksTyllW3uF7p
 74RonGvy8iCN9t058OTUvX8ywynGI+fhUPRQoEEmR9LTNmIAeJOROf6UgBNP97WjGk
 2r6hwTfsdJPiyrnqJyJ6NMJpPeYbreSmcvGLVeqnyVdwwrXjGdHs54RQPMwNuzGhz3
 JJVK24NcVXBtQ==
Message-ID: <ffeba98b-575d-4e64-a1b9-ea41dd325658@lankhorst.se>
Date: Thu, 16 Apr 2026 14:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup/dmem: allow max to be set below current usage
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20260326-dmem_max_ebusy-v3-1-8e62c06e2767@igalia.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260326-dmem_max_ebusy-v3-1-8e62c06e2767@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Getm

Den 2026-03-26 kl. 16:18, skrev Thadeu Lima de Souza Cascardo:
> page_counter_set_max may return -EBUSY in case the current usage is above
> the new max. When writing to dmem.max, this error is ignored and the new
> max is not set.
> 
> Instead of using page_counter_set_max when writing to dmem.max, atomically
> update its value irrespective of the current usage.
> 
> Since there is no current mechanism to evict a given dmemcg pool, this will
> at least prevent the current usage from growing any further.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> When writing to dmem.max, it was noticed that some writes did not take
> effect, even though the write was successful.
> 
> It turns out that page_counter_set_max checks if the new max value is above
> the current usage and returns -EBUSY in case it is, which was being ignored
> by dmemcg_limit_write.
> 
> It was also noticed that when setting limits for multiple regions in a
> single write, while setting one region's limit may fail, others might have
> succeeded before. Tejun Heo brought up that this breaks atomicity.
> 
> Maarten Lankhorst and Michal Koutný have brought up that instead of
> failing, setting max below the current usage should behave like memcg and
> start eviction until usage goes below the new max.
> 
> However, since there is no current mechanism to evict a given region, they
> suggest that setting the new max will at least prevent further allocations.
> 
> v1 kept the multiple region support when writing to limit files, while
> returning -EBUSY as soon as setting a region's max was above the usage.
> 
> v2 only allows setting a single region limit per write, while allowing any
> new max to be set.
> 
> This version (v3) still allows multiple regions to be set, and explains why
> page_counter_set_max is not used anymore.
> 
> I am sending this version dropping the multiple region restriction for now,
> as we continue to discuss whether it should be supported or not.
> ---
> Changes in v3:
> - Dropped first patch as it was already applied.
> - Added comment explaining why page_counter_set_max is not used.
> - Dropped patch restricting multiple regions to be set for now.
> - Link to v2: https://lore.kernel.org/r/20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com
> 
> Changes in v2:
> - Remove support for setting multiple regions' limits.
> - Allow any new max limit to be set.
> - Link to v1: https://lore.kernel.org/r/20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com
> ---
>  kernel/cgroup/dmem.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 1ab1fb47f2711ecc60dd13e611a8a4920b48f3e9..c00aa06759967a8f8977aaf036dd7966ddb55718 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -159,7 +159,15 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
>  static void
>  set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
>  {
> -	page_counter_set_max(&pool->cnt, val);
> +	/*
> +	 * page_counter_set_max will return -EBUSY in case the current
> +	 * usage is above the new max.
> +	 *
> +	 * Since, there is no current eviction mechanism yet, setting max
> +	 * irrespective of the current usage will prevent further
> +	 * allocations.
> +	 */
> +	xchg(&pool->cnt.max, val);
>  }
>  
>  static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)

I haven't seen a reply yet, so do you want me to commit this now to drm-misc-next?

Kind regards,
~Maarten Lankhorst
