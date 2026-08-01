Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8D6C55175
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747B810E2D2;
	Sat,  1 Aug 2026 07:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ugreen.com header.i=@ugreen.com header.b="nKIIwh7y";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB1C10E274;
 Sat,  1 Aug 2026 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1785562787;
 bh=GLicTeSTnlgPx72PHJoremnhSlWP1v2AZfc67NAMfQU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=nKIIwh7ysLZK1/QLUvpUP99rsgEH6gZhuqlxEggmG867YGUh6oOQzOT96xxiugP96
 EdneONIbSmaR5G2F58d1Ktq0rLhKPfcpDpis4du28ZJpUXxZCTxs9wRHJCebYdDKrL
 A55O4/myk/6ztkGvkhpq8iobU1KJK1fDHuZsjGvA=
X-QQ-mid: zesmtpsz4t1785562780t8b7bd816
X-QQ-Originating-IP: rQ9sehHB0EeDgrUdjG+/clMazJDjD8g1MJzjQ8/vi8A=
Received: from localhost.localdomain ( [113.90.157.158])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 01 Aug 2026 13:39:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9502698905456026107
From: Neil Zhong <neil.zhong@ugreen.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Date: Sat,  1 Aug 2026 13:39:13 +0800
Message-ID: <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
 <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NULd4DJcKZL/VkqnKQpx5oKZ1uT1aJiGnaXhom6z+qaWMA8mEiMw7isQ
 KCkZmS3PLNj7pwSMlTjfhAxjU6GNvL0ywUYY4mT0rWaFZNA0Cv+YaCB3KUehVSu8FLbbc6/
 nFVg8tO6ouYy8hx98vXfiTg0qD/CgRXkqVPUBkq3c+W3kSWgY0u+eLWuCpauB/UfqYCk6ZU
 9pxqiiz2f1YVPwQDTkMTBFJzGAhkh7Me7eV+YJA9/OHPB4F5w+EUdd0D0+93+MqHW+JEaGH
 u1kzAycycpvqGTgbUZLxoNQi6EXKds2aun3ZknGgEJ++L9bGzi9dTE1nLuJNo0ufHSFq/Sn
 rWbISgxNvIdh0gwMmP6u2tdEteOQjpo3TK/CPrt1l626zykB6YvZ6H18dpP5qvncjmxn3zK
 65gjqHOzqDv2/5HHqTJIeNkEGZ8cXtqTy5RjrwBfjKBXppRTwBiqvPgIKysfwmvGzA4wbe5
 WPM0UfZiSyhEfW63azR4MGzxy6izKOQm14i+wYHr9Ddf03dziaSw8SQhKo6VTrEP6YOFlDb
 lheAe4F9OD8Rr1X0Tym3eKCZimVqWhoyHZ0H0YR6QcaS7ZAnh0DMI6mC+8jHfTQqJPUIuBW
 L1Q7R//zjInLboPm36LGhfsOXHRZUxJWab8XXqZbS4l0e6/QlX5MaJ6USoAlC0H9hj3RAF8
 8P9dLUOzya+ziZ30srUEk90dPaIRFmzqjoMzaBdBaJK+sFRPxMWGNWPiKnxuVgawlm+h9Tm
 BA9+pvDaekNxpaXHdmdMVZK3Di4fKzsw6SyjiWc80I8aW6DKR9QwZJvW1KW+LganTjPXtB7
 9O8GHt0C4RFoIeWJkT1oMohhOO8fjf9HVh0rXYUd2JGnj24o+G429cu0ydAaQ2emY+yGs65
 N5vM5A8RSDpyol8aofzflj3A51JdsQPBvNJ4RVY0gcufgIPO18Ni3F+SoEu5td5VNwVW6Rq
 vnmwOjNn2OlBDmUoYzW0oWXvbgYCcEVoPFHDJxfHU4+N333puVc3JbLNhTi0oDsQta0TJ0Z
 LbcSOnpLSMJPi/up8ZJIPv8shG6IT/LSBdpfubMQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

