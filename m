Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD7CC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CD510F065;
	Thu, 23 Jul 2026 10:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JF7Fb9FO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C73110F065
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:10:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A98EA41A3A;
 Thu, 23 Jul 2026 10:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4851F000E9;
 Thu, 23 Jul 2026 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784801411;
 bh=ffDOQ3Xv1d+SfNqYpg9VjXhWon0RP1JKCxXKrHBd6YI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JF7Fb9FOhgjvptO5TznRX0DWU5bGGWLhKGi85TJ7kC/WFwDMvvQTDFkbOLaM9tKA/
 UyQ6ZpkFgC6o2HL5XbLGnSCAf8pYQvWYufkpqL+pn/7lKIsuP4qLmO2o/3Kx+zES7Z
 yZMym8wEcgjHMqE6d/jvJhHfSU79M2DKzKP6puORrnT/pB/wwNldn0YSYgQPtaprhv
 z8H1gfn/TrLxGoTgOAN63ZMUOdtQNBVqM2yj579CDANKjCpz7IYwxkKi5R1N7SHTK1
 NSpR1B7kXNzDpnQDN77MKzjZgjX3axGnfjya0GOXJk/+jdd0lYhVR/XuuNkoZHfRM6
 7sUWKu8UT6T4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] ARM: dts: ti: am335x-guardian: Drop unused
 isink-en property
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: lee@kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
 robh@kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260723100605.628882-2-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-2-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:10:10 +0000
Message-Id: <20260723101010.EB4851F000E9@smtp.kernel.org>
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

> The 'isink-en' property is not documented and not read by any driver,
> so remove it from the TPS65217 backlight node.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100605.6288=
82-1-egbostina@gmail.com?part=3D1

