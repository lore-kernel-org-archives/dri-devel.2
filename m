Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8352CCDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF7A10F12B;
	Thu, 25 Jun 2026 07:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qKYYISJ3";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447EE10E071
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:53:57 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-80260a90522so13295677b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782305636; x=1782910436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M1WZO8vWv2VJGmEwDoBM9gWeu5JjgR3Wcyzn9bhpYvk=;
 b=qKYYISJ3dnGR6D16g7WtCp3fruyh8TZ1hW8SOedTb6hRlUFAtS51jAcPM5b/SqqskH
 oUzj0Xt7hZE/d7HiHI38uL3L03GyRw9BgfRQIzYiToCP9s12ydW+VZUVPWdPfNa8z7HM
 mxxBzxFQcjGC7/s4uJcYBpPzSZaUhm/HS/KfvdeT6Moz41/wNy7LHqeOXuq4h7Uz036n
 cW5GWJuyGET23nlVGIoSqM465f2N0g2TVI0KdQ5F4AF6haOn1yqWmuTeJXFA5aqg1Aj+
 8W6kXN08XWWDPnnDrTufTP5IdqffIVQm4Q1YKtEmbAL9hgMELJiY7IHtPbMnc9SOp7+2
 KW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782305636; x=1782910436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1WZO8vWv2VJGmEwDoBM9gWeu5JjgR3Wcyzn9bhpYvk=;
 b=W8K16zQiKU9YPda2K0Q+MFGbbOLrXzOkIfFeW0jLE7EYmiC5GIzdX1P2TULDHRk8BC
 VQ3WVpYDTGF7s1HaDYOTr2POZBxstNnyt4msAs7S/x/JN+YIGg6/+bDSRa+Kmme3br9r
 t8KPmNe8mRduxOpvbzRd4GBDyjhTFHtt2V8b4W4PdvpgJUN/gUnCiANp9h2K+WCnrD58
 cT1r3PlBTmATTXYKCbP6H9MVrs+W+iQf8IaVRqCddJ5mQP62LqezZ6lOIKa7IaRLXkEL
 rT0QDJFrLwPfhJMuWQfgYtUTC65JvNG/i1JwdIW7R4fd3EQ6F53R9/7gB5a9F3r9YkG2
 IUvA==
X-Gm-Message-State: AOJu0Yxia9y5OjV9bLMDVAgAXTUib5zyuaUYRT9NBAp4rEhvv87EfV1J
 4XPfim0MHhm/9C8K0LKOaexKlcRRDcv0kId1MEiCY0cvK2jvvbQ1gx5D
X-Gm-Gg: AfdE7ckOxv8ROPiqrme2/E8JPV0DrstuSIgH0vw3dxyNUz4LQk7ljOD9jdDy4fGXDam
 75lTq72rEJ4yOVmZ9OeSt3WzKN1xnYm99PCaRCeiEXt8Suk0q2FTfa1PAtCha5ChEFnrQU0gG9F
 4zOhqBKlG+k43avCrtivPt+NxPeRrTTDFFJ+W+8mmjM+f6FbGpDYWguz2eaoGw/TKMhlyRSvB6i
 gq/vxDYMQ+HQs6R3+CuAdyKDds0nF8ZJFgqCSqPukK/2RfbQ6jVlsBURXxt9eT+zKxtZTNB2lFR
 0JQ4fYiDgoSyNiCVxK//mbVMlum4WwhPWtKGRvilVN3T707KvEWCN55nHo8kaixgy1N5hlwVHaF
 h3gUWTO3pMkEiZLqPuLLM1tjG7zIOFp/rFuxkyju/gEcH25O1Beba0G85Ki9qSpUAPoUjxAmz/F
 fwPHUUJ9vp+Yk0uS/+0ZpLMFbt3Q==
X-Received: by 2002:a05:690c:c4f7:b0:7fd:d8ba:44dd with SMTP id
 00721157ae682-806c3a16dc1mr67516207b3.42.1782305635714; 
 Wed, 24 Jun 2026 05:53:55 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025cf69b5asm57476257b3.20.2026.06.24.05.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:53:55 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] dma-buf: udmabuf: avoid list copy size overflow
Date: Wed, 24 Jun 2026 14:52:42 +0200
Message-ID: <20260624125242.11232-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
userspace. The count is compared against list_limit, but list_limit is a
signed module parameter while the count is u32.

If the limit is raised too far or made negative, that comparison no
longer bounds the count to a range where sizeof(*list) * count fits in
the u32 temporary used for the copy length. A wrapped copy length lets
memdup_user() copy fewer entries than udmabuf_create() subsequently
walks, leading to out-of-bounds reads from the copied list.

Take a positive snapshot of the module limit and use memdup_array_user()
so the multiplication is checked before copying.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/dma-buf/udmabuf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index bced421c0..b4078ec84 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -469,14 +469,15 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	struct udmabuf_create_list head;
 	struct udmabuf_create_item *list;
 	int ret = -EINVAL;
-	u32 lsize;
+	int limit;
 
 	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
 		return -EFAULT;
-	if (head.count > list_limit)
+	limit = READ_ONCE(list_limit);
+	if (!head.count || limit <= 0 || head.count > limit)
 		return -EINVAL;
-	lsize = sizeof(struct udmabuf_create_item) * head.count;
-	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
+	list = memdup_array_user((void __user *)(arg + sizeof(head)),
+				 head.count, sizeof(*list));
 	if (IS_ERR(list))
 		return PTR_ERR(list);
 
-- 
2.54.0

