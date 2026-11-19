Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B11606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1JaDGAF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B43112740;
	Thu, 19 Nov 2026 22:04:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08879112740;
 Thu, 19 Nov 2026 22:04:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AB1B6252D;
 Thu, 19 Nov 2026 22:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FF41F000CA;
 Thu, 19 Nov 2026 22:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795125877;
 bh=PI7G2oNkJyP4qTtg2yF+n/o1C/UwLBkBdnZWxPffPSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U1JaDGAFwasS7MYay0oPg1k0PaGyii50B2MJqs3mm6k1/gkmRCAeYt+Vx98uWf0RO
 0cCL5CkoCcJrS7YB7BwETQC8KYr2rrzxEcBhnHaOxSqs3/7ej/bmwHe+IZgw4dM/0s
 FEvP7LUrARGVFW/gJ527xrfJ/vbBQamYn/hvm7PXjzhPKQa7T4y5YxPY+hV1S/TTTW
 7iGZpbYkSnj+QugGhTABjkE5p8uXqIKEQtj4iXDM6kGk7KYVRuYxSo9/SVfbtPkLw4
 dFBQKllaYZi6O+uvFIruwlHWUtIS7lBLpQ9E8GXs9hKqigtUz85jQcW2Yb/+K0GJ1t
 lHsvUtEMlqiHg==
Date: Thu, 19 Nov 2026 23:04:34 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, airlied@gmail.com, 
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, simona@ffwll.ch,
 tursulin@ursulin.net, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
Message-ID: <av9xxr03wFlfWwhv@zenone.zhora.eu>
References: <20261118153205.2432736-1-haoxiang_li2024@163.com>
 <179507544606.16202.12430112951192190652@jlahtine-mobl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179507544606.16202.12430112951192190652@jlahtine-mobl>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Joonas,

On Thu, Nov 19, 2026 at 10:04:06AM +0200, Joonas Lahtinen wrote:
> Quoting Haoxiang Li (2026-11-18 17:32:05)
> > i915_vma_pin_ww() allocates bind work before retrieving the object's
> > moving fence. If the lookup fails, it jumps to err_rpm, bypassing the
> > fence commit at err_fence and leaking the work allocation.
> > 
> > Jump to err_fence instead so the fence callbacks can release the work.
> > 
> > Fixes: 8ec5c0006c50 ("Merge tag 'drm-intel-next-2022-05-20' of git://anongit.freedesktop.org/drm/drm-intel into drm-intel-gt-next")
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> 
> You seem to be spamming the different kernel subsystems with patches and
> never respond to any feedback, so if you could just stop and do something
> else.

The patch is correct, though, and I'd take it.

If Haoxiang is not responding to other patches then bad for him
and I'd give the same suggestion as you did. But if we are not
taking this patch, then we would remain with a clear known
liability in our code.

Andi
