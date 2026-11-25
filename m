Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC280606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuwHHUrf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CEB10FBDA;
	Wed, 25 Nov 2026 11:47:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4007210FBDA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:47:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AED9340B98;
 Wed, 25 Nov 2026 11:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E6C1F000D1;
 Wed, 25 Nov 2026 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795607250;
 bh=YZ6bHi0umed5LM1vKu1/QlN1Ny1fOK0BiX3ksQa46tA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AuwHHUrfZJ3cKd0JFYPuL8EYvaGVNvPP61IZkK6zzl5Gm+WyXJl8tFwLgbjbnkTYU
 qz2MCz8x+GfW3Nm+prVZlEW3i0WDGe724lG8d99AqVeuCfuGe6cfsFckArB3C4PaUm
 6fnZSFJPW3NzAbvHTTU9Up1n5lFDf+fPquL7Nunu0T+Co4NYccQKn+mMaqeH1Vv8vC
 HIdMtUjwOsxm93c7vevkB2PN5HzagTvX8wEiGHLsFoEaanXYdboOdTiij76/q92I8f
 QIlkmNg0BAK16dl4u0G6iO8EDRam20QDAsY0FPskYLQzL0VzGEGPRs/ChfQgQ8Asfp
 mFfJB1qQvaHkQ==
Message-ID: <sashiko-outbox-233283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: st: stm32mp15xx-dhsom: fix bridge
 reset polarity
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125-tc3-reset-v2-2-32eefcaf1460@kemnade.info>
References: <20261125-tc3-reset-v2-0-32eefcaf1460@kemnade.info>
 <20261125-tc3-reset-v2-2-32eefcaf1460@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 11:47:29 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ARM: dts: st: missing Fixes: trailer for tc358762 bridge reset
  GPIO polarity fix
--

commit ed072d08151b8622793e548d3a5ea860d378e59d
Author: Andreas Kemnade <andreas@kemnade.info>

> ARM: dts: st: stm32mp15xx-dhsom: fix bridge reset polarity
>
> Reset is active low. It is apparently set to active high to work around
> a driver bug but not to indicate an additional inverter in the signal
> path. Correcly describe the hardware.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

[Severity: Low]
Should this include a Fixes: tag for the commit that introduced the DT
overlay with the active-high reset polarity?

  Fixes: 77a5fde00b9a ("ARM: dts: stm32: Add DT overlays for DH STM32MP13xx=
/STM32MP15xx DHSOM")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-tc3-reset-=
v2-0-32eefcaf1460@kemnade.info?part=3D2
