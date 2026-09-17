Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7423C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8043E10F1DB;
	Fri, 18 Sep 2026 07:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p2SoVuPi";
	dkim-atps=neutral
Received: from mail-vs2-f31.google.com (mail-vs2-f31.google.com
 [74.125.227.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFC710E4F6
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:36:10 +0000 (UTC)
Received: by mail-vs2-f31.google.com with SMTP id
 71dfb90a1353d-5c67e512ee5so319571e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789662969; x=1790267769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=22vAnO/NdhoyxOh5BfKieSuetSOebs9QwAExSEe28JI=;
 b=p2SoVuPibIJsq3Ddpd0WQ0cUNUEnqJa8VZumJLVqQ/dIC8ai1IvBk0b1wZ9xu42Lcu
 zz/cSDGBPGG/2zqynFg2w1D8DCjNPIvMpjRz6Y9CXZ5SuyEbS2+Dv81EV/MsO9RWa5n/
 +3IdMMpOIHASGdTHJnOc8vEnIMxqPnhZvxNesy6TraldxuhUrJzaehBjXnpN2lp8kzPG
 zSMgdHmZ5BZuyVMD4zRGzpN3yqyZw7hb+FWJc67/26vnRIvREzQ8Js59fnmweCHScQpJ
 Qn1DjJQ9cfEEC0h6FKMdbtx2cKm68JJu/jNs90z4xpfVGX5ZrfGxtRjazjXoLfpjBvZW
 xj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789662969; x=1790267769;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=22vAnO/NdhoyxOh5BfKieSuetSOebs9QwAExSEe28JI=;
 b=nCIQYtlptq4HiGbM0lsq58/RqwTcWhxDvyONLbKktI9FUGl3AS2CIX9392GMhM+Sx9
 MfNdY61MVAaVVG2d7nC+tfBlHJptMRkvCLKxGZZ/Nw8VYGeTyt/yFdnjT0691oBdgsBH
 84CFGXFXMHxvKU+Vb35eCVsku4G1m32EbOaTUAK4hhIY/MhEmyrqDpZb/0TVPSUqT0st
 hfuL9TlWr672w75Psnx228Yu0vLkueQzDr+cI0tyeEUHenjKYcbinxOam8/UNY6Dpqm6
 Wd0sLis6SStbnvuEx1GqDNWQzKfmkfh9mu/mESgM1e376lToyStb0S8CplBDXqMQlDC2
 ah3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByI4QDsP1a/g80h0d1aNjVk8JNiVM22rzxAhhQ/s3uyGIrfhVwJ/wxReRM5xVx3aaGlmCpSeN39EZA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsQiRBo9iC3+b25Ki1NxbCTwnZuqRlZv0Di/U2mjZLeU0rNcRx
 aMq27+0naUXWmM5ywxCvrswAagWICzcO4DTu56w0PUBiFNMAD0WyKjlP
X-Gm-Gg: AYBFou3rR/iMKwtOvvf5y9QRLaxyr0HEJP4gdk4NpUz4BFDx326/uPjiNzHxpDGS24c
 uK9Ui7x8h5GKA+wps2GhctGXaiP1qsRU0ErvmR+9BIHC0hQ8jziiqfgqt4GEOqQgjSHtHViQ+M1
 QxUe9QagrEmOKq7jvoU+Xuk7N+gnfBxN+mfbn/9iW1xgA87nFPvvKFjCEmjZ5tStyU1W8TZ5TvM
 TpLcwJVKScHpP6hnYqtYvlQjFBkf8G5L6eEHpG6hMkXsUCSW7clu+snhyn6WJ8vf8QUUIqa8dok
 I6F3fXD9a2f4DEbCckRJD0TbBINrl+GvvKGvvLM+BnFisudqBgkmgq2ybLdgVtX2/LRi7TdntDe
 eykcQFnJFgJG7/sHxmTc++x7+jXWxdZh5aBowwjwoPeTuqwpJ0uE8LpUdn7EOwQdTGsDadk+Pwi
 /Qj+ze6y9BOFjALsnGD9GGQ9vacOMlkPMORLJDADuW4A6rz4g+vMKzfW5z6Ee/0B9aDOv9+O7r0
 NB792OoRniJQ74O7UnQKVLzjlyEOL0uqcAHygSJCrE5TGVZyrqLAji/jA==
X-Received: by 2002:a05:6122:1806:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5c9a60d39bemr2393082e0c.14.1789662969650; 
 Thu, 17 Sep 2026 09:36:09 -0700 (PDT)
Received: from lord ([170.246.209.50]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9a53b2ba1sm3065363e0c.8.2026.09.17.09.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:36:09 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 jani.nikula@intel.com, navonjohnlukose@gmail.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v4 2/3] drm/xe: Log when a timed out TLB invalidation ack
 finally arrives
Date: Thu, 17 Sep 2026 13:35:52 -0300
Message-ID: <20260917163553.1742580-3-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917163553.1742580-1-talesam@gmail.com>
References: <20260917163553.1742580-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

When a TLB invalidation fence times out we log the timeout, but if the
ack for that seqno later shows up there is no record of it, making it
impossible to tell from logs whether the ack was lost forever or merely
(very) late.

Track the most recent timed out seqno and log how late its ack arrives,
relative to both the original request and the moment the fence was
signaled with -ETIME.

On ARL with GuC 70.53.0 this shows the acks are never lost: they
consistently arrive ~2.3s after the request, tens of milliseconds after
the TDR has already signaled the fence:

  TLB invalidation fence timeout, seqno=10992 recv=10991
  TLB invalidation late ack: seqno=10992 recv=10992,
    request-to-ack=2314ms, timeout-to-ack=45ms

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
---
 drivers/gpu/drm/xe/xe_tlb_inval.c       | 19 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index 7a0c04fac60..7047a347551 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -14,6 +14,7 @@
 #include "xe_guc_tlb_inval.h"
 #include "xe_mmio.h"
 #include "xe_pm.h"
+#include "xe_printk.h"
 #include "xe_tlb_inval.h"
 #include "xe_trace.h"
 
@@ -99,6 +100,11 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
 			fence->seqno, tlb_inval->seqno_recv);
 
 		timedout_seqno = fence->seqno;
+		if (!tlb_inval->timedout_seqno) {
+			tlb_inval->timedout_seqno = fence->seqno;
+			tlb_inval->timedout_inval_time = fence->inval_time;
+			tlb_inval->timedout_time = ktime_get();
+		}
 
 		fence->base.error = -ETIME;
 		xe_tlb_inval_fence_signal(fence);
@@ -227,6 +233,7 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
 	else
 		pending_seqno = tlb_inval->seqno - 1;
 	WRITE_ONCE(tlb_inval->seqno_recv, pending_seqno);
+	tlb_inval->timedout_seqno = 0;
 
 	list_for_each_entry_safe(fence, next,
 				 &tlb_inval->pending_fences, link)
@@ -454,6 +461,18 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
 
 	WRITE_ONCE(tlb_inval->seqno_recv, seqno);
 
+	if (tlb_inval->timedout_seqno &&
+	    xe_tlb_inval_seqno_past(tlb_inval, tlb_inval->timedout_seqno)) {
+		ktime_t now = ktime_get();
+
+		xe_warn(xe,
+			"TLB invalidation late ack: seqno=%d recv=%d, request-to-ack=%lldms, timeout-to-ack=%lldms",
+			tlb_inval->timedout_seqno, seqno,
+			ktime_ms_delta(now, tlb_inval->timedout_inval_time),
+			ktime_ms_delta(now, tlb_inval->timedout_time));
+		tlb_inval->timedout_seqno = 0;
+	}
+
 	list_for_each_entry_safe(fence, next,
 				 &tlb_inval->pending_fences, link) {
 		trace_xe_tlb_inval_fence_recv(xe, fence);
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
index d77be1aedc9..80d2019fa20 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
+++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
@@ -112,6 +112,23 @@ struct xe_tlb_inval {
 	 * @pending_lock: protects @pending_fences and updating @seqno_recv.
 	 */
 	spinlock_t pending_lock;
+	/**
+	 * @timedout_seqno: seqno of the most recent timed out TLB
+	 * invalidation, 0 if none. Used to measure how late the ack for a
+	 * timed out invalidation actually arrives. Protected by
+	 * @pending_lock.
+	 */
+	int timedout_seqno;
+	/**
+	 * @timedout_inval_time: request time of @timedout_seqno. Protected by
+	 * @pending_lock.
+	 */
+	ktime_t timedout_inval_time;
+	/**
+	 * @timedout_time: time @timedout_seqno was signaled with -ETIME.
+	 * Protected by @pending_lock.
+	 */
+	ktime_t timedout_time;
 	/**
 	 * @fence_tdr: schedules a delayed call to xe_tlb_fence_timeout after
 	 * the timeout interval is over.
-- 
2.55.0

