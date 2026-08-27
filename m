Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EF2C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2E910F18C;
	Thu, 27 Aug 2026 19:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CpfH2Ji5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1535810F18C
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 19:22:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E813341894;
 Thu, 27 Aug 2026 19:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AD41F000E9;
 Thu, 27 Aug 2026 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787858553;
 bh=Pi7StiO52nrIaJocR7894LKY4OJH0svOVSowFddPScA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CpfH2Ji5Zm0RlqvqvSUKyL9vLgz5sD5mqrS+xdNY61iIOmv+z4/axcYs4NQS8ny6e
 j3Vjby/XZUQu7aznq9ajLxL7A5OgnAsrMvgPA0XMfFqA2aVl6JlwltphZ91tJ32sqM
 ianOb3mNenoGPlBOWGS9eMLg9RSefe1CnxokXJcFDvlA/3okxf8f4r9F4oJMFmLIli
 Ox3Grr/Ji6eAPKF3/GqbSHjM1e7304x5gFW+mvLvG/Wx5SPgponUYS35ixxN540xE1
 SdBm9S63W/uB+KKugRZ3VgwkBsOf8WqTsnu7BfuEOnk3VSalqqjXZl1TDc6BbYF927
 n7WR5sw06KleQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 2/9]: Glyph size: Use GLYPH_SZ/HW rather than hardcoded
 2, 1
To: "Alan Mackenzie" <acm@muc.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <apCFsX_JXJ9m3vpr@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box> <apCFsX_JXJ9m3vpr@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:22:33 +0000
Message-Id: <20260827192233.A5AD41F000E9@smtp.kernel.org>
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

>=20
> vt: 32b glyph: 2. Use GLYPH_SZ, GLYPH_HW rather than hardcoded 2, 1.
>=20
> These #defines enable the console to be built for either 16-bit or
> 32-bit glyphs.
>=20
> Signed-off-by: Alan Mackenzie <acm@muc.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D2

