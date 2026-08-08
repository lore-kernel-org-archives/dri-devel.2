Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D6AC5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC5E10E691;
	Mon, 10 Aug 2026 06:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ugreen.com header.i=@ugreen.com header.b="RIbvT0iK";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6018010E00F;
 Sat,  8 Aug 2026 09:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1786181659;
 bh=C5llPHgg+WJXBlm8wjJbJ5566rhpI9Np0sHlFHEa6w0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=RIbvT0iKOM0eOZYuiYr0B0cK/NXxL6CWQTM14ot7lRHNWVrcarKOvr81FMNW5pyN6
 c0J8FpYpW9Ej0W9sQ7hj+9tAvdC+w/r1HNi1wOrB7FF7Eri7kyjY8xu97BOOSBMFq5
 BO74FU+M16Jk7ufVu29II0yS6ISXj02ZQKBUBkJ0=
X-QQ-mid: zesmtpgz4t1786181652t33ce22c6
X-QQ-Originating-IP: 1VykBWxJV+I9skzak7YyUX27ze/NQDYkwRcicFEpW7k=
Received: from localhost.localdomain ( [113.90.157.158])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 08 Aug 2026 17:34:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11190497938159396211
From: Neil Zhong <neil.zhong@ugreen.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Date: Sat,  8 Aug 2026 17:34:04 +0800
Message-ID: <0AC9B69C6E8FB7B2+20260808093408.79701-1-neil.zhong@ugreen.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <am2Lkcid3rLuqLFL@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
 <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
 <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
 <am2Lkcid3rLuqLFL@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nl7eTg5yGHnwuiaqE1IpzB6xT7xJ7YEyLcZu12DizdgNOqu7AypBVAQ6
 agh8Q3pOoxeeA0KquWls6/7cBWDiPXoSzbQktEnsXLVUbKCpNFPC6D9EHoNIs1krln87dGg
 FpwLOEKHPe5ciJo1OaTlezWYF7821EvAsksTPi+gdvQw8YuRrsFMG91nbO+c8/uo7Cs/k2Q
 oLf0FKt2f8Ale2QLdH4fz3IVmEaDdFKru3ePcphEa9BcYoU8efRJxtWy/vhVE4RRvBeNC8t
 OOOJucoNV/OtrWsvhPFUhYsjkuyRqoeXdmjSaWL6D3Q0xUaCfeKQpdBgcwfmmwkWkz1habx
 Uq7qepJt+A0OzWzOpSjFfszIdBgsvJiiu92VnJPKl33gZBaoIzi5CXaWJ0ADS1xmNVVum0U
 Bci8wQYUl/CISLEsC67zTKe4fB8uyZq9gm0mZpaJ/y+bgBS4Q1aytdQhB17czPY3blevEzB
 6oOKKMIY5FpmC6WrmNg2pXA70f9D/DjJrG9+ixvYPr5V+aAIf1qGVrMoclyxy8K2CoAAiaL
 Yit2qjcNhfQhlNzsKS/V/hvQZAXxoT5yo2tezaGziyO7JG3ulZBBtK3m+qnZE8c4FHsh6iF
 fwjojG58DaeXLHZizuhnnEV7SqA1Y5TVDGA+sDWBoQEI+XW1WmpEtIFf10MB2zNIx5Jg4aR
 aWOsyac7XTX/f1nc4JaXVMmuGl9dIKqgIekfN/ZeH0WZlAIQxfFTlc+uNgNiKebIOjikmDe
 pmBPt2x/Iw8KP+y6BT4eADcef5GV1fB9vC8MjbRrEZbVja8O9xXRybjzkGHwJF/41U4Kq0e
 3hRFZbeWZKBUbnMxsUg7ZlQpE1nBR72hSRlaqWmqDyI5XqZ9LpWZavHMyVjRos1TWTiIPzP
 6PVPMqqUZAnVA/qBIKjlRR0cVRTycEJZWeSQj4/65nNra+68fc/m8MDVl+BhheplEH40KWV
 H9G+xkYDhdU3xMoHARaK0s0tawCJep4E52DuvRi3ZvaVlgc5oZPLlks7Mav5lIxsgBnK7IE
 vKdNph2nH5zsdQMYxSxTl86aSeMyFlGUNVaIuVoO/2uyD1BySB
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

