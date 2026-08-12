Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B849C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B3E10EFBF;
	Wed, 12 Aug 2026 13:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jIxkLAfx";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7215A10EFC8
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:06:57 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so4422345e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786540016; x=1787144816; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=teFT6NRTXr4zIRuGi3t1INSLzXK+rPxsyQcQYNZ+t2Q=;
 b=jIxkLAfxpI6cOTjMPJGwKmQJBreElZOmGnWoSYNDucCUYRbKkyICtoUfOHkVMfGaT1
 edp1juClISb/iXefJeWlDioNOnDMgIjU8iT9OrpITeOf4ELx9Q2X549q10GuOZGKB2l/
 B2t6sxrQkAOxNEb97odkUPArtw7ZLqJ2s7gXH+dnmGwrI3OdepAw/r2rKaW1DelnSyRJ
 pNR3MlYqeo9bTV/YDzepa0sfD855ZhfAM37+y4tHIiiyyI1viJk7iRO8BIrmR5T928s1
 j2hB9Fa1eGZL4JAnz33c35WFHlgtV2omKbS5Ry/juxHK5v4D0gENk10DqUsbwam9bIab
 dezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540016; x=1787144816;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=teFT6NRTXr4zIRuGi3t1INSLzXK+rPxsyQcQYNZ+t2Q=;
 b=NqfnVzTwXo3Eg6AXvtSKwKUMUkkBdetFpIpQMUXwG2ZUIkJd2PncrsAuYPkiATK0+q
 Iz9ZA8gPZRMBc9VD0b4y3Xu9XgH7KzWINFMeNRIdB0Vn9gdEtYa0CCttWfb4J1VRcg9Q
 Xo7Uvr0WuS8ZGmpHFPIEvhVuge8+fbFDNdPZGVp4DuRMWH9BuhLkxlGAkKljEVjy/NXW
 xQ8Vh6/8pC+v+0e9dRFaf0XSjmkIL0SApDYDR1GuC9Pggw6McKJbiR7XxgjkIOpAIsf8
 kVkRa5J1IvLYc3JcgZS2FT3Twe+fyrjGiv+RFDobe57hoT74YBt9LY6NtK2cn7rtQ7uw
 O7HA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqhx2ej/yo7V4Ofw26ahzsQTNDBJTSiDXTqeel8OOSnhVry57p7SOYVDB701aXiZSVcKQSsE41BTy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRX5s1WU1W2cmy/gWSDGy2UZbGbWIIxAIPYbQLJ1br1ATrlt8E
 H9evyqHSHIfbae8WuGnAN66SJzglc2DjVq70Kh3cb66OYlt3ETBW6ILa
X-Gm-Gg: AR+sD12Iuia8/hnFG7zQXShBuzCHe9SSgGnzW4s7wxIhvfbuyiGLDzolelvJIUHVL73
 yg0k2V44GFdUTFvdq9f8kDME6OxrSmZsNTeXC2CBQ9i5MzVbEB0zSy+E29eNzC+sUQKzrpeXNNd
 h1MPVaaTGUP/b2eibY0vz0k212UwRHMwvPvO2rbhX/z/bIQSN8havX1nvZpZEPxf2C9drSmBph9
 2EazugYdFImD3Dxn8Q1rN+H+9HUCaDS/tTAk6IlRvDy7otjAfKxvzQ/KvD+2xmqVMdyPIhJW782
 SD0ZWaSJ0oaYK9yM3r7xWlrP+rIkqUgLOgYBSryvT+Uz6HjRDXN3NXSe5ovW+dxlgwmaEXs7igp
 HOAocxoApG7Xi2J8Bi9Z652MGAh7t64oUqmYpbiFiO6/3M1Ya5irzwZNhVytIW8st3LHIvt4gNi
 fN5wS5Jb7VeirneuwkIfk6OKxCitFed+JrU0tk79Ylmhbn9fBV6NYtvYNHikDHzEaDJI8puGakL
 rHqB6EtnqdPVaX1mIk3GNxSpugJFrZF+w==
X-Received: by 2002:a05:600c:3b20:b0:493:f318:3bc6 with SMTP id
 5b1f17b1804b1-4997c15729cmr62919945e9.13.1786540015739; 
 Wed, 12 Aug 2026 06:06:55 -0700 (PDT)
Received: from osama ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm38582755e9.3.2026.08.12.06.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:06:55 -0700 (PDT)
Date: Wed, 12 Aug 2026 15:06:53 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: luca.ceresoli@bootlin.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Message-ID: <anxv7W4RsTh8BCcj@osama>
References: <20260811165037.12437-1-osama.abdelkader@gmail.com>
 <0510ced7-7c91-4b00-bc7f-773a9b6517eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0510ced7-7c91-4b00-bc7f-773a9b6517eb@linaro.org>
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

