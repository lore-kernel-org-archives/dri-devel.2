Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97F8C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249F310E96B;
	Mon,  6 Jul 2026 12:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lCMC/T8g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF7010E96B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:51:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 229DE41994;
 Mon,  6 Jul 2026 12:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9611F000E9;
 Mon,  6 Jul 2026 12:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342274;
 bh=X+2qgwVuOVgbZOSZiRUEmxRy75ATRaztorH5FdNs/3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lCMC/T8gLWac2RjtwdWkYaYX61/99bB6Ji1ciMMj/d31+7J+ctti4H+lp5SgFFL/x
 HXa8HdeUHbJUTsKo5Io8yAKrDs2z2VNCpAYQK2toRmjzSF09NUCm41bG4wxJB/WD6z
 2D6sM/qblHlvntbsonVkKxy6O2yfucd3giB03eNLJEAEEmNyLfg8smtCGm7lQULA6C
 a/HkADaSaiO8YuxFRCpbLYhix7fPuVCha8hlCxmJauqVrn3le1pVT3X9YuBjCIzz62
 TlIsV5qMAHeh8ojwR3tjXt33qPHeKQB0iK0scTvK5YQLPDBS9B1J2koJ/qWfByK8kd
 frVvZ4c/NWkKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/20] rust: io: move `Io` methods to extension trait
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-io_projection-v6-12-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-12-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:51:12 +0000
Message-Id: <20260706125113.AA9611F000E9@smtp.kernel.org>
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

> `Io` trait now has a single required method with many more provided
> methods. Provided methods may want to rely on their implementations to not
> be arbitrarily overridden by implementers for correctness or soundness.
> A good example is the `size` method, it may be relied by unsafe code and
> thus must be consistent with the metadata obtained from `as_ptr`.
>=20
> Thus, create a new trait to host `size` method, extract existing provided
> methods to the new trait, and provide a blanket implementation. This
> pattern is used extensively in userspace Rust libraries e.g. `tokio` where
> `AsyncRead` has minimum methods and `AsyncReadExt` is what users mostly
> interact with.
>=20
> To avoid changing all user imports, the base trait is renamed to `IoBase`
> and the newly added trait takes the existing `Io` name.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D12

