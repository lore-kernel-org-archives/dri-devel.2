Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7FFC79F85
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 14:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C4710E3D3;
	Sun,  6 Sep 2026 14:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="a0Splrg6";
	dkim-atps=neutral
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A61A410E3D3
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 14:59:34 +0000 (UTC)
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail2.ecloud.global (Postfix) with ESMTPSA id E594C72128A;
 Sun,  6 Sep 2026 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
 t=1788706771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVMGfeFZrB58Lk7o3G3a6wdkQDsZOBW4TUrkVV5ZwgQ=;
 b=a0Splrg6zB00oeVpK4FriY8N+4GX17As20bPsA8Vx68XwCxzPSyZuXZgKfTgxovlJtlesN
 bxEs+wzrGffdT8Ih5QE30TKCExhKjyzbY4otFGSd4YbqpIKaQ+RA4/s7K6HAQBMS8FtR1X
 CSWgY5ki1wIZLfpJGmpXWo8D0uBPuhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail2; t=1788706771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVMGfeFZrB58Lk7o3G3a6wdkQDsZOBW4TUrkVV5ZwgQ=;
 b=THJSY92/A/bjlj/pBTmUxyu7CCDs80zoyeYMIggATaIpL8vqJFlBrJhaPBJPGEI6RyIMtR
 NAU+Lsj5+v0YaaS4T+naMaa4I6xDz4kCMWURKf1LKkssivQ9G1gjaQ/S0TqUwpXElYkKGN
 iejrNvcdKwjMq5n3hnEPRs5vl0+GPmY=
ARC-Authentication-Results: i=1; mail2.ecloud.global;
 auth=pass smtp.mailfrom=maud_spierings@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1788706771; a=rsa-sha256; cv=none;
 b=AyIWxjPgvVFrVvAxTXlq0c74VZgXwUKhdAsaAo7owEu5lfVisTLR+RN6ywUsHXhiMJkRFL
 dLC4XUaP3ekFGA1Jjk/HdAWNPCsR/hNMIYi7EFT4SXTQoHtELqbI3vmzjEzvEMPKBN16Z4
 TzdFhlnMtX3Oyh73K4IEa6RNY6VrHLU=
Message-ID: <cb0884b3-c9be-4cfd-ba43-27add3821ddd@murena.io>
Date: Sun, 6 Sep 2026 16:59:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
To: Dominique Belhachemi <domibel@debian.org>
Cc: m.wilczynski@samsung.com, Laurent.pinchart@ideasonboard.com,
 airlied@gmail.com, alex@ghiti.fr, andrzej.hajda@intel.com,
 andy.yan@rock-chips.com, andyshrk@163.com, aou@eecs.berkeley.edu,
 bmasney@redhat.com, conor+dt@kernel.org, conor@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 hal.feng@starfivetech.com, heiko@sntech.de, hello@big-grey.co.uk,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, kernel@esmil.dk,
 krzk+dt@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org, luca.ceresoli@bootlin.com,
 m.szyprowski@samsung.com, maarten.lankhorst@linux.intel.com,
 maudspierings@gocontroll.com, mfd@lists.linux.dev, mripard@kernel.org,
 mturquette@baylibre.com, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
 palmer@dabbelt.com, pjw@kernel.org, rfoss@kernel.org, robh@kernel.org,
 sboyd@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, uwu@icenowy.me,
 vkoul@kernel.org
References: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
 <0ccb4168-ff88-459c-972d-3c091c155db2@murena.io>
 <e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io>
 <CAAvaLCwvVUddS14MPx0FHdnp+QeZ99+ox17pXt2hSWPTCFcHtw@mail.gmail.com>
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <CAAvaLCwvVUddS14MPx0FHdnp+QeZ99+ox17pXt2hSWPTCFcHtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/6/26 07:39, Dominique Belhachemi wrote:
> On Sun, Aug 30, 2026 at 10:17 AM Maud Spierings 
> <maud_spierings@murena.io <mailto:maud_spierings@murena.io>> wrote:
> 
>     I was still having some glitching happening on the display, but I've
>     found the way to fix that, the question is what is actually
>     happening here.
> 
>         0x29590020 <- 0x00000005
>     This one I have no idea, it is 0x00000009 with this patch series but
>     with the vendor kernel I get the value above. When I hook up my
>     external
>     display (regular 1440p) this becomes 0x0000000D on the vendor kernel.
> 
>     But I can't find this register being written to anywhere there?
> 
> 
> Maybe this needs to be swapped?
> 
> drivers/gpu/drm/bridge/inno-hdmi.c
>    -#define v_HSYNC_POLARITY(n)          ((n) << 3)
>    -#define v_VSYNC_POLARITY(n)          ((n) << 2)
>    +#define v_HSYNC_POLARITY(n)          ((n) << 2)
>    +#define v_VSYNC_POLARITY(n)          ((n) << 3)
> 

Those seem to only be relevant the 0x08 register:
 > #define HDMI_VIDEO_TIMING_CTL		0x08

also in the code:

 > /* Set detail external video timing polarity and interlace mode */
 > value = v_EXTERANL_VIDEO(1);
 > value |= mode->flags & DRM_MODE_FLAG_PHSYNC ?
 > 	 v_HSYNC_POLARITY(1) : v_HSYNC_POLARITY(0);
 > value |= mode->flags & DRM_MODE_FLAG_PVSYNC ?
 > 	 v_VSYNC_POLARITY(1) : v_VSYNC_POLARITY(0);
 > value |= mode->flags & DRM_MODE_FLAG_INTERLACE ?
 > 	 v_INETLACE(1) : v_INETLACE(0);
 > hdmi_writeb(hdmi, HDMI_VIDEO_TIMING_CTL, value);
