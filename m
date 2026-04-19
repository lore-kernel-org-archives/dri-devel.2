Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0173DEA71A1
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 17:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0330F10E0A2;
	Sun, 19 Apr 2026 17:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dnG53VFq";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DDC10E0EA
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 16:12:36 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8d76492e51bso240031885a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776615155; x=1777219955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B17bAyfAm7uzzttww80XtUu6/K1MgSIE6Bs+vc9UHtw=;
 b=dnG53VFqOUIao/mXNGO3reJl1svsE5Gw+L+/ZtT75Fxj66GQsAkRHhUkkUYc5WGC1H
 yPsRTTHXpLCJVDLc0euwl3bSRzlvYNtLVSQg1MZoC3FV/kP8U2zdyoGzrYVhYHnwea7e
 oVPqV3WPQIYtQEnChmZyLbRr4WMTk12zS1tZVz6TJjB/MQ0PknmVNpUvFON3SlQs8OKY
 E1p7NXHjeHg/p2CFjs0wYboeRR2wOcRuB96empFyNmwi8LxgXQFgysUJRt0/hnLlRkh3
 qIXXj9jmIJTCxvygahQ2RbqmaxPJOQxssvH1Kjr54dJlRIgn1Y00vdR4aQhfEvwJFNYM
 Hg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615155; x=1777219955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B17bAyfAm7uzzttww80XtUu6/K1MgSIE6Bs+vc9UHtw=;
 b=nPYdL8fYCtOtgKpY2ZoJGbcJfqwuxEEW/AL8ayUFJIpzIv6Idcx0nZL4LpygteuL2j
 RGdFR3SdBHhNABUtGtSw5T//ZUYETXcaB/fay/wXNeMMdP+A2eAZyAYfbtPithmBrvIW
 xHZjQwxkfXPJbi7Qi4KfOZhlPMTAKPUzE21mo4Z8STSLEJXibU9enixuhx7qn6CS1Lnf
 n2Ja01X842BaZvqmJF830NeIKRAZ5bKLw9Q3/9d/DefWLUGJg9PScPLuH527IdsHAL+T
 2dAeCOtzGjAZIX+/O3txrt+Z0hL6xYkBAoXWxB9Va661xupcxzjLqP8m7DSJmeO5gAtv
 jPIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UahThkT5aMjMPpQq2gkx1VptPIy/63kujmQ+iR4W6rx/kwYq7l7d38/qL8HgNnZNultnkWDBCXxA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/ji1g9iskzlWW9QOsrCJLj0ssQ73KNf60B/Qe5UAUmcO1yP1B
 UkAGA9zFBrlqB43rTkQU/rfh7XYwlEp4SJa6RwCo4VXy6mANIe7SeaD+
X-Gm-Gg: AeBDievvDoPhfBJ18RpRkxWiySXsM+mKkp5/ALAM9y2XkpQW7z3+qkpkTB3eJ0RC50s
 bcEFvIsBMbuwhnlCqM1jEa3DdT262Zlhq9pCwtv7BLY/a6AVe6BYA4UumSR8OWA4E0le3wkwOOp
 YWGNF36NyCltDWNRt+n8CdTyVBIjzOVq0m+rJiFDnzL3fB41y0W6WtH0JuIwVeVroX/cHFB9TJT
 jgMjSmArpuiPOt+JjUT70oHWDBHe+xZ+Rz1QcqzhPjGjfQZIUCs3xKLkoLfo3J8DkzTtdLCAMvv
 /wVkMPtDqKht1jBYQAnA9A8xsWTJH6TpmriO2ksNMBN2s317q354p0CdTi3V+grNbHoVJUGc1zp
 gJROqI19hlmfW0uPhEhecSwDSW9eqPke4jTm5Uwly/GhkEshAvfmu1oVvTP7/OTzmuHQYiJIV9n
 Nd4BAJuT8lww+1I8dBVgbokry5y22JZRYgRZ2VEFfdCO7wB+GggPLmer7xdGSlyInbUL4drcXrH
 9zQOQT0geLQ0o5K4HjQIpxwpL10UpM=
