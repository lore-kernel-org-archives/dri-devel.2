Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D60DCD5BC7
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651F910E3E7;
	Mon, 25 May 2026 06:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZbO/s/LB";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F1710E31C
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 21:09:36 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-82f8b60e485so3530575b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779570576; x=1780175376; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m75pjVJH9fVWqs1GIsLd17VZCLb6FKMxe/bCaTR72AE=;
 b=ZbO/s/LBVJYtIJYOJwjdHWu9U9nbinKJb0TPAOl3QvS+ndx2bOODRDi4EXsOi5L0SE
 MB5ITaA8bW5CvToMv2XMk2VGj+aMHe7lzOxqglphfR8VfthEh48ldYrp9G5Jl8/AvYfC
 RWwc/OJl6VH6/0IBjorte7hz9dJhL+P8isX40GbJiQapr+kMK/HJt5K2nMKOJcTOQIcb
 YGJpgwm67fiBzWJAco/tPMUXCEiFRHmdjEAOgwniborRXw9LOxyX52WaH0EJUFTE7OQ4
 SPk6xhtADxDhktZEB+W5vbVRNmvwOAPAtr8MDKuzXiN35c3g4WpMFNspTwgis7bWT8wn
 QEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779570576; x=1780175376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m75pjVJH9fVWqs1GIsLd17VZCLb6FKMxe/bCaTR72AE=;
 b=QdUzmmkOicy5/EdlqQhX9RqhqXfbyRWGBtY0Tp3dHqxoOfVmYYJfFZLfYKpVUfURQ8
 AdyQuWVGRK4iC4ZQmsHY4F2z86UdfRQNyd+A4+nqSzbeMSzg50x4bzvxsvn2nqRApVwt
 0lYPaPD4m8OR9bM/ob65ySBQ5WguoA/+KEd7b2W06LaV6wE1oqj6LNT2lVvh0wdSL6Pk
 FzKtjAvpyPO968B0M0sGJHmntDeXyW9vvzDazuDhX2FLTqn5NNCPkV89x8odQgoL/9RU
 8WTUIeKtOLTUxP3JNLhxXmAqy6upd1YELcuxKCVWl0MhWNVs3pZISWlwNgshTK2q8Oob
 m3eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JNkYIPFuowypB3GN5uuHuio0KTzdh2b2tv3sOSAK6LQ0KvKe16++brzw2yy7SlNE3aX8t6bN4Hic=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxipj8ruAodQHXVbXiNk1eQRCXVNFluQ9aWXOdeHrba87inAf/n
 Fh2JTbU3hHn5PsCnE/LsjRDFEN6nRRNDZeADfXN247oSb95vNCQi5qFpojhbW9MxIRjO2w==
X-Gm-Gg: Acq92OE55hl/BiBadDoYKynmBWkUXozoVTHJv6zyqGtUFOncKlDvjVb6/sGafrkMZvk
 qOdZ3ND4U/7Y3UkoNEymvtmEOUTs06YRVNk+HLT9Mqm4p45bP1EgOME3MBTy3mEEJaTcSMefwBq
 KNo6jXy0rAM8laITii22EmUMQOjWAQcUiuPNDQUEib5rg0fXqTayzjLgg4TgLpkyt1QvOioCbtJ
 P7tA6d7w4/G3TKZ8cigxFLCyPkHXY8JepmWryAQTiQr/CaqbsEzlniVpZ0zDDdZYiG+NydYoqym
 VeboAN2iLz5B5SA6y7+2NmOblv+1U8Xs1aEbc5jcYohVsdFsoqJ1MsozsS8SONJo19s7q0t+hvh
 KEaItmzLgEKGkON+xGZ5kZozevs9M7Uege5YzXl8cQgZKK9erkJbNCpCBrLeA7w6YfAOmkEiOfu
 9Rb242vE4729a/aOWTyd6hScuIWh+rYzCiIwxhgutpS3JJMfsTxdwOl22OLJm7sHU/e3wg5c00p
 WVWr4GhJa0XZdrTYZq57KHhFOKwPaKTuLuOyZ8LFDChJ837wvhx2KDeXB/jeSpXRDsCKWgFtC3I
 RT5f+W8TY04=
X-Received: by 2002:a05:6a00:348a:b0:837:e9cc:d460 with SMTP id
 d2e1a72fcca58-8415f15b4dcmr8301554b3a.18.1779570576015; 
 Sat, 23 May 2026 14:09:36 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.195]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fc646bsm5406884b3a.46.2026.05.23.14.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 14:09:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 2/2] accel/ethosu: fix wrong weight index in
 NPU_SET_SCALE1_LENGTH on U85
Date: Sat, 23 May 2026 21:07:53 +0000
Message-ID: <20260523210840.92039-3-meatuni001@gmail.com>
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

On non-U65 hardware (e.g. U85), opcode 0x4093 is NPU_SET_WEIGHT2_LENGTH.
The BASE handler for the same opcode correctly assigns to
st.weight[2].base, but the LENGTH handler mistakenly assigns cmds[1]
to st.weight[1].length instead of st.weight[2].length.

This leaves weight[2].length at its initialised sentinel value of
0xffffffff and corrupts weight[1].length with the user-supplied value,
breaking the software bounds-check state for both weight buffers on U85.

Fix the index to match the BASE handler.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 043541407a8f..5a02285a4986 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -600,7 +600,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			if (ethosu_is_u65(edev))
 				st.scale[1].length = cmds[1];
 			else
-				st.weight[1].length = cmds[1];
+				st.weight[2].length = cmds[1];
 			break;
 		case NPU_SET_WEIGHT3_BASE:
 			st.weight[3].base = addr;
-- 
2.53.0

