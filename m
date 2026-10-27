Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6ipUS6S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5A8112057;
	Thu, 29 Oct 2026 07:59:13 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 814D610F595
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:11:03 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c423b145922so569645266b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793110262; cv=none;
 d=google.com; s=arc-20260327;
 b=S9HjCZdWNlefs/ke3mJC4YMdBnftJq8rlbiGmICETChHIkrmE/poofx7DxDHoWVERu
 h6jNGfdAWuv95Laz4G3q4jPLg0b4VCHGEFvQA7if+IAJt5sP967Pv01WHAjz/AjQoTBq
 M16+icV9Q+QTKYXO+fgA/D4MMRYUE46JgEhZ8p2o86P2KJ7EJIHUTdl+3QdShPxrnp1o
 Kr4WhmCyw1jqUx9XlRvrtWBMC9uhWdHfYuottVoe3JzGHkoX6VfjMnMgktsezPOgRvQE
 +R+SNpT/+UvOVNz6TUM5RJo7uU4OMuWV53Wi7vhJWuvNiO6fPbxoJ/HQPH0qOT0J1eK9
 LJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n3PsL6sMIPlUBnMX0/2Kvdyl0GgdzxTtG4W14Mwv2Jg=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=iX0d4XMh2WVQPUQcz2Xy4w1KrpCy6H8V0T/Qestwqhh94xH/sUS50kivVIjMSiuXO9
 pi9gDCOnjE8mQqVIO9krr1COiWqkBtTleHAjWTnSdjHB13UzqP/ZQW2XYZD0XbYpxY1+
 PLQ18fcHEfIFLi8u7v24I4me67/Y/FMA8/t13v5qnPsxCrbKC7YoAkqclNLZwJro205U
 c5hNDjrrRJVPlvLGLL6SbWMAzaDcSShSRaqG4e26nA03/lNrpJzrOclZ8onjuDeO0jWT
 Z2sjmcO0uP7kwFY31Dtc7KGrhfrceNlD/hUJx5T4HS7QmrNJWB1RN5aToTn0xXFOehmJ
 4b7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793110262; x=1793715062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n3PsL6sMIPlUBnMX0/2Kvdyl0GgdzxTtG4W14Mwv2Jg=;
 b=m6ipUS6S5669SzQkJNdvReBs3flUa0DPZt6BdnSmAREF2TVDXhdVGHM+k+zIsR79fe
 ZfuNYVqU7IdAgokF2Xln62ZJZqNJb3TzZzEadfBJ4hTCHaVanRLLd4Q1LEXdsfSRNAyx
 HnzjTEKQsApc6y2JKJyRJpdBBuxjvYeXvITTSllAiUX3ocVEI301csqy5UBH7s/W6qvo
 /aZAPcG/nGOAX7Oxv5hxOBIyObPRpCSYl5a9NumY16ucr4BoysS+2hfzZ5F5VFPONKQ+
 wopS2dv8li0uHQQYWHzEUWpKyzs/LCBTLQs1NUhi+ChEJfcPyVXJDOU852GrkCMXdWEB
 ONcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793110262; x=1793715062;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n3PsL6sMIPlUBnMX0/2Kvdyl0GgdzxTtG4W14Mwv2Jg=;
 b=mucUSHFCWKhJuuZhL8+Rfg5dAloISmSS1Afo2Pr+25J2cyXsScijAtvLqj+sI/1f/4
 dd6D10xCZ0/qx75NvG3TBlxJIIb5B1tnFsBk8yRCsckk+5Xcw4tTm71NVaz9ltY5aOPO
 bqMrVKBwd7OEB85aFlxt0GTEeMdNB5X0P2+HkCtqXjsBHljTy1obaZucJQlDRHQ9bDk3
 1JrWc3UCe5w9CIh08RLF10bccaxmMaELjC8pquCOCQl9mqcaulshQF6gk6IQYhGPv/My
 ZRNd5iSb8reSz0RoNNM0gI+D7ByAnoc90bEvjxSBpGSkxPPHiipJGX7WiUJnyjJUSt1M
 loFQ==
