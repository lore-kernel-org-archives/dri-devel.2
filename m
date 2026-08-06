Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F51C5AC9F
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C719410F386;
	Fri,  7 Aug 2026 06:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ooZHa6Zp";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE49010F30F
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 23:51:02 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-92e5b048375so147770685a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786060262; x=1786665062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jn5M2DPxWkJRuSOq4XRDkDeVAclvZgLB7USjbXRxmNs=;
 b=ooZHa6ZpvQyaTQTIxwDxzjECgJdMzQRpnvZFfhbwYaUA7GdwzjNKZCrUxLLY1oIaTg
 /Esb8p5P70Pi7SStsWLnLwkhbLKg4yxq0AbXpo/6zbjiXDf8wsAGPrOeMQxlTkstoWUE
 aWlw/Z9iFS+Yi4xaNH09UnDsIWLxvvPE8HrMM+8TA5qOfcWbExpndJSsB+Jqf4hfMSnV
 FO/RM/XvLPDCHrBLfqa28NwmBA9Pj6dVMw84pOMlR9jQjrLOnA/06RlsWmMPfLbMtntX
 2Ley52kDC8o9lEEg3cd1N68O+s8a9Fo983n0E8YbY9vgvRql0+HmjRCQfDA5OcjlMgty
 vasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786060262; x=1786665062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jn5M2DPxWkJRuSOq4XRDkDeVAclvZgLB7USjbXRxmNs=;
 b=h6y6n4mze0oUoAvPXaj9b37VRzrRUXSOCe7q8/SVtHOBiQ9kGD6LFLnzhQdCJf1lhm
 GuG77TeeMc7pgHKR2oQSRNgaJGeT2mMB3XSPnkjMF8g3PpdwmM2hsF0G8eMgpWanMbn6
 b0P03qipqNMOwxqfW+ccyAXbiHruUJwG0f9/5yaIbAwz+hAGG3EZQYyift6M5slKZGaE
 0bj5YocxnaUrzjOMm1Pg1DdzpO12s5mV6j9mMJaQJ3b24thPduUDxUuZSE2xB+pPGXF4
 hQKF+84Yq5Ulkrnyx2aFyO3+h/NvoKG07ykTkFiFTO7udkYiIevYCYz3Mw8vfOvTRTeZ
 OPEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmTE9n1IXSa4qSCdSakJnOj1ysybPZXiRz+ceniX++y91oAHeOGTkABNhNot35Cl05tcuvkwjlxgo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzcm4ga1JE024PBeVDKsQ/Ckb2ZycoauFKHrv0O1vjOIgV41jPk
 5RFBEiMIOYA4K1G01jozW011ER0LJLHGKI01YyKmx63YsOcvZNtTR/jR
X-Gm-Gg: AR+sD13mb3mJ2IQLzPKAjMqIjDOWIdnpY2+WzT5Kpf6S4FgzDEYVD84gtQt28SztbFU
 5Nj3YkUSrfm6hp6jlBmzbdI0fKMvGFQnOpQQzPIanLZrsZpsOPwAe1BNqKPfAkrvy2ygvGIdmgY
 v8TZ24oOpcX6pU9VNIft4EMlv7YX8iZXtia7Ukv221xaxlcGgnPTN63yuVa5e9Ek28KYRPTq7BB
 mz1gQIcdSuEGzXo5xGTY7wpOgjOKJzygH7PUhBk15tI9acwIrx3UcbjKtN0cUVO8PMTFeiiI6hT
 YpVR3/hVZOfmnzuVDHjuiZxGWv3SYo/xSrsdrVUVEzcCsB2DHIVDuvtALswFHlAqyKA8VvCNB3C
 0mfaGtmeTBAp6tiYqBAxgsZSo6YlP920oUYSEwuqMN9NqeFfLiF1oEzWlAH0I4uTh4QYUnSySXw
 kn73QB1oRNpGZdvqbEKEbV8kfuR4tUxDzR/xvgQRKI9kgVBIFILQQ+RGb56t7LP528B6/xYVLkm
 s5O9qcssC0NDQ6wEp/G6EDTKHEFM/X7l23EEqF5XkFMK+3NFGMCHyk=
X-Received: by 2002:a05:620a:a2dc:20b0:92e:8aed:4785 with SMTP id
 af79cd13be357-936490e7a4bmr1535882085a.25.1786060261714; 
 Thu, 06 Aug 2026 16:51:01 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu.
 [128.210.106.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e258edesm25793285a.32.2026.08.06.16.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:51:01 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Yifei Gao <gyf161023@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] misc: fastrpc: fix use-after-free in fastrpc_map_attach()
 error path
Date: Thu,  6 Aug 2026 23:50:54 +0000
Message-ID: <20260806235056.456341-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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

map->table is set right after the attachment is mapped, before the
len > map->size check. When that check fails and jumps to map_err, the
error path manually calls dma_buf_detach() and dma_buf_put(), then falls
through to fastrpc_map_put() -> fastrpc_free_map().

Since map->table is still non-NULL, fastrpc_free_map() repeats the
cleanup: dma_buf_unmap_attachment_unlocked() dereferences the map->attach
already freed by dma_buf_detach() (use-after-free read), and a second
dma_buf_put() drops an extra reference on map->buf. As the exporting fd is
typically still held by userspace, this imbalance can later lead to
premature destruction of the dma_buf and a use-after-free.

The branch is reachable by an unprivileged process via
FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
requested length, before any DSP invocation.

Clear map->table in the map_err path so the fastrpc_map_put() fallthrough
does not operate on the already released attachment and buffer.

Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..d6be951d5538 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -915,6 +915,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 
 map_err:
 	dma_buf_detach(map->buf, map->attach);
+	map->table = NULL;
 attach_err:
 	dma_buf_put(map->buf);
 get_err:
-- 
2.43.0

