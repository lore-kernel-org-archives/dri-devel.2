Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FF6CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E629810E5A1;
	Mon, 22 Jun 2026 11:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q59WRL0Y";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A0810E5A1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:22:07 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso44353205e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782127326; x=1782732126; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n3pEs7ELftmADa57rBtbs9ZKMglFTJdohuXXnbaKK8k=;
 b=Q59WRL0Yv4Vkx5WyP56dRBNR9L15UkNG/Sz90t5As4uzLNYsYu2xtAgj8KyZRMZ+OC
 U6G6DYJv5V+oRpnZ33bdDSI2pXXBrg7k6GEDqA9L9E1S/sanL6QCEcKX1foTSMCW1YGk
 35FDvVXzG+1nNhh+8hP308c76g9onvNhmdbTymxbjc+WMr/5mJDFZhFxysTwxzVIEMFu
 T8QosAaY7mY5Mfb+66StN4y0CETDxyMUEyYmwO1nXnQHIopFAj1vuF7ML7MBpmu6f4Ig
 tCMQ6ISWDeRAopdLEw7+MjhQt7DJgJjtNaRjLrt+/B7tF4OB29t1u5tZlr2Ev/9o8i4N
 jJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782127326; x=1782732126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3pEs7ELftmADa57rBtbs9ZKMglFTJdohuXXnbaKK8k=;
 b=EPTV17KxnBWjTkQH+bHy+M1XoZuk5MqWZVBgvY418EeOd21QX+Ypjd7lejOoQ5nX1N
 5y9+jJkeDVZGuI/sTcTyEKatVDx1Rc03RZ5MUoKzIEcR5ZURRFVHs9yCt5TnHCjGfIi2
 qu5giD/snbmanI+aAq//0qId2gFXXQ5SCm5jpwYO0r1JJhztcfLMG658ILN1t/o8ifMQ
 4P99PRI0/ZiMgB6sgZ+BKYWp+/8k4tzXnqkPqCre9EFnRmY/cTPn0PJcv9JD9HtXcF8A
 gFz0StfiOTpIVBJV3CPtRisXuoHr4IVrfA17stgOluh9RsisWB/ZXtSkV0UnJxC2GWmu
 EcMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9K3EOJqMhivA5+PYgTOZwZV+7nSXzeaDRbiFaWgGLJ/al0mYVzOOGGHZMosCuWDaOyOOCPMAaY48g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylUU7iPufTzpHJzQrwj+kkkt2RxP1v3SsRPgKtWmybYFtJbFL5
 9vk9NcDgLJJZVfsHKzSyQRazuepRYheulHQKkvkLhs2GxDjKSgtIU4MJIW+8a5HU
X-Gm-Gg: AfdE7cnK8KFcBSECAD8Xad+KU1DKtNQOU6Bf+W6ByMAT6OfnJ15G9EmrPXkingkw623
 riwkeoGQwGUh3M64Ap+Mbm9TwUEU+zAupmsSNG+Ssm+8l9MP1OvlVVZODW4ueFcHkjgjU0Z/ugU
 +VGE8rrwDp0mjX8VGJAljYlDw9w0MXkKG14e8sJIHBK54pbrjJYLhYXr2eHbymE7eHGCRZ01pub
 oCAl0HPdZwdWirMchqf60q23XZYEUp7oCmt3JMWi8OLk9nQyJJ8Kti5/GmCdCfOTPHESawdsu6E
 n0TRF16yFiX45UqZsD9ZYKKLeZsAPPzGmib25PFX2v+aL1v2oy2w1hUHyHwuidNFVhYEbR5WYej
 8berrA/A0KPRWvR3DCxHOpQdYYUy4S6KyoQCbfeevTLzbaui9X3N3s6BEEwkAgMuy7XE//FmCs6
 zdU0BEgoTkkEsvZ0cb
X-Received: by 2002:a05:600c:8b2b:b0:492:4a56:690b with SMTP id
 5b1f17b1804b1-4924a5669d3mr155913935e9.35.1782127325428; 
 Mon, 22 Jun 2026 04:22:05 -0700 (PDT)
