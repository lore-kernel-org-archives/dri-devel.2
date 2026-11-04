Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76FC606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IdAjcdvb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3E310E1DB;
	Wed,  4 Nov 2026 03:29:26 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B0F10E1DB
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 03:29:19 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-5495d549924so2043231cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 19:29:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793762958; cv=none;
 d=google.com; s=arc-20260327;
 b=SPd3EFaivOrC12wnF4pKqxmNVu2Q1sZuX6kWQGREUJIH5MamzPXrVC2M7wE5IRbHy1
 JZSvxu+pEwbjvpuKVNRL+Or2JfiM1R2eUziTyXjfI6xSoaahF1cTTr2TsQDNhCiuq9Eg
 qs9Iq0a/zDZP6j7jg1tCvCj5nxbUoLjUX/5wC+rBtlfT5jOIzpf0rzyFsNFYw5fhtorG
 gtrJS0tX5i+S+wBaqN0WxJhiTplpVEorQcLLdkttDlpZZeIhuCxrZDIH1PwSngfUWetB
 NlpBp4+6ZLT+XUSVp/3ZZXYZiNFGefNQH5KIzLX2zynfzeGxcR3sYPeSt13fJdFg4DI7
 TadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oO978g2g+ySozYrr4RRVibDsnm8jDdPaT+WiTnU9rNQ=;
 fh=Scqlrk8otiHIIskJdrFzjuxCvaZdOcVRNo4c1uRVDr4=;
 b=qrYr8UYIVZDB+M0lkjiz57vx9K54oAIQn5GsgZ30I7Y15WZlxRNOg+Ua+2Hn2he88M
 Dh+lLT2FXc4T0FhgvDSdfk2P95MA+YMl3OUqx7wiFK3bcX2/LPyfgFHahBgtTE3/XMJN
 a7NN4k5h2ISwcAkay8dphawWwOB5tiJ3/wTL3Cvbs6fsnl5pX/8mIrmYQ5/EqntgFsP/
 O+b3ftX3T/w7a98S03bxjecpKPgSZs1RrBQD8B09bUBjYpZ2/PibpgZmxY8sjcLkNGiT
 ibN3fnVhnxb5vdHo4x1Agx3BwP9fjueuYanC1Da8zoiu96h3lUtKnqbDO3Y3Yv8K2Zc2
 JalA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793762958; x=1794367758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oO978g2g+ySozYrr4RRVibDsnm8jDdPaT+WiTnU9rNQ=;
 b=IdAjcdvbzXGW2G4P/GsQMrn8pfZvfAuhxFzXyD39o/lfv8wpSsGXo+jOWYT9gSA8yK
 De9DvNdnxPvqTZS5c+yY1mINTRGFBVN5F5yqPGIcR8arlC1S2TPH405DRUrOMTnlSm42
 /oo78YGOrk/U50weEFtvG/HVpbsw5YTafImsKGccrVupy6gdHslOoK440OR9LrPkWQpQ
 laZL01eW7e/+EmFr6DqUq6bh11WCtM8zglEdFwh5ZQTZpwADskp+NuBRG6pEP+gkauWL
 rgeokEreXH62NVn2qNA6WfppIK8n+ebkiwHlc8PzNLUstfHn/68XhgZ3rJtAHDx+r0l/
 xeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793762958; x=1794367758;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oO978g2g+ySozYrr4RRVibDsnm8jDdPaT+WiTnU9rNQ=;
 b=g0nTUHD3zHi9SDogt5Iqej4temRPSUtBSUPis0ZKzE6u8+wrpNGqXIr9K/cZyAt0UM
 boICIarah/q14raDilrphXCGoUWTs178vL0lJz9ftzMFCWZeXloIHRakVm9ZESH0g1uR
 XBE3OrHrVSWpVyGLsEMeS46BDDjrhCw9pcw5iH+XzKtYQ/48n4PkXGvOF6/dcrP8Z8s1
 KPlmx0mb2kB5IQkDqhfu5EpT2asPrTnPLqZmSOZ2A5m5/V3U1US+ASJt91I/lK+VFTPr
 Pf51HCoDKfa0LCenYB+ctX6hifDSUKw2ycdROoXtV3yj15wZLYdEGvPpMyCeWNLRZ/lZ
 I95w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ2AaGdqM1NzXIouEyBj0yc7K7enR9Gqq3q93d6zSa36iiz5k9U7AMKuuiUvV1qN+49GM64WBRnK0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+rf0v1QWCoz/NuPGMHlNBi1+oqA41qeasg4DQLB/yxMfuwip1E
 DwHPfZ5DHa61AH9kUSQlT6/ncUVF3AjbNrHhYuLfJ6CbMNRNPoTMh8XBNlTVWiHpq5IxXYV27+L
 hbe8Hk4dAVhtlQ1/huwzfAJ7PiB87h50=
X-Gm-Gg: AYBFou2hjRYWDP849Vodal+dO9KCfaEwHwpDLdc1TBfo941vBlH5hF19MTTju//3AlL
 I8yxRuRdHbDAiOw/hNRRFkt5CYTqnPJ+pd5byxjMSiqDmHh8rh61VBx1wk5bSGHq8f/y6zObF9e
 saCytesQb0KllAQXEmsIbWpQtjP58wTEp2npI6ed7sWGUK6wFRUuNSmsrQZRyzLaR94nvqRPo7j
 Yf5LdEH0gZ4UIlQvwW7/6qduM8gZwE8zZ6A+uNdrzyn1Q6zhF9M/j/Sznp+YJn7nSIDPCmYcHfs
 IyGr1hUzS6p7WaaRBvfFqiWkU7wnfPj8pCeD7ybs/eTDj/xquTMfH1PVZcEZ9CZRr7OYdGawMxm
 N0A5BickcFzMETZR0zEZCQBilb1RZZiY1Ai19ov5Uy79IQJL/pOL+z4eUmIJWRdWDa/RqJd6igK
 r2ZfL7XFbvLAeLDJTCddH8jQVJqClWOhMjqegjT/M27Ko=
