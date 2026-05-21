Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D300CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B410C10E4FD;
	Thu, 21 May 2026 16:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="s7PzemUL";
	dkim-atps=neutral
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A8010E4FD
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=default;
 h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
 To:From:Date:subject:date:message-id:reply-to;
 bh=j9BWViu2SpWt7Rj6XMWPmrgjG6rA+onWCpewnCfYlnQ=; b=s7PzemULtOwfVJPGZe380o8FCH
 Ox3Fin9xFVsNn6I2c2+c/byyh8SKz+3aGFTyvtsoGgz8uOjibUR9Vvtrxznxc2vCikoRLnqP0+c9l
 baw9lqMUwBVYAxoDJErmQsJwFhgkBcSblolqdS6T9j77woqnmIzPP00yIL8GRmkEZLp8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.98.2)
 (envelope-from <hugo@hugovil.com>) id 1wQ6Be-000000003xE-2ZGi;
 Thu, 21 May 2026 12:23:54 -0400
Date: Thu, 21 May 2026 12:23:53 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: krzk@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, Frank.Li@nxp.com, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org,
 laurent.pinchart+renesas@ideasonboard.com, antonin.godard@bootlin.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 14/15] dt-bindings: display/lvds-codec: add
 ti,sn65lvds93
Message-Id: <20260521122353.82651a97984e58d2ec8309c5@hugovil.com>
In-Reply-To: <20260511114406.24673c770d112b2ca4aba2eb@hugovil.com>
References: <20260305180651.1827087-1-hugo@hugovil.com>
 <20260305180651.1827087-15-hugo@hugovil.com>
 <20260511114406.24673c770d112b2ca4aba2eb@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --
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

On Mon, 11 May 2026 11:44:06 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> Hi,
> 
> On Thu,  5 Mar 2026 13:06:29 -0500
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add compatible string for TI SN65LVDS93. Similar to
> > SN65LVDS83 but with an industrial temperature range.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Now that this series landed in linux-next/master, except for this
> patch, we now have an error since it is required:
> 
> https://lore.kernel.org/oe-kbuild-all/202605071909.lXKPelNA-lkp@intel.com/

Hi DT folks,
wondering if someone could pick/apply this patch to fix the build error?

Hugo.


> > ---
> >  Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> > index 4f52e35d02537..f2cb74b86cc05 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> > @@ -37,6 +37,7 @@ properties:
> >                - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
> >                - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
> >                - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitter
> > +              - ti,sn75lvds93 # For the TI SN75LVDS93 FlatLink transmitter
> >            - const: lvds-encoder # Generic LVDS encoder compatible fallback
> >        - items:
> >            - enum:
> > -- 
> > 2.47.3
> > 
> > 
> 
> 
> Hugo Villeneuve <hugo@hugovil.com>


-- 
Hugo Villeneuve
