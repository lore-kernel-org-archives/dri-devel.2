Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD41AC44531
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784B310E7A1;
	Mon, 20 Jul 2026 07:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="ZxD8ifEN";
	dkim-atps=neutral
X-Greylist: delayed 934 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 16:59:58 UTC
Received: from outbound.st.icloud.com (st-2004b-snip4-5.eps.apple.com
 [57.103.78.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C9B10F5B7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 16:59:58 +0000 (UTC)
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 085271800162; Fri, 17 Jul 2026 16:44:20 +0000 (UTC)
X-ICL-RepId: 019f70f6-f646-78c2-a5a8-9dc1ab044d36
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCE0HQwZcAFBcHA4EVANbQgtICi1eCF4fTBwdDlgGEhZdRVoOWwRHFBcbXAAXGVFNDlhbCFsEDx9MDFECQgVWXkoMHQRUB10FXVZQAlpLQgRLRWhcBVwcQBdIHV9qS1YUBBFQAVgeVl5aF15NWgJWTQVJBFUDWAJGD00FXwVFCkEOTABeGVkGQQpOAV8FUwVGAEoLXANTA0IXH1UVXx5QXUoMUg9bDh8WVhRfAkAeQjBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1784306663; x=1786898663; bh=IcoWptpMMKJfRvm1yIVnGLPBbqqPSHCKZlMZVkgirlQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ZxD8ifEN7b8aRl1NYfGicJmcE6DYELUf0Qd10WubY7eLMn/y6DIo+WNmCSdoxTnsh3VRct9wWITtyyGIbWABPQ0nUvSKsScX302ALMZeeo+uLDur3D70GwQZcM81qm3Cucc0N/5FvuBmhR2cx3mJiadTSPUZs0TdkTlvSTyPHhdBEUm7sMLcZQ74YebDT9HZR1QKJiTYKjAPI1o0wyQJDnn83Dr1lIDbSxwpTc/SYCagrlGwatZ0Y0IYGAELX2dVi0ajTSPBsQ/Qvp4eei0oh4nCtcgN3Yx1j9xqWRxrDDsCF8MBz6vviFTEea+63TifE/HEX0/HjRLGhANz7YO2wQ==
Received: from [192.168.1.7] (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 B734718004DC; Fri, 17 Jul 2026 16:44:18 +0000 (UTC)
From: LetsDank <ichi2209@icloud.com>
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: Leo Li <sunpeng.li@amd.com>, Mario Limonciello <superm1@kernel.org>, 
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drm/amd/display: add DMU timeout recovery support
In-Reply-To: <178429570497.694276.1089609041510474786.dmub-recovery-v6-test@icloud.com>
References: <20260505182105.420525-1-someguy@effective-light.com>
 <20260505182105.420525-2-someguy@effective-light.com>
 <178429570497.694276.1089609041510474786.dmub-recovery-v6-test@icloud.com>
Content-Transfer-Encoding: 8bit
Date: Fri, 17 Jul 2026 19:44:16 +0300
Message-ID: <178430665622.817433.2413622287692814812.gfxhub-stable-followup@icloud.com>
X-Mailer: b4 0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784306658; l=1310;
 i=ichi2209@icloud.com; s=default; h=from:subject:message-id;
 bh=ArBkVRRAB5Hvap9lCuY6dcFa5nG0SOuaadtHLVMS3oI=;
 b=CWUuXgg1PEAiHyqq03uqN3F0jdvYWw8zJjJAdYXq4drRPjbbmuk028yQ0z0xM8qEcEWq7yUAg
 3vSnsWflprABSOoMGhLfQQfN3hqiAN9iDqcn45y+T2xgPGqy3ILlKGQ
X-Developer-Key: i=ichi2209@icloud.com; a=ed25519;
 pk=XxjWf2lZjzshfIjDjk9y0WzmUwfl3qazBLI51WfnrWs=
X-Proofpoint-GUID: w3bjnjs-y5_2ErSwc5aNum-ipELnllOs
X-Proofpoint-ORIG-GUID: w3bjnjs-y5_2ErSwc5aNum-ipELnllOs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE3MSBTYWx0ZWRfXykUdY01ZPP1+
 tSy8A/Cqq6jmZjHJ2XutCumk0L/k/c6nW/UFrWF9I04vAqfoNUaoqcGXce2ThCsslOjG2WE1FJb
 r28dQolaQ7ZUzwSXBqNinf5so0+EBJHlaukZJAAImijXm+4mFfwur2vDptj+pl5dUe3l5U9Qnrm
 xfm8QrklycqVB+MfTtR8znQ8dgovmhEzhT2QyhIGPAZI/WYQ3erTdVTMrNW+22Pby19Jz4ROwb0
 hQVkusegqcahpuyhWCBq9m+uKZOngCnbVULpsJ2gX3Jnm4MVTHscwQJ3l/C+3stHxCtA+KxnC4S
 gRRVyVahnuFJh3wSyVd
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

An important follow-up arrived shortly after my previous message.

The same separate gfxhub failure has now reproduced on the Fedora
7.1.3-200 kernel with amdgpu.dcdebugmask=0x810, after about 30.5 hours of
uptime. The sequence was:

  [gfxhub] page fault, process Xorg, ring 24, vmid 5
  GCVM_L2_PROTECTION_FAULT_STATUS: 0x00501031
  Faulty UTCL2 client ID: TCP
  PERMISSION_FAULTS: 0x3
  ring gfx_0.0.0 timeout
  Ring gfx_0.0.0 reset succeeded

Mesa then aborted Xorg in amdgpu_ctx_set_sw_reset_status(), ending the
X11 session and returning to SDDM. As in the v7.2-rc3 incident, there
were no DMUB, DMCUB, flip_done, or commit-wait timeout messages.

I captured a second complete 5.4 MB AMDGPU devcoredump. The fault status,
client, Xorg context, Mesa abort path, and ring-reset sequence match the
v7.2-rc3 incident.

This corrects any impression that the machine is stable against all GPU
faults with dcdebugmask=0x810. The workaround still appears to avoid the
original DMCUB/page-flip timeout signature, but it does not prevent this
separate gfxhub VM fault. The reproduction on both kernels also makes it
unlikely that the gfxhub fault was introduced by this patch series.

Both devcoredumps and the matching kernel logs are available if useful.

Regards,
LetsDank

