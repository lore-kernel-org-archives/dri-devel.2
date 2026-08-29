Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26ACC61DD9
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 15:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39E810E0AD;
	Sat, 29 Aug 2026 15:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I38/rcs6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D183F10E0AD
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 15:54:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4EC6C600AA
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 15:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00560C2BCB9
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788018855;
 bh=mE4dqN/EF0FBsINaGZNj98ikXGigU5bc2d0e03vj8EQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=I38/rcs65+aYvV4UGVnjmeDik851x2x74eU5Q0Pd3hzxIgARMCKyjKv0HhJlajgkI
 EBaA4HqSxrbuLe0AC+AqPo4b1MvguXuQnL9SqJp3nMYPBe1nqe84EGCDyWd8PGv0gf
 Go6LMu4c2OySLUlxfW5YGhIE4nts1dvLjLMfWXAKtS1tuxjjOO3ZC02Scc36ryUQNm
 VQCsKhGiNC8fd2Zd5ORaQcu3/6OMz8LGmWefmqL0IsqGx0aHxOvQLvWyrd8u1MiWoH
 nwCoizkwq+hROeBzDfXKr0FFoGoDA2DYOay/tVUXOVU8uvURzmEORiLXpVNRPjRjrM
 91504L/oCz48Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D929EC4160E; Sat, 29 Aug 2026 15:54:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221040] AMD Ryzen 5700G (Renoir/Cezanne): Second suspend hangs
 after "PM: suspend entry (deep)" - xhci_hcd and asus_wmi LPS0 involvement
Date: Sat, 29 Aug 2026 15:54:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: s93nesua@bote.unbox.at
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution
Message-ID: <bug-221040-2300-6UIfWMA3UI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221040-2300@https.bugzilla.kernel.org/>
References: <bug-221040-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221040

Bertram Ganz (s93nesua@bote.unbox.at) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|ANSWERED                    |CODE_FIX

--- Comment #5 from Bertram Ganz (s93nesua@bote.unbox.at) ---
Update: Issue appears resolved (kernel 6.18.42-1-lts / Mesa 26.0)

After several months of using hibernation (S4) as a workaround, I retested
suspend/resume (S3) today and completed 3 consecutive cycles successfully
with no hang - previously the second cycle would reliably hang after
"PM: suspend entry (deep)" with no further kernel output, requiring a hard
reset.

Version delta:

My original report was on:
- Kernel: 6.12.63-1-lts
- Mesa: 25.3.4

I retested a few months ago on 6.18.17-1-lts and it was still failing at
that point (see earlier comments). Just retested again on:
- Kernel: 6.18.42-1-lts
- Mesa: 26.0

...and suspend/resume now works reliably. So the fix landed somewhere
between 6.18.17 and 6.18.42 (kernel), or possibly required the Mesa 26.0
upgrade in combination - I can't pinpoint the exact patch given the size
of the jump.

Still present (but non-fatal):

These log messages still appear but no longer block suspend/resume:
  gnome-shell: Cursor update failed: drmModeAtomicCommit: Invalid argument
  xhci_hcd 0000:01:00.0: xHC error in resume, USBSTS 0x401, Reinit
  asus_wmi: failed to register LPS0 sleep handler in asus-wmi

Hardware:
- AMD Ryzen 7 5700G (Renoir/Cezanne)
- ASUS ROG STRIX B450-I GAMING (BIOS 5901)
- amdgpu.dcfeaturemask parameter removed, no longer needed

Status:

I'll leave this open for now since I haven't pinpointed the exact fix, and
the underlying error messages are still present even though non-fatal.
Feel free to close if this is considered sufficiently resolved, or let me
know if a bisect would help.

Also posted updates on:
- AMD GitLab: https://gitlab.freedesktop.org/drm/amd/-/issues/4927
- EndeavourOS forum:
https://forum.endeavouros.com/t/amd-ryzen-5700g-renoir-asus-b450-i-second-s=
uspend-hangs-after-resume-xhci-hcd-asus-wmi-issues/77923
- r/AMDHelp:
https://www.reddit.com/r/AMDHelp/comments/1qv40fo/amd_ryzen_5700g_renoir_as=
us_b450i_second_suspend/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
