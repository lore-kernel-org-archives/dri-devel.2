Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B1CCD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC612112B95;
	Fri,  5 Jun 2026 15:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WIE8rBmE";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E1D112B95
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:18:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A3C6BC58474;
 Fri,  5 Jun 2026 15:18:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BF7F65FED1;
 Fri,  5 Jun 2026 15:18:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 540D9106A24E8; 
 Fri,  5 Jun 2026 17:18:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780672730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=r2zLTXnIIEWYP9WPDWgk1ltoj3vmFgVMDfsqz5DWKFY=;
 b=WIE8rBmEy6A5wqgUNEYncR6XrGg25qcSFXrhLoqEbsj6qiy4816P80+gfL+qMXGr1155On
 4CMfLUab5VjAwzaALQWOZ1gObAv/1Wv1pSZZI6HMZ5mgBSqL5LNkgUbQxPms3USmily5uJ
 aUEbWVXE4FJ5opp8I+JpWuVC2cbpCHL7xqpP2c8oo5Fv5B95w9OCK3VkEqxrJTb4f/MqEL
 4AG54RQ+t7jgYjd2hlvbtXqHcm56a4jlGrpi3mBp1i+GrO5I3EkA1faqTNKbri3qI8VzXr
 bXVjXuQxoQiopn1OcNnOx7yvpV0didlNmxO5iYf9pQDKxbldqGlMV7uk9gzYXg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 17:18:43 +0200
Message-Id: <DJ17SSAYCT51.28YSD262KHNKK@bootlin.com>
Subject: Re: [PATCH v4 2/2] drm: bridge: ti-sn65dsi83: Disable video burst
 mode for LVDS stability
Cc: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <alexander.stein@ew.tq-group.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Marek
 Vasut" <marex@denx.de>, "Maxime Ripard" <mripard@kernel.org>
To: "Sean Nyekjaer" <sean@geanix.com>, "Sudarshan Shetty"
 <tessolveupstream@gmail.com>, <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
In-Reply-To: <ahsxWhXMhzbAj_3G@Seans-MacBook-Pro.local>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Sean,

+Cc Marek, Maxime.

On Sat May 30, 2026 at 8:51 PM CEST, Sean Nyekjaer wrote:
> Hi Luca,
>
> On Wed, May 27, 2026 at 02:27:36PM +0100, Sudarshan Shetty wrote:
>> The current DSI configuration enables MIPI_DSI_MODE_VIDEO_BURST.
>> while burst mode is supported by the hardware, its use
>> depends on continuous clock behavior from the DSI host. In practice,
>> burst mode may introduce instability depending on the host controller
>> implementation, as the DSI link may transition to low-power state
>> between bursts.
>>
>> Testing showed improved display stability when using non-burst mode on
>> affected panels.
>>
>> Remove MIPI_DSI_MODE_VIDEO_BURST and use non-burst video mode.
>>
>
> We briefly talked about this at Embedded Recipes
> I promised to sent a link:
> https://lore.kernel.org/all/E35054BA-FBE5-4CEE-905C-1F5D20140590@geanix.c=
om/

Thanks for the discussion at ER and for this follow-up e-mail.

> When burst mode is enabled, the LVDS clock gets way to high for my
> panel. I don't know if it's the DSI controller in the STM32MP1 or
> something not supported on the TI side.
>
> We have been running with this fix for 2 years :)

If I can summarize the situation in the last 4 years:

 * Several users reported the same trouble
 * Those users patch their kernel out of tree to disable burst mode as a
   workaround
 * According to Marek the correct way to make burst mode work is
   implementing link negotiation
 * Nobody is willing to implement link negotiation as of now

And this leads me to some questions.

 * Do we want to keep the current situation (everybody beats their head on
   the wall until they discover disabling burst mode "fixes" their panel,
   and keep an out of tree patch)?

 * Assuming the priority is getting a screen working (and not saving power
   on a black screen), would it make sense to apply this patch, and let
   people improve in the future by implementing link negotiation?

   Let's pretend for a moment this is a new driver being developed: would
   it be OK to have a basic working driver, without some power optimization
   features which can be added later on? The only valid answer to this
   question is obviously "yes". Doesn't the same principle apply here? If
   it doesn't, why?

 * What is the expected power saving with burst mode?

   I'm afraid I don't have precise numbers but I measured the total board
   consumption with or without burst mode (the former with a black screen
   but backlight enabled) and found no difference: exactly 12.74 W in both
   cases.

Thanks for you rpatience in reading this. I hope it helps in finding a
better solution.

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
