Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198BFC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743FC10EB8A;
	Tue,  1 Sep 2026 17:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V6qsq9L5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F25310EB8A
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:02:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 479C942004;
 Tue,  1 Sep 2026 17:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDD41F000E9;
 Tue,  1 Sep 2026 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788282126;
 bh=RzSJb02HAiI7ZXWz5/Frw1NDIqIy6zNSBRQbsI50Orw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V6qsq9L5HMg4Hgr6ZtUIqxBHI3JhAtH4y3HlljoZ1vKxhh1i+qH1dKezF7Ra/EfgU
 ZayHZa1oSK6unQ5Lodcb7i6Em8pBLxT7n8kiNiB6yqHTNFKAd0nM465S9qFUZ7z2ns
 P1xtA+tcyyww6UPsuKMV5m+IISoC61rXtsqqiHbB8ZwgIx8gt07luBsOv6holggjZU
 RpyMe6Fo/IxfL6EZgrTwySk5Muf+FHZmcYQ+nR+/srEpP1z4tjdg4qaFOToCBoLm/5
 TfdIjhjNuRyPTAZMb78ns5EeUeqFlecnOTBE7AcfK58LbWHSXscOWQ+AqrZN+63MXw
 rsfsyiPe/xaPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/16] rust: io: register: support fixed offset
 register without bitfield
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-11-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-11-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:02:05 +0000
Message-Id: <20260901170205.BFDD41F000E9@smtp.kernel.org>
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

> Add a rule to allow creating `IoLoc` in `register!()` using an existing
> type and not create a bitfield. Add an example to demonstrate this for FI=
FO
> registers.
>=20
> This rule is also going to be used to create subregions for registers; the
> example of doing so will be added later when relative registers are
> removed.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D11

