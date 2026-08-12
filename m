Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA880C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B40910F267;
	Thu, 13 Aug 2026 09:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ugreen.com header.i=@ugreen.com header.b="Ff2UEWQm";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3651010E3E5;
 Wed, 12 Aug 2026 08:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1786523339;
 bh=6pvU5hKGwNoAskF8h1svo43tQkk7bW8zd/eH2+CgO6g=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=Ff2UEWQmKyF02RA1FFVVT7JOl3lXuysDukNJmLPSQkhjd0zetm5/J/4PYyIHm20Uo
 RdkGtx9d//8hD5vsVoi7x99eIwYjC9nMdUITpjulRAp+tMamH2+bRFEdaOnHDAYDuk
 cWFtFZiRoEfBRsJIW8JbphOsVtVsHlfodE07mqj4=
X-QQ-mid: zesmtpgz3t1786523331tccda71ea
X-QQ-Originating-IP: ROJw1rlyoLNm7vO4Ujpru5u1DWWBu46TE/Dl7ji34wc=
Received: from localhost.localdomain ( [113.90.157.158])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Aug 2026 16:28:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8013104862253889230
From: Neil Zhong <neil.zhong@ugreen.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Date: Wed, 12 Aug 2026 16:28:47 +0800
Message-ID: <B6F23642F2B2211D+20260812082850.60737-1-neil.zhong@ugreen.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <anvV3WiVbYMqjdbZ@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
 <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
 <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
 <am2Lkcid3rLuqLFL@gsse-cloud1.jf.intel.com>
 <0AC9B69C6E8FB7B2+20260808093408.79701-1-neil.zhong@ugreen.com>
 <anvV3WiVbYMqjdbZ@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Oe8iJ2SlZYdbgp4T4i8ZwEtxkbI+aPBCsoHR5N2/w8joACtUy4GisV6E
 g3Br1RMTzkm8onRe4k6k2xue2Y6OyQlN3MpWDfNMO++LZ6ACr/SKBmXYkQyXJy3c6vlZ2ko
 rssip3eVtr227wUu4j5OHBukwOvR8dXAoobjnq8RY9uf3rxoTRibjabjkoSilq6EbtnMgg9
 yne8sCweHE3fRiccuqA6ASNdEvvEucpPf0m+AN8OOYSZQKSoIgEwxEkYi6j5Sz9uNROa4Sc
 D5qZlEnAvFg6U5rea8VX2KDiTuDifIABLOyDFijtoKzFb+PFJ8h9srHO4nAzEWy0dHl93mm
 vI+VGOfZrCfZpAevKOGhMpdhkuXkD5jFhf7AgFNDOLnt2dbWr4UtYEZldOKFY6sI9N9SdR2
 jL5emFN9EG6WHblaoP1DN9BK1a8FYZJOVRZSaeRNbJzgXI5wsLvW5Sa61HFJe3oB/BCNKqR
 crXa1RHd8JbSJJcTxgdT1JAnq+JzaIKYgcJMxK7Akhb2/uXXd9PPp2LrtKkgzPGKFFyq/CI
 L/DmxhQODURBugI0FLvdVJn1/TnS0ZFu44Q9UGi3SglrZIH10dxf+WGdbB/J/8LxR497RYQ
 c1loPUu5cTOHcdqyJn3sGrTqhd0MDMlGlMmD82V/IJbi7ZRT1R6sZh+Bir6wz9aE+WsJGBG
 TNCxlF/fYLlG8ReNmklBxZCGwUOBcB72T63k7mloq87s/MJNlPImn58nL+oUPE3ARjOFjpV
 9mG+n40Qq1Kxz3apPAMYmN9nb0oxwndvnmM1HKxJYcFaeDp3T/2zG4jTtvC+l2lOiH5kZVG
 waBO3lFDtUXt8G+EtlWdH8keWmzc19dZ8Pk3/tbPF2pnTXQyCgkATsY2bwaasJWrQ9DY58w
 VXrjrVIrwk5+jnlX10XQC/STn+XeLRV+jig+H1abLdc+nygJ0CC0AnbsDF4quz3MGrLj9C/
 P6kgXVSyA94gp46NVC+R0z8SYtoI1JqQlCUOZPtlkFaZ7wOkKh2H9zpGiD74zW5yZPLUAZc
 VAIWuBbpt63J/7QFaU19S67HbySBNgShLlzK0aAg+/1vE9KdaCzEVyi7J72T/Nr/7mXqCMV
 r+AEjWUuCX6
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Hi Matt,

> Can you give me instructions on how to recreate this on our end and your
> machine, memory details? I have a bunch of various reproducers which I
> have been using for shrinker work and the more the better.

Yes. The test system and workload are as follows.

  - Panther Lake iGPU using shared system memory
  - 8 GiB installed memory; /proc/meminfo reports 7,723,392 KiB
  - 4 KiB base pages
  - four zram swap devices, 3,858,416 KiB in total
  - Linux 6.18.15, x86_64, PREEMPT_DYNAMIC
  - X11 fullscreen output at 3840x2160 and 60 Hz
  - a 3840x2160, 60 fps, HEVC HDR video played continuously in a loop

The player uses hardware decoding. Each decoded frame is imported through
DMA-BUF and processed by libplacebo/OpenGL for HDR tone mapping before
presentation. It calls glFlush() for every rendered frame. During steady
playback, the player accounts for about 1.85 GiB of logical Xe BO
allocation, including about 672 MiB reported as shared.

