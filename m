Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259E0CD342F
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C5610EA30;
	Tue,  5 May 2026 09:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nur+LkGx";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F25F10EA2F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:58:21 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c8021c8c42fso723562a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 02:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777975101; cv=none;
 d=google.com; s=arc-20240605;
 b=ZmJ2xVwU2yUG9Hh5GyRvVg1MsrPZW00w65OiAABVXV0FZRP8FfuLvZzyvH5m/vOzuC
 bWTvvO/9E9lmHM2aU440+jACq/RQC7oQgrGceBkHw82Odx+TIhSSz1AAvRDlyXlvl/3F
 AKJXCGaz+Cpm3EDZyZeczqgjAtgeLuAeiTxjCZx9C8xbbKzRa6thXTMedQSBnrshDFeV
 xmZ41Zbe5WBadDLBq2lohtGl6CbGxa1hcmdjWi4kweq10l+tVG8kqw2JeJMLTPXJ20Tk
 UVlO96nfS2jKMJJifqli9Jt6kTj13KQF+HpOjSQY+liV0E6KBpMOv8G4agez0S/tNRk2
 UIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UrxUJHBBr7SJTAlV762fNk/m6IwtaONncgY9rtS10fk=;
 fh=INE9ez1rJJu57LHXZ1rogqc3B+jn4VJpkITgOtyjfuY=;
 b=jhGCarfGLFqPRD4kp0ycXiVj7dFK1SeLjcFRXUfSsVCqwbPXmVuSoUCiw6ukifWo0L
 gmy7CW4e11X4M7PT7TFkaZwTPpTasqfT3O67c9IdMUE8ORcWbFKMYg0XJTrQyyga/8uR
 QZa+KwBZvf/u4Bmvbhmr9o4EG16sKf8mucyju5a9+ugffXGt8wBuO8tjLEtP3HCIGKSZ
 0CGRhKJPFnZbKYcplUGNrOerGjvbEi2k5ls60SOpAc4qjra1kcgxvyDYjvXSIYiemXr8
 Lp9UJHBzsF+JTf2j/WQ0mMyzCp1We8wrt4yyN16HMwN5U5trbjZ/zVs4DYX1Eyh8mnJW
 ySaQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777975101; x=1778579901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrxUJHBBr7SJTAlV762fNk/m6IwtaONncgY9rtS10fk=;
 b=Nur+LkGxPA+miYLxf516Mbx/s/iOeWsxnVryZz2DYtxjtCLwT59TYK6l5kCBi/sw9n
 l1FfUjT1Z1RLz/PgAjKon0GBTDf4+kgzpr/cP5Xy5BPQVZhZO7gth5l0J7z+OuOisN3y
 vgjNbEjRx902fMHj6MJm1T80nxIH2x6MAAGQ+xMJOTSnV3KKZKFLRvp1G6KK2F/vKcMD
 QUGhl+FH44TLjibgZfNYdY/uOgRpDLgjtMIQGBEmtTupOyI0+aBcEIwEU7SoMSlOiO/x
 WdLC61e/fQ2U9VDsk2Xt03D3/px3l+nqBxfFJV+ztYwtwXvjd/bMtkUDxjTJL2zUJFeC
 iFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975101; x=1778579901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UrxUJHBBr7SJTAlV762fNk/m6IwtaONncgY9rtS10fk=;
 b=bZnaiVz+A6dQkWEKi+82A6QAx4WjhQY7fzxmnYwDlriJWF/Vz51ySRv9nikv6TncMG
 Kw8OuIOInqupwKZ0VlKoMH/kUJLNDQPLhKBTEVzsByctWlH+RUbIzapfDse5ZIki6fO+
 QYdhW/PZrPIQzC6wE3nXcwWI6WJT2hwidj45Xh5QyN85A9skQB7AoRrffFEucHBkzzKj
 g0TkKpPKnjub2wQ815evwurDvpe7eBSjMSW86ooNXP4wLhccSUZ60JFsLdXs7JMzhOgz
 nVisTp7EW4JSvW1p8CWwaP5F5zFia4yqEdsPPaPoKfPtx9ZlWEebU0RpnA+f2X2SFSnV
 /1Jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+x9d+k+KF2hmk++9o5pZFufhYh+EXzXVXES5NCUTeft534XED4LbGpQItERIe1mWopL3wGnDlgbe0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz506E/TdNP5OOGHYq3d5Z7BiONxcJOz4ZlAgs4tPy11JVQHzwq
 CouXM/rGcR15+nDaxRn92jh/S5qf2L0ihom0KquerWF3BxJMjw9eOpexqQIV2RaLb1uO/6WDhxd
 Jd8YaIjIlNpQHltmICWDhkaWT7dgjHCc=
