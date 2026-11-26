Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B4606A6BE
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9Lx+Nck
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8252F10E212;
	Thu, 26 Nov 2026 09:37:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE91810E242
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6A62464F2;
 Thu, 26 Nov 2026 09:37:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685843;
 b=tsop6MANav5izDO5qRcZWOGNwSf6ot0H/sddrwjXhfTuOwDmK1HI+tRg8DLtleF48oEE
 OwZ2OJLKWl7IX5O1N4OyGdiYHuFKOxdtX5991OEVwg8XVlmZryaKVffl97dMqefhyYH8U
 N9Llv5x0Dzrx51okMihlShgHossWepsNs9OYGihlOrSHWAM4sqgaabCRkL0lk9xg21CAk
 cxWLhbv3mypP3PXlYbpmbT1BuJxlZ816wvqaWEALk4ItOIaChywvcxPZfC8UhGif+GXoc
 g2r3n/VZqvq03Xh0g0R9IXNDO0or7iirEC1vDTkoLWDI/aYmOokP5MezItjOERcL/+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685843;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=a/vyWyZs+bXF4Eo60VswsLWu4yvF9aNznJJqFBcKWcQ=;
 b=lKINTYuAlIr1upKkBQ7UqLofJotnaUpLwn1Vq6/DkZcN4CNnw9Uc/1DPmqZj3x785hQ0
 EMkMc9NRjO3Arb1sr/zdrksWh0zEQjW5bqnY2/YZQItDk++HxspqV+8GC6FhA+OFVVaRW
 +E9d5gEcBeLFVILZ5yxxVDb5CpPs6QUNKUDnGzAyaf+OlrZdF5ztT2VLf7NIs92StpLZI
 4QjGNouB0jar9WbuQlcw2ZmchpBEuksMyJyOPazNDvdlYCaT/rjYkQnb/uCOzX/AK83v2
 Fd6LqDx6b5J+YfIkqxFubaovmx3ta3CD7SZEx7AGIs35gY7sQFErVj9JLOWs8DppY/w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D43FD1F0283B;
 Thu, 26 Nov 2026 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685843;
 bh=a/vyWyZs+bXF4Eo60VswsLWu4yvF9aNznJJqFBcKWcQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=g9Lx+Nck1YFJOOM+B/3/Q54gT5Gyu0spYXyOISbhI0qT0ZvtmF0NBhzDKJC8tNQMU
 as0lGIYktRLRML/IP3pCxEL0hfVxbizqrhOuE3K8GNLX9SmjW0jdgDswaOlRzer9y+
 1fbcLWaR/luPxzi3yqannJidOWevw6zJfGgqSnHb6ua/p8FMgbonWJi/+kSl8k3oHm
 VkxaDIj+BGqH/Aol42Go78kNXoqHlhbraHHpurOIc5AkmOZpoYgSXbxPTPNeMDiM0d
 flP3ptF8m70JgoXxba6jMgQVfTmLbyfTAwvxKhDQ+OKJBJj6bTAe9d4teYngQyH/WB
 zhzjrfjfSetHg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 257DA4D365;
 Thu, 26 Nov 2026 09:36:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v4 00/17] drm/panfrost: Resume long jobs instead of
 resetting, and mapping error path fixes
Date: Thu, 26 Nov 2026 09:36:43 +0000
Message-Id: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBQE4KuQrq3pD0Jx5T2Miwd9QAlQ0iLRE
 O5uwQ0xxOUkM9/MxKMz6Mk1monDyXhj+xDiU0SKGvoKqdEhE8FEwjlndIC+dNaPtLV9RRube8q
 TWAqVgoCCkzAcHJbmtaH3xzf7Z95gMa7S2qiNH617b68TX3t/DyZOGRXxhalMZoBK36oOTHsub
 EfWg0nsCXFIiEAAS5RkGqTOsl9C7gl5SMhAKAaYKi1VmeCeWJblA6u4phVMAQAA
