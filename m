Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A096C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9739110F01E;
	Wed, 12 Aug 2026 14:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kE32Qono";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E75C10F01E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:23:16 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so5000355e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786544595; x=1787149395; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UtdUb75BaWpEKGv7DkEH6NaI+7V5a5qgQY9Sk2+HEG4=;
 b=kE32QonoZYDGqm0f0TKkWrn65FDz3HOUL5Ng2QJNTvIH6rg5U9DngQ6jl2sv47Blx5
 z5UpAfjHjTVmODk2AjHL/KNSftp4U4VAD7KVHgmiEK5h3OvnsLbWVdGCX0MZTieE7DrB
 U+z8bKFnGDX/OBx9E2Cau3J3INj2ATc8vTe+8zAeU8Qn4iSGYkMjvFcMSvG+xEZDJZm+
 v7XRcji7rgUS5UJ9d+B3bN+QUn07XjCtZJOJ8NoYNMq/KQhKTmzaPpNPcBbGhc0jjaEa
 aCGX2qUd4uKDARFDLiV//yloBGV98K3PL4K3h7wNdnaK5NwwzjYoLlmAYWgx2X19SnNw
 wOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786544595; x=1787149395;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UtdUb75BaWpEKGv7DkEH6NaI+7V5a5qgQY9Sk2+HEG4=;
 b=M2dWO13anDw1losIgp0W7iaiJ0OPKzqJNA158GXv2Fqs46m6vgcOj3QxMJFzH7jt3O
 KwgdZiHyBJvEfkqaB40PSwiNLDQ3zo50LVVjBJGdLUxDuBrotVX/yR7E3v3SbHVlDQj2
 vcIV5ZrJTQq0axQtnvgVy2gTf2I5QKFo8L1dNzsLGdttm3dSTu+wexNgVb7SUPxzlI7I
 fALkcdYbSsmZlK57868daq/3m20+OvTj4/m5fBghN2cLWPVnmJ4sCleDLY3amtNDSb5g
 yx9fCRhPitUnJ3hWKfzG7jygjtIp34BBPU2gHoKK7lX+1NpmbJet8z+j1RyV1hcAoeGD
 qN+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqsPoYhK/e8hercxC7yEFTF+Bju0YtIZioxEdre3HDySq0np9ImXi3HzXP0tdy6WOAKQCczElbGSc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJ7/fFmD21eU5fKOPOxjsYsgVW4oQoM/szeteKWN5Iz6eWjl+v
 ODKxqa8aNRh3PyR7D+B3qQvjTbMC5l777FamYFz8Ixpl7st/ivZvnnuW
X-Gm-Gg: AR+sD132Z+UUZ9GbMVKiG8bGWzJaer370PALI1d4eIMLyxFrpYdG9TXQMHC2pT+bl+R
 rSfVX/HPrukNzosM03IGpnc/wQ5vPhJBcxAsUygwcwmLKI8es3N2bqsbJueIlA3wnJ5Z9wF4SQP
 A2NKYXHyHlsxIq9AqBkxR5OoTpvsE0lGOV2P9i0r/rKSOeW0UPmiwYB5MWR9UW0cWL7p6kCzY8F
 CA8SaYwV1Dhkme8p2TJj+OZEIhElAQPkpORLejLOaeXThbsoke43QyyYRcWZszsTc98N38JyKjK
 ClisfuGGAv6ZNZaCaUE7ObXFlKh1uKmdvgS4k8nZ4C8Mp6r1FTaMB9RY31+0wqITDnlJcG9Pn9I
 XVHRqZPu9JDxiK19JAXybU74XD7wOs5qCDI+9hFojVJTx4Sj/i+sCdsK8S4PL5nH+XBYNZ+gm5J
 nuCLMHG6IWTUuVKDRfsAqr4LLh30Ny7N7O6/oZvt4YubvxnV3RT1NTso10/P+GL2xlVZk1CkLg1
 ybIEydeem+fllMzqV+oWcc=
X-Received: by 2002:a05:600c:1f8f:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-4997bf83d13mr52851095e9.0.1786544594416; 
 Wed, 12 Aug 2026 07:23:14 -0700 (PDT)
Received: from osama ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abf94c1sm73155475e9.14.2026.08.12.07.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 07:23:10 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:23:08 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Message-ID: <anyBzAO1VSjMKhlz@osama>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
 <20260812-psychedelic-accomplished-swift-4f0081@houat>
 <DKN0ETWJ22OV.3QPJV5URU6GSY@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKN0ETWJ22OV.3QPJV5URU6GSY@bootlin.com>
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

On Wed, Aug 12, 2026 at 03:45:59PM +0200, Luca Ceresoli wrote:
> Hello,
> 
> On Wed Aug 12, 2026 at 3:26 PM CEST, Maxime Ripard wrote:
> > On Wed, Aug 12, 2026 at 03:04:18PM +0200, Osama Abdelkader wrote:
> >> Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
> >> corresponding manual detach calls from remove paths.
> >>
> >> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> >>
> >> ---
> >> v3:
> >> - Move the changelog after the `---`.
> >>
> >> v2:
> >> - break long description lines.
> >> - add Signed-off-by tag
> >>
> >>  drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c       | 8 +-------
> >>  drivers/gpu/drm/panel/panel-boe-himax8279d.c         | 8 +-------
> >>  drivers/gpu/drm/panel/panel-boe-td4320.c             | 8 +-------
> >>  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 4 +---
> >>  drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c       | 8 +-------
> >>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       | 7 +------
> >>  6 files changed, 6 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> >> index 84c21c62a43e..6a74523a6614 100644
> >> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> >> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> >> @@ -359,7 +359,7 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
> >>
> >>  	drm_panel_add(&boe->panel);
> >>
> >> -	ret = mipi_dsi_attach(dsi);
> >> +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
> >>  	if (ret < 0) {
> >>  		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
> >>  		return ret;
> >> @@ -371,12 +371,6 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
> >>  static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
> >>  {
> >>  	struct boe_bf060y8m_aj0 *boe = mipi_dsi_get_drvdata(dsi);
> >> -	int ret;
> >> -
> >> -	ret = mipi_dsi_detach(dsi);
> >> -	if (ret < 0)
> >> -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> >> -
> >>  	drm_panel_remove(&boe->panel);
> >>  }
> >
> > mipi_dsi_detach is now called after drm_panel_remove. Your commit log
> > should mention it, and explain why it's not a concern.
> 
> Indeed. Or switch from drm_panel_add() to devm_drm_panel_add(), which would
> avoid the issue mentioned by Maxime and cleanup even more the code.
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Thanks for the reviews, I updated that in v4.
Best regards,
Osama
