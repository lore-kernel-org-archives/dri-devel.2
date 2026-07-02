Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD30C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D074010E4A1;
	Thu,  2 Jul 2026 08:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZQaM1bAQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D45410E4A1
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:25:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D48A96001D;
 Thu,  2 Jul 2026 08:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FF71F00A3A;
 Thu,  2 Jul 2026 08:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782980737;
 bh=4RY6J5hQsKwwS1bODNyJH4n0AYCEf0BX4FbYt1LmhgE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZQaM1bAQ4JjnPHk4nL6I/xL2zRMuxjW8IYTzz1iMgcDC7gq0rPmgrU3aPeZ+Yuh2f
 LrrpGKLZ1JtGJy6Lh3gbWyHQSVZArAYsxZ53k8q3kPG63seQYLxnbAbkFsiYP+7UO1
 tdaN298mTxAzR5LHevcBRh1iZrmx6upDRIYoMdLtsLTn0ifY+JkkyeGZtdHA1hR/iW
 WiannNMPw8hsKAdYGtF70dJgitWc9ADcQtaZCQp6qJEI5qVR6Kwwe2UVmlePHfaHqJ
 JjPyQG978zg3CsJU+pPrNkJ0I0uKr0+dZzAMantZsCeSCdNtw4VJZwgZb5HRPeRpOG
 RiOnQvVo7Fp4g==
Date: Thu, 2 Jul 2026 10:25:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junjie Cao <junjie.cao@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, caojunjie650@gmail.com
Subject: Re: [PATCH] MAINTAINERS: update my email address for the AW99706
 backlight driver
Message-ID: <20260702-ethereal-granite-pronghorn-839bf5@quoll>
References: <20260701133533.32585-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701133533.32585-1-junjie.cao@linux.dev>
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

On Wed, Jul 01, 2026 at 09:35:33PM +0800, Junjie Cao wrote:
> Switch my maintainer entry for the Awinic AW99706 WLED backlight
> driver from my personal Gmail address to junjie.cao@linux.dev.
> 
> Update both MAINTAINERS and the device-tree binding maintainers field.
> 
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
> ---
>  .../devicetree/bindings/leds/backlight/awinic,aw99706.yaml      | 2 +-
>  MAINTAINERS                                                     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

