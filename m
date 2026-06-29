Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABF9C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96AAC10E78C;
	Mon, 29 Jun 2026 13:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EOwwaOIN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D68D10E78C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:23:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 218B2400AE;
 Mon, 29 Jun 2026 13:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9701F000E9;
 Mon, 29 Jun 2026 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782739384;
 bh=M/hws3QJsI1dQNwnIvGQGYXsx9igw4RW3AwP4LISd/U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EOwwaOINLu4S+nEVl4VV3tbtEMCq0ir6/ij7O0o4+n7sKrkD9f2u0yECKgJOvxgGq
 vJjfQXQoEhwbaCbTcLzKES32nujswwNMsykEvDyHF9l3fNSLuG5J4hFr8/DbDT8c1t
 IdM1II2clMJfbjMGMACO0B62YkQborbb8ZdwSCH0vB5bf2rcHd5UM0H57SOGhlwDow
 vBkf2eCjPWrH4tD48+2rzuMLRTsu0z+RiKmTcUzY3ZOyQWdeaHrcYZYsMaEfEBlTeo
 DxSBbF2lwouWMeH8jo0disztF7QB9n/c+a7PbrmdPjLGF9QZgJYI0fnj74wMgK8ccI
 VHRD0QQ3pikZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Remove unused-but-set variable hubp from
To: "Markov Gleb" <markov.gi@npc-ksb.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629130907.124-1-markov.gi@npc-ksb.ru>
References: <20260629130907.124-1-markov.gi@npc-ksb.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:23:03 +0000
Message-Id: <20260629132303.CD9701F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch creates an inconsistent state by removing a redundant =
`hubp &&` check at the end of `hubp1_is_flip_pending` but failing to remove=
 the identical redundant check at the beginning of the function, and comple=
tely missing `dcn20_hubp.c`.

Pre-existing issues:
- [High] `union large_integer` is incorrectly defined for big-endian archit=
ectures, causing 64-bit addresses to be split into the wrong 32-bit registe=
rs.
--

commit 48f884fa7d92e532907b613a494b6862ba88449f
Author: Gleb Markov <markov.gi@npc-ksb.ru>

drm/amd/display: Remove unused-but-set variable hubp from
   =20
The final check of hubp for NULL covers all remaining lines of code, since
the value of hubp does not change until the end of the method.
This check is redundant because hubp1 is already dereferenced within the
macro.
If it were NULL, the program would have already failed to proceed.
Remove the left part of the expression with the logical "&&".
Found by Linux Verification Center (linuxtesting.org) with SVACE.
Fixes: be1fb44389ca ("drm/amd/display: Check null pointers before used").

> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/dri=
vers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
> index 7c97a774141ff..d8eb5996b5774 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
> @@ -772,8 +772,7 @@ bool hubp1_is_flip_pending(struct hubp *hubp)
>  	if (flip_pending)
>  		return true;
> =20
> -	if (hubp &&
> -	    earliest_inuse_address.grph.addr.quad_part !=3D hubp->request_addre=
ss.grph.addr.quad_part)
> +	if (earliest_inuse_address.grph.addr.quad_part !=3D hubp->request_addre=
ss.grph.addr.quad_part)

[Severity: Medium]
Is this fix complete? Earlier in hubp1_is_flip_pending() there is another
redundant check that wasn't removed:

	if (hubp && hubp->power_gated)
		return false;

Leaving this check at the top of the function might be the root cause that
implies hubp can be NULL, which could still confuse static analyzers.

Also, it looks like a similar redundant "hubp &&" check exists in
dcn20_hubp.c:hubp2_is_flip_pending(). Should that be addressed in this patch
as well?

[Severity: High]
This is a pre-existing issue, but while looking at this code, does the use =
of
quad_part here work correctly on big-endian architectures?

The earlier REG_GET calls read the low and high parts into the address:

	REG_GET(DCSURF_SURFACE_EARLIEST_INUSE,
			SURFACE_EARLIEST_INUSE_ADDRESS, &earliest_inuse_address.grph.addr.low_pa=
rt);
	REG_GET(DCSURF_SURFACE_EARLIEST_INUSE_HIGH,
			SURFACE_EARLIEST_INUSE_ADDRESS_HIGH, &earliest_inuse_address.grph.addr.h=
igh_part);

Since large_integer is defined unconditionally in dc_hw_types.h as:

	union large_integer {
		struct {
			uint32_t low_part;
			int32_t high_part;
		};
		...
	};

This maps low_part to offset 0 and high_part to offset 4 regardless of
endianness. When earliest_inuse_address.grph.addr.quad_part is read as a 64=
-bit
integer on big-endian architectures, wouldn't the high and low 32-bit halves
be swapped?

Could this lead to incorrect physical address comparisons here, or hardware
registers being programmed with swapped address halves?

>  		return true;
> =20
>  	return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629130907.124-=
1-markov.gi@npc-ksb.ru?part=3D1
