Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD1CC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD9710F5BB;
	Fri, 17 Jul 2026 15:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jcSYDkA2";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8924410F5AC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:21:23 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 039171A1067;
 Fri, 17 Jul 2026 15:21:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BDFC360361;
 Fri, 17 Jul 2026 15:21:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E796F11BD0007; 
 Fri, 17 Jul 2026 17:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784301679; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nalHUOdm7VQVimzU6YnOC1j2OEES9BvqlJ7ozQWcY3c=;
 b=jcSYDkA25yOnOGUnVeJf8gDepP8BEEtaSQXvujl53JXFhhiH52FBqxKzswsczT2ieY4lYw
 2Oz0o+BgQOHqRLR/s/3JAG1638E3jqVOHRr3SwCMk2dMbiqNsL2AxNDJtM/5gRT9nIdwWJ
 5sd/oOUgSVYDk5Q6SD3uuhNBwY16uhSTT89BklfIEBrkNLolcr8fZqioxBg4fDD/a3VDMq
 mMrmu8LFIPT0Oe8GYbytbC6YjPMubjRBY57jyFZewflgSUo/ApdEm8upq5GfeBu86UmjGL
 XBQzMfIvqIXOskEO9cyttWNCJj+sVZwGViYCQ62RuLdJ8u9TE4S++lzsg0BVWg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 17:21:11 +0200
Message-Id: <DK0Y5JTE66EA.111RUXTL6W8FA@bootlin.com>
Subject: Re: [PATCH 2/4] drm/bridge: display-connector: Fix I2C adapter
 resource leak
Cc: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>, "Thuan
 Nguyen" <thuan.nguyen-hong@banvien.com.vn>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Magnus Damm" <magnus.damm@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, <linux-renesas-soc@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>, "Laurent Pinchart"
 <laurent.pinchart+renesas@ideasonboard.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
 <alpEVeVmH5oiqmaj@hovoldconsulting.com>
In-Reply-To: <alpEVeVmH5oiqmaj@hovoldconsulting.com>
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

On Fri Jul 17, 2026 at 5:03 PM CEST, Johan Hovold wrote:
> On Mon, Jul 06, 2026 at 12:35:40AM +0300, Laurent Pinchart wrote:
>> If the probe function returns an error after getting the I2C adapter for
>> DDC, the reference to the adapter is never released. Fix it by releasing
>> it in the bridge .destroy() handler.
>>
>> There is no need to test the ddc pointer with !IS_ERR(), as
>> of_get_i2c_adapter_by_node() returns NULL on error.
>
> I stumbled over this this morning as well and posted a fix here (which
> releases the adapter on driver unbind as is currently done):
>
> 	https://lore.kernel.org/lkml/20260717085716.1619275-1-johan@kernel.org/
>
>> Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio sup=
port")
>
> I believe this issue was first introduced by commit 2e2bf3a5584d
> ("drm/bridge: display-connector: add DP support") a few releases
> earlier.
>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.c=
om>
>
> Reviewed-by: Johan Hovold <johan@kernel.org>

While Johan's patch has the benefit of putting the i2c adapter at remove
time (as opposed to destroy time, which is potentially a long time later),
it is also more complex. So I'd say this patch is fine.

Maybe we should have a devm version of of_get_i2c_adapter_by_node() to make
it all simpler.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
