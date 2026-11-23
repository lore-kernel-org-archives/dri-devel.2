Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEAF606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALjCqxzW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE79110E6D9;
	Mon, 23 Nov 2026 15:37:05 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFB010EF18
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:36:49 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-8212fce7258so401686a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:36:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448208; cv=none;
 d=google.com; s=arc-20260327;
 b=C0BaiBBOOFTXJG7sy+x/9yK54+iAWyOP0xtvPhM2tvIjjuvke1IZCU7L8r2Uzn1+S1
 WBKOqHerm6WEaxsV3ZvHGqLSpxwK5Dh1t6BI6Mxe32JDolR1IcNVV0hzEHfxQivATCOL
 XV4F0J91484xfSIa2HMpS/nIFd6mawfKu2ikJw1G/lePHjBb7u8qEwOymp+RH/+lSVKw
 gR69qARWwZbDIdpD58nJS64tvsvw8t6MJVjei4QLcWJzbbfRCqmOUBNC8UHlXkH/lRZX
 DIUYKUVVHVtI/GkSq41sK/ityKvX3PLZTA1U1rWCxS8IwAzRvvoPnaNoVGazLLxctrK6
 UuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O+ZsCUKlDNFkykdhaFUY00lREXOJ7VO+hfzdF9elZiI=;
 fh=oGHswW/8rbvh/TOBeWxqTx3TCAWJtYgUl4gW84Ifnbc=;
 b=pbbL6LigUD3N06evmgxYKuoK+JQCnCl2wmPcfjGidJDgwHuxU5lS5I+a4BFctZ7gDa
 bOSzAMHB7q4ej3pBuQElDbT2PbQ0Bcky5sCyjQ2Ov5LiJcEtNrgmp3cid+d1pZwBJYzr
 Y5W2IJHujMJNo+at1COKAiw8uC7W14ZhjGDernBtnEHzn84lYem+ciXb1iRE+y1iT+E3
 Bhc9o5zBq8MuNI6yi3Oj6u5JA7ZrYRiTj5TMh4GV7k96WPnZPqDtFT5t135Dl27hJwsm
 PpExk3X8FFPAomBI20p1EC1HPhr9u6/nQLfPFauXuackBs5Yzplxl4OCRGDsxU9C8Jci
 MBYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795448208; x=1796053008; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O+ZsCUKlDNFkykdhaFUY00lREXOJ7VO+hfzdF9elZiI=;
 b=ALjCqxzW6NBAbCpZT0hCAc+NO4ou7ceF0TxCi/WAfUbszdzP8tgJ+OosC9SHgHtfPg
 SD8d5VLH+ZekOhHJu6Aen/BFnVBDNK+yIbp5bZEb4zk/JsWHyhfuJCNz/8nAXD7f0KSA
 +GgtYzKWQAXPweAHxV3VxdakQh99dzgNr96bOwA+YdM+wkWe01KlUnSZBqYmbVgdnBh6
 5a2ynDZUjfGcc/MG1FOe0GGcasJ9Y2DVswoo6kNgipd4S8BpjyDiFqlukzTNR/zePHEa
 Fy8Tml4lg4uebFh0mDVHFSce87Ad0CHmKJsgE0nOUks4uQBsSogj+3Li0nZ+J0BjnrVx
 lr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448208; x=1796053008;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O+ZsCUKlDNFkykdhaFUY00lREXOJ7VO+hfzdF9elZiI=;
 b=rfleGA/c2gCSVftdyQ2yGScEz/col3fEcqywLxAC4Ve2JYAJKqfcwP+nj0h9bvVh8L
 QhG4MCzv3yQes4ubrunaOlxniE4xwO432fCVg0N/5rwr+duReqQ9IZsvbpI4lOWAK2jP
 l26jbLDC8rXBfvQAZPHdCHk01O/qecSu2lzIlSk2JsfKg1wQEgweun9a1wtXiLqn7WBu
 vR3A7y6IhIGjmb2VUH3kJlwvt7GBHszYOCETg2+N5UhtK+VMMmVtILd8HbY8bqSYDsvB
 4/VM/9CDjviAa+3CPueMv3JHt9Pptr8LV/pqQhKMiNTX3F/PHWST9p2ArA1fbRacJbUA
 k9PQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH4q5jknwLf9PSguBl3TKlCMOak83y0LjTQSVJKshqt/h0levpS1uONAH89JHpcl7Aj36inX3Q5jwQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9FpnjOaiT/HTedTBr0FVZgCpiWpxWnVW/kwc+dY9gsdJCWOjK+
 EkeA9CKZh1r1BJDYKVZ64DVzW2INPjLHe3jDy2x4UjYLFGjUSXi7kwkAsnLapCum3XteI9GoR9U
 Nm8hkzRtGkcZu5wWpfox+7Abm4d04+go=
