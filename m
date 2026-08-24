Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D83EC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742B910E115;
	Mon, 24 Aug 2026 11:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cPk6SRp+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7B910E115
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:26:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C62240948
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14521F000E9;
 Mon, 24 Aug 2026 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570819;
 bh=tOOXAP0FQlsikOY78xrP0MSwhHJ9C7dKegtzGiN6DGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cPk6SRp+vyNJ7jN3diovEEqTmuusUBodrroeCI5vHsKv5F3z9WZyN/QH5JXuJJzl7
 bsPedpl0Q0chMEIQ4/4TwRkujZHZnNKwTIsGS2D9kRg0oUKcXR+nHx8odkGKwhdx1j
 Sdpoxl6fusKzUupI6pfYaWZ1a5tgE6aGTTdy6DmQxoSg9odQruvanmBIcPvMxCIAW/
 Lua7kxz7qA5AWGMce5WXrNO2K0ZZuqdV2P2u8SPHuV/6n8Pw5g8JG3e5joO+5juoq8
 4gpGTpf/IGy38QDc9qSZ065CGa7OxlMIZhRD/rpHY/nEvpDfCGq9sSUbPbYrIN1KgI
 vbo/uMz2562Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260824-unique-ref-v20-4-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:26:58 +0000
Message-Id: <20260824112658.B14521F000E9@smtp.kernel.org>
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

> From: Asahi Lina <lina@asahilina.net>
>=20
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>=20
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D4

