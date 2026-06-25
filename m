Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F388CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5465510E1CD;
	Thu, 25 Jun 2026 08:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iQ1p8ohR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED8110F1AB
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:36:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDA7760220;
 Thu, 25 Jun 2026 08:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654C71F00A3A;
 Thu, 25 Jun 2026 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782376572;
 bh=oD1VxhZq9697KH+qXgV3dLwh8bpLta0Equ9DdguzgIk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iQ1p8ohRyKBQ7KY1xLnpE2A7CijIb0wV9ojbLnsIUVienGHT1LGanmRv+2U4ThS2V
 mkpwyZ3vOHiyyezR2aygJo67d+CUufQWIbtoo/1nZ1pP/kztbpYtT1s6wU13ibESF1
 2zl5YhqGRnoJqaQfkYe4qHegUAa/WONp9y8vLwDEcaX/Ie5YsbL5NDI8lYEbmUx9sZ
 ntRJelUX6p77oOSWfPqa8fwvDx2xSkCWGNsqem87UFw7P1PO6sokYqv3GeKc14uVXU
 6SU7+5Gvzb2Xa/+HF0uViYKJ9hVOZrR9/iiELgNhi6MUfFTA3sl2NmVCcosv1HsAg5
 C+pxOb10VtVtQ==
Date: Thu, 25 Jun 2026 10:36:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: tegra: Add channel/syncpoint
 range properties
Message-ID: <20260625-poetic-heavy-vulture-7baabb@quoll>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
 <20260622-host1x-nohv-v1-2-65bc682a617f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622-host1x-nohv-v1-2-65bc682a617f@nvidia.com>
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

On Mon, Jun 22, 2026 at 05:22:51PM +0900, Mikko Perttunen wrote:
> Channels and syncpoints available may be limited when other system

What are channels and syncpoints?

> components are using them. Add properties nvidia,channels and
> nvidia,syncpoints to limit the range of usable channels and/or
> syncpoints.

Why isn't this deducible from the compatible?

Also, nvidia,channels is too broad/generic. This is not ADC, right? And
channels is a common term in IIO. And in few other cases.

Best regards,
Krzysztof