X-Change-ID: 20261110-panfrost-long-jobs-1643287a2ac1
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=3740;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=MuMFK5jO5fKWatEuOQyDpCntuKMcI66DhXJph8CZWSY=;
 b=awhPy25Y6qlxTk2fZxxx9dZqagO3/tHmG4IOvwA0b204D6qCaV/GFNaoF0wvJht+83hbSPvJL
 mPa0pN9iZz0Avsq/Dw8+vNbrFaTCtFopVeinB3fl9L0d+BCkldxMEmM
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes for problems found running the GLES, Vulkan and OpenCL
conformance tests with Mesa on a Mali-G31 (Allwinner H616), and for
problems Sashiko found around them:
- 1-4, 14, 15: reset and timeout paths vs power management, heap BO
  cache sync, a mapping being freed.
- 5-8: BO mapping error paths.
- 9-13: races around panfrost_reset().
- 16: soft-stop and resume a job still active at the timeout.
- 17: name the BOs around an unhandled page fault.

Open points: a job that keeps reaching task boundaries is never killed;
stopping a long job holds all slots (here at most 349 ms); 16 can go
separately.

Tested on v7.3 with Mesa 26.2: no regressions in 1196 dEQP/KHR cases
and 9 OpenCL CTS groups. 2-4 and 9-12 were not reproduced.

Developed with Claude (Anthropic) as coding assistant (investigation,
code, commit messages); I reviewed them and ran the tests.

---
Changes in v4:
- New patches 1, 14 and 15 (Sashiko on v3). Patch 2 clears
  reset.pending in runtime resume and leaves system sleep to patch 1.
- Shorter commit messages and comments; test results in 1, 6, 7, 14
  and 15.
- Renumbered: v3 1-12 are now 2-13, v3 13 and 14 are now 16 and 17.
- Rebased onto the current drm-misc-next.
- Link to v3: https://patch.msgid.link/20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com

Changes in v3:
- Patch 1: disable the reset work across system sleep (Sashiko).
- New patches 7, 10 and 11 (Sashiko); shorter messages and comments.
- Renumbered and rebased onto the current drm-misc-next.
- Link to v2: https://patch.msgid.link/20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com

Changes in v2:
- New patches 1-3, 7 and 8 for Sashiko's findings on v1.
- Patches 6, 10 and 11 reworked and v1 4/7 dropped after Sashiko's review.
- Renumbered and rebased onto the current drm-misc-next.
- Link to v1: https://lore.kernel.org/r/20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com

---
Arun Iyengar (17):
      drm/panfrost: Freeze the reset workqueue during system sleep
      drm/panfrost: Power the GPU up for a reset queued from the MMU code
      drm/panfrost: Refuse to sync the CPU caches of a heap BO
      drm/panfrost: Don't take a reference on a mapping that is being freed
      drm/panfrost: Don't WARN when a GEM mapping cannot get its pages
      drm/panfrost: Unwind a failed GPU mapping without dropping its pages
      drm/panfrost: Give back the pages of a heap chunk that failed to map
      drm/panfrost: Don't WARN for a heap folio a neighbouring chunk filled
      drm/panfrost: Don't signal a job cancelled from _NEXT at a reset as done
      drm/panfrost: Don't cancel a job that completed during a reset
      drm/panfrost: Drop the cycle counter only for a job that holds it
      drm/panfrost: Don't take a job that was never started for done
      drm/panfrost: Wait for the soft-stopped slots with the live slot status
      drm/panfrost: Keep the GPU powered in the job timeout handler
      drm/panfrost: Keep the job interrupts masked during a reset
      drm/panfrost: Soft-stop and resume a job that outlives the timeout
      drm/panfrost: Name the BOs around an unhandled page fault

 drivers/gpu/drm/panfrost/panfrost_device.c |   1 +
 drivers/gpu/drm/panfrost/panfrost_gem.c    |   3 +
 drivers/gpu/drm/panfrost/panfrost_job.c    | 254 ++++++++++++++++++++++-------
 drivers/gpu/drm/panfrost/panfrost_job.h    |   3 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 145 ++++++++++++++--
 5 files changed, 333 insertions(+), 73 deletions(-)
---
base-commit: 8a6e49c8557d3ba0fe4c7f1cb7f428289b13bfed
change-id: 20261110-panfrost-long-jobs-1643287a2ac1

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


