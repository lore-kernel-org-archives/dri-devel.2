Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D91C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE24410F429;
	Fri, 28 Aug 2026 16:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WTM+j3Kx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC1A10F424;
 Fri, 28 Aug 2026 16:30:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A890440B35;
 Fri, 28 Aug 2026 16:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DC61F000E9;
 Fri, 28 Aug 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787934608;
 bh=tY4wi0Hw//HMvuAjx2+QG9v063dDMraFVN/xIrZ0B/M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WTM+j3KxDSoYUdnVTxDz3N6sVE+EjQj0XQ9UdZxQgsDogGv86Aqgv88TJyKBCl4px
 Qsrf27BrlA5q97LEava3qiPXRcXw06cUzEjUqxaaQCqIYlj6g4sM7/LCGM8faYQN5/
 UBZbbRbtOnCeczSJ3D9QlZIHWKGIZIK36rlbSRqGkohjEEeXyafhZbB/wdaStj2Ivf
 AhjhvlVA3dJ4ytgx7lGVoqw8Rq35uh4UbP7A7IjS+5oaWA/odX8gCTLgutHtEvFvAX
 2n15sSH7bjKDuicBCS2N2D8lSirB68dcXSGSlSavN398oQhYEpBUJ7e4fdTb02nu1h
 jKGBSe3R2iekg==
Date: Fri, 28 Aug 2026 18:30:04 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 7/8] drm/i915/selftests: Use drm_* prints in selftest
 headers
Message-ID: <apG3WvXV3CYYnIIT@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-8-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-8-krzysztof.karas@intel.com>
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

Hi Krzysztof,

On Fri, Aug 28, 2026 at 10:03:38AM +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  drivers/gpu/drm/i915/selftests/i915_selftest.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

in the title you are stating that you are using drm_* in headers.
Please, fix the title according to the change.

Thanks,
Andi
