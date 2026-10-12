Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEEACA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8E210EAF3;
	Mon, 12 Oct 2026 11:42:46 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44D110EAF3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:42:39 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8ab8d96d02aso12534797b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 04:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791805359; cv=none;
 d=google.com; s=arc-20260327;
 b=rKJVdjZBTTUhOxMHClY3eEJIRViWJ/u++5t47t4awXk4/QCFUNnccbQV5AsWA4i+jt
 AkaeVkQaEBBndh4Yd7s3tL2Et2OMz3pO+nwyfNXJhPJZU6rkF62K2Yk2VTzdYjmOsE3v
 lvS7+kadGjKZ7d0JnatUKamE/mOVQ/NWJInu1wM0xPNOT6IzRhzVdd5+UMyhMJ6urt1i
 IdK0aG/qhs0fjUCd7FXjwi9vm8SGGJFi+/3IQ0ldKDhQIhEHyGA5NCAqBGB5N0aLAwv+
 t1Xt9OasM9cxBAYXD3SauRRUn7+8Yl6oifr9IHwj0JybEpKFZGCxhTW9YSlWIN/Ld3Yv
 OZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8d+kg9RkP1lylbAE//urm5mkbXdgQbKNqjBZri2pwEM=;
 fh=cAeV+/pRE1SL11oXjmGCGWFYYIh+mG45jjQYJ/SLwm8=;
 b=BigKKlHUpZVq4fK7qgFiX7tULbFd/sE7zRcjmXAyyNWCh3EIPef+oJ1NU3FulbQMMH
 6Xp5Q2skzozWhleBq2ouGAbYRNp0H7AwO6KOoUYySRF6V8gDBmVKkKNzgyo6SFTV8wgy
 m8kNAdng58FXDxmAjxKHug27bKkiOwskQGUT5y64yP+f+cXxE1ZlsJcHD4RKOi6AhT4r
 TdqibbyFmfrRhOOqrU4U/R4SrrWjIJQZeOD2ekgxOvx+gfpn4jM7uy0eHtD9UfZK0joA
 Y6xpCO6Xa0iZkPbVDEIDutuPTLIs9ZfaXu1hkMoUFr6n4PgNlik0vN03dkoLoCksaPTM
 E9gg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791805359; x=1792410159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8d+kg9RkP1lylbAE//urm5mkbXdgQbKNqjBZri2pwEM=;
 b=jaXhjEW2CyvUHdgGq3zG0b32X46hf5zz+qxNeCkjAMeSHQMGRNI4eiwNlO++cnyn3u
 YSIKRhKOks5lC+RetrAbsraTDvnhLHdq0X4ZZn7MahfFCeXKWz+EJtB+5iEv2zAD3Ctg
 CxdjdklcxVVkNK5gzaZFvXxhQS1sbhpAI+6Kl+KHQQAElZDU0DTbUHyZk/QnFNRORK3G
 QWI71y+n7ls3l/Tg65FD7OyGb/o7AH8lFD0vtBMuy05699rf2F1zshUneGCM0FxO8RcE
 CdKXuh9eVAdOtHUTIY66YjDU8O1qAsEJ5ay1FkD4Xnl9JLkgfgxKL6CqMZ2XQJL1laK2
 JXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791805359; x=1792410159;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8d+kg9RkP1lylbAE//urm5mkbXdgQbKNqjBZri2pwEM=;
 b=VAEAwq2ta/Qlmti10NGBrvTP9BBZ5Ftl+eN4ZNxmzY9xqju5dkgC6vQPeycIdYEs+p
 zK4mrLoR0qkynuZvPK0flds0bFfU4Se9dj6V2ShmC1bEGZ1eXQ4c9DJOLbGGJFBEZfGy
 5J/Y4Yd4Fk7HZ8proOhT9F9ISkDoGSDZ+u9Ww9/cTIyRiRx0GylW/VplhAcWzAM+LGut
 vhMvw1fecF3uAtZlQGchC/fj8McI1qpRuTWYMLBG3aCOfE/dBiDq9/ScDhqEVmO1reDi
 gEzOZGyq1X1l+8Ophg20twrUI4WL9Km5BQlZQ4iP8zOhHGAdFzH80LXXHfqfSxOXU2T4
 fk0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnvn28DrCoqAMKsF+0jfC15nq/RHIGqOCJoPF3rNA9km2X82v8RL8sZViDdQ0ydWorn82pLaQB0No=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxJ6D3JSPSHKVjmsVuCWcTBImFKcwZuiHDySO8dpkjqnN4cZ7K
 4xcrBYTy3UGFpLU6piX8zxU/l2YWEmIA4WnIv7wcrgU26nM1/D4dA+U8n42f46GEc1IkPAXKfCT
 PIP6JUKqNKnDHG/Dr5YrDBwx64a/J9qw=
