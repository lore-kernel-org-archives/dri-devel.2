Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421E9C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B92D10E902;
	Mon, 20 Jul 2026 12:43:58 +0000 (UTC)
X-Greylist: delayed 696 seconds by postgrey-1.36 at gabe;
 Mon, 20 Jul 2026 12:43:57 UTC
Received: from h6.fbrelay.privateemail.com (h6.fbrelay.privateemail.com
 [162.0.218.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DF810E902;
 Mon, 20 Jul 2026 12:43:57 +0000 (UTC)
Received: from MTA-10-3.privateemail.com (mta-10.privateemail.com
 [198.54.118.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4h3fzQ5K5jz2xjv;
 Mon, 20 Jul 2026 12:32:18 +0000 (UTC)
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [142.188.184.102])
 by mta-10.privateemail.com (Postfix) with ESMTPA id 4h3fzD0NJlz3hhTX;
 Mon, 20 Jul 2026 08:32:07 -0400 (EDT)
Date: Mon, 20 Jul 2026 08:32:04 -0400
From: Hamza Mahfooz <someguy@effective-light.com>
To: LetsDank <ichi2209@icloud.com>
Cc: Leo Li <sunpeng.li@amd.com>, Mario Limonciello <superm1@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drm/amd/display: add DMU timeout recovery support
Message-ID: <al4VRK6IAYLPSm3c@hal-station.localdomain>
References: <20260505182105.420525-1-someguy@effective-light.com>
 <20260505182105.420525-2-someguy@effective-light.com>
 <178429570497.694276.1089609041510474786.dmub-recovery-v6-test@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178429570497.694276.1089609041510474786.dmub-recovery-v6-test@icloud.com>
X-Rspamd-Queue-Id: 4h3fzQ5K5jz2xjv
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

On Fri, Jul 17, 2026 at 04:41:44PM +0300, LetsDank wrote:
> Hi,
> 
> I have been seeing what appears to be the same failure on an MSI Bravo
> 15 C7VF with a Ryzen 5 7535HS / Rembrandt Radeon 660M (1002:1681), an
> internal 1920x1080 144 Hz eDP panel, and KDE X11. It occurred on Fedora
> kernels 6.19 and 7.1.3. The relevant signatures included:
> 
>   flip_done timed out
>   commit wait timed out
>   Error queueing DMUB command: status=2
> 
> Using amdgpu.dcdebugmask=0x810 has avoided the failure for more than 53
> hours across four boots, including one continuous run longer than 27
> hours.
> 
> I built this v6 series on top of v7.2-rc3 and booted it with:
> 
>   amdgpu.dcdebugmask=0 amdgpu.gpu_recovery=1
> 
> It passed five DPMS off/on cycles, five modeset cycles between 60 Hz and
> 144 Hz, and a short fullscreen rendering test. It then ran a normal KDE
> X11 workload for about 12.5 hours without any DMUB queue-full, DMCUB, or
> page-flip timeout message.
> 
> The original intermittent timeout did not occur during that run, so I
> cannot offer a Tested-by for the recovery path.
> 
> After about 12.5 hours the test kernel hit a separate gfxhub VM page
> fault attributed to Xorg, followed by a gfx_0.0.0 ring timeout and a
> successful ring reset. Mesa then aborted Xorg. There were no DMUB,
> DMCUB, or flip timeout messages in that incident. I preserved the full
> AMDGPU devcoredump and symbolized userspace coredumps if they would be
> useful as a separate report.
> 
> Patch 1 also needed a small API adaptation on v7.2-rc3 from
> drm_atomic_state and drm_atomic_state_*() to drm_atomic_commit and
> drm_atomic_commit_*(). The resulting kernel built cleanly, and all three
> commits passed checkpatch.pl --strict. I can send that fixup if it would
> help with a respin.
> 
> Is this series still being worked on, and would testing a revised version
> on this Rembrandt system be useful?

I haven't had much time to work on this, though if you look at the
previous thread [1] the whole idea around having a recovery path for KMS
was NACKed by Ville. So, it doesn't appear to me that there is much of
an appetite for this.

[1] https://lore.kernel.org/r/afuMqXoBt2oIFRm9@intel.com/
> 
> Regards,
> LetsDank
> 
