Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D64CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B32688697;
	Thu, 11 Jun 2026 17:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="TA0AOqCZ";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A7510E825
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:14:30 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-7dc67a5e102so880197b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781198069; cv=none;
 d=google.com; s=arc-20240605;
 b=es8GA3i8b2BxcHapnxDGHhTdIZy+HAsQ9N4I3rC5qfyTDRyODyi89m0DsUgQHeivlN
 HDidipQBudPDfuWEAb6Re+QdalbW7c6p6ptCwLjNJu5ZQk5sHTDh7vjvg+ebJ0T5y6By
 IHGSr6HtpXHkMSLNaVjg5ZtE4EIZAxRzC527xlDKtEfHbLVdT3x3FEXyVe1ji+iPv89q
 z6IKezREGE4AON3Tj5oVuQfNsADESDUj1zDpgMYbwMvLe+CrUoPZoIPuBU9yyVLDzixo
 9D3F42JlkWP1q67ltlY8DS2+BDUfSIoJSjgKX4D9lK63zYYI6BiA6GyYQn1uwZ8tSCnv
 VJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eA7yRXvTEh8fNrCRO00h2bUBzADrGeYwcxZYdic1EgQ=;
 fh=uSfTQ4taLpwh1Ix0MoMNUSthPj+QD44k2HX/WInX4TQ=;
 b=FDLX/ob4sZZSIj/+qBz0DM4sntiSmaGtYtiQ0Z4IzKZIOie8bW+5UTVUijsOMMVYJT
 Os4Mnh2Vh88GR+70NR879wO94nSrHKQ7H14j0FAgIdeiCiJdNro/ai6+fjuGS1pNWZbx
 eMeFpmUNdtXBJR806u4BnGrMF0SzFSv4CdsgQY+hM/LlsvOIy85UT4FPnlQ3lWoJe0ag
 yHoPfdcHgsB42hAmcdX3S94AOCaT7ORr85HWJ0AvMykQSMINnTux4is4RrCKY003AE7a
 mpTCFAhqYwcu9rRmeCBamHC+qjIdE+/klUcgd1sCdwUoN5Y9pzW7CWMW3wuSN5c8AIW/
 E64w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1781198069; x=1781802869;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eA7yRXvTEh8fNrCRO00h2bUBzADrGeYwcxZYdic1EgQ=;
 b=TA0AOqCZ/32aNVDqu1QOw2wI2aLXtd8s0OFDsN5Kdy+5H2aMpLgjMsQD40vlFp/mz6
 CPZh2IG9QEWzfO4cZUKKXoMrwaZOz3cRxOwcVgsysIh6tre90MjrvSXYjRtFZyt5798o
 Hmz4cBziQbdZU+WOWphu26t1VEkNtQqEuDg0OR++/ZC2TVv2h+AWTT1Z7bpe/1EOG0Pm
 0sckFTlXtEV7G/jvojNXv8N3Dj9f6JSiV4C6YcQM/XQSCbk72GuEmlPD0Lc07Bz/vhTH
 gOinduMfBcbc7+2ulsgnAZtxr0liWXjVzT79Qlmo5laTDWwfjRdIhfZE6XBA22BkobGC
 QkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781198069; x=1781802869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eA7yRXvTEh8fNrCRO00h2bUBzADrGeYwcxZYdic1EgQ=;
 b=PnfltebpyahsP+nsDAn42HINx7Pqq4T25zA4PI6ngnaLylIvWPu40XwxthiKcpAyfF
 BAD2f0EOsPOd1gpHFcaJVcTv1H28euk1GdyRvCyHhS/7IbXcj/1sJCBts9LTgfhXjGMi
 U4hkvGpAbtelqT3sIDodmQPyB/C+NuNl6EpRi7zWXYbVvOf+2I1C4hexdw0I4+3MjiII
 FrJvQjxYAA37ISuBYc3Z/ZI0l4mcCMcwR15LugL5v1FwaqOdG94UBo9HIPUxkaRhk/Dz
 R2Sbq5tk/L/tn64KekCMRiUBCtnbY1sB0iUArNJdMIJqq3t9kWqN3xaB6id7HJKvTY9d
 KJpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/K3DmrVsL4Xww7Qxyp0z51kqhNjEXt9q+/cBHOg7zi1u7/ZwClWW+eaA56mmCUNTQJH03Iw/4haAc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6LGiJs3v4qXkwug4jxv09UuI8DOd5h7JMG6mAfbU+ilZKGctC
 ZTyO5NbUKBsZW8zJ9YpRbsAKdDdUXZe9ZuXFRRG4pRzlOh2+0vv+9sosUvRC0WvPsE1KJLRsbet
 xJlBDnL2sasQuri/ACykYfaKFHZpq3eB/XCJkitmGqQ==
X-Gm-Gg: Acq92OGCaKMcHwGiu6UiXidfYU6S6WAhRxPE4jVsOERYq7Xq/iV75qt28QH6WpXnpO8
 4D1pRRSP1gvAeexxBBZl+kGw4Qx5iAcQvlmtC7Kj+BgzVi544dO6s3cFFlGoHGPYPpYDd0s9rkA
 OycdF3z2Uti5ONYxZDWG+TKA4sM8Z74aHH5/kvZF/j/wWFL1ZzhAsP+VOhMOzKjhLG2Kq6glyDO
 d42tztr54Mrf+K72E4tmuot6YlmAujtLqFA/1J3x9wFGZwIAxr5bxJioIF71aR/3ivHAxbxoFQW
 eyWbajdJJvYp7WHz3Z2dKWnvOvqEWdYAvplgYRHvzybHxQo94LKAFEZGp+fmrjnJbAD9Za5c3tq
 X8lvAT1493auzIin7JKiqkflYVaQ1Z7czDlE=
X-Received: by 2002:a05:690c:660f:b0:7cf:f14e:bf5a with SMTP id
 00721157ae682-7f655cd3b81mr39665227b3.20.1781198069266; Thu, 11 Jun 2026
 10:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-24-445eb54ee1ed@collabora.com>
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-24-445eb54ee1ed@collabora.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 11 Jun 2026 18:14:11 +0100
X-Gm-Features: AVVi8CeUnQ0ZG_IBJrTt3afcxP7ht6E9ev0RCneHeSMnT7NSdu-xpfFzb1oLr80
Message-ID: <CAPY8ntDw9CSZgMzdDenHdv8ZN8Ho5JAhu1h8FXUiqLfxcVCWLQ@mail.gmail.com>
Subject: Re: [PATCH v7 24/30] drm/vc4: hdmi: Use common TMDS char rate
 constants
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 1 Jun 2026 at 23:45, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Replace HDMI_14_MAX_TMDS_CLK defined locally with
> HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ provided by linux/hdmi.h.  Note this
> incorrectly referenced HDMI 1.4, as the 340 MHz maximum TMDS character
> rate was actually introduced in HDMI 1.3.
>
> Similarly, use HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ instead of the 600000000
> magic number.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
