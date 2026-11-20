Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9960A2613
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q2tAdg33
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99B110E229;
	Fri, 20 Nov 2026 17:31:42 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB35112C07
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:31:36 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-55be673e029so306871cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:31:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795195896; cv=none;
 d=google.com; s=arc-20260327;
 b=LUdeqDDULO90RXPioGqZ+8jUW/jzh+EDNEEKeN+ayNUTBo/4UJQZ5gbn2ffUYDZkil
 dNUAYYbYD6DhZnpipOAYQAVcyFyURh2kKoEhjRoPsfHJY1tHfJDDax5TCWM2Ja2Sq6lj
 nAIYIVC2FH8jhyEgTLAZfkH9Yzp1Oi8QPfjd8i3X+f/hhcg06w4wtucfqKZqRRe8bT2j
 6pinNS7Gke0I1SQj5RZ7KYJzNA08nWxkgBaIqvp0yF45JdjNqFrMN6grEoMnnu/JXqpC
 LRxPe75UYhu48xUhP556BwOw47kKM4KaMUcfoaEBCAM1/HcPLpbtefB3lRifjESOsGO4
 9zZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TI7DZVXU6YK/vkfYgR8KztTLGwad0zi129B1pm8/11Q=;
 fh=U4KsMJ4bkFO5Azu1yWiaNwbFHWrFhMLpzkS+rABOgNs=;
 b=d3/zawNSznRBfhX2fotU6Dj+Ale8kl+jiu09t6uEgvtFfqahs8KdEISO+fa2HJvMWO
 07hetKqTAvnApOP3q6bXWZ0tt5HXE0WChyXtluiwW5sIfjrvPUsFcOulWjoAA25dkTyu
 a21RIOrCAyYatxgqQeA6BpOOoLP8VpYtXTwApYSFV+3FvhFOjG1OJ9FQkVRDYp9g7y6r
 JT50OXK4LINMSa/wbmZlnmExT2WrHwYqoQVYSuK27cP6aK+CH5k9P5To44xX6FqYSAwi
 JqPeav+s5KkXp4QXWRjLK7OysBVoPnOlN3nLTtc/NyPRBzpzkaSrELKUfJHYlIrYTjqW
 ULVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795195896; x=1795800696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TI7DZVXU6YK/vkfYgR8KztTLGwad0zi129B1pm8/11Q=;
 b=Q2tAdg33UFDMolMB0AEibT0u2FcSi8Hzmd/TLXGN4+cSnwyZJjIbD+0mu13E0Po1/r
 az0GT+9+zxWEZ5sbAWBoe3IjXGTpfOEP/1TRTNR5Dou4QiM55j9zbam8mcc+1kLmRVWq
 89c5Rp4JSnFu4C2X96EMUMCdqRBy4LLC/E80Bll40g3J7YfRjkEzhL0lnxhWQasyWKaR
 1y6jnFdK5EO/BWspEQgJb8tsZtOXd04BiHkRCz2Oes9wU7Aql/1g6KTqy0Yi6K4rT+75
 Tlmjk4lZzdWLiM0jrRK+Fz79JZ7qSZzKBvpd4kOoG0iMl0US/JA05TjtQzQIP4cYauaE
 YXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195896; x=1795800696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TI7DZVXU6YK/vkfYgR8KztTLGwad0zi129B1pm8/11Q=;
 b=FeIFbok6mw5Y9qRWpjAhG+CEwkx/p+H+wu6pL+YXn9nXU0GVBRfFwcTEGnEPzy0K4e
 YEPIutDUxkyYm1V6xFUCyVjm4XRb8u678Ru1gIe9mItVw0EdvuLpmJEJ5S7B4dDP3nEQ
 kJgZ7LMLfTb2je58dE5RiJd/N6JSNwmbx68167aUL4ofoqjTImH9QaTDn8ChzV7FLSUN
 DWbB3dggV/MQUtARX/XUmjjFSKB1JQo2LtYxPphNauCJn9HcYRtOg9KLKY8nGj/Gftrp
 dEYqD3l+tsHbPOtrVLq8+PgG/NBih9FXa1Qykb1pt9Jw4aoOJIv/UARCrn0sJFHbFRFQ
 d63w==
