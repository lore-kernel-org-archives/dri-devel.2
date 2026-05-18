Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A39CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B10B10E02A;
	Mon, 18 May 2026 10:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m8Lkslkv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4525F10E02A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:10:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9137160125;
 Mon, 18 May 2026 10:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434D8C2BCB7;
 Mon, 18 May 2026 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779099047;
 bh=aUORUiqrvW7zb9bXPpjnpLQLn0KymJQcaxGWHgaAmr0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=m8LkslkvKrksMa89hR8I0c0EtoABcua57UIZhTq3aPPc91iVfYZFRqZI0hihuCt+Y
 4pCAySTfDl9vQPiblQKGlvTFggbl95kqdeVodd6OwZbq2gqvZh+jf9XCadgm4YAzz2
 vOp6uwgbEoC9tmL6skOuFnM1NjkJiuU0RjIBPyFdILqzb235d0R4C4Ad3owCNbPdzm
 YEuV3el9nB/OtJ0WWvmbsk2Ce59Ize/wEgngaANsQFXpLdSdgymelxm61UEl/mpORp
 I1FraZNchONMJzzMotAo+5oOLX7lk6gBhUJhj2Tk+XJB8Dsi84nDI5CpEuj4qTGOOd
 yWC1rDHsoPNxQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 12:10:42 +0200
Message-Id: <DILPZ57SSUVY.39LBSOQ8OL268@kernel.org>
Subject: Re: [PATCH 12/13] drm/tyr: add vms and gpuvas debugfs interface
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
To: "Alvin Sun" <alvin.sun@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
 <20260326-b4-tyr-debugfs-v1-12-074badd18716@linux.dev>
In-Reply-To: <20260326-b4-tyr-debugfs-v1-12-074badd18716@linux.dev>
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

On Thu Mar 26, 2026 at 7:53 AM CET, Alvin Sun wrote:
> +/// Writes VM debug information for the "gpuvas" debugfs file.
> +fn show_vm(vm: &Vm, f: &mut impl Write) -> core::fmt::Result {
> +    writeln!(
> +        f,
> +        "DRM GPU VA space ({:?}) [0x{:016x};0x{:016x}]",
> +        vm.gpuvm.name(),
> +        vm.va_range.start,
> +        vm.va_range.end,
> +    )?;
> +
> +    let kva =3D vm.gpuvm.kernel_alloc_va();
> +    writeln!(
> +        f,
> +        "Kernel reserved node [0x{:016x};0x{:016x}]",
> +        kva.addr(),
> +        kva.addr() + kva.length(),
> +    )?;
> +
> +    writeln!(f, " VAs | start              | range              | end   =
             | object             | object offset")?;
> +    writeln!(f, "-------------------------------------------------------=
------------------------------------------------------")?;
> +    for va in vm.gpuvm_core.lock().va_mappings() {
> +        f.write_fmt(fmt!(
> +            "     | 0x{:016x} | 0x{:016x} | 0x{:016x} | {:18p} | 0x{:016=
x}\n",
> +            va.addr(),
> +            va.length(),
> +            va.addr() + va.length(),
> +            va.obj().as_raw(),
> +            va.gem_offset(),
> +        ))?;
> +    }
> +    Ok(())
> +}

Why is this code duplicated? The implementation already exists in [1].

[1] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/gpu/drm/drm_debu=
gfs.c#L209
