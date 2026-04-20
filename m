Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C607F5A8C7
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A66891D9;
	Mon, 20 Apr 2026 21:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O1GnK4+K";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4EA10E769
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 21:59:19 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-35d965648a2so3016246a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776722359; cv=none;
 d=google.com; s=arc-20240605;
 b=kmUXU0bR83Df7sCTGsQGaYNlSi/MhGKr/eYbnU2FgVMzi8fc3538JBCV7ugQnqZjd9
 ffxdEIfG2JubG/bc+rF/f5OIP+ZrLFHdbl+KJ7yw/SGt7vkNco2e9I1VpQwN3Tx4ENl2
 eFk9HkBiQgdJJLENUx8En22sjd1+AkMVsq/3UB0A2UuBLhPCCc8gPI3UFFGv+l+sHUwd
 fx328Uukh450eGE9f27k3m/rATw4GccToNWveSuJg+Th+9K74z+kVrcqxLPjRfp+iL54
 HIF2FNLULX17RyqW0/IkKJOyy6uphS1OwwFaNrxLct7AG3j+rSvUReyPNd2eX09FDWDr
 c2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oZHwgC3Xzf8jfkbpQVbDXt2pNcNKRQomh8QKnspAMRk=;
 fh=tCoV7esn2M7A63uQ3PRG0c9mJTRlnz8deHpA9h2YjiM=;
 b=PQ5+HbbM6fToVjG94KmVroRxczGk7R54NBiawOQZEPADRLlQfh8qlJEHZLB7R0GxsY
 jY4j/dHYgtt+mGXmNKpdrkxGqcUZ1dBFlZjtrR3Isy2tuS37XuPTQmRmTArQqQEHqiYP
 JU7/XusA5mVZbkdC85GRIfnSwLR28H48ZLxD4bmUVXLqilEvYkzsPk8o2X6Gj+sL8UBA
 +S8u+EexxvIdxpBob0bcrO6x+oLSZBZ03RwMfRppYO8r7erv1t5/Ilug0f+5PWbktXa3
 vX/QlKdJErHWcg6CI9mPg9dP1B4ojebB/fDw9wIHFLNBLx4gfJauBJzlWs7WmbXF+fji
 eliQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776722359; x=1777327159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZHwgC3Xzf8jfkbpQVbDXt2pNcNKRQomh8QKnspAMRk=;
 b=O1GnK4+KT4MUD6FAwIfs3kBD1zgQiw92HK9EPPLT+sCN2V2ImzF0w8aOJmMdMhft04
 BTi8ULB9fvtbZ/doJMJAXVtPTC9sfHuOjQad4MpQ7glEIp5XfunMFq/3B3I3WS8vFl8i
 4oEmsdxURpf1+Pw9cQMxwkPPABPLLozZPDVA1eC5fOTXfj+/+wU8IefZh8ecBzUsmbD6
 frvYvpJajHnEHdgTGjeH9eigQ7+ri2mjHl6W5re85N1iwWG7+IIwIj9tiiFX8I99b3wE
 sLMUKIoitccfa47haY4FH60ZQsxG8uQdlQhnpQQUlFyfOiliPePCDPVVxjHtB73bfMBv
 /nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776722359; x=1777327159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oZHwgC3Xzf8jfkbpQVbDXt2pNcNKRQomh8QKnspAMRk=;
 b=MqotnajvZcojmqhVJGq4R26t/1Xr6vtfn4bT6ICjdo52t+BdTRRmxnnsOOYznv0gh+
 OFZx/mly5xS8xTLp0GaMzV69GhBZ+1neipz9Rc2yA9dEH04NZZ7G8N6e1Q842BdeUa+w
 6BqTXVS/6/ZQ6m5cLOHqi/mco+BbU42v2L8gcPKl+a9Bsy6u1eV9Rw9oNtjU6GkmEt44
 gHJK3DoXmEna9Ro8TiNhhJE5G/o0kAk38kr5U6IxkID2DMsPHYvgroHRO/TS1Tzm/fpK
 C2ONQKAbjj3J6cKX2j1gyGQPd3JGABI4i9TMUpeyMHHVfueA7u8WezTIT7U9tvLaX3EE
 eq6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DVKqwkrE9+78owKb/ZYsyHvikkh2ypqk2esecQ42gj0Dk2nvMyQEPq+9m5xMW4oFA0bmY+xcI6u4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNfJenf3hQXi0lHOBwh7c5klq8dosKfF9WSveEsXWGeXXxzPyn
 oduu9eLSR6pMZlYrEPiSBCCf1DylAK3Pp41si0jWj1eoPDnDgtjMGPFUNLaXJojYxaxvsxbIOhh
 PGOrWUVDd8VFLS0ATNONo9G7JSJXuoyk=