X-Received: by 2002:a05:620a:2844:b0:8b2:1ee9:dcfb with SMTP id
 af79cd13be357-8e78f82cf5emr1427279685a.8.1776615155112; 
 Sun, 19 Apr 2026 09:12:35 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb795sm598271385a.25.2026.04.19.09.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:12:34 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Sam Day <me@samcday.com>,
 Christian Brauner <brauner@kernel.org>,
 Ingo Rohloff <ingo.rohloff@lauterbach.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Kees Cook <kees@kernel.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] usb: gadget: f_fs: serialize DMABUF cancel against request
 completion
Date: Sun, 19 Apr 2026 12:12:27 -0400
Message-ID: <20260419161227.1587668-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 19 Apr 2026 17:04:30 +0000
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

ffs_epfile_dmabuf_io_complete() calls usb_ep_free_request() on the
completed request but leaves priv->req, the back-pointer that
ffs_dmabuf_transfer() set on submission, pointing at the freed
memory.  A later FUNCTIONFS_DMABUF_DETACH ioctl or
ffs_epfile_release() on the close path still sees priv->req
non-NULL under ffs->eps_lock:

    if (priv->ep && priv->req)
            usb_ep_dequeue(priv->ep, priv->req);

so usb_ep_dequeue() is called on a freed usb_request.

On dummy_hcd the dequeue path only walks a live queue and
pointer-compares, so the freed pointer reads without faulting and
KASAN requires an explicit check at the FunctionFS call site to
surface the use-after-free.  On SG-capable in-tree UDCs the
dequeue path dereferences the supplied request immediately:

  * chipidea's ep_dequeue() does
    container_of(req, struct ci_hw_req, req) and reads
    hwreq->req.status before acquiring its own lock.
  * cdnsp's cdnsp_gadget_ep_dequeue() reads request->status first.

The narrower option of clearing priv->req via cmpxchg() in the
completion does not close the race: the completion runs without
eps_lock, so a cancel path holding eps_lock can still observe
priv->req non-NULL, race a concurrent completion that clears and
frees, and pass the freed pointer to usb_ep_dequeue().  A slightly
longer fix that moves the free into the cleanup work is needed.

Same class of lifetime race as the recent usbip-vudc timer fix [1].

Take eps_lock in the sole place that mutates priv->req from the
callback direction by moving usb_ep_free_request() out of the
completion into ffs_dmabuf_cleanup(), the existing work handler
scheduled by ffs_dmabuf_signal_done() on
ffs->io_completion_wq.  Clear priv->req there under eps_lock
before freeing, and only clear if priv->req still names our
request (a subsequent ffs_dmabuf_transfer() on the same
attachment may have queued a new one).

This keeps the existing dummy_hcd sync-dequeue invariant: the
completion callback is still invoked by the UDC without
eps_lock held (dummy_hcd drops its own lock before calling the
callback), and the callback now takes no f_fs lock at all.
Serialization against the cancel path happens in cleanup, which
runs from the workqueue with no f_fs lock held on entry.

The priv ref count protects the containing ffs_dmabuf_priv:
ffs_dmabuf_transfer() takes a ref via ffs_dmabuf_get(), cleanup
drops it via ffs_dmabuf_put(), so priv stays live for the
cleanup even after the cancel path's list_del + ffs_dmabuf_put.

The ffs_dmabuf_transfer() error path no longer frees usb_req
inline: fence->req and fence->ep are set before usb_ep_queue(),
so ffs_dmabuf_cleanup() (scheduled by the error-path
ffs_dmabuf_signal_done()) owns the free regardless of whether
the queue succeeded.

