Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD20FFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3292C10EB04;
	Tue, 28 Apr 2026 10:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hnEnyNVY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3199310EB10;
 Tue, 28 Apr 2026 10:07:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D245A407C4;
 Tue, 28 Apr 2026 10:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DE4C2BCAF;
 Tue, 28 Apr 2026 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777370831;
 bh=aBxKILg4xl7pe+Xf6KtRk2a8koU7zSMarOGT9Dk7dGE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hnEnyNVYoOAExiKeJGwNkpqYaVpVZxV/kakThVTG0je9EtEKm6raDPHkT/31tuXHC
 GkwS2pNyuQmFnwvCMqkqNo5z8OjwSCrLxj6XCPwrApVpvUbW91O+lN6GVu/AGPW1wA
 V2LA++WhFCGkii4YRnWlRr4roKD6jfEQavcqTAIZDM0Kw+omtIeuf71q/JX3gG0o82
 bPrzasTGLFpwra3HK3iDShGF1dxQUK2I3J7hFDcV2OjWdHIGwC0LuSxWceNffK9vWj
 ZUJxkSOpeMoJgp1Wf0QecV2DVHMIxO0K7Z4uvN88sMF84p8Y+nUvSkTqAiXrJLqLjC
 oizMhaWw2ZWJQ==
Date: Tue, 28 Apr 2026 12:07:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Colascione <dancol@dancol.org>
Subject: Re: [PATCH v2 3/5] drm/ttm: Introduce ttm_bo_shrink_kswap_fragmented()
Message-ID: <afCGat6ADLrHYEIn@zenone.zhora.eu>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-4-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423055656.1696379-4-matthew.brost@intel.com>
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

Hi Matt,

...

> +/**
> + * ttm_bo_shrink_kswap_fragmented() - Whether in kswap and memory appears
> + * fragmented
> + * @nid: current node being shrunk
> + *
> + * Return: true if in kswap and memory appears fragmented, false is not.
> + */
> +bool ttm_bo_shrink_kswap_fragmented(int nid)

This name is a bit to strong and misleading, in my opinion.

> +{
> +	enum zone_type zone_type;
> +
> +	if (!current_is_kswapd())
> +		return false;
> +
> +	if (!numa_valid_node(nid))
> +		return false;
> +
> +#if IS_ENABLED(CONFIG_ZONE_DMA32)
> +	zone_type = ZONE_DMA32;
> +#else
> +	zone_type = ZONE_NORMAL;
> +#endif
> +
> +	for (; zone_type <= ZONE_NORMAL; ++zone_type) {

just start with "for (zone_type = 0; ... )" and you don't need
the ifdefs above.

Andi

> +		struct zone *zone = &NODE_DATA(nid)->node_zones[zone_type];
