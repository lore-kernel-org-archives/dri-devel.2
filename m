Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1CACA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EA310E9D4;
	Fri,  9 Oct 2026 14:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="W3TNU13c";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B6C10E9D4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791556129; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fEpcfuCdyTuAeNVDN5w3gTdg4iVSczsygLIQjzPSzP2cQiuZBlRjpPBYY11ebxXvTfdmaVyb4KDAcDpv443k7DkPjdlZCbprA4YXWoNnt9F+Cdgh9hqmup+dHCgrWJz8uLkRsNsjIYboC18oaEhjmkf4BAiWcwqwmwv+TbdPGxA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791556129;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zVbWP16VRMrWp/DvVtxAnr3TU+v7W0tYlq0ED/T4l0U=; 
 b=csy4qDpmoMmAT/bHWKkhtnFb16J1DpyFESqr/Yc9HJ68+x549k8mWsSMUx/FW+9c93e9qASItOCLZmrhoN8qZEdp+YDebB/M14jpjBW0EhLLXCQEht0vmQSfgVsheiV5b+f/VQ3SOE/onJ3sPh9jas1GziXPc7mrjt37Sa+bkVA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791556129; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=zVbWP16VRMrWp/DvVtxAnr3TU+v7W0tYlq0ED/T4l0U=;
 b=W3TNU13cRQ1sXBYnikNHNpwESMYtfMCVCptTvukXjQopCaVz30kYiRXXJwSxKmWt
 a8dRgoGRAb866GgHV73oe93zM/xKV3cXEK73TfAOIR5IW2Mw35SlQVBtsJKV6XRXN2z
 FluNH19L8taDBquVPfhF/o56pqbKYYIpOhc02YRU=
Received: by smtp.zohomail.com with SMTPS id 1791556126179586.2419855994772;
 Fri, 9 Oct 2026 07:28:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v3 06/11] drm/tyr: add BO creation and lookup helpers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260929-tyr-ioctls-v3-6-26955fb111d5@kylinos.cn>
Date: Fri, 9 Oct 2026 11:28:29 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 driver-core@lists.linux.dev, Alvin Sun <alvin.sun@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <84ADA150-9E7B-4EF9-ABD0-377E9746E293@collabora.com>
References: <20260929-tyr-ioctls-v3-0-26955fb111d5@kylinos.cn>
 <20260929-tyr-ioctls-v3-6-26955fb111d5@kylinos.cn>
To: sunke@kylinos.cn
X-Mailer: Apple Mail (2.3901.100.1.1.11)
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



> On 28 Sep 2026, at 23:15, Ke Sun via B4 Relay =
<devnull+sunke.kylinos.cn@kernel.org> wrote:
>=20
> From: Alvin Sun <alvin.sun@linux.dev>
>=20
> Add helpers for the BO ioctls: new_object() creates a GEM object with
> the size aligned up to PAGE_SIZE, and lookup_handle() resolves a =
handle
> for a DRM file.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> drivers/gpu/drm/tyr/gem.rs | 31 ++++++++++++++++++++++++++++++-
> 1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index 3bf3787f5c3fd..0e0989a48678f 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
> @@ -9,8 +9,10 @@
> use kernel::{
>     drm::gem::{
>         self,
> -        shmem, //
> +        shmem,
> +        BaseObject, //
>     },
> +    page::PAGE_SIZE,
>     prelude::*,
>     sync::{
>         aref::ARef,
> @@ -23,6 +25,7 @@
>         TyrDrmDevice,
>         TyrDrmDriver, //
>     },
> +    file::TyrDrmFile,
>     vm::{
>         Vm,
>         VmMapFlags, //
> @@ -53,6 +56,32 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: =
BoCreateArgs) -> impl PinInit<Se
> /// Type alias for Tyr GEM buffer objects.
> pub(crate) type Bo =3D gem::shmem::Object<BoData>;
>=20
> +/// Create a new GEM buffer object.
> +#[expect(dead_code)]
> +pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: =
u32) -> Result<ARef<Bo>> {
> +    if size =3D=3D 0 {
> +        return Err(EINVAL);
> +    }
> +
> +    let aligned_size =3D =
size.checked_next_multiple_of(PAGE_SIZE).ok_or(EINVAL)?;
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
> +#[expect(dead_code)]
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
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

