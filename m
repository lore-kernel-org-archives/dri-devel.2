Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD03AF8A16B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DB710E1DF;
	Thu, 16 Apr 2026 12:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k38KH5gq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4798E10E1DF
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 12:25:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F04FB41B05;
 Thu, 16 Apr 2026 12:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD2BC2BCAF;
 Thu, 16 Apr 2026 12:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776342328;
 bh=6+bhKxlhyP70s6qQtFL8x4iitk+Ytpo3TCuQoPIXt0o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k38KH5gqOnP6n131pbJu9czjOBIkqyufr/hm793QVcngxruaeefymllcOimP/h7mY
 s02vcEuUh9+fGlDjehpzXsnGogJrWzFWOes8yZiFrxkDHQBeDxHirJ6iUGM1icJwy0
 srdFVE7uYw+ccgNwgGL3T2qUeXxcYFrFPmV7SBcjmMa/HTMfdQAm+tLIOs4AL2SAHf
 mNdqE8yNbY8iDgCEbzC0UjXFlnju8uHG6aXfBGYlU9WhBpuBPKgXawPE7xPBI3dOCw
 cIdYaAlQ2eMsHjtgY0CP3Vdlm5E+bi29Y5hspUsz14X2bcyAqv4M0up2EVV7hRgYAW
 ody2nzNTqLryw==
Date: Thu, 16 Apr 2026 07:25:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Swamil Jain <s-jain1@ti.com>
Cc: jyri.sarha@iki.fi, maarten.lankhorst@linux.intel.com, vigneshr@ti.com,
 praneeth@ti.com, krzk+dt@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, devicetree@vger.kernel.org, airlied@gmail.com,
 linux-kernel@vger.kernel.org, mripard@kernel.org, devarsht@ti.com,
 tomi.valkeinen@ideasonboard.com, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] dt-bindings: display: ti, am65x-dss: Fix AM62L DSS
 reg and clock constraints
Message-ID: <177634232413.2771790.10894262514665978952.robh@kernel.org>
References: <20260415110409.2577633-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415110409.2577633-1-s-jain1@ti.com>
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


On Wed, 15 Apr 2026 16:34:09 +0530, Swamil Jain wrote:
> The AM62L DSS [1] support incorrectly used the same register and
> clock constraints as AM65x, but AM62L has a single video port
> 
> Fix this by adding conditional constraints that properly define the
> register regions and clocks for AM62L DSS (single video port) versus
> other AM65x variants (dual video port).
> 
> [1]: Section 12.7 (Display Subsystem and Peripherals)
> Link : https://www.ti.com/lit/pdf/sprujb4
> 
> Fixes: cb8d4323302c ("dt-bindings: display: ti,am65x-dss: Add support for AM62L DSS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---
> Validated the changes with some examples:
> https://gist.github.com/swamiljain/79f30568c9ece89f5a20218f52647486
> 
> Changelog:
> v3->v4:
> - Add reg-names constraint
> - Re-order constraints to make it consistent with the properties order
> 
> Link to v3:
> https://lore.kernel.org/all/20260410105955.843868-1-s-jain1@ti.com/
> 
> v2->v3:
> - Reduce redundancy and use constraints suggested by maintainers
> - Remove blank line between the tags
> 
> Link to v2:
> https://lore.kernel.org/all/20260129150601.185882-1-s-jain1@ti.com/
> 
> v1->v2:
> - Remove oneOf from top level constraints, it makes bindings redundant
> - Remove minItems from top level constraints
> - "dma-coherent" property shouldn't be changed in v1 itself
> - Add description for reg-names, clock and clock-names
> - Add constraints specific to AM62L and for other SoCs within allOf
>   check
> 
> Link to v1:
> https://lore.kernel.org/all/20251224133150.2266524-1-s-jain1@ti.com/
> ---
>  .../bindings/display/ti/ti,am65x-dss.yaml     | 70 ++++++++++++++-----
>  1 file changed, 52 insertions(+), 18 deletions(-)
> 

Applied, thanks!

