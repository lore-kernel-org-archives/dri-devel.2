Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C9606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t8bCHq6Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3B710E4B4;
	Tue,  3 Nov 2026 21:25:03 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA9A10E1AD
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 21:24:56 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-16a8e5d15f0so196c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:24:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793741096; cv=none;
 d=google.com; s=arc-20260327;
 b=g0ICyuwowJKdKwE7UF/WZRVR/bigUL9ecBdKHcwPDXw2lUcZQc9KYpJOZ7EiqI1o93
 5BT9IHHOvfkeqMN3GUEov2XtCbbBzLYqZNIbfE1GuDOw9SblLzhwT3WpcIbn5fILvM4/
 l0wnBWrtKDgvhMCEm9cHsCa7IFwR7FLn5fV701/M9yGUAcDXg8dg4D33a4Q+hVzq61/9
 wFH7Q3iAyunBpc+fvaVGhjYkKTBX6QnLLBoZCltY4xz0Bcwpt8+Xus6X1OJI+GL91mAW
 d1hZrJBsE0JfBhNefSzT1Hz0S6m4DODibiufuMEP4IzFq/U2nLj99obSXOACA1PlE2g9
 qNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=griRhT58RktvO7sgJyedxK3XqWlFRaj4fFKAMoaHwtI=;
 fh=ZfsIVCZ0xnU2y5FWThtx6P0eHQeCLgpGvqS8eX3FqGU=;
 b=k5MQYBYoGGUxzvlTzVF/fnVZ5VE6pHp87zWEgAAWMFFN2UHjwGEb2i4hZzbuUWLEAu
 uGL3ZP9iDa7vt5B5iX+FLmSfqb9hrF1HxGxebMXRCx91u6O0JTbvg2nvrHx6Tv2uXEco
 EBuKiLbF2j1XzZyI8G7HCvdGYh/8uuY9++8arA+zIB49Mt7P+mYNWubQwzi32gxvxNs2
 CCD2Pw0uE1ZjbednmSLvBFlcIEc4Mm6HSGIcoCiqWPtR84IsERw8JENvh3hLcKsZ8Duq
 Enbosa+05DkYrn92KzadEZ5zIfA1IvVPSPiR5unmMancMcZpW4s6S5WmxhEioKJQBhT+
 Pkdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793741096; x=1794345896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=griRhT58RktvO7sgJyedxK3XqWlFRaj4fFKAMoaHwtI=;
 b=t8bCHq6QD0zJsfM7s7fH1Hp7qr+4DTqoyTyCWbg2KU7iF5NNImG+qXTsLSCkVJzSJj
 E9GyXeT4KAO/fnPLm7t08kZjTkbUgyiLoNNMByMnNz093Hlt2NA+ESrDo93IkDKFd+cj
 8Y88jHVc6dGkz6dTj9Zim1oLWsIkjdk+lx78NVSlxONpqhT3LxOFQhL9NyU8ThQKLKob
 ZPjF7VVSBJsIM3FuBktqvR3uR2+axOXHZR8trsSxLo7MSZWiZQMB4lbMW3afPpDNRNke
 vb7atuZBWlGx+wxF5NUfPIECmPCNI9c/mi82vu8s2n2iNM1hVcf0NPh0DwKMvfN+HP4g
 CR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741096; x=1794345896;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=griRhT58RktvO7sgJyedxK3XqWlFRaj4fFKAMoaHwtI=;
 b=LzTihxsBEzB0OCG9quxWRPwCMGtMLOQyQcdxC6Dv99kogZ/6DWxn2Zj9POE4duv1ri
 cG4jzSOR3FGNhn5CEGpOqDoA6vsWs8idyRpuOBSYHVzvDHTuo59v7fTh6eyLRDnikYc4
 MYxRVmkRP07PujwSN6RU/WiTDa/EOL0450sMsYxkmJv1+/NEK/h7TgrYETyhLkWtbLlo
 ABTf6n8NxGPE3rONZMCOs7dV3vYPOn8NJlYC8ZNZxuxrVkpBwopfwElPE7iu8uyOPohK
 kVplAMaRQXlfdbr9LmLBW/IOA1tvX76GbE65ianlX2JwYqm3IvdGAOTvIzRk/AMGx0Rz
 /2lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt30GBqr6I1KdZf7ua+VgzGjAVuVnRlZHNHLxaAcoBoHZfYELgUjoPh6zz7s7Vanb0Bhff8ojRU8w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81OeTw7QOyadU5O3SQakCJU9h9P/+4RX4hm7stAKZ9u2wEeM12
 grgl1lHlTZfCshmjnzsjTAXBVaXYN9emM1uuFi026EjUda01wlixYUU95PfFh/EeZOpaSGglJ9k
 +AgOyvVQbqfX1hJB87qUKYqY/mQeIqWs=
