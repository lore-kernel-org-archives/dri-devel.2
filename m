Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D19CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7671A10E447;
	Mon, 12 Oct 2026 11:39:18 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E6710E447
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:39:12 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-8ac9d666d4eso11133357b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 04:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791805151; cv=none;
 d=google.com; s=arc-20260327;
 b=fE/wVtN7iMPSGiMudLCh0uGCIryCukEGdQArCbLX2CHcswaKwWmrxaDtliV48oan3W
 DsmgdijRCUwkbPWSewwv69DmZuYoVY5I3C4IWq9d+pMuvmx+Aga7wUMB2vGHlxpnp2yk
 K5OHDvC3D4t9cwBKydGx/q2rAvpald8mfd13mgLwTXPLW59+hV/LD8fq0UWYhl1cVE/k
 awjlZ+wyqw7LxD2fNZMhVOjtoNPCBibCBUoBtNFmBH5WHBWr9SzOauvXV7vJovMqliPX
 62amuuCWT7qTK42c6gapqZqgafR7gNf46AGZjD5od5kKVD/u/36Noj4uQ0QvIAy4Yx9R
 0H2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ni29dh9h/iY48KqO27Kf84qCvqIwpSgqllYQhFBWKYg=;
 fh=vZGA541/Da9R8ky4DoFlF8rJQ1/aoJyaQkS65CynXWk=;
 b=M/ia+ZTfHYvF+oqKvB24iboHwcXXz3fusSrPrBuytbiYEeTx76fQMzawhYalmFXlU2
 oX/xBo92PpMyDVhgK3F/Pjg/os0eT48+gQYUzBEcD+e5cwIY52na3brLdXrERUdagmd8
 zE1n8jrbsiv1rXFlnbXi37Xlyb2ei1PccKA9xT5Dw8lnVCAAm2d1mD9P3b6/T7otsXJ7
 fM9/V3Rjfu9v7DtT+zmMcWk7U8Mpf+C9Gi8dSNV8pl0gLNgU5RL77tZy7+miLZrkhzSI
 WPfR0cBk6QzG6bFj5twR3pyCYkxU7VO4nSysHzy0I8C04tchCfEhz8bDmCzh4ZdAGUke
 3U3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791805151; x=1792409951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ni29dh9h/iY48KqO27Kf84qCvqIwpSgqllYQhFBWKYg=;
 b=N2DnIMUr0k+zBckLCek7LUyYQYD8J+VMYzlYhCDREYdtAzq2AE8eyt7RpyWinzDmUv
 gLhKZjoV3JgT2yqg9hhSIyvY6Kr6bgHTbK6wvEfOqlMq2wtZm1ohVA0EKqqEKCEtePuQ
 JmEowPlbYFcN9QNJD7cbFFYdC00oi9Szmii5FWyCk0Lg0/nq0LX0AeZ1sQqGd0v0UDXx
 tR8gr2FqBGlPfzeKALSLm30M+reNowuqYIc22sUUGMYzOL1p4sOFRtukdx7BwpBQxaHL
 tDyPXcHg38a+kodH9NT0LTAeS4ITvZvd4+bkSPcBI5ad5lI7JHe+QX60zB9FNIBy+CzZ
 Poeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791805151; x=1792409951;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ni29dh9h/iY48KqO27Kf84qCvqIwpSgqllYQhFBWKYg=;
 b=H0hoO3s1X4MUL4j+frB+hEOVQZZgk+DSsrbiZvFDOAIXEvfPX3rwTK/98mrWRN1WLx
 nUj6Ik1+bfxSfiEFl8GD+WZVJVMTRBJNFwbN7rbVobtW1gEHLibpIDVlV3YeYF2gkG6p
 2j96thTXIsyWEsj8ME9zXDeyWTpKjftudTFDPR6aEu48HQ+vbNDeHJe/vJzJXjNf85kz
 S9sa2SFwYeC4Xw17kuCZRYQFDD0lvvqxS92trXcl3GmQofM2TvALhQTPDwAaEbStAI9g
 LlYL4SmvYi8RwpaB+4cSrf3z3iiOQp+x1uFeePeGgOeWZmUpFtgIW245FdG4u1414czc
 ei4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdvk9s+6QG/NmGejgRwTa1OR0A9cTaD+3aDO8GjuEgyH3zG2MTRff7EGfAzqL8jOBakc29C5RY8y8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJpOijlN2Ygled5GUaTFXAieCFn5sA5xrEc7kBlZuBnNb9TNol
 HVO8y+w6XTyJBGF8BAwLUjzACcKFDv7LpYN7j+U/dvCGL//wNxxAjK9I5ljWoWI6Hctg7bR5ZMl
 wOcoKaw1cIPkV/74ymQWMOVyYMxDlyLw=
X-Gm-Gg: AYBFou1Zscgyulo+1p7vgm79K7hlwp9gaS8sdYtmRx2O/lOuLbzE+gvZcexw9jd8d3T
 geIXNnB9/sm+gan7sbgCbWAmyQWBykb+ImDxm0IY3N1040ErPr+RkhbZBEklMudepXXWnAY6c7J
 4mAyk5zIMXrANKlVKXepTRcHiBPFDJInpEruHz/RlJ4UlIwgU9kmiJUucA+pyMF8xhrnRP9FZaQ
 Ib0jmB4S9XPilOMn7358bU8WHnHlt2E+bJfn0tHb1zcMDeFXVDeuaZejWajXuWJ09swx14OMmdS
 D1+MkShOIAWXNbiUi0J5DeHl1Eo+1pIYOp+0pMgDSDqNimrAo9Sz0MD1/KfTlbJnP43Sf5zm9yO
 aQ6VBB6q/8UgR3qpm1p4u
