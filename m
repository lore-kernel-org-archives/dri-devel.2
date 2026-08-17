Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A32C5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C1310E42A;
	Mon, 17 Aug 2026 17:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MwMoC0+K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA4510E42A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:15:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 859D4600AE;
 Mon, 17 Aug 2026 17:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF111F000E9;
 Mon, 17 Aug 2026 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786986938;
 bh=vqpl9F2i8d57XZXPuTpGkt/yJ+MUgRhR3pJM+vtCdo8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MwMoC0+Kglq9E9f+00Xg4gxv5nPnA177Xmw8/KzEXMiTtOgzJJ+n0hsD2N+EakHsU
 UrdIgnmkYl2HkcqFUI5LpbwMlGEWC3BaYEPmRoiJLE8y2n1KmVmY7HTGSm3Aksfl8t
 RQ76ks4TTzgugYTSnQ6/JYvBupRl9XuDWVV45mDKcz3/zypb1WjNnCLIs8mHcDvrfO
 OPR3RPeIgitG9mZWLK8iqzAZCi+1I9vkfjzLE/0dfDnF0PW8jrTrw7CEouCHwdrkFP
 CQ+TPjb2NadFymas/iUddtrhTDXXdXqCFXbwaQXJuIBspkVQV8RZ1YvIVZLNhxUlsO
 14aFNSAxRVKOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] leds: lp8864: Register a backlight device
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org
In-Reply-To: <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:15:37 +0000
Message-Id: <20260817171538.0FF111F000E9@smtp.kernel.org>
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

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> The LP8864/LP8866 is a display-cluster LED backlight driver. Expose a
> standard backlight class interface in addition to the LED class device,
> so it can be used by display/panel stacks that expect a backlight.
>=20
> Use the new devm_led_backlight_register() helper, which spawns a
> led-backlight device driven by our LED and tied to the I2C device
> lifetime. This keeps the driver a plain LED driver, requires no
> device-tree changes and remains backwards compatible with existing DTs.
> It is a no-op when the led-backlight support is not enabled.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817170817.1933=
046-1-alexander.sverdlin@siemens.com?part=3D2

