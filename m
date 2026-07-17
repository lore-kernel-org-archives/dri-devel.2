Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6160C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2007E10E4DE;
	Fri, 17 Jul 2026 20:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xNB33+mz";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C9410E4DE
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:07:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 04BEF1A1077;
 Fri, 17 Jul 2026 20:07:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CAB6160361;
 Fri, 17 Jul 2026 20:07:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F35BF11BD013E; 
 Fri, 17 Jul 2026 22:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784318819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Wi6BQXLKQhiTifAq9gxYfAkWMFRwEzXZVKdz6vQCO6g=;
 b=xNB33+mzXBMshQjizeo3TN2jPxVuCW1lwKEfonhroQzwgjcCtDDv7/UuW2b8jugzJ7uOWP
 FzSwAUYWASfPIZMpSVfd1cvemr5Nh6YKswabLkTNhweI7+JXBN+417vk3IfTs1zeT6GUxV
 E1mmsmgi0vbm3YxX3lXHWSGufVZEjC5QWO9tOmBW1zkWls9mOcRMJT5+gFiiWjleACZF3S
 5gniqFIMkuMg+Xh6kEETLedAEZOomBXxcfwsSXg9ZJ2/3mRIrRzn9Cu4GQl5XOMk7zw819
 NAg3aKj9k1ZBa8+zwm0BW/yJTJKtQ/NwHm70Ns+Wger32LngZJhaC4EC+yXNIw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 22:06:51 +0200
Message-Id: <DK148A1HSGJ4.1GZXWYTWPOZ6F@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 2/4] drm/bridge: display-connector: Fix I2C adapter
 resource leak
Cc: "Johan Hovold" <johan@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, "Thuan Nguyen"
 <thuan.nguyen-hong@banvien.com.vn>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Magnus Damm" <magnus.damm@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 <linux-renesas-soc@vger.kernel.org>, <stable@vger.kernel.org>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
 <alpEVeVmH5oiqmaj@hovoldconsulting.com>
 <DK0Y5JTE66EA.111RUXTL6W8FA@bootlin.com>
 <20260717182802.GD1889304@killaraus.ideasonboard.com>
In-Reply-To: <20260717182802.GD1889304@killaraus.ideasonboard.com>
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

Hi Laurent,

On Fri Jul 17, 2026 at 8:28 PM CEST, Laurent Pinchart wrote:
> On Fri, Jul 17, 2026 at 05:21:11PM +0200, Luca Ceresoli wrote:
>> On Fri Jul 17, 2026 at 5:03 PM CEST, Johan Hovold wrote:
>> > On Mon, Jul 06, 2026 at 12:35:40AM +0300, Laurent Pinchart wrote:
>> >> If the probe function returns an error after getting the I2C adapter =
for
>> >> DDC, the reference to the adapter is never released. Fix it by releas=
ing
>> >> it in the bridge .destroy() handler.
>> >>
>> >> There is no need to test the ddc pointer with !IS_ERR(), as
>> >> of_get_i2c_adapter_by_node() returns NULL on error.
>> >
>> > I stumbled over this this morning as well and posted a fix here (which
>> > releases the adapter on driver unbind as is currently done):
>> >
>> > 	https://lore.kernel.org/lkml/20260717085716.1619275-1-johan@kernel.or=
g/
>> >
>> >> Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio =
support")
>> >
>> > I believe this issue was first introduced by commit 2e2bf3a5584d
>> > ("drm/bridge: display-connector: add DP support") a few releases
>> > earlier.
>> >
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboar=
d.com>
>> >
>> > Reviewed-by: Johan Hovold <johan@kernel.org>
>>
>> While Johan's patch has the benefit of putting the i2c adapter at remove
>> time (as opposed to destroy time, which is potentially a long time later=
),
>> it is also more complex. So I'd say this patch is fine.
>
> In this case putting the I2C adapter early is probably fine, but in
> general I really prefer reference-counting and releasing references at
> destroy time. This ensures that the resources stay available if they
> need to be accessed between .remove() and destruction (for instance in a
> .release() handler following a close() or munmap() from userspace). I
> think late release should be the default, as it's safer, and early
> release should be carefully reviewed when it's required.

Makes sense indeed.

Thanks for the clarification.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