X-Gm-Gg: AYBFou1ReS+5joEehA2oSEyWlKw/DIBB+g3m/Q7J5vWpzdjlH9UY/fNsNlHdjcRZSPZ
 /9f2R117A0Tkx1IH1FffWZCtuD4CbfBXM9cSw+HpFpZV3C1431qsmpSF/h/FsjRN00U6PbIPTuF
 FKRBiepqdtjZHV5kC0L6rZN/Rs05+ExAdCLtkUKhsmRw1Dho4Dn5FEZ3Z7MZ4UVJMhIOQuvmo/z
 8OpeJTyKW1uslP4pSKfQ+KMVeL0gVan4a0mTVp/Yt1aHvb2MyWcHM0P/zlq2JO/hhaZ8vsgq5R8
 4CHM5x4nXPo/wh06Zg56pGzJkLwerkHyGdewd+F6pcM4brXnytHsb/CbEIhi7oC2qV+k+nlwawL
 rCvBJxpwEoqDKRUCxuoFoxIj3u6SRcXnoVaAGOFxpBVJBaOdZ52FPyzGuotka4sng2y/y/iNtZL
 XtuQydlSMI8vYnkyDVTfS3b38=
X-Received: by 2002:a05:701b:418d:10b0:190:e602:c769 with SMTP id
 a92af1059eb24-1ac59143aeamr34394038c88.1.1793741095721; Tue, 03 Nov 2026
 13:24:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <aujZcJBUyQ7iX_PM@intel.com>
 <CADnq5_M5SjooHDGt3T=69mTqYW0rjwM25Y8r9dgi8gDJEWYt7A@mail.gmail.com>
 <aupFpMdhZD7vcP0b@intel.com>
