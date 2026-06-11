Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E074CD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A134010E82B;
	Thu, 11 Jun 2026 18:37:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K0azF+7T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A0D10E82B
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:37:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF84A403FC;
 Thu, 11 Jun 2026 18:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C70D1F00A3D;
 Thu, 11 Jun 2026 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781203060;
 bh=Ft1ihQMfKPgKz5iJY84BNeV3QYrti5OcakjOiiYmEkY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K0azF+7TawBPLeB5u8uUV1+lNWrFKIldC0TPXUQLjhxgc3utwp0sFjatFDOByMJnW
 llQ/wZzvzP0bES1hw/Q0TWzngCl4S2JZBCTuLD1dRJxs29eFQccEktbGvJvb+ImyEX
 S9+1tCZaS0KrP8Pia4y6II59NvNO7UIBtas1Xu/A5Gheqdgftjb7RbHvV70/1QsT70
 RUOtVQqUgs+7ydfGTMrfvnf4js5J39nT3ZjdpKpBFXg1lp6uzYQbk/HQAb5gExTCop
 JqZCs8bEH92S2S/3x2fzSAy24WWs0jo8pfpwpDS4laoHYYJx49XUJPMQG+M2o+AcUT
 Yo3tEkigMjcqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260611-io_projection-v4-16-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-16-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:37:40 +0000
Message-Id: <20260611183740.8C70D1F00A3D@smtp.kernel.org>
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

> Provide `read_val` and `write_val` that allow I/O views to be accessed wh=
en
> they're narrowed down to just views of primitives.
>=20
> This is used to provide `io_read!` and `io_write!` macros, which are
> generalized version of current `dma_read!` and `dma_write!` macro that wo=
rk
> for all types that implement `Io`.
>=20
> Note though `io_read!` and `io_write!` only works if backend implements
> `IoCapable` for the type; which is typically only implemented for
> atomically accessible primitives. `dma_read!` and `dma_write!` currently
> supports them via `read_volatile` and `write_volatile`; this can be
> undesirable for aggregates as LLVM may turn them to multiple instructions
> to access parts and re-assemble, even if they could be combined to a sing=
le
> instruction. Thus, `io_read!()` and `io_write!()` does not fully replace
> `dma_read!()` and `dma_write!()` in this scenario. The ability to
> read/write aggregates (when atomicity is of no concern) is better served
> with copying primitives (e.g. memcpy_{from,to}io).
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D16