X-Gm-Gg: AZFdTZc6PKjP3zSPURh/I2iDCJH+Th5PKeUsoMn0QGyQu3CIE94gvVrDH0R2bNfhxOg
 M3sK7zhXYz3dorQiylIEr0UqZiankvDBXUrcw3vovx3t7oIgFs/0psQOY9WQEjj7wrxpjahgOjB
 8uyqpyNfI0EkYR9DEGSIS6WHmVgUNKjyJXQDrkwVLyMe74qqo7/NBZwkDt9ZYNFDg0lBEZIErB6
 zqFkk0pz/dnqAmgstaFUCQ+B+WWltN6ycZupGXggo/3e3D2vCfSeG1RvyQ0i5t4HGqb9cNfvrRN
 EfKFm0d3V1FYENdg5rxHz5fLUUUHDrPLShV7btl1crsLWTuozht+xy6eei8MuE3+3xJhrKXxywK
 mxgMLFQOIfLRFwssRpkJNV90sa/cVEYeCtCu5xwl27z1ca7G/gYhUzXHAHgzS4vD1fnLNRKorxx
 lckBt4rn15Fz6hZ8/QRkmUokV06HYuCXqUORgpjisNFn4mo45ODOMRC4HdX8E=
X-Received: by 2002:a05:6808:1383:b0:549:e9e3:9460 with SMTP id
 5614622812f47-57a025ed532mr17234457b6e.0.1795448208292; Mon, 23 Nov 2026
 07:36:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122045319.18651-1-irogers@google.com>
 <c7a81b11-73de-49dd-b38d-76aabf193dc5@amd.com>
In-Reply-To: <c7a81b11-73de-49dd-b38d-76aabf193dc5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Nov 2026 10:36:36 -0500
X-Gm-Features: Aa3M54rvn7dkOhohcibCJnEbcJ8Ls1D79SvQUldxYdV48pGWUDZbdwQoEIZo65U
Message-ID: <CADnq5_P23gnpD8eXOF-hOE3bjHcffEOQdwvfjY9xMsF_Awbx9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/amdgpu: Initialize r in VM and TTM buffer
 helpers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Ian Rogers <irogers@google.com>, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

On Mon, Nov 23, 2026 at 6:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for both pat=
ches.
>
> Alex will probably pick the patches up, if not please ping me again.
>
> Regards,
> Christian.
>
> On 11/22/26 05:53, Ian Rogers wrote:
> > Two fixes in drm/amdgpu for uninitialized return-value regressions
> > found via Clang -Wconditional-uninitialized on an x86_64
> > allyesconfig build:
> >
> > 1. Set r =3D 0 in the 'else if (!bo)' branch of amdgpu_vm_bo_update().
> > 2. Set r =3D 0 right after the while loop before 'error:' in
> >    amdgpu_ttm_clear_buffer().
> >
> > Build-tested with LLVM=3D1 W=3D1 (-Werror) and -Wconditional-uninitiali=
zed;
> > not runtime-tested on AMDGPU hardware.
> >
> > v2:
> >   - Keep 'int r;' uninitialized at declaration in both functions so
> >     future missing-assignment paths are not masked; instead set 'r =3D =
0;'
> >     inside 'else if (!bo)' in patch 1/2 and directly before 'error:' in
> >     patch 2/2 (Christian K=C3=B6nig).
> >
> > v1: https://lore.kernel.org/r/cover.1795106955.git.irogers@google.com
> >
> > Ian Rogers (2):
> >   drm/amdgpu: initialize r in amdgpu_vm_bo_update()
> >   drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
> >  2 files changed, 3 insertions(+)
> >
>