X-Received: by 2002:a05:622a:5c19:b0:537:af9c:1538 with SMTP id
 d75a77b69052e-542b82fa290mr253528921cf.69.1793762958622; Tue, 03 Nov 2026
 19:29:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <DMKY979I29AF.BS1DF5YAZMOY@kernel.org> <aujikV14tF6K1Xqw@intel.com>
 <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org> <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
 <auqaZdocMvOIxN1c@intel.com>
In-Reply-To: <auqaZdocMvOIxN1c@intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 4 Nov 2026 13:29:06 +1000
X-Gm-Features: AclHuK9drYAacddhbXIiBI0dBhlm-N2TmBWV6CewNw1USTlKHw4AiMKzH5-lPpk
Message-ID: <CAPM=9tzu6MYQ-Y0iYK=2PLiM5=1BsEN+Q5WnmYh=hkKnLJ4b1Q@mail.gmail.com>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alex Deucher <alexdeucher@gmail.com>, 
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

On Wed, 4 Nov 2026 at 12:37, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>
> On Wed, Nov 04, 2026 at 12:01:36AM +0100, Danilo Krummrich wrote:
> > On Tue Nov 3, 2026 at 11:48 PM CET, Rodrigo Vivi wrote:
> > > On Tue, Nov 03, 2026 at 04:19:11PM -0500, Alex Deucher wrote:
> > >> On Tue, Nov 3, 2026 at 4:11=E2=80=AFPM Danilo Krummrich <dakr@kernel=
.org> wrote:
> > >> >
> > >> > On Tue Nov 3, 2026 at 9:33 PM CET, Rodrigo Vivi wrote:
> > >> > > On Tue, Nov 03, 2026 at 08:32:48PM +0100, Danilo Krummrich wrote=
:
> > >> > >> IOW, linux-next merges tip/for-linux-next, and tip/for-linux-ne=
xt merges
> > >> > >> $tree/for-linux-next, rather than $tree/$tree-next.
> > >> > >
> > >> > > For this to work we need:
> > >> > > 1. xe to create for-linux-next for-linux-next-fixes
> > >> > > 2. amd to create for-linux-next for-linux-next-fixes
> > >> >
> > >> > Huh, I thought all the trees are doing this already. Well, that ex=
plains
> > >> > where the the problem comes from. :)
> > >> >
> > >> > In any case, drm-misc, drm-rust and drm-intel already have for-lin=
ux-next and
> > >> > for-linux-next-fixes, and the implementation is generic. So, addin=
g it to xe and
> > >> > amd is trivial.
> > >>
> > >> I've started doing this for amdgpu this cycle as well, but I still
> > >> pushed an amdgpu-next branch as well since that is the source of all
> > >> of the cherry-picks for -fixes and -next-fixes.
> > >
> > > But it only works if you stop this branch of updating after you sent =
your last
> > > -PR and from that point and on you merge or cherry-pick-from your -ne=
xt-fixes.
> > > Otherwise you are sending next.next material to -linux-next.
> > > And this is the current issue Mark is raising to us for a while.
> > >
> > > We have 2 proposals on the table:
> > > 1. (this RFC): a global unified drm-for-linux-next that is a chop-poi=
nt while
> > >    drm-tip is getting constructed.
> > >    If we go with this option you don't need to do anything, but stop =
maintaining
> > >    your for-linux-next.
> > > 2. (Danilo's proposal): Each driver/domain keep their for-intel-next =
and
> > >    for-intel-next-fixes for granular control of the blackout weeks
> > >    and dim merge them together into a drm-for-linux-next
> > >    If we go with this you need to at least ensure that your for-linux=
-next
> > >    doesn't contain next.next material during our blackout periods.
> >
> > dim already does that, fully automatically, it checks:
>
> right, but like xe, they don't have this for-linux-next setup with dim ta=
king
> care. So they do need to take some action.
>
> >
> >       git merge-base --is-ancestor $remote/$linux_next_fixes $remote/$l=
inux_fixes
> >
> > which means:
> >
> > - If -next-fixes is an ancestor of (or equal to) -fixes: feed for-linux=
-next
> >   from -next. This means -fixes has caught up with all of -next-fixes.
> >
> > - Otherwise: feed it from -next-fixes, which contains changes that have=
n=E2=80=99t
> >   reached -fixes.
> >
> > The only think maintainers need to do is push $tree-next-fixes to catch=
 up with
> > $tree-next, which they need to do anyways.
> >
> > IMO, this is more robust than relying on all maintainers freezing $tree=
-next at
> > exactly one global cutoff.
>
> This is the part that I disagree most. In my proposal, maintainers need t=
o do
> absolutely nothing. The freezing is already guaranteed by our rules.

Yes this is the thing I like, while I like maintainers having freedom,
relying on them to do something manually every release at the same
time doesn't seem to scale so well.

If we can't have the tool enforce what we send to -next after -rc6
then it's going to have gaps.

Dave.
