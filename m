Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89597CDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837D910F473;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rOsxvKcD";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE7F10E1C9
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:57:29 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-6647c26a4a3so1104994d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782377848; x=1782982648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HXBGWP+mHV9r0WWwErucYsy42UpdRmWv6NJcEbVBLI=;
 b=rOsxvKcDGJv6fs1bH3Mh9h+xH7Uo0p5w8AfnYxe4DP8QN7dAmphmb1MyCiLQUVhTnn
 /XSV3LvxhRKeaokcm62M2M6Cna1hMw6nckiBpSnJqPAyvnOy5Y+jXy+oKuULW1ovUrGR
 PYNEftspBHDN09eKClnqNxDsPKphVb1ndyzxfPMFdIfECDdGTW4wj8uZu+/RvfbCzUcG
 s3YSzF13YqY9vpVSvnuJpqZlrms+UzAJwBeNjmtWJ0Vu2tctt1UtuCVii5D3troGltcm
 z/uM41H9X0Laz/QuN8hask84LO1foiTYMGWniCb2Yu5DXuIIKbG4PD+nH1WaDo8abCqh
 EQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377848; x=1782982648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3HXBGWP+mHV9r0WWwErucYsy42UpdRmWv6NJcEbVBLI=;
 b=bS749QUh+bUfj2NLnI0fV7Kc654t8E+dDT8tdqv7S1KKLzgP1SeM9Wr0R4lGf8VgI2
 7+rqxcpadaj4PV3JBQX+V96SrXdCDbWnFvbwYFSNQAV47iGUecgMyFUAYVOl0jcwU+Di
 MyH3v6ezHgmV1+J3yke2DrqOgjVyBcm74xEyRyPqPAGDRfTrmBTCk/+PQgIIHMGVy7AP
 TOkjZiAxbPLU1n4biq0j+q66Jp1BzEVdMDcI45Cs9hmyObG8cG78OU7xxUvL+dyhB8zi
 qjqDWsewv2x2Y0m926o0KQ0Q93588T1aZNnENoiq1xI376bPcQzDGdeq6YVuFe+bB62K
 Xu0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqtBpRFE+dH8lSKvvwLsRSBPdKKDp+SCvQ6ZY968ly3DuCEO0vytV1cck25KFJnV2AiaFoTeGFwh0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj8M7PjA+m2d5tjAYbjt7q1rDtFSL/9LSHUDfFJ8MOWfodocyZ
 Jrp2pbQioNKSmAc5OllIpxDFGRRIt+egj6S6liiDhqqVcS1rFffzVXYV
X-Gm-Gg: AfdE7clTG2vfHjs0Vvo6Nzh1Mg8SWKhjWI0j1FNAjSPYTFhv4iYPa58N3voUOsNTVsU
 mlB2yHf+om4JJvABjCr/Tf2zf6bhOaXPvZUBLgqrAiqQxn2HuIdhjEY7Uh5zGtYSfVn35pA6M/s
 UWcZ7rzXiFqYW3gRtNcWLx1FTFpQczEg7ui/vMTQakLdEqjgbe1PihuBc7UIqIljJiyjI/35MRJ
 Z3UfeBAc4iTz1Maf1nbr2b18PLhVbp/4BUmRT9EVaRAdPoF0msaspbH7B0UFgFSrBu41ohPO3qK
 Q0QNj3EadpxtB60J7B1PG4nKPiQKNU8OvAz06DZhvLSqp3t8JPPjouChJa6khaleOv87nY0XDz5
 D+NktJLY7q6GLYdrzZr7rN40DdOkqTXENfoBMh07amBQxkTpFGi2q4H8q2BbDylVzL27NGN6pOu
 gEvUqEuU72GN3bJ/9BL4ENdKHTAw==
X-Received: by 2002:a05:690e:b4a:b0:660:ffe0:2df7 with SMTP id
 956f58d0204a3-66487c28ae6mr1186398d50.23.1782377847966; 
 Thu, 25 Jun 2026 01:57:27 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6647f785f6bsm1105061d50.6.2026.06.25.01.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:57:27 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 3/3] misc: fastrpc: protect interrupted mmap cleanup
Date: Thu, 25 Jun 2026 10:56:59 +0200
Message-ID: <20260625085659.4469-3-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625085659.4469-1-alhouseenyousef@gmail.com>
References: <20260625085659.4469-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

The interrupted invoke path walks and moves fl->mmaps without holding
fl->lock, racing concurrent mmap and munmap operations that use the same
list. Move the buffers while holding the user lock and use list_del_init()
so later cleanup can safely identify moved nodes.

Buffers moved to the channel interrupted list are also discarded on rpmsg
removal without freeing their coherent DMA allocations. Free them during
channel removal so interrupted invokes cannot permanently leak DMA buffers.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 50f90e17e..608878052 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1395,10 +1395,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 
 bail:
 	if (err == -ERESTARTSYS) {
+		spin_lock(&fl->lock);
 		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
-			list_del(&buf->node);
+			list_del_init(&buf->node);
 			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
 		}
+		spin_unlock(&fl->lock);
 	}
 
 	/* We are done with this compute context */
@@ -2628,8 +2630,10 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
-	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
-		list_del(&buf->node);
+	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node) {
+		list_del_init(&buf->node);
+		fastrpc_buf_free(buf);
+	}
 
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
-- 
2.54.0

