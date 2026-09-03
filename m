Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2256AC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E10610F7BD;
	Thu,  3 Sep 2026 22:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="C8AufTuH";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B6210F7D1
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 22:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788473213; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=R6bG7hdiDiKlEIgrX3xMgWzJwRMGsftITsN+MI8KcXwvHksT/f6eZ+8jr2s7TAvHdrVVzR4+Urpo34vxL5TpFw24bUjI2Fnb73NQkOZW1mJFCkfeR1DZlR56k0zx81GJLzDmeIEyhFUMgqTY/n6v2cJhMphmq8IsVeDuKiywRKI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788473213;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=afA3ax7f9QXcCedQi5bAM/QoI2EIiapIQDf4xdId4Ug=; 
 b=e03QYNDF1BzCbkp3Z6v8qmmYuONMENPFbUos06vuaYO4Cp8ZtKipFRSSeig4Xav2jk55S4104gDYbDjWBGOB09QyaFmGQT4pEEIuhqqXjHSQKLM9aVNqgvFuMffT7PR1hHX9djHM6jN+3njkRLqsNklXYmGBMTQRfqjNL8ZJqwc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788473213; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=afA3ax7f9QXcCedQi5bAM/QoI2EIiapIQDf4xdId4Ug=;
 b=C8AufTuHLPwUljbA54/aDdNTZQpkZb0OFLwnFnvPnt6ZW8E2u8au1DNCLZpbqCnD
 Mvh34mx5FVS9mgjYUsToU957PGF05WKA5kM6/zX5+Vrwtz8W1xjBVTxT3dBIF8ukHy/
 sthFIRJyiU6knD+o6DPFAt+UbTn/LzVzeHZlJKMQ=
Received: by mx.zohomail.com with SMTPS id 1788473212203626.0025116376753;
 Thu, 3 Sep 2026 15:06:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 6/9] drm/tyr: add BO creation and lookup helpers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260902-tyr-ioctls-v1-6-e0fdbf8bd108@kylinos.cn>
Date: Thu, 3 Sep 2026 19:06:31 -0300
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
Message-Id: <B6966555-4532-4369-B519-56AD72307553@collabora.com>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-6-e0fdbf8bd108@kylinos.cn>
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
> Add the new_object() and lookup_handle() helpers.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> drivers/gpu/drm/tyr/gem.rs | 29 ++++++++++++++++++++++++++++-
> 1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index 3bf3787f5c3fd..be1affe80db1a 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
> @@ -9,9 +9,11 @@
> use kernel::{
>     drm::gem::{
>         self,
> -        shmem, //
> +        shmem,
> +        BaseObject, //
>     },
>     prelude::*,
> +    sizes::SZ_4K,
>     sync::{
>         aref::ARef,
>         Arc, //
> @@ -23,6 +25,7 @@
>         TyrDrmDevice,
>         TyrDrmDriver, //
>     },
> +    file::TyrDrmFile,
>     vm::{
>         Vm,
>         VmMapFlags, //
> @@ -53,6 +56,30 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: =
BoCreateArgs) -> impl PinInit<Se
> /// Type alias for Tyr GEM buffer objects.
> pub(crate) type Bo =3D gem::shmem::Object<BoData>;
>=20
> +/// Create a new GEM buffer object.
> +pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: =
u32) -> Result<ARef<Bo>> {
> +    if size =3D=3D 0 {
> +        return Err(EINVAL);
> +    }
> +
> +    let aligned_size =3D =
size.checked_next_multiple_of(SZ_4K).ok_or(EINVAL)?;

I think this needs to be PAGE_SIZE instead of SZ_4K.

> +
> +    Bo::new(
> +        ddev,
> +        aligned_size,
> +        shmem::ObjectConfig {
> +            map_wc: true,
> +            parent_resv_obj: None,
> +        },
> +        BoCreateArgs { flags },
> +    )
> +}
> +
> +/// Look up a GEM object by handle for a DRM file.
> +pub(crate) fn lookup_handle(file: &TyrDrmFile, handle: u32) -> =
Result<ARef<Bo>> {
> +    Bo::lookup_handle(file, handle)
> +}
> +
> /// Creates a dummy GEM object to serve as the root of a GPUVM.
> pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> =
Result<ARef<Bo>> {
>     let bo =3D Bo::new(
>=20
> --=20
> 2.43.0
>=20
>=20

