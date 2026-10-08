Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CA7CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15AE10FCBE;
	Thu,  8 Oct 2026 07:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KR4rDzTn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CFC10FCBE
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:38:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C141419C7;
 Thu,  8 Oct 2026 07:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFCE1F000FF;
 Thu,  8 Oct 2026 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791445096;
 bh=42tEfSCwrEQdTCVPUj466kCjGMPLnBr3HCBYWUS+8PA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KR4rDzTnW/+PIkHrk8m3UPx+f25GG0yv8fpDYUU13qD8Y+nb/QQ2dbcj00lGXY2rT
 JMxTJ/KWEWVAM2SUXdYsEW4qIVW9lbMZFr9/kt8a33t2RsZ9fMrBtf/u8sW5NZTCi4
 iZ7pttPrQe9NxdVGubRQyX46QcvYxfJYXqXDhY/cZn/eSvhfiFUma8MQ5bUJeFug5K
 TdcxEuwFrK1osirkqJfFyWd/ZgMZSZvNDAC2fuHmSyYHbC2CYcU/ak+EIYPaJ3eTAy
 O4IxvADX0rpA/TQg3u8wwhNu3WnQdxEaMd/z4nI1nP7BENC8NADOg9gvHACzK/OHok
 0+EPqwK1YCXAA==
Message-ID: <sashiko-outbox-163771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Increase the HDMI HPD disconnect
 filter time
To: 2564278112@qq.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_B4299278015532212E7D2E624FA23C09C90A@qq.com>
References: <tencent_B4299278015532212E7D2E624FA23C09C90A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:38:15 +0000
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
- [Medium] drm/amd/display: HDMI HPD disconnect filter masks valid KVM puls=
es
--

commit 56a856b6f885a6969be27edf739c5c17d243d79b
Author: Wang Jiang <jiangwang@kylinos.cn>

drm/amd/display: Increase the HDMI HPD disconnect filter time

This commit raises the DVI and HDMI HPD disconnect filter time from 100ms to
800ms to hide bouncing hotplug signals when sinks reconfigure.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c b/d=
rivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
> @@ -82,8 +82,12 @@ bool program_hpd_filter(const struct dc_link *link)
>  	case SIGNAL_TYPE_HDMI_TYPE_A:
>  	case SIGNAL_TYPE_HDMI_FRL:
>  		/* Program hpd filter */
> +		/* Some HDMI/DVI sinks drive HPD low for a few hundred ms while
> +		 * they reconfigure; 100ms is not enough to hide that bounce,
> +		 * which is then reported as a fake unplug/plug pair.
> +		 */
>  		delay_on_connect_in_ms =3D 500;
> -		delay_on_disconnect_in_ms =3D 100;
> +		delay_on_disconnect_in_ms =3D 800;

[Severity: Medium]
Will this 800ms filter in program_hpd_filter() mask legitimate hotplug puls=
es
from KVM switches or AV receivers?

Standard HPD low pulses used by these devices to indicate a configuration
change are typically between 100ms and 500ms. Because this filter is progra=
mmed
in hardware, an 800ms threshold completely hides these valid pulses from the
CPU, meaning the HPD interrupt never fires.

Could this cause the driver to miss valid hotplug events when users switch
inputs, resulting in blank screens or incorrect video modes because EDID and
HDCP are not renegotiated?

>  		break;
>  	case SIGNAL_TYPE_DISPLAY_PORT:
>  	case SIGNAL_TYPE_DISPLAY_PORT_MST:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_B4299278015=
532212E7D2E624FA23C09C90A@qq.com?part=3D1
