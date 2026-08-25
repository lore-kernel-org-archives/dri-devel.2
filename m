Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29B7C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D801210EA73;
	Tue, 25 Aug 2026 14:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G1GLfr7O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328AC10EA6E
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 14:24:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA4BD41AEB;
 Tue, 25 Aug 2026 14:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29321F00A3A;
 Tue, 25 Aug 2026 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787667871;
 bh=2RkQOOLYLownyq4udSCBZzxrwkOqMpKkbw+Pe3Jqjf0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G1GLfr7O9aDC9kFWGpDG0Cgz0F/gKL14xxiH1s+/krw2qyGM8L1dkVGilSH/Vp2WL
 W+iFJZSGjWYOs2zzDV1FfoPQqX+aem2PpZ8DvixaVP9DcOBaUszMJoOKKxD8D6Xey9
 0L5mZ5ItAPNS6QNvdQdjeHoJlHHOs0EV3BiP/rkZ7mncxlkhhhS8NwqTF6y37dx0iI
 OcUrCJSnI3VD2mup2sKGfXpOL8/0H3pnBYjI28FxHa1gj5R86/OMrHHwZxeXD5YTcB
 O1zGvyWixeglmX3KJ2YPA1ha1einf8SZtfbX+cyN2fh3csDzUbVMD9RXnESoPQ9+CF
 P/VRPdEwqRqrg==
Date: Tue, 25 Aug 2026 16:24:28 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 Maarten Lankhorst <dev@lankhorst.se>, 
 Andi Shyti <andi.shyti@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
Message-ID: <ao2lXC8z9snNBX2P@zenone.zhora.eu>
References: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
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

Hi,

On Mon, Aug 24, 2026 at 05:11:25PM +0200, Geert Uytterhoeven wrote:
> Enabling a (modular) test should not silently enable additional kernel
> functionality, as that may increase the attack vector for a product.
> 
> Fix this by reverting the select to a dependency.  Make sure the GPU
> buddy allocator can be tested without enabling another driver that uses
> DRM_BUDDY by making GPU_BUDDY visible if KUNIT is enabled.
> 
> The page based buddy allocator for GPU memory is only used by DRM.
> Hence add a dependency on DRM to GPU_BUDDY, to prevent asking the user
> about this code when configuring a kernel without DRM support.
> 
> Fixes: 8fe3fc37564920ae ("gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

I agree with this fix, but as sashiko pointed out, .kunitconfig
needs to be updated as well.

Andi
