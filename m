Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B8DC88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5496910E2B6;
	Fri, 11 Sep 2026 16:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zwn9kacY";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BB910E2B6
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 16:08:52 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5b6188a2c0eso1085284e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789142930; cv=none;
 d=google.com; s=arc-20260327;
 b=ZkHV+N6OHreo1FjUjv64iG+JH9Fr13nBgv3oEDu0WcAZHPDsEmbkjY0+Xt0TpS0Ybd
 QvKCFhuje/pPtoA6DG0q0wxXvtY0Sa9FNOcQnL9+3p23UZdHAyFeRy3HGao4yyouc86h
 8n15L5CtHdMxyBPba5CYip+EDYXKe9sCaJPiBZxRpdmyJC5iMiJ5CS6KBSk2p0Gq28wx
 DfIZAgWeRUOKSxeduI3/MDUk4qbyocxjlrnidCLgxX2UQmNuPfkx0qj5cFb9LAFnNG1e
 vfelkRenwO9dDsPVPsay4CE/6JSB8f86y/SAo7CYWmY8s4wvk0eLTgv2Dh3AO3uN3MwQ
 QwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=snwxagCQ4mrcEcTHwmB0+aYoYDwFIfdB7PhzX2AVWJg=;
 fh=qqCnhi8GL+hq+jht112eLzGZcuvbdF29waTararmj6k=;
 b=iLRq8rKUN3KujI6G88Mh1eQmBJZ/3Oc3Dt4VAxqXdCYfeSuq6cPeLnsFtT4snij0xC
 a3SAjV0WHfX28oZyOsoMoPCCpj1TS/5Na+h/97aS2B0RMcDFq6xFTiuXDXG9hyeUc+wA
 b8RDlAkoH7s8OFsFB+P8XjNIneTZ0QmQa0nMql4I46bTXWe3Tr2Msr6bN/mhq253ACb9
 lHpPh3fy+FQkfqrO3Y8Rqx5s89ltqmHyZYNy2jH+KMIRAJaFGaBpHe0/YRuR8yNtlPDb
 RZKFd73Olch+lMGtig1WjeEQOLciPNt1hAnepk7QlaOgrH8nYDxOr9+1XR8I/6/BixDP
 b/wQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789142930; x=1789747730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=snwxagCQ4mrcEcTHwmB0+aYoYDwFIfdB7PhzX2AVWJg=;
 b=Zwn9kacY2TNm8Rm1TLbb/5SDFQqwqi2HhuJJs9Nz1S0Zr2ei5Nx/7h5L1e9uJbG/aD
 uF+KxqNkZ/ucKyflgnIHolU5mWGGiJjTr5Ms2Nt6yKgumxRzVK1IkwPKV68hfQICJ0+W
 cAddP28kVOFFt8svgR+/VsHAowx8ZVymhClIBY5kRze/EM5lnR7vTDBlN7m7aF92UEWG
 gTBwFziZfodmmdkgcqY5A+uysVlfJHXUfehub3Yu3+EuRNwtGmsSoHRKtSQVsbEHzeCr
 YDsg1B1DDyuKerLk/jHvFCzKQ/AosxDv+x/f7yiU2SwsharAaXSf3qWqjl7eI9ojCK5w
 X4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789142930; x=1789747730;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=snwxagCQ4mrcEcTHwmB0+aYoYDwFIfdB7PhzX2AVWJg=;
 b=VdZfpjkWlKgmrejG++HBMJqhWB++5AyVSre+Pl/1ysRVaN4uaHAebysAXyUfZIeoTA
 YPnA8ObAcRV2+o6mjW9d0QDcvzQXi2Su70aVnQLtPxgLuaf/lsZNnfyZaucVQD4TMr9W
 ROqmvEJiNkIgPSEmfZcGRFe0DWkUQfrHZtb34PagomkfkUI8iTdfac5cBEy/T0W7kICV
 fSgpwja9VoCItt4rXsz4w6+36ngltP422AvGebtQ8QJFSRbHY6k/rfrdU4ilTE1I11P6
 AjMFfK4Y/t2Acg/+eEZPmvNK+LJOo2zOsq42OlKby4KJdH6OAK96eXEmWxdNqKXcpRoC
 2blA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsM7hmgsU/tDfl7J/CgOXeMfK6TRzXQG2jHm/3lEyN97ijrK+SdsWIwNwjjlOq7P2GgQt+32GUfyU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++naMbQ11mvRFb1zbA2rzcRazAfxkgmu1V3cC5TtOr2BvOwch2Oj
 WUjiIFzLJK33XiZl5XitZcAg+WjPIKDtyWmVhv5vRW9PcOXRN5utq8UOsSKbiAkwiirxdoZPKLi
 3Y4qGbI2faAAFeKdEOZbeazjlIwWsPJk=
X-Gm-Gg: AYBFou2DeO1MLSEzrKH5kVLDNHAfWH7RmxE5Gj4cPeX/piSjfcF4E1dgLDvYHGwVY4a
 vhWknuMo19L5Mr09DOlMmsePmgtqj6ACAD8MNjZNrw1gJCmnRnOvZ/I4aupJv0hLx45B4d9V9GI
 MPryn7Yz+qLjwfOKNkcZ/FODsbXgnNZtVrDZfV41fe+C+YWC4uPmLblGtR9da1H76tBCyPbf310
 YaNYjmrz4I6M5/8W5nzds9u38ZStzWpGJBAxEIB3pLHVWqoCYUUamcFB0fg6GJKwjQD0OCdYrjb
 DRfuXsW7xgyDjvKmSItxBGZ66ztbPhPEKqq6owUpJi+fGqHvAG3m4Bg8VL1YY+Oz4rZp4FjZKge
 9Z4zQfPpd
