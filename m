Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6E8C5516F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D61010EFBB;
	Thu, 30 Jul 2026 20:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jtaDIu+e";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DE210EFAA
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:11:41 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso324284b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785442301; x=1786047101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SiwSGXnRH3TAjHZf8TYJ+bLPyzkydxq8UaVMUOfakl0=;
 b=jtaDIu+eu+xeE3ZXUEsQ3a4nGKKj4d5XctoGXEcpRWnYVuPzYOMv3AtF3W4vnQE2D9
 EraWy06HvQbrgftQVZFoRy3kKeQ4ZppXhCk/+NTXHgfNfA0gLM5VQ0pYw19yVYjmLFi5
 8LdyWgb8lzET3t7WjmVXmElep1+Z99XthoST5z6fG0QozlJoMCaGEghmbtOxi5p8p6gg
 mLVYlopTFOCm+jzoxkSDI7k/oNOrkt4vVitRdDmpORgrONn7HMva3ge1/x4UQ9Y6bhEI
 fCo0jNNhlq+8tBiWS+C8TSqvNoy8zLU5AKN1AXaed3T2BURx6fXwklpEQsh0o8eConNP
 MBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785442301; x=1786047101;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SiwSGXnRH3TAjHZf8TYJ+bLPyzkydxq8UaVMUOfakl0=;
 b=Qduq3UdylEXGplwziQ2ksQBzfQX7KiRxzRrHjO3L9tPSQp7BfFhri6BPQToY9jVEbK
 kfFQFTfLO4as6h+2coPM91bbGC0rgX5uojlU+SK0R148JLfCw8Lp7VGAk/BhpXlYXQs1
 4W2yN8bPKihALyZcoGHybIb475NJ/bh0i8pxO4jTkEmWCHXSUkR1wfzHFzhchjNFYHlL
 0DUh795nwUsKoxBJ0ys9uy7KENf6iXNxr/OO5s6yDGozmbbvG9cCwNC0AzCX2qlfddCR
 oAQTdWKw7mbowS1m8+Pk/1rv33+6GUqPQaiocdwZpol/bAXSFbf6t7LcvtU8xpPlMtEB
 mffg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8HWMu5280qwqtnSXZB9mLoV/FpqWVukAOcgWn1OpTO1yM22HxhXjLMbWAVAj4r6v5Eplr2xYlYww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHCheobQwuAfAUBou33/6YUpCEG/89+7FHdLnOGzUchjwvJRLj
 13fnuA/YJ5ITxzsCD25u0+uZQ3ZuK1uMcv0EdY8P7bba0SJ/kxwzWLgM
X-Gm-Gg: AR+sD10abdsnRvvZ5mr/I72NW3eKM8RBmE3t1FIvWMK3DisjHluqeOFGbPCl0lsiq0C
 0calbJpmfantcW5qBP+IkxXbnUOoXibN+dd05G0/YROhWdGx5h2fI8C9Bg3UL2sNzr3gtEbCjlS
 sWmmvIDw6mUp5/PVTLnqWz3JyTYqLTqINjRdDe7BvlYXo5heRTrWHcbnaxp27vl1D8pzmIAjZfy
 cUbRtNTmavGjs4AHEm76hfhbcNhtsD2BWmtX3hyorDuBdEc29x8Li1DS+77lcLUIVV8f0pg5H0F
 18Z2bm8J/pb6PhoxuMDlM1I8nfi2Xj+Kk5djynfFuHbq4Njqg6xJtrf+c9MflF3UsBzLvV25M9n
 Mca70jxChQegLgh3olKhWpBCbbiyXH5E/0oYD2q884JiHIVMHjscOMcVTwqcFH8dv8YK7wkdEVM
 s7K3+Wn67jsmovW9qRouxdi46eyCpr13Jgf6W/Qij3EwxLoDOUgqy+qbX+iCxWSO2YoG2WblGU+
 b5WSxQ5ztkxji0Ei8ZiKmD2P26zZ0sA35UgNEfiKwj4iNZes968RQ==
X-Received: by 2002:a05:6a00:1391:b0:848:56ff:6ced with SMTP id
 d2e1a72fcca58-84ebc1f5844mr3898044b3a.8.1785442301426; 
 Thu, 30 Jul 2026 13:11:41 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net.
 [174.165.208.10]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 13:11:40 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@kernel.org, ssengar@linux.microsoft.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, sgarzare@redhat.com, horms@kernel.org
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 linux-scsi@vger.kernel.org, virtualization@lists.linux.dev
Subject: [RESEND PATCH net-next 3/6] hv_netvsc: Remove GPADL teardown special
 case for old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:20 -0700
Message-Id: <20260730201123.1767-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
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
Reply-To: mhklinux@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, the special case handling of
GPADL teardown is no longer necessary. Remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/netvsc.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 4d319c50955e..4295b96b4312 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -695,17 +695,8 @@ void netvsc_device_remove(struct hv_device *device)
 		= rtnl_dereference(net_device_ctx->nvdev);
 	int i;
 
-	/*
-	 * Revoke receive buffer. If host is pre-Win2016 then tear down
-	 * receive buffer GPADL. Do the same for send buffer.
-	 */
 	netvsc_revoke_recv_buf(device, net_device, ndev);
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_recv_gpadl(device, net_device, ndev);
-
 	netvsc_revoke_send_buf(device, net_device, ndev);
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -733,14 +724,9 @@ void netvsc_device_remove(struct hv_device *device)
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	/*
-	 * If host is Win2016 or higher then we do the GPADL tear down
-	 * here after VMBus is closed.
-	*/
-	if (vmbus_proto_version >= VERSION_WIN10) {
-		netvsc_teardown_recv_gpadl(device, net_device, ndev);
-		netvsc_teardown_send_gpadl(device, net_device, ndev);
-	}
+	/* Must do the GPADL teardown after channel is closed */
+	netvsc_teardown_recv_gpadl(device, net_device, ndev);
+	netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
-- 
2.25.1

