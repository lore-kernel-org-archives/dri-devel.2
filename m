Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA4BCD343B
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE68B10E48E;
	Tue,  5 May 2026 22:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="CXht79SW";
	dkim-atps=neutral
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0EE10E48E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:27:57 +0000 (UTC)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-c822652f82aso1720487a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020076; x=1778624876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4laXKsJghpQ0NzWYTQfDQ/6AR2f8qW64EMi9UHORnXY=;
 b=Ne3XoSQmqh+Gtcr16Vk357DC515ahqSgZWZTNEbawBEeslntDhvic/FwRasGk3oNJj
 3ihbIodCZqL0XTuLCSqUapQApCHxERYZpCmRyQRkriP7x0MlJ31B92D8g0JTgliOJUKZ
 JJQRGdZJWAgohZQ4YrTtHfJj4+uFg92NvynCfGX+V31Y8dxPhcQhJTztfCKqfkuL5K1N
 EDpSd1KkpBLq0FxJYyqeATDwA90N+ZY2QHLafJKd/W0Rz5L4Y12k5RYfxbm9sFLdI5Dh
 1r+8GXxkwiy9egLK7sUzUVH+xF8Kg7iy1xLmqcwK8zmQTI0zitmcimPbe8IZxNcrLfvd
 sdjg==
X-Gm-Message-State: AOJu0YxQ2KD58oHLYWK3glFn8RiQLQdi38FY+WGHe26S+UElB6QGBU3E
 SWj+g1RrvWGj076Q5lYdCihQas4EX1QJSU4xL1o2GLiim7ssdl+i8TKLIgX264nfy1nttLQRLP4
 jCIpN6coIgjV7XG2ChFii67YvILlXrRmlsOt/WaH91qBmj7ZnR6kOVZVaV3hPZ3yThwqsSopxQ4
 U/xCx9GOSTY5wTyVizm/GwYc5AQ1fv9WRfGtlM1AXDzeAuVlONES6LYYQ7TGvlSei/737QR+wd3
 bIK6wzLuJYxvwk1HQ8y
X-Gm-Gg: AeBDieuvzIOA53tpi3KpkvoywPyx/3LY/knLmVqbskcm2F6x2L/eme8Ff/W0dNfjvvx
 5vxVsm65PvlSOqogd3oHO1eiNDP0voqXl/ON7gWtOy+dXKqJ9rFFpVdJwk9lhJ1XdMndcUXJDeI
 aZVfncvSpDAIEwRUQUaoCj/iRoToqsSZfLAPxCeYFyrfDe67wXR010aKTyas4MqA9UDgVmAKqcR
 bOD1rkfQbIcFiRMLYzg3zpLyAYS12UknrU4QPQMUFrF9LiKjol0z5N10L6mZggttpbeo3Tj/ubI
 hEC9nEs/YPCDE/PpjrXclaFRj6uFT+kbbPRD+sq/vfydJFxnyg11cbXs70vGKJ9jH8o/NqLxxVn
 TFfRndlW4sXs18we7TuLjr9LIBtE+K0PIonv466hOjsPh37UuWFPyeODSmB9wzXOJaInS0we6C0
 9Z2TGqVkmJj32Dvmt8O1B9/2S6THaF9yn/eci4csHoW0YVtdUPjuo0TRdJF862GW/eqNWlf4e+K
 H8=
X-Received: by 2002:a05:6a00:2356:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-83a5dd5c7a8mr622082b3a.25.1778020076517; 
 Tue, 05 May 2026 15:27:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-83962d838f2sm274290b3a.0.2026.05.05.15.27.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b7e68098dcso72390706d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020074; x=1778624874;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4laXKsJghpQ0NzWYTQfDQ/6AR2f8qW64EMi9UHORnXY=;
 b=CXht79SW0A/oOnXy4Q9FbNzv8c3YisQb1+V57XdkdTaPkfJ4bmZd+QxIdYci5BTcAw
 riIDuJVL7Cac7uMlhrtos7vLsg4yjbx0y6tLfdwUdtmdYsJyN4/h03H6m7ToNYi7H7IT
 +/D4YHZAFaRKNDe6SAyLJPkm3JSGUgPidJmN0=
X-Received: by 2002:a05:6214:cc5:b0:8b5:6654:7556 with SMTP id
 6a1803df08f44-8bc45b31797mr11258576d6.42.1778020074388; 
 Tue, 05 May 2026 15:27:54 -0700 (PDT)
X-Received: by 2002:a05:6214:cc5:b0:8b5:6654:7556 with SMTP id
 6a1803df08f44-8bc45b31797mr11258186d6.42.1778020073857; 
 Tue, 05 May 2026 15:27:53 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:53 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 07/12] drm/vmwgfx: bound DMA command body size against suffix
 pointer
Date: Tue,  5 May 2026 18:22:28 -0400
Message-ID: <20260505222728.519626-8-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

vmw_cmd_dma() locates the DMA suffix at

	(unsigned long) &cmd->body + header->size - sizeof(*suffix)

without checking that header->size is large enough to contain both
cmd->body and the suffix.  An undersized header makes the suffix
pointer underflow back into the previous command in the bounce
buffer.  The verifier later writes suffix->maximumOffset, clobbering
verified fields of an already-relocated earlier command -- a TOCTOU
on the device-visible command stream that lets one command rewrite
another's GMR id, surface id, or other authenticated fields.

Reject the command if the body is too small for the suffix to fit.

Fixes: 4e4ddd477743 ("drm/vmwgfx: Fix queries if no dma buffer thrashing is occuring.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 2410d53a75aa..a9136a6523cb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1510,6 +1510,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 	bool dirty;
 
 	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
+		VMW_DEBUG_USER("Illegal SVGA_3D_CMD_SURFACE_DMA size.\n");
+		return -EINVAL;
+	}
+
 	suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
 					       header->size - sizeof(*suffix));
 
-- 
2.51.0

