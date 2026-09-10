Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFECC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E4210F38D;
	Thu, 10 Sep 2026 08:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bi2OEwh+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC0610F38D
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:52:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB5A6600CB;
 Thu, 10 Sep 2026 08:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DF01F000FF;
 Thu, 10 Sep 2026 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030330;
 bh=QSxJWdyReIeiAvKgAQ8G9IsI4hio9q+PYzraL+E27XI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Bi2OEwh+dBcmM538G9dyx3Oq2alMvJAQ84PyDedBuPZumF1KPQpSkumD8FbPtSJZV
 2lcjuWN2HGkbtbgqlfFb0ta6UCSFG6kx2ZNSbgQLOhzkQdxqYAo41bzMeZSeA56wT2
 hd/YITGu4TYavodcJX2qorPYKk+fy+rFLHUaEFiEKQY10WmJ6SaoBzvWpm7EnoNT8A
 Z+2P4QWdkTMQGZKyTfBTRNE/sMearano2UxuBsq46vI1GQfx4NBjOpWwWzMq2Wu8+H
 SSzDGS0iZaUrz3pVTodc3B1M69TvGYoMCF9V+IAxIBJ6kVZyMvBmezu3iunITEY7ry
 qwCBERCmBI8Jg==
Date: Thu, 10 Sep 2026 10:52:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joel Selvaraj <foss@joelselvaraj.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] MAINTAINERS: update Joel Selvaraj's email address
Message-ID: <20260910-premium-pistachio-platypus-e60aa3@quoll>
References: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
 <20260909-update-email-address-v1-2-94a240f9469e@joelselvaraj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-update-email-address-v1-2-94a240f9469e@joelselvaraj.com>
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

On Wed, Sep 09, 2026 at 01:12:00AM -0700, Joel Selvaraj wrote:
> My jsfamily.in address is no longer active, switch to my current one.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---
>  MAINTAINERS | 2 +-

This is the same commit as mailmap update. Not two separate.

Best regards,
Krzysztof

