Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2201C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22F210F114;
	Wed,  9 Sep 2026 13:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W7dVNgZm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0528B10F114
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:30:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2418B6020A;
 Wed,  9 Sep 2026 13:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDFF1F00A3A;
 Wed,  9 Sep 2026 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788960642;
 bh=lfPcFf9koNkKSbGEgY2V9DzwoXfXgtwsL3fbXf3UeTM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W7dVNgZmo9CpEWWWvfGOjYw2tv4EqENvzwHW1NUCK2yuCBNtuWvAQwf0VXZMdiXxp
 TfsNOjMvqcBZKoXWyDa/b7Q9I2/7WC0dwe+IZVeTedDQco7ySdaGxYOgqX3ukIM5jS
 9AeBa7F2YYZCWJHl6aiVONC01Wg/dHrnS/ARJOoVVONgs6RvvynNd45oHW0dQSMaa6
 1gL/3OOg6fu2hPf9fqYunXu4X10IBz08Hz5kZOWTU1hUsZ2ySLGsL/tGD+xtpSGPln
 QfG1IiPaD3mYzC1DjPBsIW5dV83bk7oKw0d80mj+quzOMXDYQLX6X5f0IICYApngRC
 IA0FF+JCqW8GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org,
 linux-watchdog@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org,
 mfd@lists.linux.dev, media-ci@linuxtv.org
In-Reply-To: <20260909132153.1596191-9-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-9-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:30:41 +0000
Message-Id: <20260909133042.0CDFF1F00A3A@smtp.kernel.org>
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
> This driver was apparently never used, as it has has no devicetree
> support and never had corresponding platform_data definitions.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D8

