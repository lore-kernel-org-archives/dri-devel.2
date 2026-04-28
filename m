Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302F6FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732FB10EAC6;
	Tue, 28 Apr 2026 09:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RT5cRL60";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F2910EAC6;
 Tue, 28 Apr 2026 09:55:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CF1F43E2C;
 Tue, 28 Apr 2026 09:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F56C2BCAF;
 Tue, 28 Apr 2026 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777370116;
 bh=lY/rML6uz9ZIxs4GZnCj1Fq5sJipTf0WSkf6XsU+5fQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RT5cRL60PRur02Ka7Bt2xPa173aOEsxKJHzEsAiNqLrmc1L5JfzjJEeSh0Mby5UHu
 AzD+yW3MnM2lyhaFyLtxmnKyELftaxVn+DO+yVHeJhQclTHJ+lr1TjLae2xsMlZURE
 WohT37zr6awZujlqOw8imG40dKFKE22c6lPAESQIKH2IsXc07MoMG9gdOwgx5lRwrr
 pQNrOXELlyhnUsMNhwAyF6xkxwlqIufvRmsMjUFCyxrlkbixLV+23o0LECPKaX8FlG
 qo78jBZfYukijVqKqI5RmdvX6RZi4mwgvretNOTakXN2MmXmHhPIZCNszrsusyR0dM
 NaUd9ZeokEpIw==
Date: Tue, 28 Apr 2026 11:55:12 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Colascione <dancol@dancol.org>
Subject: Re: [PATCH v2 2/5] drm/ttm: Issue direct reclaim at beneficial_order
Message-ID: <afCD6OPH_Q7qe_tx@zenone.zhora.eu>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-3-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423055656.1696379-3-matthew.brost@intel.com>
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

On Wed, Apr 22, 2026 at 10:56:53PM -0700, Matthew Brost wrote:
> Triggering kswap at an order higher than beneficial_order makes little
> sense, as the driver has already indicated the optimal order at which
> reclaim is effective. Similarly, issuing direct reclaim or triggering
> kswap at a lower order than beneficial_order is ineffective, since the
> driver does not benefit from reclaiming lower-order pages.
> 
> As a result, direct reclaim should only be issued with __GFP_NORETRY at
> exactly beneficial_order, or as a fallback, direct reclaim without
> __GFP_NORETRY at order 0 when failure is not an option.
> 
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> CC: dri-devel@lists.freedesktop.org
> Cc: Daniel Colascione <dancol@dancol.org>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Christian Koenig <christian.koenig@amd.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
