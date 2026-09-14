Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559ABC88E7D
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8B310E216;
	Mon, 14 Sep 2026 22:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S+ZlKkG1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 818A710E213;
 Mon, 14 Sep 2026 22:16:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B39E560252;
 Mon, 14 Sep 2026 22:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379F81F000FF;
 Mon, 14 Sep 2026 22:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789424203;
 bh=pdiy6rs9PjUTu1hfHq+0xrXD/PkX+hVLybBjnb+mpR0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S+ZlKkG1LtB6j04Xs3gs0Hf3BsPlwjvY7ClyoD3L5q7EhHDdgY2lGadjOSOfLWx1R
 gHtnkjqy6aq5T+1YQMGDjLaBUfRq+H3HyQlRlrHmYtdAwrsKR5S6N7pvznggAukBg9
 sMjgKRQ6EmznuhTV8F1B1i/PlaqeTQoeoH4tbdOy0JZ1T2OS2ziL13GnDyQASTe1oa
 K95VxH8Scy63vu0DQDJgW3yFIWYtRPsWmnSIRrTH5GhCEObTB5onVcpbU9NNtVA4UQ
 HX91XlLiDCepY/GKy2MGHba4c3U8ZTPZ0qXwcZJhx5fzYsW6AYkwGFN5nOULsKQQFk
 gz4c9rrCn0iPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
References: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:16:42 +0000
Message-Id: <20260914221643.379F81F000FF@smtp.kernel.org>
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
- [High] mmio: fixed 10us delay in long waits causes hrtimer/context switch=
 storms
--

commit c92012bfe0677557677a0dcb08c9a338f44452fd
Author: Alan Previn <alan.previn.teres.alexis@intel.com>
Subject: drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

This commit replaces the custom wait implementation in the driver with the
standard poll_timeout_us and poll_timeout_us_atomic macros. It drops the
atomic flag from xe_mmio_wait32 parameters, updating callers and adding
explicit _atomic variants where needed.

> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
[ ... ]
> @@ -1574,7 +1574,7 @@ int xe_guc_mmio_send_recv(struct xe_guc *guc, const=
 u32 *request,
>  		BUILD_BUG_ON((GUC_HXG_TYPE_RESPONSE_SUCCESS ^ GUC_HXG_TYPE_RESPONSE_FA=
ILURE) !=3D 1);
> =20
>  		ret =3D xe_mmio_wait32(mmio, reply_reg, resp_mask, resp_mask,
> -				     2000000, &header, false);
> +					     2000000, &header);

[Severity: High]
Does this change cause an excessive number of hrtimers or context switches
for long waits?

For example, in xe_guc_mmio_send_recv(), the 2,000,000us timeout here could
result in ~200,000 sleep/wake cycles if the hardware is slow or hits the
timeout. The previous custom wait implementation used an exponential backof=
f to
handle these long wait periods without flooding the system.

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
> --- a/drivers/gpu/drm/xe/xe_mmio.c
> +++ b/drivers/gpu/drm/xe/xe_mmio.c
[ ... ]
>  int xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u3=
2 val, u32 timeout_us,
> -		   u32 *out_val, bool atomic)
> +		   u32 *out_val)
>  {
> -	return __xe_mmio_wait32(mmio, reg, mask, val, timeout_us, out_val, atom=
ic, true);
> +	u32 read;
> +	int ret;
> +
> +	ret =3D poll_timeout_us(read =3D xe_mmio_read32(mmio, reg), (read & mas=
k) =3D=3D val,
> +			      10, timeout_us, false);

[Severity: High]
Will hardcoding a 10us sleep interval here cause context switch storms and
PCIe bus flooding during long operations?

Certain callers like __xe_driver_flr() wait up to 3 seconds, and
xe_gsc_wait_for_proxy_init_done() waits up to 1 second. Using a fixed 10us
interval means those paths might invoke usleep_range() tens of thousands of
times if the full timeout is reached.

Could this degrade system performance, and does it warrant re-introducing
an exponential backoff scaling for longer wait periods instead of a fixed
interval?

> +	if (out_val)
> +		*out_val =3D read;
> +
> +	return ret;
>  }
[ ... ]
>  int xe_mmio_wait32_not(struct xe_mmio *mmio, struct xe_reg reg, u32 mask=
, u32 val, u32 timeout_us,
> -		       u32 *out_val, bool atomic)
> +		       u32 *out_val)
>  {
> -	return __xe_mmio_wait32(mmio, reg, mask, val, timeout_us, out_val, atom=
ic, false);
> +	u32 read;
> +	int ret;
> +
> +	ret =3D poll_timeout_us(read =3D xe_mmio_read32(mmio, reg), (read & mas=
k) !=3D val,
> +			      10, timeout_us, false);

[Severity: High]
Similar to xe_mmio_wait32() above, does applying a fixed 10us sleep interval
in xe_mmio_wait32_not() risk hrtimer storms for callers with large timeouts?

> +	if (out_val)
> +		*out_val =3D read;
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914215746.2727=
21-2-alan.previn.teres.alexis@intel.com?part=3D1
