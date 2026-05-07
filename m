Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9919ACD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DE310E263;
	Thu,  7 May 2026 10:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SSLrc/lN";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B2C10EFBB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 10:38:33 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7DFB664;
 Thu,  7 May 2026 12:38:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778150307;
 bh=ydmTmsjfRJ0hth7ILhAiLaP0jMYvJoZgq1tSBlpEHq8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SSLrc/lNt577vc7KdRU5Lp7rvS19wjBj/Atp47wfhnbIQE29QoLJ9Z/c0K9jzOxMV
 P+0fOPK2eBeuitkxn2PxO76f2/ceMBkRx+EiwzLx0uHlfYzXQHv2INJ3XT+eJWAvEl
 2ToegnWLEYNhE3g++h6115a5yHLIzBGuC3nZoonk=
Date: Thu, 7 May 2026 13:38:30 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H
 and RZ/N2H support
Message-ID: <20260507103830.GM1778786@killaraus.ideasonboard.com>
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506195002.GA1778786@killaraus.ideasonboard.com>
 <CA+V-a8u8=mfR0zDJRNMEjnjrzFVAkOrqtro05Zgd1JFqGRByKw@mail.gmail.com>
 <TY3PR01MB1134676FA7479724BDCE40649863C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3PR01MB1134676FA7479724BDCE40649863C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

On Thu, May 07, 2026 at 09:24:48AM +0000, Biju Das wrote:
> On 06 May 2026 20:58, Lad, Prabhakar wrote:
> > On Wed, May 6, 2026 at 8:50 PM Laurent Pinchart wrote:
> > > On Wed, Apr 29, 2026 at 06:00:09PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Document the Display Unit (DU) support for the RZ/T2H and RZ/N2H SoCs.
> > > >
> > > > The DU block on RZ/T2H is functionally equivalent to the RZ/G2UL DU
> > > > and supports the DPI interface, but includes SoC-specific register differences.
> > > > Add a dedicated compatible string to represent this variant.
> > > >
> > > > As the DU implementation on RZ/N2H matches RZ/T2H, describe it using
> > > > an RZ/N2H specific compatible string with the RZ/T2H compatible as fallback.
> > > >
> > > > Unlike other DU variants which use a multi-port model, the RZ/T2H
> > > > and RZ/N2H DU has a single output and is modelled using a single
> > > > port node with one endpoint. Add a port property to support this and
> > > > update the allOf constraints accordingly.
> > >
> > > Wouldn't it be simpler to always have a "ports" node, even for
> > > variants with a single port ?
> > >
> > I agree that, from a binding perspective, always having a "ports" node keeps things simpler and
> > consistent. Biju suggested this change based on earlier feedback for the RZ/G3E series.
> 
> From G3E feedback, I got the impression that going forward all future SoCs needs to have
> single port and multiple endpoints. That is the reason for suggesting port for new SoCs.

Right, let's clarify that.

TL;DR: it depends on the hardware architecture (what a surprise :-))

When reviewing the G3E, I noticed that the LCDC has a single output that
is connected to one or multiple encoders, depending on the SoC. I think
this should be modeled in DT with a single port.

Note that this does not preclude using a "ports" node, containing a
single "port@0". If you're confident enough that no future generation
will require multiple ports, then it makes sense to standardize on a
single "port" node and no "ports". If, on the other hand, you think that
some SoCs would have multiple ports, then using a top-level "ports" node
unconditionally would lead to simpler bindings.

I'll let you all decide what you think is the most suitable approach.

-- 
Regards,

Laurent Pinchart
