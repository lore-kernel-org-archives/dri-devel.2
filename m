Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB1606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pyPsBRhA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A497610E717;
	Mon,  2 Nov 2026 23:07:34 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1165510E71E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 23:07:28 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1af971cd9f9so159262c88.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 15:07:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793660847; cv=none;
 d=google.com; s=arc-20260327;
 b=UOLkvX0d6iR1XCn0Dd5s+YU/P0mNN2Tj8Bky9zfaNuaOw0Q89Mru7P/+lfjkwiohRs
 RW0HrPIc5VoRNxiuAIxY4q3Y+PZydgsxUcklfGE2NLabh8P7lRtPam3oyv1aM/ZFB9jm
 vs6jalpiaBoeP+MVwvMFC54Rt6JJwiSfVJSLXdIPhAgcSNWsSksP04t1dfhk7p7IH6Rv
 dwJM+mkraLF6NmbTGZ9RP2qCoWVThAUqgQ9V3I6EaFI/GLjmKorAcD3NdeTg8jjGVbc2
 Z3ontLhZlBr5yyyruuqqaN8hhEZibesjGi8jMvhs+Uyjbs0x75Kgd/sAt0/XvL19kJC2
 OU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LtJ5JL6qAopgs2lhUvZDWm4BbQkkZyUq93j8S5yMDyg=;
 fh=5Ctck7kaRZ8RMuSKmpKWuZEGACJDtrpObQsq33+mdAA=;
 b=ez/OMvYw5OHHeb8DURDwJiVuMGI0Vq81lIm4K4gb4PQRLM8jfVSjrV+etLLotS01f4
 RYgcWBC0Q+IEL4Mr67oKDU5Gy+0/87/j+ZE5vfMPRSk/U+0e2xH08nGktuzu6ATO1FCT
 7c/dbdSqMD0NtdfYWO33gtiI9JBgkJSB78oqikXK+vbX0JzlKsVwyt87S97b0PBaehLz
 R4ULV0mFui0O3BFjv14dI5SScs02zB5VM9WYIoB9z5iAEl9Ux88vsAoWFgoWdWJYeYgj
 7xKMrSolU8/rYfxgtLB0t1Jlt32OWDu6ZTtba11FDby98DUkhhUCLnM/20pPdroCeoT+
 SWpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793660847; x=1794265647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LtJ5JL6qAopgs2lhUvZDWm4BbQkkZyUq93j8S5yMDyg=;
 b=pyPsBRhAR5xgv4T0fcfIoCjn3uX2HrQ7RijB/pifan+0uU3j2SIcrt435He3PPecac
 qRyuTKjjIB3xUglogTwHEpdulFp0aB4m7VhZKYWJCOpS8I7luALNzctKmQWbpjVPcARv
 +K1ABkkIwISEn0hYVVOB4/xNNowBHfUE+vDFgF/pemHt+RJJM7hpYW9JC1BMuCjlI0u2
 4UTU1a+RddqROpheRIKZjcOe8laFaUaYKAvbGxcFiLtaLncCzYkNLpISSaAuZlp1e5VM
 S9iI5e0fTnWbAB/UJYIb0qSc0wgQBMqGlFH0bHmh/8ilEqUkJs0vohZdjQpJJe8SwVG8
 nrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793660847; x=1794265647;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LtJ5JL6qAopgs2lhUvZDWm4BbQkkZyUq93j8S5yMDyg=;
 b=pbnV1M/p2lLB5dF+stLB3hKI2jtSkqXo7YTCD7RhsxX5AMs2jfA2H7W9ComKdiJl/X
 VkH0OqNoi7ci4nNdOuoEijmvPbiw90XtJ8R0NZ6TtQ3qM361/PSZB2lteE1G/pj1wE36
 JGiDYvg1lZigy3yU3uy7jVmmHWtPnrXTlXq+7HQs+OPqvi+G+DkY85b6/K38UD1SrOL4
 uMNCdOf75y8PQlvgG63jAapmgiK6klpwbJoSN6Tryq6+Kp6ddczce5+r/Z2szizx2sOa
 3gdEjLa8mlVRgL5zRWb1o98w9P10qef+xhgvwgTN0EX7QoOvfZKks022K4cVohuTmc3P
 VB5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuNf9+5PibsWjTOUH3+Vf3khpeMRhtPShpj0FJq5BYwTW5hecky9UAJLHywz38ZHs2BLOxxBJMFbU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLal5cb3gWH9K/ufFjCKjMNUfdCM7Nl4e0a0X0gkYBIInECTfoP
 qPwTHk065ndcyIEUwdKtRLbzbJDg9inM4M56eQS+bvTjYK/ZnOAhUPz9s8mtbqNvBdEQdXSxn1A
 e8ZFM2IRQbZmPTq7pW73HVROhOjsmKBM=