X-Forwarded-Encrypted: i=1;
 AL+hErEBu0Gdntus8udzFmrXMLCjIaa6DTm5urarcFtUoaw4kph1cyaJcgayG3sPCwxuxhAITbr6BqaqZks=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9wxgOqgOyngKMchEeUNL4wh5GZKJAZ4NEEQ5iF0AWngGWI4YPA
 MMpZhyN3cAwVk6VNbclRspl+27JXMo3OWRJusR+5/Dqz3ESJYaHK2mAhW+nuD2CpclgDQZ0G8mp
 WXEoVgCZcHmB3reZoZ7bMMujntehdwkXebg/uDiJS
X-Gm-Gg: AZFdTZfssuKwO0BtPYtFowz2cdNfElDoqw7Eo2U/IvWllVSmQ+bhX30QWIHqeK5yKdJ
 GRTwkr4WgB5sz1fiIwWed+7GtXZ+d7nvHX8CncIRGpDy3Nnnq5LpsOzpO2PGP9l04/a6ahEnoVL
 Nj1wVXRBd0vugXYiblEfRgpVEfSSjHEJkIioC6UOHQFNq02m6eBTsovN5msQV6lpy63/ZnliSx+
 4fVdYtU3/vOiR/JewiqJ95tz+2C56HIyugpbJZ/cdjdMaYbiEqlOnY+WhGzF/iF6+tZ1pQTH/11
 PgL0w9vMJWzNFFSscBpHLLTb97oQ7oB4qWvWAHtiRnzubiITnaPrJeE4uLNXCfh4sYvH8xbmXj+
 CDV0eEfOZoCQkm0MU3pnwS18Y/9qYR0L3+ll8
X-Received: by 2002:ac8:6102:0:b0:546:92f2:7830 with SMTP id
 d75a77b69052e-55d7914f377mr24289241cf.6.1795195895205; Fri, 20 Nov 2026
 09:31:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795106955.git.irogers@google.com>
 <6fcb1e5c7545f8bcfee9ac9a3abd296c475aa1b7.1795106955.git.irogers@google.com>
 <dc491d12-68f0-4297-acda-f122fec00288@amd.com>
In-Reply-To: <dc491d12-68f0-4297-acda-f122fec00288@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Nov 2026 09:31:24 -0800
X-Gm-Features: Aa3M54pYUkUhv-1L_RAm3wzkZJVptY38X_B1tSpjk2kKiiLF52OLhk9KXrZQJlk
Message-ID: <CAP-5=fWN3zHAtixPSbaNwXn9WWTcxd1+XJO6uUb-S-FgNzrUtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 4:12=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 11/19/26 18:07, Ian Rogers wrote:
> > In amdgpu_ttm_clear_buffer(), 'r' is declared uninitialized. When
> > consider_clear_status is true (such as AMDGPU_GEM_CREATE_VRAM_CLEARED
> > allocations) and all backing buddy blocks already have DRM_BUDDY_CLEARE=
D
> > set, every iteration of the cursor loop hits 'continue' without assigni=
ng
> > 'r', returning uninitialized stack memory to amdgpu_bo_create().
> >
> > Initialize 'r' to 0.
> >
> > Found via an x86_64 LLVM=3D1 (Clang 21.1.8) allyesconfig audit with
> > -Wconditional-uninitialized enabled; fix and changelog drafted with an =
AI
> > coding assistant. Build-tested under LLVM=3D1 W=3D1 (-Werror) and
> > -Wconditional-uninitialized; not runtime-tested on AMD GPU hardware.
> >
> > Fixes: 23bd7e67961e ("drm/amdgpu: get rid of amdgpu_ttm_clear_buffer")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 0f86777250fc..280fcdfb9cca 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -2675,7 +2675,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buf=
fer_entity *entity,
> >       struct dma_fence *fence =3D NULL;
> >       struct amdgpu_res_cursor dst;
> >       bool vm_needs_flush =3D false;
> > -     int r;
> > +     int r =3D 0;
>
> Please initialize r directly before the error label, apart from that look=
s good to me.

Will do - I'll move 'r =3D 0;' to right after the while loop directly
before the 'error:' label in v2.

Thanks,
Ian

> Regards,
> Christian.
>
> >
> >       if (!entity)
> >               return -EINVAL;
>
