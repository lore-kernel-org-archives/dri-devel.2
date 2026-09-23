Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3D3C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 496F910F0CA;
	Wed, 23 Sep 2026 14:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lBtG1lAJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9A310F0C9;
 Wed, 23 Sep 2026 14:19:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5283440A16;
 Wed, 23 Sep 2026 14:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D7A1F00893;
 Wed, 23 Sep 2026 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790173199;
 bh=n/cCmCgfiu86QXCh01/6+WMltDLl2tW980LwiQXLLso=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lBtG1lAJcS/jKUd5C+8TUbCJxox79/rA27+E/9dK6AZPDkBGudzyBIyAJIkya/Amc
 CMqf6w+D8s+Q7fSxAoSHwpzlKoBzXpxw8N6qaGbekDCCwwlUoQQY4FVsWQcT25oC6V
 y9p0QHNkLPEslv0+UtbFHgfqaYikX6j4fj8T8QK7BX36PvxJ8fgIpXzrWkH64oiO3c
 WWipepZdMr0esNAtRPS27TfiZoUiGo2sJ4CNiemGiqJyYOmNKid32g+oLByWlyqAXB
 a8vZhm+K/rDg5lX4pw25s7aaUMhUxfsKdIYwLtfydnn6hBZlWPvC4qWvolhj30DBJu
 UR8f1kI0/q4jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/xe: Don't unload the driver until all drm
 devices are freed
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260923140844.390822-3-thomas.hellstrom@linux.intel.com>
References: <20260923140844.390822-1-thomas.hellstrom@linux.intel.com>
 <20260923140844.390822-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 14:19:58 +0000
Message-Id: <20260923141959.00D7A1F00893@smtp.kernel.org>
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
- [Medium] xe: logic mismatch in xe_device_exit wait causes indefinite unin=
terruptible hang
--

commit b47bb26ab24e9f99fb3dd76c67cadc55ddf082fa
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/xe: Don't unload the driver until all drm devices are freed

This commit ensures the driver module is not unloaded until all DRM device
references are dropped by tracking a device count. It implements a module
unload wait mechanism using drm_dev_release_barrier() and a timeout check to
prevent executing code from a freed module.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c

[ ... ]

> @@ -1501,3 +1518,28 @@ struct xe_vm *xe_device_asid_to_vm(struct xe_devic=
e *xe, u32 asid)
> =20
>  	return vm;
>  }
> +
> +/**
> + * xe_device_exit() - Device subsystem exit function.
> + *
> + * Exit function to be called at module unload time.
> + */
> +void xe_device_exit(void)
> +{
> +	/*
> +	 * Wait for all devices to be freed. 20s is well above the typical
> +	 * maximum dma_fence signalling time, so warn and keep waiting if
> +	 * we're still not done by then, since it may indicate a leaked
> +	 * xe_device reference is stalling module unload.
> +	 */
> +	if (!wait_var_event_timeout(&xe_device_count,
> +				    !atomic_read(&xe_device_count),
> +				    HZ * 20)) {
> +		pr_warn("%s: Waiting for %d xe device(s) to be freed before unloading.=
\n",
> +			DRIVER_NAME, atomic_read(&xe_device_count));
> +		wait_var_event(&xe_device_count, !atomic_read(&xe_device_count));

[Severity: Medium]
The commit message mentions using a loop and printing a diagnostic every 10
seconds to avoid an indefinite, silent hang. However, this implementation
uses a single if block with a 20s timeout, followed by an unbounded
wait_var_event().

If an xe_device reference leak exists, won't this fallback to an indefinite
uninterruptible sleep and trigger the kernel's hung task watchdog?

> +	}
> +
> +	/* Wait for any driver release callbacks to complete */
> +	drm_dev_release_barrier(&regular_driver);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923140844.3908=
22-1-thomas.hellstrom@linux.intel.com?part=3D2
