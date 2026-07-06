Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAE2C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D0110E8D8;
	Mon,  6 Jul 2026 11:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hbZMC1UR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BEC10E8D8
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:38:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B94F9416B1;
 Mon,  6 Jul 2026 11:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C801F000E9;
 Mon,  6 Jul 2026 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783337915;
 bh=l+aT3QZ2N+Ch8j6u7o5Q++W7zx0tOiHFvaY9CK5XacA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=hbZMC1UR0GoPIJQIFj9F7L53KpVakJp+ost79Sz0pGLFXqIZGq4hpI0i78mKOkQYr
 sm6YA3otDKGYbtEqXU153x3EtNrvLRCXBpTBNR7CwAYV3wGpVP2qO5R7/O8/S+vQCa
 wlMk0AIN5xrYNaOd8kH3j+TAq3c/YNKRZFKF9EDAwDxH5w4UlaKFflkOviIult5Ndr
 adWezq0FKAckU2RC+E/OxYZIH8RVWCQd5kdFQQJKgpi9bdQQ5iZLt24yZrmiabfi8z
 ZQp9dFfISOu4oHfF1/z0b0BTu6Ua/ay98W6FAUx3n+bAed51x3MU66y4uQzw3rTqls
 cf1TEMpPsCLCA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 13:38:32 +0200
Message-Id: <DJRGJ2WRZJE0.3E2KH7DEC4LAA@kernel.org>
Subject: Re: [PATCH 1/2] drm/sched: Guard sched->ready with ACCESS_ONCE()
Cc: <phasta@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260629104040.2695163-2-phasta@kernel.org>
 <5ed4ecfe-05bb-4bdd-9aa3-155e1d926861@kernel.org>
 <2abbd54a7908f5ee82bcffb22bf0dccc05734bbe.camel@mailbox.org>
In-Reply-To: <2abbd54a7908f5ee82bcffb22bf0dccc05734bbe.camel@mailbox.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon Jul 6, 2026 at 10:44 AM CEST, Philipp Stanner wrote:
> On Mon, 2026-06-29 at 14:09 +0200, Danilo Krummrich wrote:
>> > +	WRITE_ONCE(sched->ready, false);
>>=20
>> Don't we need smp_store_release() here and
>>=20
>> > +	return READ_ONCE(sched->ready);
>> smp_load_acquire() here?
>
> Maybe. Not sure what the precise access rules would be. To really get
> correctness, all counter-parties you found in amdgpu would have to
> remove their layering violations anyways, which is beyond my scope.

Fair enough, let's get it right in the core infrastructure then.

>> Also, what about drm_sched_init()? It also seems that this is accessed f=
rom
>> amdgpu without the drm_sched_wqueue_ready() helper about a million times=
. :)
>>=20
>> 	$ grep -Rin "sched\.ready" drivers/gpu/drm/amd | wc
>> 	$=C2=A0=C2=A0=C2=A0=C2=A0 119=C2=A0=C2=A0=C2=A0=C2=A0 544=C2=A0=C2=A0 1=
0320
>>=20
>> There may be false positives, but from a quick glance at least most of t=
hem seem
>> to actually come from the scheduler.
>
> Correct.
>
> Your ordering comment hints at me that you would rather see the ready-
> flag be left as is, if it can't be made right 100% (which it can't).

No, the change makes sense. Getting it right in the core infrastructure is =
the
right thing to do, even if you don't want to fix up amdgpu.
