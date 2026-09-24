Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD8C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0007E10F746;
	Thu, 24 Sep 2026 18:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m79AI8XI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8507A10F74A
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:49:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8201E601DE;
 Thu, 24 Sep 2026 18:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2211F00893;
 Thu, 24 Sep 2026 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790275757;
 bh=SWxFfP5cMz5BLNozzgEEabvCVVzyYyzSr63qQn+Q3EM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m79AI8XIx7apUP33LY2Upm6Sy3onX0/dVsqasEENVaANM34sKd1rovPtqcLYztDNI
 g0KnWt3+NfhlrMzn/J4mvrd/FSHCMTPaC+/K9mhtopiUrl/PqTD9Pp73DSfaJ2KFf+
 RGj4ps1pqIH686sAPQ5EUq5BFq6TLjCuHmcJipflcOunR6a80ehRvra108ZZn+KNod
 2/noEjBg5aXPbjI6hXX6I2JOV7pMa/3yWqd/aui6JO0QWK7d1vQUwx9EV1igmI6FnT
 vjGNkgHXa5YtaglpDOXCrIjrrCP7e5TOA3BYFQFKtzDUmfTCwfpDbRuANDRyRTsk6j
 9nyLXf5BDSQ0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/14] drm/bridge: it6505: complete poweroff even if
 disabling regulators fails
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <b6053ef6184ce92d4285a91f6b40795b89eefb2b.1790275151.git.daniel@makrotopia.org>
References: <cover.1790275151.git.daniel@makrotopia.org>
 <b6053ef6184ce92d4285a91f6b40795b89eefb2b.1790275151.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:49:16 +0000
Message-Id: <20260924184917.1A2211F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/bridge: missing newline character in dev_err() format strings
--

commit 66842dcef6ab0efdd620d9bb8ab7b4ec82630515
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: complete poweroff even if disabling regulators fails
   =20
This commit modifies the bridge poweroff sequence to continue disabling the
hardware even if regulator disablement fails. It logs the failure instead of
returning early to avoid wedging the bridge.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 19bab8d65e222..b9e5ce36f556a 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2814,13 +2814,15 @@ static int it6505_poweroff(struct it6505 *it6505)
>  	if (pdata->pwr18) {
>  		err =3D regulator_disable(pdata->pwr18);
>  		if (err)
> -			return err;
> +			dev_err(dev, "cannot disable pwr18 regulator: %d",
> +				err);

[Severity: Low]
Is this error log format string missing a newline character? Without a \n, =
the
kernel log buffer may not immediately flush the message, or subsequent mess=
ages
might be incorrectly appended to this line, leading to garbled logs.

>  	}
> =20
>  	if (pdata->ovdd) {
>  		err =3D regulator_disable(pdata->ovdd);
>  		if (err)
> -			return err;
> +			dev_err(dev, "cannot disable ovdd regulator: %d",
> +				err);

[Severity: Low]
Similarly, should this error log format string also include a trailing \n?

>  	}
> =20
>  	it6505->powered =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790275151.gi=
t.daniel@makrotopia.org?part=3D5
