Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763EBC88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDFD110EC18;
	Thu, 10 Sep 2026 22:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YXPkwHBa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011E610EC18;
 Thu, 10 Sep 2026 22:11:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B09614071E;
 Thu, 10 Sep 2026 22:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B41F000FF;
 Thu, 10 Sep 2026 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789078282;
 bh=wWZZV6M2jtgvgSqhCuTmOOsoAMFv5dTKINEq4VrrVro=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YXPkwHBa8wk6+BvGiegPvHIC9Juu8B/WxOxoh18kcXtSpPSUeEk8x59doiyU3btI5
 mjz4X5a+ZIbxW4YuY3n9pqXIeVkx8YbKW906NbJb/nKLonOSaX1z+vtf/iqNyONc6S
 qgplt/2p21v7Kd/9wKqfBGUASN1APT8GifGix4EE8FFRm8joOl+ZIbwUJPhoFawDCz
 Yevki3TNreFNGoyCErtj7/azRYMlBLLSHiXQD/o6JCADIgAZACZFa14VyuZUAPjxLt
 Uju4lvNwQVMwCrikFhy+IiIcjJWpfUc6IBBdaP1IbL4iYVNHs5wji9eA5jdSMFvUGn
 NqAtCWvzB7c5A==
Date: Fri, 11 Sep 2026 00:11:18 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 3/7] drm/i915/gem: Free sg table on failure to acquire
 second folio
Message-ID: <aqMq8d7aEedeBn8V@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-4-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-4-krzysztof.karas@intel.com>
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

On Wed, Sep 02, 2026 at 08:25:21AM +0000, Krzysztof Karas wrote:
> We should release folios if the first entry was populated, but
> loop failed before sg advanced (st->nents == 1 && sg == st->sgl).
> 
> Fixes: 957ad9a02be6 ("drm/i915/gem: Avoid iterating an empty list")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
