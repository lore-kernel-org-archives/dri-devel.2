Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CDCC44528
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF20610E702;
	Mon, 20 Jul 2026 07:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="an6wpk/n";
	dkim-atps=neutral
X-Greylist: delayed 929 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 13:57:21 UTC
Received: from outbound.qs.icloud.com (qs-2007e-snip4-11.eps.apple.com
 [57.103.84.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969CE10E475
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:57:21 +0000 (UTC)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPS id
 D06AA1800341; Fri, 17 Jul 2026 13:41:48 +0000 (UTC)
X-ICL-RepId: 019f704f-d874-723c-852f-6cc36591fbf3
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCE0HQwZcAFBcHA4EVANbQgtICi1eCF4fTBwdDlgGEhZdRVoOWwRHFBcbXAAXGVFNDlhbCFsEDx9MDFECQgVWXkgLHQRUB10FXVZQAlpLQgRLRWhcBVwcQBdIHV9qS1YUBBFQAVgeVl5aF15NWgJWTQVJBFUDWQtFDkgHVABFBEkNSgRbGVoCSABOA1QHXwNFCEgHWgNcCkYXHF4YVUZAFVoXRQhFEh8GD1VHCEQfchlaFFwYU0VRH1RGExlOG1dNUBtfAkIP
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1784295711; x=1786887711; bh=bmAC5L0eOwGiTuBws4CHSoQ7QdmQGR+K5mt2FFZOsRc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=an6wpk/nfyLEaTFxIwYyN/ldoxNbDXK+xSfER7NCx68gRm3UQ1tHjvAuHZO2L0d/UocAiBCeCrzK5Z0YHccYVNbUxCCg0cf/dp+cWCEHJi21F1d8gb/RQCUXNyfuMIPcffhKgL4P8F+D2r0dteKW0xC6HQpzdEdUcEE0tQiWdankH8uo2VObtJtkHhSpfO6ybal02ZCkhfb4VLv+o/Plq7ppkQRpbe3eXw7J6I3sDHQB8bS7urK8YiZjPxRFPZQox9/c/aHM0JmhL+WOJE1j+JTcjTRtPAR5agenURz0dHFF1aaArr0IXJ+8pGiT+EppUqZZqhQQ7C8nvHrCSe6VAA==
Received: from [192.168.1.7] (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPSA id
 11CA718002F5; Fri, 17 Jul 2026 13:41:46 +0000 (UTC)
From: LetsDank <ichi2209@icloud.com>
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: Leo Li <sunpeng.li@amd.com>, Mario Limonciello <superm1@kernel.org>, 
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drm/amd/display: add DMU timeout recovery support
In-Reply-To: <20260505182105.420525-2-someguy@effective-light.com>
References: <20260505182105.420525-1-someguy@effective-light.com>
 <20260505182105.420525-2-someguy@effective-light.com>
Content-Transfer-Encoding: 8bit
Date: Fri, 17 Jul 2026 16:41:44 +0300
Message-ID: <178429570497.694276.1089609041510474786.dmub-recovery-v6-test@icloud.com>
X-Mailer: b4 0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784295706; l=1832;
 i=ichi2209@icloud.com; s=default; h=from:subject:message-id;
 bh=pONLHRr4dv+r1AnSmaerPnjsgr3wwol/ONWGGkYAxhQ=;
 b=1gDu6sF6JRmy6Roi+ijshuHmj6QRFgfe6dgXzO4i+LCNF7i/pB7fyMS3Kys6LPZTnubTE68JI
 8RO13gSySBiCPbqhj2qmHXBROpI16SYfCJeBt0zdc6yxu617X5/67aG
X-Developer-Key: i=ichi2209@icloud.com; a=ed25519;
 pk=XxjWf2lZjzshfIjDjk9y0WzmUwfl3qazBLI51WfnrWs=
X-Proofpoint-GUID: l3fBCJMtfIFppapp5IvLTCv63-28tSmV
X-Proofpoint-ORIG-GUID: l3fBCJMtfIFppapp5IvLTCv63-28tSmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzOSBTYWx0ZWRfX7h9HxEwuJmVb
 4dgVsJMMYoef/Fj/4VePzyUcJLn7aDldl1I+4bIs6qHM5INW7OS2X9dCr0QpOKdeCTX8Jpln0Aq
 0MVl3xybNRsC+h3pmCn8emkz2PyDq9uj29RAi17b/UfbMWuRHNlwNteA47FMe7e/OPcLJxd1C4L
 Feic+zXISd4eXYJJEMR/5Vg5187aominZMz2jq8fg45wLZcymVw2Mm3KOPicxh8mZFctbamqQhx
 5J6myYrZJm5wAQX6jp95Wb9Vu09uho5mxHFDJAREIiPorFuBMUUNjhmqMlJs8NPI96c0O6e36LP
 hvEfiEx5aikDJcmtogH
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Hi,

I have been seeing what appears to be the same failure on an MSI Bravo
15 C7VF with a Ryzen 5 7535HS / Rembrandt Radeon 660M (1002:1681), an
internal 1920x1080 144 Hz eDP panel, and KDE X11. It occurred on Fedora
kernels 6.19 and 7.1.3. The relevant signatures included:

  flip_done timed out
  commit wait timed out
  Error queueing DMUB command: status=2

Using amdgpu.dcdebugmask=0x810 has avoided the failure for more than 53
hours across four boots, including one continuous run longer than 27
hours.

I built this v6 series on top of v7.2-rc3 and booted it with:

  amdgpu.dcdebugmask=0 amdgpu.gpu_recovery=1

It passed five DPMS off/on cycles, five modeset cycles between 60 Hz and
144 Hz, and a short fullscreen rendering test. It then ran a normal KDE
X11 workload for about 12.5 hours without any DMUB queue-full, DMCUB, or
page-flip timeout message.

The original intermittent timeout did not occur during that run, so I
cannot offer a Tested-by for the recovery path.

After about 12.5 hours the test kernel hit a separate gfxhub VM page
fault attributed to Xorg, followed by a gfx_0.0.0 ring timeout and a
successful ring reset. Mesa then aborted Xorg. There were no DMUB,
DMCUB, or flip timeout messages in that incident. I preserved the full
AMDGPU devcoredump and symbolized userspace coredumps if they would be
useful as a separate report.

Patch 1 also needed a small API adaptation on v7.2-rc3 from
drm_atomic_state and drm_atomic_state_*() to drm_atomic_commit and
drm_atomic_commit_*(). The resulting kernel built cleanly, and all three
commits passed checkpatch.pl --strict. I can send that fixup if it would
help with a respin.

Is this series still being worked on, and would testing a revised version
on this Rembrandt system be useful?

Regards,
LetsDank

