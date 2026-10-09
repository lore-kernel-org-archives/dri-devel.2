Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98698CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E897710E180;
	Fri,  9 Oct 2026 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DXubZqbr";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4D210E180
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791557553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Z+z6z0ksLMfonBhun8oeR7/DSVjnafMXHhyl6IGgTwbRwCHnhp4BxXnVi0JOquxAiGVhvgSetsOJfNXjSOGyxQxsJ1l7YmzXWPSjANhra8npyQu/nDGCS69CQxB63sDlvdzUpatOQvOTnzVtZa3yy6ZVBGGMGgeKbD8SH5s2QY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791557553;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EiLsH5UA/UAiT8EVhaZCRrPJfE6J/JG41Rfbvq9F6Jk=; 
 b=dVa8fOIknUAnhPupZPxBXcpw5NN+mrT2WN9dy/0/Pq7lV7P2TdSl7GEv4K0QXIgk8szcH/LHspkdsvFugW//uRfkatqjxx2IEYG+QEOB9HVsMT/mkPldckPULk3kYovkyFcwbq6xhw6GP71fr5DWIlecO0yilkgEV2/kDnbBrkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791557553; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=EiLsH5UA/UAiT8EVhaZCRrPJfE6J/JG41Rfbvq9F6Jk=;
 b=DXubZqbrnPnNjo75oU8CUkmCxU5WEW7U137kdql6G/TvUin3a9mIBQ01dcF3Jyvw
 zXysVlnWfi8tPmxV4UWfqAX/MVUX5EZDadwk0cr8eOCfVfNdEDysgtm0r1IimXErtue
 NKF66Fi2yzMoVjB3dE+xlGimuCzQ1UfNdYeaXsPI=
Received: by smtp.zohomail.com with SMTPS id 1791557552056367.49141307442665; 
 Fri, 9 Oct 2026 07:52:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v3 08/11] drm/tyr: add BO-related ioctls
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260929-tyr-ioctls-v3-8-26955fb111d5@kylinos.cn>
Date: Fri, 9 Oct 2026 11:52:12 -0300
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
Message-Id: <419B635B-1C89-4004-98CB-9127875CA043@collabora.com>
References: <20260929-tyr-ioctls-v3-0-26955fb111d5@kylinos.cn>
 <20260929-tyr-ioctls-v3-8-26955fb111d5@kylinos.cn>
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

Hi Alvin,

Same comment about dev_err vs dev_dbg.

> On 28 Sep 2026, at 23:15, Ke Sun via B4 Relay =
<devnull+sunke.kylinos.cn@kernel.org> wrote:
>=20
> From: Alvin Sun <alvin.sun@linux.dev>
>=20
> Implement BO_CREATE and BO_MMAP_OFFSET so userspace can allocate GPU
> buffers and obtain a DRM mmap offset for the generic mmap path.
> BO_CREATE page-aligns the requested size; BO_MMAP_OFFSET rejects
> NO_MMAP objects, which must never be CPU-mapped.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> drivers/gpu/drm/tyr/driver.rs |  2 ++
> drivers/gpu/drm/tyr/file.rs   | 73 =
+++++++++++++++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/gem.rs    |  8 ++++-
> 3 files changed, 82 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index 9a7f147935e29..8baf88aee96ad 100644
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
> index 2c037b136406c..e98eb0a46877f 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -248,6 +248,79 @@ pub(crate) fn vm_get_state(
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
> +        {
> +            dev_err!(
> +                ddev.as_ref(),
> +                "Invalid BO_CREATE params: size=3D{}, pad=3D{}, =
flags=3D{:#x}\n",
> +                bocreate.size,
> +                bocreate.pad,
> +                bocreate.flags
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        if bocreate.exclusive_vm_id !=3D 0 {
> +            dev_err!(ddev.as_ref(), "BO_CREATE: exclusive_vm_id not =
supported\n");
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

Why is the sg_table() call only added later? As it stands, this patch
introduces a silent (and extremely confusing) issue.

I=E2=80=99d prefer if the call were to be here instead. You can just =
call it
unconditionally for now. IIUC it is harmless for coherent systems
and in any case, we only support non-coherent systems atm.



With the changes above:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

=E2=80=94 Daniel


