Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5DACD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D342310F0C1;
	Thu, 11 Jun 2026 19:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EccGaNFD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCC210F0C1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 19:13:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6991B40682;
 Thu, 11 Jun 2026 19:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14E81F000E9;
 Thu, 11 Jun 2026 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781205214;
 bh=iCtrLGLeaHuKj5zHjis2MgS/7XpFHZqDvQ5PL9vwLts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EccGaNFDGxNT4H7ojB/6WI5pXsuObDhvfIo0SbG/VbkMp+DKCErMXcfgPRnoEYXYz
 EHHrIuO9MzMBIa7kbyJDKBvf7+PDnbxb6OR+iNkxNIE6/QOsQfKO4G3znLw8R3KXe4
 EiyFjpv8C84Hc2sgl0WUM+rl5jwGG9dILPNjC/NdJ3bdiYdHpEaWIlsngrIwdIDGMC
 ue+DcQscLnB935ZxZYjIBDWmmINOC3d3QjopdlcvYR4m8urXdu4Z9H0+IGtt+b2V+p
 LzPGQEj1Wo4F+Dhn18tKjBaQdaa3HhTV8L5tup0mT9jgfuDt810KXcUB7nmExA8rSH
 bCLDYsB0rynKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/20] rust: io: implement `IoSysMap`
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260611-io_projection-v4-20-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-20-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 19:13:33 +0000
Message-Id: <20260611191333.F14E81F000E9@smtp.kernel.org>
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

> Add an enum as sum type for `Mmio` and `SysMem`. This serves similar
> purpose of `iosys_map`. Thanks to Rust's type system, all of projection a=
nd
> struct read/write can be handled by the generic I/O projection mechanism
> (i.e. `io_project!`, `io_read!, `io_write!`) for free, and there is no ne=
ed
> to provide things like `iosys_map_rd_field` or `iosys_map_wr_field`. An
> enum type also makes it very easy to construct or destruct.
>=20
> This could be made more generic by implementing on a general purpose sum
> type like `Either`; however this is kept specific unless a need arises th=
at
> warrants this to be generic over other I/O backends.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D20

