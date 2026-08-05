Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5529CC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A5710EF60;
	Wed,  5 Aug 2026 16:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FsHq6Rir";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352F010EF64
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:46:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C475D4082A;
 Wed,  5 Aug 2026 16:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500281F00A3A;
 Wed,  5 Aug 2026 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948372;
 bh=gEL68mjnWiqmUcoRyhQdbilUsRYelV9MmT9U4J/YaYM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FsHq6RirXU40VoJTn7yUZpFaiPVBjNnKjqtnTCpW5pH1KfF1LLrP1W4UwAbnJ9PyX
 c47WDxdXXw+tHgbB3hA28spbpT7Ug2LrCjUjimiNed2QfNWWTxKlICCkAvA2P7o5US
 vVi2xHlugmDaas9+Bra1hFmZlrP1+hnpgOGQelFXu/0/WQrmoAs+CgCG9JqaeTEzdm
 iy2aDRXxudzq7DZf5G4jatzJ9E/UT9OMWxJIxedLI9D8lu7XzbA4xwXxIwl70/MiGK
 PKiPZmJMxVxPxTYPVBJe2JvwE8UJVhpHhRMSMg5yU1xh5wpLmEEwunpCMw1+wq2ejL
 EbVPUFfc40RPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:46:11 +0000
Message-Id: <20260805164612.500281F00A3A@smtp.kernel.org>
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

> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` and
> update PFALCON and PFALCON registers to be fixed register on them and not
> relative registers on `NovaRegisters`.
>=20
> Update `Falcon` struct to store projected views when constructing and
> access with `self.pfalcon` and `self.pfalcon2`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D12

