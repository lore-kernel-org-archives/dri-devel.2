Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8F9CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC18410F12C;
	Thu, 25 Jun 2026 07:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MeNzj2GZ";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173C510E10D
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 21:54:42 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-7dd5a8dc8a2so12161457b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782338081; cv=none;
 d=google.com; s=arc-20260327;
 b=ijSH0n20ramr5BUXoQv6Dyh1ngRgYaYxy4J/cnqs02eYznbD0lGz8TDDS/eogkwn2t
 h2puXxYmVN2mdBqeaCfou4JRJHt++JxTE846TW4cEfFPc7g6VQchTFY+p1D4+EmjJn2n
 YON8/7a7HDFM/v6n3lA7IcI1EyVVUrVx9TuP6/C1wDGk90fLjNAUPYeTLFKKnviZk3HO
 M7GpYRkHkSAfYyVutK+00P8rRq2mAebHFbzZH0NzrjxSLNEnDP/4k9+dfkJFZYxF2Z6Y
 rv2DY85Skn9OE0c1ty+rIxgR74NC//RyWH8JfYnEXzq/IBO7gEpEv4TVzx09rg+S8LxN
 TlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=Bh8+6SvsunFH7emI3915MXGw0/i4y8PizMc/TEhnjUg=;
 fh=YoE968zk1FLPGIMx3a2MxDc8T7oFORIljD2bQx93eLg=;
 b=Xz9Z5KwJVjD37v0P7Ep5CThnGGS+usTYvrUiKntaDm2R/zIoGxTLARhamNwUIEBXU3
 nIZvqS262oFv7Ui8jrNDbe49bOvGtl85IDHfSeIB3koeHy86H69KyUQOCiRwD9fdzHpk
 nsMQrJ/gmyqzIfO0tJ7eAmLFypr+TkJE70zuEQyxiBGcNbgjlObTuIDOC61iRz/M/u8L
 mpf+rKPtDCS5Ye3Of45lbZzq6EfTpfd2oG5VXV3ey2ACwKpcs35G1+NrBsLuTUSv0pCr
 46JLUjaIFoMcD8k6e46g9/ZPQXRUDQ7J6rPXiq70OKzi36KXvHZ+aPCKksa54thbacA8
 mY7w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782338081; x=1782942881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bh8+6SvsunFH7emI3915MXGw0/i4y8PizMc/TEhnjUg=;
 b=MeNzj2GZUj1Y1Ok5Jutm1YleRHyQVYiotPrQOBdVqOb/0aaWjVTcojmHaOqqr7aMDy
 gd9C6mnCzEOnlpfpdlmIVHtQ15fk2ljKpf2BIwiUEj1fc4WE3f82iJHmvkplS4/En8z1
 1cFvAYMk2hPmLLYfLTlzCaqKHaIN2/i2wvtLuzr++hlzDR14srsKhI+HPsp1Iwy30yH3
 Q9aQE3LCEByV7gfYycABVMJlE5+tv2f1n+OHM4A6r3xOz87pkS998VAeag7n19WRGLCQ
 DvqXW19fn3579JGH7eXnuiwCH8yziCg9P0JLWlsk2YbGC7/ntjuCrRfpFgWq7i5QB9ko
 EgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782338081; x=1782942881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bh8+6SvsunFH7emI3915MXGw0/i4y8PizMc/TEhnjUg=;
 b=Q+k+RXPL9IVQLhjvkne1kobdXLz6PPCUnaeUy0zDCAD435s58fWPCRAshaCZOyIU8Q
 In5khYW6OMvIx/Pp+1UxeMLkEI28agquRTGrB+uay3pKTI9cm8qEgKtQEP8TAZcbaDlc
 ynQ7PQNhyJDYXu1swic/Uq4nhlHs1ePjH2Yqy2o/L+vE+8J6Y/NfEqPCV12zM2vbTtdT
 axzp4tzdomHZk3tQWShtF1ReDSD8CB+cVkNPPQIKXRDQ5KFMcxELnRLlTXERm0lzAPJY
 idvBJ0zpK0c4/2sRn5fjnKQu258yy1ey3mxeTpu/u99WoiA6b0ktwxgGAjkQQVsqX9Ul
 a+Xg==
