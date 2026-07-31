Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65EEC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C70C10F197;
	Fri, 31 Jul 2026 07:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SjffXQIp";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D626A10F197
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:13:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B10F84E41045;
 Fri, 31 Jul 2026 07:13:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 809C26039A;
 Fri, 31 Jul 2026 07:13:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C1CA011C16487; 
 Fri, 31 Jul 2026 09:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1785481980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VGQMgHVlOdFPDkwMI+ZQoWPHjwSAajBkHRpM/WNvcII=;
 b=SjffXQIps0y6Tp261sDuMH0z7WBGwsH8I4QNFdoyreg98+b2zKgt/Xf/4lJT/gda1aV++U
 JVnDkcj5vwon5cWzWFTCWDTByNed+5Jxt4cL0v/COi7lQsgtZtHVx2B6OcZtGc/mAyHXkj
 b8+pxk6ksmEdfSqzTFl1ttNKy2OWIHt6vEVEhAPVAXs5eyFu3rVpr1wo4CBxk6WTcxydf8
 8eyenOFp6ttZrHtTJdq0YywBIH5Z+LsEY4fhYGcBgDNbPDW7hARAFDKc7i+E/la1XKHcBy
 HflJJ/za+yBZTeR8TWZBs9hS2lpcXXnEfBDvZYdrndmEOZ/gSGbNuPcMImZj9Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 09:12:47 +0200
Message-Id: <DKCKJ87JYAKB.U2K2QGA8T1RG@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 00/10] drm/bridge: Remove redundant error messages on
 IRQ request failure
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Douglas Anderson" <dianders@chromium.org>,
 "Damon Ding" <damon.ding@rock-chips.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Heiko Stuebner" <heiko@sntech.de>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Harikrishna Shenoy"
 <h-shenoy@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, "Kees Cook"
 <kees@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Pan Chuang"
 <panchuang@vivo.com>
X-Mailer: aerc 0.21.0
References: <20260723131649.134127-1-panchuang@vivo.com>
 <178481705931.250308.3468984153003724124.b4-review@b4>
In-Reply-To: <178481705931.250308.3468984153003724124.b4-review@b4>
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

Hello Pan,

On Thu Jul 23, 2026 at 4:30 PM CEST, Luca Ceresoli wrote:
> On Thu, 23 Jul 2026 21:16:32 +0800, Pan Chuang <panchuang@vivo.com> wrote=
:
>> drm/bridge: Remove redundant error messages on IRQ request failure
>>
>> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
>> devm_request_*_irq()") added automatic error logging to
>> devm_request_threaded_irq() and devm_request_any_context_irq()
>> via the new devm_request_result() helper, which prints device
>> name, IRQ number, handler functions, and error code on failure.
>>
>> [...]
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

And:
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I plan to apply the series (except patch 10, already applied) next week if
there are no objections.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
