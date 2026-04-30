Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DE8FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0492A10F241;
	Thu, 30 Apr 2026 07:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oAvkUQod";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D0A10E41D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:04:41 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso546761eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 18:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777511081; x=1778115881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xj+Q6F5F+cZDdWH6frNMQBdZyXrMvEZgcQYJAjUh6Z4=;
 b=oAvkUQodhoTtI6dDL5iM0iLjsNaLdITt5K8AC8lgRS42jVRQifVeoIcxhVo3Ub5bHc
 0WyVmE/1oRYrRixs8O/FN4lX4nNqHqcHrEkTzDMX5S5I3pmzyOyYz5AfwUS2e/9AlIfm
 mmIXlK77YEV4gKk+auixTHvQvW/S6+WG/WKunwW03DyObNDAvBozK7a5R7E5YMbwOgu1
 iskEEhhsniA2ZYy7FZgZlwAs3ZrwIJObs5Ira1/8CjVyfXaisD+W/mnYIH9EWHYdZBSZ
 mMDinbMbII3yggQF9yXapuqhYggQjYxHCCv86jDBXcJCNaaONvWCQ2V8sITSeWFAI4Ff
 ZKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777511081; x=1778115881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xj+Q6F5F+cZDdWH6frNMQBdZyXrMvEZgcQYJAjUh6Z4=;
 b=FgMvg9dLSGC1+rizMqJ/dVzs958nxvj2UYJNSm6ojaGUB92TfqYLStBkIS4UbXQJsD
 017mDMS6UzugTdGh9MjC1n8Dgd3UFcQwdB7kYlJKGkzE8F0QBhrUWDCEuHOUoJofJ+6f
 YwloUT4zogdyI9C0XNBaCKJ99DFGGbwIxZaKSo43YpqMAiiA8Y1g/TQYOu0MKLhi/joN
 FEffBlyGXAAB/XiYE3vWIJjzBZEWr2KQ5pLx4uKmXrjsI7cJ9yyR23M5mQTjnj6Fx3z6
 vi/jz7iVNO2OefiX13MbRtBXD3MdoUTOCQF9vl33qmboH1Z4elCsjzVErg5NxkeK1KhS
 udrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N5xgvgTEhF2Gvieu1P+M78gAL19YKzDMKLhILb1TKpm10Ec4nQhckbhGKnMoRiF/YHQJCBolz8Dw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUG96PU+SxLcK718eiYL3Z+b3wwZ8sN/O+1T2n9L5e+/ZS/ymh
 qbImna63Yz+jFywlRjYU3mkMkA+jkFP6U0ysICyRZY4zJHPcxbKBJjBt
X-Gm-Gg: AeBDietpps4/udfpugXenO3vlLYeeZFnNE5l5qk9iIQYj1xmbJXrHogsxH55fw7LXMS
 PsHC94vTKDMh2jzln8woa1w1vaElQiOMM2r5+FHjWprQzZOCmJBi1eRce4KFMozxNruWjLKNLTL
 NABtYkl8Ao4vRInIk/JOeDKX4uWmwQ49INI9Q0sqkXiXBHpeBn1Of/endA6PA6pcDsWF9udRAqs
 5Mdl0IrDPWqVwwRE/Q7hxAMCgvcrZWW1VTPSsezM033JhlUwe+qUAapYsSR+g+4zDK1jSm1eQmt
 NbnjOfAKtrtUb1GcsWIqqnA2isjGP8M9QMXLOCAHo7u/IeCPLpPzEZYwJ2g9DW65KQld51xuhPo
 pfgd5pzxk6onPa+aw50G68a+vLUg+A60nvqQYyIJ+AC9nGKpeZuQnojmhL2/dmmzh9tSpyskM0F
 XbUonKN5DVovcK0NBxLe5+3HstG/xfyNjs3qNjQVTj
X-Received: by 2002:a05:7300:324d:b0:2d1:9b35:4eec with SMTP id
 5a478bee46e88-2ed3c4d51f5mr222411eec.2.1777511081095; 
 Wed, 29 Apr 2026 18:04:41 -0700 (PDT)
Received: from localhost ([2804:1b3:8302:9360:6bc7:11b1:cec5:a693])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8e268sm4534653eec.12.2026.04.29.18.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 18:04:40 -0700 (PDT)
From: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
Subject: [PATCH] Fix kernel-doc for amdgpu_display_manager
Date: Wed, 29 Apr 2026 21:04:05 -0400
Message-ID: <20260430010405.52591-1-kenner.linuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:37:56 +0000
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

The struct boot_time_crc_info is not described in amdgpu_display_manager.

Running the `make htmldocs` is showing the following warning :

WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 struct member 'boot_time_crc_info' not described in 'amdgpu_display_manager'

i added the description that fix the warning and describe the struct.

The warning is not showing anymore in make htmldocs after change.

Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 74a8fe1a1999..201b4796b591 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -347,6 +347,7 @@ struct hpd_rx_irq_offload_work {
  * @dmub_aux_transfer_done: struct completion used to indicate when DMUB
  * 			    transfers are done
  * @delayed_hpd_wq: work queue used to delay DMUB HPD work
+ * @boot_time_crc_info: Stores CRC information collected during boot
  */
 struct amdgpu_display_manager {
 
-- 
2.43.0

