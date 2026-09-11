Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415B7C88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4E910E495;
	Fri, 11 Sep 2026 09:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="McH4wbd6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A690210E495
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:52:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4873143E4A;
 Fri, 11 Sep 2026 09:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32891F000FF;
 Fri, 11 Sep 2026 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789120324;
 bh=nXsrkjWE4prBXa8s2vKEcY8Cn5cG+6IhnDl61E18dFw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=McH4wbd6Z+QSsKyHkcw/C/St3nLTsYwvseou4LBFRX7kySVZPlxDhynpZrncqFgdi
 e2xeOAGaiCBMkiRjGjtGf2BF98HlOpzCdx/o+Pn3aLqF3cKMeqHW+pYNKAZHzsm2G8
 oDPVnOfiHfbbnIoECGv6MU3H1Rjh2aJhjFLmPlP8VIV8Nk2afyfcHCCDTJC4XxcdUz
 4lEcK/9J/qw8hDGDgqFJcOqRvODt+8rz8z2kss5w3DaWufvFb1XhMKN+DFJan//H8R
 z+u8mGt5M5h70J79+1myGHYJ5wGJcUBG6oESHpPN+tH6YLreZaWTSlRAo4aZ8+3b/J
 bbU2Xe09NdMog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] lib/fonts: Add font_glyph_cursor() helper
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260911094518.78093-5-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:52:03 +0000
Message-Id: <20260911095203.F32891F000FF@smtp.kernel.org>
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

> The new helper font_glyph_cursor() fills a glyph with a cursor pattern.
> As with the font_glyph_rotate_*() helpers, the caller has to provide the
> output memory.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094518.7809=
3-1-tzimmermann@suse.de?part=3D4

