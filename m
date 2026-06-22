Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16FCCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5B010E9DD;
	Tue, 23 Jun 2026 08:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z0DALH7l";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2035110E455
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:52:40 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7fe723ca5e5so45545527b3.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 05:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782132759; cv=none;
 d=google.com; s=arc-20240605;
 b=BFFxCDjHeem80NarvtkDa2V1RBipa4iGVq5UaApvA+V3hMiMI7cRSGd98x5hFm7PsC
 FLQMVEDfGhHGKO0xCykWmf6GPr8z3oSNSI1n2YdRkxbXSMcWN1+Ox/YkvPogi+XWcuV+
 AzlM+T97u8sVnDXd5NXBibsgx7CK3YNOIzdn5QlUwcE9vidnnBz+PhQnslNWbLIOvyxJ
 yake3H4EsPKtD3kX2bUKxbYCNMg9Rz/XN6UmjhZUy3j2jTDLvKtMyoWv6XyJQPvfdfgn
 FRZa8q5QVQ9zjKRF1RiBWT0uhC6e9NrQD2fFGg7BPcmsrGPKZ93O9bxBj26Cgpbcx7js
 04Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gQG1dK1Pn3kDMIdZo6j2PggknuXDB9/v9hKNqUmuRqo=;
 fh=GGf9vm7jvrQb6hEF4PsjydzjWWdWJtBwDUo65CaN1zM=;
 b=Zmlhn+vs+iZ4QaUBAicLirqIG2yJyqMdb+tA3G2KVVUVVpiFhBD/J8Jztql1JcDN2d
 zsvl6579j4nm/BoelmFZOwNc+47h0C2bdFQlKDmNdJfYLf2k9mj27oWSLAfk7GBOlrDF
 30QbjhI/rWiYGOT94PV/9WEsOjnQFj6LPj6vhuHBa0HGYIffH7PNcPYa7dFwG/CYFx0L
 qcxlQlnZOQsUxSfRyuFwsOFgtEIRl12DSQievDDoUucv2xxOV6fKFKuA9qmNJWBCeGOZ
 SP7GJjKu4bQL/kNrQC0E2IZwYe6Tu60DQeyBl6C1xPqUjmMKIYeBIMjiZopndkdMBQg8
 +7tw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782132759; x=1782737559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQG1dK1Pn3kDMIdZo6j2PggknuXDB9/v9hKNqUmuRqo=;
 b=Z0DALH7lYadneNjd5Potn4KPN5XG5m50Hlh1Dy1B6C+MjCRmRVS9J4ZqhwPwDvmIAr
 QdxUyt1reKPVyYW1pPEA8rpazmR8rz4SQUNlisDJgh4eJovehSEXmkSi01g06DFvSA0O
 49MWfX8AO/RcT6wmmgQni5jQ9KD/mKVu3I2Tjqm2wSDXipYTo5U1jUXBfHGhO6J0RJYf
 oBoXWOb0PEEPxyZsc0bP3A+5Do4k0tZStxOm3/OQs1KSKMNUVQdHElaOAd9XKW3y4RPa
 /lsef3EmMmfa1wfck9ApyDMRo6Yb1znJth7c3MOC97mYacyo342tl4IXMywWYKbe5gMR
 KZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782132759; x=1782737559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gQG1dK1Pn3kDMIdZo6j2PggknuXDB9/v9hKNqUmuRqo=;
 b=SMHsXDZ8PwsvVLRXAlF+ci0xFikcc7AkN0NjRifGL8PFrKd0N0bNDRdD+OXVXZmdaO
 sWJ2ex8Nl7/jKANNLQq2eOKuv+7ZiM64uIiLIco3WvcL6Zr11oxSiXxoSq6UvcT+NggY
 Xjhrs93Yq8c2dMyI4+TBn55F6DJJWuuMY4lFpI5KfV1DAaz3lmHOVP+POQkpk+bH+gt6
 JpGVIsVX0LWkoOUFZJCVq05pQ0zkmiLc/qg+0NqMy67NpH2nIRUorsWGdcIEah5r1Koi
 XblT8q8n09pcT3YzN8XSsQ7uo8Ru4iHuzu6yqjr/8elRVw6EdQFGTV+hojrfvXXMTvZg
 GiEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0ITAPiE/AxQ6ZnvLhAY0petWMtZSg1dBj7gB57sRd+BzcrSnaMEUXTPpOt0gWI6qz7lRWCneUlfU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT2UmTsZ/Q+o1thZPJZxh2WkvW5dHHM1lTG2bpRCC1aEX5RNj4
 siKKaF6mf1Plv6P/NJRlQxkVO3bA8XFqqtpx0+Dnc589rvrJWmxoeb0VrL9EUYx2sHcVdJtxrje
 HEzRvSTI/kFB6G12ZpMgEZKE4/1hYBAY=
