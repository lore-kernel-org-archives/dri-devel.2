Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55853606A33D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SN4wTjU4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00D210E358;
	Tue,  3 Nov 2026 21:19:30 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B09510E358
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 21:19:24 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a06df2304cso12822b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:19:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793740764; cv=none;
 d=google.com; s=arc-20260327;
 b=oHDdIL3F0kKTj1dfF23csyIlkcNIfwmW/1zWEc0o4SE4UG7mDOBvtJFbKy3hAX+Yue
 aPsdNKbHHO4aciY/Od40UcakJN9pVP1ENBYC5/b0+l65LPkl21LHrZ81Lh6juSUbLI28
 SVucc/tgwdrQZLlH7JxaH3PqXVCf+xV9ShQQ9r3eFGuETyiFU0lueyZaS69qvRJn06Bs
 j8F/l82VfS9Gje074dfWYZWC2x3vEvcoCfGWhhBsigkZPpVQF63juzHqy73WTQzJny4A
 bTTri7fOo5PffzqbD+oHN0sqczKqqwWyX1mvaPwovaZfLDUVfnjJuX21wqx+vauFZP/i
 YBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wBE5bGZhedA//s+lBFPy7kHAF2qFFj2zWvXQd1T2OZc=;
 fh=tuUWWYCiLtpYVlrQNQwT3lVjcYjR8mN9KCElaCKaLx0=;
 b=Hsmlo2aJVs+G0l/nI5VWZ25vfcx0w+aDLnIPQfQi4NQs0fpVPzEJ5Q/q58SPCalRif
 d1O2pZOukM3ZjB/WqCDZ/SohWoT3Wpdkl1l73/pEC3FctLkAnWUmh0siFQgCYe+cQ/tS
 gd5goEgeAaeB9h7UeD2xKNO7Ro6mw3BxB1fFLwH6v7ZMuO5fe7Hj3AYKQxDiQrwXk6Jv
 cXoxy2nbQF97wrEP1tNu8afEHcLZdeNENWoblaFmtRPjK9hW+IlJZOko18V6yby/zYH7
 kpFqUE5b7h2+dEgyRbQjJSmFrYCLi0On7s+ZdQp+UmbwXzvksZkmQxtY3m20ZHJx32NP
 07Hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793740764; x=1794345564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wBE5bGZhedA//s+lBFPy7kHAF2qFFj2zWvXQd1T2OZc=;
 b=SN4wTjU49YqTE8h9q9I76Oq5AuplguGcWuDHhluixuZll+QFyU0xYdL2EEcqk/shtJ
 qk2MWze8V8cF+2IYSWns209PXujBAFqj0erPcnrPV03qoI0B1BFkjwzQ72H71ObpO5Oz
 VYxymIWhgEV/gJYO9xIHe0CZIAtMzpuDqqwe/NmFJFukQ2OpHp/xOEt4BuxfmQFYTyjM
 SDntQi8Py5wCwKb+Nz79wvOaSq0PKO2OV7QZhhdzIeEIfW5N3a6nerDeCKFpw2R7PwWI
 vpd0M8WafHgRePUgKJL207sxPuXfmCgg+V5jnlG8KIO4wrAyu9kdfJvh1/bIwPoOHn7h
 dJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793740764; x=1794345564;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wBE5bGZhedA//s+lBFPy7kHAF2qFFj2zWvXQd1T2OZc=;
 b=IGvglozgx8sH2SRCb4CxSvFv55Ngm29I7Mosx4nAtAGsm75vqWeEbB1sp/AkGgMFxW
 IUwUeSEb2pJo0lnIc2Skv65u/MV5o0ObAZ886Ca3k5JSlNXkz3oYnID9UnFNVWs83j6P
 oSXiV1VbpmkyxNNm9MhoKQcMnbp4y83fUKCjC7vunDWUWtgmpADYgfXfptp9fPo54SXC
 qB/JTf3WpBXsgoaXl1djT+EH52eN0HdlJQ41OlobAtokai9eMRXvH/sDDH4TTZE3PZax
 vqSdyEPYvDkFnJpfZOUmpDE3l+pvd18ikIKFR94OpHdTRyCZZvWWvYcTvFLrttQxcnxS
 pfAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCOcXArYR2V9RJbpbkPGA47DA2ySkUf76Nl5xKGHsZok+AN6xBwUaO948xoPD69hdRSAMZgQ25S9Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/mcJr7xRVaiYtG/r40NVPKh9T0ud4+1H3VATMor4BBUnU14b69
 6u/xc5HJPhUe9d+v6CwVsgHETI3kEQIR94+tWZopYdR75NNPfbIxZSb6DCRbjFDzmKph6AQINnM
 25+PWYpZ0d7SYwHwnBVJak1H1ByuSyak=
X-Gm-Gg: AYBFou02ypuUF2OUZH0cX0bfuWlHsssDLUpNJmz1iszGAusexnh6tgclAovGYhMH0tv
 jD7+hZnO2c0gcpSBLTrWVxW/2jD+a7t4Er015d12FqlWkgmIZBH9iI3L/tfkk7Ify+qaTWqzlqy
 o1ki7RwBjz/d2mAy1Sm2xr88gXijNK3YdoIwf4oIIktyD7D+ew/Ae/cltmf1cK+JGDxheH/66K6
 vaOP6v9Mx+xSmnrGDlNGv9x5pbhD2Dp9LK37vNDP/DtzYIVIhcdDufikhSte3OhICB/mey7jFR7
 VMSktL3b3tjttS4kvO9zEchxSoqZETCxAYqdtd9cVN1jA1NLXwv8ZX9nIkwXQqbkGB32RnyMYo5
 8miBsnzChoaYzUu5bLWHZEiCHTalvfJLZ5hMtMRwuGCLEn2QoFTRt9NzGpZB6+xD9ZrbW8QIVCb
 MomNTLDlwR7nz7tPWXNQkQ/SY=
