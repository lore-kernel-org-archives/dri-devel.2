Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E9310F6FDC
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8C010EDCF;
	Wed,  1 Apr 2026 17:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="GUMNQh4o";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0F5A310EDCD
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 17:20:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E3D2E99
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:20:42 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 1E74F3F641
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775064048; bh=jso9ol/BwsazpOhcwBaDQGk6Irh//4G6BIQJqtlE/t4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GUMNQh4oGH+lLUbUwax8Efbo/CzfC4XNlZtQ92plr1po4rMiQCrWyS242t0OjT7pn
 OFtVdUUoC1pazkKLwa8OwL5X/QJKqFNU9MqecSXUCYEsBMmAIbp6zszc++g26UE97M
 XRiJjHYlD+EkeM0eFTQaLJAeTvw4X6npzvU1Po6U=
Date: Wed, 1 Apr 2026 18:20:27 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Guangliu Ding <guangliu.ding@nxp.com>
Cc: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 Jiyu Yang <jiyu.yang@nxp.com>
Subject: Re: Re: Re: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Message-ID: <ac1T282yvpdAp_TP@e142607>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com>
 <acva1Xt8V4k9-uG8@e142607>
 <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
 <AM0PR04MB4707B3E37DFE7AEE587DBA2AF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <aczv0R0aQRmHKdvt@e142607>
 <AM0PR04MB4707335CC7035232D44E6ED9F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <ac05OpEMjKMd8CXy@e142607>
 <AM0PR04MB4707604AF2C445971C7474EFF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB4707604AF2C445971C7474EFF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
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

