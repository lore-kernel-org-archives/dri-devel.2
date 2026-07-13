Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8494C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABA510EAEF;
	Mon, 13 Jul 2026 20:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RdmZ99nA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB8E10EAEF
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:29:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B42B60103;
 Mon, 13 Jul 2026 20:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F301F000E9;
 Mon, 13 Jul 2026 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783974547;
 bh=fV7OXG0XY8ASWWbWgLtPwia7xSPFHx9Cd77aaSkr+gI=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=RdmZ99nALpM8SurJ92B5g4eVuw4u6Sd5yULrVRX4pwkMKCkLXqljZPLDdITkMKfce
 0GUTr+YsugBMCjpHdiQdT9w2d3Gg8DpDJbaNo71lHltsP1vvUiur9uoZr/HiFQYILM
 4zxl7a5QnnNecDrQR5FzA3qTEL13V/T9RpxZxqjfj0vjUwYM3UlxIvklmmsCBZN4Wr
 l34mK+hPr0xOjOxd5jwQbqPc456BLFNsLOunY1Sz590IIcw8uIe/guBEDVHtT2sx6N
 mhDgPQbalDVo9pQwBVnA5TgL7pgkHzUYJacLXkZruRdBA7uivbUFeZQDVxBzfJ5VyX
 qWGWdwyDO5cdw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 22:29:01 +0200
Message-Id: <DJXQ72BQ9CJY.3U4YFYKGYEEKU@kernel.org>
Subject: Re: [PATCH] rust: device: make lifetime on `Core` and
 `CoreInternal` invariant
Cc: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Eliot Courtney" <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260713201455.640151-1-gary@kernel.org>
In-Reply-To: <20260713201455.640151-1-gary@kernel.org>
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

On Mon Jul 13, 2026 at 10:14 PM CEST, Gary Guo wrote:
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index b3c91731db45..b603b0bd2692 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -285,10 +285,10 @@ pub(crate) struct Gpu<'gpu> {
>  }
> =20
>  impl<'gpu> Gpu<'gpu> {
> -    pub(crate) fn new(
> -        pdev: &'gpu pci::Device<device::Core<'_>>,
> +    pub(crate) fn new<'a>(
> +        pdev: &'gpu pci::Device<device::Core<'a>>,
>          bar: Bar0<'gpu>,
> -    ) -> impl PinInit<Self, Error> + 'gpu {
> +    ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {

Isn't that edition 2024 only?

>          try_pin_init!(Self {
>              device: pdev.as_ref(),
>              spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {

I think you also need this hunk:

diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 1f59e08aaa4b..6fe94a73c52a 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -147,7 +147,7 @@ fn build_inner(dir: &Dir) -> impl PinInit<File<Mutex<In=
ner>>> + '_ {
         dir.read_write_file(c"pair", new_mutex!(Inner { x: 3, y: 10 }))
     }

-    fn new<'a>(pdev: &'a platform::Device<Core<'_>>) -> impl PinInit<Self,=
 Error> + 'a {
+    fn new<'a, 'b>(pdev: &'a platform::Device<Core<'b>>) -> impl PinInit<S=
elf, Error> + use<'a, 'b> {
         let debugfs =3D Dir::new(c"sample_debugfs");
         let dev =3D pdev.as_ref();
