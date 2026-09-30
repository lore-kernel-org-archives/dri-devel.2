Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B88CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D29010F4C0;
	Wed, 30 Sep 2026 19:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rKwk765z";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB7D10F4C0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:35:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 26B7D1A1080;
 Wed, 30 Sep 2026 19:35:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E707060749;
 Wed, 30 Sep 2026 19:35:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 67C771032A657; 
 Wed, 30 Sep 2026 21:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790796942; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vpqwVhkaQrlM436Ao8cy3FIBQzurew4N1bUjRlG3ai4=;
 b=rKwk765zTUA62PJdK6Dbqbnq30ntX08ZMYWV9oB4Bkff4C0oXIhqhIPXhT6CRN0HsQlFU9
 5b4bHMwIQUtwRhiCGp2C9VWPa16v0EWh84DXBgciHzslAo919sCG505Lz5Lm/udM56j5ga
 DjrCV8uZA7AU0TUTolKn0jzNrKzHOtTxtGFhPJoMXeVkc8QWhn3SJgaZ6Ajz+G+rJJCww7
 QEVb4SZd3TFHfpiHwuxG3e/Kzr9u7yKCf3yfyf29356z6ZU27N3kV80Ua+eSwMT1T+c/2n
 Cznaegi02Y9iRSzMnBlRDuvPm/BoAoeakPqq9yeNPLLtS4kMMBF4Y4FIDTy3fQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 21:35:39 +0200
Message-Id: <DLSWJ8V1AIC9.3D68VRRVHXJUF@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 3/7] drm/bridge: dw-mipi-dsi: stop using deprecated
 devm_drm_of_get_bridge()
Cc: <wsa+renesas@sang-engineering.com>, <imx@lists.linux.dev>,
 <Frank.Li@kernel.org>, <dri-devel@lists.freedesktop.org>
To: <sashiko-reviews@lists.linux.dev>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v2-3-6da431d8f180@bootlin.com>
 <20260929135537.5E85C1F00898@smtp.kernel.org>
In-Reply-To: <20260929135537.5E85C1F00898@smtp.kernel.org>
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

On Tue Sep 29, 2026 at 3:55 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] drm: bridge reference leak on dw_mipi_dsi_host_detach early re=
turn
> --
>
> commit b7207f37872ee6fe7eb2903e38f89975b930c392
> Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> drm/bridge: dw-mipi-dsi: stop using deprecated devm_drm_of_get_bridge()
>
> This commit switches from the deprecated devm_drm_of_get_bridge() to
> of_drm_get_bridge_by_endpoint() to resolve a build failure when CONFIG_OF
> is disabled. Since of_drm_get_bridge_by_endpoint() returns a refcounted
> bridge, it adds the necessary put operations to release the reference.
>
> Link: https://lore.kernel.org/r/20260928161605.2271412-1-arnd@kernel.org
> Link: https://lore.kernel.org/oe-kbuild-all/202609291109.9RGna4XZ-lkp@int=
el.com/
>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu=
/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 5dd475fcaacf8..22d1b8cbe1d57 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> [ ... ]
>> @@ -368,9 +368,8 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_h=
ost *host,
>>  			return ret;
>
> [Severity: Medium]
> If pdata->host_ops->detach() returns a negative error code (e.g., during
> device unbind or PHY teardown errors) and takes this early return, does t=
his
> leak the bridge reference acquired in the attach function?
>
> Since the bridge is now dynamically refcounted and we skip the newly adde=
d
> drm_bridge_clear_and_put(&dsi->bridge.next_bridge), it looks like the
> reference count will not be properly decremented on this error path.

The issue was there already for drm_of_panel_bridge_remove() (here deleted)
and drm_bridge_remove().

Id say it's orthogonal, and most likely nobody has this issue in real
life. So I took a note to fix this soon, and I'd let this patch be applied
as is because it fixes an issue bothering people.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
