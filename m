Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27567C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8418610E287;
	Mon,  6 Jul 2026 18:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X0altrg5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DAF10E287
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:24:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5447414A2;
 Mon,  6 Jul 2026 18:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5C71F000E9;
 Mon,  6 Jul 2026 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783362260;
 bh=K/KkssBkhVgVIh46vkgI/nfxUkz9E1mOUlteTTNrRQg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=X0altrg5cGkWWna0S88PwdclgEGysCeir7KByOyCtWwvE8QkaKpU1OXjsjAE+sHL5
 8+S0cKpw4krOJB+UOUwSM6ythlk0vw5iDkkYrtesu5yv1o2dVyT6Bmd/sjWOLYNMdr
 LSraJrEou3DMCPIKPw93IV0jLI0kRuISpKiQhFY80M+j0N4Cd5PvXSgDUM0LAEEpNy
 4vsDiaITAqvhGB/GKfVx5lB3cndYQ9q6dfgLC3lm+r/6miX3dq3nRE5DK+QiiV5y4x
 3EO4YQ8cR/pgGtok98JAYsJqfuemDpo9m42KB+gNOolV7It0M3CsU8vggfJceYu0XQ
 dyci2uzFsk5+g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 20:24:16 +0200
Message-Id: <DJRP5QO5JKVT.Y7LCZARVCWJ8@kernel.org>
Subject: Re: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
Cc: "Alistair Popple" <apopple@nvidia.com>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>, "John Hubbard" <jhubbard@nvidia.com>,
 "gary@garyguo.net" <gary@garyguo.net>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "lossin@kernel.org" <lossin@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "aliceryhl@google.com"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
To: "Timur Tabi" <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-4-apopple@nvidia.com>
 <59948bff927bd4ad3af5fbe68d5d5e7565c5f729.camel@nvidia.com>
In-Reply-To: <59948bff927bd4ad3af5fbe68d5d5e7565c5f729.camel@nvidia.com>
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

On Mon Jul 6, 2026 at 7:35 PM CEST, Timur Tabi wrote:
> On Mon, 2026-07-06 at 15:34 +1000, Alistair Popple wrote:
>> @@ -38,6 +38,7 @@ pub(crate) fn get_param(
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let value =3D match get=
param.param as u32 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uapi::NOVA_GETPARAM_VRAM_BAR_SIZE =3D> pdev.resource_len(1)?,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uapi=
::NOVA_GETPARAM_GPU_CHIPSET =3D> reg_data.api.chipset() as u64,
>
> Can we assign these IOCtl values to match Nouveau as much as possible?  I=
 think it would make
> everyone's life easier if we could use the same user-space tools/librarie=
s for Nova that we do for
> Nouveau.

I don't mind using the same numbers where it doesn't matter too much, but f=
or
this to work, it would also require us to retain layout compatibility with
structures, semantics, etc., which I think we should not bother with at all=
.

Let's build a clean new uAPI, it will get messy over time by itself. :)
