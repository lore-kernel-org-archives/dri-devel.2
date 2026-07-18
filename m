Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5839C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D160A10E60A;
	Sat, 18 Jul 2026 21:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YbWwWNR+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BDD10E60A
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 21:59:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DEF341E96;
 Sat, 18 Jul 2026 21:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E651F000E9;
 Sat, 18 Jul 2026 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784411977;
 bh=AYt4bTL22XRla8JWYxmAo40Jg3WCRJP9kLovVPMZAu8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YbWwWNR+R8+jHi8BxAsEqYZb7O+bSTJ2smF3wRl2c6ju07VxXD/I2ZBNPvCyxsgQ0
 nOvCrMnbyP39YZ0rSORBhcAozQSM5hl94VPVFneLz/snrARtfCYeut78ilHpz+6xov
 j9PZh/yKhYnh3dZfBtjJ7QIPCJp+jelx+qNDBZGdtD+3Gm9tS2jSxyghFpvTp9rNb2
 j4PFklSpzChE1xYZjCDDPoE2BPjpL5F5NNAkbpYW+Ty5tpneRBpnkriOZBZCaBbJ8A
 vevRrzORbAq+E4c4XuuWDilutav61+s8E7gfjsyKJoJFWYkUEBDHVYZLogN/auOZGu
 ZdumcKllGdJRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: am335x-guardian: Drop unused
 isink-en property
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: linux-leds@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260718215632.3295049-2-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-2-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 21:59:36 +0000
Message-Id: <20260718215937.67E651F000E9@smtp.kernel.org>
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

> The 'isink-en' property is not read by any driver, so remove it from the
> TPS65217 backlight node.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718215632.3295=
049-1-egbostina@gmail.com?part=3D1

