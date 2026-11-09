Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22009606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVVM4NSf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3CD10E662;
	Mon,  9 Nov 2026 02:09:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3533510E662
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 02:09:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AD2661EE8;
 Mon,  9 Nov 2026 02:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AE81F0089F;
 Mon,  9 Nov 2026 02:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794190187;
 bh=AGlA800/A1ayCVptXG9KT/P7KQrv/2x+66sQSAFdyOY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HVVM4NSfe9RiSG+B2HBbNRu2xYaywBPuAqT+22NA+bz+m+vjt93lIMgOrUKELKmO+
 ROCv58H8v0pUjFgI8cO099czmgNc0X3Bqt40thISG2fRdlYws4xqaT59rq0qM2X3TA
 CsSQoeO/YYTCUWfZCmdaFh3MqHDgKAq+tZcZJZBjwvaf9Q6tJ26+HOjRBuXWnip1IW
 puQKiIydj5hcPCKrZrjuPtFmz4AfLwDrwh2V1XShnS1syAa111hr1wftNCGbyHTInn
 qj7v5Rd8uGeHzV9vcPs4JLYtewtotnz3+xHY8uOUIGxGE4/6EPGJDWXLkID4KBK8gi
 U9350heq1pucg==
Message-ID: <sashiko-outbox-204344@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] gpu: nova-core: add support for GPU timer block.
 (v6)
To: "Dave Airlie" <airlied@redhat.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Alice
 Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261109-nova-timer-v6-2-5544a3bd8b28@redhat.com>
References: <20261109-nova-timer-v6-0-5544a3bd8b28@redhat.com>
 <20261109-nova-timer-v6-2-5544a3bd8b28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 02:09:46 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] gpu: nova-core: wrapped timer offset programmed in
  set_sys_timer_offset()
--

commit 7d2284f17f67e098294d4252bcce87d29a2a59b1
Author: Dave Airlie <airlied@redhat.com>

gpu: nova-core: add support for GPU timer block. (v6)

This commit adds GPU timer block initialization for Turing through
Blackwell GPUs to compute the system timer offset for GSP initialization,
including a GH100 FSP ucode version check for bug 3957833.

> diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-=
core/timer/hal/gh100.rs
> new file mode 100644
> index 0000000000000..154c7a301a0c1
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/gh100.rs

[ ... ]

> +fn set_sys_timer_offset(bar: Bar0<'_>, fsp: &Fsp<'_>, time_ns: u64) -> R=
esult<u64> {
> +    let sec_timer_ns =3D sec_timer_read(bar);
> +
> +    let sys_timer_offset_ns =3D time_ns.wrapping_sub(sec_timer_ns);
> +
> +    // Don't set the timer offset registers on buggy firmware
> +    if !fsp.is_bug_3957833_affected(bar) {
> +        bar.write_reg(NV_PGC6_SCI_SYS_TIMER_OFFSET_1::from_nsec(
> +            sys_timer_offset_ns,
> +        ));
> +        bar.write_reg(
> +            NV_PGC6_SCI_SYS_TIMER_OFFSET_0::from_nsec(sys_timer_offset_n=
s).with_update(true),
> +        );
> +    }
> +    Ok(sys_timer_offset_ns)
> +}

[Severity: Medium]
As reported by Alexandre Courbot on v4 [1], can set_sys_timer_offset()
program a wrapped value into NV_PGC6_SCI_SYS_TIMER_OFFSET_1 and
NV_PGC6_SCI_SYS_TIMER_OFFSET_0 when sec_timer_ns exceeds time_ns?

If the host wall-clock time is behind the GPU secure timer, wrapping_sub()
produces a large wrapped u64 that nsec_hi() truncates to 61 bits when
writing the hardware offset registers while returning the unmasked 64-bit
value for GSP initialization.  In OpenRM, tmrSetCurrentTime_GH100 verifies
secTimerNs < osTimeNs and returns early without programming the offset
registers if the delta is not positive, with the caller logging and
ignoring the error.

[1] https://lore.kernel.org/r/DMO7FUYY05LK.123ZPLIW24C2S@nvidia.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-nova-timer=
-v6-0-5544a3bd8b28@redhat.com?part=3D2
