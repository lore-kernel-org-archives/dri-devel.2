Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB3FC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E2310E65D;
	Mon, 10 Aug 2026 06:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFwUPgS2";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17F010E0E1
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 05:04:13 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cace91f112so2480815ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 22:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786165453; x=1786770253; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8uD24huWZm6XpJh9wT7WOr3BJsSLtwFgAarL6fJ9kQ4=;
 b=YFwUPgS2bztpV2GlcwOEYEJGCZQ85ZU8RX8oU13BiNJVz3deHoS7Cnb5/JO95/ahmH
 ZEG/a6tjsJbtXwVjs9i9GeiCl8hwKtnXizuhLEZMJbWFbFFSnPn+TmITz8odsAIlf/lm
 CJq84aDjrbMzAEpZ27xnidAHN/xJQLFJ1iBf1VV/jsEECNKCW9Ww+BvFb0aVf/j1ayMQ
 9MC1pYyfyyKicyKt1l4l4njoAoyzvlWrSkCd+K4J1R04ZNHJf8rb273RWS4+CuxeylF7
 6lTdD9GpwJR7Asc/EdJzdMxK13eMEAD4tBg5aRhsk4aELGWGkmlqwluxqB6yRrGXH+KJ
 Pr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786165453; x=1786770253;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8uD24huWZm6XpJh9wT7WOr3BJsSLtwFgAarL6fJ9kQ4=;
 b=F4YTdUSrRolH6F46lYyowI7I0gh720oE4pFMJ373cAYikC8in+dI/o0qkEKtpMPJk4
 fBRuw0WqGQTDoa7KFAsW7nmcsNiKgB7hCWaZOnJiVTUx5X4djiCzDUONMx1FQEXJsZ7w
 gqE/p4rbyS2DubT2aB/oBdeyGaG4CXPB95K66Pq3WNY1UFgpCC5O606ArWM9o7/ZWMjm
 Mrk2OjjoBujXSMxGh6WqJSuZRQl78K10YNZYudg4Ph+aL1ASL2hwKpIw1M85ZBJIMt/p
 L7SRkyJPtNXqd4Yp6LSmq6eLrmhAy9MGEbMfBNWJgqOS3GBEkgfFTqyt6b0SUpKXLxON
 r0GA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1wa9Z1/DmHQa8AJJizsh6tLGD0YV+p2v9mA3ggxGVbQHnOoriB1uKwtLc0lI9xZ3WHzI+hAV2dao=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzT5ZjGaFnwJVq8A7Wv2fYr3VHzXXMizCt33ylABwOHBstMcR+
 8WKoVZIMtN0AruIbJPAR3PoHz/cR36ayHFGByOdHlWSZdeCEa4KMhM/0
X-Gm-Gg: AR+sD13X1ISVMFTpGiTsnviDAgLolb6gy5I1h01Y60QrQMKw75q4khjVGbGGk8zj3cK
 v9iD8xDKxgGWT8qsINE6WDbUJ1RpiGbuuQR/9YaQ0kqsWKKapVFijNvSV1K7qYCbfGnTUVjDXFr
 MUg7zfI5tweE+QP+CP60O7vy3Gm75llZ9c4fY+/FYi8MjGXwQizkT/uS7ClQ6JaSE1hvNx2DDPY
 FnFrTYC34PpUbMhEfVNNWRHeMiR4GfiCHxQ6qbVshzew8yXhVZExvQMWJLRrzY/8MyLbfooVXP6
 L1x8e6EbJRptr9WeRhNOmtMMhP1fU4KBFB25v92Olm15giuB3NuHu0Do1nz0Wv3mSdJM24Pgwd9
 +T6qv6KvFU2FKB1pFRS2JkvujZL7OMYToWVdzfTdeZngYqvJHCrDo2bxC5NF9AE0X0kOCbYcSmN
 svl3aJflhGRxUL7URQrmojOYGvrJYF6d9jLg==
X-Received: by 2002:a17:903:fa5:b0:2c9:d8c6:1dc3 with SMTP id
 d9443c01a7336-2d0ca1611famr339026475ad.0.1786165453023; 
 Fri, 07 Aug 2026 22:04:13 -0700 (PDT)
