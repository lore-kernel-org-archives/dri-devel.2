Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF2BC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D92310EE53;
	Thu, 30 Jul 2026 09:01:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K9csu7bT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB2010EE4B;
 Thu, 30 Jul 2026 09:01:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A24F44EA6;
 Thu, 30 Jul 2026 09:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ABF1F00A3A;
 Thu, 30 Jul 2026 09:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785402070;
 bh=LGo0Y+vq8nefU4ANrNQuN1FAY/ncrAOjApNfAbchaPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K9csu7bTuIFAo0REU75oHr3UT4yLq/Sc/4HP8zzyqb7Y9Ft46Dq94BB8tVXhCFHmI
 m/nwO4e8zHoEVxz/a7whYqxIDdIOXrJ3QVPReWM6uJ51vG9JxJaxdwcABR0YlvuUaQ
 XWKYsW9UszPl2Jr1sYHUC/uXZJA3zy+w4NuAebwGMml6Zi6WSbPF7dU9yBfSgrmuKP
 e5JEgWTgte1nui0+bRcaeWwO9yb6YN+s4y7qN0rVBzBgKbXth6kdGQgKRydd1bSHTJ
 9GeDTtGaBVnwlD/a3TX1WVLTQSTtWHTlfDUeKK1n9TEYaPnDdQEbeMx6ADo1jQ/bMT
 n0N+Js1okv/Cg==
Date: Thu, 30 Jul 2026 11:01:05 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, 
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Chris Wilson <chris.p.wilson@linux.intel.com>
Subject: Re: [PATCH] drm/i915: Replace sleep with GT idle wait
Message-ID: <amsSJGPIyXXgtyNd@zenone.zhora.eu>
References: <20260722072228.1080796-1-andi.shyti@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722072228.1080796-1-andi.shyti@linux.intel.com>
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

On Wed, Jul 22, 2026 at 09:22:28AM +0200, Andi Shyti wrote:
> On VT-d systems, the driver must ensure that the GT is idle
> before DMA object pages are unmapped.
> 
> Currently, the driver simply sleeps for 100-250 microseconds,
> which does not guarantee that all requests have completed and no
> further ones are being submitted. Replace the sleep with
> intel_gt_wait_for_idle() to explicitly wait until the GT has
> become idle.
> 
> An error is printed if waiting for the GT to become idle fails.
> 
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>

NAK, this patch is doesn't fix anything and reintroduces the
livelock that Chris has tried to originally workaround.

Sorry for the noise.

Andi
