Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5878C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BB110E42D;
	Wed,  1 Jul 2026 14:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hEXwOwDz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D8E510E3BC;
 Wed,  1 Jul 2026 14:13:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CC1841A79;
 Wed,  1 Jul 2026 14:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6924F1F000E9;
 Wed,  1 Jul 2026 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782915191;
 bh=RfU7bZHw588z2tR//rNfbsQEpkucqzOcm8xzNYEhTQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hEXwOwDzt6MuZoLzrdB/v9H/UPJKnYMciWL4Gu/xPMgRXJmRuxx3+BCQS01nXn9Yx
 iTEC8gZU7DPOux4ZCq4pzSOo9FsgJ3gN2ptFiRMMRrc8QiD5tfSiKrtlijsJzzblx5
 dbNmYSzj0lwH+2NgzNmnF7Yi5FEOMHC42dF+a2bDm6iG0dTlAsEMOdkJjR3ghgKQbr
 ZqEMf/bnn7hshNKglnWx7HGQdnjZpzn7ioQt/6//viCffyEQsWy8SlXQg8c9DQ2IO1
 jFsc5rQ9E0+Hl6JaEXfXnutlcoEgV5W4z5PAyIULZ+lrq17iTuChF/LzeScSIEwPu7
 rTZ929i1AXumA==
Date: Wed, 1 Jul 2026 16:13:04 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>, 
 Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, Martin Hodo <martin.hodo@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Fix NULL deref on sched_engine alloc failure
Message-ID: <akUcJk-H3BiTVP0L@zenone.zhora.eu>
References: <20260701114513.221254-1-joonas.lahtinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701114513.221254-1-joonas.lahtinen@linux.intel.com>
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

Hi Joonas,

On Wed, Jul 01, 2026 at 02:45:13PM +0300, Joonas Lahtinen wrote:
> Avoid using intel_context_put() before intel_context_init() in
> execlists_create_virtual() as the kref_put() inside would lead
> to NULL deref on the IOCTL path when sched_engine allocation fails.
> 
> Discovered using AI-assisted static analysis confirmed by
> Intel Product Security.
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: 3e28d37146db ("drm/i915: Move priolist to new i915_sched_engine object")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

looks correct!

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
