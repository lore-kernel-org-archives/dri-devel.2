Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78041C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D242A10E18F;
	Fri, 31 Jul 2026 07:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RnWhquYW";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA52910E18F
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:16:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 847764E41045;
 Fri, 31 Jul 2026 07:15:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 517776039A;
 Fri, 31 Jul 2026 07:15:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D19611C16493; 
 Fri, 31 Jul 2026 09:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1785482154; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=q6rVTdFce9zLYwdpKcETTUyPMfQzcWo+Xq/orZPdh6E=;
 b=RnWhquYWA16Db3QD57oc6NHqlch0Nctf5QPVHrBkOTHB7oSLf1Je0+OYob2eewt4LydHXZ
 +u4u9hni6y67UWHKpYoRD71XV+w4S1kHWCciA+fh4EeJ/K6o97boHFzR44CZ1mDql6HUoj
 rmnCD+O8tWA7b0fCVEytagWF6XLDMHaW9YqqWFPHTXvdCwHckbX2TnQz8Z00Epq/r8e432
 o4cog/dtudx27XH5+5EUwq/kNi9RINEK2tVtWkEwBRtHB8rK/M6ZKceWBG8oecuC9P0/QQ
 FCVXowwMMF0S1zIyZ3cgNfm0f7tlx5s57jq6eJsYcFx+l5LJUmlJjMqVahFs2Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 09:15:50 +0200
Message-Id: <DKCKLKB5PQRX.5J3QA5DIEMK@bootlin.com>
Subject: Re: [PATCH 10/10] drm/bridge: ti-sn65dsi86: Remove redundant
 dev_err_probe()
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "open list:DRM
 DRIVERS" <dri-devel@lists.freedesktop.org>, "open list"
 <linux-kernel@vger.kernel.org>
To: "Doug Anderson" <dianders@chromium.org>, "Pan Chuang" <panchuang@vivo.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-11-panchuang@vivo.com>
 <CAD=FV=WPC92HLyRbo72KK5E9jTQ2TZN9F9gogZk7oNfpat4YRg@mail.gmail.com>
 <CAD=FV=Uud3YA_eQ12SM9MUSLQSmzDY1f_V0HnSCUUXOHSY1aDQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Uud3YA_eQ12SM9MUSLQSmzDY1f_V0HnSCUUXOHSY1aDQ@mail.gmail.com>
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

Hi Doug,

On Thu Jul 30, 2026 at 11:17 PM CEST, Doug Anderson wrote:
> Hi,
>
> On Fri, Jul 24, 2026 at 7:11=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
>>
>> Hi,
>>
>> On Thu, Jul 23, 2026 at 6:17=E2=80=AFAM Pan Chuang <panchuang@vivo.com> =
wrote:
>> >
>> > Since commit
>> > 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq=
()"),
>> > devm_request_threaded_irq() automatically logs detailed error messages=
 on
>> > failure. Remove the now-redundant driver-specific dev_err_probe() call=
.
>> >
>> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
>> > ---
>> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>
>> I'll plan to apply this to drm-misc-next in ~1 week unless anything come=
s up.
>
> Pushed to drm-misc-next:
>
> [10/10] drm/bridge: ti-sn65dsi86: Remove redundant dev_err_probe()
>         commit: 9c950822f0fa923ccd344d7a143872d25efe89a3

Out of curiosity, did you apply using b4?

I see the commit does not have the R-by I gave to the cover letter a few
days ago, and assumed b4 would pick it up as it does when applying the full
series. If my assumption was wrong, maybe it's an issue to report to the b4
project?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
