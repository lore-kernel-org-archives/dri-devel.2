Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01985C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E8310E0DB;
	Wed,  9 Sep 2026 20:13:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q8I9A4Ep";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C64F10E0DB
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:13:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78237601EF;
 Wed,  9 Sep 2026 20:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102C51F00893;
 Wed,  9 Sep 2026 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788984793;
 bh=3Ab6GKKJTCmd1zexMcnFtdjqfJQAEWlspxEPNLksuHg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Q8I9A4EpuWSax8KzU+S3I8gSSqplNKaCaDuf8RoX3rM7vk4Dx+6o7qe5NbvGYzrCq
 Vls9HnlFo9ifsAiii6k/9db3EnbSY2+cxMqvF7YAECdBlw3pzo9BVCK34WPy/tqego
 GTUggaGM3hqdmpCrNwYvddOcaZzxBzC7OR3U1+2nitfAm7RLcNC0lIeoyXMm1D/07B
 62aJkuz1j2vxh4kuDdLNfi/mXdYRf11Pjc6F2W/vsEwLCAGw5T5rrB4ChUjfVUV0BQ
 voPAElPMyspQH75fT3fpdwBgxoz77Q22GuRUD77hQPjsq4AQpbSnmyUq4FJti38WRg
 9iT2nIcNakV4A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 22:13:09 +0200
Message-Id: <DLB26IJOGT28.6EW1J23QCYM3@kernel.org>
Subject: Re: [PATCH 15/16] gpu: nova-core: mm: Add BAR1 user interface
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
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

On Wed Sep 9, 2026 at 5:59 AM CEST, Eliot Courtney wrote:
> +/// Access object for a mapped BAR1 region.
> +pub(crate) struct BarUserAccess<'gpu> {
> +    bar_user: Arc<BarUser<'gpu>>,

This shouldn't be an Arc, we can just borrow from BarUser.

> +    /// [`BarUserAccess::release`] [`Option::take`]s this; `Some` at
> +    /// drop time means `release()` was never called.
> +    mapped: Option<MappedRange>,

This Option, the panic in mapped() and the odd warning in drop() should go =
away
with using proper RAII types as suggested in a previous reply. I.e.
unmap_pages() doesn't need to call free_vfn() anymore, but MappedRange's dr=
op()
does it.

> +}
> +
> +impl BarUserAccess<'_> {
> +    /// Tear down the BAR1 mapping.
> +    pub(crate) fn release(mut self, mm: &mut GpuMm<'_>) -> Result {
> +        let mapped =3D self.mapped.take().ok_or(EINVAL)?;
> +        let mut vmm =3D self.bar_user.vmm.lock();
> +        vmm.unmap_pages(mm, mapped)?;
> +        Ok(())
> +    }
> +
> +    /// Returns the active mapping.
> +    fn mapped(&self) -> &MappedRange {
> +        // `mapped` is only `None` after `take()` in `release`; hence un=
wrap()
> +        // cannot panic here.
> +        self.mapped.as_ref().unwrap()
> +    }

[...]

> +impl Drop for BarUserAccess<'_> {
> +    fn drop(&mut self) {
> +        if self.mapped.is_some() {
> +            kernel::pr_warn!(
> +                "BarUserAccess dropped without calling release(). BarUse=
r address space will leak.\n"
> +            );
> +        }
> +        // The inner `MappedRange`'s own `MustUnmapGuard` will also fire=
,
> +        // identifying the leaked VA range.
> +    }
> +}
