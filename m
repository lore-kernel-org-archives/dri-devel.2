Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4379C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFB989B46;
	Mon, 17 Aug 2026 23:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R9xoH9FM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624EC89B46
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:31:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6D8140D9B;
 Mon, 17 Aug 2026 23:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B9E1F000E9;
 Mon, 17 Aug 2026 23:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787009477;
 bh=8w5PCJVb44pfOYUvxJj6TLmkrxlIO1XtC4kz3s+Hz7Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R9xoH9FMGYENwojZGIo20sG+MgpBoAF+cYjs1cFypv8YDoKFSTHVLUkAwbg84c/2d
 M5giFp2AEkNlNBwcU5CNN+dXAQcI+/S2TfCBn+m1+VfZBxza06HCrlfxlHNcISdh53
 gQ8yC36D7bVOMwRM+RHeSOjAq6/4Tz7OeGgrzJQdnVJlxwAVGfN4oMqjGIGPEZzKWP
 ag5WTPTWG/qptM/m5o8S2UP8UZrzKh13VRpZdQIr/BTTPnfVdZxbpTB4L6sDEOqMlK
 OWV0ZB20A0B8IL56abxvFyHzWSUdpRu2YXvH84HDfqYAYrS6t2St0QqATCefn0xL97
 V/hBjMlJ1kP/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: return early from a zero-length flush
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817230655.356785-1-taimuraz@kaitmazov.com>
References: <20260817230655.356785-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 23:31:17 +0000
Message-Id: <20260817233117.A6B9E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling drm_clflush_virt_range with length 0 causes a page fault, =
and this can be triggered from aie2_cmdlist_multi_execbuf.
- [High] drm_clflush_virt_range() performs an unconditional out-of-bounds r=
ead when called with a length of 0, triggering a kernel panic.
- [High] Flushing a DEV BO iterates over its heaps and flushes them without=
 pinning them, which can lead to a use-after-free if the DRM shrinker recla=
ims the heap's pages.
- [Medium] Userspace can trigger a kernel WARN (and potential panic if pani=
c_on_warn is set) by passing invalid parameters to the SYNC_BO ioctl.
--

--- Patch [1]: [PATCH] accel/amdxdna: return early from a zero-length flush=
 ---
commit 0c882e06a9bf65285c4bb50a3200aa5bf9fa60e9
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: return early from a zero-length flush

This commit fixes a kernel panic triggered when a zero-length flush request
reaches drm_clflush_virt_range(), which accesses the byte before the mappin=
g.
It avoids the crash by returning early from amdxdna_flush_bo() if the size =
is
zero.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index b01f5d95fac83..d18de7eb7af47 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1253,6 +1253,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj =
*abo, u64 offset, u64 size)
>  		return -EINVAL;
> =20
>  	size =3D min(abo->mem.size, end) - offset;
> +	if (!size)
> +		return 0;
> +

[Severity: High]
This is a pre-existing issue, but by only guarding the SYNC_BO path here,
is there still a vulnerable path in aie2_cmdlist_multi_execbuf()?

If unprivileged userspace submits an ERT_CMD_CHAIN command with=20
payload->command_count =3D=3D 0, the offset remains 0. The function
aie2_cmdlist_multi_execbuf() in drivers/accel/amdxdna/aie2_message.c
bypasses its inner loop and directly calls:

    drm_clflush_virt_range(cmd_buf, offset);
   =20
Since offset is 0, this will bypass amdxdna_flush_bo() entirely and still=20
trigger the kernel panic in drm_clflush_virt_range().

[Severity: High]
This isn't a bug introduced by this patch, but while fixing the zero-length=
=20
flush here, does the root cause in drm_clflush_virt_range() need addressing=
=20
as well?

drm_clflush_virt_range() in drivers/gpu/drm/drm_cache.c does:

    clflushopt(end - 1); /* force serialisation */
   =20
Since it unconditionally accesses memory prior to the buffer, calling it wi=
th=20
a length of 0 causes a guard page fault. Any kernel caller that legitimatel=
y=20
flushes a zero-length region can crash the system.

[Severity: High]
This is a pre-existing issue, but can flushing a DEV BO lead to a=20
use-after-free?

When flushing a DEV BO, amdxdna_drm_sync_bo_ioctl() iterates over its heaps=
=20
and calls:

    ret =3D amdxdna_flush_bo(heap, start - heap_start, end - start);
   =20
This happens without first pinning the heap BO. Later in amdxdna_flush_bo():

    drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
   =20
This accesses the unpinned pages array locklessly. If memory pressure invok=
es=20
the DRM shmem shrinker concurrently, it could unpopulate and free the BO's=
=20
pages, causing the flush operation to access freed memory.

[Severity: Medium]
This is a pre-existing issue, but can userspace trigger a kernel WARN by=20
passing an out-of-bounds offset?

If an unprivileged user calls the SYNC_BO ioctl with an args->offset larger=
=20
than the BO size, amdxdna_flush_bo() safely catches the bounds violation=20
and returns -EINVAL.

However, back in amdxdna_drm_sync_bo_ioctl() in=20
drivers/accel/amdxdna/amdxdna_gem.c:

    if (ret) {
        drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
    }
   =20
This translates the user-provided bounds violation into a kernel WARN, whic=
h=20
can result in a Denial of Service on systems configured with panic_on_warn.

>  	if (is_import_bo(abo))
>  		drm_clflush_sg(abo->base.sgt);
>  	else if (amdxdna_gem_vmap(abo))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817230655.3567=
85-1-taimuraz@kaitmazov.com?part=3D1
