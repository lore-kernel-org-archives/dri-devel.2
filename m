Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEECC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 277F210E3A1;
	Mon,  6 Jul 2026 14:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NcwXQd4V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A5710E3A1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06B6A60098;
 Mon,  6 Jul 2026 14:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE8F1F000E9;
 Mon,  6 Jul 2026 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783349478;
 bh=gX+RTsEC+E1GOYf4zhyVTJIbyuYEziIUjO504B5vk8A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NcwXQd4V/8nliMpIreKxxHDO5WYCbX3VYdJK+s8E01wqcYvZ4XAtH7u9sP3gHdc7Z
 I7QQKJQVPBEm5AwZGsabmnu5JhfyPu8ibJ/VITGrBK5MqzClEQV9Bx5rjTo7Ob4oB2
 deqt6oLp4+sNV81iwHQFOylNZPG4n0PlTSxfD5+526oQmreQwDUF/K1rSo7885ZXae
 Jx/s07pkej969Yn1WStL4jScwtwY4eVB57n/2iNWUwX1tWBIwxA3rAUr30SHT+x0UH
 m0NRaEEqjeE75aYAwuyTxskz1Lo7fKWHpgqkql6eQkw1H+nR4Suil9viI0Di+nSBLP
 zWkT6b6leB+/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] rust: clk: add devres-managed clks
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:51:17 +0000
Message-Id: <20260706145118.3AE8F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly introduced Rust wrapper `devm_enable_optional_with_rate`=
 exposes a broken error path in the underlying C framework (`devm_clk_get_o=
ptional_enabled_with_rate`) that incorrectly calls `clk_disable_unprepare` =
on clocks that haven't been prepared or enabled, causing unbalanced global =
count decrements and state corruption.
--

commit f2d6842b5aa3017f9a5274d7b455e65224dd1e79
Author: Daniel Almeida <daniel.almeida@collabora.com>

rust: clk: add devres-managed clks

The clk API allows fine-grained control, but some drivers might be
more interested in a "set and forget" API.

Expand the current API to support this. The clock will automatically be
disabled, unprepared and freed when the device is unbound from the bus
without further intervention by the driver.

> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index dd5fd656271e1..b9a44f83843a3 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs

[ ... ]

> +    /// Same as [`devm_enable_optional`], but also sets the rate.
> +    #[inline]
> +    pub fn devm_enable_optional_with_rate(
> +        dev: &Device<Bound>,
> +        name: Option<&CStr>,
> +        rate: Hertz,
> +    ) -> Result {
> +        let name =3D name.map_or(ptr::null(), |n| n.as_char_ptr());
> +
> +        // SAFETY: It is safe to call
> +        // [`devm_clk_get_optional_enabled_with_rate`] with a valid devi=
ce
> +        // pointer.
> +        from_err_ptr(unsafe {
> +            bindings::devm_clk_get_optional_enabled_with_rate(dev.as_raw=
(), name, rate.as_hz())
> +        })?;

[Severity: High]
This is a pre-existing issue, but does exposing this C function to Rust
drivers introduce them to a broken error path?

Looking at the underlying C implementation:

drivers/clk/clk-devres.c:devm_clk_get_optional_enabled_with_rate() {
	...
	ret =3D clk_set_rate(clk, rate);
	if (ret)
		goto out_put_clk;

	ret =3D clk_prepare_enable(clk);
	if (ret)
		goto out_put_clk;

	return clk;

out_put_clk:
	devm_clk_put(dev, clk);
	return ERR_PTR(ret);
}

If clk_set_rate() fails (for example, due to an unsupported rate), the
error path calls devm_clk_put(). Since the devres initialization previously
registered clk_disable_unprepare() as the exit function, won't devm_clk_put=
()
execute it even though the clock was never actually prepared or enabled by
this consumer?

For shared clocks, couldn't this unbalanced decrement of the enable and
prepare counts forcefully turn off the underlying hardware clock while other
consumers are actively using it?

> +        Ok(())
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-clk-type-s=
tate-v5-0-67c5f326a16c@collabora.com?part=3D3
