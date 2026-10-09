Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2C7CA9EBD
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE6110EA81;
	Fri,  9 Oct 2026 17:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UOXVnO3z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E2B10E1AD
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 17:34:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 842E443472;
 Fri,  9 Oct 2026 17:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457EC1F000FF;
 Fri,  9 Oct 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791567275;
 bh=Y+e5fiagQUAbWq0G0G72uFDu9M2cjMIliK8S5C6avdA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UOXVnO3zLoVszFvsV1E0D3WZpQXkBbOKbF5rRippK/RnbXOYcy3ELkYeimx3uG//V
 CdFGVtMRcx7GLbDblh+dkr4XNWLvY/7MZtNA9aC/ABl8Q9d+7g5V6ZZ/tcQQgXUnpm
 6W0tuTIBiq4UcdSPP0MZGUdO6pD/xWWMJnGcKnjgov9SfakkP43UUUt+cHr86DK8qb
 taFrkhGfWcmDriSUwg2E0QCOewfSjpTMWVm5JsIzzRzHHJfKkkOcCWoSLHu++eImHK
 4ZTJ+kzQ9OA+lPEbSGeDbuu5dOlAFZT3wb5CXE0C/ne2qxQNO0JoDukIkWjeatApNC
 ljGhNLuwMZsGQ==
Date: Fri, 9 Oct 2026 12:34:33 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Quchaosheng <quchaosheng000406@163.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <20261009173433.GA2862960-robh@kernel.org>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
 <20261009105601.301891-2-quchaosheng000406@163.com>
 <20261009-2f34bbada2c463c78b2c05a7@squawk>
 <20261009144434.GD622105@killaraus.ideasonboard.com>
 <20261009-db35f1d74028d0d0a34f1106@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-db35f1d74028d0d0a34f1106@squawk>
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

On Fri, Oct 09, 2026 at 04:42:01PM +0100, Conor Dooley wrote:
> On Fri, Oct 09, 2026 at 04:44:34PM +0200, Laurent Pinchart wrote:
> > On Fri, Oct 09, 2026 at 03:25:49PM +0100, Conor Dooley wrote:
> > > On Fri, Oct 09, 2026 at 06:55:59PM +0800, Quchaosheng wrote:
> > > > From: Chaosheng Qu <quchaosheng000406@163.com>
> > > > 
> > > > Convert the TPD12S015 HDMI level shifter binding to DT schema.
> > > > 
> > > > The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> > > > and ESD protection circuitry. Document the two ports it exposes between
> > > > the HDMI transmitter and the connector.
> > > > 
> > > > The tpd12s016 is software compatible with the tpd12s015 and is listed as
> > > > a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
> > > > fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so
> > > > a board using the tpd12s016 must list both compatibles.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> > > 
> > > No idea if the sashiko reply is valid, because I have no clue if
> > > providing a subset of the gpios is functional. Really this should have
> > > multiple different gpios properties,

The minItems one is not valid. sashiko struggles on our quirks against 
normal json-schema. Generally, if either minItems or maxItems is not 
specified, we make them equal. I think I documented that, so we need to 
get sashiko to read it...

> > 
> > Definitely.
> > 
> > > but this binding is really old and
> > > not worth changing IMO.
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > pw-bot: not-applicable
> > 
> > I'm getting annoyed be the LLM-assisted individual conversions. Can we
> > start requiring people who convert text bindings to YAML to at least
> > handle whole groups in one go ? If they're going to do a bad job, I'd
> > rather have to review it once only.

I have a branch of ~600 questionable patches. :) It does make arm64 
warning free (and some of the warning fixes are valid).

What's left is really stuff that's old, not getting new platforms and no 
one cares about. I don't think we need perfection. We should probably 
just ignore sashiko.

> 
> Or do one, and take the learnings into all the remaining patches - but
> with LLM conversions I don't think there's really much learning going on
> at all.
> 
> I guess bunching them is fine, provided it is for one subsystem. I
> definitely don't want to see a set of 15 patches across 9 subsystems,
> at least with one subsystem it's likely to be the same common problems
> across the bunch.

I've tried expressing my preferences in priority, but it hasn't worked. 
It was mainly GSoC or other programs, but now it's?

My priority is:

- Fix arm64 warnings
- Fix arm warnings
- Convert subsystem bindings
- Fix other $arch warnings (no one cares AFAICT)

We're actually pretty close to arm64 being warning free. krzk's LPC 
slides inflate the numbers as N boards for a SoC give N copies of 
warnings. next is currently sitting at 218 warnings in my deduped count. 
About half of those are HiSilicon and Mediatek. The rest of the 
platforms (by subdir) are around ~20 or less.

arm32 is still a long way off. The recent platform removals should help 
though.

Rob