On Fri, Jul 31, 2026 at 11:00:49PM -0700, Matthew Brost wrote:
> This actually roughly what downstream customers are carrying :).
>
> It is basically these 3 patches [9] [10] [11] implemented directly in
> the Xe shrinker code to avoid touching the MM or TTM...
>
> Alas I got nack'd by someone outside my subsystem on this approach.
>
> I think if you use the reference patches above to implement a heuristic
> in Xe, or come up with a similar one, it will likely solve this issue.
>
> Since you're on 6.18, you may also be missing some Xe/TTM changes
> related to this problem that have already been merged into drm-tip.
> There are a couple of one-line fixes that should help somewhat, but the
> heuristic is what I think will actually address the root cause.
>
> As heads up, I've started looking at this again and pushing to get
> something upstream as this at least 5th time someone or org has flagged
> this as a problem. Any data you can provide will help us push towards a
> solution.

Hi Matt,

Thanks. I tested [9]-[13] on the same machine and the fragmentation
heuristic does reduce the frequency of the problem. However, after these
tests I would like to clarify my actual requirement, since my previous
watermark-based proposal did not express it correctly.

For BOs that belong to a latency-critical visual processing working set,
I think userspace should be able to mark them as non-shrinkable, and Xe
should not back them up under any memory-reclaim condition while that mark
is held. This would be a hard residency contract, not another reclaim
priority or a fragmentation hint.

Why a hard contract is useful for visual workloads
--------------------------------------------------

The reproducer is continuous 4K60 HDR playback. Every decoded frame is
imported through DMA-BUF and processed by libplacebo/OpenGL for HDR tone
mapping before presentation. The active BO set contains decoded video
surfaces, intermediate render targets and presentation-related surfaces.

At 60 Hz the complete frame interval is 16.667 ms. If glFlush() is blocked
for longer than this, the application misses at least one presentation
deadline. Repeated missed deadlines are perceived directly as dropped
frames or visible stutter. A 100-500 ms reclaim/restore storm is an
obvious freeze, even if the system eventually recovers and its average
throughput looks normal.

Fence-idle is not equivalent to cold for this workload. A video surface
can have no active fence in the small gap between two frames and still be
part of the application's current visual working set. The next frame can
need the same BO immediately.

The trace demonstrates exactly this case. In one sequence, kswapd
completed backup of an 8,208-page BO and the rendering thread started
restoring the exact same ttm_tt about 33 microseconds later. The kernel
copied about 32 MiB to shmem, dropped the WC pages, then immediately had
to allocate pages, copy the data back and reapply WC.

In the ten-minute default-watermark capture:

  successful ttm_tt_backup:                 4,853
  ttm_tt_restore:                           4,810
  minimum backup+restore copy traffic: 50,436.105 MiB
  Flush > 16.667 ms:                         209
  Flush > 100 ms:                             65
  maximum trace-aligned Flush:           223.195 ms

Of 4,791 restores matched to the same preceding backup, 4,279 happened
within 100 ms and 4,753 within one second. kswapd0 performed 4,839 of the
4,853 backups, while the player's rendering thread performed most of the
restores. Of the 209 Flush calls over one frame interval, 205 contained
ttm_tt_restore() and all 209 contained set_pages_array_wc().

This is not useful recovery of cold memory. It is destruction and
immediate reconstruction of the visible working set.

What the heuristic test showed
------------------------------

I backported [9]-[13], extended the fragmentation check to direct reclaim,
and tested a `high + min` watermark threshold. In a follow-up run with the
same kernel, video and playback configuration, I set vm.min_free_kbytes to
50000. This lowered the Normal-zone `high + min` threshold from about
379.8 MiB to 255.1 MiB.

With the lower threshold, the fragmentation helper returned true more
often and Xe working-set churn fell by about 90%:

  successful ttm_tt_backup:        4,853 -> 443
  ttm_tt_restore:                  4,810 -> 435
  Flush > 16.667 ms:                 209 -> 19
  Flush > 100 ms:                     65 -> 3

