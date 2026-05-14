Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B36CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984D910F1F2;
	Thu, 14 May 2026 13:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rhl+pvbS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2365210F220
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:21:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 428B4601EE;
 Thu, 14 May 2026 13:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A688DC2BCB8;
 Thu, 14 May 2026 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778764862;
 bh=/d6JkD/4Duqh2N5CT7o3NdRCDzek83LRZbMUXKP5S00=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rhl+pvbSZ6S7HzUWEwRzIj50xuMqM3Kgs2qd7rxxwC4uLXgbHc3tWEqcAYPoSxtkU
 3DEN8LsChgWX4ZRW+YUit/4awrUqPZPc58VxaVbbCfQrvBwB/x/krfHDcJzxdy0XMY
 08YIQcSG5vtx5EUc98+p53OrmIbu+n/ibskNAyTv2L3X3S83QwQsx73KBM1CcKk1BG
 BIEueWAugB+95p5UFSETqu2XgSq0IplOZEOTTYNy8xmAm35pXsfDGfEOiu41vfmuLJ
 5Pbbt6gWe02B6QLI1UvdAzouzyWrgHJvymcmpaecpV7z/+vItbu7DJNqNtAuXKfxOl
 GMhSDq9UjtDMg==
Date: Thu, 14 May 2026 08:20:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Magnus Damm <magnus.damm@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, devicetree@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 1/5] dt-bindings: display: renesas,rzg2l-du: Refuse
 port@1 for RZ/G2UL
Message-ID: <177876485382.133353.4226109265397951012.robh@kernel.org>
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260512144104.761531-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512144104.761531-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


On Tue, 12 May 2026 15:41:00 +0100, Prabhakar wrote:
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> 
> The RZ/G2UL DU supports only a single port@0 DPI. Explicitly refuse
> port@1 in the ports node.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3:
> - Was orignally part of separate series [0]
> [0] https://lore.kernel.org/all/d1e0d4e0fe74e60345a3d043fb4f9128c1057638.1778141145.git.tommaso.merciai.xr@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

