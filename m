Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1A9CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD59510E45D;
	Tue,  5 May 2026 22:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rUQ1kXUl";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C647C10E45D
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:03:42 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D80385B2;
 Wed,  6 May 2026 00:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778018618;
 bh=0enfH9MaghJe1NRHjDQd0G9Ook3g6sEavxPdH0LUlDA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rUQ1kXUldVcE6uezjEG75AW4gGCp9QMg705KpcXAawY7Q2VbKt7YVux3MVo/vtUyM
 2cyfTOw6c/polEXZeReO0AFi6IWJJvlsVsb9D8aW12ZnwOzlh+ohYspHUBTuAVaB+1
 wKIioKgySEZupTiNthDpjOly7KtzZlUOReVteOGk=
Date: Wed, 6 May 2026 01:03:39 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: renesas: r8a779md: Add Renesas R-Car
 R8A779MD M3Le DTs
Message-ID: <20260505220339.GI1547435@killaraus.ideasonboard.com>
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-7-marek.vasut+renesas@mailbox.org>
 <20260429221153.GD132396@killaraus.ideasonboard.com>
 <380861ce-b832-4789-93fa-c2340ce487e6@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <380861ce-b832-4789-93fa-c2340ce487e6@mailbox.org>
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

On Sun, May 03, 2026 at 01:39:27AM +0200, Marek Vasut wrote:
> On 4/30/26 12:11 AM, Laurent Pinchart wrote:
> 
> Hello Laurent,
> 
> >> +/delete-node/ &vin4csi20;
> >> +/delete-node/ &vin5csi20;
> >> +/delete-node/ &vin6csi20;
> >> +/delete-node/ &vin7csi20;
> >> +/delete-node/ &xhci0;
> >> +
> >> +&du {
> >> +	compatible = "renesas,du-r8a779md";
> >> +	renesas,cmms = <&cmm0>, <&cmm3>;
> > 
> > Shouldn't you then also delete the cmm1 node ?
> 
> Please see my reply to [PATCH 1/7] dt-bindings: display: renesas,du: 
> Document Renesas R-Car R8A779MD M3Le , the CMM0,1,3 all seems to be on 
> the chip and accessible. I think the CMM driver should be aware of the 
> IP, even if it is unused, e.g. to bring it into low power state if needed.
> 
> > And does the DU still need three clocks and three interrupts ?
> The Geist board schematic indicates that DU_DOTCLKIN1 is present on the 
> SoC package and is supplied by Xtal X22 on the board, so I think the 
> answer is "yes" for the first clock part of your question.
> 
> As for the interrupt part, it seems DU1 is present, but not connected. 
> That means the DU1 interrupt does exist, but is not going to be used. Do 
> you prefer to describe it or leave it out ?

Following our discussions on IRC, I understand there are quite a few
unknows at this point, and more testing is required in order to upstream
display support. I think your next version will drop support for the DU,
I'm fine with that as a first step. We can then build on top.

-- 
Regards,

Laurent Pinchart
