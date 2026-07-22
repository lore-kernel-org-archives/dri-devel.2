Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4028BC4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F8710E28E;
	Wed, 22 Jul 2026 00:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eDwnQ2Sw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E837910E28E
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:58:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5078C40421;
 Wed, 22 Jul 2026 00:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BE51F000E9;
 Wed, 22 Jul 2026 00:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784681931;
 bh=ZmmeHNSnn9B5TETX4tYQaESO9JPR7WpnMMqz4tgV0Sg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eDwnQ2SwY2EhZzGkEzUEJkkbZKRv3ocbG85zUFuMLNlNLuNJbt2bd4xGri7HJeE21
 mUTOtyNYSBRnBbkvHtKDsNLaNn4IhxEabzuZDC8j4ZGoq1Naj3SGQZeibaK5lvZnHP
 KzNkB5b3/gUbYUvNgu5/OR+bPAg4mwwl+qTJsG04h9tQhmFbeh9/LekIxFaeqofetw
 xxnxlt9C5lMtm7yMl6ELpaZ7gppsxTGOV5DfgIp52k1HLzDmwxinBb4hzZEIy0XBz+
 qEyZl6/HoJ/zag08se4eJM8DgO4hnxOBjjYyNWQfuujQKJW4Te/al7mkFTHynWJ96U
 9RnDvHoXbGwgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/7] drm/tyr: add a kernel buffer object
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-fw-boot-b4-v8-5-b28f744581c9@collabora.com>
References: <20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com>
 <20260721-fw-boot-b4-v8-5-b28f744581c9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 00:58:50 +0000
Message-Id: <20260722005850.F1BE51F000E9@smtp.kernel.org>
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
- [Low] Trailing newlines in logging macros cause double newlines in the ke=
rnel log.
--

--- Patch [5]: [PATCH v8 5/7] drm/tyr: add a kernel buffer object ---
commit d331aa5f9ef1fb72722d9ab68ad7b2746d91080d
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: add a kernel buffer object

Introduce a buffer object type (KernelBo) for internal driver allocations
that are managed by the kernel rather than userspace. It wraps a GEM shmem
object and automatically handles GPU virtual address space mapping during
creation and unmapping on drop.

> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index c28be61a01bb2..583c2a87b23b3 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
[ ... ]
> +impl<'bound> KernelBo<'bound> {
> +    /// Creates a new kernel-owned buffer object and maps it into GPU VA=
 space.
[ ... ]
> +    #[expect(dead_code)]
> +    pub(crate) fn new(
> +        ddev: &TyrDrmDevice,
> +        vm: Arc<Vm<'bound>>,
> +        size: u64,
> +        va_alloc: KernelBoVaAlloc,
> +        flags: VmMapFlags,
> +    ) -> Result<Self> {
> +        if size =3D=3D 0 {
> +            dev_err!(vm.dev(), "Cannot create KernelBo with size 0\n");

[Severity: Low]
This isn't a bug, but does this dev_err macro call need a trailing newline?=
=20
The rust dev_err macro automatically appends a newline to the formatted=20
output. Including an explicit newline at the end of the format string=20
might result in an unnecessary blank line in the kernel log.

> +            return Err(EINVAL);
> +        }
[ ... ]
> +impl Drop for KernelBo<'_> {
> +    fn drop(&mut self) {
> +        let va =3D self.va_range.start;
> +        let size =3D self.va_range.end - self.va_range.start;
> +
> +        if let Err(e) =3D self.vm.unmap_range(va, size) {
> +            // If unmap_range fails, it is still safe to drop the
> +            // KernelBo and its ARef to the GEM buffer object because
> +            // GPUVM also holds a reference to the GEM buffer object.
> +            // The physical pages won't be freed or reallocated.
> +            dev_err!(
> +                self.vm.dev(),
> +                "Failed to unmap KernelBo range {:#x}..{:#x}: {:?}\n",

[Severity: Low]
Similarly here, does this format string need the trailing newline?

> +                self.va_range.start,
> +                self.va_range.end,
> +                e
> +            );
> +        }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-fw-boot-b4=
-v8-0-b28f744581c9@collabora.com?part=3D5
