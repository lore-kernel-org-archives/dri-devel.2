Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD9606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1hbxWM8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B379310E949;
	Tue, 10 Nov 2026 15:37:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7096110F1AD
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:37:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5323663473;
 Tue, 10 Nov 2026 15:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723A71F008A1;
 Tue, 10 Nov 2026 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794325061;
 bh=AgzWKwmUgDmGY0LNSysbPTD1wk8P1adOL9USn2GvpRE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F1hbxWM8fza/F9Wq8DFIwmsXScaCPJJqS+Y4qBpJOK808vvt5k9V5asBjRu1eZQOS
 qkVEoCz3aKzgWFe0fvX8a+bvtTCgrr/N6i+5QbSrKzbKzuW3cb4oLQhHeH8Q7S6EP5
 lC5CAOUaTN7x8vFEUa1wCk7VG20UkjMsPNJjXKwoBMiYmwQShJ47TpyGpBUr04YT7v
 jvLNoXZHbkYJj5iluLeBQAITntXA2XCdqZSVXSYTb0UJlP7zOGcabSrJN1pYhy0IAV
 57BSapqLBILp6Oz/nxUM/O4++KZirRGaO7iMxEezVbr8BcPbbO7xXwJyRNNXxdZ42o
 zNdJtyv9H6kDw==
Message-ID: <sashiko-outbox-207273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: nova-core: use pin-init self-referential support
To: "Danilo Krummrich" <dakr@kernel.org>, acourbot@nvidia.com,
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org,
 gary@garyguo.net
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20261110152746.140351-1-dakr@kernel.org>
References: <20261110152746.140351-1-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 15:37:39 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] gpu: nova-core: missing PCI device cleanup in probe() [1]
--

commit 29c3fdaf952e7762e87f691bed7be2d19d9871ac
Author: Danilo Krummrich <dakr@kernel.org>

gpu: nova-core: use pin-init self-referential support

This commit replaces unsafely derived self-referential borrows in nova-core
with pin-init's self-referential support.

Link: https://lore.kernel.org/all/20261008-dev-selfref-v2-0-e280b3c8fba5@ga=
ryguo.net/ [1]

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 560a70c4f5a7d..ac5a9d9f83313 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs

[ ... ]

> @@ -129,44 +131,25 @@ fn probe<'bound>(
>                  crate::irq::doorbell_test::run_selftest(pdev, bar, spec.=
chipset)?;
>              },
> =20
> -            // TODO: Use self-referential pin-init syntax once available.
> -            gpu <- Gpu::new(
> -                pdev,
> -                // SAFETY: `bar` is initialized above, pinned, and outli=
ves `gpu`.
> -                unsafe { &*core::ptr::from_ref(bar) },
> -                // SAFETY: `bar1` is initialized above, pinned, and outl=
ives `gpu`.
> -                unsafe { &*core::ptr::from_ref(bar1) },
> -            ).pin_chain(|_gpu| {
> +            gpu <- Gpu::new(pdev, bar, bar1).pin_chain(|_gpu| {
>                  #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
>                  _gpu.run_selftests(pdev);
>                  Ok(())
>              }),

[Severity: Medium]
This problem wasn't introduced by this patch, but does NovaCoreDriver::prob=
e()
leak the PCI device enable count and leave bus mastering active [1] if a
later step in try_pin_init!() fails or when the driver is unbound?

Earlier in the initializer block, probe() enables the device and bus master=
ing
without a cleanup guard or devres management:

drivers/gpu/nova-core/driver.rs:NovaCoreDriver::probe() {
    ...
        try_pin_init!(NovaCore {
            _: {
                pdev.enable_device_mem()?;
                pdev.set_master();
            },

            bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")=
?,
    ...
}

If bar mapping, Gpu::new(), or auxiliary registration fails, or when NovaCo=
re
is dropped on unbind, nothing reverses enable_device_mem() or clears bus
mastering.

[1] https://sashiko.dev/#/bug/linux-c8fbc048-c40f-4093-b156-461f41a6e9fe

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110152746.1403=
51-1-dakr@kernel.org?part=3D1
