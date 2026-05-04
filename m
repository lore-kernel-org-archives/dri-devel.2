Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65407FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBAC510E78C;
	Mon,  4 May 2026 19:04:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 265F710E78C
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:04:40 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mfe@pengutronix.de>)
 id 1wJyaF-0001jw-LA; Mon, 04 May 2026 21:03:59 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <mfe@pengutronix.de>) id 1wJyaC-000SKl-1r;
 Mon, 04 May 2026 21:03:57 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
 (envelope-from <mfe@pengutronix.de>) id 1wJyaC-0000000Gfy7-3deA;
 Mon, 04 May 2026 21:03:56 +0200
Date: Mon, 4 May 2026 21:03:56 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Liu Ying <victor.liu@nxp.com>, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Marek Vasut <marex@nabladev.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
Message-ID: <2mkih6id2cfqjfksfvvitzlcnyfz7r4rs4f7bhtvdhf7scwzue@bb4ucnfxa4l4>
References: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
 <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
 <0d7c7403-4b77-42f3-82d6-eaf2be8e5b1e@nabladev.com>
 <excxf6kxwx44kepc22smvvnirptc4kxpubioxoto7nqleqhoiq@ymch4y6dd5n5>
 <bc7d5955-600a-48eb-b897-3928ace275a5@nabladev.com>
 <7hysu6kamrsltsfcp5hyx23o5nbqbds22jhv65266w2qmps6ft@4tpbs4gfnzx4>
 <afMnXQCRX4WEhxfu@raspi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afMnXQCRX4WEhxfu@raspi>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

On 26-04-30, Liu Ying wrote:
> On Thu, Apr 16, 2026 at 01:20:20PM +0300, Laurentiu Palcu wrote:
> > Hi Marco, Marek, Ying,
> > 
> > On Tue, Mar 31, 2026 at 01:22:19AM +0200, Marek Vasut wrote:
> > > On 3/30/26 8:29 AM, Marco Felsch wrote:
> > > 
> > > Hello Marco,
> > > 
> > > > > > On 26-03-29, Liu Ying wrote:
> > > > > > > LDB's parent device could be a syscon which doesn't allow a reg property
> > > > > > > to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
> > > > > > > has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
> > > > > > > without a reg property(LDB is also a child device of the Media blk-ctrl).
> > > > > > > To make the LDB schema be able to describe LDBs without the reg property
> > > > > > > like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
> > > > > > 
> > > > > > NACK, we want to describe the HW and from HW PoV the LDB is and was
> > > > > > always part of a syscon. This is the case for all SoCs i.MX6SX/8MP/93.
> > > > > > 
> > > > > > > Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
> > > > > > 
> > > > > > Therefore I would just revert this patch completely.
> > > > > Last time, I pointed out the hardware is part of syscon, but as a subnode
> > > > > and therefore with reg properties. What is the problem there ?
> > > > 
> > > > To quote the DT spec here:
> > > > 
> > > > """
> > > > The reg property describes the address of the device’s resources within
> > > > the address space defined by its parent bus.
> > > > """
> > > 
> > > That parent bus would be the syscon, wouldn't it.
> > > 
> > > > The parent bus is not the parent iomuxc (i.MX6X) nor the blk-ctrl
> > > > (i.MX8MP/93) device. Therefore this is wrong IMHO and should be dropped.
> > > 
> > > How so ? What is the parent bus ?
> > 
> > It looks like the discussion is stuck on 2 things:
> > 
> > 1. DT spec argument hasn't been fully addressed: Marek asked "what is
> >    the parent bus if not the syscon?". That question is still open. Syscon
> >    children carrying 'reg' to express their offset within the parent's MMIO
> >    range is a common upstream pattern. Marco, can you explain why syscon
> >    doesn't qualify as the address space provider here?

Syscon is no bus, this is a special MFD device. TBH I've never seen a
dt-binding which makes use of the 'reg' property to abstract the
different MFD functionalities. E.g. the imx6qdl.dtsi anatop syscon
doesn't make use of the reg property either. Instead the different
drivers ensure that only the required registers and bits are touched.

The LDB is no special device here except for the fact that NXP bundled
the LDB bits into two dedicated registers of the syscon (iomux-gpr for
imx6sx and blkctrl for imx8mp,imx93). Unfortunately this wasn't possible
for the other IPs and therefore the LDB is rather the exception than the
rule.

> > 2. Regardless of (1), removing 'reg' from the imx6sx/imx8mp DT nodes is
> >    an ABI break, those nodes are already upstream. Ying's patch is
> >    the minimal fix that respects that constraint while unblocking imx93.
> 
> Yes, I don't want to break ABI by removing the 'reg' property from i.MX6SX
> and i.MX8MP LDB DT nodes.  And, I don't see a way to remove it, which
> doesn't break ABI.

We're speaking about commit 8aa2f0ac08d3 ("dt-bindings: display: bridge:
ldb: Add check for reg and reg-names"). This commit enforces the 'reg'
property and is part of Linux since 7.0-rc1. So there shouldn't be an
issue with the backward compatiblity.

It's up to the DT maintainers to make a decision if it's allowed to
revert the patch which marks the reg property as required, therefore I
added them explicit to the To:.

Regarding the actual DT node name: There are examples which renamed the
node in a non backward compatible way, e.g. the remove of the leading
zeros from @0003000. This is also up to the DT maintainers.

> Laurentiu, Marek, can you please provide your A-b or R-b tags if you are
> fine with my patch?  I see your positive opinion on the idea of this
> patch, based on previous discussion[1][2].
> 
> [1] https://lore.kernel.org/all/p7glzm344tiu76zm5aa7qq4lswdcjuqlqel3hl3tr3s2cllltj@i2eyzuux4cj3/
> [2] https://lore.kernel.org/all/a4a5284d-6004-46c5-b5a3-f8eb4d9b3680@nabladev.com/
> 
> > 
> > Marco, a broader cleanup of 'reg' from imx6sx/imx8mp would need to be a
> > separate patch with an explicit plan for the ABI impact... So, for now, my
> > suggestion is to move forward with Ying's solution.
> 
> I'm open to any better idea than my patch to support i.MX93 LDB in DT.
> If there is any, I'd like to see plan/discussion/patch for that.

Honestly I don't know why this is such a big deal here. I get the fact
that you want to move forward with the i.MX93 but this patch complicates
the handling for something which shouldn't be that complicated. By
removing the complexity we make more maintainable.

There are two points:
 - Don't mark the 'reg' property as required -> revert commit
   8aa2f0ac08d3 (see above explanation)
 - Fix the DT nodes incl. the names

I can provide these patches if you want, unfortunately I'm deep in
project related work and had no time yet to do this :/

Regards,
  Marco



> 
> > 
> > -- 
> > Thanks,
> > Laurentiu
> 
> -- 
> Regards,
> Liu Ying
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
