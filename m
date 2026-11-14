Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C720606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SawnGC/s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE2710ED0C;
	Sat, 14 Nov 2026 02:02:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED7C10ECFE;
 Sat, 14 Nov 2026 02:02:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D641740AA4;
 Sat, 14 Nov 2026 02:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870931F000C4;
 Sat, 14 Nov 2026 02:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794621766;
 bh=/DAXMH/Xlsgy1PzaYwQSHGmCTzCBvTt0IXXJ5Hk5Yec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SawnGC/szUbaGxjN6TnzEF9x444/N0/4LO2uGs7QkA4DQ0C5suI6C01vrVDLblXHF
 +VLakOKiU+8G29RrzPEoEvWw9chCwZHC6xF5xAjpbfGBJwHGN37m/jLmPhjVx384ZE
 vhIidoKKOPUEeLKyhXHJMc3+8eEJBSmWXiP1qC09TwOzkS9Yfmh3TWG1piNL/zNlWt
 uQQuqVHHlFPatH0Sfnopc77KTw51xO+P24KO7eMQWv/hcuV7S1jfZW59qsN4Pu+w9u
 NdBHJpy/dQAp8DpMyhhpkIiHTmIWvmAhL7SOt7dEwe+Wdv1baykMWTS3B+cXgRCaW6
 CTOetkKmMbgXg==
Message-ID: <sashiko-outbox-214037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] drm/i915: Arm joined pipes within one vblank
 evasion for VRR
To: ElXreno <elxreno@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114014335.2132756-6-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
 <20261114014335.2132756-6-elxreno@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 02:02:46 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915: Signed-off-by trailer uses handle ElXreno instead of
  real name
--

commit fc87993e7c0d725b8ec9527a36ed996a89438f35
Author: ElXreno <elxreno@gmail.com>

> drm/i915: Arm joined pipes within one vblank evasion for VRR
>
> All joined pipes run off the transcoder of the primary, so one vblank
> latches every one of them. On the MMIO path each pipe nevertheless
> goes through its own intel_pipe_update_start()/intel_pipe_update_end()
> critical section, one pipe after another. When the vblank falls
> between two of them the earlier pipe latches its new state a frame
> ahead of the later one, and for that frame the halves of the screen
> come from different frames.
>
> With VRR that gets worse, as the commit ends the frame itself: the
> push at the end of the primary's section latches whatever has been
> armed by then. Commit the joined pipes together when VRR is in use:
> do the vblank evasion once, on the primary, arm all of them inside
> that critical section and let the primary send the push at its end.
> The evasion accounting, the trace events and the atomic update
> failure check then run once as well, for the primary.
>
> Armed this way the critical section takes 15 us on average for two
> pipes on Arrow Lake (71983 commits at 240 fps: 71918 under 30 us, 16
> between 30 and 60 us, 49 between 60 and 188 us), against the 100 us
> the evasion allows for. The window is not scaled with the number of
> pipes. The 49 are single MMIO writes that stall, not more work: the
> instruction count is that of an ordinary section, the CPU stays in
> C0, there is no SMI or NMI, and the register differs from case to
> case. The per pipe sections of the same mode without VRR and with
> the DSB turned off show the same stalls (15 of 72002 sections over
> 60 us), so they do not come from arming two pipes in one section.
> None of them ran into a vblank.
>
> The per pipe sequence is kept where the critical section has per
> pipe work attached or the pipes need sequencing against others:
> modesets, the atomic fallback of a legacy cursor update, async flips,
> commits that need the vblank worker for the LUT load and commits that
> change the DDB allocation of a joined pipe. The vblank worker is
> needed on the platforms without double buffered LUTs, when a colour
> update or a fastset has LUTs to load that can neither be preloaded
> nor be left to a colour DSB. Commits that go through the DSB or the
> flip queue are not affected, and neither is the commit sequence of a
> joined configuration without VRR. The latter has the same race
> against the fixed vblank, it is left alone only to keep this change
> to the case that can be tested with it.
>
> On the platforms with double buffered LUTs there is no vblank worker.
> Where no colour DSB is used the LUTs are loaded with MMIO inside the
> critical section, which here is the joined one and then loads them
> for all joined pipes. I have no such hardware and have not tested
> that.
>
> No functional change yet, VRR is not allowed with the joiner.
>
> Signed-off-by: ElXreno <elxreno@gmail.com>

[Severity: High]
The Author field and Signed-off-by trailer use a single-word handle
(ElXreno) instead of a real full name.  Per
Documentation/process/submitting-patches.rst, patches must be signed off
using a known identity and real full name rather than a pseudonym or
handle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114014335.2132=
756-1-elxreno@gmail.com?part=3D5