On Thu, Jul 30, 2026 at 07:44:02PM -0700, Matthew Brost wrote:
> So I posted another rev priority changes to account WB vs WB/UC:
>
> [7] https://patchwork.freedesktop.org/series/170454/
> gitlab branch: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/priority_fixes.v4
>
> But after reading this a bit more carefully, I suspect the real issue is
> that fragmentation is driving shrinker activity. Your changes more or
> less prevent Xe from shrinking its working set, since nearly every
> buffer is WC. In my opinion, that behavior is reasonable for
> fragmentation-driven reclaim, but it is much less appropriate in genuine
> low-memory situations.
>
> This is also a known issue for us. We most recently attempted to address
> it here [8], but the fix was blocked by the shrinker maintainer - the
> same has happened to other proposed solutions as well. We have several
> downstream customers carrying non-upstream fixes to work around this
> problem too...
>
> [8] https://patchwork.freedesktop.org/series/168651/
>
> I guess if it isn't too much trouble could you test:
>
> 1. Priority changes [7]
> 2. Avoid shrinking working sets on fragmentation [8]
> 3. Both [7], [8]
>
> Matt

Hi Matt,

Thanks again for the priority series. I have now done a longer test of
[7], including a system-wide Xe/TTM trace that records the exact BO
backup and restore traffic.

Test setup
----------

The test machine has a Panther Lake iGPU and 8 GiB of system memory. It
is running Linux 6.18.15 with the applicable parts of the current v6
priority series backported.

Since 6.18 does not have the newer Xe purgeable madvise state machine, I
backported patches 1-4 and 7-8. Patches 5-6 depend on the newer
xe_bo_set_purgeable_state() infrastructure. The active VM-bound WC path
in this reproducer does not use those purgeable states.

The workload is continuous 4K60 HDR playback. Decoded video frames are
passed through a libplacebo/OpenGL rendering path, with every HDR frame
going through GPU HDR rendering/tone mapping before display. glFlush()
submits the rendering work for each frame. The working set is mostly
DMA-BUF-backed video/render surfaces and other VM-bound WC BOs.

Results with [7]
----------------

The priority changes alone did not fix the stalls. They appear to delay
the first visible failure after playback starts, but once reclaim and
fragmentation activity builds up, the same failure mechanism and
hundreds-of-milliseconds Flush stalls return.

In a 599.545-second trace, the player recorded:

  Flush samples:                 16,462
  Flush > 16.667 ms:               157
  Flush > 100 ms:                   67
  Maximum Flush:               494.434 ms

Every one of the 157 Flush calls over the frame interval contained both
ttm_tt_restore() and set_pages_array_wc(). The maximum Flush contained
73 BO restores and 65 WC conversions.

For the memory trace I used temporary entry/return probes to record the
ttm_tt pointer, num_pages, and the actual page count returned by
ttm_tt_backup(). This allowed a later restore to be matched to the exact
same ttm_tt rather than only comparing aggregate counters.

The ten-minute working-set traffic was:

  successful ttm_tt_backup:          6,743  (11.247 objects/s)
  pages actually backed up:      6,717,364  (26,239.703 MiB total)
  ttm_tt_restore:                    6,693  (11.163 objects/s)
  restore matched to same ttm_tt:    6,673 / 6,693
  matched restore volume:       25,993.043 MiB

This is at least 52,232.746 MiB of backup-plus-restore copy traffic in
ten minutes, or 87.121 MiB/s on average. It is cumulative migration
traffic, not resident memory growth.

Of 639 unique ttm_tt objects that were backed up, 491 were backed up at
least twice. One object went through 125 backup cycles during the
capture. The delay from completion of a backup to restoration of the
same ttm_tt was:

  median:       47.932 ms
  p95:         189.083 ms
  p99:         360.138 ms
  within 100 ms: 5,190 / 6,673 (77.8%)
  within 1 s:    6,653 / 6,673 (99.7%)

This looks like working-set thrashing rather than reclaim of cold BOs.
The caller distribution makes the cycle particularly clear: kswapd0
performed 6,460 of the 6,743 backups (95.8%), while the restores were
mostly performed by the player's rendering and decode threads.

The activity was bursty. Backup occurred in only 42 of the 600 trace
seconds, grouped into 14 reclaim/restore storms, with up to 397 BO
restores in one second. Backup and restore page volume had a same-second
correlation of 0.997. Per-second maximum Flush had correlations of 0.904
with backup pages and 0.917 with restore-request pages.

