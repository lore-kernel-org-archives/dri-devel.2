Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44615CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8FD112948;
	Thu,  4 Jun 2026 17:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bZD6Aft3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D19112948
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:45:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 18FAB60052;
 Thu,  4 Jun 2026 17:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3711F00893;
 Thu,  4 Jun 2026 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780595099;
 bh=NXfb9RF7XsmjVt/iYPcJRj5crMD8V3NV+fidKflvLbc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bZD6Aft3+L9N2JXRgcM6wCVDkeJqPktYVakTB31qKKjga6MFgw5GC6Fw66BXCWkEn
 7mwAc67TyudUg69kmBmg6yGL4QIa6LNCkAqK6GX62J5roIMGqeoS2PyZDLYT1f48Vn
 UzyH6iu0bxEV5yT67yDRnQ4L8mk0Cg5P/pNOlMxTjgjiD016n19vKbUO+OgFjkUxFv
 k7Mbx3ZlioJhu5BIaMKg5TiTIFl3H40h6vh1MenGfybYMSd4BjV7fM/d/ceXuz6fW3
 vY1R3WBQpjUm9C239NjB2W3XsNiZemXyu0TpLJeehRtSH/daQ7lkD0JM7xVxO8iKPG
 SO5glUXx7hiHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] drm/panfrost: Prevent division by 0
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-claude-fixes-v2-2-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-2-57c6bd4c1655@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:44:59 +0000
Message-Id: <20260604174459.9E3711F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] The exact same division-by-zero vulnerability fixed in panfrost_de=
vfreq.c is present in the Lima, Panthor, and Nouveau (gk20a) drivers.
--

commit dc73067c1030f65e3609c76a060b1b1176f85e4e
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Prevent division by 0

This commit clamps the devfreq total_time to 0 when it is less than 100ns
in panfrost_devfreq_get_dev_status() to prevent a division by zero error
during debug printing.

Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88

> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index b51c307788110..e34de47bf43bb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -78,7 +78,8 @@ static int panfrost_devfreq_get_dev_status(struct devic=
e *dev,
> =20
>  	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
>  		status->busy_time, status->total_time,
> -		status->busy_time / (status->total_time / 100),
> +		status->total_time >=3D 100 ?
> +			status->busy_time / (status->total_time / 100) : 0,

[Severity: High]
This is a pre-existing issue, but the exact same division-by-zero vulnerabi=
lity
fixed here is also present in other DRM drivers.

In drivers/gpu/drm/lima/lima_devfreq.c:lima_devfreq_get_dev_status():
    status->busy_time / (status->total_time / 100),

In drivers/gpu/drm/panthor/panthor_devfreq.c:panthor_devfreq_get_dev_status=
():
    status->busy_time / (status->total_time / 100),

In drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a_devfreq.c:gk20a_devfreq_ge=
t_dev_status():
    status->busy_time / (status->total_time / 100),

If userspace repeatedly reads the devfreq load in quick succession, total_t=
ime
can be less than 100ns, leading to a division-by-zero kernel panic when deb=
ug
printing is enabled.

Should these other drivers be patched similarly?

>  		status->current_frequency / 1000 / 1000);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-claude-fix=
es-v2-0-57c6bd4c1655@collabora.com?part=3D2
