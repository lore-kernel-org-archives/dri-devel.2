Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E1606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wuayt360
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD4E10E09B;
	Mon,  9 Nov 2026 00:48:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3861310E09B
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 00:48:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00CF740B7A;
 Mon,  9 Nov 2026 00:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDC61F0089F;
 Mon,  9 Nov 2026 00:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794185295;
 bh=47rRjZYtKTlblOYQdFunV83ynBkzlwRRszNdsskfAEk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wuayt3605T4Zjb3je8ogo8vhrfo/QyP4BOsYKitvDLWztw1tM9a6067OyDRZqucDS
 s498PznPD9Hb7zb3hvP6inDroXQRZeBOWFIfqASkeK8clM8vlRATY3mKlvofFb1bJ+
 eISTVKSwFSo797tv3XpEsZz6LLjwAVAzt4p0Mdhr/Z0kCvKy0Aowb+NRT7Ux4fNJrr
 SFQIUINYc1eNRJ0xVqK8Q24Ip1yXw//sJfA0ZG7dgTDTvSQF2OsZqY4EWPMJEMxk86
 VhJo1kq4bJFFNVeelRVuOmCKVtD4bw6TOom3shSjdO4JFoBb3fBPw5rPQhyO0x+RFI
 2e4hY/e7CJhBQ==
Message-ID: <sashiko-outbox-204259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] drm/tyr: add per-file VM pool
To: "Ke Sun" <sunke@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261109-tyr-ioctls-v6-4-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
 <20261109-tyr-ioctls-v6-4-b2896bf2b3c9@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:48:15 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/tyr: off-by-one IdPool capacity in VmPool::new() on
  32-bit builds
--

commit 6b8d6be457daf3e5e905977c364059ce3d3249e4
Author: Alvin Sun <alvin.sun@linux.dev>

drm/tyr: add per-file VM pool

This commit introduces VmPool to manage up to 32 GPU address spaces per open
file using an IdPool and an XArray, tearing down remaining VMs when the pool
is dropped.

> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 1dd11b2b12532..6f5518652a03f 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs

[ ... ]

> @@ -947,3 +953,135 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, ARM6=
4LPAES1>, range: Range<u64>)
> =20
>      Ok(())
>  }
> +
> +/// Maximum number of VMs a single file may hold, matching panthor's
> +/// `PANTHOR_MAX_VMS_PER_FILE`.
> +const MAX_VMS_PER_FILE: usize =3D 32;

[ ... ]

> +impl<'drm> VmPool<'drm> {
> +    /// Creates a new [`VmPool`].
> +    #[expect(dead_code)]
> +    pub(crate) fn new(dev: &'drm Device<Bound>) -> impl PinInit<Self> {
> +        let ids =3D IdPool::new();
> +        pin_init!(Self {
> +            dev,
> +            ids <- new_mutex!(ids),
> +            vms <- XArray::new(AllocKind::Alloc),
> +        })
> +    }
> +
> +    /// Stores the VM and returns the allocated ID.
> +    ///
> +    /// On failure - ID space exhausted or a store failure - the VM is
> +    /// returned in an [`AddError`] so the caller owns the teardown.
> +    // TODO: allocate IDs with the XArray directly (once it grows range
> +    // allocation, the equivalent of C's `XA_LIMIT`) and drop the IdPool.
> +    #[expect(dead_code)]
> +    pub(crate) fn add(&self, vm: Arc<Vm<'drm>>) -> Result<u32, AddError<=
'drm>> {
> +        let id =3D (|| {
> +            let mut ids =3D self.ids.lock();
> +            let unused =3D ids.find_unused_id(1).ok_or(ENOSPC)?;
> +            if unused.as_usize() > MAX_VMS_PER_FILE {
> +                return Err(ENOSPC);
> +            }
> +            Ok(unused.acquire())
> +        })();

[Severity: Medium]
Can VmPool::add() fail with ENOSPC on the 32nd VM on 32-bit builds?

IdPool::new() creates an inline bitmap of length usize::BITS, which is 32 on
32-bit platforms (indices 0..=3D31).  Because find_unused_id(1) skips bit 0,
allocating 32 VMs requires bit index 32, so only 31 VMs (IDs 1..=3D31) can =
be
allocated before find_unused_id(1) returns None.  Searching from bit 0 and
adding 1 to form the 1-based VM ID (subtracting 1 on release_id()) would fit
all 32 VMs within indices 0..=3D31.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-tyr-ioctls=
-v6-0-b2896bf2b3c9@kylinos.cn?part=3D4