X-Received: by 2002:a17:903:388b:b0:2e9:5714:607a with SMTP id
 d9443c01a7336-2eb3641d0edmr226893925ad.2.1793740763907; Tue, 03 Nov 2026
 13:19:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <aujZcJBUyQ7iX_PM@intel.com> <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
 <aujikV14tF6K1Xqw@intel.com> <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org> <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
In-Reply-To: <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 16:19:11 -0500
X-Gm-Features: AclHuK-QY53_MeeAsq2_7VWuOuBtQ5OHeIVET2v1xKAgr_M7JWpMcXTZioJWzRk
Message-ID: <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
To: Danilo Krummrich <dakr@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Dave Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, 
 linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 4:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Tue Nov 3, 2026 at 9:33 PM CET, Rodrigo Vivi wrote:
> > On Tue, Nov 03, 2026 at 08:32:48PM +0100, Danilo Krummrich wrote:
> >> IOW, linux-next merges tip/for-linux-next, and tip/for-linux-next merg=
es
> >> $tree/for-linux-next, rather than $tree/$tree-next.
> >
> > For this to work we need:
> > 1. xe to create for-linux-next for-linux-next-fixes
> > 2. amd to create for-linux-next for-linux-next-fixes
>
> Huh, I thought all the trees are doing this already. Well, that explains
> where the the problem comes from. :)
>
> In any case, drm-misc, drm-rust and drm-intel already have for-linux-next=
 and
> for-linux-next-fixes, and the implementation is generic. So, adding it to=
 xe and
> amd is trivial.

I've started doing this for amdgpu this cycle as well, but I still
pushed an amdgpu-next branch as well since that is the source of all
of the cherry-picks for -fixes and -next-fixes.

Alex

>
> > 3. All maintainers to agree to move their -next-fixes on the same day t=
hat
> > they are sending the last PR. Or have a new dim sub-command dim final-p=
r
>
> That's what drm-misc, drm-rust and drm-intel promise, yes.
>
> Something like dim request-pull --final seems like a reasonable helper to=
 me.
>
> > 4. Instrument dim to have this secondary reconstructed tree instead of =
the
> > implemented chop.
>
> I think for this part isn't different; tip/for-linux-next just merges one=
 or the
> other.
>
> > 5. Prepare every committer to deal with this extra build time and extra
> > conflict resolution.
>
> Which extra build time and conflict resolution? You have two tip trees in=
 either
> case, no? One that contains $tree/$tree-next and one that doesn't.
>
> > I honestly prefer the simple chop solution. But it would be okay by me
> > if you take the lead and implement the dim changes for this flow.
>
> I don't mind doing this. :)
>
> >> I.e. the ultimate source of what is linux-next material remains to be =
$tree.
> >>
> >> In general, I think that this is more accurate and probably less error=
 prone
> >
> > I would argue the other way around.
> >
> > The reason that we are seeing so much escapes from next-next into linux=
-next
> > might be exactly by the fact that the blackout right now depends on 2 s=
eparate
> > actions to help simultaneously (last PR + rebase of -next-fixes). What =
most
> > of us are not doing.
>
> Interesting, why is that? It seems to work perfectly fine in drm-misc, dr=
m-rust
> and drm-intel.
>
> The only thing maintainers need to do is push $tree-next to $tree-next-fi=
xes at
> the cutoff. The rest is automatically handled by dim already.
>
> >> For instance, let's say a tree closes (i.e. tags the last -next tag of=
 the
> >> cycle) a few days before -rc6, it could happen that subsequent commits=
 to
> >> $tree-next still appear in linux-next because tip still picks them up =
until
> >> after -rc6. So, after -rc6 those commits (that were in linux-next for =
a few
> >> days) would disappear from linux-next again.
> >>
> >> Not that big of a deal, but technically they didn't even belong in lin=
ux-next
> >> for only a few days.
> >
> > But well, this is a good catch and a bug on the current proposal indeed=
.
> > Should we move that to -rc5 to -rc1? We just need to ensure that everyo=
ne
> > have at least 1 PR after -rc5 and we are all aligned.
> >
> > The only caveat is that patches landing in drivers-next during -rc5/-rc=
6 will
> > take a few days more to propagate, but it shouldn't be the end of the w=
orld.
> > It is still a couple weeks before the merge-window.
> >
> >>
> >> If we kept $tree/for-linux-next, tip would never pick those commits up=
, because
> >> a tree that closed a few days before -rc6 would already have switched
> >> $tree/for-linux-next to $tree/$tree-next-fixes.
> >
> > Well, if you don't move your -next-fixes at the same time of your last =
PR
> > you are leaking that as well. And this is happening.
>
> Where is this happening?
>
> > At least now we know why it is happening (besides xe and amd sending
> > straight from -next instead of having the -for-linux-next branches).
>
> I think if xe and amd would have those branches there'd not be a problem =
to
> begin with.
>
> But independent of that, I think it is nice to give the "fully merge conf=
lict
> resolved thing" to Mark. :)
