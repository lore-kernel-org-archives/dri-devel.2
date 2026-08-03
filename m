Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0E3C55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A44C10E4D6;
	Mon,  3 Aug 2026 08:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NKhtBaNr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0614310E4D6
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 08:34:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9563B42A81;
 Mon,  3 Aug 2026 08:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17EF1F000E9;
 Mon,  3 Aug 2026 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785746083;
 bh=T6PSTdosSJnetlCgA4yczYZf9xWsTaKV6oTuRV6Emuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NKhtBaNrIBauI28AWY25IcFZCIgLheck3JBQSqTkVbFuugR6EbSHcx2WlWBtVV7Bn
 86CPeGDlfWd9/ZkokCgYdu7belIvuWkJgAGuFEfgjAhXFHsWq5ROxxxA52ycLPJEPN
 PYce/7Wlm2WJ3I3H58En4+veUcG/1yx+9Tjv7jL2Zay3jWA4apztCJX7uOek2Gs/Gy
 R7AjtXC413FPaZJyF9gH8bMssSKshF76BGCEjK70YHjC9cjbMaWm8FP1pZQK0UQbjt
 WwMpxoDF8uqq74bzfT8LsCyXX82XRDnE58944HAOsHf5ZUisWWPO3kw+ninkM8mubw
 cWNxUsCBTbojQ==
Date: Mon, 3 Aug 2026 10:34:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 07/16] dt-bindings: display: renesas,rzg2l-du:
 Document RZ/G3L SoC
Message-ID: <20260803-screeching-merry-lobster-cc6a7c@quoll>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-8-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729125516.230757-8-biju.das.jz@bp.renesas.com>
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

On Wed, Jul 29, 2026 at 01:54:59PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The DU block on the RZ/G3L SoC is identical to the one found on the RZ/G2L
> SoC. However, it supports the DSI, DPI, and LVDS interfaces, while the
> RZ/G2L supports only the DSI and DPI interfaces.
> 
> Due to this difference, a SoC-specific compatible string,
> 'renesas,r9a08g046-du', is added for the RZ/G3L SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Restored ports.
>  * Replaced endpoint with port in ports node.
> ---
>  .../bindings/display/renesas,rzg2l-du.yaml    | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

