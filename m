Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17C4C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F7610EEAA;
	Wed, 15 Jul 2026 13:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pdu0O9yl";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDDD10EEAA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:36:56 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-476a130c138so2111208f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784122615; x=1784727415; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dzANICZPcrQ4mfbgZVA3ED3GO6T9Lf7g8EslsvNWAkc=;
 b=pdu0O9ylr/0iUAWCXt0BZi4qjFU3kutJis7HA0D+OfLvMptWWZ/yzrzltU98nOnZ5b
 OyBlCMqCrZ5oFwf7k3pNAVvH4P4zOTiXj0O18o5fOCRRLpr7WDH71UoUToIUgfq5axg5
 Wq6v2vCa05W3l2OhOynpXhRp4ZRk2mscEVqmEzcZQxwJKRauU0tLsuhJgWr6MkhMqVWY
 OVGTU8/6VJszm2Bb807jePzgQVbJD6WInO174ne1wGLa6DEbwPhrPvmjSjmj2k7FZp7e
 nzuAMoUAGYwYDm7yM7vVOANmdow4oM3qrcJDd/FP/OcljWzVuRSNetoehVH23ABCyXs+
 /W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784122615; x=1784727415;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dzANICZPcrQ4mfbgZVA3ED3GO6T9Lf7g8EslsvNWAkc=;
 b=lR3abMH43VbzSPY/fVnxtfv1yECDc7Wl1A0CBTurXsmVTdgtYaPWJwweFxUYZMZLs6
 54ewNd/LnfEIKIlwX6m18xZibzJWu0CmKXAftuescXmsM+mRwGS5TmBW/00QGlsfsoKO
 YNJ7lTpMSbI1COuocGxh5/rnCfp4lYmNJ61Px0/yVpcjx+hQ4XnqmR3GB4LVbSaNyv8A
 JSXiYgmnJfJ/DjvnQyBMn6L7xuWXw9IW32qx7a5gHraROnqcLGu4+Np1o3V+pkDnKzj5
 a0VB8en24bSR0zpzzGaK3r5Nwd8B4WZ4fXhEKFIlDd1/OjqqLrkeY7MS1eugIeZtoo6H
 2sIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoksO5hBtIcgzQfTJ1AGVXhVywhpuIIxouhu+qEvNSlJUvWlEbeJH87minnGUkjRZWJAhhhqGHJDDU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybNv13NC+l36ECpaJYf4Ui5G4umYEtkaCCJlAJtFL7Ft2xmASP
 K6hlzvcAUqNtIqoPtqX81pO5lgbOR4z4KYBZnW8ZvfKAIpFrgTNvFoh5
X-Gm-Gg: AfdE7clnftNz+t07DbwfvzYyurgeG1GQb9u1eK2jfEVJryuFd4Nb+MoVPifnV8bcyAE
 11c6+WLC+NdCbU28Lieae+9mePjOg+AkOu391mgj9Yw4Lv5GvTjANhanS3yn9UHkX0ZDSPgwtWn
 FEI1C57MtknHsz6lOa/bCNBeCj0K7MU+k29CLFBkgFqC8+NSPMDYxkHRaOiQHkcNx5Mt6iBT9qv
 CbWZrGAkTMR5NljQHb32VbJbpu7lB2eqSbWEO1qV8yh9kpQYh6HRvvLCEbMRtWJSxwbGTdY0q2M
 nN/3cAN8PBe+rUusR8MnJWYUc/FunomBrpGjDePv8owdN1N3YYD9eJiB30appBaCOihiIkEqttZ
 IBnfAYHeV2xJ2hUyyRQNbWocUAmuvdmH+DpuOdetUFDN+kl9kbVDvxKHS5lCmJzalHUOjOyr2Wh
 uTQ549kM8R
X-Received: by 2002:a5d:5846:0:b0:475:94e1:29d5 with SMTP id
 ffacd0b85a97d-47f2dce942amr20020545f8f.20.1784122615112; 
 Wed, 15 Jul 2026 06:36:55 -0700 (PDT)
Received: from owl5 ([2001:861:3201:3d10:e682:163f:4878:db7e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f462e0cb2sm16802692f8f.0.2026.07.15.06.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:36:54 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:36:53 +0200
From: Gary Bisson <bisson.gary@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Esben Haabendal <esben@geanix.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Adam Thiede <me@adamthiede.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
Message-ID: <aleM9Wy9otpd6Je3@owl5>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <8733xko1ms.fsf@geanix.com>
 <0f719c00-3cf5-4403-afbf-713b07255981@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f719c00-3cf5-4403-afbf-713b07255981@collabora.com>
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

On Wed, Jul 15, 2026 at 03:25:11PM +0200, AngeloGioacchino Del Regno wrote:
> On 7/15/26 14:53, Esben Haabendal wrote:
> > Gary Bisson <bisson.gary@gmail.com> writes:
> > 
> > > Some bridges, such as the TI SN65DSI83, require the HS clock to be
> > > running in order to lock its PLL during its own pre-enable function.
> > > 
> > > Without this change, the bridge gives the following error:
> > > sn65dsi83 14-002c: failed to lock PLL, ret=-110
> > > sn65dsi83 14-002c: Unexpected link status 0x01
> > > sn65dsi83 14-002c: reset the pipe
> > > 
> > > Move the necessary functions from enable to pre-enable.
> > > 
> > > Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
> > 
> > Hi
> > 
> > I have run into the same problem, but in combination with another
> > pipeline. I am seeing same problem with an i.MX8 using the nwl-dsi
> > bridge and the dcss driver.
> > 
> > I have submitted a fix that adresses the problem in the ti-sn65dsi83
> > driver instead. With a bit of luck, it can replace the fix proposed in
> > this thread.
> > 
> > See https://lore.kernel.org/all/20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com/

Thanks, just tried it on 7.2-rc3 with my patch reverted and confirm that
it works too. My assumption was that the SN65DSI83 was locking the PLL
earlier for some specific reason and therefore was reluctant to change
it.

> > /Esben
> 
> That clarifies a lot of things.
> 
> The patch on mtk_dsi shall be reverted then.

Angelo, do you want me to offer the revert patch? Should I wait to see
how the other thread goes?

Regards,
Gary