Received: from owl5 ([2001:861:3201:3d10:da31:7e0:ef44:ffb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd1f886sm270773485e9.4.2026.06.22.04.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 04:22:04 -0700 (PDT)
Date: Mon, 22 Jun 2026 13:22:03 +0200
From: Gary Bisson <bisson.gary@gmail.com>
To: Adam Thiede <me@adamthiede.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
Message-ID: <ajka2220depklK1_@owl5>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <42607fa4-485d-4142-b31c-7bfac71118d2@adamthiede.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42607fa4-485d-4142-b31c-7bfac71118d2@adamthiede.com>
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

Hi,

On Thu, Jun 18, 2026 at 04:06:28PM -0500, Adam Thiede wrote:
> On 1/20/26 05:36, Gary Bisson wrote:
> > Some bridges, such as the TI SN65DSI83, require the HS clock to be
> > running in order to lock its PLL during its own pre-enable function.
> > 
> > Without this change, the bridge gives the following error:
> > sn65dsi83 14-002c: failed to lock PLL, ret=-110
> > sn65dsi83 14-002c: Unexpected link status 0x01
> > sn65dsi83 14-002c: reset the pipe
> > 
> > Move the necessary functions from enable to pre-enable.
> > 
> > Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
> > ---
> > Tested on Tungsten510 module with sn65dsi83 + tm070jdhg30 panel.
> > 
> > Left mtk_dsi_set_mode() as part of the enable function to mimic what is
> > done in the Samsung DSIM driver which is known to be working the TI
> > bridge.
> > ---
> >   drivers/gpu/drm/mediatek/mtk_dsi.c | 35 +++++++++++++++++------------------
> >   1 file changed, 17 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 0e2bcd5f67b7..b560245d1be9 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -672,6 +672,21 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
> >   	}
> >   }
> > +static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
> > +{
> > +	if (!dsi->lanes_ready) {
> > +		dsi->lanes_ready = true;
> > +		mtk_dsi_rxtx_control(dsi);
> > +		usleep_range(30, 100);
> > +		mtk_dsi_reset_dphy(dsi);
> > +		mtk_dsi_clk_ulp_mode_leave(dsi);
> > +		mtk_dsi_lane0_ulp_mode_leave(dsi);
> > +		mtk_dsi_clk_hs_mode(dsi, 0);
> > +		usleep_range(1000, 3000);
> > +		/* The reaction time after pulling up the mipi signal for dsi_rx */
> > +	}
> > +}
> > +
> >   static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >   {
> >   	struct device *dev = dsi->host.dev;
> > @@ -724,6 +739,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >   	mtk_dsi_set_vm_cmd(dsi);
> >   	mtk_dsi_config_vdo_timing(dsi);
> >   	mtk_dsi_set_interrupt_enable(dsi);
> > +	mtk_dsi_lane_ready(dsi);
> > +	mtk_dsi_clk_hs_mode(dsi, 1);
> >   	return 0;
> >   err_disable_engine_clk:
> > @@ -769,30 +786,12 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
> >   	dsi->lanes_ready = false;
> >   }
> > -static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
> > -{
> > -	if (!dsi->lanes_ready) {
> > -		dsi->lanes_ready = true;
> > -		mtk_dsi_rxtx_control(dsi);
> > -		usleep_range(30, 100);
> > -		mtk_dsi_reset_dphy(dsi);
> > -		mtk_dsi_clk_ulp_mode_leave(dsi);
> > -		mtk_dsi_lane0_ulp_mode_leave(dsi);
> > -		mtk_dsi_clk_hs_mode(dsi, 0);
> > -		usleep_range(1000, 3000);
> > -		/* The reaction time after pulling up the mipi signal for dsi_rx */
> > -	}
> > -}
> > -
> >   static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
> >   {
> >   	if (dsi->enabled)
> >   		return;
> > -	mtk_dsi_lane_ready(dsi);
> >   	mtk_dsi_set_mode(dsi);
> > -	mtk_dsi_clk_hs_mode(dsi, 1);
> > -
> >   	mtk_dsi_start(dsi);
> >   	dsi->enabled = true;
> > 
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20260120-mtkdsi-29e4c84e7b38
> > 
> > Best regards,
> 
> Hello,
> This commit was part of 7.1 and caused a problem for me.
> I'm running postmarketOS (basically Alpine Linux) on a Lenovo C330
> chromebook with a Mediatek MT8173 processor.
> The problem: when the display on my laptop powers off (via suspend or idle,
> like xset dpms off) the picture does not come back when the display powers
> back on (from resume). The display backlight comes on and brightness is
> adjustable but there is no picture. The only fix is to reboot.
> 
> Reverting this commit and applying it as a patch on top of 7.1 addresses the
> issue for me.
> 
> You can view the config I'm using here:
> https://gitlab.postmarketos.org/postmarketOS/pmaports/-/merge_requests/8819
> 
> Is there any sort of testing or other debugging info I can provide to help
> address this issue?

Thanks for reporting the issue, could you share some logs? Is the driver
saying anything during resume? Also, what type of panel is used on that
chromebook?

Thanks,
Gary
