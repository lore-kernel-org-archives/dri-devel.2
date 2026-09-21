Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FF2C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C05410E970;
	Mon, 21 Sep 2026 18:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oaa6RZEc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8140810E970
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:23:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C79F360120;
 Mon, 21 Sep 2026 18:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF301F000FF;
 Mon, 21 Sep 2026 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790014987;
 bh=rO/H4zxRJWijL2XrpP2BhtNedFZc7PUyJZ2NzpwnEZ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oaa6RZEcAW1kIyaqqlyztwaifquTpV30LiSEeq4JQsinKWTFCRc85tV8lkBfZhxpw
 frs8uBRj1eFJYgi0KBUygfqI0Jqooh2bZCNeT0vvxzT6Av5HYVZQ0LbxzvOsli6pSl
 NCXESRllMWFjnT+Oyly8Q6ZKAd43FO6UBtvEcutVawcdENogf0H0EjlwQryfSEVDvr
 zfpviNZyqO5Hc4swvzHlxpedeptt5hzJnKlGmju3b/z5G9ScW2FSdVF44tjHK3iqUX
 E7S3sfDzoU+XgSIkTPoGQdSpC62/L15vy1iJ8aZfuyfwMnI/Ds2jCMUbSqp+1gw5qR
 f/GJHtMp6cBXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/19] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, linux-clk@vger.kernel.org, conor+dt@kernel.org,
 mfd@lists.linux.dev, lee@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:23:06 +0000
Message-Id: <20260921182306.EDF301F000FF@smtp.kernel.org>
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

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the compatible for the rpmpd found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D4

