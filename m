Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFC7C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC6110E950;
	Mon, 17 Aug 2026 21:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jOwZxTkk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD8D10E950;
 Mon, 17 Aug 2026 21:15:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2ED2D601DE;
 Mon, 17 Aug 2026 21:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E9D1F000E9;
 Mon, 17 Aug 2026 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787001332;
 bh=QEr0rRA21WjCDIBRI70eBUz7M8prDjj0zBXStrFdDyU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jOwZxTkktgTIyKLsmu1S0JLCpLosLQO7ddGejEJrIQRVIQ6yzLJSFF42fms1tqZwc
 WIQMVgbYV0SeKC2YNHjrfovXOcwLlG7tSDMD7aDmRlsBD6hjCMvVgUe6hzjNe3XIJj
 zUVNtbuo+2kiU3qU+FjXxJIK0eUpcCN6sfDV3zI1r7Dmkr9TPflC79LBeHqCyF40fT
 48FD+j1Ggi4myfJB9FpfD7td+Xoa9wMQuANMIh8hcRXqk9eWOIs9hPTGb+nxlzOb21
 DatGJuFPZbPeOzyFChG6F8L/ohOMJ2ujRnEHkIEqL39cKxPSM/qQjXEigvUPx4bzD3
 5AdOi79axU/sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] drm: Add drm_timeout_rel_to_jiffies()
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260817-drm-timeout-helpers-v2-2-73052b669f49@igalia.com>
References: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
 <20260817-drm-timeout-helpers-v2-2-73052b669f49@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 21:15:32 +0000
Message-Id: <20260817211532.A3E9D1F000E9@smtp.kernel.org>
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
- [Medium] Inadequate overflow check in `drm_timeout_rel_to_jiffies` allows=
 `nsecs_to_jiffies64` to wrap around for large timeouts on 64-bit systems.
--

--- Patch [2]: [PATCH v2 2/6] drm: Add drm_timeout_rel_to_jiffies() ---
commit 8056b58ff81363ebaf4bcf9d659c346706fc5b99
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm: Add drm_timeout_rel_to_jiffies()

This commit introduces a core helper to convert a relative timeout in
nanoseconds to jiffies. It aims to unify similar conversions currently done
in drivers like i915 and v3d.

> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
> index 78e9f65e54779..18c2719d1fe92 100644
> --- a/drivers/gpu/drm/drm_timeout.c
> +++ b/drivers/gpu/drm/drm_timeout.c
[ ... ]
> @@ -45,3 +46,36 @@ signed long drm_timeout_abs_to_jiffies(int64_t timeout=
_nsec)
>  	return timeout_jiffies64 + 1;
>  }
>  EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> +
> +/**
> + * drm_timeout_rel_to_jiffies - calculate jiffies timeout from relative =
value
[ ... ]
> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
> +{
> +	/* make 0 timeout means poll, as for the absolute variant */
> +	if (timeout_nsec =3D=3D 0)
> +		return 0;
> +
> +	/* nsecs_to_jiffies64() does not guard against overflow */
> +	if ((NSEC_PER_SEC % HZ) !=3D 0 &&
> +	    div_u64(timeout_nsec, NSEC_PER_SEC) >=3D MAX_JIFFY_OFFSET / HZ)
> +		return MAX_JIFFY_OFFSET;

[Severity: Medium]
Is it possible this overflow guard is ineffective on 64-bit systems?=20

Since MAX_JIFFY_OFFSET is extremely large on 64-bit architectures, and
nsecs_to_jiffies64() internally uses a multiplication that can overflow a u=
64
at roughly 65 years, a very large timeout_nsec might bypass this check.=20

If it bypasses this check, the value could still wrap around during the
nsecs_to_jiffies64() conversion, causing the wait to return almost
immediately instead of blocking as requested.

> +
> +	return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(timeout_nsec) + =
1);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-drm-timeou=
t-helpers-v2-0-73052b669f49@igalia.com?part=3D2
