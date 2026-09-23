Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1CBC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC5610E0CB;
	Wed, 23 Sep 2026 15:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cmf+SlqT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F3310E0CB
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:20:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8767A40478;
 Wed, 23 Sep 2026 15:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E826E1F000FF;
 Wed, 23 Sep 2026 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790176840;
 bh=x7hz/wkv4TIP3tFV0atbeAtIVV/ATXHLJDQELrGuxLM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cmf+SlqTaFJfYHX3sPm69koXlm9CC2phElbCF3QFWipRsHqfNXfjmXgo1N3kSzuVo
 39j8AsPtsVJsZzNHaJDJ9bvjelWWcNwUehLTjZ+H45O9I/fPCGukKXZ/XGLwCRdiuJ
 pSt1A5uCI9wb8Nv7Sc2WGuJSKK7wFPmI5H2bPOat5tDgoZKRqS9i2q59Y/vcmkTJdF
 RLO2xKif7mqKBByMy5EeuEhtEsMURKlm1Wt5+JR2eemcdpIl2oGbc/6uOzDtV16eSO
 Ynpy7Gxwxx6a3RzdUcRLSbltyuUhqbVlK4k/oBgXslQBwUd1msjf7kCrkW19E+anUL
 RQ19e+5JSteXQ==
Date: Wed, 23 Sep 2026 16:20:34 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 18/20] mfd/regulator: db8500-prcmu: Remove EPOD
 regulators
Message-ID: <20260923152034.GI3864833@google.com>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-18-9d0c17e1f816@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-18-9d0c17e1f816@kernel.org>
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

On Mon, 14 Sep 2026, Linus Walleij wrote:

> Remove the obsolete DB8500 PRCMU regulator drivers.
> 
> Drop the regulator build hooks and the db8500-prcmu-regulators MFD
> cell now that EPODs are power domains.
> 
> Assisted-by: LLM
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/mfd/db8500-prcmu.c             | 239 ----------------
>  drivers/regulator/Kconfig              |  12 -
>  drivers/regulator/Makefile             |   2 -
>  drivers/regulator/db8500-prcmu.c       | 501 ---------------------------------
>  drivers/regulator/dbx500-prcmu.c       | 155 ----------
>  drivers/regulator/dbx500-prcmu.h       |  55 ----
>  include/linux/regulator/db8500-prcmu.h |  38 ---
>  7 files changed, 1002 deletions(-)

Looks good.  What's the plan?

-- 
Lee Jones