This confirms that preventing working-set backup prevents the visual
stalls. It does not make the individual restore path cheaper. When the
heuristic still allowed a storm, the maximum Flush was 191.655 ms and
contained 25 restores and 23 WC conversions.

I do not think tuning global watermarks is the right solution. More
importantly, I no longer think that protection for explicitly identified
visual BOs should depend on whether reclaim was caused by fragmentation
or genuine low memory. Once userspace has declared a bounded set as
presentation-critical, violating that residency guarantee produces an
immediate and user-visible failure.

Possible explicit marking mechanism
-----------------------------------

Could Xe provide an opt-in, mlock-like mechanism for this purpose?

One possible interface would be a new DRM_IOCTL_XE_MADVISE VMA attribute,
for example DRM_XE_VMA_ATTR_RECLAIM_POLICY, with states similar to:

  DRM_XE_VMA_RECLAIM_DEFAULT
  DRM_XE_VMA_RECLAIM_NO_SHRINK

NO_SHRINK would mean that the backing BO is excluded from the Xe shrinker
while at least one protected VMA holds the attribute. Userspace would set
it when a video/render surface enters the active visual pipeline and clear
it after the surface leaves that working set. Unbind, VM destruction or
file close would also release the holder automatically.

For a BO shared by multiple VMAs, Xe could maintain a BO-level
no_shrink_count, similar to the holder accounting already used for
purgeable state. The shrinker would skip a BO with a non-zero count. I
would prefer a separate shrinker-specific count rather than exposing TTM
pin_count, because pinning also affects placement and migration, which is
broader than the requested guarantee.

The existing WILLNEED state does not provide this contract: it prevents
purging of the contents, but the non-purge shrinker may still back up and
unpopulate the BO. It also cannot simply be redefined because WILLNEED is
the default state for all VMAs. SCANOUT is not sufficient either, since
many HDR intermediate and imported video surfaces are not scanout BOs.

I understand that an unprivileged client must not be allowed to make an
unbounded amount of memory unreclaimable. Like mlock, this could be
controlled by an explicit per-file, per-client or cgroup byte limit, and
possibly by a privilege check. If the requested protected set exceeds the
configured limit, the madvise should fail rather than silently accepting
the mark and later violating it under pressure. The application or system
service would then decide which visual surfaces to protect or release.

Within that bounded contract, however, I think NO_SHRINK should remain a
hard guarantee even in genuine low-memory reclaim. Under pressure the
kernel may reclaim unmarked BOs and other memory, reject additional
NO_SHRINK requests, or require the application/service to release part of
its protected set. Backing up an already accepted presentation-critical
BO and stalling a frame by hundreds of milliseconds defeats the purpose
of the interface.

For comparison, my original workaround approximated such a hard contract
by excluding VM-bound WC BOs from non-purge shrinking. In a 21-minute
capture, no XE_EXEC, VM_BIND or DMA-BUF ioctl exceeded the 16.7 ms frame
interval; their maxima were 348 us, 136 us and 20 us. The call rate of
set_pages_array_wc fell to 0.179/s. That automatic VM-bound WC rule is too
broad, but an explicit and bounded userspace mark could provide the same
latency guarantee only for the BOs that actually need it.

Would an explicit, bounded NO_SHRINK/latency-critical VMA attribute be a
reasonable Xe UAPI direction? If so, I can prototype the BO holder
accounting and shrinker exclusion, then modify the video/Mesa path to mark
only the active visual working set and collect another strict A/B trace.

[9] https://patchwork.freedesktop.org/patch/720030/?series=165329&rev=1
[10] https://patchwork.freedesktop.org/patch/720036/?series=165329&rev=1
[11] https://patchwork.freedesktop.org/patch/720031/?series=165329&rev=1
[12] https://patchwork.freedesktop.org/patch/732698/?series=168466&rev=1
[13] https://patchwork.freedesktop.org/patch/732420/?series=168389&rev=1

Thanks,
Neil
