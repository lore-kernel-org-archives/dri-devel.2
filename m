Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C87606A918
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TerN/uEq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8103D10E0C3;
	Mon,  2 Nov 2026 17:11:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353CC10E691
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 17:11:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05B7741509;
 Mon,  2 Nov 2026 17:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC451F00A16;
 Mon,  2 Nov 2026 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793639511;
 bh=cuQWtJGwnvegdYikr8U6KKYKj8DR4nlIdjuO1a/b6fk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TerN/uEqB6ABewtwZ5RYEEmU6xQW54N2wIeB4MPLQPo2pilZkP0wJlGIV/UkBT1sM
 ptH+43vrfTsWw6dpGlBuKAQmXJ+44Xx079Owk7FdcPf/MAOH+A3L88GtLcKm9c2gx8
 dVsi0VISUH6fxxwzavTB48T8Z8nR6LU61o3oGMlbxjYbfYBOA9ecCazM/pTWtPjMc5
 Coyc1uEvbWipeXistwcEVXOBKcfZjC723r0voETvaq/M1AnMmxzSCjAdLjG8eXQpbZ
 85paAcGOTSU2hQDJvc86zUGBljuk9xZdg4YjVS5dR5M/twAfBjLtUXaxZ4YHeFaYE+
 HIa2fI30AqJ9g==
Message-ID: <sashiko-outbox-193809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] gpu: nova-core: add support for GPU timer block. (v2)
To: "Dave Airlie" <airlied@redhat.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Alice
 Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261102-nova-timer-v1-2-b347ead64469@redhat.com>
References: <20261102-nova-timer-v1-0-b347ead64469@redhat.com>
 <20261102-nova-timer-v1-2-b347ead64469@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:11:50 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gpu: nova-core: GH100 FSP bug 3957833 WAR applied to Blackwell in =
timer_time()
--

commit fd289ae7ae729480f9ef4d6e43c04d6aa8f3dbe4
Author: Dave Airlie <airlied@redhat.com>

gpu: nova-core: add support for GPU timer block. (v2)

This commit adds GPU timer block initialization for nova-core to compute and
program the system timer offset passed to GSP initialization, with HAL
implementations for TU102 (Turing/Ampere/Ada) and GH100 (Hopper/Blackwell).

> diff --git a/drivers/gpu/nova-core/timer/hal.rs b/drivers/gpu/nova-core/t=
imer/hal.rs
> new file mode 100644
> index 0000000000000..7aeff6cdc6787
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal.rs
> @@ -0,0 +1,28 @@

[ ... ]

> +pub(super) fn timer_hal(chipset: Chipset) -> &'static dyn TimerHal {
> +    match chipset.arch() {
> +        Architecture::Turing | Architecture::Ampere | Architecture::Ada =
=3D> tu102::TU102_HAL,
> +        Architecture::Hopper | Architecture::BlackwellGB10x | Architectu=
re::BlackwellGB20x =3D> {
> +            gh100::GH100_HAL
> +        }
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-=
core/timer/hal/gh100.rs
> new file mode 100644
> index 0000000000000..7f55bf04a3f35
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
> @@ -0,0 +1,76 @@

[ ... ]

> +/// FSP ucode version from which on the fix for bug 3957833 is included.
> +const FSP_BUG_3957833_FIX_VERSION: u32 =3D 0x44c;
> +
> +/// kfspRequiresBug3957833WAR_HAL: returns `true` if the FSP ucode preda=
tes the fix for bug
> +/// 3957833 and hence the sys timer offset must not be programmed.
> +fn fsp_requires_bug3957833_war(bar: Bar0<'_>) -> bool {
> +    bar.read(regs::gh100::NV_GFW_FSP_UCODE_VERSION).full().get() < FSP_B=
UG_3957833_FIX_VERSION
> +}
> +
> +fn timer_time(bar: Bar0<'_>, time_ns: i64) -> Result<i64> {

[ ... ]

> +    if !fsp_requires_bug3957833_war(bar) {
> +        let offset_ns =3D sys_timer_offset_ns as u64;
> +        bar.write_reg(
> +            regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::zeroed()
> +                .try_with_nsec(((offset_ns >> 32) & 0x1fff_ffff) as u32)=
?,
> +        );
> +        bar.write_reg(
> +            regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::zeroed()
> +                .try_with_nsec(((offset_ns >> 5) & 0x7ff_ffff) as u32)?
> +                .with_update(true),
> +        );
> +    }
> +    Ok(sys_timer_offset_ns)
> +}

[Severity: High]
Should fsp_requires_bug3957833_war() in drivers/gpu/nova-core/timer/hal/gh1=
00.rs
be restricted to Hopper (GH100) rather than also running on Blackwell?

In drivers/gpu/nova-core/timer/hal.rs, timer_hal() routes Architecture::Hop=
per,
Architecture::BlackwellGB10x, and Architecture::BlackwellGB20x to
gh100::GH100_HAL:

    Gpu::new()
      -> Timer::new()
        -> hal::timer_hal(chipset).init(bar)
          -> Gh100::init()
            -> timer_time()
              -> fsp_requires_bug3957833_war()

In OpenRM, kfspRequiresBug3957833WAR_HAL is an FSP HAL method implemented o=
nly
for GH100 (comparing GH100's FSP ucode version against 0x44c) and stubbed to
return false on Blackwell, which has separate FSP firmware version numberin=
g.

When running on Blackwell (BlackwellGB10x or BlackwellGB20x), if the value =
in
NV_GFW_FSP_UCODE_VERSION is below 0x44c, won't timer_time() falsely trigger
the GH100 workaround and skip programming NV_PGC6_SCI_SYS_TIMER_OFFSET_1 and
NV_PGC6_SCI_SYS_TIMER_OFFSET_0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-nova-timer=
-v1-0-b347ead64469@redhat.com?part=3D2
