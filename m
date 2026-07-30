Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF7BC5516F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD15810EFA1;
	Thu, 30 Jul 2026 20:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQm9bdSM";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FDF210EF99
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:11:39 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso249280b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785442299; x=1786047099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1cRzxCLmJh01GBR+ktuxuJ/o0iMR1lZqgXW5wBf6dg0=;
 b=aQm9bdSMtp5Cq1XCYXY6Cyjbh52xrdBJOKRVk5e0AlQo2IkzXo+GPM+j8tDlgn9FiW
 DOQGNcvn6kQj7SUdIm/2EA1Umyc00TWGF+kYNTlwMmW9ZbYrg3eYOh3v382nxs6mH4CD
 czYyb9oFijwwv7LBHdwyuo9us0unvaLsNHiSspQFrhvGQL5XxgUofMSTla2bslYtI+oj
 FYGA1DbTRvQ+pPzITN6zzaWqOKEAEs1XbaNS/pjdaobBduShSiUPufhhTcS8pgViFOLx
 rSdD0kEvwDQnzqMjUGWu7NgKWx9N7/PSQA/TD78nQQVWSj4bBHl/MrqgYbAfqcZMxA5v
 cDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785442299; x=1786047099;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1cRzxCLmJh01GBR+ktuxuJ/o0iMR1lZqgXW5wBf6dg0=;
 b=tLmd7GVPOxvPVkIX1WpCmxsQzoYGFQ0eLG8wfdMQddyu/jGw4TT1YcbQG+JfDpzeAn
 OIVYp+7DPU0LCF3ZPpD0wiZCOHSk6uNx5NzivTnVqwC3YqNuc7+AyA6KILJ2H0n+sHwJ
 IQAjW9t2wkpeWWyQd0HsFkP89tarF0GUcgtUYXNZXVa4bLMvDqhrW962WQuCTyY+TtV2
 Nq/fiPxHXEydBo7Vfe+Iq9jlsX8e1O3R+3SMbS5C7QwHUMrZYHGaky5Um6OoJM2mtFIB
 eY6hx8JNWaVQN0ts4x1H8T4/8jonwcjp9VrFM1sQV6/BT98qox2bub/eQ5CD70C/CqiS
 rbgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RprLeFbXbwswRmpa9eGtVg/sKeg9oAtCxCVGlJCmUG8oAzhmTTGjlDzFCT7A5oxldZ8mcyB+4GNiug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgPxmnlQcu6SCo00+lsWshbgkx+rE6iVnc9Ig4kBFulBm4X4vL
 DLwjg8eZLsWEQfq7w1tIyvvFY5EAHvPQvuwsziT6TpVeW0o4TpVulkO4
X-Gm-Gg: AR+sD12KtlQsiH3u/tbiCYbpQvwsEexX5ZuLlGK52WkxsBf1pX1HnEx7H/vih7kF6vV
 zXNkLdloI4uSu+cftoBGJ93+/otyxgShOtgV64BRScWnUzxRzs3wZkAZHxsnMkYjKKpXN0hLQDe
 p3JDTWWOhtIK+iWt8Jn7AN5FAVGlsORabxeo3e5wDPCFSkwY9VqsxzcbmNDRkzaYZiby8eEtnQn
 TRMF8anyWylWxJDFLbkG8GILsQt8F4ujuuJucI0JvJqfgJM1MbV+aEeUTL+zeTPv+l6V825TTK1
 JEwYcfZCDHifh+9s4/VLDIJHDMokBMDDpjtGL2QaBBYc/L6EjG6wwCc58+3hFelO02iojaGFixd
 Qbs59NqpKyv0nRdO9zP9nai+0s/9froW/nBwIlJo3IhasmtMRXwahLbcPf1ra4+5LRjd84rviCK
 abhTSRvNsieiH2RnYerK3Qd861+tYAENmWD4Gol4Bf3xH5ZHDqYkl1QyCaDxISYK7YIGw0XN176
 imelysARlbc+YqwzdMmwDIjtVBr29CR8aLYuKY8M2A=
X-Received: by 2002:aa7:88c7:0:b0:848:760e:eb76 with SMTP id
 d2e1a72fcca58-84ebc432c34mr3475574b3a.61.1785442298760; 
 Thu, 30 Jul 2026 13:11:38 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net.
 [174.165.208.10]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 13:11:37 -0700 (PDT)
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
Subject: [RESEND PATCH net-next 2/6] hv_sock: Remove check for old Hyper-V
 hosts
Date: Thu, 30 Jul 2026 13:11:19 -0700
Message-Id: <20260730201123.1767-3-mhklinux@outlook.com>
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
hosts earlier than WS2016 and Windows 10, the check for such versions
during hv_sock initialization is no longer necessary. Remove the
check.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 net/vmw_vsock/hyperv_transport.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 5405c2680dec..855b15971c35 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -961,9 +961,6 @@ static int __init hvs_init(void)
 {
 	int ret;
 
-	if (vmbus_proto_version < VERSION_WIN10)
-		return -ENODEV;
-
 	ret = vmbus_driver_register(&hvs_drv);
 	if (ret != 0)
 		return ret;
-- 
2.25.1

