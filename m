Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F7AC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 16:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6158B10E483;
	Fri, 17 Jul 2026 16:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h6FqF5Ug";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED12910E483
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 16:06:44 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47640541585so4029536f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784304403; x=1784909203; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BTNiDs+YQP5gErq+/6PIKAwZFcni80aDhJBtKwTwBbg=;
 b=h6FqF5UgiIpJjhC4xJeXEH/WYFZ7IrGinSKP2iVVv4Jc9sFhZd/DEGgj9qes1x6zwy
 6NOWTwDpwU+3EUXcEwV7ZztwkyvUXljoZuQvT51WkSvEpOcVvjEq76zeHqsDyxHwQLzy
 kpC5ub0dAMrZ8k42DHI5/5Mzz0Bk1KLhhZ+inQtlvagSuQt0fWiK0FyyLtCayLuPiGBY
 8cBDGtUVhL/k/gVyREFOv+CWheMFBV+g3FjGBVPGJvwbLncfKDD1dYNaDggyxuEm9tRN
 xn7y0i0XrGDeWMM5/BrAgI+C+cTS4B7QlqBCulgzuih5Dmn2HWB0Y44qCzr4WEoeZWy5
 GfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784304403; x=1784909203;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BTNiDs+YQP5gErq+/6PIKAwZFcni80aDhJBtKwTwBbg=;
 b=Q524ggqmXzig62fuZQkG1YZiCfh56HYWeJh18KTtiVnyWBKS2nQS2fWX9+BMejDPgj
 GNfhlf65df79CWDpTmKnTfih1U+IXHVk5FUprLvquaZKGckMfZO7E96KuiLBJiM9dbjK
 uMQsSGKqnRcrjAQadvZvzYXdNpdGoOvjjHeVH0OzmjdWliY6qhVxgicj/htyZKew8NnX
 loddye83PbAXLLYlCFMfoK4twDgyKIhj1dDpuMLFcLnp2DBa+kB4xyJyiHvXuCdNBUDQ
 TKzRxZLfI0ZbbwyHuwb/l92fShyhleLNHmT8QLBCXuMAIabOtGB4v3vFW2Me0Y2XVh6i
 I4Hw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1iDTZ2+heICLVPB2FoZRURUaAx21dmY9JIhvs87D38QmE9ng1yVz9/kDE4P2dNxUNAkhka8vaNfE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNFtAHJtTNdrUqrYkD+uOwG9zynh3tGB255hVeja07NymFqcKU
 RiF5gzm7SxtuQYsk2uPPsBJZqnMwwLDCxlw68gMEqvaMnhFNm06llxcl
X-Gm-Gg: AfdE7cm0oIyfDimip4baCUtN0/Qs5iqKsAih0fqiWWvjtp8LBaaBEKYD9Rw49XbMfMa
 hlT/5qOQed5cGdJ6Mbu51YXVmTmYVtthG8oaZAovZzGXmOOMAlj/MVGsbxGy0VZFb/13tCqqtOP
 s6UClKK0kB9DQhmtWZ8pcnl6joUfcPOs/wwN45sxvhfc6S9q6vCxjU4p8DxGDKrIeZrE304QOLV
 CuZ+VafSFmWh78KwwW/tDWJfNReEb+Tu6CsKfYxGeGqlMt5f01BYHhw8UpPgOXkXx5T71zo2o1b
 49UeYSrsz29JQy1dEXwiYl2MVr3OcE9Rimc2zLsELE0i040AdcCdtxL5T+6eAm0U/HGovS/QabG
 4A2h+bbNnWHWF213CAIt6cir0GkBaOV/8BEsppfbdw2h4zWnOKbOjExofFGAbgeCPKGmdqctlRA
 ==
X-Received: by 2002:a05:600c:4453:b0:495:4f62:1ff7 with SMTP id
 5b1f17b1804b1-4954f622066mr5214955e9.17.1784304402908; 
 Fri, 17 Jul 2026 09:06:42 -0700 (PDT)