X-Gm-Gg: AeBDiettIgmo0rjqHBS0Eb0/glqhGaS1XDsWFJFe0jEvVjYUDZOZlvy9zFGgL0Yp7i7
 WrCOrWuhfz08A4jhQ3ejgSeXCQqb/Lwud1VmrROBEIE4EirIYu6q1ffhiAdaKRxTp7u4RTqUeJ7
 3puALzpJMJzkX221n/23FHpqoKNSK74oW2DlS/k4DmKvO0NpF4+oA8j1SCMCSSkaNqXTwEc7r6k
 XDwU9MFy5qhUI1l/kh/Q3GUnMkI/2d1VAmrlqgv3+ItrdlZD6Sm3i6zwDQ4p0A8/MaQy78kGuPI
 FjUz0ruKhe72auyGXqVRaKD4gGomM0O5LuPjDa3TvH4/okDW
X-Received: by 2002:a05:6a21:e098:b0:3a2:d629:16a2 with SMTP id
 adf61e73a8af0-3a7f1a1df2amr12918590637.10.1777975100827; Tue, 05 May 2026
 02:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260402193424.2023318-1-mcanal@igalia.com>
 <c277db50-2f06-4e33-a700-23751ddab281@igalia.com>
 <CAH9NwWcZ1B1GN=K7nbD6WFqab_GrnArJj_vasFaZfrHJaUoK+A@mail.gmail.com>
 <6ff5b398-a5cc-4548-8260-5babff255beb@igalia.com>
In-Reply-To: <6ff5b398-a5cc-4548-8260-5babff255beb@igalia.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 5 May 2026 11:58:09 +0200
X-Gm-Features: AVHnY4K6NAu8oJooU1Flcnb9q498959JW2xJWJ-EqZsxd2Vt148-Lj0qjUpzQL0
Message-ID: <CAH9NwWdJqtv-b0NjngBvUhUG6wpSSgYiX_cj3DvxdwDvLKLiOA@mail.gmail.com>
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

> >
> >>
> >> On 02/04/26 16:32, Ma=C3=ADra Canal wrote:
> >>> When xa_alloc_cyclic() failed in etnaviv_sched_push_job(), the error
> >>> path skipped drm_sched_entity_push_job(). This is a violation of the =
DRM
> >>> scheduler contract, as once a job has been armed with drm_sched_job_a=
rm(),
> >>> it must be pushed with drm_sched_entity_push_job(). From the DRM
> >>> scheduler documentation,
> >>>
> >>> """
> >>> drm_sched_job_arm() is a point of no return since it initializes the
> >>> fences and their sequence number etc. Once that function has been cal=
led,
> >>> you *must* submit it with drm_sched_entity_push_job() and cannot simp=
ly
> >>> abort it by calling drm_sched_job_cleanup().
> >>> """
> >>>
> >>> Fix this by splitting the fence ID allocation into two phases: first,
> >>> alloc an xarray slot before arming the job (which can fail), then fil=
l in
> >>> the actual fence with xa_store() after arming. This way, allocation
> >>> failures are handled before the job is armed, and once armed, the job=
 is
> >>> always pushed to the scheduler.
> >>>
> >>> This also fixes a double call to drm_sched_job_cleanup(), as both
> >>> etnaviv_sched_push_job() and its caller would call it on failure.
> >>>
> >>> Fixes: 764be12345c3 ("drm/etnaviv: convert user fence tracking to XAr=
ray")
> >>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >>
> >> Gentle ping
> >>
> >
> > Thanks for the patch - looks good. I=E2=80=99ll take care of it over th=
e next few days.
>
> Any update?
>

Applied to drm-misc-fixes.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