X-Gm-Gg: AYBFou2MlVmGR0ydP2JJadtVdBd9+bzwuk88FuQv7DBBqcxAJIX1AmxgbV5xTuM6YNy
 aJTYVWSvD0E9zsfDb6Kqxq7W/qoMfsYvNur7X9zej415FAxycFaVpVnvBJTxHkMJB/wnxxZfA9e
 UnF6nE7ja1EAngigfv0ng1uWXVEd3EVgHSvQNlL32UU4HXaaWSSAp9Oo1RgUU0IQKDxIo4DKe81
 qw7nx5P+x0uHFgkATdWEYM6IGaglv1zFW/qQJAMfoxxL6BocN0Qb4inf1+rdxY6WFtxBwqGGdLW
 2AcogQhUOSFFw58Yh/8NlTfIVhwAzCqOkoSPtLF41EWfYFzSrW6FS2peITgVXAiE+/XRiBWynqf
 9aW2YPn9OpPUS0TxASfo6
X-Received: by 2002:a05:690c:1d:b0:8b0:8a9c:fac1 with SMTP id
 00721157ae682-8b08a9d034bmr20413527b3.21.1791805358689; Mon, 12 Oct 2026
 04:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20261010180711.1548333-1-ju.orth@gmail.com>
 <20261010180711.1548333-3-ju.orth@gmail.com>
 <f70c39c0-3754-4a18-8ad9-eaaf8a307b8f@amd.com>
In-Reply-To: <f70c39c0-3754-4a18-8ad9-eaaf8a307b8f@amd.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Mon, 12 Oct 2026 13:42:27 +0200
X-Gm-Features: AclHuK9UY_9BF00vKMnCcUp0DHYkFhZbh5NYROup1fNDrn0hsAfYgZ-u9GoRjDM
Message-ID: <CAHijbEV=510kPTYit=EbXtsYosQ+WOJ58Ey1AqK1Ca7Wb77bCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/syncobj: flatten chains when importing sync_file
 into timeline point
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

On Mon, Oct 12, 2026 at 9:51=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/10/26 20:07, Julian Orth wrote:
> > A sync_file exported from a timeline point can contain a dma_fence_chai=
n.
>
> No it can't, IIRC sync files are only supposed to contain raw fences or d=
ma_fence_array containers.
>
> I think we never documented that and that's why this issue here leaked in=
.

When I reviewed this patch before sending it in, I asked the AI if it
would not be better to do the merging at export time. It was adamant
that it had to be at import time because of commit 519f490d by
yourself:

    dma-buf/sync-file: fix warning about fence containers

    The dma_fence_chain containers can show up in sync_files as well

>
> I'm not sure if that doesn't break anywhere else as well, so I think we s=
hould fix the exporting side instead.
>
> Alternatively we need to audit everywhere where fences from syncfiles can=
 be imported somewhere else.
>
> Regards,
> Christian.
>
> > Importing such a sync_file into a timeline point with
> > DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_IMPORT_SYNC_FILE |
> > DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_TIMELINE passes the chain directly to
> > dma_fence_chain_init() and triggers
> >
> >   WARNING: drivers/dma-buf/dma-fence-chain.c:286 at dma_fence_chain_ini=
t
> >
> > because chain fences must not be wrapped in other chain fences.
> >
> > Flatten the fence with dma_fence_unwrap_merge() before adding it to the
> > timeline, as drm_syncobj_transfer_to_timeline() already does.
> >
> > Reproducer:
> >
> > 1. Export a sync_file from a point > 0 of a timeline syncobj with
> >    DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD.
> > 2. Import it into a point > 0 of another timeline syncobj with
> >    DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE.
> >
> > Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline=
 syncobjs")
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Julian Orth <ju.orth@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_syncobj.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncob=
j.c
> > index 5ca5163d0..c545af77e 100644
> > --- a/drivers/gpu/drm/drm_syncobj.c
> > +++ b/drivers/gpu/drm/drm_syncobj.c
> > @@ -742,8 +742,18 @@ static int drm_syncobj_import_sync_file_fence(stru=
ct drm_file *file_private,
> >       }
> >
> >       if (point) {
> > -             struct dma_fence_chain *chain =3D dma_fence_chain_alloc()=
;
> > +             struct dma_fence_chain *chain;
> > +             struct dma_fence *tmp;
> > +
> > +             tmp =3D dma_fence_unwrap_merge(fence);
> > +             dma_fence_put(fence);
> > +             fence =3D tmp;
> > +             if (!fence) {
> > +                     drm_syncobj_put(syncobj);
> > +                     return -ENOMEM;
> > +             }
> >
> > +             chain =3D dma_fence_chain_alloc();
> >               if (!chain) {
> >                       ret =3D -ENOMEM;
> >                       goto out;
>
