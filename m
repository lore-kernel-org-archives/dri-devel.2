Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E03DCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 15:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B461A10F275;
	Thu, 14 May 2026 15:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EWFiSNnc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6406410F275
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:23:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E0ED60154;
 Thu, 14 May 2026 15:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FC2C2BCC7;
 Thu, 14 May 2026 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778772212;
 bh=JvugWyByTkXEaIiK4vIpB6X4Zi+TSZyKhUr1GwFqia0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EWFiSNnc3dSAI7/O8AGV6HRJlPPpdM0omY94DJV0t1xNMNDmXd77WNVptjBI4LqM+
 J6eBL3atJACHKI7alCexSwPf8VItP7gqXfKFdio/YEVXB5Y5DMGmt2pbAXD7Zo7aag
 pBRGqZfGuBq77ctyeUArqY3aWFwgcku/nuHFfWaPiZkaNTT2H5qlfczGMIcZ48hrxH
 QX/qKDZ6qYc1j5QYnecdWpga9qP/lIzPEnKPiCuxHe0Dp+FLWWiSQQ8pdt7fqtIAeY
 Z1zbliDw451ngxw4FNmDmvdNzvp2wueQi/MfOKwOupMWNG9+/cK5MUYFFmRuLgSHgX
 XzSohzDYdTcMQ==
Date: Thu, 14 May 2026 10:23:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Simona Vetter <simona@ffwll.ch>, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 2/5] dt-bindings: display: renesas,rzg2l-du: Add
 RZ/T2H and RZ/N2H support
Message-ID: <177877220882.612619.10485324075713791036.robh@kernel.org>
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260512144104.761531-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512144104.761531-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


On Tue, 12 May 2026 15:41:01 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document the Display Unit (DU) support for the RZ/T2H and RZ/N2H SoCs.
> 
> The DU block on RZ/T2H is functionally equivalent to the RZ/G2UL DU and
> supports the DPI interface, but includes SoC-specific register differences
> and has no reset control. Add a dedicated compatible string to represent
> this variant and update the allOf constraints accordingly.
> 
> As the DU implementation on RZ/N2H matches RZ/T2H, describe it using an
> RZ/N2H specific compatible string with the RZ/T2H compatible as fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - No change
> 
> v1->v2:
> - Dropped the "port" property in favor of "ports" with a single port@0
>   child, to align with the existing RZ/G2L bindings and simplify the
>   device tree structure.
> - Updated the commit message to reflect the change from "port" to "ports".
> - Dropped RB tag from Rob due to above changes.
> ---
>  .../bindings/display/renesas,rzg2l-du.yaml    | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