In-Reply-To: <aupFpMdhZD7vcP0b@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 16:24:42 -0500
X-Gm-Features: AclHuK8C6NStvAz1dQJfq2azB7y9C2eQ418Bin_47lR5VnRJH3htDrx2QjporTI
Message-ID: <CADnq5_MNaSCYhkQ0LMLyObVHZidaEC_J2BD=GG0tKbsmvwC2+g@mail.gmail.com>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 3:35=E2=80=AFPM Rodrigo Vivi <rodrigo.vivi@intel.com=
> wrote:
>
> On Mon, Nov 02, 2026 at 06:07:15PM -0500, Alex Deucher wrote:
> > On Mon, Nov 2, 2026 at 1:51=E2=80=AFPM Rodrigo Vivi <rodrigo.vivi@intel=
.com> wrote:
> > >
> > > Hi folks,
> > >
> > > We'd like to replace most of the DRM trees in linux-next with a singl=
e
> > > branch:
> > >
> > >   https://gitlab.freedesktop.org/drm/tip.git#drm-for-linux-next
> > >
> > > It replaces these entries:
> > >
> > >   drm/drm-next, drm/drm-fixes
> > >   drm-misc/for-linux-next, drm-misc/for-linux-next-fixes
> > >   drm-intel/for-linux-next, drm-intel/for-linux-next-fixes
> > >   drm-xe/drm-xe-next
> > >   drm-rust/for-linux-next, drm-rust/for-linux-next-fixes
> > >   amdgpu (agd5f/linux.git#drm-next)
> > >
> > > drm-exynos, drm-msm, drm-msm-fixes, drm-msm-lumag, drm-nova and etnav=
iv
> > > are not part of it and stay as they are.
> > >
> > > The main reason is to reduce the conflict pain that Mark constantly f=
aces.
> > > All of them should be handled already when we are rebuilding drm-tip.
> > >
> > > During this work, I realized that drm-xe is a big culprit for leaking
> > > future work without a blackout date from -rc6 to <next>-rc1.
> > > So, another quick solution would be to get a drm-xe for-linux-next li=
ke
> > > the other domains are doing. However, I still believe that this unifi=
ed
> > > one will make Mark's life much easier anyway.
> > >
> > > The unified branch is rebuilt by dim together with drm-tip. It has al=
l the DRM
> > > -fixes, drm-next, -next-fixes and driver -next branches merged, with
> > > the conflicts between them already resolved on our side. From -rc6
> > > until -rc1 (per Linus' tree) the driver -next branches are left out, =
so
> > > nothing for the following merge window lands early.
> > >
> > > It contains the DRM fixes too, so it would go where "drm" is today.
> > >
> > > During the past weeks I have confirmed that the drm blackout period
> > > works well on this new branch.
> > >
> > > The dim changes:
> > >
> > >   d875049d2b29 dim: build a unified drm-for-linux-next branch
> > >   3009867cd318 dim: keep -next branches out of drm-for-linux-next dur=
ing the freeze
> > >   https://gitlab.freedesktop.org/drm/maintainer-tools/-/commits/maste=
r
> > >
> > > AMD:
> > > Alex, Christian: linux-next takes amdgpu from
> > > agd5f/linux.git#drm-next today, which differs from drm-amdgpu-next in
> > > drm-tip. Is drm-amdgpu-next fine for linux-next?
> >
> > They should be the same.  I just mirror drm-amdgpu-next to
> > agd5f/linux.git#drm-next in case anyone is still looking there.
>
> That's fine. But please let us know your thoughts on either going with
> this approach proposed here or with the other approach proposed by
> Danilo, where we in xe and you would need to create a for-linux-next
> and for-linux-next-fixes.
>
> Both xe and amd are leaking next.next patches into linux-next right now.
> And we definitely need to stop that.

I'm not quite sure I understand what you are proposing.  Is the idea
that there would effectively be one drm-next composed from all of the
constituent drm-next or drm-next-fixes trees (depending whether we are
in or out of the blackout period) and that is what higher level -next
trees would integrate?  Isn't that what -next-fixes is supposed to be?
 Maybe we just need better documentation for the upstream -next
maintainers?  Maybe the actual vendor -next branches should just be
renamed to something like vendor-dev and then during the blackout
period vendor-next points to vendor-next-fixes and then after that
vendor-next points to vendor-dev.

Alex

>
> Thanks,
> Rodrigo.
>
> >
> > Alex
> >
> > >
> > > All other maintainers, please ack if you are okay with this approach.
> > >
> > > Mark, you're in Cc for visibility only. Once we have all the acks, I'=
ll
> > > send you the formal request. After linux-next switches, we stop
> > > updating the old for-linux-next* branches (patch below).
> > >
> > > Thanks,
> > > Rodrigo.
> > >
> > > ---
> > > dim: stop updating the per-repo for-linux-next branches
> > >
> > > linux-next now pulls the unified drm-for-linux-next branch instead.
> > >
> > > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > ---
> > >  dim | 53 -----------------------------------------------------
> > >  1 file changed, 53 deletions(-)
> > >
> > > diff --git a/dim b/dim
> > > index e3f616b..b3ed8f7 100755
> > > --- a/dim
> > > +++ b/dim
> > > @@ -658,52 +658,6 @@ function dim_range_diff
> > >         fi
> > >  }
> > >
> > > -# update for-linux-next* branches
> > > -function update_linux_next # branch next next-fixes fixes [for-linux=
-next] [for-linux-next-fixes]
> > > -{
> > > -       local branch linux_next linux_next_fixes linux_fixes for_linu=
x_next for_linux_next_fixes repo remote
> > > -
> > > -       cd $DIM_PREFIX/drm-tip
> > > -       branch=3D$1
> > > -       linux_next=3D$2
> > > -       linux_next_fixes=3D$3
> > > -       linux_fixes=3D$4
> > > -       for_linux_next=3D${5:-for-linux-next}
> > > -       for_linux_next_fixes=3D${6:-for-linux-next-fixes}
> > > -
> > > -       repo=3D$(branch_to_repo $branch)
> > > -
> > > -       if [[ $repo !=3D $(branch_to_repo $linux_next) ]] ; then
> > > -               return
> > > -       fi
> > > -
> > > -       remote=3D$(repo_to_remote $repo)
> > > -
> > > -       git_fetch_helper $remote
> > > -
> > > -       if [ -n "$for_linux_next_fixes" ] ; then
> > > -               echo -n "Pushing $linux_fixes to $for_linux_next_fixe=
s... "
> > > -               git_push $remote +$remote/$linux_fixes:$for_linux_nex=
t_fixes
> > > -               echo "$DONE_OR_SKIP"
> > > -       fi
> > > -
> > > -       if git merge-base --is-ancestor $remote/$linux_next_fixes $re=
mote/$linux_fixes ; then
> > > -               # -fixes has caught up to dinf, i.e. we're out of the=
 merge
> > > -               # window. Push the next queue.
> > > -               echo -n "Out of merge window. Pushing $linux_next to =
$for_linux_next... "
> > > -               git_push $remote +$remote/$linux_next:$for_linux_next
> > > -               echo "$DONE_OR_SKIP"
> > > -       else
> > > -               # dinf is ahead of -fixes, i.e. drm-next has already =
closed for
> > > -               # the next merge window and we've started to gather n=
ew fixes
> > > -               # for the current -next cycle. Push dinf
> > > -
> > > -               echo -n "Pushing $linux_next_fixes to $for_linux_next=
... "
> > > -               git_push $remote +$remote/$linux_next_fixes:$for_linu=
x_next
> > > -               echo "$DONE_OR_SKIP"
> > > -       fi
> > > -}
> > > -
> > >  function check_conflicts # tree
> > >  {
> > >         if git diff | grep -q '\(<<<<<<<\|=3D=3D=3D=3D=3D=3D=3D\|>>>>=
>>>\||||||||\)' ; then
> > > @@ -1192,13 +1146,6 @@ function dim_push_branch
> > >
> > >         git_push $remote $branch "$@"
> > >
> > > -       update_linux_next $branch drm-intel-next drm-intel-next-fixes=
 drm-intel-fixes
> > > -       update_linux_next $branch drm-intel-gt-next drm-intel-next-fi=
xes drm-intel-fixes \
> > > -               for-linux-next-gt "" # no for-linux-next-gt-fixes for=
 now
> > > -       update_linux_next $branch drm-misc-next drm-misc-next-fixes d=
rm-misc-fixes
> > > -       update_linux_next $branch drm-rust-next drm-rust-next-fixes d=
rm-rust-fixes
> > > -       update_linux_next $branch drm-amd-next drm-amd-next-fixes drm=
-amd-fixes
> > > -
> > >         dim_rebuild_tip
> > >  }
> > >
