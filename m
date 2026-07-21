Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC03C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB3D10E8E9;
	Tue, 21 Jul 2026 11:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oi04spBa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072B110E8E9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:03:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B33E42A71;
 Tue, 21 Jul 2026 11:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ACA1F000E9;
 Tue, 21 Jul 2026 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784631790;
 bh=jnqBbvf29F//CNHhQmNFcQsozSJ7qfyC4BcWfsQiKZE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oi04spBaG42duuAGGO9LsPPRccPyqsYBykF4eSiFEeUWPjcdlD1KrMIGnedzk85V7
 0kjaWpbquFUrQs2xw/CKi/O0pNS7oOBstdIuXVi9UBISPhySHBeZfdRhFHbNSvp5DI
 Ml2Wzk4HDt3kOWoRR6DTHNHwyxmPCIUBqI6Xbo+GQi5xc1Z0fH9mvv0JSip8W7d0Q/
 qA/oJ/0XPOQHTWjXTkycihH0cZmR4X/zZ8kj6XcGfSrXBQYSYVELvGaVemluqNNSIt
 tcXd9iW/DcE6hCLMT75D1OTjV3NpQusUv5u5VNoANXE42P8a/Sjm5ImTPNl/eVUGqm
 CBVtKVdR9WInQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/drv: Add buffer bounds check in drm_dev_wedged_event()
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721105041.642598-2-mallesh.koujalagi@intel.com>
References: <20260721105041.642598-2-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:03:09 +0000
Message-Id: <20260721110310.54ACA1F000E9@smtp.kernel.org>
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
- [Medium] The newly added buffer bounds check evaluates truncation at the =
wrong time, missing partial truncations on the final recovery method and ca=
using string corruption.
--

--- Patch [1]: [PATCH] drm/drv: Add buffer bounds check in drm_dev_wedged_e=
vent() ---
commit d685223ec7cc48ba38c7ea409895bbfb9a46aadc
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/drv: Add buffer bounds check in drm_dev_wedged_event()

This patch adds a bounds check to prevent silent truncation when
formatting the wedged event string. It emits a warning and breaks
the loop if the buffer is full.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 1ff0bf7cba6aa..63eef0a19e993 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -578,6 +578,9 @@ int drm_dev_wedged_event(struct drm_device *dev, unsi=
gned long method,
>  		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
>  			break;
> =20
> +		if (drm_WARN_ON(dev, len >=3D WEDGE_STR_LEN - 1))
> +			break;
> +
>  		len +=3D scnprintf(event_string + len, sizeof(event_string) - len, "%s=
,", recovery);

[Severity: Medium]
Since this bounds check is placed before the scnprintf() call, what happens
if the string is partially truncated during the final iteration of the loop?

If multiple recovery methods are present and their combined length exceeds =
the
32-byte buffer during the last iteration, scnprintf() will partially trunca=
te
the string. Because this is the last iteration, the loop terminates without
ever reaching the bounds check on the next iteration.

Consequently, the truncation goes unnoticed, and the post-loop cleanup code:

	if (recovery)
		/* Get rid of trailing comma */
		event_string[len - 1] =3D '\0';

will overwrite the last valid character of the truncated string rather than
a trailing comma, emitting a malformed string to userspace.

Should the truncation check also evaluate the result of the scnprintf() call
to ensure partial truncations are caught on the final loop iteration?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721105041.6425=
98-2-mallesh.koujalagi@intel.com?part=3D1