X-Gm-Gg: AeBDietK5nAR4sDNbN14aBkbRGNwnO7L9/YA4Ld5dViCs/JD4KFaM7NqQVZheqPPekW
 WF4oVcID7+XKb2gaPGBrxjWO8dvRjdUS/k3hWcseuB/GQNHKP8A7E+QarK+7MX0baSAJPiGT6DW
 t58l9eTJQxS88kAk5LlDERjLzaNPo9d2bXfxemVxmwPhP23OJGPQJgS+7Vuus77L8eB7IkNYTEF
 ZDEUh0AGRk3h2tNXBkvxezWmLxcTVYkufmdSaDqjpvxZx8EFyCJ7Y+N9hy4xNrRBiAZpPDjSdr/
 53PL6R8EVfU0MZSZuu/WSR0gzM/ZJtZJJcXdzdfBb59B2tm3
X-Received: by 2002:a17:90b:3f84:b0:359:1130:1047 with SMTP id
 98e67ed59e1d1-36140468c28mr14794415a91.17.1776722358823; Mon, 20 Apr 2026
 14:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260402193424.2023318-1-mcanal@igalia.com>
 <c277db50-2f06-4e33-a700-23751ddab281@igalia.com>
In-Reply-To: <c277db50-2f06-4e33-a700-23751ddab281@igalia.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 20 Apr 2026 23:59:07 +0200
X-Gm-Features: AQROBzAo17709YwScIPIv4bXTMRHuh16P_cry_7bg3XCI-EzAk_s5u1bKkD4Ppg
Message-ID: <CAH9NwWcZ1B1GN=K7nbD6WFqab_GrnArJj_vasFaZfrHJaUoK+A@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Fix armed job not being pushed to the DRM
 scheduler
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Stanner <phasta@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

Hi Ma=C3=ADra

>
> On 02/04/26 16:32, Ma=C3=ADra Canal wrote:
> > When xa_alloc_cyclic() failed in etnaviv_sched_push_job(), the error
> > path skipped drm_sched_entity_push_job(). This is a violation of the DR=
M
> > scheduler contract, as once a job has been armed with drm_sched_job_arm=
(),
> > it must be pushed with drm_sched_entity_push_job(). From the DRM
> > scheduler documentation,
> >
> > """
> > drm_sched_job_arm() is a point of no return since it initializes the
> > fences and their sequence number etc. Once that function has been calle=
d,
> > you *must* submit it with drm_sched_entity_push_job() and cannot simply
> > abort it by calling drm_sched_job_cleanup().
> > """
> >
> > Fix this by splitting the fence ID allocation into two phases: first,
> > alloc an xarray slot before arming the job (which can fail), then fill =
in
> > the actual fence with xa_store() after arming. This way, allocation
> > failures are handled before the job is armed, and once armed, the job i=
s
> > always pushed to the scheduler.
> >
> > This also fixes a double call to drm_sched_job_cleanup(), as both
> > etnaviv_sched_push_job() and its caller would call it on failure.
> >
> > Fixes: 764be12345c3 ("drm/etnaviv: convert user fence tracking to XArra=
y")
> > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>
> Gentle ping
>

Thanks for the patch - looks good. I=E2=80=99ll take care of it over the ne=
xt few days.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
