Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B263CFCD0B3
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2658710E684;
	Wed, 18 Mar 2026 05:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DV/QE7pz";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0146A10E684
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 05:45:11 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2aecefc7503so31570335ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 22:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773812711; x=1774417511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aSnRYfqfJcyjaevNaNbpmhAT4WJV+y2G/dIlTdsAPy0=;
 b=DV/QE7pz7rPFDCczZ7lnV6Jegj8C1JYjDamgaH4jwW9ncNgW2RdAep3BcHyWVCwm0F
 eHNxcVgEUJmYfG8pwejJHykLF2Q6k2aDIGF6oH/WY4l1SjXTjlHwoeFTJN9v6/D3hqSQ
 Tnn13LtJ4o7YQsZ5/4rXp2qBGONy6l/6VamYv1qV0qTYTG3dwqfhq8ZnpmGkHljOyzMx
 Y605xV9nI2AOtcu8RdyeJPTxvIQU82Z68IMS/SUCEV2FdbermgjOJ9a1iGE8GPfTDFSn
 Nbp1Ab55EEpTRa26J6m1xlqpoMgW1TIEtcuGbWAhm5mJ2+JIHseNRVraE7eJOtR4dioB
 xT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773812711; x=1774417511;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aSnRYfqfJcyjaevNaNbpmhAT4WJV+y2G/dIlTdsAPy0=;
 b=plsQ38S0V2FbQLBe89jwRp0FQVze2yg43pX4KY3diJaHjBFofKMWLE3j5Fm2dPTkAW
 d5Au7H8yzDkTUKTntQz9ttVk/kqnzw6KpXz/qe4+c53xbCQxpdcL94kis55VYAreRNfS
 6t7d2ZhRYYI/hRhiokK7flka4hvady4iEnteaSdHFxWLDcQt7bdSK3TQd8Z+ZY/56dIi
 iuF+tqKDg0QfQvXzJDN9UWPFov1ySCS+PFoX92ezdP42XHge4ujV+1qAmmFWwHSc5iYt
 +ejWQL8RDiQmiZbN+vSh8Pt7FZ1X3gLKhhh2e/RimB4CkUD2Fv8icShRSvvVv3uFz0EX
 O28Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCViUSQ8mWycQMlXR4njPtuBtM2JCGCIcYIcXq6e21/Lzt4ua/izyKM1Iy90bLfhe42Jo1xspY2Cqc4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzg2AG0k3rL5doWRBiNhV9rA9KRoNttu081HMSNVos8iqJGY8cv
 6VyekcZpGgeDRa+NYuiQnudadpoOAggzHsTBT9+a0ss0u0/3ZhMdy77e
X-Gm-Gg: ATEYQzybEvt0BHGJik2wJoSuuGMqJ9WgyyzmlkpTFpi5r2PSOj7nmJEZU+ah/9xBMbt
 ZhBb/XGHkhWpXJ4xwPDSME2MWezJwhlMhiIlE/oF5ooM5MMODY/MCbIFshIJz7IVIbIMlvFmfDc
 4mvEbskqsQjrYY9aaLl2/TQ5FXCcW3aAI3qs2aibK6sLzqFgqy9PfQYx6LU3x0avy4JpaqofBW9
 uk4ie043z1yfx5s8c1nwFxZoYL5GH5nYHoFTE3l50H9Ng+1PUEaWOJzaQjvGpJvNMBak6O/ibIC
 8c5iqaHVDEUZOQcE8TKG96ENISNlCYw97DKh7grn74eg2wxmnxPoKDAvbrVjWeB7RTEwT5pYZaT
 FIXGIBkA9zwKAQFAdSiNAzwwiMAjBJNXFEAySXuaSU5TmClVNmQy4AmZ/7YvmzJnwc2RibWn8JI
 jkOre/78Lq54OGYrHLJByjgFFZuFGasbMMs7oTTbONmnEI0qg=
X-Received: by 2002:a17:902:ca8d:b0:2ae:4fc8:3f5d with SMTP id
 d9443c01a7336-2b06e4399acmr12760325ad.48.1773812711359; 
 Tue, 17 Mar 2026 22:45:11 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm13463195ad.52.2026.03.17.22.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 22:45:10 -0700 (PDT)
Message-ID: <49b79a0d-844b-4fee-bccb-706187ed76d1@gmail.com>
Date: Wed, 18 Mar 2026 11:15:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: tessolveupstream@gmail.com
Subject: Re: [PATCH v2 0/2] drm: bridge: ti-sn65dsi83: Improve dual-link LVDS
 support
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Marek Vasut <marex@nabladev.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 valentin@compulab.co.il, philippe.schenker@toradex.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <9f694b2d-44bc-46ad-8aa3-b464c2f0da13@nabladev.com>
 <176ed865-11a6-42de-89e0-06951b59a430@gmail.com>
 <DH0X7QW3AH3C.PRNRA8CRSSKA@bootlin.com>
