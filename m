Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38D0CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237A110E917;
	Tue, 13 Oct 2026 17:15:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3419710E917
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:15:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CFCB41AC6;
 Tue, 13 Oct 2026 17:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A879A1F00893;
 Tue, 13 Oct 2026 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791911743;
 bh=bN4RiUcBpF7GCOc9k2/wLqIH+Z/bMrbk3r/RI458mW4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TX1Kapzpk0Q9Rdml9RrXlY8RmH7Kb0pThCRGXPtQdC9IL0DCKvZ4AS9aBEqepQpbI
 5d3S9vbqszTfWq/RXcuS+CvAUZwHRL+GyUEf/glr6Bf2faIcymmbxSXqfuuQtgGZT8
 R86TxOfWrGCEmE8aMRiEPYdgR49oV2Iebl264r4jk/UuNUPV/stS4dk0OYgxprilW4
 jB5TFcrTwM9EUXU/urAIeHqJMnqLedq96jQ4aeJ9ruiSRjzYfMKp4O29th7EqtxGlf
 +BOPK1vOg1Gk7+Ta499wrONHxu8kqPAFZ9vS8V0NRm/PS/ikXLoLBn1NdgJP8Wqqak
 Jy1PXPXdSYwZA==
Message-ID: <sashiko-outbox-170200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] rust: clk: replace `OptionalClk` with
 `Clk::get_optional()`
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:15:42 +0000
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
- [Low] rust: clk: missing #[inline] on get_optional() abstraction wrapper
--

commit 796077cfd7119a6144686ab76ca00413f2a3071b
Author: Daniel Almeida <daniel.almeida@collabora.com>
rust: clk: replace OptionalClk with Clk::get_optional()

This commit replaces the OptionalClk wrapper with a get_optional() method
on the Clk struct, as clk_get_optional() already returns a valid struct clk
pointer. The tyr driver is converted to use this new API.

> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index c73fe7c572511..1de2484df8cf5 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs
[ ... ]
> @@ -175,6 +172,25 @@ pub fn get(dev: &Device, name: Option<&CStr>) -> Res=
ult<Self> {

[Severity: Low]
This problem wasn't introduced by this patch, but should this preexisting
function have an #[inline] attribute? According to the Rust subsystem
guidelines, small functions or functions forwarding to a C binding call in
abstraction crates should be annotated with #[inline].

>              })?))
>          }
> =20
> +        /// Behaves the same as [`Self::get`], except when there is no c=
lock
> +        /// producer. In this case, instead of returning [`ENOENT`], it =
returns
> +        /// a dummy [`Clk`].
> +        ///
> +        /// Equivalent to the kernel's [`clk_get_optional`] API.
> +        ///
> +        /// [`clk_get_optional`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_o=
ptional
> +        pub fn get_optional(dev: &Device, name: Option<&CStr>) -> Result=
<Self> {

[Severity: Low]
Should this new function also include the #[inline] attribute? Since it
primarily prepares arguments and forwards them to
bindings::clk_get_optional(), adding #[inline] would align it with the
subsystem guidelines for abstraction wrappers.

> +            let con_id =3D name.map_or(ptr::null(), |n| n.as_char_ptr());
> +
> +            // SAFETY: It is safe to call [`clk_get_optional`] for a val=
id device pointer.
> +            //
> +            // INVARIANT: The reference-count is decremented when [`Clk`=
] goes out of scope.
> +            Ok(Self(from_err_ptr(unsafe {
> +                bindings::clk_get_optional(dev.as_raw(), con_id)
> +            })?))
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-clk-type-s=
tate-v6-0-a5e9977b3509@collabora.com?part=3D2
