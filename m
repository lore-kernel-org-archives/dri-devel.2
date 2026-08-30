Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE081C61DD9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 23:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22D510E2D3;
	Sun, 30 Aug 2026 23:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eMLqMvBw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832E810E23C;
 Sun, 30 Aug 2026 23:08:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7077560120;
 Sun, 30 Aug 2026 23:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88131F000E9;
 Sun, 30 Aug 2026 23:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788131289;
 bh=b1onlhSrnGqb0z7H3cY4B805Mh41bOrQ9tT2MDdJoJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eMLqMvBw5Ujp/wT3C7EIGTt1Exe/pW81jpWcis9erLzM4Skoc2gUvZ9Yaa0XcUUaZ
 ywjGn2r+BoZU8m26mCkQD8RhfT9EMnBsYfKomEA+WpyGJu9aIRQx+ZIDE/o26RFUIn
 258RmMyZMSgRiNrJEFxi2xDTcLRAsQJrRZ68hRQmfMg5LOYn23j54flPMDHKp6TLdz
 nUybwy38lPhEf+a1frXG5If8TQfPM9HEWCUV4xGiWOCSD0bLopmqQYrJ/OC+wYck82
 YHl0s79lP3nxHfirChToomZrM+EfrRlTVUNT1tM2RTimm3u68h6hrehRkJx0rb/Rw1
 V+igCGboLbzDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/gt: Fix request use-after-free in heartbeat()
To: "Andi Shyti" <andi.shyti@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260830225708.3959691-1-andi.shyti@linux.intel.com>
References: <20260830225708.3959691-1-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 23:08:08 +0000
Message-Id: <20260830230808.D88131F000E9@smtp.kernel.org>
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
- [High] heartbeat() dereferences the local pointer `rq` without holding a =
strong reference, making it vulnerable to a Use-After-Free if intel_engine_=
park_heartbeat() concurrently clears the shared pointer.
--

commit aa7ae2412e3834bb064c9442f0f96ffd0058a8ae
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

drm/i915/gt: Fix request use-after-free in heartbeat()

This commit addresses a request use-after-free in heartbeat() by using cmpx=
chg=20
to manage the detached systole reference and replacing direct struct access=
es=20
with a local pointer.

Link: https://patch.msgid.link/20260808184302.1509585-1-shuangpeng.kernel@g=
mail.com

> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/g=
pu/drm/i915/gt/intel_engine_heartbeat.c
> index 6424ecce8bcbe..fc6c53c93cf57 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
[ ... ]
> @@ -152,9 +160,11 @@ static void heartbeat(struct work_struct *wrk)
>  	if (rq) {
>  		if (i915_request_completed(rq))
>  			i915_request_put(rq);
> -		else
> -			engine->heartbeat.systole =3D rq;
> +		/* Keep a newer pulse that raced with the detached systole. */
> +		else if (cmpxchg(&engine->heartbeat.systole, NULL, rq))
> +			i915_request_put(rq);
>  	}
> +	rq =3D READ_ONCE(engine->heartbeat.systole);

[Severity: High]
This is a pre-existing issue, but does heartbeat() safely dereference rq
without holding a strong reference?

If userspace toggles sysfs heartbeat intervals, intel_engine_park_heartbeat=
()
can execute concurrently, clearing the shared pointer and dropping the
reference:

intel_engine_park_heartbeat() {
    ...
    rq =3D xchg(&engine->heartbeat.systole, NULL);
    if (rq)
        i915_request_put(rq);
    ...
}

Since rq is loaded locklessly here without a reference bump, could this
result in a Use-After-Free later in heartbeat() when accessing
rq->emitted_jiffies?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830225708.3959=
691-1-andi.shyti@linux.intel.com?part=3D1
