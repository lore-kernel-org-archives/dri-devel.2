Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC8FC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A73A10E343;
	Tue, 11 Aug 2026 14:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nAOHCnsN";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55F810E336
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:32:32 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso50142045e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458751; x=1787063551; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYlCOewNL3l2HhIwDF9AzVHy9ppLOSojfQ0hX+V1OZk=;
 b=nAOHCnsN6+Db5ScCkby/HxF7plVC0ra1v9VQ7pg1a20i5lul277DBJRt5EIFKgU3K2
 Ne4SC4nYdJIEEsEkryDGKO17Oll9WcAd6JkLe4PqnElDDzxSt5wJeMZZWaxvAOu8Jt8y
 5sxgoO8etfbxiNSqgqw+1dQ0H4D4GU3gzvE8hfQFyEXmFJ6HCeHN+6oZeRWoegiqpvUi
 rY8khdRscay35uXtIIgfH+Wz4A2wDeFzGlzCwwFoJFDqnr+I6STPSQihl3BsCzHSrMGt
 YWsrOyjWRevCYUnajLk2mEC2RJvF8R7RE+jKTvnM70fYpB2sjm2H3WAL3ze+gaUCLuON
 M3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458751; x=1787063551;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HYlCOewNL3l2HhIwDF9AzVHy9ppLOSojfQ0hX+V1OZk=;
 b=MexM9G809jvDcAup7T0+kXXQAnq/c5xIjDfy5jz34hhhu/3TfQ3AnKJKR8m8SOOA6j
 VsIoHymagrDR4wqdyfNaYA97pJEk9CmuREL9uds5leCPLUeghTqlyatKyh+P9V0gZ4/+
 ALa085zFTWCV8RomAUdbeeTg8+Br1FyisYH0B+V5pTwZmOmqI9CNq28utmCv5NKdJOp7
 egeTL+5hacO0nDtkmoyrHVCWq0U1s/xO1pWICa+JSLV2uUK/4bKLkcpuU5MeH57EMrMF
 KOlLLLBv6g0viDN8s+/oWNRW47xIbvRle/wD8bBA5LDZ0SLh9AqIT1SPS9ObIJ9KrMzI
 ox6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RomhltGJ1UWlVVnPNd9bCunkWWjW0esKzC0OB3Bx25h/WM74yJ6tAHZIBmtAE9FIHNZu2VslQd5tJY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSTsayNcSELZQuRTk4gt4ro/yzHXmc7DgvZTDQkU6yuITvwY+6
 6xIhlazAy57PhsaaVJEJnm3oY0hk/yCf7Nf0WTgzcmjQdoP5LT5aUz80
X-Gm-Gg: AR+sD11gsZXX4VPztI8umRDYiOOlMOua9JPFnfP5R6q8g8C27zMB3QX112ZLsHcUrcL
 fWU+G9y/EmXYzGstcw54+p5AX3nrIxlr8yaeJLShpSPdXBrmBiXHlpew9ghfhl4x7PoBhwDhu1o
 x43SdLU6b05xLU5yNwG3KkqCKKSItHnuIgArLE0exU6bHpGgjNk5tgdIhFuaQPw+DmVIFcXozRT
 eA2QSytKtGr9cQe1Tne+TQZe9miIIgtKgNSPvA9/2ZVHmzPOpJoxPn3PyiexWUB/AEOUvlS86Jv
 bEWeFR/MtDIL+S9PbDsU/0Vx/dn3d8dcolWyXjmLEypvcTDG18Paa3dCRT/FMO2irVB6wHXKeuX
 MZRSZmZxM4Jh/Uffi3h/mUIicc8NeXnQTXDCwAydNpL9Hv9YJCDZYeAUkoZmca0XIiz777OT3Xl
 9Fq2HrISTfTDSPIPY6LgYD9+T0oFy8Rlp6iIka/fxAzvugn4jnUqKIxWwEWStu32d0Q7wpd18KZ
 V62/CJYiBWxW/U8q7RBVQ==
X-Received: by 2002:a05:600c:8b4c:b0:499:593c:3384 with SMTP id
 5b1f17b1804b1-49978434835mr60014535e9.6.1786458750690; 
 Tue, 11 Aug 2026 07:32:30 -0700 (PDT)
Received: from osama ([2a02:908:185:7e40:b0cf:778:ae86:13b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788fd9a4sm62325695e9.12.2026.08.11.07.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:32:30 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:32:28 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: chipone-icn6211: use devm_mipi_dsi_attach
Message-ID: <ansyfFn0yhem0z0v@osama>
References: <20260521212529.151493-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521212529.151493-1-osama.abdelkader@gmail.com>
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

On Thu, May 21, 2026 at 11:25:28PM +0200, Osama Abdelkader wrote:
> Follow up on the previous devm_drm_bridge_add() conversion by
> converting the remaining manual cleanup in chipone-icn6211 to the
> managed helper.
> 
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/bridge/chipone-icn6211.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> index e5957917ad88..d51d770060b6 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -531,7 +531,7 @@ static int chipone_dsi_attach(struct chipone *icn)
>  	dsi->hs_rate = 500000000;
>  	dsi->lp_rate = 16000000;
>  
> -	ret = mipi_dsi_attach(dsi);
> +	ret = devm_mipi_dsi_attach(dev, dsi);
>  	if (ret < 0)
>  		dev_err(icn->dev, "failed to attach dsi\n");
>  
> @@ -761,11 +761,6 @@ static int chipone_i2c_probe(struct i2c_client *client)
>  	return chipone_dsi_host_attach(icn);
>  }
>  
> -static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
> -{
> -	mipi_dsi_detach(dsi);
> -}
> -
>  static const struct of_device_id chipone_of_match[] = {
>  	{ .compatible = "chipone,icn6211", },
>  	{ /* sentinel */ }
> @@ -774,7 +769,6 @@ MODULE_DEVICE_TABLE(of, chipone_of_match);
>  
>  static struct mipi_dsi_driver chipone_dsi_driver = {
>  	.probe = chipone_dsi_probe,
> -	.remove = chipone_dsi_remove,
>  	.driver = {
>  		.name = "chipone-icn6211",
>  		.of_match_table = chipone_of_match,
> -- 
> 2.43.0
> 
ping.
