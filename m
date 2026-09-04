Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E442C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A09C10E16D;
	Fri,  4 Sep 2026 20:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AH0QIu/1";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC3B10E16D
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 20:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788554138; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q+Tl8OjiLNj2TOW2Ca6y3oZuXXVaOox6E2aQEMQ1K7y7cw74k8SXkDyq5Pt+sN2spNCvnD0zAgWzSUYkAovbvGfz1+Nxw3/xHt6F8SVn1AtVa4chNQHKHKk6PcX5a5RjDjCXZXTWAneIURl8ix2O8eCUxs1ucTYStEhoUY0dZ68=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788554138;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=I0k6Kz+SdWEmoW6Od/eEawvKt15zwDmptkDj5bWnB04=; 
 b=CDWqeX5iKsGcCfsVo7Pf3drLz6TbWQFUtzIRXzLyFBYpMCWnGX2EMbJW0G8C7E2KANShckrKKsxHh0ZmVxlYSpz/ggWGJqpkZiust0xZGTbuabNPNLK0j5mE9d1cFQnPY9gsnS293a+Hz19vI2CVYhy9HsUPSyrqelDlHxs7GL4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788554138; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=I0k6Kz+SdWEmoW6Od/eEawvKt15zwDmptkDj5bWnB04=;
 b=AH0QIu/1ROj5KivqKZVlwT/Pt2CtnypTOH5IjKniTcu3h5r8w01eUCoYvhYWBOm+
 ucs79wglBotCytiwi1iYfe0ipANZ3z0kmh/lJPoSwMlyOKT5PvFftvWVmTm8HkNkUXU
 XcnLeNrbeCTFDoUyws4j5CiyjQOV+v5DvXHFRLoY=
Received: by mx.zohomail.com with SMTPS id 1788554135928568.4108043928953;
 Fri, 4 Sep 2026 13:35:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 9/9] drm/tyr: add BO-related ioctls
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260902-tyr-ioctls-v1-9-e0fdbf8bd108@kylinos.cn>
Date: Fri, 4 Sep 2026 17:35:16 -0300
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
Message-Id: <FDEDAB25-FBF2-438C-9C1C-F72DC851E88C@collabora.com>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-9-e0fdbf8bd108@kylinos.cn>
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
> Expose buffer creation and BO mmap offset retrieval.
>=20
> - BO_CREATE page-aligns the size and returns a handle with
>  write-combined mapping.
> - BO_MMAP_OFFSET provides the offset for the DRM generic mmap
>  path, rejecting NO_MMAP objects and non-zero pad.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Same comment as the previous patches, please write a few
more things here about why the changes are needed.

With that addressed,=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

> ---
> drivers/gpu/drm/tyr/driver.rs |  2 ++
> drivers/gpu/drm/tyr/file.rs   | 70 =
+++++++++++++++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/gem.rs    |  7 +++++
> 3 files changed, 79 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index b3145526ada06..fc8d11c9ba1ca 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -224,6 +224,8 @@ impl drm::Driver for TyrDrmDriver {
>         (PANTHOR_VM_DESTROY, drm_panthor_vm_destroy, =
ioctl::RENDER_ALLOW, TyrDrmFileData::vm_destroy),
>         (PANTHOR_VM_BIND, drm_panthor_vm_bind, ioctl::RENDER_ALLOW, =
TyrDrmFileData::vm_bind),
>         (PANTHOR_VM_GET_STATE, drm_panthor_vm_get_state, =
ioctl::RENDER_ALLOW, TyrDrmFileData::vm_get_state),
> +        (PANTHOR_BO_CREATE, drm_panthor_bo_create, =
ioctl::RENDER_ALLOW, TyrDrmFileData::bo_create),
> +        (PANTHOR_BO_MMAP_OFFSET, drm_panthor_bo_mmap_offset, =
ioctl::RENDER_ALLOW, TyrDrmFileData::bo_mmap_offset),
>     }
> }
>=20
> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 157bc40e1cac4..16abf2968299c 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -252,6 +252,76 @@ pub(crate) fn vm_get_state(
>             Ok(0)
>         })
>     }
> +
> +    pub(crate) fn bo_create(
> +        ddev: &TyrDrmDevice<Registered>,
> +        _reg_data: &TyrDrmRegistrationData<'_>,
> +        bocreate: &mut uapi::drm_panthor_bo_create,
> +        file: &TyrDrmFile,
> +    ) -> Result<u32> {
> +        if bocreate.size =3D=3D 0
> +            || bocreate.pad !=3D 0
> +            || bocreate.flags & =
!uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP !=3D 0
> +            || bocreate.exclusive_vm_id !=3D 0
> +        {
> +            dev_err!(
> +                ddev.as_ref(),
> +                "Invalid BO_CREATE params: size=3D{}, pad=3D{}, =
flags=3D{:#x}, exclusive_vm_id=3D{}\n",
> +                bocreate.size,
> +                bocreate.pad,
> +                bocreate.flags,
> +                bocreate.exclusive_vm_id
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let size =3D usize::try_from(bocreate.size).map_err(|_| {
> +            dev_err!(
> +                ddev.as_ref(),
> +                "BO_CREATE size {:#x} too large\n",
> +                bocreate.size
> +            );
> +            EINVAL
> +        })?;
> +        let bo =3D crate::gem::new_object(ddev, size, =
bocreate.flags)?;
> +        bocreate.handle =3D bo.create_handle(file)?;
> +        bocreate.size =3D bo.size() as u64;
> +
> +        Ok(0)
> +    }
> +
> +    pub(crate) fn bo_mmap_offset(
> +        ddev: &TyrDrmDevice<Registered>,
> +        _reg_data: &TyrDrmRegistrationData<'_>,
> +        bommap: &mut uapi::drm_panthor_bo_mmap_offset,
> +        file: &TyrDrmFile,
> +    ) -> Result<u32> {
> +        if bommap.pad !=3D 0 {
> +            dev_err!(
> +                ddev.as_ref(),
> +                "BO mmap offset pad not zero: {}\n",
> +                bommap.pad
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let bo =3D crate::gem::lookup_handle(file, =
bommap.handle).inspect_err(|_| {
> +            dev_err!(ddev.as_ref(), "Invalid BO mmap handle: {}\n", =
bommap.handle);
> +        })?;
> +        if bo.create_flags() & =
uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP !=3D 0 {
> +            dev_err!(ddev.as_ref(), "BO mmap offset on NO_MMAP =
object\n");
> +            return Err(EPERM);
> +        }
> +        bommap.offset =3D bo.create_mmap_offset().inspect_err(|_| {
> +            dev_err!(
> +                ddev.as_ref(),
> +                "Failed to create mmap offset for handle {}\n",
> +                bommap.handle
> +            );
> +        })?;
> +
> +        Ok(0)
> +    }
> }
>=20
> fn vm_bind_exec_op(vm: &Vm<'_>, file: &TyrDrmFile, op: &VmBindOp) -> =
Result {
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index d9ddcb287f52b..f404139f54f32 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
> @@ -38,6 +38,13 @@ pub(crate) struct BoData {
>     flags: u32,
> }
>=20
> +impl BoData {
> +    /// Returns the flags the BO was created with.
> +    pub(crate) fn create_flags(&self) -> u32 {

I would prefer flags() instead of create_flags(), which reads a bit more =
like a constructor.

> +        self.flags
> +    }
> +}
> +
> /// Provides a way to pass arguments when creating BoData
> /// as required by the gem::DriverObject trait.
> pub(crate) struct BoCreateArgs {
>=20
> --=20
> 2.43.0
>=20
>=20
>=20