X-Gm-Message-State: AFq9FYKfRHQxtH8tTaFYuij0R3HpWfK2NLkuUTScx/kk7vXmGuw1j6uP
 Wjmh59nCzFIIH8vrryiLOMDqgjyTg7idEzsaYUbhQqstoN7Ajr+NgeZ8EJdIOrghzxs6ZTkGiyI
 sK9isARLiFSVycnvO24m0pSheqvGOUqCOEIDFdnY=
X-Gm-Gg: AYBFou0S+pogEp7Kp3l9XW0NJW7JMcyjj7JKldoZy2F0kwJm+JQjVRbObe7zldVE1n+
 xpBm4SUYsvY6IU1XbDXFuG2gmobtPnUo5H67yC6lzFiLIv6J1jLAf62YbDXAVNQBKjBRhasyjyd
 BYpLzfrRUnrgjz/JnX7n0xC+Al2I9JFNAD3L/ELrcJgGLLNijTKLu0S2T+65SQHVVfxusKPuIO4
 xsUNqkT20TSyO28MXe8aBw0V1IKqX22m9j+bRdSiH7j1EOQSb1sG8S8B/MiP88tNt+GzsS1ngEW
 7Gn88LabAGQpfUc91EC0P+trL/vALrZ3ukmYnQgF8vnIKMyWcYAk6VfzWJuKfEAtbolKPn5UY9i
 +/J0Gesph/g8I6rIGrxDacIgUeq2A52OeQqeKxH3GelZ/WbSDCWKzNm/VRwp3n93SZ0iFQSRPtX
 pMbOAOoAWBNnfyBchMK+Gu6b/+7/riu/DWG/aTKlnDH9kEaf0=
X-Received: by 2002:a17:906:7312:b0:c2e:46d0:b802 with SMTP id
 a640c23a62f3a-c46bde8c7d8mr1100681666b.40.1793110261730; Tue, 27 Oct 2026
 07:11:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-freesync-plane-reset-time-v1-0-bb43b501faf4@gmail.com>
 <20261027-freesync-plane-reset-time-v1-1-bb43b501faf4@gmail.com>
 <sashiko-outbox-186669@kernel.org>
In-Reply-To: <sashiko-outbox-186669@kernel.org>
From: David Hughes <davidralphhughes@gmail.com>
Date: Tue, 27 Oct 2026 07:10:50 -0700
X-Gm-Features: AclHuK84VcnEHW0gEAXZMPCvk5KE1zhDcnRTYDp8drZma-PfQxzbTYJcvshBpzg
Message-ID: <CAO0OR0kGAKNHOaPqQu-O3HfnaQ23Zt+8FiEUtO2uVhNpoGkkiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Keep FreeSync flip timing across
 plane resets
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Can copying dm_old_plane_state->dc_state->time here in dm_update_plane_st=
ate()
> race with an in-flight non-blocking commit or copy stale flip timestamps?

Yes. The copy in atomic check can read the old DC plane's flip timing
while the previous commit is still waiting on fences or writing it in
copy_surface_update_to_plane(). FreeSync only reads
prev_update_time_in_us, so a stale copy usually costs one frame timed
across two flips, and at worst falls back to the behaviour without this
patch. It is still a data race, though.

v2 moves the copy to amdgpu_dm_commit_planes(), before the preflip.
commit_tail() has already waited for the previous commit there
(drm_atomic_helper_wait_for_dependencies()), so the old plane has been
programmed and nothing else writes it, and the copy doesn't need
dm->dc_lock. I'm building and testing it right now.


On Tue, Oct 27, 2026 at 6:52=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] drm/amd/display: race and stale flip time copy in dm_update_pl=
ane_state()
> --
>
> commit ab38a8475d9a38b0920f07d4b8cd8a1171060e9b
> Author: Davey Hughes <davidralphhughes@gmail.com>
>
> drm/amd/display: Keep FreeSync flip timing across plane resets
>
> This commit preserves the DC plane flip timing across plane resets when t=
he
> plane remains on the same CRTC, preventing FreeSync below-the-range (BTR)=
 or
