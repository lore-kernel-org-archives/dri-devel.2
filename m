Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5065DC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B922310F688;
	Fri, 26 Jun 2026 14:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fiycdi5f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F08310F688
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:53:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97CDF600C8;
 Fri, 26 Jun 2026 14:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E689E1F000E9;
 Fri, 26 Jun 2026 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485638;
 bh=ky/CA2O6RC56KEbujWxESCs6Eo0AP0g1YwCbV0Ddly0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fiycdi5fEvsc/QmsndPNj0a3nWVDcfptpkfypsMkHUkItbvRS+sKFNTqXPgfIXTYv
 IRLuSxsyT1VCphMimZtSDzvnBp6niRM3NyAgvHPCjSmoz8e1Nz4034mdcX7kLdt0jE
 nm3phaClnLe3CVtoHeXKdIKkxrE+ewlCV0+DBATMGxASrlf0B56/MaIyRmXw1BoMYj
 L6W1A5goxn78k9OG3Inkjn0sqjwo4ogSZlfyI77f/Fmc0KoURelqbfuLAQoLdPSTPh
 /WGRM4nKan/svfT90610DhvjThcYbsyyiLzDzopBj2yUvZDRBLLLTPO6yHP8xCAaDe
 gyEh/NJjMDbRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/20] rust: pci: io: make `ConfigSpace` a view
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260626-io_projection-v5-8-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-8-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:53:57 +0000
Message-Id: <20260626145357.E689E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D8