Reproduced under KASAN on both detach and close paths against
dummy_hcd with an observability hook
(kasan_check_byte(priv->req) immediately before usb_ep_dequeue)
at the two FunctionFS cancel sites to surface the stale-pointer
access; the hook is not part of this patch.  The KASAN
allocator / free stacks in the captured splats identify the
same request: alloc in dummy_alloc_request, free in
dummy_timer, fault reached from ffs_epfile_release (close) and
from the FUNCTIONFS_DMABUF_DETACH ioctl (detach).  With the
patch applied, both paths are silent under the same hook.

The bug is reached from the FunctionFS device node, which in
real deployments is owned by the privileged gadget daemon
(adbd, UMS, composite gadget services, etc.); it is not
reachable from unprivileged userspace or from a USB host on the
cable.  FunctionFS mounts default to GLOBAL_ROOT_UID, but the
filesystem supports uid=, gid=, and fmode= delegation to a
non-root gadget daemon, so on real deployments the attacker may
be a less-privileged service rather than root.

Fixes: 7b07a2a7ca02 ("usb: gadget: functionfs: Add DMABUF import interface")
Link: https://lore.kernel.org/all/20260417163552.807548-1-michael.bommarito@gmail.com/ [1]
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/usb/gadget/function/f_fs.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 815639506520..75912ce6ab55 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -150,6 +150,8 @@ struct ffs_dma_fence {
 	struct dma_fence base;
 	struct ffs_dmabuf_priv *priv;
 	struct work_struct work;
+	struct usb_ep *ep;
+	struct usb_request *req;
 };
 
 struct ffs_epfile {
@@ -1385,6 +1387,21 @@ static void ffs_dmabuf_cleanup(struct work_struct *work)
 	struct ffs_dmabuf_priv *priv = dma_fence->priv;
 	struct dma_buf_attachment *attach = priv->attach;
 	struct dma_fence *fence = &dma_fence->base;
+	struct usb_request *req = dma_fence->req;
+	struct usb_ep *ep = dma_fence->ep;
+
+	/*
+	 * eps_lock pairs with the cancel paths so they cannot pass a freed
+	 * req to usb_ep_dequeue().  Only clear if priv->req still names ours;
+	 * a re-queue on the same attachment may have taken that slot.
+	 */
+	spin_lock_irq(&priv->ffs->eps_lock);
+	if (priv->req == req)
+		priv->req = NULL;
+	spin_unlock_irq(&priv->ffs->eps_lock);
+
+	if (ep && req)
+		usb_ep_free_request(ep, req);
 
 	ffs_dmabuf_put(attach);
 	dma_fence_put(fence);
@@ -1414,8 +1431,8 @@ static void ffs_epfile_dmabuf_io_complete(struct usb_ep *ep,
 					  struct usb_request *req)
 {
 	pr_vdebug("FFS: DMABUF transfer complete, status=%d\n", req->status);
+	/* req is freed by ffs_dmabuf_cleanup() under eps_lock. */
 	ffs_dmabuf_signal_done(req->context, req->status);
-	usb_ep_free_request(ep, req);
 }
 
 static const char *ffs_dmabuf_get_driver_name(struct dma_fence *fence)
@@ -1699,6 +1716,10 @@ static int ffs_dmabuf_transfer(struct file *file,
 	usb_req->context  = fence;
 	usb_req->complete = ffs_epfile_dmabuf_io_complete;
 
+	/* ffs_dmabuf_cleanup() frees usb_req via these two fields. */
+	fence->req = usb_req;
+	fence->ep = ep->ep;
+
 	cookie = dma_fence_begin_signalling();
 	ret = usb_ep_queue(ep->ep, usb_req, GFP_ATOMIC);
 	dma_fence_end_signalling(cookie);
@@ -1708,7 +1729,6 @@ static int ffs_dmabuf_transfer(struct file *file,
 	} else {
 		pr_warn("FFS: Failed to queue DMABUF: %d\n", ret);
 		ffs_dmabuf_signal_done(fence, ret);
-		usb_ep_free_request(ep->ep, usb_req);
 	}
 
 	spin_unlock_irq(&epfile->ffs->eps_lock);
-- 
2.53.0

