Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73F7C44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1484B10EB9D;
	Tue, 21 Jul 2026 22:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YosDL3nO";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CD910E34C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:23:08 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso9105487a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784640187; x=1785244987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LtVNy9WEfDzxsKFFVeCmSkblw1jFuZZyyyPD7xNCflw=;
 b=YosDL3nORhPv/2iyhH4Oewty8DCr0yyuKlcv8kuINcrR9qscs2oHkFPteHnRGj0Iwc
 1x5+pCPsjihzYVTA01R4MXOI3TNxHQx5qEGLOuqjTWXgj/jBCffc4C94WLY7/W9MyBoJ
 Ix4PlwBW0Bo1YCeM5QaPUjFL/01zvzODn1tqGYDSViY4/1rfQ76L9r5zVL9j4NETY9ly
 GoekvbbDEGTSzb9TRwMJyxXoeuiklmpOaoWx+DXqiRBspUiYtrXADMnRg7hPCQ0zIc9x
 9L1sj603BrL7XsBbgO2PQicPRAhbepK4ePtKW276By3DjHN634hfXxyeuuUyRj5oo+7h
 5kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784640187; x=1785244987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LtVNy9WEfDzxsKFFVeCmSkblw1jFuZZyyyPD7xNCflw=;
 b=ajGebbcG4bfPsboEpj0AJh+h/Q+YwBJV1UnkVmJbwLFjvXgfekidOcI8AIeA1u5uqc
 3FA5HsSoWfnZNzQwlh1y0wHK0bUgx1WgnjCkUfbB2++0fBP0CjjqdguRwsm5iDu5qLjA
 b++8YDc3pnJO9rMuo99BfC+izh5XThRQCMNBmAunig5TPjMk3VOBvEdRWnbXozaDmxn9
 uJ0sIjuWg/3/KlfL8qrKh7G0Byou3OWuuMgtbr/QIjZc1ZQOgrIp3E6eFmI7mi/GJOFD
 18jA21hzfGZ4iYGtKE3Vst8hiN4fFGAm+DVTiObyBxpfkLx1uqit+ylcPnk27JRE925f
 IvuQ==
X-Gm-Message-State: AOJu0YzsXAg9CkbdL2WfnhqVbC4LUhb3cUZvBmKZqjhg5tkBvcktxOk8
 wWPIS/4uFKsJbhZcxPVfhLIKXplkpLCf1Y1kXKBQFOImTHzpRp886yq5
X-Gm-Gg: AR+sD12/ZkYle0cKgDddRLCSnxMs3YXlHfYTZty/XWJQd/i9FEqMJ9aGW0sbVFU3DPL
 mUPcE/5unNkl472BeCbI7Iuo4bqTYwbaGx3+U0/beFvE9XlZAo8LpGpiHCX/Z9Dqoqal7OZWu3c
 /k+dgaU0ErgHh7hHrxl2Tw8hN5Mr1mHL+yIVpTPXDhLALcHG+CWaQFsR/hkyhVulSAY2WPkbhoh
 zIEHaQi7B4uxCfp0JKse4DsxTN6S/FxZq0r5txMk/sjPD3ekwfbBWN9F0MJXpPIPnwWW7DTZs4C
 Ee88AAepJB6pYWeDplpkjJAdKgUwVWk1mPHZbsxMUYuDFBQtJNbJVDT7YY4zRVqJkoyivX+HUkl
 R9Hy+b2j+WsLXqeIVmrgyFX4vbP/51t49l0hFKzQa9JMJbR+vvSVsfrElemNgD4X5tuoprXfhVY
 CDAS4glBG8q2608DFx1etOUs9r1li2UVaBCha56KTX4Y56glaZb3LM3ig=
X-Received: by 2002:a17:90b:2d50:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-38e4b455693mr20977206a91.13.1784640187373; 
 Tue, 21 Jul 2026 06:23:07 -0700 (PDT)
Received: from fedora ([2405:201:a412:78a0:40cb:342e:9c1b:a9a3])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2ddfb35sm43244731c88.14.2026.07.21.06.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:23:06 -0700 (PDT)
From: Shivank Sharma <shivanksharma2376543@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shivank Sharma <shivanksharma2376543@gmail.com>
Subject: [PATCH] doc: ABI: sysfs-class-backlight: update outdated HAL
 userspace reference
Date: Tue, 21 Jul 2026 18:52:53 +0530
Message-ID: <20260721132253.256422-1-shivanksharma2376543@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

HAL was deprecated around 2009 and is
no longer used on modern Linux distributions. Update the 'Users:' field
in the sysfs-class-backlight ABI documentation to reflect modern
systemd-logind, udev, general userspace.

Signed-off-by: Shivank Sharma <shivanksharma2376543@gmail.com>
---
 Documentation/ABI/stable/sysfs-class-backlight | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-backlight b/Documentation/ABI/stable/sysfs-class-backlight
index 40b8c46b9..2f60dd3f4 100644
--- a/Documentation/ABI/stable/sysfs-class-backlight
+++ b/Documentation/ABI/stable/sysfs-class-backlight
@@ -8,7 +8,7 @@ Description:
 
 		 - 0 (FB_BLANK_UNBLANK)   : power on.
 		 - 4 (FB_BLANK_POWERDOWN) : power off
-Users:		HAL
+Users:		systemd-logind, udev, general userspace.
 
 What:		/sys/class/backlight/<backlight>/brightness
 Date:		April 2005
@@ -19,7 +19,7 @@ Description:
 		are between 0 and max_brightness. This file will also
 		show the brightness level stored in the driver, which
 		may not be the actual brightness (see actual_brightness).
-Users:		HAL
+Users:		systemd-logind, udev, general userspace.
 
 What:		/sys/class/backlight/<backlight>/actual_brightness
 Date:		March 2006
@@ -40,7 +40,7 @@ KernelVersion:	2.6.12
 Contact:	Richard Purdie <rpurdie@rpsys.net>
 Description:
 		Maximum brightness for <backlight>.
-Users:		HAL
+Users:		systemd-logind, udev, general userspace.
 
 What:		/sys/class/backlight/<backlight>/type
 Date:		September 2010
-- 
2.55.0

