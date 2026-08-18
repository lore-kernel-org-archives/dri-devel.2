Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C65C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB1010EB4B;
	Wed, 19 Aug 2026 06:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUMCQKVK";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF4210E4E6
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:37:30 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso167798a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787071050; x=1787675850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ftdf9TYd3IItf3p0WR38TYPK1ZF7cfzR1m81D5DmLvo=;
 b=OUMCQKVK05XTKcBLNgbxpwwjsMIKC1r7PwAbqa/rYwtxhkua63woKEdxIX/jKwOlkE
 Qhxb9tlHbZiVd9s+FgVVRGqi79NmRpHrAXXqPjDuulEIWyG8j02blpvYvptLePXLCGRU
 TxIgPB7T73BX9K+Yk+MoQZoMj84zKShY4vB3c3b+yzQ8cBJCBRa0OcvOfcPRdUpw816S
 ounXO7d3qU+4QAwgCxmG73axX2OdO1N3pqEV2Sd6fmFfC/rBo0an9WjlPf6dYK6uEwl1
 IOQY4KHBDlhu13IURLT4UWGvJPV9Ij+V0+FU+v7DgA159G82yqkr4BfjOiSoPGzl6FPM
 6pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787071050; x=1787675850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ftdf9TYd3IItf3p0WR38TYPK1ZF7cfzR1m81D5DmLvo=;
 b=VfASS93koVMaEG4cr8yRORjsZFkgQ0+7Fsf43ceQ6DsKDaDqweYvowPQfVvKfZVa3A
 8oSdc2dhD3RRR3K0HIWKaEV97BFBv1r1O1O4N5u4p8727lnr5bElOii1MGGrtqmJVcQr
 q4glna+kWXGZIRMz2fxCO+58hX/Zqr/wYUxlwxgBnG9RobTYc+HYfEnRJenvRbFGcGx+
 SKPzmdJFRZ/Nd0S/a1gsFWkS9Dja2IOzZ30X1VZqkACPwnK4Mm2+QvRt67KjAgtze2sP
 Iu1gA4HtH3Fs6KO3XB9BzODC2W4OFYKLfc9buy7dwLtxP+12OF2Fj4tKcGIuE0SYKj42
 mIfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBijd4VnEZPW8Xq5mIWTun7LKkFR/ukNrYuTZV28VWaK2/E/0edHaT4zdY9kvMoC86go1sGp7zLyQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYVxa53C/5FV1siEO5gnntZV9/y4ttV9KwsYt4WLTvgzbiIMpg
 CmW1DiAOJ8ufqBPFNgB8BDXTxfuGy33jT/U0hRKjvxpwftDUMLXWeUIDI0Y+3g==
X-Gm-Gg: AR+sD106OFy1ps1ZU2oaVX13D5FIMziXhlNe789I8Aa3G+eCm2Bo+TgPYefh/dquN5Z
 INmyt3Q87XdDtpzDCZ77y4KdOZ2RxV2KmGeaDOkTdl5YLmJY4ij8eW5uZuWtxz7/t6YUpFqdO0f
 POMZukNHlymTpNPHGQHHur0cxo3U8SoBosbhJW0uJB4A9Clmb7Z5t9itu8XD/8svpSNcDq1AVAV
 DfzhVyP/PpzkzfLo0xORynUU4Tl+Qw+Z7sQe1v7lxb/SJY5ouj+DlsyBKKKpv2kYgTZDGNC3t7A
 ut9wUTqKkj6xgC1sMHytwiUxaZv96XdsPW7+uge6EJwbK+SfE6AdopsRNArfrygKsDdy8KxrNSZ
 0tLc/DFBYODnMRiHnNqI5DDIEoW5tSeT2+tVD6wCCiSDvxVYNOhgds7n3zNTS+7nLK373+p88hA
 XjgOfwSFzfjGXqdATqVCbKWzRzlyLyaMptX3TcS8xhkYbIAYFA428tOYesGXeZ2N5e8VaJDWxUT
 ruFmeIGXbGBrB93k4WRhfwEECYgZvCNX+AfUZwQRF+2dIkezKJMPKZB9A==
X-Received: by 2002:a17:90b:274e:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-3955a3dd549mr14819014a91.2.1787071050008; 
 Tue, 18 Aug 2026 09:37:30 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net
 (1-160-197-194.dynamic-ip.hinet.net. [1.160.197.194])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531ff679fsm9195992a91.14.2026.08.18.09.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 09:37:29 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 1/2] drm/ttm: drop stale @ctx kernel-doc entry
Date: Wed, 19 Aug 2026 00:37:18 +0800
Message-ID: <20260818163719.115946-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818163719.115946-1-seanwascoding@gmail.com>
References: <20260818163719.115946-1-seanwascoding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

ttm_bo_alloc_at_place no longer has a ctx member, but its kernel-doc
comment still documents @ctx. Remove the stale entry so the
documentation matches the struct.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index ef56c18ded1b..943297b49dc5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -506,7 +506,6 @@ struct ttm_bo_alloc_state {
  *
  * @bo: The buffer to allocate the backing store of
  * @place: The place to attempt allocation in
- * @ctx: ttm_operation_ctx associated with this allocation
  * @force_space: If we should evict buffers to force space
  * @res: On allocation success, the resulting struct ttm_resource.
  * @alloc_state: Object holding allocation state such as charged cgroups.
-- 
2.43.0

