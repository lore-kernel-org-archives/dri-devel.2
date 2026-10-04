Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A66CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C34710EAA3;
	Sun,  4 Oct 2026 16:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n9jAW5Wv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB1510EAA3
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:49:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D918F40054;
 Sun,  4 Oct 2026 16:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1B61F000FF;
 Sun,  4 Oct 2026 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791132589;
 bh=2GvCWs79o3I/v/0fMpds5qr0bL0VPOy289wv50sqoSQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n9jAW5Wvo4kuVJm05eprG+hvvPkH/Q1Cnk5FigX4e+64Q660+F72KU+c9htmhQL5c
 C4p+5WNlOvT9iNSwC3FxSi7yaDfKRgrHii3Got8k3C5pViNPKrQuig/oZ07vy+X+bg
 xB9lP8gLp5thoSt19MSDsp+JJIKf0/JBRrlYr+2z7Asqp1JAyE52vmdJVXIFvTukgM
 CfKUcKDSKhheqn/QIy1whEggHT0KDliFNEFZEqBAHJf9JBVJNEaMVSyYteggEPpYPQ
 TG5GnhDPCVT7EeCzgOqgaSnW1dPeFz8VG4SJqqdIlnP6enyZkaBewP0qeT8SRMeAdo
 S+x0uUEeD5RLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] mfd: aat2870: Add support for VIN and IN-LDO
 power supplies
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-leds@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, lee@kernel.org
In-Reply-To: <20261004164121.193514-4-clamor95@gmail.com>
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 16:49:48 +0000
Message-Id: <20261004164949.4A1B61F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004164121.1935=
14-1-clamor95@gmail.com?part=3D3

