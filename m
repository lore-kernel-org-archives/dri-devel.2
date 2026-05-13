Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C18CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 22:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903B010F0A3;
	Wed, 13 May 2026 22:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="usmRqyuK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921EF10E20A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 22:27:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B038660052;
 Wed, 13 May 2026 22:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1CAC19425;
 Wed, 13 May 2026 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778711248;
 bh=yMeTXDbCQEz8EGX5JoE/0Wc6TDDp9GFsAJU2DsCuFl8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=usmRqyuK9pOiEvW8mB+vmkviwJba88lsn/0lKWzJt+QFxHCVq6mmr/ESnXb0hD5qE
 QyHC86X9bIOw3ql53AjZRDwtDpW4Vp0cMJdDolQbIpYkfPWwFwVlkc+fp38oStO5Mn
 vguMWBVzGCDkjVhT23lq7EKvbcFny8y+jIyghbw5NSqTJ5kh7ygHwcNfUH/Gs9LzxT
 9jS9CUaTEC270aHe03fCDMC+hORO6IYt8jwHWhOSTFmZydaAhNSd+zDjnnjWrdhDMv
 o3YWKb/5FLf64ufkpeASVLMyJIctLWNE/CiSxbqTCRmM+F0hzMyCGnX48VmC9k1ZqQ
 lBcwEPGn3yoMw==
Date: Wed, 13 May 2026 17:27:25 -0500
From: Rob Herring <robh@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/13] dt-bindings: display: renesas,rzg2l-du: Add
 support for RZ/G3E SoC
Message-ID: <20260513222725.GA2069022-robh@kernel.org>
References: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
 <ff8e401a0667970a42a55420dcb071e34730a923.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8e401a0667970a42a55420dcb071e34730a923.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
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

On Thu, May 07, 2026 at 11:21:30AM +0200, Tommaso Merciai wrote:
> The RZ/G3E SoC integrates two LCD controllers (LCDC0 and LCDC1), each
> containing a FCPVD, VSPD, and Display Unit (DU).
> 
>  - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
>  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
> 
> Add compatible string 'renesas,r9a09g047-du' and extend the binding to
> support two DU instances: add reg-names ('du0'/'du1'), extend reg,
> interrupts, and resets to maxItems: 2, and extend clocks/clock-names to
> six entries (aclk/pclk/vclk per instance, minItems: 3).

Don't write what the diff has. I can read the diff for that.

> 
> Drop the "Each port shall have a single endpoint." constraint since
> RZ/G3E ports expose multiple endpoints.
> 
> Add a RZ/G3E-specific allOf rule mapping two DU instances to two ports:
> 
>  - port@0 (DU0): endpoint@0 DSI, endpoint@2 LVDS ch0, endpoint@3 LVDS ch1
>  - port@1 (DU1): endpoint@0 DSI, endpoint@1 RGB (DPAD), endpoint@3 LVDS ch1
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v6->v7:
>  - Rebased on top of [1]
>    [1] https://lore.kernel.org/all/20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>  - Use single DRM device aggregating both DU instances (1 DU dt node),
>    modelling single port for each DU0, DU1 and multiple endpoints for
>    outputs.

That seems like the completely wrong thing to do and you've given no 
reason why you think it is the right choice.

Rob
