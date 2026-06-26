Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E6C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8168210F645;
	Fri, 26 Jun 2026 15:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AvbzoTjB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE1D10F645
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:03:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C89C7415E8;
 Fri, 26 Jun 2026 15:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DF81F000E9;
 Fri, 26 Jun 2026 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486196;
 bh=DydvaVcIYpBYhCA/4Yjj5+MV7fAZ2c7GCn63eHsHmOQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AvbzoTjBANXMK5Tm4IbjQpMiZg4dlzHgRmfr/z5MxYhZFFeHYzEEjEEs8i/UsAn9p
 802frsbHjg/m9Je/03yOtDAvjM2kkmgvzXRqiab/QxtdQoNVyRPkV17LOBbrWlvsfz
 WHWT40jvNqHRWG6yfqGX2jTHpFCF2JXjTW4tpSkBtjCHjoTtT+dlM82o7m9X8GM9iD
 HRLPblUxCGnAb4O4aNoCGcaGX0/JszyE7nyYlA5P35j3c5lb9EKQJ8hn9Y5FHeB9hA
 S2dBLIZct9Xj056w0ZSJTEdfKrHmgjn0h64sQJnmMNMZCUXM+suGgCn3gnMd6eA+iE
 JEI06mOHiQdJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/20] rust: io: restrict untyped IO access and
 `register!` to `Region`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260626-io_projection-v5-3-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-3-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:03:13 +0000
Message-Id: <20260626150315.60DF81F000E9@smtp.kernel.org>
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

> Currently the `Io` trait exposes a bunch of untyped IO accesses, but if t=
he
> `Io` region itself is typed, then it might be weird to have
>=20
>     let io: Mmio<u32> =3D /* ... */;
>     io.read8(1);
>=20
> while not unsound, it is surely strange. Thus, restrict the untyped metho=
ds
> and also the register macro to `Region` type only.
>=20
> Implement it by adding a generic type to `IoLoc` indicating allowed base
> types. This also paves the way to add typed register blocks in the future;
> for example, we could use this mechanism to block driver A's `register!()`
> generated macro from being used on driver B's MMIO. The same mechanism
> could be used for relative IO registers. These are future opportunities,
> and for now restrict everything to require `IoLoc<Region<SIZE>, _>`.
>=20
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@n=
vidia.com/
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D3

