Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29975CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653B910E92C;
	Tue, 13 Oct 2026 18:16:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5409910E92C
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:16:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB6A242A75;
 Tue, 13 Oct 2026 18:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BF91F000FF;
 Tue, 13 Oct 2026 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791915404;
 bh=d6gxlL56eKPPYrcopIYJhrR06Tfnwl5dj59P0UUTSdI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZlTNQhot4IAe+alzJ1Kz/Nzi34UQqutbyaGH/XDZKQ+WJZ42YUJaGO6YfSqyRodgb
 Yjh/NvboeZ79UChx//oILxERYt10coxahIuoPfKKNFffNmvr85Ktuj+OP9qVq2zVcg
 8l8UwZfpeyuuFq+unxUUCDaW1Eq4Ykc5dWVJPkUx3JLNMfR26Z6NgoCyDRJdwHLY6e
 7zdRd4nAssmWe9398XJpWV6N0K4VUj5JFKmCiDl4BTNdA1Z5BxI3/Xs2HSCkyhM/o8
 OgzHxaW9LvWONaMfIqgUhiqh0sNVV35I7EWux7/j8cuuUYjKUpRMQ5q5fincbkhRQy
 HdH42QdJSPTPw==
Message-ID: <sashiko-outbox-170306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] mfd: aat2870: Derive brightness steps from max
 current
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <20261013180933.487013-3-clamor95@gmail.com>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:16:44 +0000
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
- [High] mfd: aat2870: Backlight max_brightness incorrectly initialized to 0
--

commit 236a2bd14466123f025d53f0e3094d82e1e098d7
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: aat2870: Derive brightness steps from max current

The AAT2870 allows only 32 steps of brightness, with this amount defined
by the maximum supported current. Remove the need for max_brightness by
calculating the allowed number of steps from the maximum current.

> diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlig=
ht/aat2870_bl.c
> index 8b790df1e842b..eb686e315921d 100644
> --- a/drivers/video/backlight/aat2870_bl.c
> +++ b/drivers/video/backlight/aat2870_bl.c
[ ... ]
> @@ -150,10 +139,11 @@ static int aat2870_bl_probe(struct platform_device =
*pdev)
>  	else
>  		aat2870_bl->max_current =3D AAT2870_CURRENT_27_9;
> =20
> -	if (pdata->max_brightness > 0)
> -		bd->props.max_brightness =3D pdata->max_brightness;
> -	else
> -		bd->props.max_brightness =3D 255;
> +	/*
> +	 * The maximum number of brightness steps is determined by the max curr=
ent.
> +	 * The aat2870_current enum maps directly to the allowed brightness ste=
ps.
> +	 */
> +	bd->props.max_brightness =3D pdata->max_current;

[Severity: High]
Should this be assigning aat2870_bl->max_current instead of
pdata->max_current?

If pdata->max_current is 0, this bypasses the fallback logic applied just
above and assigns 0 to bd->props.max_brightness. Could this cause a
regression where aat2870_bl_update_status() rejects all valid positive
brightness updates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013180933.4870=
13-1-clamor95@gmail.com?part=3D2