X-Gm-Gg: AfdE7cmKVQBFa+s+D4Ph7Ej8W/NbBNM3WnTDYsszZy3ufljibzHPO6LMTFQDE5fPTp9
 3e3lRQaY0AuvMnfOKUi/OUXbgYCI6fvGaoLrp97YQ5LtjbDkRgM1JVuiE1Efq6pYovtz2ZX3aUU
 +9SRnitIE51j8q2i/BV5iR33kmqjI963jWOHrQtHWBHmwXsgSnovBLiYcLCIH0a30IyodPkxgs0
 NcYHN0/aRDWJSdWPMffuJBa/gK/qhjVDwSxbgoX6/4Gn7WHjo0yh2eIfW5GzqY6PzF3jCsb
X-Received: by 2002:a05:690c:e346:b0:7bd:882a:43d9 with SMTP id
 00721157ae682-8013236fffbmr132455027b3.27.1782132758806; Mon, 22 Jun 2026
 05:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260616181956.61476-2-birenpandya@gmail.com>
 <20260622115544.GA3899302@killaraus.ideasonboard.com>
In-Reply-To: <20260622115544.GA3899302@killaraus.ideasonboard.com>
From: biren pandya <birenpandya@gmail.com>
Date: Mon, 22 Jun 2026 18:22:27 +0530
X-Gm-Features: AVVi8Cck-hMvuxp0n3mewo-gqCHtjTxGDRmA3jAjW6tNVdbjxYSJyw9YAMsTs2w
Message-ID: <CAAeMi9LMootkxmRE0tjo0mwijAuA0u+49HhxWxRGU-pSz+Cggw@mail.gmail.com>
Subject: Re: [PATCH] drm/gem: modernize locks to use scoped_guard()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, sumit.semwal@linaro.org, 
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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

On Mon, Jun 22, 2026 at 5:25=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Jun 16, 2026 at 11:49:57PM +0530, Biren Pandya wrote:
> > Several GEM core functions manually managed mutex_lock() and
> > mutex_unlock() over single scopes or error paths. This adds boilerplate
> > and carries the risk of lock leaks if error paths are refactored.
> >
> > Modernize these locks by deploying the <linux/cleanup.h> scoped_guard()
> > macro. This ensures that the locks are reliably dropped when the block
> > exits, cleanly removing goto out_unlock paths and tightening the
> > lifecycle.
>
> What's the reason for doing so in in drm_gem and not other areas in DRM
> ?

Hi Laurent,

Thanks for taking a look.
No deeper reason than it being where I happened to start =E2=80=94 I didn't
mean to single it out, and I'd rather the treatment be consistent than
piecemeal.

> > @@ -1021,37 +1018,34 @@ int drm_gem_change_handle_ioctl(struct drm_devi=
ce *dev, void *data,
> >               goto out;
> >       }
> >
> > -     mutex_lock(&file_priv->prime.lock);
> > +     scoped_guard(mutex, &file_priv->prime.lock) {
> > +             spin_lock(&file_priv->table_lock);
> > +             ret =3D idr_alloc(&file_priv->object_idr, obj, handle, ha=
ndle + 1,
> > +                             GFP_NOWAIT);
> > +             spin_unlock(&file_priv->table_lock);
>
> And why don't you use guards for the spinlock as well ?

Fair point =E2=80=94 the spinlocks here are equally good candidates; I only
kept v1 to mutexes to keep it small.

That said, this is a pure cleanup with no functional change, so it's
entirely your call whether it's worth carrying.
If you'd like it, I'll send a v2 that converts both the mutexes and
the spinlocks in drm_gem.c consistently. If you'd prefer not to take
cleanup-only churn, I'm happy to drop it =E2=80=94 no problem either way.

Thanks,
Biren