X-Gm-Gg: AYBFou1a2P8nRGQBC2H12J5PaGGE57AeFhXWOWeNP1PdxDlli3jc5m8kQsap17LSMW+
 1ZMPVhLE3PdKsm8Fyhd0lKHnwL5HzifLnAwXLbzAlp36+A+7vkiGcYCVg11S/JELtI6mtcflCUy
 EnXsBjA3bG62YF2HV6MQ4JktYqEv8u44QIxtKbaQKmZe1tqhDoIV4jRlDTHjeV1PDJuapohGEwp
 WNgAkwjPwRynJu+8PH9uGYVzo8LDnLNEFoQXgpvSmsy7pHx/H2L3RRvJz0wmvuQq7rjDWcwPcCU
 USMMPIXeNK8+d881But/5THeaXN2fHuUeBzK1JleeIdYvROQqQ293hJQTnfVtRdAE1a17bU9V/Y
 vKeTAb8ksxSqoZ4wUVV5KhlsDYR0gG8kR+b0PYhwMFcP9aqa6qIxTinrR0Yj3Dx4A655GL3iLAo
 7nTfxDK9Pfj/8ylZ+Cobvl6bs=
X-Received: by 2002:a05:7022:c90:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1ac5914348dmr23169730c88.2.1793660847033; Mon, 02 Nov 2026
 15:07:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <aujZcJBUyQ7iX_PM@intel.com>