X-Received: by 2002:a05:690c:f08:b0:8a8:e0c7:dc3f with SMTP id
 00721157ae682-8b07edb5995mr31001627b3.18.1791805151356; Mon, 12 Oct 2026
 04:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20261010180711.1548333-1-ju.orth@gmail.com>
 <20261010180711.1548333-2-ju.orth@gmail.com>
 <49d4f34d-6d27-4a70-88ad-a5e939eef084@amd.com>
In-Reply-To: <49d4f34d-6d27-4a70-88ad-a5e939eef084@amd.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Mon, 12 Oct 2026 13:38:59 +0200
X-Gm-Features: AclHuK_TvDl5T3sJwAa-8Y_DCBwlQE-ZZAXe0QSdCleHISQ5S_vtpBNdiV3KYsA
Message-ID: <CAHijbEWpH+0M=mU3GiQWNL8b+6uTd=dK59UM=ejtviHmiRFq2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/syncobj: fix fence and syncobj leak in
 drm_syncobj_import_sync_file_fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 12, 2026 at 9:45=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 10/10/26 20:07, Julian Orth wrote:
> > If dma_fence_chain_alloc() fails, the function returns -ENOMEM without
> > dropping the references to the imported fence and the syncobj.
> >
> > Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline=
 syncobjs")
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Julian Orth <ju.orth@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_syncobj.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncob=
j.c
> > index c23a5de27..5ca5163d0 100644
> > --- a/drivers/gpu/drm/drm_syncobj.c
> > +++ b/drivers/gpu/drm/drm_syncobj.c
> > @@ -730,6 +730,7 @@ static int drm_syncobj_import_sync_file_fence(struc=
t drm_file *file_private,
> >  {
> >       struct dma_fence *fence =3D sync_file_get_fence(fd);
> >       struct drm_syncobj *syncobj;
> > +     int ret =3D 0;
>
> Please don't initialize return values on declaration that is often consid=
ered bad coding style.
>
> >
> >       if (!fence)
> >               return -EINVAL;
> > @@ -743,17 +744,20 @@ static int drm_syncobj_import_sync_file_fence(str=
uct drm_file *file_private,
> >       if (point) {
>
> >               struct dma_fence_chain *chain =3D dma_fence_chain_alloc()=
;
> >
> > -             if (!chain)
> > -                     return -ENOMEM;
> > +             if (!chain) {
> > +                     ret =3D -ENOMEM;
> > +                     goto out;
> > +             }
> >
> >               drm_syncobj_add_point(syncobj, chain, fence, point);
>
> Allocation and adding the point is intentionally separated so that dma_fe=
nce_chain_alloc() can be called before looking up the syncobj or previous f=
ence.
>
> I suggest to make use of that.

This is the fourth time that someone has tried to fix this trivial bug
for over a year. The previous 3 cases were:

https://lore.kernel.org/all/c715ef30-9d91-46f3-8a0f-1039f3d25e7d@stanley.mo=
untain/
https://lore.kernel.org/all/20260516-jorth-syncobj-v1-9-88ede9d98a81@gmail.=
com/
https://lore.kernel.org/all/20260525025455.3887523-1-vulab@iscas.ac.cn/

The last of which didn't even receive a reply. And there have been
more cases in the past where I encountered a dri-devel-adjacent issue,
googled it, and found that patches had already been sent in years ago
to fix it, but were ignored.

Which is all to explain why I had all of the work for this series done by A=
I.

I heard some chatter about dri-devel adopting a gitlab-based workflow,
and I hope that works out and I didn't misunderstand. Because the
current system is clearly broken. Nobody keeps track of which bugs
have been reported, nobody triages existing bugs, nobody keeps track
of attempts to fix bugs. Which is how 3 people ended up doing repeat
work of discovering, analyzing, and fixing the same bug.

The same pattern applies to my patch two. I clearly don't know enough
about the (probably) undocumented semantics of where and when which
structure of fences can be used. Which is why I sent in a bug report
about this issue in May instead of trying to fix it on my own:
https://lore.kernel.org/all/CAHijbEUKuXNeSnT82P-ojOhzU5siNHjxUW+qEDOqx07Ys9=
m=3Dxw@mail.gmail.com/

I would have hoped that a bug report amounting to "this new feature
causes the kernel to spam dmesg at 60 fps" would get some attention.
But no. The only way to get this issue fixed seems to be me acting as
a meat proxy to fix an issue that I know very little about.

Thanks for reading my blog post.


>
> Regards,
> Christian.
>
> >       } else {
> >               drm_syncobj_replace_fence(syncobj, fence);
> >       }
> >
> > +out:
> >       dma_fence_put(fence);
> >       drm_syncobj_put(syncobj);
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int drm_syncobj_export_sync_file(struct drm_file *file_private,
>
