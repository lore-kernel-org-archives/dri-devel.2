Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFC01094465
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 09:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A28A10E1F2;
	Sat, 21 Mar 2026 09:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RmEV2ZMe";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EB210EAD3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 11:29:50 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-35a09e0dd63so654054a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774006190; x=1774610990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K6kdQ83MFjK4keBWOvjShHEs96amZMPmnqfM2hE8yU4=;
 b=RmEV2ZMezynVicFsY1SHZaBrgUSi2Ld6LASU8/VC7gLuVUWDnJOwF4klFqJBhA+kTJ
 wNdDs0j4OCW/AGbr3He1dDztnbxu9EcQYekNWWupD3YgrHCQwqtQU4K4sMSJh7SCxa9k
 1OgoZV9k6hsYEpf4r0fA1RaFRfkZKl7LH8INSnm98SBCQ4sZyyKJLbpfTY40Ff87dCo2
 uGkoGKYVWc1jtTjwr7X1m8wkC3+8NRPiEz1Vz59eytvanad6OBHDTSNLqWbsSCJjPBm6
 QDUUIHEl+TrKO6Q8dL0Ydte7ZI6lsIlZchyrgcmm/fXZk8xc0lUUK+quE8DWB14D9Dft
 mTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774006190; x=1774610990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6kdQ83MFjK4keBWOvjShHEs96amZMPmnqfM2hE8yU4=;
 b=f3RMIdsN7c2O2FZKMLLlZPNOc5/4wZvWCg+36h5uNupKPn97cFrWrys8yUGlcsaUjk
 as2LHqWbUuWwVoZ5EHScEZ/cdmMC8ccV5W6+51z+QgwH5Niju9YLGn88mlzdmZDhD1qV
 lFVKS+zWaiGGNF8AXQ223NLd3oItgOtzWjnlBnitD3/8HEAtKqRXMu1orgzdyYph4ADM
 z4C3tZ89GbZTb14aRuPuGSk/ggrtx6qb4AEivATR+B2Cql8AtXaH8BoOR2cxdDn0sP78
 vbGbdqk8F/i8GyQD5Q+Iw/T2rUcOhkl7oyI9FoqC5S/22gQT1ipgNKkL8D9iE3VbcjJr
 vO1Q==
X-Gm-Message-State: AOJu0Ywcgk9l2DWyYU+i1tKQA8VupiPlIFr8OdSf4fz+WXQRB5z/XQfH
 F3jSzA17EJl6WlflNlhyQ1JR9RzKjFyu5JTK/51KwPLpq3E5RXks9I9s2kebIP8/
X-Gm-Gg: ATEYQzwubXKoI43+q/FBIhyhmb1PBFSXbPZjIAhXN9HtcxowzZhJfhYH18Cn8EXB+/D
 /lddLEHxk9ByFguPGxe3zFL8obNvrIr5SOVFbQwxvMQOTwinGjDd92EgtYftWSmkPonnFndcixY
 PUdGyk6bFbERy6KUlO7IBhFSyCLIUzGyFvJz+kAiQWTibn2yMJLsnfEqx8ewI69woGRd76VDhBZ
 w7/e9BFG02sbIUiS+5PZ7xgQvsIOsaBdCn6VtvljuyaOrVZn5jSlFBji4FqvW25U7E7GM0Oa9VV
 iQ3exsaW1VM6ZDpO1N26HQq5D5bMM11OXRCctZ44fdYnDaCnst80j1FYojH0I9I8dcyIDKaqMq5
 6KLLE2KMN1ZImEaGdGRtDAZ/b0PpZ76jEgzfJ2bscD6wynWdFz/kmx5eacI/euTZtBpObyQ1giw
 p6SH8dBMW3it/01/xb/7ws2LcwpUMRPo197pac9d/6hA5HvRXrj5lmrA==
X-Received: by 2002:a17:90b:35d0:b0:343:7714:4ca8 with SMTP id
 98e67ed59e1d1-35bd2c69ef3mr2298767a91.15.1774006189515; 
 Fri, 20 Mar 2026 04:29:49 -0700 (PDT)
Received: from ZC-202510311500 ([61.185.217.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd3f21163sm1833042a91.7.2026.03.20.04.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 04:29:48 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "haoyu.lu" <hechushiguitu666@gmail.com>
Subject: [PATCH] accel/amdxdna: fix missing newline in pr_err message
Date: Fri, 20 Mar 2026 19:29:38 +0800
Message-ID: <20260320112938.305-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:46:58 +0000
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

From: "haoyu.lu" <hechushiguitu666@gmail.com>

Add missing newline to pr_err message in amdxdna_mailbox.c.

Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 46d844a73a94..e681a090752d 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -499,7 +499,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 	int ret;
 
 	if (!is_power_of_2(x2i->rb_size) || !is_power_of_2(i2x->rb_size)) {
-		pr_err("Ring buf size must be power of 2");
+		pr_err("Ring buf size must be power of 2\n");
 		return -EINVAL;
 	}
 
-- 
2.53.0.windows.1