X-Received: by 2002:a05:6512:4008:b0:5b7:6393:ebf3 with SMTP id
 2adb3069b0e04-5b8a03304e8mr1270246e87.33.1789142929866; Fri, 11 Sep 2026
 09:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260909205028.13799-1-bub4z0r@gmail.com>
 <067e5ddc2268ae4678745a900108e93d0c6eeb74.camel@linux.intel.com>
 <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
In-Reply-To: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
From: Samuel Ainsworth <skainsworth@gmail.com>
Date: Fri, 11 Sep 2026 12:08:13 -0400
X-Gm-Features: AcwNN1W1VB8g78HD46FVELsdSdTjEr91Xqvo_dSAH54nzFz00UIvmNhPOfVbY1o
Message-ID: <CAHYiNPaHFYSKt6pZWpCvxui=UA8DfH=3iMqYXnziZ43_Ua-nTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix swapped-out resources never leaving their
 bulk_move range
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Vadim Nikitushkin <bub4z0r@gmail.com>, ray.huang@amd.com,
 matthew.auld@intel.com, 
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 alexander.deucher@amd.com, bernardomagri21@gmail.com, 
 Natalie Vock <natalie.vock@gmx.de>
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

I left a comment on the commit in GitLab
(https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3db7d7d583419f7b1f=
2e141e36418802dbb25cf8#note_3658149)
but it occurred to me that it may be closer to convention to reply
here. In short, AFAIU the commit description describes fixing this by
checking `ttm_tt_swapout()` inside `ttm_bo_swapout_cb()` but the
actual diff is modifying `ttm_resource_try_charge()` checking inside
`ttm_bo_alloc_at_place()`.

Perhaps I'm missing something?

Sam

On Thu, Sep 10, 2026 at 3:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/10/26 09:14, Thomas Hellstr=C3=B6m wrote:
> > On Wed, 2026-09-09 at 23:50 +0300, Vadim Nikitushkin wrote:
> >> ttm_tt_swapout() returns the number of pages swapped out on success
> >> and
> >> a negative error code on failure; for a populated ttm it never
> >> returns
> >> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite
> >> LRU
> >> walk on swapout failure") moved the bulk_move bookkeeping in
> >> ttm_bo_swapout_cb() under "if (!ret)", so the
> >> ttm_resource_del_bulk_move_unevictable() /
> >> ttm_resource_move_to_lru_tail()
> >> pair is now skipped on every successful swapout. The equivalent
> >> change
> >> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix
> >> ttm_bo_shrink()
> >> infinite LRU walk on backup failure") tests "lret > 0", which is what
> >> was intended here as well.
> >>
> >> Before b2ed01e7ad3d the resource was taken off the bulk_move before
> >> the
> >> swapout; since then a swapped-out resource stays inside its BO's
> >> bulk_move range (and on the manager LRU) although it is unevictable.
> >> When it is later freed or the BO leaves the bulk_move
> >> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
> >> ttm_resource_del_bulk_move() skips it because of its
> >> !ttm_resource_unevictable() guard, so a range endpoint in pos->first
> >> /
> >> pos->last is left pointing at freed memory. The next
> >> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that
> >> cursor
> >> is a use-after-free, seen as the resv WARN in
> >> ttm_lru_bulk_move_add(),
> >> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
> >> dereference in ttm_resource_manager_next() -- minutes to hours after
> >> a
> >> hibernation, or at process exit / reboot following one. Samuel
> >> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
> >> dangling cursor; the missing removal at swapout time is the reason it
> >> dangles.
> >>
> >> Testing the condition for success restores the removal. On an AMD
> >> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate
> >> on
> >> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
> >> crashed 5 of 18 hibernation cycles; a function profile of one
> >> hibernation showed 336 ttm_tt_swapout() calls and zero
> >> ttm_resource_del_bulk_move_unevictable() calls. With this change the
> >> removal happens for every swapped-out resource and 12 further cycles
> >> were clean.
> >>
> >> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk
> >> on swapout failure")
> >> Cc: stable@vger.kernel.org # v7.1+
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> >> Link:
> >> https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4Nu=
P8D_eSL+UJeevXw@mail.gmail.com/
> >> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
> >
> > Nice catch.
>
> Agreed, that is a really good one. We had tons of people staring at the c=
ode without seeing that.
>
> >
> > This also explains why https://patchwork.freedesktop.org/series/170311/
> > appeared to fix the issue. But that series actually kept the resource
> > on the bulk sublist until someone bumped the LRU or removed it.
> >
> > Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> If nobody comes up with some last second objections I'm going to push tha=
t to drm-misc-fixes ASAP.
>
> Thanks,
> Christian.
>
> >
> >> ---
> >>  drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> >> b/drivers/gpu/drm/ttm/ttm_bo.c
> >> index ef56c18..9b85b5f 100644
> >> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> >> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> >> @@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk,
> >> struct ttm_buffer_object *bo)
> >>
> >>      if (ttm_tt_is_populated(tt)) {
> >>              ret =3D ttm_tt_swapout(bdev, tt, swapout_walk-
> >>> gfp_flags);
> >> -            if (!ret) {
> >> +            if (ret > 0) {
> >>                      spin_lock(&bdev->lru_lock);
> >>                      ttm_resource_del_bulk_move_unevictable(bo-
> >>> resource, bo);
> >>                      ttm_resource_move_to_lru_tail(bo->resource);
>
