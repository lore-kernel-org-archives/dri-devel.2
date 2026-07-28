Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AE3C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B1A10E7A6;
	Tue, 28 Jul 2026 07:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ugreen.com header.i=@ugreen.com header.b="jHVCse0V";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5DA10E52A;
 Tue, 28 Jul 2026 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1785219551;
 bh=k5DNc4eRvSz4OUMAL85dEjxad0TwoiiNcTQ5KlNiABs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=jHVCse0VS5O1xUygD7xAeg0aJJ7bQzynAY/ggWbyexX+CKCsohevGWGdTOrUF8NLg
 nXtTN54nE/eQWK3QpICTW2r1Uuj/+4ZJXKsRgJmcvxXipPZMCTLcHTQV+K36K52/0c
 o0STJIIhN+C1mCad4ovFTohy5rYPdWiZwm5pTPNk=
X-QQ-mid: zesmtpsz7t1785219413tb61fcfca
X-QQ-Originating-IP: AQyvpo1zHDEgU59Wcb3plaG/Hbh6ebjPeeuXu4LeoNo=
Received: from localhost.localdomain ( [113.90.157.158])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 28 Jul 2026 14:15:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17931810034244921429
From: Neil Zhong <neil.zhong@ugreen.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] drm/xe: avoid reclaim/restore stalls for VM-bound WC
 BOs
Date: Tue, 28 Jul 2026 14:14:42 +0800
Message-ID: <88EF5AEC93511ABE+20260728061443.33616-1-neil.zhong@ugreen.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NrJHW3hvBPkCVAf65JZa0T58suSJCsP7I3ftU552/t2xlq5KeGvPVaMH
 xj8EcQQBM9+SW5aN+Q6VSxpRsl7lvrwFLUaLmVN5rWnj0/CMLHfQWqNTL6dbQDy0lmEkRUN
 joXodYrOcKbkqfzTIoyqQudRKcZb9wifzI1q3y4ux9uFqFMJAJ14rNSbOTFYi9+81VMidiA
 XalzMdusecCv2/tY7YzohwmxRT2hBQFVsgrnclo3Fx59Jy9zOqX1SGx6C2s121r1x/wKMvm
 GezIQbwFzVyfLsdmjvPc62UdnKaNmb38dNmyDoQKu6VcjeHdgagtdZIPTRvwaJYYUCHR3Zp
 gviEQraVGyVvSr/c4tgtvjixcB+0Wa/4HZI3E98AGMfBmgjGzMwlLzTkhLJHc6HDa3+rSB5
 R9bO8fYWdiisvK9WdM1E5MKe2uxeMdT0nf8rUGe0kovvquoRTgwyr8OK0JOEJT8ekSS51SX
 Cy8VH5QqjbsP7VnEQy9+W2F1DpvJ9OaSVEh16hJCBgl3GXG42Dq9t1Yd4aBOQp7GuIO64Yn
 PjwfFlpOBmyklQLfo0QElFqDmIIbPuGdBfRUEM/9/KO/+kyB+D1YCmDSifn1naUwMxTcvYB
 dq626V76ImMeMuMbuoTSG/pTetm8HtKHdhT0N48SkKcwCKW5GlBISV2AIV2paSPO21/1vu+
 pF+cZQ4PvXq+X8ppzI6bPixt9YwtB0oYOhoIjdlUtZaABbLCBfaOZ9ChO1Bimk6yA95ynno
 Q0bgSfuH9m/UcMYli0KB7OtTsIwBfXryyEJRYPgdfq6ytWLhgex9Mujd4ixhQT4Q4leTd8Y
 MBUbrbytQXCDRd4UPCIncZrDJjSrxFfUrdsH/34tEgqEBffSdhgamHqhB+Zg4gGdNoZ/hbm
 XnfedOo2UqLLRQiYmZx7sAfd51dyA864IjB7xFap6LEkIdjGk2piud+ioptyrpJW/kXqs0/
 XS8d3xnEIlXYGRftNvKXXzuNtrxMe0OQh+4eA1yqs02XBKAB0ZFMuCZbbGdPUQLgW1V2Jc0
 UF6KDflg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

Hi Xe maintainers,

We are looking for feedback on an Xe reclaim policy change motivated by
repeatable HDR 4K60 playback stalls on two 8 GiB Panther Lake systems.

The stalls occur after memory pressure causes the Xe shrinker to back up
pages from WC BOs which are still mapped through VM_BIND. Restoring one
of those BOs allocates WB pages and runs set_pages_array_wc(). The x86
CPA cache/TLB flush is synchronous while validation holds the BO's
dma-resv, so unrelated EXEC, VM_BIND and dma-buf operations can wait for
hundreds of milliseconds on the same reservation object.

This RFC skips non-purge reclaim for WC BOs while at least one GPUVA
mapping remains. It does not change object lifetime. VM_UNBIND, VM
destruction and process exit remove the mappings and drop the existing
VMA references, after which the BO is reclaimable or destroyed normally.
Purgeable BOs are not skipped.

The main questions for review are:

  - Is the presence of a GPUVA mapping an acceptable residency signal,
    or should the policy also require recent GPU activity?
  - Should severe reclaim be allowed to override this policy instead of
    keeping mapped WC BOs resident unconditionally?
  - Is an A/B module parameter useful for this RFC, or should the policy
    be expressed without a user-visible knob?
  - Would retaining a bounded number of converted WC pages in the TTM
    pool be preferable for the remaining allocation-time CPA latency?

Observed pre-change ioctl maxima were 549 ms for XE_EXEC, 291 ms for
XE_VM_BIND and 343 ms for DMA-BUF IMPORT. With this patch, a 21-minute
capture had no instance of those ioctls over 16.7 ms; maxima were 348 us,
136 us and 20 us. The ttm_tt_restore maximum fell from 80.6 ms to
8.33 ms, and the WC conversion rate fell by about 82 times.

The post-change run kept about 3 GiB MemAvailable. DMA-BUF accounting
also fell from 26 objects / 664 MiB to 21 objects / 544 MiB during
playback, confirming that normal unbind and destruction still release
the working set.

The patch is based on drm-xe-next commit 05649458e4bc ("drm/xe/bo:
optimise TT population for DONTNEED BOs").

Thanks,
Neil

Neil Zhong (1):
  drm/xe: keep VM-bound WC BOs resident during reclaim

 drivers/gpu/drm/xe/xe_defaults.h |  1 +
 drivers/gpu/drm/xe/xe_module.c   |  6 ++++++
 drivers/gpu/drm/xe/xe_module.h   |  2 +-
 drivers/gpu/drm/xe/xe_shrinker.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)


base-commit: 05649458e4bc2e45eb8d231a7a9b00dd6c9e8206
-- 
2.50.1 (Apple Git-155)