X-Gm-Message-State: AOJu0YzuOFst5RBCiSzBCJ8ZnVhySRocXBXfQQY/Z0bU4OeswUidRN+1
 ecPABoqVJTXY9qJcX1Be8g2jPwa2m5gxnOKXwbj0baXnO2cey+U+YO8U1FxtuQyaNxPzASVg82I
 sXQ2ZFUBqidkVoiyd+hQcwo7sRtjDsMA=
X-Gm-Gg: AfdE7cn5ctrhAz3iaN9UBasU1A4YGTd4+6dDDxHXhktzwdvLdnc5hLbjBKXd8hIe4vL
 228oVJRQh3peN0FTlEvqEhlqSjdxkzKCOj0z8/fGJa69t8qV/uITkFjdg/YfQ1n0mtYuPf5priQ
 LACqgoBRPzAJQCP57JLT6f4bO7uIABqgyFO6iqqLxHzC8TjeY39dyrDfc7DzsM79WDi/7tOiWwD
 RxQ66PjPxImnZ2BGTqLy86sJiUdtdkD9HrVlK+AHO5U+XYi438Kzw7oCdLvvFzeybzefKg/
X-Received: by 2002:a05:690c:7248:b0:7bd:8ce4:92b with SMTP id
 00721157ae682-80a6a296427mr41307b3.17.1782338073547; Wed, 24 Jun 2026
 14:54:33 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 24 Jun 2026 14:54:33 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 24 Jun 2026 14:54:33 -0700
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:54:33 -0700
X-Gm-Features: AVVi8Ce_wcOOGQACiJ7fmfSkprpRmGytkZE_GUVedaUXOaW1g6FuUzDMUNPcyPM
Message-ID: <CAMuQ4bUb-nH9F3S+-qCAeC1z2NVi2MuzNirJdTNbq66BtCDfQg@mail.gmail.com>
Subject: [PATCH v2] dma-buf: udmabuf: avoid list copy size overflow
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Yousef Alhouseen <alhouseenyousef@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

UDMABUF_CREATE_LIST copies an array whose element count comes from
userspace. The count is bounded by the list_limit module parameter, but
that parameter does not need negative values.

Make list_limit unsigned so its type matches the u32 count field. Also
use memdup_array_user() for the list copy so the element-count
multiplication is checked before allocation and copying.

Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Make list_limit unsigned as suggested by Christian.
- Keep the checked array copy and drop the local u32 byte-count temporary.

 drivers/dma-buf/udmabuf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index bced421c0..e34a3b135 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -21,8 +21,8 @@
 #include <linux/udmabuf.h>
 #include <linux/vmalloc.h>

-static int list_limit =3D 1024;
-module_param(list_limit, int, 0644);
+static unsigned int list_limit =3D 1024;
+module_param(list_limit, uint, 0644);
 MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
Default is 1024.");
 static int size_limit_mb =3D 64;
 module_param(size_limit_mb, int, 0644);
@@ -471,12 +471,11 @@ static long udmabuf_ioctl_create_list(struct
file *filp, unsigned long arg)
 	struct udmabuf_create_list head;
 	struct udmabuf_create_item *list;
 	int ret =3D -EINVAL;
-	u32 lsize;

 	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
 		return -EFAULT;
 	if (head.count > list_limit)
 		return -EINVAL;
-	lsize =3D sizeof(struct udmabuf_create_item) * head.count;
-	list =3D memdup_user((void __user *)(arg + sizeof(head)), lsize);
+	list =3D memdup_array_user((void __user *)(arg + sizeof(head)),
+				      head.count, sizeof(*list));
 	if (IS_ERR(list))
 		return PTR_ERR(list);

--=20
2.54.0
