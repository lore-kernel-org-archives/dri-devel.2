Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD90C88E45
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F01C10F088;
	Thu, 10 Sep 2026 22:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y0rsxF3J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F37110F085;
 Thu, 10 Sep 2026 22:33:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75E1F601F0;
 Thu, 10 Sep 2026 22:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886521F000FF;
 Thu, 10 Sep 2026 22:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789079613;
 bh=zJ8BgUiYocvgAL+cnXgVrbEwxr8z4wAo+lXStos3B5Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y0rsxF3JeEL4kTSYxZkrv94F+7FDsXhu5+pu9b0sDajVgTvMMSGl82ERGGBuGgUh7
 R60v7bdQ1/3WrtfbbqK1tuvHNYbDUsFWSQ4SLZw+zvJPvizgHBGIUmFnJNxrXECk1s
 515jkYTvNVRbHoRidNHQeOb8/SUc76Y6GetxiTU8kikVfMRUUpas549ryWufH5qCrz
 NpIYhvF9DfChMPoTsr+JKBOtC4kbo9JNf+xiRneN5TOPlAzG/2hcYu/Rsz24+e303I
 UwSeAxSNy0LqbFreAB7Sj8ejC0Sn7VN6VveEDPIM6Z4BZL6zwFrbpq8YZ3kQDT0WQs
 pVKKt528SBuxA==
Date: Fri, 11 Sep 2026 00:33:29 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 7/7] drm/i915/gem: Remove iterator and use while loop
Message-ID: <aqMv2XxfGhxoWgdK@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-8-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-8-krzysztof.karas@intel.com>
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

On Wed, Sep 02, 2026 at 08:25:25AM +0000, Krzysztof Karas wrote:
> Change the main "for" loop into "while" to get rid of obscure
> iterator "i" and use a more descriptive name to indicate how
> many pages were already covered. Detect first loop with
> st->nents.
> 
> Assisted-by: GitHub Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
