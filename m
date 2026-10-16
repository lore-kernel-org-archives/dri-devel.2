Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EDCCCF2C1
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 22:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 209E11129FB;
	Fri, 16 Oct 2026 22:20:06 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063E71129FB
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 22:20:00 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-93ead211f14so39162185a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792189199; cv=none;
 d=google.com; s=arc-20260327;
 b=CiB3jqp0zuCrLaH0gpRjdJYOrgIBThehaRomt8VefoTHA1ZCWO9VWUVS2GqD20ZPWZ
 l96/EzUqkDu5dJWA/Kr7jgdTbriA/9dcytHVMZRKRbApGOUkIsIBKEEP2OMynzmLFbgg
 nLAF2gr27DlvlltTo73WplQKEvtgGC2qY3HWmFwzw0s3bkFnRIN10N7ziNt4hu+Nr20f
 xkkCgrWSd/zm+CjlETPZCsQ7J77LEwTs6jkL9HQ8c9nWSpGYbV9nznB921GeKcDpcF8m
 BH/960BGjs/kJxwC2F/3T/iRTcWRLHlIQE4tDlviK7ohLWcMoN2QwGF+o8dBxXWQ0fCm
 3q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g2RpCD6pPbG0jDZvBkn3q6Al3Jxnoi0KYgJ+ZRe5j8s=;
 fh=hDLIUJ7cskWTnlJ7yzRupa3svd2FKhYOhJGjVfsHS7Y=;
 b=kEMXxr8w3cBDsR52TGUQi23jQLuZPrct9HD3ahbD1ZsQUQmtzkRv5pVV9aH9Eyau2K
 uA9IqHgUBr0VwD6/BAJPkX2v3b6dFt4doycvwsHE5wunKxxdS/SYXei7vqIxSmxl7lLr
 S5hZtH/y+maAZP6/vm7HKfetbmjlDm/SbE6/hiC7zNhMw+VoCxBJj68x5MCfxHyXZw4f
 AtzMjDrB+ZbwWX/XBkjd/4THGw1EYE+OjpS9zWgC6VVa58xEX8JVo4rVi7ldy1wtmlCY
 FmMUSfA5+qUbsA2qKBAgW8WNF9+9bYTsuv+qFT/NSkAG8RmGaSSr+TafiZix/ZOBKTXo
 ISZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792189199; x=1792793999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g2RpCD6pPbG0jDZvBkn3q6Al3Jxnoi0KYgJ+ZRe5j8s=;
 b=B3a6Y9jY08HjaiNaMQTFKxD7QmLAi+YVTpCIb0HwFPsoDz9ldxAWRDXJ/wCVwYEdmG
 zJZRqRzoZjzJuLemn1iV2CXFqB0OKr/WcdzUuYM3pa8+Zkhn+yUM5aqejnCrx5yCaCcV
 A2MJaPP4LhbI3q8CiKuiPiNFjS6AvLw0GkxrITZQ7H6QSsrsrFX/7fD0qrJJOQac1xOj
 lnnqaNTmB2uuI49FIq1vIiGYmfBfygu4/GSYbnZkkItzO1dGCtLf8KQKr1uHKA+qWBj0
 gQ/8NNtpAu8lkRbU5p6BBQg/Kib8epybao77A+8ODKW/JpsduTHn2CUX044EtFb7PzM2
 fbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792189199; x=1792793999;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g2RpCD6pPbG0jDZvBkn3q6Al3Jxnoi0KYgJ+ZRe5j8s=;
 b=dDEc2RdiY055DgLoY90Qzp32gzxMPtL7f6kHMzD3VRd2t/gtHwtj2127Pvq767X9qv
 PA9RBry+tS0nBlT+t7pD5xMBl4h06Gm+JWngd/9OBR/pCB03OyMVVFNPQkXTFG74xHrh
 PSHNbFC2hpRJjWtBRbPSdAI2Z/fWK6I03GtxcuDWZpJThGRixUeX1oLczzM/Ep09VAfb
 DpHqfGemvaku+ikVc/INBV/3LOByP262TBetXCuEpRP3Z3YMHpDbeZJiG71zGI/XvHib
 bW1Q/uhAfa4K+ac9LNtTjaHagk2invw57/fWhE3ZVTTZIVzSKjwrGd07vSKpFRLRnHgk
 q0qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsHZvoyv50+p7pXk8NhFxEhe+sbWY5fIUvwl2Mh7pZQqs9kejZo/jv3Rvm8VZbQe/5OddUBQcCJbw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL+EzFw9PI2VPn8c9KVYSTtafpVZ02JXv3ZXccAIeqzRBy74NeX
 gLtNYfGwVXim0XoUTBGqeWjBty13A6RMkM9L3Ay6kzLgP8oWqYU2xeuloYfwuCi4N4W/7E1L9NS
 iYUqrMjwhbm2xRWPtMMXueFC/d48WFgg=
