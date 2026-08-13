Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83582C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D556110E062;
	Thu, 13 Aug 2026 18:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bf+QAwjy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D554110E062
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:51:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58F73600E2;
 Thu, 13 Aug 2026 18:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E476E1F000E9;
 Thu, 13 Aug 2026 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786647067;
 bh=8gxPFLDL0MQX94lvrrevCmGg/xQFr50jw9uGLp6oOdE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bf+QAwjyxbc0dVl4popX3Ze1RTY2NugXRo3SnoefFxCPXuNIm2IHgYHyFPNPCar85
 O/BuKJpF41mL8PFWe9JNEh6MoOWvLSOhDi2jKvnxJ0rY0OsygtyQryWhhDUc6ZXR7M
 vvt60ETpHOpxtSGbwURbtQ68BmUZ2EFv1KJK4VDgCovnx08elew0AnmoXNaL70Cd5Z
 0AyMHq1wrJyCDDp0oiMWRkF2ucvS6wfvmLCyFArEl0pdRcojBOeQ+Z6giu+CJvf8vt
 vvqkdalolRqWSxiFRzCCV+udc52HkjICUE1NG7AwsBzP23QWRAT3ONl597KlBWhuox
 Bs249PcDCDM5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] accel/amdxdna: check the sync range for overflow
 on a device BO
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813164700.43960-4-taimuraz@kaitmazov.com>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
 <20260813164700.43960-4-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 18:51:06 +0000
Message-Id: <20260813185106.E476E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprivileged userspace can intentionally trigger a kernel WARN by =
passing out-of-bounds offset/size values for non-device BOs.
- [Medium] Missing bounds validation against `abo->mem.size` for `AMDXDNA_B=
O_DEV` objects allows out-of-bounds cache flushes within the same heap and =
silent failures.
- [Medium] If virtual mapping fails, the fallback logic flushes the entire =
BO regardless of the requested offset and size.
--

--- Patch [3]: [PATCH v3 3/3] accel/amdxdna: check the sync range for overf=
low on a device BO ---
commit bd85443971ea32d5dd9a298eda3414fbb3246a1f
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: accel/amdxdna: check the sync range for overflow on a device BO

This commit adds overflow checks to the BO sync ioctl in the AMDXDNA_BO_DEV
path. It ensures that the caller's offset and size do not overflow when
calculating the flush start and end addresses.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 1798003cdd45c..2507877fff29a 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1302,8 +1302,13 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *d=
ev,
>  		struct amdxdna_gem_obj *heap;
>  		unsigned long heap_id;
>  		u64 bo_start =3D amdxdna_gem_dev_addr(abo);
> -		u64 flush_start =3D bo_start + args->offset;
> -		u64 flush_end =3D flush_start + args->size;
> +		u64 flush_start, flush_end;
> +
> +		if (check_add_overflow(bo_start, args->offset, &flush_start) ||
> +		    check_add_overflow(flush_start, args->size, &flush_end)) {
> +			ret =3D -EINVAL;
> +			goto put_obj;
> +		}

[Severity: Medium]
This is a pre-existing issue, but should there also be a bounds check again=
st
abo->mem.size here?

While the integer overflow is caught, if userspace passes an offset or size
exceeding abo->mem.size, it seems we could still perform out-of-bounds
cache flushes into other sub-allocations within the same client heap, and
return success for out-of-bounds requests.

>  		xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
>  				  abo->heap_start_id, abo->heap_end_id) {

[ ... ]

In the else branch of amdxdna_drm_sync_bo_ioctl() (handling non-device
BOs), there is a call to amdxdna_flush_bo() followed by a warning:

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_drm_sync_bo_ioctl() {
    ...
		ret =3D amdxdna_flush_bo(abo, args->offset, args->size);
		amdxdna_gem_unpin(abo);

		if (ret) {
			drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
			goto put_obj;
		}
    ...
}

[Severity: High]
This is a pre-existing issue, but does this allow unprivileged userspace
to intentionally trigger a kernel WARN?

If userspace calls the sync IOCTL on a non-device BO with
args->offset >=3D abo->mem.size, amdxdna_flush_bo() legitimately returns
-EINVAL. The caller unconditionally catches this error from
amdxdna_flush_bo() and triggers drm_WARN(), which could spam the kernel
log or panic the system if panic_on_warn is enabled.

Also within amdxdna_flush_bo(), there is fallback logic if the virtual
mapping fails:

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_flush_bo() {
    ...
	} else if (abo->base.pages)
		drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
    ...
}

[Severity: Medium]
This is a pre-existing issue, but if the virtual mapping fails, does this
fallback logic flush the entire BO regardless of the requested offset and
size?

Under heavy memory pressure, falling back to flushing the entire buffer
instead of the requested range could cause severe latency spikes and
performance degradation due to unnecessary over-flushing of potentially lar=
ge
BOs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813164700.4396=
0-1-taimuraz@kaitmazov.com?part=3D3
