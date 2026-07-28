Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD42C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D9110E7E5;
	Tue, 28 Jul 2026 07:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ugreen.com header.i=@ugreen.com header.b="ES6Ef4Zx";
	dkim-atps=neutral
X-Greylist: delayed 2198 seconds by postgrey-1.36 at gabe;
 Tue, 28 Jul 2026 06:55:55 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B5510E532;
 Tue, 28 Jul 2026 06:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1785221723;
 bh=HU/esAg819W3gAc7tI8fdkf8VNMCDHKEGVFowIVESso=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=ES6Ef4ZxFqxfRhm31KtpE88233JdNjrn/dyqk/6lAtZWqTN95RoDiHKQeb5/+bybw
 +PZ/cWIIK0JhDa1aRdobtubR5/1TQGApqiaLuzBe5zGDqeV7L2/FF/PX1bzqgRhXoU
 uF/FrdZK/pj9PFdUZ499HXx6TRNYft02icdrgQqs=
X-QQ-mid: esmtpgz16t1785221716t778db5a1
X-QQ-Originating-IP: E9gCfsExpx+aNqlwavsHwKrT2kBL1VM847UGLn0yPMU=
Received: from localhost.localdomain ( [113.90.157.158])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 28 Jul 2026 14:55:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2496392086044991614
From: Neil Zhong <neil.zhong@ugreen.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/1] drm/xe: avoid reclaim/restore stalls for VM-bound
 WC BOs
Date: Tue, 28 Jul 2026 14:55:11 +0800
Message-ID: <2039244986CAC5D2+20260728065512.59911-1-neil.zhong@ugreen.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NjiGCKSKQVBPnJtaYnCiLjawHdd4nTS/lbXph18/+JLYSP6Wr4tuV9E6
 mgzjTbb/WpDqNd6c6mpxvl7vVK+dXvtXlZh79UyrE5p7NkC4du6Y+Ncv8rPWEIVWnZUatek
 Vzs0I5/h0d7Y5h0uno5HjjNSuq+qdjCxVTohJHuq8P0evj20cVFgK9IGYbg7e73D7Fkfe9t
 KohtNkuOfs96vGHnCweNYImPuZc6mFTsysAYa6/1HgLSbUJENJiac2HHsL9Ja9rQN8alLMt
 EDUct+VTLs7zt4vEIrupfz+ZMrOC4RfdCfIBwAEyCmD6L4L8JujfWyK+6qVR/s8ZmstKIl7
 SozgnqsJ0bgYtkn7m6dlPSrV+Svt1qYMpJT78QZCzITvYrA/Z/h+B7rDmzXyFBj7K3vQRDG
 2tV4pjHkapMG9ptTFZ2BlZqnq6ykb2p2/L36jUBzq4A33u/xqI5uFwVePgLuLMcAxd53hu9
 XBh5SjssObYnNnSLVXWiyx6PcYaP1MG+uPZI8Yu/gSIVRSxsM+1wTzRMr90YIPk5R/ms0rz
 m39S/+AK/ZqBj2tBprjJf/ock5CkD7NIW+ASTIJxiItW0NHDa076k30BD129fiLvwvKuaYf
 MeQaadSRpq0hLmgrKDFeEiuu4WvI2jKMr6EX0jsR37KFcwcxVux+55jXM/k0vHGsW205Ynw
 TMvWMbZ/gP3e4rPRBHPE1WV671571QeRPA/EGQakL3hBQ4x+7Vgn2ViIhTRlRHOTqFJi0+1
 wAwmCpkE72U0UUbrpIA5KYcNEiJrdFJkcSGFMYQr9FAbslu7dO8RN3o7aG233dBZDB4oGJG
 7n4dkuluYqwj5EbTfbqfAtqgjN7PXnZibq2MuxgsIN3a0osg6rpbm7odqc7jaGtOZHZuGNs
 eYE2dQQe0Zs0bi4TSwlN+k9YIPKOQSOUjmycfeiIbEiDFEao+H+TlXJf2O9KEQHsmsfg+T3
 FevMaTS1MjSHCzwu16ufOWa+i0RW+XyPVfp6ssNT4uJ+3tqXA7301BMn4Rua+OcgM9gLuQc
 vbYtXR9OdMJ/lYAI9iMGrhDRzxavCnSO5y4DZOUyqlusm3eSIDh3iEsR5tvgs2dNbifDYV8
 0N2aXTSGpKh
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

Changes in v2:
  - Call ttm_bo_shrink_suitable() before the Xe-specific WC predicate,
    so ttm_bo->ttm is known to be non-NULL before checking its cache mode.

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
