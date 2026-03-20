Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA601099B4A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 22:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3B510E0F8;
	Fri, 20 Mar 2026 22:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kvXX5vrc";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7109510EB50
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 22:38:50 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-64ae222d978so2763332d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774046329; cv=none;
 d=google.com; s=arc-20240605;
 b=baypSPFlHLWW66D+PtmCgcEfXK2dbZVJc5djKPJ2/NcAC7wVbwSglkAHpB/ye58zKp
 0mVJzHod5TREw0KwVHlZ1gKXIQO+oe7WMaJhclCMRqFnCYrHZRmp/CrTwdAToR3BB8fn
 RSG927e4pyQ48LvtKSxC4lj8lHVhVsGhE9ZLyNq0RS/UWf/Wlnxc0gcgrcmFolGTOcpj
 AFcAr4ZWtro1lQ3D/z8+CzVf5XkGUHnPAVtSL3DDEC1DtPxU2CnqzHxFd6K8aaKvvNn1
 Ln+Og8pkwJLx2vdoiOtAHpyoGT2owCdzLOPXSlk+RRxDHFyVhnYfb2ASvH3iSzXwku0X
 6m0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1QP6vLGAno7k+sNss+wwfyElHbIT2Fj2kzdCjibqhnU=;
 fh=/Yz+5q+bd9obOVvzWqO8RfsHIZ5e8S038l02TxpuRHA=;
 b=HbPpLelpKQ+0XTeVQ2yag7YRhpDcj1pED38v+X7svDdiZSCy08fgLiFYwc4y+i+v4V
 daTjULMKm+0E+I7zdqODRLB5f8+H/Y71t42e64kMUlW5u0vp5zczZblrI/FfXQfMostr
 cIRKmPy1tFvY+Ii7zZLKGgF4khd0Cjn9k6uxpWj0VNlaMQVD0FMWntdsKWAqNjA5OXRC
 +2+s/2FErQp4O0xpFNoui0Wb2gAQaoWPhvBgnNVXbmwgTIqbPcPhjPIqTbdXh2AV1zZb
 FKJVEnATq3CwrtRnqzD0M5eftt0DbmdJ3e0zVOx8IxQq0fjS205iXIHV6KrdAh9Tb+zF
 xWWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774046329; x=1774651129; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QP6vLGAno7k+sNss+wwfyElHbIT2Fj2kzdCjibqhnU=;
 b=kvXX5vrczBwzeLzetQEk30KLX2hI8wZSCEZPkz20BHdO3OAlPJiiyRZYMBjwTkqK6G
 lA5a2Vymp8+CNUMPqbfeM4+pqnADDrPl5sa+jaMfitV0HrH1BZYm1SDX4gPbT4ep3nZV
 vqu1n16wt+dXoujFWL+/sK8qDWM3+xx7HV8swGmXa3oAvgTqtPCi6hyUxlZKQD0wldj4
 Iqw2vxzzYJOJahzsWAEo0XxnEE5AUh92KtkTU+eIvYoAsYYZbwPvlzKBXd13jPw/5Fi8
 bHuYLT2x00OCwkNMEM7eeGTr+r4Z4WC45fTvR/llh3PsxA5cVoVGzDH2RV+5im+1NitV
 1ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774046329; x=1774651129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QP6vLGAno7k+sNss+wwfyElHbIT2Fj2kzdCjibqhnU=;
 b=Aiqk+VxeWHFBTh8CEiFEjAW3gIbNkA9dzQe3yZ6K2kknrbsGRPCc3CICVw8uFHBMXL
 ArPQqSh80WFCocYNcWprJ1/9VKjzmJaIDQE+RysuogKr4o4y4QxlDb1O8qs9m5MRdHXG
 5WGUpJ8NCSNGFpEQIU796AlWDouIGTRPoUviByFH9t16aDcHxv90BYRYiTiv/rDycPhr
 a44bY+2D2jueo6haygLeQb6vii76t0TVctuwOmlFrEULHfV4w7zNUTlgPElOjkkpjUdn
 45eo08T3dUGF8Pr3Z3/4dKmCNmze9JyCJMuN1aYNVwZNDDpNh08aJfbjhHcYRKi7tS9e
 OWVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkRIFriinctm64EUJErqilk5gU3yMhAx9ihosHV1Kdk/RhtBNV/Co8JRYiWnh9+swdwm9xMgHOybA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlKDhs+XJDScCb3XXFHBA2e7yv/Lnh2hO2oOZzBZ2GWBgjqffH
 Kolb4zZydbcUYhHyQIMVOgZAMSBJtqIzdxGGVnp4XyVtZ6MpTy4VzsiQ1ISo9Pxt9TuTdrJO4Qx
 zm2PC7qV2mBre+7ftudR7b0HlF4FhBmc=
X-Gm-Gg: ATEYQzxVd3pkbzHlq+qXIsH1BeJue03QHs2l1BBksWLUOjjYzuLopa1l+huisYKz1G7
 6sqs3sk5RGB9zbD4XW8moMSD3d9h+Y203QbmOrqXgZJi3eqoRocx1ct06c3vpLZ+n3OPbPJZXU3
 Q8CJFrGeum5y8RsVr/P62Eqp5w9B3vc/gsO4xu4Ul5HyXksrK4qtUwgm4zt+mMNsPVdoGRBYuqx
 kxdwYXGSWPcQj2pkAxvOhHOOeda7/EO9coGmEMmcTTPEmUFSWBGVwvMpDUrO9S293dEDg9r1dem
 V3wk
X-Received: by 2002:a53:b9d2:0:b0:64c:f2f5:8f5c with SMTP id
 956f58d0204a3-64eaa707e47mr3626057d50.30.1774046329351; Fri, 20 Mar 2026
 15:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-65-jim.cromie@gmail.com>
 <177402491485.6181.1878747749743687917.b4-review@b4>
In-Reply-To: <177402491485.6181.1878747749743687917.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 16:38:23 -0600
X-Gm-Features: AaiRm532nEVSECCKtVZQBvh7bVjnXge5XC4gNh5bglnjYOP9OLegdkUxnYh0aWg
Message-ID: <CAJfuBxy7U4DtDHKrphky7mCHMxmC9ZvuE4cdH1qAzZ4PZGuz1A@mail.gmail.com>
Subject: Re: [PATCH v11 64/65] drm_print: fix drm_printer dynamic debug bypass
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
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

On Fri, Mar 20, 2026 at 10:43=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:20:29 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > [...]
> > mismatch in intel_pipe_config_compare(), the resulting UART storm
> > causes a hard timeout after 20 minutes (see below the snip).
> >
> > To fix this, change __drm_printfn_dbg() to use the explicit
> > drm_debug_enabled_instrumented() instead. This ensures the bit-test is
> > performed at runtime for this unguarded helper, stopping the UART storm=
.
>
> Why don't use use drm_debug_enabled directly? Does it make sense to call
> the _instrumented when [2] is not enabled?

my reason is so that we can turn on the pr-debug, and see how often
this happens.
If it happens a lot, we can look for ways to replace the bit-test with
a static-key guard.

That said, we could use drm_debug_enabled(), we'd lose the counting ability=
 when
DRM_USE_DYNAMIC_DEBUG=3Dn, but still have it for =3Dy.
So Im happy with either way.

>
> >
>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
