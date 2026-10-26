Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA8606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2znGfjk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE4C10EEA9;
	Mon, 26 Oct 2026 12:11:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F3110EEA9
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:11:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFEFA601EF;
 Mon, 26 Oct 2026 12:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885F1F01825;
 Mon, 26 Oct 2026 12:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793016710;
 bh=mPNitt3FocwblgeYuJE6oudtAZGn2jwvulIUmLU4VCo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=V2znGfjkBCROQXAUh7afWPb23gOk8nQqUx0kNFHExrfr/dX8k5FcEKWk2dGaGepcm
 QvJdfMNHqWTowjQsLTMOptXSmVINZm8MR7Jgd3OEJZ7VK/tZxuC69zx0bCSxQADBU6
 akAKnt3VUAQiKfUElxWc+/pbBG12bVW1EFNaBQ6LUSb3oS7GDr7lqG5p38+y35BhVY
 L+Bo/9vPKcgMXw9QNZ2l4RsTF/VJoQInzykW3cl9Ai/oeXtJjJ8lROFR8+Ev8ShZdg
 JvM+V1BRIzJwnJv3ZhPNy7VK2YL+NFQEPUWvp0/RWmKmQ/veCJ0BbyevWKOrh+th2/
 WJm3M9XZ9sVSg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 13:11:47 +0100
Message-Id: <DMERDJZTGIN2.3GG2GSRWTLE2X@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: make bar1 optional
Cc: <airlied@redhat.com>, "Alice Ryhl" <aliceryhl@google.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261026-nova-bar1-option-v1-1-8b43585881a3@redhat.com>
In-Reply-To: <20261026-nova-bar1-option-v1-1-8b43585881a3@redhat.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Oct 26, 2026 at 4:50 AM CET, Dave Airlie via B4 Relay wrote:
> @@ -135,7 +139,12 @@ fn probe<'bound>(
>                  // SAFETY: `bar` is initialized above, pinned, and outli=
ves `gpu`.
>                  unsafe { &*core::ptr::from_ref(bar) },
>                  // SAFETY: `bar1` is initialized above, pinned, and outl=
ives `gpu`.
> -                unsafe { &*core::ptr::from_ref(bar1) },
> +                unsafe {
> +                    match bar1 {
> +                        None =3D> None,
> +                        Some(bar1) =3D> Some(&*core::ptr::from_ref(bar1)=
),
> +                    }
> +                },

This can just be

	bar1.as_ref().map(|b| unsafe { &*core::ptr::from_ref(b) })

> +    /// BAR1 user interface for CPU access to GPU virtual memory, if the=
 device has BAR1.
> +    bar_user: Option<Pin<KBox<BarUser<'gpu>>>>,

Can we please add a TODO to replace this, once we can get rid of the extra
allocation?

> +            bar_user: match bar1 {
> +                None =3D> None,
> +                Some(bar1) =3D> Some({
> +                    let pdb_addr =3D VramAddress::from_raw(gsp_static_in=
fo.bar1_pde_base);
> +                    let bar1_idx =3D crate::driver::bar1_resource_index(=
pdev)?;
> +                    let bar1_size =3D pdev.resource_len(bar1_idx)?;
> +
> +                    KBox::pin_init(
> +                        BarUser::new(
> +                            pdb_addr,
> +                            gsp_resources.spec.chipset,
> +                            bar1_size,
> +                            bar1,
> +                        ),
> +                        GFP_KERNEL,
> +                    )?
> +                }),

I think this could also use map().
