Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185BEC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 18:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E58410E16D;
	Tue, 25 Aug 2026 18:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oGOTqkpv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D9B10E16D
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 18:55:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53FE94051C;
 Tue, 25 Aug 2026 18:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5569C1F000E9;
 Tue, 25 Aug 2026 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684111;
 bh=KZHQGlEAZKtrNhrPxlldZOvbeSMTgtkvv9lxX4F4Qyk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oGOTqkpvVigGlY5ChrB+WPGAwT0qktoyBN1H1NuXofbYnHZeZhKaQ2wtnX18djCDQ
 1cKzf38vVEl1UClzNFC3XoSxHMrlsA5J3+Soe+c5ht2anxkUDZOLhjHbMomHDVn4JT
 xfavDuv/DNW8EenH1JZRF1yx+8ixrhGYQnZI2aRYvTw/ntLsfzEH1wYdHKSKrxuIii
 NvYeEcLkhAP9u/FDPQezkGDMRova5qFVX0mvZV2fDkL+AWKotqvJSR9Clfa8LkYdw9
 mcNqupo6GEemETKIsvsl3sLcWnHkunmbyKJsV8OxRLBQwvLb7ecNYUCik/aslro46S
 7FVLfOU2oW44A==
Date: Tue, 25 Aug 2026 20:55:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 Maarten Lankhorst <dev@lankhorst.se>, 
 Andi Shyti <andi.shyti@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
Message-ID: <ao3k1kA1Yf_IKkN5@zenone.zhora.eu>
References: <e67a2cb0d599b75ae365882913c543e7b0c5b8a3.1787671708.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e67a2cb0d599b75ae365882913c543e7b0c5b8a3.1787671708.git.geert@linux-m68k.org>
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

Hi Geert,

On Tue, Aug 25, 2026 at 05:29:59PM +0200, Geert Uytterhoeven wrote:
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
> Update drivers/gpu/tests/.kunitconfig accordingly.
> 
> Fixes: 8fe3fc37564920ae ("gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

I tested sashiko's statement and I guess it got it wrong.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
