Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E90CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A129710ED0A;
	Mon,  5 Oct 2026 13:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TvKeMfOu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E223B10ED0A
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:35:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A029C41AB6;
 Mon,  5 Oct 2026 13:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB781F000FF;
 Mon,  5 Oct 2026 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791207322;
 bh=drDTHZXJJjUYfOxaT94bjl7XeRp11f4RZ7YY4F2GMig=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TvKeMfOugFVoJ11748OnUQ4r18JWCxu3BnrnkSsfL6T53aSo96W0wNmtcIwtKssUf
 R0xu6HRwpjxs58IfzM0qM8BMKUIFPnABLOZYVi4o4wEF56LBZjpoJZJRbcZziozFoI
 WNWNTYA1oOilUKSlMNvU1Wg3GRp877xtmh/5RYCRFNibyvWhc5UTUowYI0hbKdMPp3
 7qs0I/hkodIx6UyNtTbMIkajQDRXnjHCBuuJiyA0jJaEWJCEAqnSAa5VWEwE03rtq8
 dqmmms6GoW/lvHfJN8irz2FFo+R68sQGapf30Qw64UHcmM7nS620T2Nb2Fhd/xLe/S
 AyxLlELm9Zx7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] vgacon: Remove trailing whitespaces
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20261005133335.344302-3-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:35:21 +0000
Message-Id: <20261005133522.4FB781F000FF@smtp.kernel.org>
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

> Fix coding style.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D2

