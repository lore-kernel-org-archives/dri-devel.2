Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A85C44539
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056B910EB9C;
	Tue, 21 Jul 2026 22:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="RVqn67G7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bh+Hqcw";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21A010E34C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:43:52 +0000 (UTC)
Date: Tue, 21 Jul 2026 15:43:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1784641430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSxdxXIt1908WxxV+0JYrAx1/H/jAX98PXijkclkVos=;
 b=RVqn67G7dpS+KxmlGYZk8EFL4TT7NrdIGgQgbXaTxqv6k/iZJGhh6ADS4nkY8r/FAqwqfy
 W8RZDeoPICqavufKUHGSiMvg7W+ggNg9UKKoSEKOidbETBDVAHwyk3gL5D/gHt+3kDa2cS
 NkBbjG2HzPxbaflUd6s1MPnhN6iTvdGaGSRf5a6UrpP33gnp1vn+kgxUx05JA/+8pNHUme
 P9XfKR/ilOMT2YxksLkF3KxNDmqb2+SpjNQo0dGDPujBqaIzk79K6t6isgfZhm9gx+XDF+
 VOp+kUYMyfYwUSma4gWPNEX1eEACptK1Se652h+puli9aQWW4EWciVrDnnYfXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1784641430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSxdxXIt1908WxxV+0JYrAx1/H/jAX98PXijkclkVos=;
 b=0bh+Hqcwd2XcpK91Oou08Q+mbXBAfY3a4510jizlEP4UVYV5U/PmwK6WvELy3/4bF1jkZ9
 5y+68Cefe+ZuOKDA==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: hvs/v3d: Fix null dereference in unbind
Message-ID: <cthbezi5wyphyxqvbae22y5ktd5hefuos53v7sirclvhm6z2yv@dp3xibrbgoij>
References: <20260720-rpi-vc4-fix-v1-1-6073a96a5773@linutronix.de>
 <b1a84b2e-1f34-469f-898c-1dfb76efe2df@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1a84b2e-1f34-469f-898c-1dfb76efe2df@igalia.com>
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

On Tue, Jul 21, 2026 at 09:28:51AM -0300, Maíra Canal wrote:
> Hi Gregor,
> 
> On 20/07/26 14:20, Gregor Herburger wrote:
> > The hvs and v3d drivers use dev_get_drvdata(master) in their unbind
> > functions. Since the vc4-drm gets removed before its dependent drivers
> > (vc4_hvs/vc4_v3d) the vc4_hvs_unbind/vc4_v3d_unbind functions try to
> > get drvdata of its master and fails with a null dereference error.
> > 
> > Use the data pointer passed to the unbind functions directly instead of
> > dev_get_drvdata(master). This avoids using potentially freed memory.
> > 
> 
> Shouldn't this patch have a "Fixes:" tag?
Right, will send a v2 with Fixes tags. 
> 
> Best regards,
> - Maíra
> 
> > Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> > ---
> >   drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
> >   drivers/gpu/drm/vc4/vc4_v3d.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> > index 184d51ea3fa5..e715147d091c 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> > @@ -1752,7 +1752,7 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
> >   static void vc4_hvs_unbind(struct device *dev, struct device *master,
> >   			   void *data)
> >   {
> > -	struct drm_device *drm = dev_get_drvdata(master);
> > +	struct drm_device *drm = data;
> >   	struct vc4_dev *vc4 = to_vc4_dev(drm);
> >   	struct vc4_hvs *hvs = vc4->hvs;
> >   	struct drm_mm_node *node, *next;
> > diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> > index d31b906cb8e7..f32410420d3e 100644
> > --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> > +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> > @@ -494,7 +494,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
> >   static void vc4_v3d_unbind(struct device *dev, struct device *master,
> >   			   void *data)
> >   {
> > -	struct drm_device *drm = dev_get_drvdata(master);
> > +	struct drm_device *drm = data;
> >   	struct vc4_dev *vc4 = to_vc4_dev(drm);
> >   	vc4_irq_uninstall(drm);
> > 
> > ---
> > base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
> > change-id: 20260715-rpi-vc4-fix-d93513b05425
> > 
> > Best regards,
> > --
> > Gregor Herburger <gregor.herburger@linutronix.de>
> > 
> 

-- 
Gregor Herburger
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 35; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy 
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen | 
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700 
806 | Geschäftsführer (Managing Directors): Dr. Wilfried Wessner, 
Katharina Kopp, Alexander Gieringer