The trigger also looks fragmentation driven:

  kswapd wake order-10:             577 / 590 (97.8%)
  wakeup_kswapd order-10:           560 / 576 (97.2%)
  direct reclaim order-10:          512 / 518 (98.8%)
  MemAvailable during the trace:    2.89 - 3.15 GiB
  compact_stall/success/fail:       1,073 / 132 / 941

Thus the system still had about 3 GiB available while nearly all of the
reclaim wakeups were for order-10 allocations. This is consistent with
high-order fragmentation repeatedly invoking shrinkers, rather than
sustained order-0 memory shortage.

There is also normal small-object allocation activity, but it is not the
main problem. ttm_pool_alloc/free ran at about 41.6/41.5 calls per second,
but 97.6% of allocations were only one or two pages and are normally
reused through the TTM pool. In contrast, the same active working set was
copied back and forth for more than 52 GiB during the test.

For comparison, with my earlier workaround that skipped non-purge
shrinking of VM-bound WC BOs, set_pages_array_wc() ran at 0.179/s,
versus 9.859/s in this test. The current trace restored backed-up content
at about 11,099 pages/s, while the earlier capture recorded
ttm_backup_copy_page() at 26.74/s. The earlier 21-minute capture also had
no Flush, XE_EXEC, VM_BIND, or DMA-BUF ioctl over 16.7 ms.

The current trace is system-wide whereas that older function graph was
player-TID filtered, so these are not fully identical A/B collection
scopes. However, the difference in WC restore activity and the
user-visible result is large and consistent.

Interpretation of [7]
---------------------

The priority changes seem to be doing what they are intended to do: they
change which object is considered first. However, most of the active
working set in this workload is VM-bound WC. Once the lower-priority and
WB candidates are absent or insufficient, the shrinker still reaches the
WC half of the bands and then the higher-priority WC BOs.

Therefore [7] has no clear steady-state benefit for this reproducer. It
mostly postpones the point at which the active WC working set becomes the
remaining reclaim target. Once that point is reached, the backup/restore
and CPA cost is essentially the original problem.

Possible Xe-local alternative to [8]
------------------------------------

I agree that [8] may help this workload, and the order-10 trace data is
consistent with the condition that [8] is trying to identify. I have not
yet completed the [8]-only and [7]+[8] tests.

I also understand the MM feedback that this is a wider compaction versus
shrinker-working-set problem, not something unique to Xe. Nevertheless,
for Xe there may be a narrower implementation that does not require a new
hint to be propagated through MM.

My idea is to make the Xe shrinker distinguish base-page shortage from
fragmentation before entering its destructive, non-purge backup pass:

  1. Always keep the purgeable-object pass available.

  2. Check order-0 free pages against the relevant node/zone watermarks,
     using sc->nid and the zones allowed by sc->gfp_mask. This should be a
     watermark check, not a global MemAvailable threshold.

  3. If the relevant order-0 supply is healthy, for example above the
     high watermark, treat the shrink request as fragmentation-only for
     Xe and skip backing up the active VM-bound working set. Reclaiming
     arbitrary BO-sized objects is unlikely to produce the contiguous
     order-10 extent and is very likely to destroy the GPU working set.

  4. If the order-0 watermark is below low, treat it as genuine memory
     pressure and retain the normal Xe shrinker behavior, including WC
     reclaim if cheaper candidates are insufficient. Between low and high
     the existing priority policy could remain the conservative fallback.

In pseudocode, the special case would be placed between the purgeable pass
and the non-purge backup pass in xe_shrinker_scan():

  run_purgeable_pass();

  if (order0_watermarks_healthy(sc))
          skip_non_purge_working_set_backup;

  run_normal_priority_based_backup_pass();

This differs from my original workaround because it would not make
VM-bound WC BOs unconditionally unreclaimable. They remain reclaimable
under real base-page pressure, so the system can still recover memory in
a genuine low-memory situation. It only avoids the expensive backup and
immediate restore cycle while base-page watermarks say that the problem is
fragmentation rather than capacity.

This Xe-local policy would not solve the broader problem for inode, dentry,
or other shrinker-managed working sets, so I do not see it as a replacement
for a general MM solution. It may, however, be a small and testable Xe-side
safeguard while the general compaction/shrinker policy is being worked out.

Would this be a reasonable Xe-specific experiment, or do you think Xe
should rely exclusively on an MM-provided indication such as [8]?

I have retained the raw trace, the per-second timeline, and the probe
script and can provide them if useful.

Thanks,
Neil
