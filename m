Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EADAC55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D9010EDED;
	Thu, 30 Jul 2026 07:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BnbO6+Nk";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CE010E08F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 00:31:58 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cf41bab353so26769075ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785371518; x=1785976318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fI6aSyOYXjF/tGTQD0BJTcmduvJ9bMsRenmuTJgMGVU=;
 b=BnbO6+NkPwn2N+wG2s/xHEBkTsQu2tTEu8SpKsdd19v6u5e6R5GDnULuKAH0x/5HBo
 ogmTU+HVRVS4siVyRO/rTLcb/isXHnlazIK/spZbEQ6fGdE1juFVv3VmAValOCEdSoPm
 x5RCn0Da2QylkOqjwotT7y1rzlMjJqQaQUZXqw8L9fyysYOjineRLdyoMXgECnL3tjfB
 9NcOcwuvbIYtp3CExdX9Les1Qa9RrsnsG5h7aziLyBkHaXQvLPyxwNvJY8qumwIb0Z0j
 db4GQRqswYGiKm4Teo32k3XX/5SAv7a3RGI2/e1O6Znidb4Ql8SmB2SG8x+zbxlju5qh
 Ghdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785371518; x=1785976318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fI6aSyOYXjF/tGTQD0BJTcmduvJ9bMsRenmuTJgMGVU=;
 b=BTDghHWQlWKYIonERTSVEgJp8n0FmxUNDONSETVN2yuIs4FQokGpCFpKQ+b3DirlNK
 aPG4WkMolupe1jP20T4RZPP57O6LB4GblIrFlWkvZxyFRcW4V8DDHiFn63VuXFBga6AK
 Omno93lg9wL6sf3xY95kF7tvazlOwKu0TlOv+MMyqlCq7ogOxao2pFP2/Llcc+qnfJoZ
 j79qhMjuTfTsW/QghYIzIjpQpP51WZ11Itm7Id2SouHSV3gFgDAA+HdDKA9J5pgT1euE
 TFyfmnR1zcJiLr7UMVfx5HczosSNfOcf9evETWnU3jrdQxju1LssE2btETMXymougQLW
 atCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcNeb8Td0q6Q4QxCCa0Vx0i9lK4XeyfAyRvS/SwVsMkCy7LPPdNjM4ln/gEI9KcAiN6qAGQZrqDP4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yydy511Sm17sIs6w2kDvHqy+iw/N3jnczIyN/c96l+6l0tMdP+Y
 Kx1bprYVSBqwvsy/c+PXo0JojGFpHJ4ZbkTkZFZsAjZVYGNGW4ACFE7f
X-Gm-Gg: AR+sD10DvUB8RUdE4/Lrl6m/268MaHemB/MX8XbY/0u3PpoexefuqgBTd0oJm5bhgHV
 VDHbnS72kwd6mMQGxoClkYoPxtmRXLWFbUxEVzWWIMaHUVC1Cwl6HM5DrwEROjwMQchI/paFznN
 ORwIhdUuiIQNxZU90NeqsOhLMZhBb6wo86C+fZUuEnQhzRnAe21AgQf7c7LuFAk1L57eo0uCVji
 HpEktl1qYwouaiYKEElyxXjZhXLQd/Okx4QtFygbFNEOR0Fj17o7DHm36vpsXhrzb68sqjN4QTz
 FwPyPOoecjmI9+83ri6IJZrVCZ7yEFQjKMODlSltGrOGnqnGyWFpgIQaD2eCpEMIDAp01K42Nb9
 RvOtsFRWTB3fwpaxwCEfOnkm74eVdii+Dq6jhsHuQbyKmv5fvNrfpDDtqQdVwqI3R0j78RWuyhA
 jowLEc2cepOK0KQ5Ibe6zuvTesjAcDeO+RpMYG7yZ2G77+vwmPyl8kcJ+a4W+uKsJRBj5/yrWno
 OoI/x8AFSxTRcW6Ma3Ha8Re4KxV78RqXCV00bZN71O6MfY9dy4bu4jnGWOphyT5eiJ9C/xhNxqO
 qcv7q+kE
X-Received: by 2002:a17:903:120e:b0:2c2:bd0d:3cf0 with SMTP id
 d9443c01a7336-2d035ccd3cemr5576695ad.25.1785371518417; 
 Wed, 29 Jul 2026 17:31:58 -0700 (PDT)
Received: from alanhc-ROG-Strix-G16-G614PR-G614PR.tailb22ec2.ts.net
 (1-161-137-250.dynamic-ip.hinet.net. [1.161.137.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf4c0bsm17606485ad.59.2026.07.29.17.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 17:31:57 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH] dma-buf: fix stale return value documentation for
 dma_buf_set_name()
Date: Thu, 30 Jul 2026 08:31:53 +0800
Message-ID: <20260730003153.4030818-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:55 +0000
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

The kernel-doc for dma_buf_set_name() documents an -EBUSY return for the
case where the dma-buf is already attached to devices. The function has no
such path: it returns 0 on success, or the error from strndup_user().

kernel-doc does not validate prose, so scripts/kernel-doc does not report
this.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 drivers/dma-buf/dma-buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636d..324f4f0c8 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -413,8 +413,8 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
  * @buf:    [in]     A piece of userspace memory that contains the name of
  *                   the dma-buf.
  *
- * Returns 0 on success. If the dma-buf buffer is already attached to
- * devices, return -EBUSY.
+ * Returns 0 on success, or a negative error code from strndup_user() if the
+ * name cannot be copied in.
  *
  */
 static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
-- 
2.43.0

