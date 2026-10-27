Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E0606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtCYy4YC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F5710F54D;
	Tue, 27 Oct 2026 13:52:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D40A10F558
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:52:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9F4F43250;
 Tue, 27 Oct 2026 13:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17F21F031E1;
 Tue, 27 Oct 2026 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793109122;
 bh=+eNsy5l3T92AvOMKs4cBhRYlEoTtdEVq4bpNZqdJHuI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mtCYy4YC7zVSpdK880/ukycTYHrsiV4fBTj/Mie+5TyIc7pbBe3dpPp7gsXaVE+zo
 J7JQJcbUolzdMhMF3OI4tkr3p5CUQchoC+1rS024Ed5mL3p8ZegZEE2v5goByEuMxN
 brCpz/7rTgCU7XW8CAIT+Mon0E07Fgll7u4qLdJrJdqj4B/xZE8Fkg4jUihtSwwdP3
 03/NTfpjarqxr4eU+YDc2Q5Rig8Pb/8Tun3G8pitXg6yFi+GNSo5SYRDxB6RgJX7Ma
 JZ+M80MYRmQHD5DRpAfSpQSY3Wx3s9iIsuzX9yV/5MI57svMWI/Xi4XiHtptWXmMrw
 h/9aPJmlMlUKQ==
Message-ID: <sashiko-outbox-186669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: Keep FreeSync flip timing across
 plane resets
To: "Davey Hughes" <davidralphhughes@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027-freesync-plane-reset-time-v1-1-bb43b501faf4@gmail.com>
References: <20261027-freesync-plane-reset-time-v1-0-bb43b501faf4@gmail.com>
 <20261027-freesync-plane-reset-time-v1-1-bb43b501faf4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:52:02 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amd/display: race and stale flip time copy in dm_update_plan=
e_state()
--

commit ab38a8475d9a38b0920f07d4b8cd8a1171060e9b
Author: Davey Hughes <davidralphhughes@gmail.com>

drm/amd/display: Keep FreeSync flip timing across plane resets

This commit preserves the DC plane flip timing across plane resets when the
plane remains on the same CRTC, preventing FreeSync below-the-range (BTR) or
fixed-refresh paths from seeing a zeroed flip history on color management
updates.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bdabb4bf14dab..a69e28685857f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6076,6 +6076,11 @@ dm_update_plane_state(struct dc *dc,
>  			goto out;
>  		}
> =20
> +		/* FreeSync times each frame from the plane's previous flip. */
> +		if (dm_old_plane_state->dc_state &&
> +		    old_plane_crtc =3D=3D new_plane_crtc)
> +			dc_new_plane_state->time =3D dm_old_plane_state->dc_state->time;

[Severity: Medium]
Can copying dm_old_plane_state->dc_state->time here in dm_update_plane_stat=
e()
race with an in-flight non-blocking commit or copy stale flip timestamps?

When userspace submits a non-blocking commit (Commit 1),
drm_atomic_helper_swap_state() installs Commit 1's plane state into
plane->state and queues commit_work before dropping drm_modeset_locks.

Commit 1's worker then runs asynchronously without holding drm_modeset_lock=
s:

  amdgpu_dm_atomic_commit_tail()
    -> amdgpu_dm_commit_planes()
      -> drm_atomic_helper_wait_for_fences()
      -> mutex_lock(&dm->dc_lock)
      -> update_planes_and_stream_adapter()
        -> dc_update_planes_and_stream()
          -> update_planes_and_stream_state()
            -> copy_surface_update_to_plane()

In drivers/gpu/drm/amd/display/dc/core/dc.c:copy_surface_update_to_plane(),
DC mutates surface->time under dm->dc_lock:

	surface->time.time_elapsed_in_us[surface->time.index] =3D
		(unsigned int)(srf_update->flip_addr->flip_timestamp_in_us -
			surface->time.prev_update_time_in_us);
	surface->time.prev_update_time_in_us =3D
		(unsigned int)srf_update->flip_addr->flip_timestamp_in_us;
	surface->time.index++;
	if (surface->time.index >=3D DC_PLANE_UPDATE_TIMES_MAX)
		surface->time.index =3D 0;

If a second commit (Commit 2) that resets the plane enters
amdgpu_dm_atomic_check() while Commit 1's commit_work is still waiting on
fences or executing copy_surface_update_to_plane(), amdgpu_dm_atomic_check()
calls dm_update_plane_state() before calling do_aquire_global_lock():

  amdgpu_dm_atomic_check() {
      ...
      for_each_oldnew_plane_in_descending_zpos(...) {
          ret =3D dm_update_plane_state(dc, state, plane,
                                      old_plane_state,
                                      new_plane_state,
                                      true,
                                      &needs_dc_state_realloc,
                                      &is_top_most_overlay);
          ...
      }
      ...
      if (needs_dc_state_realloc) {
          ...
          ret =3D do_aquire_global_lock(dev, state);
      }
  }

Because dm_update_plane_state() reads dm_old_plane_state->dc_state->time
without holding dm->dc_lock and before do_aquire_global_lock() waits for
Commit 1's hw_done and flip_done:

1. If Commit 1 is currently in copy_surface_update_to_plane(), the unlocked
   struct assignment races with the writes to surface->time.
2. If Commit 1 is still waiting on fences before acquiring dm->dc_lock,
   dm_update_plane_state() snapshots the pre-Commit-1 flip time (which is a=
ll
   zeroes if Commit 1 also reset or enabled the plane, or Commit 0's timest=
amp
   otherwise). Then do_aquire_global_lock() blocks until Commit 1 finishes
   updating dm_old_plane_state->dc_state->time and signals flip_done, allow=
ing
   even a non-blocking Commit 2 to pass stall_checks() in
   drm_atomic_helper_setup_commit() and commit with the stale dc_new_plane_=
state->time.

Would it be safer to copy or update the flip timing in commit_tail (for
example inside amdgpu_dm_commit_planes() under dm->dc_lock after the previo=
us
commit has completed), or after synchronizing with the previous commit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-freesync-p=
lane-reset-time-v1-0-bb43b501faf4@gmail.com?part=3D1