The player is not currently public. However, an equivalent pipeline should
reproduce the condition if it keeps the decoded surfaces, HDR intermediate
render targets and presentation surfaces alive, rather than creating a
small synthetic BO set. 

No additional memory-pressure tool was used for the first reproduction.
I start the video, let its working set reach steady state, and then capture
ten minutes while playback continues. On the 8 GiB system, the priority-only
run had MemAvailable between 2.89 and 3.15 GiB, while 97.8% of kswapd wakeups
were for order-10 allocations. Thus this reproduces without forcing an
order-0 shortage.

I collected the trace with:

  sudo ./capture_xe_memory_churn.sh \
          -t 600 \
          -s 0.2 \
          -o ./xe-memory-churn

`-t 600` records ten minutes. `-t 0` can instead be used to record until
Ctrl-C. The 0.2 second option is only the /proc and TTM-pool sampling
interval; ftrace events are recorded continuously.

The player also logs one line after each frame submission in this form:

  gl_sw_submit_frame timing: ... Flush=123.456 ms

The log prefix contains the wall-clock timestamp. An equivalent reproducer
can record the time immediately after glFlush() returns and the measured
duration. The trace script inserts a wall-clock epoch marker into a
mono_raw ftrace stream so that the two timelines can be aligned.

The figures in my previous email came from the 6.18.15 kernel with [9]-[13]
backported, the fragmentation check applied to direct reclaim as well, and
the high-plus-min watermark experiment described there. The default-device
watermark capture used vm.min_free_kbytes=131072. The follow-up used 50000;
the workload and trace procedure were otherwise unchanged.

> Also a quick write up how you extracted these numbers from reproducer so
> I can recreate on my end.

The capture script creates temporary entry and return kprobes for:

  ttm_tt_backup()
  ttm_tt_restore()
  ttm_pool_alloc()
  ttm_pool_free()
  ttm_pool_shrink()

It also traces the Xe shrinker, TTM restore and cache-attribute functions,
kswapd and direct-reclaim events, compaction, and allocation
fragmentation.

At ttm_tt_backup() entry, the probe records the ttm_tt pointer and
num_pages. At return, it records the positive return value, which is the
number of pages actually backed up. I sum those successful return values,
not the requested page count, when reporting backup volume. A later
ttm_tt_restore() is matched to the most recent successful backup using the
same ttm_tt pointer. That provides per-object backup-to-restore latency and
repeated-cycle counts.

The byte-volume calculation is:

  backup bytes = sum(successful backup return pages) * PAGE_SIZE
  restore bytes = sum(num_pages for matched restores) * PAGE_SIZE

The reported backup-plus-restore volume is the sum of those two values.
It is cumulative migration/copy traffic, not resident memory and not net
memory freed. A shmem backup remains resident system memory unless those
shmem pages are subsequently swapped out.

> This customer, in particular, utilizes priority bands to express this
> heuristic (e.g., the compositor is the highest priority, any
> non-privileged UI-related content is normal priority, and everything
> else is low priority).

I think priority bands are useful for relative reclaim ordering, but they
do not by themselves express the guarantee needed here.

Consider a system with one large GPU workload. If nearly all reclaimable
BOs belong to that client and are placed in the high-priority band, the low
bands will contain few or no candidates. When enough memory is requested,
the shrinker must eventually enter the high band. In that case, high
priority delays reclaim but does not prevent it. The priority-only test
showed exactly this limitation: over ten minutes there were 6,743
successful backups and 6,693 restores, with 157 Flush calls over 16.667 ms
and a maximum Flush of 494.434 ms.

I am not suggesting that every BO of a high-priority client should be
unreclaimable. Whether reclaim is acceptable depends on the workload, and
the kernel cannot infer that semantic from WC, VM-bound state, client count
or BO size alone. For example, the driver-visible behavior of these two
workloads can look very similar:

  1. Foreground 4K60 HDR playback. Its active decoded surfaces, HDR render
     targets and presentation surfaces have a 16.667 ms deadline. Backing
     them up and restoring them causes an immediate and clearly visible
     product failure. These BOs should avoid eviction and shrinking while
     they are part of the active visual pipeline.

  2. Background image recognition or classification. Its BOs have no
     presentation deadline. Reclaiming them under system memory pressure
     is reasonable, even if the job later has to reconstruct its working
     set.

Priority bands cannot distinguish those cases if both clients assign their
current working set a high relative priority. This is why I think the
business semantic has to come from userspace. Priority bands can remain the
general ordering mechanism, while a separate, explicit and bounded
NO_SHRINK or latency-critical mark protects only the BOs in an active visual
pipeline. The mark should be removed as soon as a surface leaves that
working set.

> To be clear - this would be an addition to fixes discussed above, right?

Yes. I see explicit workload-semantic protection as an addition to the
core MM fragmentation/shrinker fixes and the Xe/TTM priority bands, not a
replacement for either. I agree that testing series 168651 together with
the priority bands is still useful for general working-set preservation.
It can reduce accidental reclaim, while an accounted NO_SHRINK contract
handles the smaller set for which a missed presentation deadline is not an
acceptable reclaim tradeoff.

Thanks,
Neil