> fixed-refresh paths from seeing a zeroed flip history on color management
> updates.
>
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index bdabb4bf14dab..a69e28685857f 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6076,6 +6076,11 @@ dm_update_plane_state(struct dc *dc,
> >                       goto out;
> >               }
> >
> > +             /* FreeSync times each frame from the plane's previous fl=
ip. */
> > +             if (dm_old_plane_state->dc_state &&
> > +                 old_plane_crtc =3D=3D new_plane_crtc)
> > +                     dc_new_plane_state->time =3D dm_old_plane_state->=
dc_state->time;
>
> [Severity: Medium]
> Can copying dm_old_plane_state->dc_state->time here in dm_update_plane_st=
ate()
> race with an in-flight non-blocking commit or copy stale flip timestamps?
>
> When userspace submits a non-blocking commit (Commit 1),
> drm_atomic_helper_swap_state() installs Commit 1's plane state into
> plane->state and queues commit_work before dropping drm_modeset_locks.
>
> Commit 1's worker then runs asynchronously without holding drm_modeset_lo=
cks:
>
>   amdgpu_dm_atomic_commit_tail()
>     -> amdgpu_dm_commit_planes()
>       -> drm_atomic_helper_wait_for_fences()
>       -> mutex_lock(&dm->dc_lock)
>       -> update_planes_and_stream_adapter()
>         -> dc_update_planes_and_stream()
>           -> update_planes_and_stream_state()
>             -> copy_surface_update_to_plane()
>
> In drivers/gpu/drm/amd/display/dc/core/dc.c:copy_surface_update_to_plane(=
),
> DC mutates surface->time under dm->dc_lock:
>
>         surface->time.time_elapsed_in_us[surface->time.index] =3D
>                 (unsigned int)(srf_update->flip_addr->flip_timestamp_in_u=
s -
>                         surface->time.prev_update_time_in_us);
>         surface->time.prev_update_time_in_us =3D
>                 (unsigned int)srf_update->flip_addr->flip_timestamp_in_us=
;
>         surface->time.index++;
>         if (surface->time.index >=3D DC_PLANE_UPDATE_TIMES_MAX)
>                 surface->time.index =3D 0;
>
> If a second commit (Commit 2) that resets the plane enters
> amdgpu_dm_atomic_check() while Commit 1's commit_work is still waiting on
> fences or executing copy_surface_update_to_plane(), amdgpu_dm_atomic_chec=
k()
> calls dm_update_plane_state() before calling do_aquire_global_lock():
>
>   amdgpu_dm_atomic_check() {
>       ...
>       for_each_oldnew_plane_in_descending_zpos(...) {
>           ret =3D dm_update_plane_state(dc, state, plane,
>                                       old_plane_state,
>                                       new_plane_state,
>                                       true,
>                                       &needs_dc_state_realloc,
>                                       &is_top_most_overlay);
>           ...
>       }
>       ...
>       if (needs_dc_state_realloc) {
>           ...
>           ret =3D do_aquire_global_lock(dev, state);
>       }
>   }
>
> Because dm_update_plane_state() reads dm_old_plane_state->dc_state->time
> without holding dm->dc_lock and before do_aquire_global_lock() waits for
> Commit 1's hw_done and flip_done:
>
> 1. If Commit 1 is currently in copy_surface_update_to_plane(), the unlock=
ed
>    struct assignment races with the writes to surface->time.
> 2. If Commit 1 is still waiting on fences before acquiring dm->dc_lock,
>    dm_update_plane_state() snapshots the pre-Commit-1 flip time (which is=
 all
>    zeroes if Commit 1 also reset or enabled the plane, or Commit 0's time=
stamp
>    otherwise). Then do_aquire_global_lock() blocks until Commit 1 finishe=
s
>    updating dm_old_plane_state->dc_state->time and signals flip_done, all=
owing
>    even a non-blocking Commit 2 to pass stall_checks() in
>    drm_atomic_helper_setup_commit() and commit with the stale dc_new_plan=
e_state->time.
>
> Would it be safer to copy or update the flip timing in commit_tail (for
> example inside amdgpu_dm_commit_planes() under dm->dc_lock after the prev=
ious
> commit has completed), or after synchronizing with the previous commit?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-freesync=
-plane-reset-time-v1-0-bb43b501faf4@gmail.com?part=3D1
