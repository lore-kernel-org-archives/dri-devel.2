Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B8606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqUl1e5z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B4B10F033;
	Sat, 14 Nov 2026 16:25:10 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D4810E341
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:13:01 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso3509705e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672780; x=1795277580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=56atBSeIj0Xj40ZEnZAWbn+Pb+5L+CHTI8/bHXYtQms=;
 b=UqUl1e5zq2V4pqBGtHu92632HFGGS16a0JYnB3tzba2g48/uobvtY5PsQDyRNMewJS
 hAmDRvAb0uYOXIPu5c3BI8U9QyEPuDnGAYFQkAU3jY0iGBgoCjK3Dvc0qK/HXivJnZVa
 cc6ks2Kf0g/FZyNvphTim0moX75fdgcxe8kska3BsxbNw5f5f1xfiCnbnIjpuUtsdNYo
 19EXS64EuBi9PAcuBcvX6FS3olwYUybS+U+KS2seqD6XKRdnBjotfNLEMlUcnUnE3puo
 5kRjSU9w3j1u7U2fAe5+yFCm5EshskfhtAY2jSSggASX5Z4ciXXkeMMYmeQPDQUKdZle
 yBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672780; x=1795277580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=56atBSeIj0Xj40ZEnZAWbn+Pb+5L+CHTI8/bHXYtQms=;
 b=FABMeAG8CIUJ/QleLPU66NRUNncjdEpQtA52hoYeN54dEdZPjFb3TsMeszptgRw/sI
 aMfqmfAHnYUK5WQQsfluA1TVLj9VVJzmejQ8H8P0BmVnYQQtO3Pw2infPdBTI78f9KAx
 HWzW/dbUmAUZUznSh5+82FQXQgdKZN7v9AURctJVnArO0hZppNZV39Fw2DxlqkyVUxzi
 SpJaWpmdNs5Sifx2RnTBcehjTBDF4GShB+uXiliQ67ZJBE2tG9+DKJ+z0I99TFolI0IL
 c1+RSVAdMxhXnpyo8ZLdmJSvW9T2nsTK9NT1mTMclRP8V+K1LGuv1wGk+xpkfwcpilM7
 FMcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEk3rjeWldgu4foobvv0SYyGPdkpCgu50hCTWGLUNLSn3+Gneh2pDZvk17MhmwboXGQYfaQGbCX7pY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8gDaC20ehQRzfnqydbuDyP7O9kkHrzBb/6BotoZUtS+2RhQ00Q
 vKHSzeLI75TLKE56iw+VJqUg3Jxegpf6XUBUNXa2N3QHkNdHB77b5I1k
X-Gm-Gg: AYBFou1QSwMeYodMhL6IH1BbVM19t7Th+keCbMxdV3QA1E8yGx3yEOkBqCFQcc3LKms
 ccszvA9VQ6DViVy9VHi5nbu+/MB/ZaEIIEvtMgYt++J6q5QtadB/PiDe3AwHYubDg6Zb2tQFCo4
 GY2JdBLd6MbHwPt8xJY3xvfwnM78LcOzBBjlPf10aRv1qRVWzBp2IbMlFLITjRt+eC0dBnu3ukn
 kOVU72ypUdTef+riKXS8h1AL7L5W+S0jWPOAvUqN2kFiTDyAYX0UT3XHWicKtg2clAyHLbxpRS/
 HYQrf4QPooU7fozKT0v7E43i7vn/ZXiD6Zja1+vc3UVIWnIXfq+tuNQZGzjBIHzzEuxY/J/XZLJ
 v45V8GEnA7B5EprBJZ4/JH7MpFKfYGdL5yZQAAyQ8Ear5KGlstZB4s/JdG2iXbK0g/+7BLTOa4/
 OfX5IxNgh0jIoWy/2AevuewYS3OjTxyxK6g5V0RO0wc3D2DTEaQmkJaSE/xhgrkqNNbdMqdvQXN
 4QbVehJS3lBanEG5LMMOeTVA2BPctgDlnds0OUVzfAXF87MEnyF7IGwCh2i0PnGRGNTurktWtus
 kZHt4Er6HiOinEnBWb701FT8F3YSYiKamHLamv2BoKGS8fMd6y6b+vOWzAwPu2GPu2V2G2q1PR3
 vNFbEhnZM0wyg/oe45qvMPdsss2mptIjF6HRm
X-Received: by 2002:a05:600c:3509:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4bb559f2cc3mr122972675e9.2.1794672779903; 
 Sat, 14 Nov 2026 08:12:59 -0800 (PST)
Received: from DESKTOP-0KSTGNI.localdomain ([197.45.81.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm101786405e9.14.2026.11.14.08.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:12:59 -0800 (PST)
From: Temitope obabi <obabitemitope765@gmail.com>
To: thierry.reding@kernel.org,
	mperttunen@nvidia.com
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, obabitemitope765@gmail.com
Subject: [PATCH] gpu: host1x: Remove unused host1x_channel_open tracepoint
Date: Sat, 14 Nov 2026 18:12:23 +0200
Message-ID: <20261114161223.3017-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing calls trace_host1x_channel_open(), so the tracepoint is unused.
Remove this unused tracepoint.

Fixes: 6579324a41cc ("gpu: host1x: Add channel support")
Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
---
 include/trace/events/host1x.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/trace/events/host1x.h b/include/trace/events/host1x.h
index 1b6aeb7b177b..30af7ebd724c 100644
--- a/include/trace/events/host1x.h
+++ b/include/trace/events/host1x.h
@@ -28,11 +28,6 @@ DECLARE_EVENT_CLASS(host1x,
 	TP_printk("name=%s", __get_str(name))
 );
 
-DEFINE_EVENT(host1x, host1x_channel_open,
-	TP_PROTO(const char *name),
-	TP_ARGS(name)
-);
-
 DEFINE_EVENT(host1x, host1x_channel_release,
 	TP_PROTO(const char *name),
 	TP_ARGS(name)
-- 
2.53.0

