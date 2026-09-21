Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C43C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356D810EB23;
	Mon, 21 Sep 2026 16:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QlMSEGzi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B377E10E1EC
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:07:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69A73414D9;
 Mon, 21 Sep 2026 16:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229451F000FF;
 Mon, 21 Sep 2026 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790006850;
 bh=MxhFv+9+nI8DxhyDzlFZHUWIPvr3tQtItZ5pcLxGCTA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QlMSEGziqBRoZMPtp245qRaDO0tTAJ74C+sCiy6WhZp92jJzXMR+xb6RLQqNhS+o4
 kGUE3uaj0Ypmip+8W1sQS0FmAWAuZHOyGzAySh3L0eJSoTwDmp3pKGiLUa7qerR3Xf
 0WZEoZ/FIBbz6W56mvPLiRDAI2aT+KzR7vn3AEsnPUUkOKAU1yftlxZvJI/yCo7dfM
 4VLp+N7HC5T91D+DzwCFVVXnUi7oyH+Jk4b5R6oAzf+b6sANjBixVhyuA5DuZEGHym
 WnkOl3mRDA2kyFWB/wNVSPbJqwLF6gkR0BckE3NIxUzn+vQZXq8S/FUAQJV3vXl0+5
 iwqtpSHuFFW2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/25] video/hdmi: Add VTEM EMP packing
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-4-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-4-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:07:29 +0000
Message-Id: <20260921160730.229451F000FF@smtp.kernel.org>
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
- [High] video/hdmi: hdmi_infoframe_pack_only() missing EMP support
- [Medium] video/hdmi: missing bounds check for VTEM base_refresh_rate
- [Low] video/hdmi: VTEM pack returns -EINVAL on insufficient buffer
--

commit 453def06fd91297425481a25d9a912cdc54c08f8
Author: Derek Foreman <derek.foreman@collabora.com>

video/hdmi: Add VTEM EMP packing

VTEM EMPs are a type of infoframe that is required for Variable Refresh
Rate. Add code to pack them.

> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 45b42f14a7503..ed9abc7ad2285 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -983,6 +983,10 @@ hdmi_infoframe_pack(union hdmi_infoframe *frame,
>  		length =3D hdmi_vendor_any_infoframe_pack(&frame->vendor,
>  							buffer, size);
>  		break;
> +	case HDMI_INFOFRAME_TYPE_EMP:
> +		length =3D hdmi_emp_infoframe_vtem_pack(&frame->vtem,
> +						      buffer, size);
> +		break;

[Severity: High]
This adds EMP support to hdmi_infoframe_pack(), but does
hdmi_infoframe_pack_only() also need an update?

Drivers that rely exclusively on hdmi_infoframe_pack_only() (such as i915 a=
nd
SDVO) will hit a WARN(1) backtrace and fail with -EINVAL if they attempt to
pack an EMP (VTEM) infoframe.

[ ... ]

> +ssize_t hdmi_emp_infoframe_vtem_pack(struct hdmi_emp_infoframe_vtem *vte=
m,
> +				     void *buffer, size_t size)

[Severity: High]
To be supported in hdmi_infoframe_pack_only(), wouldn't this function need
to accept a const pointer?

hdmi_infoframe_pack_only() guarantees a const union hdmi_infoframe *frame,
but the lack of a const qualifier on vtem prevents it from being safely
called without casting away constness.

> +{
> +	u8 *ptr =3D buffer;
> +
> +	if (size < HDMI_INFOFRAME_SIZE(VTEM))
> +		return -EINVAL;

[Severity: Low]
Should this return -ENOSPC instead of -EINVAL when the provided buffer is
smaller than the required frame size?

All other packing functions in drivers/video/hdmi.c (e.g.,
hdmi_avi_infoframe_pack_only(), hdmi_drm_infoframe_pack_only()) explicitly
return -ENOSPC when size is insufficient. Returning -EINVAL might break err=
or
handling logic in callers that expect -ENOSPC.

> +
> +	/* 4 bits max */
> +	if (vtem->fva_factor_m1 > 0xF)
> +		return -EINVAL;
> +

[Severity: Medium]
Does base_refresh_rate also need a bounds check here?

The base_refresh_rate field is a u16 and can hold values up to 65535, but it
is restricted to 10 bits. If a caller supplies a value greater than 1023, it
will be silently truncated later in this function rather than gracefully
rejected. Could this result in the hardware transmitting an incorrect VRR
refresh rate to the display?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D4
