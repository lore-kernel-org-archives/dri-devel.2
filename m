Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C926C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4FF10E3BA;
	Wed,  1 Jul 2026 15:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZFHTizPR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA4310E3AC;
 Wed,  1 Jul 2026 15:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE43E6001D;
 Wed,  1 Jul 2026 15:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5081F000E9;
 Wed,  1 Jul 2026 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782918239;
 bh=zk1agxCFt6nBM0rrZXtqvdO2lHxzgZTETSU2JH6M4JQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZFHTizPRHQweZY4aMchzZQHYcXubYszoHd/c8wNEcJTbsm7FIqbir23niTe0zpqde
 UTc4ZRMUFiJQHzVSjL5NFdUDZK+xgg0KyKZ9umuLXaqDKFTQjklRJ/qPHHyLS0YpQm
 szo68Jd4qddjgjPli5zXcNiCaRODPrSuPKTgTuj1JaeVe1hvc1fvuOcmlumbT+YQan
 kXhvhO76xsEefJYJKtw04NVI+d3MsLOd+25b4N8bkgf3eZvnzc/983oX4NaLc4+ZZ8
 jaFVSRa2hIT5JYk9V4rGbub5PVk+GYdlx9pi1AgU7RS6yRljC60pVx3O/JKUoxagwW
 TJjmW3k/tKXXw==
Date: Wed, 1 Jul 2026 17:03:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>, 
 Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, Martin Hodo <martin.hodo@intel.com>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
Message-ID: <akUqglq2Do3FF1GH@zenone.zhora.eu>
References: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
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

On Wed, Jul 01, 2026 at 10:55:55AM +0300, Joonas Lahtinen wrote:
> Setting context engine slot N into I915_ENGINE_CLASS_INVALID /
> I915_ENGINE_CLASS_INVALID_NONE and attempting to apply
> I915_CONTEXT_PARAM_SSEU to the same slot N will deref NULL.
> Fix that.
> 
> Discovered using AI-assisted static analysis confirmed by
> Intel Product Security.
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
