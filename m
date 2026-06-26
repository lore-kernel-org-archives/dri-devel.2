Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B61CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E4D10F5A7;
	Fri, 26 Jun 2026 12:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PSk1VX0j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1B710F5A7
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:06:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2517A443AD
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D301F00A3A;
 Fri, 26 Jun 2026 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475606;
 bh=iQHll4fNCXfd6f4+kL5wZcP/YzHyRXJ8oW0X4JpAqbU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PSk1VX0jaM8kR5QJp+2sod5/S55T6+E/BVptY3mPRtxWoGJy+srdMEn90F5l3t7lO
 0dZatOFhftEYd5jns+gL+rum4Axu6HVe/bbdztBIyYH2vkdvzPyTQsJCl+phFJHtMV
 ogJUbPBuQ3Ezk+ZabiU3BduC2BWtIIbYCiiiiZNtuFUUVbgYOXsVRCaYt+vEz6r8hg
 it/9QF3ingtAHrqw/tH2uwW/0YoBGYXNmtbLvqJRHLYdSANQWKVwC2GwPTVWcZBFFz
 VdCty6A7ut/T2/wKlgjG99jgjgWoxiqznuWLiVAfjE8gvfTn2VeipqzgFX4k4e6R6E
 klVe81UQ87zsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 7/8] rust: Add `OwnableRefCounted`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 ojeda@kernel.org
In-Reply-To: <20260626-unique-ref-v19-7-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-7-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:06:45 +0000
Message-Id: <20260626120645.B8D301F00A3A@smtp.kernel.org>
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

> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> Types implementing one of these traits can safely convert between an
> `ARef<T>` and an `Owned<T>`.
>=20
> This is useful for types which generally are accessed through an `ARef`
> but have methods which can only safely be called when the reference is
> unique, like e.g. `block::mq::Request::end_ok()`.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Fix formatting, update documentation, fix error handling in
>   examples. ]
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D7