Received: from owl5 ([2001:861:3201:3d10:d4b8:8874:bdef:21b2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954ba2abd0sm37795105e9.15.2026.07.17.09.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 09:06:41 -0700 (PDT)
Date: Fri, 17 Jul 2026 18:06:40 +0200
From: Gary Bisson <bisson.gary@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Adam Thiede <me@adamthiede.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
Message-ID: <alpTEPsy-SIQv_Oc@owl5>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <8733xko1ms.fsf@geanix.com>
 <0f719c00-3cf5-4403-afbf-713b07255981@collabora.com>
 <aleM9Wy9otpd6Je3@owl5>
 <aRN3_2FHX8XmTcwduTAPwz4UFde4B0tbB09ajyeUg5qZxiIYMmbvMkG7CPoNTl4iySYMZawbLMWijO47R22gkg==@protonmail.internalid>
 <65558ccc-4f2c-492d-8c74-627d27dce864@collabora.com>
 <87h5m0mkca.fsf@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5m0mkca.fsf@geanix.com>
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

Hi Angelo & Esteban,

On Wed, Jul 15, 2026 at 03:52:05PM +0200, Esben Haabendal wrote:
> "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
> writes:
> 
> > On 7/15/26 15:36, Gary Bisson wrote:
> >> Hi,
> >>
> >> On Wed, Jul 15, 2026 at 03:25:11PM +0200, AngeloGioacchino Del Regno wrote:
> >>> On 7/15/26 14:53, Esben Haabendal wrote:
> >>>> Gary Bisson <bisson.gary@gmail.com> writes:
> >>>>
> >>>>> Some bridges, such as the TI SN65DSI83, require the HS clock to be
> >>>>> running in order to lock its PLL during its own pre-enable function.
> >>>>>
> >>>>> Without this change, the bridge gives the following error:
> >>>>> sn65dsi83 14-002c: failed to lock PLL, ret=-110
> >>>>> sn65dsi83 14-002c: Unexpected link status 0x01
> >>>>> sn65dsi83 14-002c: reset the pipe
> >>>>>
> >>>>> Move the necessary functions from enable to pre-enable.
> >>>>>
> >>>>> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
> >>>>
> >>>> Hi
> >>>>
> >>>> I have run into the same problem, but in combination with another
> >>>> pipeline. I am seeing same problem with an i.MX8 using the nwl-dsi
> >>>> bridge and the dcss driver.
> >>>>
> >>>> I have submitted a fix that adresses the problem in the ti-sn65dsi83
> >>>> driver instead. With a bit of luck, it can replace the fix proposed in
> >>>> this thread.
> >>>>
> >>>> See https://lore.kernel.org/all/20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com/
> >>
> >> Thanks, just tried it on 7.2-rc3 with my patch reverted and confirm that
> >> it works too. My assumption was that the SN65DSI83 was locking the PLL
> >> earlier for some specific reason and therefore was reluctant to change
> >> it.
> >>
> >>>> /Esben
> >>>
> >>> That clarifies a lot of things.
> >>>
> >>> The patch on mtk_dsi shall be reverted then.
> >>
> >> Angelo, do you want me to offer the revert patch? Should I wait to see
> >> how the other thread goes?
> >>
> >
> > Gary, yes please, send a revert and make sure to explain the reason why
> > we're reverting this in the commit description :-)
> 
> Maybe test if my fix actually solves the problem with the mtk_dsi driver
> also ;)

As mentioned in the other thread, your patch works but it might break
the init sequence recommended by the bridge datasheet.

Moreover, the drm_bridge.c doc [1] does mention that the clock lane
should be initialized during pre_enable. If we agree on this assumption
I believe my patch should not be reverted.

Maybe Adam's bridge driver must be patched instead, just like the
nwl-dsi driver should be updated to follow the drm recommendation.

Let me know your thoughts.

Regards,
Gary

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_bridge.c#n169