Received: from localhost ([2a12:a305:4::40fb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14cce7830sm15452855ad.29.2026.08.07.22.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 22:04:12 -0700 (PDT)
Date: Sat, 8 Aug 2026 01:03:52 -0400
From: Guodong Xu <docular.xu@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: codykang.hk@gmail.com, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Haylen Chu <heylenay@4d2.org>, 
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 10/17] drm/spacemit: add Saturn DPU KMS pipeline
Message-ID: <wr3264hzlya6zep433nr3u2acukizilkrqpkj444kfqeyaeorj@2rc4zo2cqcer>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-10-6de34d80e86c@gmail.com>
 <084a860a77f18aaafcda4b223eec4fdcd96e75c9.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <084a860a77f18aaafcda4b223eec4fdcd96e75c9.camel@pengutronix.de>
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

On 2026-07-27 09:35, Philipp Zabel wrote:
>On Sa, 2026-07-25 at 00:51 -0400, Cody Kang via B4 Relay wrote:
>> From: Cody Kang <codykang.hk@gmail.com>
>>
>> Add the atomic KMS implementation on top of the hardware backend: one
>> CRTC and one primary plane per DPU instance. atomic_check validates
>> the plane rectangle 1:1 against the mode and sizes the per-channel FBC
>> line buffer; atomic commit builds the cmdlist batches, maps the
>> framebuffer through the DMMU and arms the cfg-ready handshake, with
>> vblank events driven from the DPU interrupt.
>>
>> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
>> ---
>>  drivers/gpu/drm/spacemit/spacemit_crtc.c   | 815 +++++++++++++++++++++++++++++
>>  drivers/gpu/drm/spacemit/spacemit_planes.c | 376 +++++++++++++
>>  2 files changed, 1191 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/spacemit/spacemit_crtc.c
>> new file mode 100644
>> index 000000000000..b75ff6320501
>> --- /dev/null
>> +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c
>> @@ -0,0 +1,815 @@
>[...]
>> +/*
>> + * The assert and deassert orders are not mirror images: the hardware wants
>> + * these.
>> + */
>> +static void dpu_reset_assert(struct device *dev, const char *name,
>> +			     struct reset_control *rstc)
>> +{
>> +	int ret = reset_control_assert(rstc);
>> +
>> +	if (ret)
>> +		dev_warn(dev, "failed to assert %s reset: %d\n", name, ret);
>> +}
>> +
>> +static void dpu_reset_deassert(struct device *dev, const char *name,
>> +			       struct reset_control *rstc)
>> +{
>> +	int ret = reset_control_deassert(rstc);
>> +
>> +	if (ret)
>> +		dev_warn(dev, "failed to deassert %s reset: %d\n", name, ret);
>> +}
>> +
>> +static int dpu_pm_suspend(struct device *dev)
>> +{
>> +	struct spacemit_drm_private *priv = dev_get_drvdata(dev);
>> +	struct spacemit_crtc *a_crtc = priv->a_crtc;
>> +
>> +	/*
>> +	 * Assert before gating: a reset asserted into an already-gated block
>> +	 * has no clock edges to propagate on and leaves the register file
>> +	 * untouched.
>> +	 */
>> +	dpu_reset_assert(dev, "lcd", a_crtc->lcd_reset);
>> +	dpu_reset_assert(dev, "esc", a_crtc->esc_reset);
>> +	dpu_reset_assert(dev, "mclk", a_crtc->mclk_reset);
>
>It looks like these three are mirrored, and could be handled by
>reset_control_bulk_assert/deassert().
>
>> +	dpu_reset_assert(dev, "aclk", a_crtc->aclk_reset);
>> +	dpu_reset_assert(dev, "dsc", a_crtc->dsc_reset);

Is there a reason these two cannot be mirrored in order? Please double
check. As I checked the vendor tree, the suspend/resume side appear to be
copy/paste rather than a deliberate ordering.

Please double-check. Unless I'm missing something, I suggest to bulk them.

Thanks,
Guodong

>> +	usleep_range(10000, 20000);
>> +
>> +	if (a_crtc->core && a_crtc->core->disable_clk)
>> +		a_crtc->core->disable_clk(a_crtc);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dpu_pm_resume(struct device *dev)
>> +{
>> +	struct spacemit_drm_private *priv = dev_get_drvdata(dev);
>> +	struct spacemit_crtc *a_crtc = priv->a_crtc;
>> +
>> +	dpu_reset_deassert(dev, "mclk", a_crtc->mclk_reset);
>> +	dpu_reset_deassert(dev, "esc", a_crtc->esc_reset);
>> +	dpu_reset_deassert(dev, "lcd", a_crtc->lcd_reset);
>> +	dpu_reset_deassert(dev, "aclk", a_crtc->aclk_reset);
>> +	dpu_reset_deassert(dev, "dsc", a_crtc->dsc_reset);
>> +
>> +	if (a_crtc->core && a_crtc->core->enable_clk)
>> +		a_crtc->core->enable_clk(a_crtc);
>> +
>> +	return 0;
>> +}
>
>regards
>Philipp
