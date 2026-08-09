Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9746BC5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 19:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D060E10E1D8;
	Sun,  9 Aug 2026 19:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zvu5iflv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B729F10E1D8
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 19:33:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF50E600AB;
 Sun,  9 Aug 2026 19:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFA91F000E9;
 Sun,  9 Aug 2026 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786303984;
 bh=MZfmLPR63Q609QPzuEjEPjGB1ylOqpXGZKJybMkWG/0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zvu5iflvlUot7ieKTHpJeGYN0hv2TYfp/erjqiVyDiOw5lf9x7Be4yOk+NzCvNf+j
 UjaBGfu5oq7qI00knvYWk6X+I/jY2n/vtHsPr8hODGoMK31pg2zCz7QmXEecJjNN+b
 4YcOHeg8/l/0gmSJZ6rX6VwCS5RpfQsKOpYQwK4nCwscUONXL+RX5sZ5vFoU8bR0c0
 5cL88WBT7cRuHQ26NwssvWsMYJlM1hJSy0eSoIbgU0sr27BrPWucSZ/m8cLToaDkLT
 O73OKqCxnry2tggcBcGqaFaE/mF5H9vYt4EHU/YbowP9pv0Pekdz5gbOa+NZA1QkJG
 hpbNXfxcX8Gzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] drm: Add drm_timeout_rel_to_jiffies()
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809-drm-timeout-helpers-v1-2-2de67405a145@igalia.com>
References: <20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com>
 <20260809-drm-timeout-helpers-v1-2-2de67405a145@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 19:33:03 +0000
Message-Id: <20260809193304.4FFA91F000E9@smtp.kernel.org>
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
- [Medium] The overflow guard in `drm_timeout_rel_to_jiffies()` is ineffect=
ive on 64-bit architectures, failing to prevent internal `u64` wrap-around =
in `nsecs_to_jiffies64()` for specific inputs.
--

--- Patch [2]: [PATCH 2/6] drm: Add drm_timeout_rel_to_jiffies() ---
commit c015d0990b1688d1fc81fe1000d64e7430d1d234
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm: Add drm_timeout_rel_to_jiffies()

This commit introduces drm_timeout_rel_to_jiffies() to convert relative=20
nanosecond timeouts into jiffies. It is intended for drivers whose wait UAP=
I=20
takes a duration instead of an absolute deadline, and includes an overflow=
=20
check to safely handle large values.

> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
> index 78e9f65e54779..30ad3e8ebc92a 100644
> --- a/drivers/gpu/drm/drm_timeout.c
> +++ b/drivers/gpu/drm/drm_timeout.c
[ ... ]
> @@ -45,3 +46,31 @@ signed long drm_timeout_abs_to_jiffies(int64_t timeout=
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
Is this overflow guard effective on 64-bit architectures?

On 64-bit systems, MAX_JIFFY_OFFSET is around ~4.6e18, so MAX_JIFFY_OFFSET =
/ HZ
is roughly ~4.6e16. Since timeout_nsec is a u64, div_u64(timeout_nsec, NSEC=
_PER_SEC)
can never exceed ~1.8e10, meaning this condition is mathematically impossib=
le to
trigger on 64-bit platforms.

Because the guard can never be met, can highly specific inputs cause
nsecs_to_jiffies64() to silently wrap around internally?

For example, when HZ makes nsecs_to_jiffies64() use the n * 9 calculation, a
carefully chosen timeout_nsec (like ~64.9 years, or around 2049638230412172=
402
ns) could wrap around internally to a near-zero jiffies value, resulting in=
 a
premature timeout.

> +
> +	return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(timeout_nsec) + =
1);
> +}
> +EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-drm-timeou=
t-helpers-v1-0-2de67405a145@igalia.com?part=3D2
