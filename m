Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DF3C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D9E10E54B;
	Mon, 24 Aug 2026 11:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mrPWCFhO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A7910E54B
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:22:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38FEE4321C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF251F000E9;
 Mon, 24 Aug 2026 11:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570550;
 bh=Oj0jMTC8srQp5zygQ/Wdg+FroDjsgNjFW4EaDOOL0Hw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mrPWCFhONEM7d4PKE749JmcAWxgmaaVHvsGp7+VfZBQjEj2IuzXjJn/LJucfNnp1L
 T9IQ9freoHIpleQRoOO8rtnIUoeD6LBCXgW1l+rVczRat/c/aJaGH6ef9CeC+gMtEy
 qZEfgNO0qmPwuLoDhMFlWMy9AxNAxiOZL8PSWnFI8gREKaNPBY+7yt3w0woexCWMdv
 y8T5BHujsDp7mPO7g47mVPNx00aO+keP+roz3wiu/3hmUssf45XykAqmzRlReQHucS
 quYB09luaJ2PNPaIeaYG43jOKKpyceW1FkYljknqxJbPAUrDPAyBUfb0dTF77cWqIi
 R5zZPMwEqd7Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 1/8] rust: alloc: add `KBox::into_non_null`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260824-unique-ref-v20-1-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-1-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:22:29 +0000
Message-Id: <20260824112229.CEF251F000E9@smtp.kernel.org>
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

> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D1

