Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2839BFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF4C10E8C6;
	Mon, 27 Apr 2026 18:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="eirIR8rc";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CD810E8C6
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=DEvjTnuToY1sm0DpgUIVOaDKJXu5b04Nj+3IlevEBIg=; b=eirIR8rc8D1wzx5NBo9ydvEQjC
 BDJJcZMHpyrJsKJKHvV2bSr0twcYt/sKxtWL6QBQ1Aej9lwaSg1qNfsjgyM6vbwybEawpmk7h+rDx
 UN7g/OwQJ6XcaW4btAWItcMsw9Kpa+6F5a30Ril+Qgtn7+SFZYfWHGhtmgS05Is7Tj5mblrorODP5
 +NJFoLGBt0CTsvF968IaoDccuHwFhiC2zagyshXhMSYtepRUL8rJPaSeCNq2dCupMYjDa1eV8cvFf
 N2gT9udYgl/cfJUC6UPWlPKv2V5R95g3HzpBMQNPhyN8MCa3pZIBjSSEGubJuTPRYN0H8vaDK8qH+
 zi+EUsuA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wHQl3-0000000Ha2H-2RpQ; Mon, 27 Apr 2026 18:32:37 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org
Subject: [PATCH v3] gpu: ipu-v3: clean up kernel-doc warnings
Date: Mon, 27 Apr 2026 11:32:36 -0700
Message-ID: <20260427183236.656902-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Correct all kernel-doc warnings:
- fix a typedef kernel-doc comment
- mark a list_head as private
- use Returns: for function return values

Warning: include/video/imx-ipu-image-convert.h:31 struct member 'list' not
 described in 'ipu_image_convert_run'
Warning: include/video/imx-ipu-image-convert.h:40 function parameter
 'ipu_image_convert_cb_t' not described in 'void'
Warning: include/video/imx-ipu-image-convert.h:40 expecting prototype for
 ipu_image_convert_cb_t(). Prototype was for void() instead
Warning: include/video/imx-ipu-image-convert.h:66 No description found for
 return value of 'ipu_image_convert_verify'
Warning: include/video/imx-ipu-image-convert.h:90 No description found for
 return value of 'ipu_image_convert_prepare'
Warning: include/video/imx-ipu-image-convert.h:125 No description found for
 return value of 'ipu_image_convert_queue'
Warning: include/video/imx-ipu-image-convert.h:163 No description found for
 return value of 'ipu_image_convert'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
v2: add Reviewed-by, update Cc: list, rebase, resend
v3: rebase & resend

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org

 include/video/imx-ipu-image-convert.h |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- linux-next-20260427.orig/include/video/imx-ipu-image-convert.h
+++ linux-next-20260427/include/video/imx-ipu-image-convert.h
@@ -27,12 +27,13 @@ struct ipu_image_convert_run {
 
 	int status;
 
+	/* private: */
 	/* internal to image converter, callers don't touch */
 	struct list_head list;
 };
 
 /**
- * ipu_image_convert_cb_t - conversion callback function prototype
+ * typedef ipu_image_convert_cb_t - conversion callback function prototype
  *
  * @run:	the completed conversion run pointer
  * @ctx:	a private context pointer for the callback
@@ -60,7 +61,7 @@ void ipu_image_convert_adjust(struct ipu
  * @out:	output image format
  * @rot_mode:	rotation mode
  *
- * Returns 0 if the formats and rotation mode meet IPU restrictions,
+ * Returns: 0 if the formats and rotation mode meet IPU restrictions,
  * -EINVAL otherwise.
  */
 int ipu_image_convert_verify(struct ipu_image *in, struct ipu_image *out,
@@ -77,11 +78,11 @@ int ipu_image_convert_verify(struct ipu_
  * @complete:	run completion callback
  * @complete_context:	a context pointer for the completion callback
  *
- * Returns an opaque conversion context pointer on success, error pointer
+ * In V4L2, drivers should call ipu_image_convert_prepare() at streamon.
+ *
+ * Returns: an opaque conversion context pointer on success, error pointer
  * on failure. The input/output formats and rotation mode must already meet
  * IPU retrictions.
- *
- * In V4L2, drivers should call ipu_image_convert_prepare() at streamon.
  */
 struct ipu_image_convert_ctx *
 ipu_image_convert_prepare(struct ipu_soc *ipu, enum ipu_ic_task ic_task,
@@ -122,6 +123,8 @@ void ipu_image_convert_unprepare(struct
  * In V4L2, drivers should call ipu_image_convert_queue() while
  * streaming to queue the conversion of a received input buffer.
  * For example mem2mem devices this would be called in .device_run.
+ *
+ * Returns: 0 on success or -errno on error.
  */
 int ipu_image_convert_queue(struct ipu_image_convert_run *run);
 
@@ -155,6 +158,9 @@ void ipu_image_convert_abort(struct ipu_
  * On successful return the caller can queue more run requests if needed, using
  * the prepared context in run->ctx. The caller is responsible for unpreparing
  * the context when no more conversion requests are needed.
+ *
+ * Returns: pointer to the created &struct ipu_image_convert_run that has
+ * been queued on success; an ERR_PTR(errno) on error.
  */
 struct ipu_image_convert_run *
 ipu_image_convert(struct ipu_soc *ipu, enum ipu_ic_task ic_task,
