Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B989F99351
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055BE10E2A3;
	Thu, 23 Apr 2026 09:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aWCr48RK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD3310E2A3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 09:10:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B36546001A;
 Thu, 23 Apr 2026 09:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B9FC2BCB2;
 Thu, 23 Apr 2026 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776935417;
 bh=okrKUr8RxovSOJAMjv2qyTJBTUNmF8XTs1bKE6RVCXA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aWCr48RKl8fuSrSKl6KiFcXcIF4pjFXLaFHIv87GyPP5OROG73n1kkUfQzhAZ+3je
 kPEOpyAIE05PB14FI/RG3PRZISpKTgjyi39QUZyg2fzkCu4GLyJP8Y1l4Fu29bw5YV
 BYqCcJgrfUJzgyyL/xovi9KxWRzKfRnAA77bAFUYdTTXvjjiUPZL54Ez7XhWYl+aXD
 +tVWpMNJ+lywHu/UFdYY8MPWCoGJk5TNyPsBewRg+QeOd53x/t1kGIiOS8aTANsqLW
 ENAPLL8e9oLljAIO7ihWKJHekXWxO7WQkE0a/DS/366Ct5WmD62LLaUVxdU7MauDMl
 SKhVM2rTk9hQQ==
Date: Thu, 23 Apr 2026 11:10:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: dri-devel@lists.freedesktop.org, Kael D'Alcamo <dev@kael-k.io>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>, 
 Simona Vetter <simona@ffwll.ch>, Thierry Reding <thierry.reding@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: simple: Document Displaytech
 DT050BTFT-PTS panel
Message-ID: <20260423-simple-earwig-of-education-edc36f@quoll>
References: <20260422210806.80948-1-marex@nabladev.com>
 <20260422210806.80948-2-marex@nabladev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422210806.80948-2-marex@nabladev.com>
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

On Wed, Apr 22, 2026 at 11:07:24PM +0200, Marek Vasut wrote:
> Document the Displaytech DT050BTFT-PTS 5.0" (800x480) color TFT LCD
> panel, connected over DPI. The datasheet from 16 Nov 2023 is available
> from Seacomp:
> 
> https://www.seacomp.com/sites/default/files/datasheets/DT050BTFT-Displaytech-Spec.pdf
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

