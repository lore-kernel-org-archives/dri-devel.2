Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFACC5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DD110F06C;
	Thu, 30 Jul 2026 20:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N+jsKtxz";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDA910EFAA
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:11:44 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84e27035206so363869b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785442303; x=1786047103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QRL/mQO23aZLDOYAwAiZdksOJj7+W5EBU224dpv2hko=;
 b=N+jsKtxzDaN1jGFRKwRoGoaslnUvg+BNHsN5z4+BJxme/E+b9a/1WnYc+hvPEoTQMG
 WzwTD8xFAQUcn8aw/vgUnT7JD+EY8PrgYfyw7XTHG1hxH/eRBFZ1JxiITMZk6h0p3WVi
 AqLYjhizV6jcJWFHjPfrnvzGkwEr3ci5hzNpwd3hxhrYR10MFi6j0Kl6vnG6vNmeeuD6
 uclyguh5wVYRimJPiMQL/Krn1sNwAbNeG7f89JJxJV5RuB7ZCnPs99thtDi31M1poa7g
 Fbx/yuFxIVTi6Sna7x2JU7FDfV7ZVz7m9WDVJlVtc7B8zfDLUP+u5jpwAvTfUFABOpxI
 dTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785442303; x=1786047103;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QRL/mQO23aZLDOYAwAiZdksOJj7+W5EBU224dpv2hko=;
 b=WdIP6dhGJj+xwD+HJJBh0h9+QoJsu60PFpmHJPUUzNqRmopUvTYJkxl88jwwNI2sUJ
 w3fIMsSva49qKwokgMAEDXcp4HhFMEeyHlbWYuYZ/sWSUqfT6sxg+VooDvdBp/pC4eGx
 AXS10+kSpmJjU1k1KiJU76+HfKlAZgodN99HWbNiTVlphdfraH3iM99y/q13DZhrkrMJ
 pIlRnGh7pxqDINi3UMoDANDvabSBxyyybOU/0usK0VcOXqsN5TGZweaKoKnTkaDBRm6+
 ukkvMSU5yYq7z9w3TKq0dYz4FCXqL3Lix1GIXcQB39BpW5RF93oH9PlrRflURhGDMuiB
 +twg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKg+CFjkI1aVGFxgwCPUEAxiWGd3MIlO3EPCLJVSo1zwevA4elL5aPX3TjoStwf1f76chJmIP62RM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCcxmn1hzKv0iNet38fjPg5d9ohOEK/pkNm9KhZml4mTNV+ZVY
 /sqETmTMbl7QLdsp8A58DDY4yfYNvO7bj9GuyfieOkLKhiYcY836mCdA
X-Gm-Gg: AR+sD1377zynOOYCISkllFgU/s4nqbhIe6GRmsLIJ2kMeWQLP4rmNr2h3vnc9u++wzz
 TwYbTllN1P5LkVICRiktMKuhhLer3jxzsgE4VPcyFm6WXI+QKLdIqIuYJNzTAbSbU1Q5ZtQNvvX
 0WdX7f9uExn0rATT7pLJbSnW2cFtGiE7cbKDILQUF7+IA+MOCkbfNMlfEHICiVQ0OXspfdldXWN
 fkydLhyqVp6SiAtHuOz3JV7awVbOpIJZZwWPYWDZduiAGAR/Wx1ZFacsYMU4Dop6nEn6W8NwSQF
 lNezAyVM5i7svCyEOSrSK2Ze5keycvxQ/d8q9iVLe1wLoeGDchrO68BDoanLQWd+CMz0vqgI1kL
 3lJf36dM+q50QdyD1+aMSVEk22kk9Ys13b3y03Ou3uSK3bHaNeZmwmR0h6kShU37IXyi099Gt02
 /HkPWJuzjTerCGFm5FOYDVfV5CAGgRABk46TyZDBah6AfwJUIdJu8kwAJ76QAcy9OP5NDr7xDoq
 IVkSfut5pnKIPH6FmqbKiQPdT37YO6OBJjI3q5yoEQ=
X-Received: by 2002:a05:6a00:c82:b0:845:3fea:96c with SMTP id
 d2e1a72fcca58-84ebc22e874mr3531492b3a.21.1785442303585; 
 Thu, 30 Jul 2026 13:11:43 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net.
 [174.165.208.10]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 13:11:42 -0700 (PDT)
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
Subject: [RESEND PATCH 4/6] drm_hyperv: Remove support for synth video
 protocol of old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:21 -0700
Message-Id: <20260730201123.1767-5-mhklinux@outlook.com>
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
hosts earlier than WS2016 and Windows 10, it's no longer necessary
to support older synthetic video protocols. Remove the support.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 33 +++++++----------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index f0ef627b4898..cea1ea2595cd 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -17,7 +17,7 @@
 #define SYNTHVID_VER_GET_MAJOR(ver) (ver & 0x0000ffff)
 #define SYNTHVID_VER_GET_MINOR(ver) ((ver & 0xffff0000) >> 16)
 
-/* Support for VERSION_WIN7 is removed. #define is retained for reference. */
+/* Support for WIN7 and WIN8 is removed. #define's retained for reference. */
 #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
 #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
 #define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
@@ -557,23 +557,12 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 		return ret;
 	}
 
-	/* Negotiate the protocol version with host */
-	switch (vmbus_proto_version) {
-	case VERSION_WIN10:
-	case VERSION_WIN10_V5:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
-		if (!ret)
-			break;
-		fallthrough;
-	case VERSION_WIN8:
-	case VERSION_WIN8_1:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
-		break;
-	default:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
-		break;
-	}
-
+	/*
+	 * Negotiate the protocol version with host. Since support for hosts
+	 * older than WIN10 has been removed from Linux, only negotiate the
+	 * WIN10 version.
+	 */
+	ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
 	if (ret) {
 		drm_err(dev, "Synthetic video device version not accepted %d\n", ret);
 		goto error;
@@ -581,11 +570,9 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 
 	hv->screen_depth = SYNTHVID_DEPTH_WIN8;
 
-	if (hv_drm_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
-		ret = hv_drm_get_supported_resolution(hdev);
-		if (ret)
-			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	}
+	ret = hv_drm_get_supported_resolution(hdev);
+	if (ret)
+		drm_err(dev, "Failed to get supported resolution from host, use default\n");
 
 	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
-- 
2.25.1

