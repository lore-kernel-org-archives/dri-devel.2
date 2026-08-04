Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4527C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053F010E66B;
	Tue,  4 Aug 2026 08:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="rHYzLNDx";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6494010E66B
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=HRi0gm+XpSKB831vpOi9E9TsWihIpz8NrkoFDy5ME2Q=; t=1785833354; x=1787042954; 
 b=rHYzLNDxasblgIy7oC1zB23ntD9yOBn7UK+OupATMOs7a4qIRrC5zt1UGqhLyLouKr0f6XVY1SG
 Q7VyDKVdrbv9zYMibH4zwmCIxS2vpzfmN83ifZ11l0yHITkv3GggwPvkWo7txj6DzZhwLFYKmwOj3
 MiHSiAg3vxZwKBR4bbOwN2q6tNz0OgeZOHQr3cr8m3UwBUn12r70XjN776qWXqWkrzWoqgqEHu6h5
 TxeuUl2pi1Xu1a42yf3N530oGiv4fdslL5KDIVaHObOdyFKZUfmt8Wpr3jE/oKeX8QYf7BgnVRmpj
 o5oy84wP8Mws7iluR3SdNN4GsQhVjI2MU79w==;
Date: Tue, 4 Aug 2026 10:49:08 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tomi
 Valkeinen <tomi.valkeinen@ti.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2] drm/omap: dsi: do not copy isr table
Message-ID: <20260804104908.46937116@kemnade.info>
In-Reply-To: <d8d897b2-9108-4286-9859-54edcc2a8259@ideasonboard.com>
References: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
 <d8d897b2-9108-4286-9859-54edcc2a8259@ideasonboard.com>
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

On Wed, 29 Jul 2026 11:23:21 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Hi,
> 
> On 02/07/2026 18:27, Andreas Kemnade wrote:
> > To te able to unregister stuff from isrs, the corresponding table was
> > copied.  Nobody seems to unregister stuff that way, so it does not help.
> > But there are stack-allocated objects passed to these isrs giving chances
> > of UAF of these objects if irqs are unregistered while they are handled,
> > so better do not copy that table.
> > 
> > Fixes: 4ae2ddddf44cd ("OMAP: DSS2: DSI: Add ISR support")
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > If this gets backported, it should be re-checked that
> > no isr unregisters itself in older kernel versions`.
> > ---
> > Changes in v2:
> > - remove variable definition (Sashiko)
> > - Link to v1: https://patch.msgid.link/20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info  
> 
> Looks good to me, applying to drm-misc-next.
> 
It seems not to be on linux-next. somehow this did fall through the cracks?

Regards,
Andreas
