Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2667CD6E4A
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 08:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CAF11272C;
	Sat, 30 May 2026 08:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="li6VMNQ9";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA52811272C
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 08:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=k/4+sIfuD76gWiDJ7nlP7yp+chsnq/e4G6cSrxRXb34=; b=li6VMNQ9j3X0aS8gzad66Vf85n
 8/9sFXKfM76buhkjJBOIvU0spfJaPwxEQUcqd8BftHwP91s9GCME8eMvIzfI1Lt7r6nVpGdJ66iDe
 VQTczp+bu7b352vyRfxxRAp4qdDh1wEq2wLuoHcvIga9jC3sksErq5izvrriZqDSl9brKNl4UWxyt
 e4kWlsI3k0t47p++uIbrAFVcmMnAZs9j53J0uBkhrOQvP/WkZM5nFHsOquL06wjsg1Ll+F2LS//0E
 yGcPsxFcZfeb6cLSnWr4JXFeq7oS4WXUwE52A8qnKm4dcZYOt/IPv8Gzgqj/iSfhsajHJreq/ePK8
 X3+uTXlg==;
Date: Sat, 30 May 2026 10:00:48 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, u.kleine-koenig@pengutronix.de,
 arnd@arndb.de, laurent.pinchart@ideasonboard.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tony
 Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Sebastian Reichel
 <sre@kernel.org>
Subject: Re: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Message-ID: <20260530100048.7dd1b3e1@kemnade.info>
In-Reply-To: <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
References: <20230913065911.1551166-1-andreas@kemnade.info>
 <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 13 Sep 2023 15:11:08 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> On 13/09/2023 09:59, Andreas Kemnade wrote:
> > Some 3.0 source has it set behind a if (omap4).
> > Maybe it is helpful maybe not, at least in the omap4460
> > trm these bits are marked as reserved.
> > But maybe some dsi video mode panel starts magically working.  
> 
> Sorry, what does this mean? That this fixes something, or you are just 
> guessing?
> 
> I'm somewhat sure that the upstream driver used to work on omap4 sdp, 
> which has two DSI panels. But I can't even remember what omap4 version 
> it had.
> 

this thing is definitively not needed. I have dropped this patch from
my tree.

Regards,
Andreas

>   Tomi
> 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > index 60189a23506a1..e2f576cd9f63c 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > @@ -4505,7 +4505,7 @@ static const struct dss_pll_hw dss_omap4_dsi_pll_hw = {
> >   	.has_stopmode = true,
> >   	.has_freqsel = false,
> >   	.has_selfreqdco = false,
> > -	.has_refsel = false,
> > +	.has_refsel = true,
> >   };
> >   
> >   static const struct dss_pll_hw dss_omap5_dsi_pll_hw = {  
> 
> 

