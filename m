Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB8BFED9E4
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705F110E6C0;
	Tue, 17 Mar 2026 15:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lloHfF9u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C13D10E6C3;
 Tue, 17 Mar 2026 15:34:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0780D4340C;
 Tue, 17 Mar 2026 15:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16ADC4CEF7;
 Tue, 17 Mar 2026 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773761650;
 bh=K88ELa4YxbOs7MjkjeqZu/qU8bBxF2QdgopZVhmZDuo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=lloHfF9uR2+D9irKZ+QqRQ3bjpmX1CItoqdE7Pr1fEySw6jkQA+8XV0knu2uMMdP6
 b32te5vMsjUovTfWxXubXftgV6wAT26VtyACVcwzFo6iJgyG406C7UqEyh+0hGme+8
 0dtyhidxBKuhOPZay1TUALmi+NwAQmLkOxi9N4cnrDhIBzxE6E5aSShiMniQ9WXBrR
 aLhuQJjTPYVV8e2aLp/EDAYkrjRVCJr6/tAY4bqtJPwmAa3FlTXNS7aJ0B2fjDkfIw
 TDLeW1bPsVvz4EBA8zPGh3Hy01VXWo8P0ux8oOWEGfHbxt8dbzwXiODpkON3iEeVcT
 K1845x970s2+A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:34:07 +0100
Message-Id: <DH560ZMNK76A.1YFRKZ6FDU4I2@kernel.org>
Subject: Re: [PATCH v3 2/2] gpu: nova-drm: rename nova to nova-drm
Cc: "Cheng-Yang Chou" <yphbchou0911@gmail.com>, <aliceryhl@google.com>,
 <chia7712@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <gary@garyguo.net>, <jserv@ccns.ncku.edu.tw>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <simona@ffwll.ch>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <e7539fd5-9a0d-4a06-aa02-ec3dcd235926@nvidia.com>
 <20260317092304.424377-1-yphbchou0911@gmail.com>
 <DH536IWQDX23.22R0P6FT091LH@nvidia.com>
 <DH53WAJHTQFS.ZSO15BGJLQ8M@kernel.org>
 <DH55S9CU9YCB.2Y3G50LUGSAZF@nvidia.com>
In-Reply-To: <DH55S9CU9YCB.2Y3G50LUGSAZF@nvidia.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue Mar 17, 2026 at 4:22 PM CET, Alexandre Courbot wrote:
> On Tue Mar 17, 2026 at 10:53 PM JST, Danilo Krummrich wrote:
>> On Tue Mar 17, 2026 at 2:20 PM CET, Alexandre Courbot wrote:
>>> On Tue Mar 17, 2026 at 6:23 PM JST, Cheng-Yang Chou wrote:
>>>> Rename the nova-drm driver directory from drivers/gpu/drm/nova/ to
>>>> drivers/gpu/drm/nova-drm/ and the top-level source file from nova.rs
>>>> to nova_drm.rs (matching the object name nova_drm.o) to follow the
>>>> kebab-case naming convention already used by the auxiliary device name=
.
>>>>
>>>> Update MAINTAINERS, Kconfig, and Makefile references accordingly.
>>>> Update the Kconfig help text to reflect the new module name nova-drm.
>>>>
>>>> Link: https://github.com/Rust-for-Linux/linux/issues/1228
>>>> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
>>>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>>> ---
>>>> Changes in v3:
>>>> - Rename subject line (John Hubbard)
>>>>
>>>>  MAINTAINERS                                            | 6 +++---
>>>>  drivers/gpu/drm/Kconfig                                | 2 +-
>>>>  drivers/gpu/drm/Makefile                               | 2 +-
>>>>  drivers/gpu/drm/{nova =3D> nova-drm}/Kconfig             | 2 +-
>>>>  drivers/gpu/drm/nova-drm/Makefile                      | 3 +++
>>>>  drivers/gpu/drm/{nova =3D> nova-drm}/driver.rs           | 0
>>>>  drivers/gpu/drm/{nova =3D> nova-drm}/file.rs             | 0
>>>>  drivers/gpu/drm/{nova =3D> nova-drm}/gem.rs              | 0
>>>
>>> That `drm/nova-drm` reads a bit awkwardly to me and feels unnecessary.
>>> Even `tegra-drm` is in `drm/tegra`.
>>
>> Well, that's why I named it "nova" in the first place, but I don't want
>> KBUILD_MODNAME to diverge from the directory name and I also don't want =
the
>> driver name to diverge from KBUILD_MODNAME.
>
> What is the rationale for that? I like consistency too, but also think
> it is not particularly difficult to figure out that "nova-drm" resides
> in "drm/nova".

It is consistency. But why are we discussing this, what is the concern bein=
g
consistent here?
