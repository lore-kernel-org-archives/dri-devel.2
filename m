Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8984C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C9D10F1C7;
	Wed,  2 Sep 2026 12:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="d48l6CX7";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2821910F1C7
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788353881; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TNfp49qO7PvOKNrTb6rndr+1NMxKl8IzE8OWTqpiduwHmBiqwHZu77OMJzQLoyz3PJB+m2ETbNBw+pv4/t52VKTZ0vTMn9yCEa1ExY8rnSeNfuSrJ+UNRKZDtkuvLBCBC4VbSeNJz0l4Ae0Oyx9RP5J3KREsjxDm4gMfEQcu7nA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788353881;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yOJpG0Rfo6IlzDSpX446zUyUkwOc+K8U7rIyIPg3QS0=; 
 b=AV+jSc3gRzrEMCHUncWW7+ysFtx3SZmYHcLgRXlbdQmssLzIGTAM1nOHPONIFrLm2w2AvJCp3E+tyBHllmY2P5jnLyUvPk4mxIUrvrQ3WUjQF7YeBPqG1heA5odwGnaY7ihzN+kjgk78goh4rF+3reBje8BnfbPmwtW11pIhy4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788353881; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=yOJpG0Rfo6IlzDSpX446zUyUkwOc+K8U7rIyIPg3QS0=;
 b=d48l6CX7/B2l24rgs+6vOh9aeKM9cm/DHx9PAp2TYn2ySkldkxFkjjMPlTUfzJEK
 ru01TAWEMCPhB6NaP9PLQW3uQMimZNTRjiReYBEomoI92TcwQXjvvbAXtfg5wcl7ySz
 UIAIe2cHFjzuSw79RLntBIQ/S0o4fhYWJI18WYvY=
Received: by mx.zohomail.com with SMTPS id 1788353879250420.3222580292204;
 Wed, 2 Sep 2026 05:57:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/9] rust: sizes: add SZ_4G constant
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260902-tyr-ioctls-v1-1-e0fdbf8bd108@kylinos.cn>
Date: Wed, 2 Sep 2026 09:57:40 -0300
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 Alvin Sun <alvin.sun@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39DEB659-59A2-43D6-9B62-805DB3715F49@collabora.com>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-1-e0fdbf8bd108@kylinos.cn>
To: sunke@kylinos.cn
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 1 Sep 2026, at 13:09, Ke Sun via B4 Relay =
<devnull+sunke.kylinos.cn@kernel.org> wrote:
>=20
> From: Alvin Sun <alvin.sun@linux.dev>
>=20
> SZ_4G is used by the Tyr driver when splitting the GPU VA range into
> user and kernel regions.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> rust/bindings/bindings_helper.h |  1 +
> rust/kernel/sizes.rs            | 12 ++++++++++++
> 2 files changed, 13 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 1124785e210b3..3c37993991b1e 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -110,6 +110,7 @@
> const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D =
ARCH_SLAB_MINALIGN;
> const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN =3D =
ARCH_KMALLOC_MINALIGN;
> const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
> +const unsigned long long RUST_CONST_HELPER_SZ_4G =3D SZ_4G;
> const gfp_t RUST_CONST_HELPER_GFP_ATOMIC =3D GFP_ATOMIC;
> const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL;
> const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT =3D =
GFP_KERNEL_ACCOUNT;
> diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
> index 521b2b38bfe77..b236573f0792e 100644
> --- a/rust/kernel/sizes.rs
> +++ b/rust/kernel/sizes.rs
> @@ -132,3 +132,15 @@ impl SizeConstants for $first {
> }
>=20
> define_sizes!(u32, u64, usize);
> +
> +/// Large size constants (=E2=89=A5 4 GiB).
> +///
> +/// Only implemented for `u64`.
> +pub trait LargeSizeConstants {
> +    /// `0x1_0000_0000`.
> +    const SZ_4G: Self;
> +}
> +
> +impl LargeSizeConstants for u64 {
> +    const SZ_4G: Self =3D bindings::SZ_4G;
> +}
>=20
> --=20
> 2.43.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

