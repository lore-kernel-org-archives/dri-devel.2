Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32697C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8755C10E96F;
	Mon,  6 Jul 2026 12:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UKs6DIHw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7B310E96F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:51:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F6B442B9A;
 Mon,  6 Jul 2026 12:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B451F000E9;
 Mon,  6 Jul 2026 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342316;
 bh=0Nf4KC7VkM1nFbr8or6WkWoO+AGsZ/VqZrO1mvzN4Oo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UKs6DIHwGRqnQ7hI7S/tVpfjqHbeKgKga3o9/G+A91hSgPrI2MT5Zeag1HyUpeMdk
 5YkKkgkqb4mukz4NTQ2Ft8ZRSCnTh3ebHzq2npC7MmwKdT6mJAsUgYSzz+d3rAROLA
 TuOwv4GkaFZbLDxNIVR7yW85DsKc7ukSZvUdy4YEhe3G48PpoDuIsbeC074Dy8TwQX
 VjBE1XoOsBYDAmK8juKnbKjftV0SQY+7o6Nv7nJrOHQdusuESiXErw0e76hpky6hkK
 o4u5gqCEfqpR+RdMpBsy9ImCeHHNJh3H5h9q4UW3AktzBkgt/plyg02GGpBducOCE+
 tCgKivn55NzSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/20] rust: pci: io: make `ConfigSpace` a view
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260706-io_projection-v6-8-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-8-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:51:56 +0000
Message-Id: <20260706125156.99B451F000E9@smtp.kernel.org>
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

> In order to support I/O projection, we are splitting I/O types into two
> categories: owned objects and views. Owned objects have a specific type
> that is related to setting up and tearing down, while views can have their
> type changed with I/O projection.
>=20
> Things like `IoMem` or `Bar` are owned objects, which requires setting up
> mapping and cleaning up on drop. On the other side, `ConfigSpace` is real=
ly
> just a view, as the resource is associated with the `pci::Device`.
>=20
> Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
> view. This means that `ConfigSpace` object now represents a subregion and
> therefore encodes offset (as address of pointers) and size (as metadata of
> pointers) itself. The full region case is still supported with offset 0 a=
nd
> size of `cfg_size`.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D8

