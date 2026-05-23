Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341E3CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646A410E3E2;
	Mon, 25 May 2026 06:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvDYjdH6";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B0310E31C
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 21:09:32 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so3713813b3a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779570571; x=1780175371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lm8UJ4hOarUlviQr2levKNdmrXnb21bQJ59ovlralbM=;
 b=TvDYjdH6Xd6lLSuDdlXXCOlkd5Pi9/C33KRy+k/u438kuQA1/0A39BGeE+kdrQnn4h
 ujOzBWm9cVAsA7ymwfRQN+uXWTH84NOYLn4wW9XABOGLvb6ZDaaMcySUEUr2oj2lm7GC
 eLjW4j7XS9MuLPGfUkUdMgV1jOlqPKnDg6MqJ536QCS0bain8K50m5MFW/tRWtHgC9L5
 Ome9Mrf7JHVUXtMyeC1rv9RMPhnGg4xWTek669eqWAIeaJWb/4MDcWyJCTW5RQ0tN98D
 oWacxvxOVj4md90IeBa1LKfcMy15BPFQy8yn8crCGJMaR8YvzgLhrOUW9BW96Dj+d9Nb
 pBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779570571; x=1780175371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lm8UJ4hOarUlviQr2levKNdmrXnb21bQJ59ovlralbM=;
 b=gu8CcvuU5rb54YXBDc3pTXcJl8CS9Zl33B+mHnGaGO3H9W3xDccZnHupvSZ7LdzX+J
 JcFHO/KT5zAIq3EnVLESh3T8j5f4B/YCowZvlH0I9AUj9a2OXy/wy2M45gvpP7wKsnA7
 u4R3KEj07YFOWVQmxv32w4GREWnDe1RxrowldfUGF1WoX8fDdUV0Tw6AL5leh0bS6ECF
 YUDOVr7b0FAOSKSb9dQswna96dp4OozdkkVYR50lOiBLB57YSc99pKwa6GtSkyoVgkJI
 SPAr6mp9uuMj3g1whq3KNfYCNCvrsQcrm3TuRNO0uTUVYa1ZoR1kd3AJ/ZSdKjPufMpG
 6E0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zMhjbkAZKwCn9mXRroTuvsJgs7GBPPws1jJqaEI1LdObV3KdVOFl0HMjDUtCBaltxg8jRQ64uTRI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzf6H6ecuJiC+K8Ig6UScIIcQ1vvHO9VG8uns4Mamanhd9ZUfQp
 Ui6q3gvrxUOsdZGlOQ91s6dcsLTs/2cprHiL5MFvXZ4LhHnNGmubRl+2
X-Gm-Gg: Acq92OH2pcDb8ubdSB/prNPhkzau+fsDOaWhgxYcgvKghklg4eF/Mc+ZdARe5MD7DLR
 Sf6AoTG4aGo99vodIe0m5crLbFWiYnJw6yJT0RIai1Y7uNdP4TWEdfjJD5CGtefby9n7n13bhQ7
 2qjgJ3Gx7i4CbEC9l5mHKir1hmqiuRFEX1OVRO2TVXYs2tWauH14FoHRhTu5KLBXmZcH0+bB8tG
 g8oZki7JeiN96fJBTuQ5aUiZJLZ7rEzZiBIBYyQXuf2kh25JGaayXZrukk2sJcn5EJPb7a/X+d/
 5wMxeEOJiWNtYuQ7lxXxxXuiowJtV+HVyLJwOOr323ch75gTKO8kCf+JGT8xmR5ZZ95Cp7xnGZ2
 jdQ3GtPDT7m7VxbZg6+lISZFBpgsHdLjn1Nbnox/O7AKRG02GPeEwQR1SCx5UFoDigbdhn7i21n
 yN0CTfZaRARc0JioICCjEh2Q4ZhWk3Hmfo7yDIR5AjHTb5jMGL7WMoozvtfTHrIQd5bnpQLN1po
 OU75eM+P0PcIQmaBIfPnJssYY6EHg4N8Bul4Oz6LTdOMz3Bw03fEpeWq0U54loZ/QOV7SOMMTGS
 D5RrItbRfD8=
X-Received: by 2002:a05:6a00:2d90:b0:82c:eb46:acb9 with SMTP id
 d2e1a72fcca58-8415f308ba8mr8634533b3a.24.1779570571492; 
 Sat, 23 May 2026 14:09:31 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.195]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fc646bsm5406884b3a.46.2026.05.23.14.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 14:09:29 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 1/2] accel/ethosu: reject NPU_OP_RESIZE commands from userspace
Date: Sat, 23 May 2026 21:07:52 +0000
Message-ID: <20260523210840.92039-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523210840.92039-1-meatuni001@gmail.com>
References: <20260523210840.92039-1-meatuni001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

NPU_OP_RESIZE is a U85-only command that the driver does not yet
implement. The existing WARN_ON(1) placeholder fires unconditionally
whenever userspace submits this command via DRM_IOCTL_ETHOSU_GEM_CREATE,
causing unbounded kernel log spam.

If panic_on_warn is set the kernel panics, giving any unprivileged user
with access to the DRM device a trivial denial-of-service primitive.

Replace the WARN_ON(1) with an explicit -EINVAL return so the ioctl
rejects the command before it reaches hardware.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 80d4bc21c28f..043541407a8f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -433,8 +433,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return ret;
 			break;
 		case NPU_OP_RESIZE: // U85 only
-			WARN_ON(1); // TODO
-			break;
+			return -EINVAL;
 		case NPU_SET_KERNEL_WIDTH_M1:
 			st.ifm.width = param;
 			break;
-- 
2.53.0

