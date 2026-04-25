Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F333DFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 23:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DF610E203;
	Sat, 25 Apr 2026 23:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aBosJ+CP";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC4110E4F3
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 23:48:49 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A956F1544;
 Sun, 26 Apr 2026 01:47:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1777160826;
 bh=Bp8RyEnQL0UxPw7eElHX5mckH3F8+ELKhrN2JVsixec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aBosJ+CPRWpbzNhjnEakqNIWx8v6lvj20KVcTdhjJHN+Ndm/UNWPtYyXx6WQQbise
 L8hXN5SGvJ/awHLT9vgqFhYtYGLwhcvKW6IpH+xHcG2egbT8THwrLcbcNhFYgXfQdc
 j4ji2Tag7R41Gax3AEIZ/M90dRFcVrQECrMOoRD0=
Date: Sun, 26 Apr 2026 02:48:45 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dennis Gilmore <dennis@ausil.us>, Heiko Stuebner <heiko@sntech.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alexey Charkov <alchark@gmail.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] drm/bridge: simple: Add the Lontium LT8711UXD
 DP-to-HDMI bridge
Message-ID: <20260425234845.GC2964234@killaraus.ideasonboard.com>
References: <20260425031011.2529364-1-dennis@ausil.us>
 <20260425031011.2529364-4-dennis@ausil.us>
 <20260425112844.GB2964234@killaraus.ideasonboard.com>
 <45evt7lkzuykoqsc2z27hsvm7fasmn6sr6gbjtdnme54jauehf@dmvon2o5emzd>
 <CAABkxwt1=n=CnrVfCcw+EHjqjfsLkp67POk451fV8Gqw4vdnQw@mail.gmail.com>
 <ur7mow4lw47ylxj3uigwwasrfywe6n42zb2to7ygeyjlkcgfkf@guzkembyy5hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ur7mow4lw47ylxj3uigwwasrfywe6n42zb2to7ygeyjlkcgfkf@guzkembyy5hc>
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

On Sun, Apr 26, 2026 at 12:44:59AM +0300, Dmitry Baryshkov wrote:
> On Sat, Apr 25, 2026 at 01:10:02PM -0500, Dennis Gilmore wrote:
> > On Sat, Apr 25, 2026 at 9:24 AM Dmitry Baryshkov wrote:
> > > On Sat, Apr 25, 2026 at 02:28:44PM +0300, Laurent Pinchart wrote:
> > > > Hi Dennis,
> > > >
> > > > Thank you for the patch.
> > > >
> > > > On Fri, Apr 24, 2026 at 10:10:08PM -0500, Dennis Gilmore wrote:
> > > > > The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4
> > > > > to HDMI2.0 converter, designed to connect a USB Type-C source or
> > > > > a DP1.4 source to an HDMI2.0 sink.
> > > >
> > > > As far as I can tell, the LT8711UXD has an I2C control interface.
> > > > Shouldn't it be an I2C device ?
> > >
> > > From the datasheet:
> > >
> > > The device is capable of automatic operation which is
> > > enabled by an integrated microprocessor that uses an
> > > embedded SPI flash for firmware storage. System control
> > > is also available through the use of a dedicated
> > > configuration I2C slave interface.
> > >
> > > My guess was that it can either be an I2C device or it can function as a
> > > simple platdev with no I2C controls. Please correct me if my
> > > understanding was wrong.
> > >
> > > But now looking at the schematics, it seems to be connected to I2C6.
> > > Which means that it should be desribed (and bound) as such.
> > 
> > Hi Dmitry and Laurent,
> > 
> > While the schematic shows that it can use I2C and has been wired up,
> > it also shows that both MODE_SEL and I2C_ADDR have unpopulated 10k
> > resistors; as a result, MODE_SEL is connected directly to GND, putting
> > the bridge in autonomous mode. I confirmed this by running `i2cdetect
> > -r -y 6`, with the only device on the bus being the HYM8563 RTC at
> > 0x51. Without reworking the board, the device is not directly
> > controllable and just runs autonomously.
> 
> I think it would be nice to mention:
> - In the commit for the bindings, that the device can be running
>   uncontrolled or it can be attached over I2C, bindings describe the
>   uncontrolled mode.
> - In this commit message, the same.
> - In the commit message for the board DT mention your findings about the
>   board, mention soldering R9 or R17 (which one?) and R27.

Additionally, how are we going to handle boards where the device
operates in I2C mode ? Will we use a different compatible string (maybe
"lontium,lt8711uxd-i2c") ? If DT maintainers are fine with that, I have
no objection to this patch.

> > > > > Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> > > > > index 8aa31ca3c72d..42c1f3d5ba0c 100644
> > > > > --- a/drivers/gpu/drm/bridge/simple-bridge.c
> > > > > +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> > > > > @@ -270,6 +270,11 @@ static const struct of_device_id simple_bridge_match[] = {
> > > > >             .data = &(const struct simple_bridge_info) {
> > > > >                     .connector_type = DRM_MODE_CONNECTOR_HDMIA,
> > > > >             },
> > > > > +   }, {
> > > > > +           .compatible = "lontium,lt8711uxd",
> > > > > +           .data = &(const struct simple_bridge_info) {
> > > > > +                   .connector_type = DRM_MODE_CONNECTOR_HDMIA,
> > > > > +           },
> > > > >     }, {
> > > > >             .compatible = "parade,ps185hdm",
> > > > >             .data = &(const struct simple_bridge_info) {

-- 
Regards,

Laurent Pinchart
