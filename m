Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE99606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyzoNi5N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21EC10E561;
	Sat, 14 Nov 2026 01:53:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6D510E561;
 Sat, 14 Nov 2026 01:53:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F83260252;
 Sat, 14 Nov 2026 01:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AC31F000C4;
 Sat, 14 Nov 2026 01:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794621226;
 bh=P2D47t+R5C6ZhlZO3H8W+L7LA+m/gyM/VXSCI42MPWA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XyzoNi5NKZzZJbibpUnFYkAyb5AekLMkuUyqKSAA2fmZxZ1I0UF0jnjXfRkE3YXAW
 Oa6hJobEhzo2T3BYz739hNCvWxYt0TG+Uq6ls5PUS9Poq/kt7MXnulSEMJ+/z30B/O
 pSOko+yUA/YT8a6KFBuu51nFTVQ1H05dDxz1JIyYzeeMV8I14NY8fNrqg1msMh27dv
 M71ov7sgXYUCKByGPI+1eKd4tbcxy9bXRHDKmLKpLkSkWhuhuG0oTP6WOp3U1Dw4tu
 BCNnQwaQCEHVLw6Rm0tSv04Zayh0lMtLZXRc40EMTFHYlXmBIshQVSInF/+2gIeD7o
 F8DRP+tJJ/hUA==
Message-ID: <sashiko-outbox-214015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] drm/i915: Evade the vblank on the scanline of the
 joiner primary
To: ElXreno <elxreno@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114014335.2132756-7-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
 <20261114014335.2132756-7-elxreno@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:53:45 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915: Signed-off-by trailer uses handle instead of real
  name
--

commit 516746727da5577decb0038cc22a5dddd9cbc589
Author: ElXreno <elxreno@gmail.com>

> drm/i915: Evade the vblank on the scanline of the joiner primary
>
> The scanline counter of a joiner secondary pipe was observed to wrap
> at 8192 lines on Arrow Lake, with pipes A and B joined. Sampling
> PIPEDSL of both pipes, they agree up to line 8191, which is the
> largest value pipe B ever returns, while pipe A counts on up to the
> vmax vtotal. From line 8192 on pipe B reads 8192 lines less than
> pipe A. This comes from measurement only, I have no documentation for
> it, and I could not check whether it is a property of the joiner
> secondary or of that pipe.
>
> It is harmless as long as vtotal stays below 8192, which every fixed
> refresh rate mode that needs the joiner does. With VRR the vmax
> vtotal can be larger, 12200 for a 3840x2400@240 mode with a 48 Hz
> lower limit. The vmax vblank start at line 12160 then reads as 3968
> on the secondary, vblank evasion on that pipe never sees its evasion
> window, and the pipe gets armed across the vblank:
>
>  Atomic update failure on pipe B (start=3D48480 end=3D48481) time 8 us, m=
in 12101, max 12159, scanline start 3965, end 3969
>
> All joined pipes run off the timings of the primary, so look at the
> scanline counter of the primary when evading the vblank on a
> secondary. This matters for the commits that still take the per pipe
> critical sections with the joiner.
>
> Only the evasion is changed. The vblank timestamps of a secondary
> still come from its own counter, and so does the end scanline in the
> message above, while the start scanline is now the primary's.
>
> Signed-off-by: ElXreno <elxreno@gmail.com>

[Severity: High]
Documentation/process/submitting-patches.rst requires a real name in the
Signed-off-by trailer and does not permit handles or pseudonyms. Could
this be updated to use a full real name in both the Author header and
Signed-off-by line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114014335.2132=
756-1-elxreno@gmail.com?part=3D6