On Wed, Apr 01, 2026 at 03:59:23PM +0000, Guangliu Ding wrote:
> Hi Liviu
> 
> > On Wed, Apr 01, 2026 at 10:31:01AM +0000, Guangliu Ding wrote:
> > > Hi Liviu
> > >
> > > > On Wed, Apr 01, 2026 at 09:43:12AM +0000, Guangliu Ding wrote:
> > > > > Hi Daniel
> > > > >
> > > > > > On 4/1/26 11:48, Guangliu Ding wrote:
> > > > > > > [You don't often get email from guangliu.ding@nxp.com. Learn
> > > > > > > why this is important at
> > > > > > > https://aka.ms/LearnAboutSenderIdentification
> > > > > > > ]
> > > > > > >
> > > > > > > Hi Liviu
> > > > > > >
> > > > > > > Thanks for your review. Please refer to my comments below:
> > > > > > >
> > > > > > >> On Tue, Mar 31, 2026 at 06:12:38PM +0800, Guangliu Ding wrote:
> > > > > > >>> Add compatible string of Mali G310 GPU on i.MX952 board.
> > > > > > >>>
> > > > > > >>> Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
> > > > > > >>> Reviewed-by: Jiyu Yang <jiyu.yang@nxp.com>
> > > > > > >>> ---
> > > > > > >>>
> > > > > > >>> Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.y
> > > > > > >>> aml
> > > > > > >>> | 1
> > > > > > >>> +
> > > > > > >>>  1 file changed, 1 insertion(+)
> > > > > > >>>
> > > > > > >>> diff --git
> > > > > > >>> a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf
> > > > > > >>> .yam
> > > > > > >>> l
> > > > > > >> b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.
> > > > > > >> yaml
> > > > > > >>> index 8eccd4338a2b..6a10843a26e2 100644
> > > > > > >>> ---
> > > > > > >>> a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf
> > > > > > >>> .yam
> > > > > > >>> l
> > > > > > >>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall
> > > > > > >>> +++ -csf
> > > > > > >>> +++ .yam
> > > > > > >>> +++ l
> > > > > > >>> @@ -20,6 +20,7 @@ properties:
> > > > > > >>>            - enum:
> > > > > > >>>                - mediatek,mt8196-mali
> > > > > > >>>                - nxp,imx95-mali            # G310
> > > > > > >>> +              - nxp,imx952-mali           # G310
> > > > > > >> Can you explain why this is needed? Can it not be covered by
> > > > > > >> the existing compatible?
> > > > > > > There are functional differences in GPU module (GPUMIX)
> > > > > > > between
> > > > > > > i.MX95 and i.MX952. So they cannot be fully covered by a
> > > > > > > single existing
> > > > compatible.
> > > > > > > On i.MX952, The GPU clock is controlled by hardware GPU auto
> > > > > > > clock-gating mechanism, while the GPU clock is managed
> > > > > > > explicitly by the
> > > > > > driver on i.MX95.
> > > > > > > Because of these behavioral differences, separate compatible
> > > > > > > strings "nxp,imx95-mali" and "nxp,imx952-mali" are needed to
> > > > > > > allow the driver to handle the two variants independently and
> > > > > > > to keep room for future
> > > > > > divergence.
> > > > > >
> > > > > >
> > > > > > This information should be added in the commit message
> > > > > > explaining why
> > > > > >
> > > > > > the change is needed.
> > > > > >
> > > > > >
> > > > > > But then where is the driver code taking care of these diferences?
> > > > > >
> > > > >
> > > > > Yes. Currently the driver does not require "nxp,imx952-mali" string.
> > > > > However, when GPU ipa_counters are enabled to calculate the GPU
> > > > > busy_time/idle_time for GPU DVFS feature, they will conflict with
> > > > > the hardware GPU auto clock‑gating mechanism, causing GPU clock to
> > > > > remain
> > > > always on.
> > > > > In such cases, ipa_counters need to be disabled so that the GPU
> > > > > auto clock‑gating mechanism can operate normally, using
> > "nxp,imx952-mali"
> > > > string.
> > > >
> > > > OK, I understand that you're following guidance from some other
> > > > senior people on how to upstream patches so you've tried to create
> > > > the smallest patchset to ensure that it gets reviewed and accepted,
> > > > but in this case we need to see the other patches as well to decide
> > > > if your approach is the right one and we do need a separate compatible
> > string.
> > > >
> > > > If enabling GPU ipa_counters causes the clocks to get stuck active,
> > > > that feels like a hardware bug, so figuring out how to handle that
> > > > is more important than adding a compatible string.
> > > >
> > > > Either add the patch(es) that use the compatible to this series in
> > > > v2, or put a comment in the commit message on where we can see the
> > driver changes.
> > > >
> > >
> > > According to discussions with the GPU vendor, this is a hardware
> > > limitation of Mali-G310 rather than a hardware bug, and it has been
> > > addressed in newer Mali GPU families.
> > 
> > I represent the said GPU vendor and I think I know what you're talking about,
> > but you're taking the wrong approach. All G310s have a problem where in
> > order to enable access to the ipa_counters the automatic clock gating gets
> > disabled. So the solution that needs to be implemented when we add support
> > for IPA_COUNTERs will apply to all GPUs, not just MX952.
> 
> Yes. We have bring-up G310 (V2) GPU on both i.MX95 and i.MX952. And auto clock 
> gating mechanism is firstly introduced in i.MX952 (not supported on i.MX95).
> According to your update, solution needs to be implemented to all GPUs which support 
> auto clock gating mechanism after IPA_COUNTERs are supported in the driver, right?

A solution is needed, yes.

> What's your suggestions for 952 gpu dtb node?

There is no IPA_COUNTER use in Panthor at the moment. Unless your DVFS controller uses
that, I would suggest that we don't introduce a compatible for 952 until the time we
add support for reading the counters.

It helps if you think in terms of what is already in upstream, rather than mixing with
the tests that uses kbase code. Does your hardware need extra code in upstream in order
to function? If so, where is that code? If not, then let's not introduce the compatible
until we are absolutely sure we need it because we have code specific to that SoC. For
everything else we will implement an architecture fix if needed.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
