Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C055EC44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCDB10EEB9;
	Tue,  7 Jul 2026 18:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q0yw4Ybs";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC6710EEB9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 18:13:06 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38096590070so386299a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 11:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783447986; cv=none;
 d=google.com; s=arc-20260327;
 b=erMdwAkxkBCMoaEtXG3K95sVumvp6qQDV1e2ON+r0vYAYOwI3afef4mTjjM1tKZNWz
 bopLPgF7GTdZBzv8Blq6Qp6MGnQbh76bbS2BRfkTfz1+rXtpCYxjDN123M0CQ24lOUFb
 V4aaF8UQgF9wFuD/AdBWn8Kd9NYuN6QjA7Ogm0eFuKg2YnwR22MXj+CvCQI3V2FOlVaT
 cEOKNrSmwjduhVyMkPq/KlxdFE148v1Re7gVlX7LuoxcibHpT5yg1Gkk80d4BmNrZ07W
 iAeodgGwQoMHCabzGFZdJj4KXRyGSbgGsrjI8AsCSMT2VqQ5ItH6kKUvuZo1r6kdNJHI
 KQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kqdEQqGxI7vgb8pogihq5FM0tpdEo42yoW6988L8HP0=;
 fh=yrnTUi3MbCu89rmFPpr1capZmVACLTCMKcWV+jg7X+E=;
 b=cYph49aEf3gOJlxJxU6M0v8wkjRmONyN5qLyJiRMR9dvSrexgqccPiJCYqQvBl5iYn
 kuEntJdZoUOTjw/JjocvRn1EfJ/QN1sEYUOORnJJtkb5BVW41saREHempjE93lpWllIt
 A1KwMI18f0Tc91ZGDgEpU9Eq6jnpDZwNLp9u2tZO9rvAxLNQj17M6YJsO+h3YADCqtxl
 qfx2Q9gZgaHEFGQDvTEmU48GUivroNnvMupPHWRENHTPV/drQY7x9ThlC2eLlF8vo3nt
 Be8a4kIbzy6RRpfoZcucNq1aAHPAZHSr4/UcI8L8nqg61ykFfBvJM2CX841XCRQfc9hc
 QbCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783447986; x=1784052786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kqdEQqGxI7vgb8pogihq5FM0tpdEo42yoW6988L8HP0=;
 b=q0yw4YbsckrRuO2bR3x4GrGVytoHA5RrWlarl5/rogHXn9aAA58fJDHLBBHTeq459k
 RWGyBVbHitLN13gzCEfS0by8pxPD1GDQR6nkx0vimJ9iCkRMCMv/xpf1tIgf43PytLwO
 KlX4lHxL9demBITS5J6xyl4WehNgCHXeee7fY7Cy1Xb2AqdV4Wcc05aDuEDQVh64MosM
 /GGF/xaqBsbJzb06ltDlR6QiIrg7ZildhQ77e5XWrm5w4sadBPK1KZy3HhmtAm5V3+IO
 rV/39CMyQlJYTOt9RlGhEpMNvYcXZ2aVyZr0cUP69v5QvnN8xvD1SAPGXxLoW3G84la/
 0iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783447986; x=1784052786;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kqdEQqGxI7vgb8pogihq5FM0tpdEo42yoW6988L8HP0=;
 b=JuFgLqYndatILMOMHW0nIZEyxc/R2/lzou2TGicdfkrL62dd3Pqvkai3rcPkworWkD
 9dNsqDwgcb3ds6YoS1ybtuDDlg7zciHDud/C92GJPR3WLwUwt7ibYfCIbYq1vUFouRpk
 cS4t0gF+2c0RQXON5MdSGx+qF6PSjqXz/TGsJnq2ka4GL6naC9W0lZXxh6ZWy9HBH1qh
 kH4dFet7TLHyoYxv0az+eGAkUleNym775LXtQ6JCAucKuq+uBMmZXSl2kw5Zqcau2Bfk
 dOeqtZNu0uzBnTKFbpftDYgxgB/W7722hNJyBGhUhgDqinC+7k71mjHTZV274KsTe+LQ
 tgEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrO5FZhsewDcEe4+nerI/lUaDN04Z+BSdvO8KGDlYb1EViUFCaUNs//OxZgqu1GPODVborJF8D1P4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzt3gC8o6T+Juf8GVIQY5uPJbW2Lhmn5LbDskyafAHHhfWYyHJQ
 Gfb6JJbmbMPAyd6Ms1GwZrD5CaarWbgnUg0Z+YzoC5Ex5OZAqE2N+wWfLXb9+YH2c/YzTYZDcWW
 F+Yhvi5Wjq2or+J8l5g7vwFvboHb92vOU1w==
X-Gm-Gg: AfdE7clrFGBEzbcpgXaNONsonnGaszBeKPE9zr+tOc0qPMA07dKv/onWpxw2fh+vmpd
 mSOewSSleqq0BDwGU927ze+5xhc5+4LOIcXVwwbCTNlOY77zApF2rrXGVGQqRNOiFA0gt7i3aiH
 v0rV/aOSllB1ZNPykl/LBJ/EzD0HJumVXKwhttN2Qp5x9LOdeFe8B0+31TjP2QF5Y4MPrinzsi0
 MzNMPH/d9wVDqINh7SfR+ah7yJfiNFPPSf/m1AKuJWoopKRGNCJBmCwGAJT20tTzRYWTttHkY/U
 6nerkVBk/YgeCNf+VlwW8KCmTGl64QsMbIUowteWklsKOIvEc14D1JO5SUI=
X-Received: by 2002:a17:90b:510b:b0:36d:de94:f31 with SMTP id
 98e67ed59e1d1-382a05aef5bmr10041142a91.7.1783447985781; Tue, 07 Jul 2026
 11:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260707093812.109176-1-marco.crivellari@suse.com>
 <12766042.8bMQJbFj6T@timur-max>
In-Reply-To: <12766042.8bMQJbFj6T@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jul 2026 14:12:53 -0400
X-Gm-Features: AVVi8CcFtIefmJgVcRFeNq0XkI_qubOg5oXAk2MnXUnij9hKh_kHzDeX4SXC8zQ
Message-ID: <CADnq5_MHa8L9gWutwRKBQQ5QuM=5qd8eJgC8ZYKyBQQ1J9NUZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, Marco Crivellari <marco.crivellari@suse.com>, 
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Ce Sun <cesun102@amd.com>, 
 Tao Zhou <tao.zhou1@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
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

Applied.  Thanks!

Alex

On Tue, Jul 7, 2026 at 7:02=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> On 2026. j=C3=BAlius 7., kedd 11:38:12 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Marco Crivellari
> wrote:
> > system_wq (per-CPU) and system_unbound_wq (unbound) are the older
> > workqueue name, replaced by system_{percpu|dfl}_wq.
> > The new workqueues have been introduced by:
> >
> >   128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> >
> > Usage of older workqueues will now trigger a pr_warn_once() because the=
y are
> > marked as deprecated as per commit:
> >
> >   64d8eae3f895 ("workqueue: Add warnings and fallback if system_{unboun=
d}_wq
> > is used")
> >
> > So change the used workqueue with the newer, keeping the same behavior.
> >
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>
> Nice catch, thank you Marco!
>
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c index 53be764968e4..95cceed4e=
971
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -545,7 +545,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev=
,
> >                        unsigned int num_dw)
> >  {
> >       amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry,
> num_dw);
> > -     queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
> > +     queue_work(system_dfl_wq, &adev->irq.ih_soft_work);
> >  }
> >
> >  /**
>
>
>
>