On Wed, Aug 12, 2026 at 01:50:31PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 8/11/26 18:50, Osama Abdelkader wrote:
> > Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
> > corresponding manual detach calls from remove paths.
> > 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > 
> > v2:
> > - break long description lines.
> > - add Signed-off-by tag
> 
> Please move the changelog after the ---, or use a tool like b4 to handle that
> automatically.
> 
> > ---
> >   drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c       | 8 +-------
> >   drivers/gpu/drm/panel/panel-boe-himax8279d.c         | 8 +-------
> >   drivers/gpu/drm/panel/panel-boe-td4320.c             | 8 +-------
> >   drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 4 +---
> >   drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c       | 8 +-------
> >   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       | 7 +------
> >   6 files changed, 6 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> > index 84c21c62a43e..6a74523a6614 100644
> > --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> > +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> > @@ -359,7 +359,7 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
> >   	drm_panel_add(&boe->panel);
> > -	ret = mipi_dsi_attach(dsi);
> > +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
> >   	if (ret < 0) {
> >   		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
> >   		return ret;
> > @@ -371,12 +371,6 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
> >   static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
> >   {
> >   	struct boe_bf060y8m_aj0 *boe = mipi_dsi_get_drvdata(dsi);
> > -	int ret;
> > -
> > -	ret = mipi_dsi_detach(dsi);
> > -	if (ret < 0)
> > -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> > -
> >   	drm_panel_remove(&boe->panel);
> >   }
> > diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> > index 4a8560b4b899..ffcb63f65b75 100644
> > --- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> > +++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> > @@ -881,7 +881,7 @@ static int panel_probe(struct mipi_dsi_device *dsi)
> >   	if (err < 0)
> >   		return err;
> > -	err = mipi_dsi_attach(dsi);
> > +	err = devm_mipi_dsi_attach(&dsi->dev, dsi);
> >   	if (err < 0)
> >   		drm_panel_remove(&pinfo->base);
> > @@ -891,12 +891,6 @@ static int panel_probe(struct mipi_dsi_device *dsi)
> >   static void panel_remove(struct mipi_dsi_device *dsi)
> >   {
> >   	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
> > -	int err;
> > -
> > -	err = mipi_dsi_detach(dsi);
> > -	if (err < 0)
> > -		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
> > -
> >   	drm_panel_remove(&pinfo->base);
> >   }
> > diff --git a/drivers/gpu/drm/panel/panel-boe-td4320.c b/drivers/gpu/drm/panel/panel-boe-td4320.c
> > index 23558a76dd72..704d5a9c13e7 100644
> > --- a/drivers/gpu/drm/panel/panel-boe-td4320.c
> > +++ b/drivers/gpu/drm/panel/panel-boe-td4320.c
> > @@ -204,7 +204,7 @@ static int boe_td4320_probe(struct mipi_dsi_device *dsi)
> >   	drm_panel_add(&ctx->panel);
> > -	ret = mipi_dsi_attach(dsi);
> > +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
> >   	if (ret < 0) {
> >   		drm_panel_remove(&ctx->panel);
> >   		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> > @@ -216,12 +216,6 @@ static int boe_td4320_probe(struct mipi_dsi_device *dsi)
> >   static void boe_td4320_remove(struct mipi_dsi_device *dsi)
> >   {
> >   	struct boe_td4320 *ctx = mipi_dsi_get_drvdata(dsi);
> > -	int ret;
> > -
> > -	ret = mipi_dsi_detach(dsi);
> > -	if (ret < 0)
> > -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> > -
> >   	drm_panel_remove(&ctx->panel);
> >   }
> > diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > index a70a2e58f88c..94cc675973e6 100644
> > --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > @@ -393,7 +393,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
> >   	drm_panel_add(&ctx->panel);
> > -	ret = mipi_dsi_attach(dsi);
> > +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
> >   	if (ret < 0) {
> >   		dev_err_probe(&dsi->dev, ret,
> >   			      "Failed to attach panel to DSI host\n");
> > @@ -407,8 +407,6 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
> >   static void boe_th101mb31ig002_dsi_remove(struct mipi_dsi_device *dsi)
> >   {
> >   	struct boe_th101mb31ig002 *ctx = mipi_dsi_get_drvdata(dsi);
> > -
> > -	mipi_dsi_detach(dsi);
> >   	drm_panel_remove(&ctx->panel);
> >   }
> > diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
> > index 20b6e11a7d84..2ab7764d4094 100644
> > --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
> > +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
> > @@ -200,7 +200,7 @@ static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
> >   	drm_panel_add(&ctx->panel);
> > -	ret = mipi_dsi_attach(dsi);
> > +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
> >   	if (ret < 0) {
> >   		drm_panel_remove(&ctx->panel);
> >   		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> > @@ -212,12 +212,6 @@ static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
> >   static void boe_tv101wum_ll2_remove(struct mipi_dsi_device *dsi)
> >   {
> >   	struct boe_tv101wum_ll2 *ctx = mipi_dsi_get_drvdata(dsi);
> > -	int ret;
> > -
> > -	ret = mipi_dsi_detach(dsi);
> > -	if (ret < 0)
> > -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> > -
> >   	drm_panel_remove(&ctx->panel);
> >   }
> > diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> > index 150dff3ab6c3..7d2672578dd8 100644
> > --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> > +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> > @@ -1765,7 +1765,7 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
> >   	mipi_dsi_set_drvdata(dsi, boe);
> > -	ret = mipi_dsi_attach(dsi);
> > +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
> >   	if (ret)
> >   		drm_panel_remove(&boe->base);
> > @@ -1775,11 +1775,6 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
> >   static void boe_panel_remove(struct mipi_dsi_device *dsi)
> >   {
> >   	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
> > -	int ret;
> > -
> > -	ret = mipi_dsi_detach(dsi);
> > -	if (ret < 0)
> > -		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> >   	if (boe->base.dev)
> >   		drm_panel_remove(&boe->base);
> 
> Otherwise looks good.
> 
> Thanks,
> Neil

Hi Neil,

Thanks for the review, I just sent v3 for that.

Thanks,
Osama