In-Reply-To: <aujZcJBUyQ7iX_PM@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 18:07:15 -0500
X-Gm-Features: AclHuK-yoykhBZZPuI4MkDU3EtbBAN1xWrPAe0gQ6PXSlR0CMnJh9ZxVOdSAIg4
Message-ID: <CADnq5_M5SjooHDGt3T=69mTqYW0rjwM25Y8r9dgi8gDJEWYt7A@mail.gmail.com>
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 1:51=E2=80=AFPM Rodrigo Vivi <rodrigo.vivi@intel.com=
> wrote:
>
> Hi folks,
>
> We'd like to replace most of the DRM trees in linux-next with a single
> branch:
>
>   https://gitlab.freedesktop.org/drm/tip.git#drm-for-linux-next
>
> It replaces these entries:
>
>   drm/drm-next, drm/drm-fixes
>   drm-misc/for-linux-next, drm-misc/for-linux-next-fixes
>   drm-intel/for-linux-next, drm-intel/for-linux-next-fixes
>   drm-xe/drm-xe-next
>   drm-rust/for-linux-next, drm-rust/for-linux-next-fixes
>   amdgpu (agd5f/linux.git#drm-next)
>
> drm-exynos, drm-msm, drm-msm-fixes, drm-msm-lumag, drm-nova and etnaviv
> are not part of it and stay as they are.
>
> The main reason is to reduce the conflict pain that Mark constantly faces=
.
> All of them should be handled already when we are rebuilding drm-tip.
>
> During this work, I realized that drm-xe is a big culprit for leaking
> future work without a blackout date from -rc6 to <next>-rc1.
> So, another quick solution would be to get a drm-xe for-linux-next like
> the other domains are doing. However, I still believe that this unified
> one will make Mark's life much easier anyway.
>
> The unified branch is rebuilt by dim together with drm-tip. It has all th=
e DRM
> -fixes, drm-next, -next-fixes and driver -next branches merged, with
> the conflicts between them already resolved on our side. From -rc6
> until -rc1 (per Linus' tree) the driver -next branches are left out, so
> nothing for the following merge window lands early.
>
> It contains the DRM fixes too, so it would go where "drm" is today.
>
> During the past weeks I have confirmed that the drm blackout period
> works well on this new branch.
>
> The dim changes:
>
>   d875049d2b29 dim: build a unified drm-for-linux-next branch
>   3009867cd318 dim: keep -next branches out of drm-for-linux-next during =
the freeze
>   https://gitlab.freedesktop.org/drm/maintainer-tools/-/commits/master
>
> AMD:
> Alex, Christian: linux-next takes amdgpu from
> agd5f/linux.git#drm-next today, which differs from drm-amdgpu-next in
> drm-tip. Is drm-amdgpu-next fine for linux-next?

They should be the same.  I just mirror drm-amdgpu-next to
agd5f/linux.git#drm-next in case anyone is still looking there.

Alex

>
> All other maintainers, please ack if you are okay with this approach.
>
> Mark, you're in Cc for visibility only. Once we have all the acks, I'll
> send you the formal request. After linux-next switches, we stop
> updating the old for-linux-next* branches (patch below).
>
> Thanks,
> Rodrigo.
>
> ---
> dim: stop updating the per-repo for-linux-next branches
>
> linux-next now pulls the unified drm-for-linux-next branch instead.
>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>  dim | 53 -----------------------------------------------------
>  1 file changed, 53 deletions(-)
>
> diff --git a/dim b/dim
> index e3f616b..b3ed8f7 100755
> --- a/dim
> +++ b/dim
> @@ -658,52 +658,6 @@ function dim_range_diff
>         fi
>  }
>
> -# update for-linux-next* branches
> -function update_linux_next # branch next next-fixes fixes [for-linux-nex=
t] [for-linux-next-fixes]
> -{
> -       local branch linux_next linux_next_fixes linux_fixes for_linux_ne=
xt for_linux_next_fixes repo remote
> -
> -       cd $DIM_PREFIX/drm-tip
> -       branch=3D$1
> -       linux_next=3D$2
> -       linux_next_fixes=3D$3
> -       linux_fixes=3D$4
> -       for_linux_next=3D${5:-for-linux-next}
> -       for_linux_next_fixes=3D${6:-for-linux-next-fixes}
> -
> -       repo=3D$(branch_to_repo $branch)
> -
> -       if [[ $repo !=3D $(branch_to_repo $linux_next) ]] ; then
> -               return
> -       fi
> -
> -       remote=3D$(repo_to_remote $repo)
> -
> -       git_fetch_helper $remote
> -
> -       if [ -n "$for_linux_next_fixes" ] ; then
> -               echo -n "Pushing $linux_fixes to $for_linux_next_fixes...=
 "
> -               git_push $remote +$remote/$linux_fixes:$for_linux_next_fi=
xes
> -               echo "$DONE_OR_SKIP"
> -       fi
> -
> -       if git merge-base --is-ancestor $remote/$linux_next_fixes $remote=
/$linux_fixes ; then
> -               # -fixes has caught up to dinf, i.e. we're out of the mer=
ge
> -               # window. Push the next queue.
> -               echo -n "Out of merge window. Pushing $linux_next to $for=
_linux_next... "
> -               git_push $remote +$remote/$linux_next:$for_linux_next
> -               echo "$DONE_OR_SKIP"
> -       else
> -               # dinf is ahead of -fixes, i.e. drm-next has already clos=
ed for
> -               # the next merge window and we've started to gather new f=
ixes
> -               # for the current -next cycle. Push dinf
> -
> -               echo -n "Pushing $linux_next_fixes to $for_linux_next... =
"
> -               git_push $remote +$remote/$linux_next_fixes:$for_linux_ne=
xt
> -               echo "$DONE_OR_SKIP"
> -       fi
> -}
> -
>  function check_conflicts # tree
>  {
>         if git diff | grep -q '\(<<<<<<<\|=3D=3D=3D=3D=3D=3D=3D\|>>>>>>>\=
||||||||\)' ; then
> @@ -1192,13 +1146,6 @@ function dim_push_branch
>
>         git_push $remote $branch "$@"
>
> -       update_linux_next $branch drm-intel-next drm-intel-next-fixes drm=
-intel-fixes
> -       update_linux_next $branch drm-intel-gt-next drm-intel-next-fixes =
drm-intel-fixes \
> -               for-linux-next-gt "" # no for-linux-next-gt-fixes for now
> -       update_linux_next $branch drm-misc-next drm-misc-next-fixes drm-m=
isc-fixes
> -       update_linux_next $branch drm-rust-next drm-rust-next-fixes drm-r=
ust-fixes
> -       update_linux_next $branch drm-amd-next drm-amd-next-fixes drm-amd=
-fixes
> -
>         dim_rebuild_tip
>  }
>
