Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1573FEC01C9
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9AA10E090;
	Mon, 23 Mar 2026 11:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rzIblu2M";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2878B10E090
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:21:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D1F4600AC;
 Mon, 23 Mar 2026 11:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757F6C4CEF7;
 Mon, 23 Mar 2026 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774264888;
 bh=ms8SURZjK2TNwnwC4VHjTeboaZrJo14MJa9t1jjQSjU=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=rzIblu2Mx3mzCx8Tb95ri9WGjs4az9ufrC9qOTQnVXrj3zkA2lMOi8JOO7ZA97dsK
 XjtcZbe1nzWnGGqDCdSZ8O+x/Ga6Uew9vi35dPTkuO519tM2PN5zwfZvAUKjFUrB7Y
 jPfJkZifwjdtkbPB4wcQ/Zgo2pJJhvdVA6yS77iXSgp3PD7Ek80DKss7VksuXGsjGL
 9WL2aqabOgIdUfAXsc2vN+bhAjYcPRPJRaqS06fjMq0dBQSkCkXY5wIX2kHit9zy4q
 aBFFp1JttHtoR7K/nwbikiWLCSQkiY7e9bXLNOs9lWwBXFifVsYno4PNWJNIwYKD8c
 TyU7RO7URnWZQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 12:21:21 +0100
Message-Id: <DHA4EQAOO8QW.3AFGNJZFQX6N7@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 01/10] gpu: nova-core: convert PMC registers to
 kernel register macro
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
 <20260323-b4-nova-register-v3-1-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-1-ae2486ecef1b@nvidia.com>
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

On Mon Mar 23, 2026 at 12:07 PM CET, Alexandre Courbot wrote:
> -impl TryFrom<u8> for Architecture {
> +impl TryFrom<Bounded<u32, 6>> for Architecture {
>      type Error =3D Error;
> =20
> -    fn try_from(value: u8) -> Result<Self> {
> -        match value {
> +    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
> +        match u8::from(value) {
>              0x16 =3D> Ok(Self::Turing),
>              0x17 =3D> Ok(Self::Ampere),
>              0x19 =3D> Ok(Self::Ada),
> @@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
>      }
>  }
> =20
> -impl From<Architecture> for u8 {
> +impl From<Architecture> for Bounded<u32, 6> {
>      fn from(value: Architecture) -> Self {
> -        // CAST: `Architecture` is `repr(u8)`, so this cast is always lo=
ssless.
> -        value as u8
> +        match value {
> +            Architecture::Turing =3D> Bounded::<u32, _>::new::<0x16>(),
> +            Architecture::Ampere =3D> Bounded::<u32, _>::new::<0x17>(),
> +            Architecture::Ada =3D> Bounded::<u32, _>::new::<0x19>(),
> +        }
>      }
>  }

Can this use bounded_enum!()?
