Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3520BCA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBCB10E5B1;
	Wed, 30 Sep 2026 07:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="crivVVAn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACB110E5B1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:24:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6A744164D;
 Wed, 30 Sep 2026 07:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4961F000FF;
 Wed, 30 Sep 2026 07:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790753095;
 bh=UxqKvO5DnZdyyjeJVh5WYwYUZx3ftUy3b2K0Z/lgCG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=crivVVAnfZih2ZuZ+rHoEwOX/NZWJs25YbDEGgkbIbFVMd3CeGQFY5J5+mvDthNhn
 JzwAvUHwvLsR0B+ANRllsT7t8Lur4oTr6P2/HIFnHJF7xIgdjlRKqvUaqgfEHk0evh
 DPDYcKPDHn1VkyQep8nbAYRtVwKoYeYzQG8bXmvkfecvnuqQqewNwcz9P7bl9vxQUy
 tRP9Zj9wZO9D3Q5I7yeG/oOOIkQBPeZit95VbuD5syZD5lcVmmveb68L79YKzlnKER
 qD8SjMrbAAARW54RonzPiDLTK1LpwMGNdd+h7FvoyDsVF7VFxQddi3lnLJQQ9ZKx+T
 4nV4h/zG25aSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] mfd: aat2870: Add support for VIN and IN-LDO
 power supplies
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lee@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org,
 mfd@lists.linux.dev
In-Reply-To: <20260930071513.54697-4-clamor95@gmail.com>
References: <20260930071513.54697-1-clamor95@gmail.com>
 <20260930071513.54697-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:24:54 +0000
Message-Id: <20260930072455.3B4961F000FF@smtp.kernel.org>
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

> The AAT2870 supports a dedicated main power supply input alongside parent
> power supply for its internal regulators.
>=20
> Add support for retrieving and managing these supply regulators
> (vin-supply and in-ldo-supply) using the regulator framework to ensure
> proper power supply dependencies and power-up sequencing.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930071513.5469=
7-1-clamor95@gmail.com?part=3D3

