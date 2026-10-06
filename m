Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36967CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC2F10F2EF;
	Tue,  6 Oct 2026 13:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="iPe/dLYf";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F24210E32B
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791293889; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ctIWeVt6Bo1DSvLZW9bcj3koiiOjn/pk97R7w73/ImEmZlmSD1g4IjRmsnQi6ADrCRQfO2sboCxg9o+SvvJrs1tbYO9TdLHopC+cw8pq3nbIMPO6xsbPXVKxV9JM0vX/fM5sQH9piqDvtvZwlqyC6M5IaphdOps6wEntjb8AkaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791293889;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VxANVvaudC9ucdAgKK1Ve2w93u03mD0/qfWlUqbCtCo=; 
 b=k7uEv4XxZI7LOm6Dl4URLVIpeOzXFQthaBGjf6mB0Kp7YRPbmPilsl8t3OMFj5NTCXGpqUGXpKtunlrmR9acOK2/wPwoAo8UYNYvwe2wBgnKc/9tn8j9YO3/X1KzZXLChDYatH3moo+y4clXYKsTlnJMIlhqCQ0y9OO6mvAEq5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791293889; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=VxANVvaudC9ucdAgKK1Ve2w93u03mD0/qfWlUqbCtCo=;
 b=iPe/dLYfSxIrdSGL1c+9/uyD1t4BmGMcf16vZbbgQzeXE+Td9zENZrZ7anKC1Bpn
 KpZyryv1KNUXfu32RJErpCgbfYACzZC7FtfnU/yns7Vt229+lYarGJO8+w/YYbzs5rl
 7QkQvVft9jc063MIq6pz/zCuxK82mSl95hi15huk=
Received: by smtp.zohomail.com with SMTPS id 1791293887679226.9185627884126;
 Tue, 6 Oct 2026 06:38:07 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 10/15] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <1930451a-97e7-4029-91b4-45989e954d7a@arm.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-10-62beb08de207@collabora.com>
 <1930451a-97e7-4029-91b4-45989e954d7a@arm.com>
Date: Tue, 06 Oct 2026 14:38:02 +0100
Message-Id: <179129388241.1018806.5773521934450351426.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=PDKCA2LqDdwF75BRjCYuu/t8MaYkMS6lP/2EM+xeVV0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxPm6DovXbI5ZpmdK2vim4PJNQas5ZU7DY6iND
 x0013jaf8iJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasT5ugAKCRAOJn5M7lND
 PRIxC/4hmPoz8MGU4IVr5nNMT/V8sHBIHuWf1KTg8QfEzlyh0l7rEKICS8MCyPoLD6pYUnCHn2h
 OEDtvrjT8UbOZa/vY37iec+onmLrLD98g2mh3HS3o+MH9fZ0Jf7SN7Dd75NP5ftZ2eP31vNvORg
 iz+NEyGwgkOx+xaJwfrhWrVyWW7DUfOncHNsa9t1Ud0N8xXWcQWRcWPSuTdYDNpWtptzmdJ0gpp
 TBRKfF4Vyb6O31QvkzJc1q00sZIOgarFAtIYNKnBBROP1kxItcOvi6LM98Y4h2wSz6UOvK4QRwS
 wRZsf5G8IeM8DuMJlwYqKC30WmRgzO7vOmpyRdUGkkFNmmuTnxXLEqZyUUUqixca1bgyN1oxtgy
 VLL/kSsaDf9NVzx8CMJCzQ/AAdO3JgAirhS038bHg0ut5KgH7tiuYNk79HRforFjIr+MNg9IWOO
 a75l96yI4X9pmbuCniSKMWnx7fkgKko3G3XzA57YEeC+KKSAoKMSo4ywE6bgVfdVO8nmM=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-10-02 16:10:43+01:00, Steven Price wrote:
> On 29/09/2026 04:44, Adrián Larumbe wrote:
> 
> > This will be of great help when testing potential races between the GPU
> > reset sequence and other parts of the code accessing HW registers.
> > 
> > We must also disable the reset work item rather than simply cancelling
> > it, to prevent the knob from triggering another reset when the device
> > is being removed.
> > 
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 42 ++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/panfrost/panfrost_job.c    |  2 +-
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 09a5752a3f40..94d2de341838 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
> >  /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
> >  
> > +#include <linux/debugfs.h>
> >  #include <linux/clk.h>
> >  #include <linux/reset.h>
> >  #include <linux/platform_device.h>
> > @@ -595,9 +596,50 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
> >  };
> >  
> >  #ifdef CONFIG_DEBUG_FS
> > +static int reset_get(void *data, u64 *val)
> > +{
> > +	struct panfrost_device *pfdev =
> > +		container_of(data, struct panfrost_device, base);
> > +
> > +	*val = atomic_read(&pfdev->reset.pending);
> > +	return 0;
> > +}
> > +
> > +static int reset_set(void *data, u64 val)
> > +{
> > +	struct panfrost_device *pfdev =
> > +		container_of(data, struct panfrost_device, base);
> > +	int ret = pm_runtime_get_if_active(pfdev->base.dev);
> > +
> > +	if (!ret)
> > +		return 0;
> > +
> > +	panfrost_device_schedule_reset(pfdev);
> > +	flush_work(&pfdev->reset.work);
> > +
> > +	/* ret < 0 means runtime PM for the device is disabled, so we
> > +	 * only need to return the PM reference in the opposite case
> > +	 */
> > +	if (ret > 0)
> > +		pm_runtime_put(pfdev->base.dev);
> > +
> > +	return 0;
> > +}
> 
> NIT: If this wasn't debugfs I'd be complaining that you're ignoring
> 'val' and so this isn't very extensible. But hey, it's debugfs... so:
> 
> Reviewed-by: Steven Price <steven.price@arm.com>

I looked into the available debugfs attribute definition macros and none of them provide
a wrapper that avoid passing the input value when the attribute is to be understood as
an action rather than a device property. My understanding is that because debugfs doesn't
become part of the device's uAPI, we can do pretty much whatever we want with it.
However, on a second thought, maybe in the future we'll want to extend the knob so that
it performs resets in different ways, and would want to keep backwards compatibility with
UM binaries that expect certain input values to stand for specific actions.

I'll change it so that all value other than '1' are returned with -EINVAL.