Content-Language: en-US
In-Reply-To: <DH0X7QW3AH3C.PRNRA8CRSSKA@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 12-03-2026 21:19, Luca Ceresoli wrote:
> Hello Sudarshan,
> 
> and thanks Marek for copying me, I hadn't noticed this series.
> 
> On Thu Mar 12, 2026 at 1:35 PM CET, tessolveupstream wrote:
> 
> [...]
> 
>>> +CC Luca
>>>
>>> You might want to look at recently posted:
>>>
>>> [PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output
>>
>> Thanks for pointing this out.
>> I tried applying the patch “[PATCH 2/3] drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output” on top of the current tree and
>> removed the changes that I had previously added in the driver.
>> However, with this patch applied, I am currently seeing only the backlight turning on and no image on the LVDS panel.
>> For reference, the LVDS panel used on our platform is G133HAN01.1 and the
>> DSI-to-dual-link LVDS bridge is SN65DSI84ZXHR.
> 
> Thanks for having tried.
> 
> Can you please test with both the fixes in the series applied + the test
> pattern feature and report the results you get with and without test
> pattern enabled?
> 
> The patches to apply are:
> 
>  - https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-1-2e15f5a9a6a0@bootlin.com/
>  - https://lore.kernel.org/all/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-2-2e15f5a9a6a0@bootlin.com/
>  - https://lore.kernel.org/lkml/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-1-e6aaa7e1d181@bootlin.com/
> 

Thanks for the suggestions.

I tested the three patches together as mentioned, but the LVDS panel 
still only shows the backlight and no image. I also tried removing the 
test-pattern patch and retesting with only the remaining two fixes, but 
the result remained the same — only the backlight turns on and no image 
is displayed.
>> During our earlier debugging, we went through several trial-and-error
>> iterations and also received support from TI. According to TI, when
>> operating in dual-link mode the horizontal timing parameters must be
>> divided by two before being written to the device. Without this
>> adjustment, the panel either does not light up or shows corrupted output.
>>
>> TI also shared a set of recommended register settings for dual-link mode,
>> which were derived using the TI DSI-Tuner tool. These settings helped us
>> get the panel working on our hardware during testing.
>> For reference, the register configuration suggested by TI is as follows:
>>
>> 	regmap_write(ctx->regmap, REG_RC_LVDS_PLL, 0x05);
>> 	regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
>> 	regmap_write(ctx->regmap, REG_DSI_CLK, 0x53);
>> 	regmap_write(ctx->regmap, REG_LVDS_FMT, 0x6f);
>> 	regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x00);
>> 	regmap_write(ctx->regmap,
>> 		     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_LOW, 0x00);
>> 	regmap_write(ctx->regmap,
>> 		     REG_VID_CHA_VERTICAL_DISPLAY_SIZE_HIGH, 0x00);
>> 	regmap_write(ctx->regmap,
>> 		     REG_VID_CHA_HSYNC_PULSE_WIDTH_LOW, 0x10);
>> 	regmap_write(ctx->regmap,
>> 		     REG_VID_CHA_HORIZONTAL_BACK_PORCH, 0x28);
>> 	regmap_write(ctx->regmap,
>> 		     REG_VID_CHA_VERTICAL_BACK_PORCH, 0x00);
>> 	regmap_write(ctx->regmap,
>> 		     REG_VID_CHA_HORIZONTAL_FRONT_PORCH, 0x00);
>> 	regmap_write(ctx->regmap,
>> 		     REG_VID_CHA_VERTICAL_FRONT_PORCH, 0x00);
>>
>> If it would help, we can test any proposed changes on our hardware.
> 
> The first thing I suggest doing on your side is testing with the 3 patches
> mentioned above.
> 
> If you display works, good! Let us know (you can also add your Tested-by /
> Reviewed-by tags to the test_pattern patch too if applicable).
> 
> If it doesn't work, compare the individual register values to find the
> differences, try to figure out why the working setting works and how to
> apply that change to the driver in away that keeps other boards
> working. You're welcome to come back here to discuss it in case you can't
> find out on your own.
> 

I tested the three patches as suggested, but the panel still shows only the 
backlight with no visible image. I’m unsure how to translate the working 
register values into a generic fix based on display timings. Any guidance 
on the right direction would be helpful.
> Hope this helps,
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

