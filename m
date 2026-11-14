Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB64606A8A1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQhVQxNK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E1510E027;
	Sat, 14 Nov 2026 23:09:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3505910E027;
 Sat, 14 Nov 2026 23:09:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4FBA404C4;
 Sat, 14 Nov 2026 23:09:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794697755;
 b=Uh90h/f4a8KHHE87P4ViZ17yvwOwMXh5e9pCXklgxk471fiPr8lB/kvzL8cKppAbQiOf
 MttOClIsskvm0IC/nnhe1S4+9BNy/wrtuQOjLHs7wm421PvM1TaYoC9tXUPLIlC9UwtLH
 tydv9uCLPUlTFCZg6uKllfx2KTAbobSLSfsLIa+prWZLSuhm8TtklduhEG1Y8gUTGgtzG
 fQeJLNAw/4J11Hif6VTaZ6VOjYl3/tl4x6WuIw0q5M4RiZT2ht8tA6nVCO4z+vNligIRE
 b/Tikpt0rn2+I4uvK515bZDz0BwghlEvUbJ6tpFy+XUTjXj+KPfTpZSR1Qa/439TvUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794697755;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=1PTPiOEKRlp9Zsw9ftcdqrl7XVRQXVPvWk2EJN7ugKQ=;
 b=2VYzhItxzBeG8B+6VMzXrdV2on0NVdKbNbYiSfJZPCLP5r3aj3usM7fLRpqjzGYAGN+R
 E8wDTsPGkImBWKhWby8EMK8qM26EvDQuBN3pLk2+Lxhp3QHVI2y6Qlf127e0ASK95ApO8
 /LClrjavN719iFKbgnoluT8L/EOixLU0EWwno5C1oLQD60r8zN9bSRXTzyNV3oNyhbo7y
 kPQbbThKhDL8jrMMX5sYvrd+05NDVAJAZekc5C2IAvxMpo4MXI9gq3trPLanDYrodISA9
 4idU4LlVoTUQB/0BrdHMvj5cPmtHZwStNmzYNcnWIyIR5HA8CGL2tw+Vwax1W10R8PA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 75E231F000C5;
 Sat, 14 Nov 2026 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794697755;
 bh=1PTPiOEKRlp9Zsw9ftcdqrl7XVRQXVPvWk2EJN7ugKQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=YQhVQxNK/56nTI3fAqmt39i0g/j7zkCdwv5/uKuD3leTAknrDxNdCnnbh3uYuHgpl
 1q/a9Tls3Gj7neYytWoVm90r4zHjAqNyRjqEX15ezrOFe1j+sPYQ3sTNHNDfXRjqUw
 OsneOj2U9R7EkBjgWL/TFHtWOM5ReEi7uKn7PHRAUxQ6nZIYkBrhEveOf50WXJvjAY
 n1fJY+12vpKBTq+GuIxJyjfK609KF3O4t/p8OJUuVOjweqUSb+5vxahedNgb7jT0RG
 JB5T4yVWIBk4boEXzmq76d2/cRVk0uYbVg2UYGzEfZgIpE6yecQMXTY5DwfThv2pkG
 Uk/Pi8r2R+6hw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CC97049EBB;
 Sat, 14 Nov 2026 23:09:13 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Subject: [PATCH 0/8] drm/amd/display: Copy probed modes for atomic_check
Date: Sat, 14 Nov 2026 23:09:11 +0000
Message-Id: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDtg/MerlC4mZtQRNJJppCDev
 Wldfov3TlAOwgp9dkLgQ1T8lmAeGQwzbROjuGQo8qIxJq+QVjftEVfvWHH0MWDdErGrSrKmg9T
 tgUf5/J/P122NduHh/RvBdX0BTEQDDnUAAAA=
X-Change-ID: 20261104-amdgpu-modes-four-57aaed43ab18
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ray Wu <ray.wu@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3829; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=+dDISwyisNdvJwt3B/p7Y642cJGXY2iQt7K7XzoHftQ=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn68kmCebrPd1v+MlmhdJK9C9cNofplHL//ExW1I/
 Oh7f3sc++aOUhYGMS4GWTFFFt0bngwsEyfPzCl6vgRmDisTyBAGLk4BmIhFKcM/1ZeTGH7/71+9
 UH7ePY/pk3piq4KStp/9+FTJOH9BVeUXLkaGTb9/NDnrRh5j+r9X9UJEbqmhN7uCX/CJt12nD8V
 VK/1mBgBfp0ul
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
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
Reply-To: hugo@hsal.es
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mode_config.mutex protects connector->modes, but amdgpu_dm walks it from
atomic_check, in create_stream_for_sink() and
amdgpu_dm_get_highest_refresh_rate_mode(), without that mutex.
atomic_check can't take the mutex because of lock ordering. An earlier
patch I submitted moved the probe helper's sort under the modeset locks
so this walk couldn't race it, and Ville pointed out that the bug is in
the reader:
https://lore.kernel.org/r/auh8pUx_kXUYSdZ8@intel.com

atomic_check only needs the preferred mode and the highest refresh rate
mode. This series copies both at the end of each probe, under
mode_config.mutex and connection_mutex, and atomic_check reads the
copies under connection_mutex. The highest refresh rate copy is the mode
add_fs_modes() built the FreeSync video modes from, as upstream's cached
freesync_vid_base is. It's done this way because a search of
connector->modes at the end of the probe could pick a command line mode
with a higher refresh rate, and amdgpu_dm_is_freesync_video_mode() would
then reject the video modes

The copies also need work to stay current after a monitor swap. Until
the next probe they still describe the previous monitor, as
connector->modes could, and two paths read them before that probe.
mode_valid runs before the probe refreshes them, and after a swap the
HPD handlers commit before the next probe. Patch 3 has mode_valid
validate each mode with its own timing, so it no longer needs the
preferred mode. Patch 4 records the EDID of the sink the copies came
from, and patch 7 uses them only for a sink with that EDID. atomic_check
checks them against the sink of the stream it builds, since a hotplug
can swap dc_sink under it. With another sink, atomic_check uses the
requested mode's own timing until the next probe, as before the first
probe

Patch 1 drops a debug check that walked probed_modes and
connector->modes from atomic_check, and asks its author below the cut
whether to keep it behind mutex_trylock() instead. Patch 2 stops
add_fs_modes() matching against connector->modes, which dropped the
FreeSync video modes on every second probe. Patch 4 adds the copies,
patches 5 and 6 pass the sink of the stream being built to the code that
checks them, patch 7 switches the readers to them, and patch 8 adds
tests for the copies

Patch 6 also changes one behaviour, only with amdgpu.freesync_video=1,
which is off by default. A CRTC turned on straight into a FreeSync video
mode now gets its fixed refresh config, which it never got before

---
Hugo Sales (8):
      drm/amd/display: Drop the unadvertised mode check
      drm/amd/display: Don't match FreeSync video modes against the last probe
      drm/amd/display: Validate modes with their own timing
      drm/amd/display: Copy the preferred and highest refresh modes after probe
      drm/amd/display: Pass the sink to the FreeSync and stream timing helpers
      drm/amd/display: Pick the FreeSync video config for the new stream's sink
      drm/amd/display: Stop reading connector->modes from atomic_check
      drm/amd/display: Add KUnit tests for the mode copies

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   38 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   23 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  499 +++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 1209 +++++++++++++++++---
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  153 +++
 7 files changed, 1644 insertions(+), 293 deletions(-)
---
base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
change-id: 20261104-amdgpu-modes-four-57aaed43ab18

Best regards,
--  
Hugo Sales <hugo@hsal.es>


