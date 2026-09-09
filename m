Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E64C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB1F10E135;
	Wed,  9 Sep 2026 13:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OCwE0P6t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BE010E135
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:33:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D321B439FC;
 Wed,  9 Sep 2026 13:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E79B1F00A3A;
 Wed,  9 Sep 2026 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788960790;
 bh=Wk8PpiCIrPGt/oiboUlDrzwPDaTybYBaRQ8R1roEQ4s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OCwE0P6t8ivCk5MNm4nc4zmFE6fsZruYLpah2pjqw/uscfSPzLgUA86s6fNgmtZ4G
 9qn+gTlmci4eMsu3f3/mNOfnqJlzlaoqeLaFmk+doVjMOIOR8YakJoNA7OAUvxOrDl
 7WWFhvD4FH/vaPFrFomE1FFlokYgszUUhXtjCj++cpxH/0bPfe3qzddbqpX0WjB9yU
 T+lFJfrL6Cspend5sG3V1XoUSjfHTZIbb1UyQJV11zmvz4sA7vBqm5u9FbG4b7e4zx
 dDlIGVupUfJBSGQbK7UFbGnAGMylR3m+oFIY6D8F09QveQ2idjvvBwju4MaoFr6Mzd
 sKvJNm6/CMXHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/14] mfd: remove unused wm8400 driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, lee@kernel.org,
 linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org,
 dmitry.torokhov@gmail.com, media-ci@linuxtv.org, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-hwmon@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org,
 robh@kernel.org
In-Reply-To: <20260909132153.1596191-5-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-5-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:33:09 +0000
Message-Id: <20260909133310.0E79B1F00A3A@smtp.kernel.org>
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

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver requires a platform_data definition, which does not exist
> in the kernel.
>=20
> According to Mark Brown, the hardware supported by this driver was never
> shipped in production.
>=20
> Since this is clearly unused, remove it.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D4

