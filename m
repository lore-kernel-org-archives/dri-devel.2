Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D53DCD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 11:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8704610E35A;
	Sun, 21 Jun 2026 11:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SHYrCOJa";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103F310E220
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 15:53:19 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84237c55ef9so1766652b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781970798; x=1782575598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t3oRoBnDVYl3gPZelBeVqw/jUzlCT3WUncuxAr44dxE=;
 b=SHYrCOJa087/YRPUeroT6d0F4tEX6XcK/U8F87ksaOzDH1r9cmzdo8xJQpElhPbLla
 hZGpdWv5zuTbTz/MIcVbipHo+hG4GcgHZmX7OGe/ZszpzdqLShwZ2ujFCzWRlF2kjdMv
 n4uUDPIJfv9xCu8TiwE6nIzWlLqko0slfPmnQaZa99l86qrzV12LAsxxJn8oXVV/SLti
 6bxg3lQCDYU6cXd+/7AlrgBzeXkQUd7Ek9zNcQ/cMdxFHxpUF43NFb9Hhvv9EI66VbrQ
 7rJkOYEw5RDRbO/WuOh4MH8G0JhsR0OY3kLYu/YTqsZc8oDuYkT3D5oziYFYMKarQ5Ph
 EHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781970798; x=1782575598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3oRoBnDVYl3gPZelBeVqw/jUzlCT3WUncuxAr44dxE=;
 b=rk3zLzZTq10raM7ScAaEmamGDfHXR9h5HUoC+NTJ8FMvsnj5HeKSEOohd7zdBo1irN
 zPblguMWo7VcAYUdKZ6Ypo7Nej2/OmeD5xDNl+EmTvQNTifqws/0eziNmjNZVW08+1Gf
 hD+GDRZnvXKhj3NsF6cFq4bEaFHjrCvgaMPHDMQdX6jkuP1ldBYoFLmTXom9jK5mfl6l
 dtQodDMACZXuZTx4RTpLtGAynY8B/gWTHM5i/D1vzqEdMqbBSpCrLNLr3FLjPQVXBTMa
 mlXlic1gGNbgR8BjBflnar6E50d5ooRC4WrWbo4az/JJhzQ9aCDwI/ZE4qL1Sqge3Is7
 /Q4w==
X-Gm-Message-State: AOJu0YwiBsBX0sC0yQt5gRaoDccbQei4kWXRBb5kKfKIVsFYqwBbwb6m
 4JyuuoGelmd/Ag5cVBvM6LfMIkBmD/NiqKS3w4UiJo+nmvKd4AIzFIQC
X-Gm-Gg: AfdE7cnZurDn+IW9S2vquJ+I7XLypsyIdLrP4ZXzk5E403UBp8ksU6OHeWrJ4D7KFa2
 OI9k9MLmkBW2yr0GVkYs007l4Jl9u9/Gj0qea82m4bKqloLsOVgOFV5htS0c3ypv3q6G3KHLaB/
 nuheUIGDNy8ZxhUiIsVjTasHojJ8GRfVPPiz8eAVMXdpLee9jK+en/8fYSSaWOfjegvLIXS/96x
 7ETsQDVPTl+fEobiZWRCeCOU02hyXHDP6Tom6cM9NKEUA5ApC7QeqDTs+2RW2zj6j/fPyITMd2e
 9UBo8gpn0RrU8USzyRF47zZg+iFUWEEQDldOPWhkt1iFBbpbon/0MTFFSxwkKnQdT2DWfZ5FmfN
 f9DPT2tvUfEh7lNhTOq9UEOyF+egqcQKe5jXUDAmOZT0g9E8Oi+PDjr/rLl/ODmHGjmR9wLXF4H
 sZgGqRlnT1DsV0wdci3vTk6XBhnAzRsGK8
X-Received: by 2002:a05:6a00:4f84:b0:845:3260:50d1 with SMTP id
 d2e1a72fcca58-845561132a0mr8214887b3a.27.1781970798558; 
 Sat, 20 Jun 2026 08:53:18 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:8e0e:956e:b09c:23cd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564d6c164sm2409500b3a.3.2026.06.20.08.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 08:53:18 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, farah kassabri <fkassabri@habana.ai>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] accel/habanalabs: publish signal handle after SOB setup
Date: Sat, 20 Jun 2026 23:53:13 +0800
Message-ID: <20260620155313.79464-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jun 2026 11:39:32 +0000
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

cs_ioctl_reserve_signals() makes the encapsulated signal handle visible
in the context IDR before the SOB pointer and pre-reserve SOB value are
set. Concurrent unreserve and wait paths dereference those fields after
IDR lookup.

Reserve the IDR slot with a NULL entry, initialize the handle including
the SOB fields, and replace the slot with the handle only after the
visible state is ready.

Fixes: dadf17abb724 ("habanalabs: add support for encapsulated signals reservation")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 .../habanalabs/common/command_submission.c    | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index ba4257bda77b..791fc01e24c5 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -2009,6 +2009,7 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	struct hl_cs_encaps_sig_handle *handle;
 	struct hl_encaps_signals_mgr *mgr;
 	struct hl_hw_sob *hw_sob;
+	void *old;
 	int hdl_id;
 	int rc = 0;
 
@@ -2045,13 +2046,19 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	}
 
 	handle->count = count;
+	handle->q_idx = q_idx;
+	handle->hdev = hdev;
+	handle->cs_seq = ULLONG_MAX;
+	kref_init(&handle->refcount);
 
 	hl_ctx_get(hpriv->ctx);
 	handle->ctx = hpriv->ctx;
 	mgr = &hpriv->ctx->sig_mgr;
 
 	spin_lock(&mgr->lock);
-	hdl_id = idr_alloc(&mgr->handles, handle, 1, 0, GFP_ATOMIC);
+	hdl_id = idr_alloc(&mgr->handles, NULL, 1, 0, GFP_ATOMIC);
+	if (hdl_id >= 0)
+		handle->id = hdl_id;
 	spin_unlock(&mgr->lock);
 
 	if (hdl_id < 0) {
@@ -2060,11 +2067,6 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 		goto put_ctx;
 	}
 
-	handle->id = hdl_id;
-	handle->q_idx = q_idx;
-	handle->hdev = hdev;
-	kref_init(&handle->refcount);
-
 	hdev->asic_funcs->hw_queues_lock(hdev);
 
 	hw_sob = &prop->hw_sob[prop->curr_sob_offset];
@@ -2093,11 +2095,18 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	 */
 	handle->pre_sob_val = prop->next_sob_val - handle->count;
 
-	handle->cs_seq = ULLONG_MAX;
-
 	*signals_count = prop->next_sob_val;
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 
+	spin_lock(&mgr->lock);
+	old = idr_replace(&mgr->handles, handle, hdl_id);
+	spin_unlock(&mgr->lock);
+
+	if (WARN_ON(IS_ERR(old))) {
+		rc = PTR_ERR(old);
+		goto remove_idr;
+	}
+
 	*sob_addr = handle->hw_sob->sob_addr;
 	*handle_id = hdl_id;
 