X-Gm-Gg: AYBFou17IdR3iS7y7awgaHeh0uMOVCqmOiX9qBmqTpQji2W7XSRqUEg2k/XsXa0wVtL
 gwBLFtUMQXA8/mOesA8ANBgrDq5D01jzvbNOs4JfiiZVudVvw6JK09PynykcCfWWpi8IMCtPztf
 kwYqG1wm+dyPKSXz2N8QVjigZ/q2OkU2+lVmNOYx1vzapUktrQkV8oBnrpF08eAYe9SgbJJMOxp
 +Y3/7hVXUS2ExKxzJ+Psu6g7aYlznh9ee2Hy8GIHhbUCijdHlYIhe9sGxLbIHh9dq6gTSydyQSz
 Dlr5u5346mGdk9LroD1Sd68FpW0ACxwEbKX5zY3SZVZYAoDgznSrnx/NpOVIgtbgpIs5G0+Dgpr
 FytiGfGcSvl8bV7TLynbifh3j+Nr8XiaSOPcMTfko
X-Received: by 2002:a05:620a:8006:b0:93e:5de7:fd45 with SMTP id
 af79cd13be357-93f17efcb48mr754027485a.18.1792189198909; Fri, 16 Oct 2026
 15:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <2026092253-dimness-unethical-2515@gregkh>
 <20260922153334.136648-1-bub4z0r@gmail.com>
 <2026092320-reentry-lyricist-330b@gregkh>
 <32446a55-070d-4739-bd3a-d56c4b628e29@amd.com>
 <2026092332-alkaline-overthrow-494f@gregkh>
In-Reply-To: <2026092332-alkaline-overthrow-494f@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 17 Oct 2026 08:19:46 +1000
X-Gm-Features: AclHuK_7jePb0TrqT3zGoVqGEPf6lhbuQZGz5zOPfyLgS0sUKe6-z1rwyROI4cs
Message-ID: <CAPM=9tyVcUdb-wjv2unksLV-BVcOxswqB0Y+H7agBU5vYGFKDw@mail.gmail.com>
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Vadim Nikitushkin <bub4z0r@gmail.com>, stable@vger.kernel.org, 
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org, 
 skainsworth@gmail.com
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

So I got a report that

"the backport of "drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
swapout failure" to yesterday's 6.18 missed "drm/ttm: fix swapped-out
resources never leaving their bulk_move range",

So can we make sure this patch is in the stable branches the other one
went into?

Thanks,
Dave.

On Wed, 23 Sept 2026 at 20:51, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 23, 2026 at 09:53:54AM +0200, Christian K=C3=B6nig wrote:
> > Hi Greg,
> >
> > On 9/23/26 09:41, Greg KH wrote:
> > > On Tue, Sep 22, 2026 at 06:33:34PM +0300, Vadim Nikitushkin wrote:
> > >> commit 3db7d7d583419f7b1f2e141e36418802dbb25cf8 upstream.
> > >>
> > >> ttm_tt_swapout() returns the number of pages swapped out on success =
and
> > >> a negative error code on failure; for a populated ttm it never retur=
ns
> > >> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite L=
RU
> > >> walk on swapout failure") moved the bulk_move bookkeeping in
> > >> ttm_bo_swapout_cb() under "if (!ret)", so the
> > >> ttm_resource_del_bulk_move_unevictable() / ttm_resource_move_to_lru_=
tail()
> > >> pair is now skipped on every successful swapout. The equivalent chan=
ge
> > >> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix ttm_bo_shrink=
()
> > >> infinite LRU walk on backup failure") tests "lret > 0", which is wha=
t
> > >> was intended here as well.
> > >>
> > >> Before b2ed01e7ad3d the resource was taken off the bulk_move before =
the
> > >> swapout; since then a swapped-out resource stays inside its BO's
> > >> bulk_move range (and on the manager LRU) although it is unevictable.
> > >> When it is later freed or the BO leaves the bulk_move
> > >> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del())=
,
> > >> ttm_resource_del_bulk_move() skips it because of its
> > >> !ttm_resource_unevictable() guard, so a range endpoint in pos->first=
 /
> > >> pos->last is left pointing at freed memory. The next
> > >> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that cur=
sor
> > >> is a use-after-free, seen as the resv WARN in ttm_lru_bulk_move_add(=
),
> > >> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
> > >> dereference in ttm_resource_manager_next() -- minutes to hours after=
 a
> > >> hibernation, or at process exit / reboot following one. Samuel
> > >> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
> > >> dangling cursor; the missing removal at swapout time is the reason i=
t
> > >> dangles.
> > >>
> > >> Testing the condition for success restores the removal. On an AMD
> > >> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate =
on
> > >> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bu=
g
> > >> crashed 5 of 18 hibernation cycles; a function profile of one
> > >> hibernation showed 336 ttm_tt_swapout() calls and zero
> > >> ttm_resource_del_bulk_move_unevictable() calls. With this change the
> > >> removal happens for every swapped-out resource and 12 further cycles
> > >> were clean.
> > >>
> > >> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU wal=
k on swapout failure")
> > >> Cc: stable@vger.kernel.org # v7.1+
> > >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> > >> Link: https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-=
9p0tN4NuP8D_eSL+UJeevXw@mail.gmail.com/
> > >> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
> > >> Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com=
>
> > >> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >> Link: https://lore.kernel.org/r/20260909205028.13799-1-bub4z0r@gmail=
.com
> > >> [ Squashed with commit fcfe64715b425262af1b36f498f9197f3537ceed
> > >
> > > Do not squash, send a patch series instead please.
> >
> > in this particular case that squashing is the correct approach.
> >
> > AMDs mail servers mangled the initial patch so badly that I had trouble=
 applying it and ended up pushing a broken patch upstream. The squash is ba=
sically fixing that up.
>
> Ok, I'll take this then, thanks for the response.
>
> greg k-h
