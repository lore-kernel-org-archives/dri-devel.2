Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E001A109446E
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 11:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346B510E251;
	Sat, 21 Mar 2026 11:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="ywSd66Uw";
	dkim-atps=neutral
X-Greylist: delayed 460 seconds by postgrey-1.36 at gabe;
 Sat, 21 Mar 2026 11:06:12 UTC
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CC310E251;
 Sat, 21 Mar 2026 11:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1774091170;
 bh=kDysuZ/sz32qVE18mBLkk7WL702+dG/9fna8ZhLYBpU=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=ywSd66UwFPwV4h8vGCaoHXKH796Jt1vv7IOJjM+nOedWBjEt2+XkTlQAKapEbv8e3
 mCssZZLib/HzBfev6MWM4B4BOo2kH8RNlga4JaAvOr0ldG8kMV7oDw4EId/wF48Hq2
 OTFPmfYLwqj3ty2pTUCyqpQMIckFCIMPBYeujT/M=
X-QQ-mid: zesmtpsz9t1774090656ta6086d6a
X-QQ-Originating-IP: LVy3dnYOiA9pf1Xme6SfgEJkFwBB0Hbmkt7OsA+5xis=
Received: from localhost.localdomain ( [116.172.93.199])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 21 Mar 2026 18:57:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12091318665540782229
EX-QQ-RecipientCnt: 14
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, kexinsun@smail.nju.edu.cn,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: [PATCH] drm/i915: fix outdated i915_vma_get_fence() references in kdoc
Date: Sat, 21 Mar 2026 18:57:33 +0800
Message-Id: <20260321105733.6391-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MAlUHnGeA8XKToyLYZNgiGpYerZFiPHxbOI5aNG6Nqs0GcLSgoKIPc0t
 jl3ym0VdO6R+z///99SvDo7J9D7f10RFMYY5sXdzlCHpgXnTqcxzVFXlKd0u0GTzJtEUWw1
 9K8zaZB1VyiWDTFZEa3gYYbjK88KzOHlC6fbBOYfygasBEQD7lv3ZgW04JCXa1qf3VeNEsa
 TBhDSpM8TsMPMptMBtOII7ICQFmcCfc7hMC6oII/yl/7EtpKEKmMw4G/Ra5sW9x9uhQaQ/1
 kCkSS4bI8/a69Jk8Hl58tuXavjoL3yvtN15EHlbvastLMl/01Kah02oHloYCAr8wHX0SOtu
 pC5o1cVKmYAjdorepJdbIlYukWvl2xXsTzWmxqAoGnoPnNQS0qjJIIlctCkXMTy2uVKmE7n
 XTN4bF816/l4QAaWE4s9uJ+urSQb7fcs6kxAnLzwRGEbqGYz3/If3sTRWp2U/j8c2XHu8R2
 iBDPVavndDuBtOZvkyuEavh/w5ZCAMwSCA2YmP6lBrZzAmZc2DjfoO9B1YBkKhie+Kt8fEw
 3JpTi54QOJF7ATuUwoQ1PIMsECdtYQXRlGMBSSy86p5GGgmqOBhrNhDO8CPYXd4gq5dIogt
 G8GzdgVktGhZWKN9ERM4+uqcCi23bmq3XbZUNotkJygvGI6NSl2vULzXsD+AIiW9RPv4tvz
 Re1X5gXVXpvPqHYyfcCjc5GcAsweps84aOg0+KmvLbArkJ5UgUm7YZcanVYmg87/+MHTzHd
 tsCn+REWsosGyYNuktWqv6InyMimneKKMATZxpbXcGXdXsFZpL3gR6+lnbLbhnz2nkSfl8D
 qOFcx2L0Yeo/Q5XocYxo2+F2CNS9ewPFpDA9q4H5e/qGoiEjdiBo9cDcaPEpQI1H7jDysZZ
 QqFoCxPmBrnt/IjSIuvv1PtqP7qWTJdaqIuTQ6Hfh+S+mA1kUOAokT3vQ/3Uq1yR63dHG7x
 Q8Mm5lTGXfaSJOaITpfP3YOS1p0QVv+s2h82KpmTDU9ZCHSeqMLKsEC4uY1epXjvHnKiz0p
 u6EleKYwpfB3CIQTkSwbLCDytD95X5QwHVaBVEmLbT4FYxlPcfrtU8GTJkTUs5AONc1INLM
 5zsB5uDP4Mz1jsv5eGcBV2tEOccbzwxNw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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

The function i915_vma_get_fence() was merged into
i915_vma_pin_fence() by commit 3bd4073524fa ("drm/i915:
Consolidate get_fence with pin_fence").

Remove the stale sentence that tells callers to synchronize
fencing state by calling i915_vma_get_fence() first, and fix
the Returns description: i915_vma_pin_fence() returns int
(0 on success, negative error code on failure), not bool as
the old i915_vma_get_fence() did.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/gpu/drm/i915/i915_vma.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.h b/drivers/gpu/drm/i915/i915_vma.h
index 8054047840aa..14ad66f8b398 100644
--- a/drivers/gpu/drm/i915/i915_vma.h
+++ b/drivers/gpu/drm/i915/i915_vma.h
@@ -369,14 +369,13 @@ void i915_vma_unpin_iomap(struct i915_vma *vma);
  * @vma: vma to pin fencing for
  *
  * This pins the fencing state (whether tiled or untiled) to make sure the
- * vma (and its object) is ready to be used as a scanout target. Fencing
- * status must be synchronize first by calling i915_vma_get_fence():
+ * vma (and its object) is ready to be used as a scanout target.
  *
  * The resulting fence pin reference must be released again with
  * i915_vma_unpin_fence().
  *
  * Returns:
- * True if the vma has a fence, false otherwise.
+ * 0 on success, negative error code on failure.
  */
 int __must_check i915_vma_pin_fence(struct i915_vma *vma);
 void i915_vma_revoke_fence(struct i915_vma *vma);
-- 
2.25.1

