Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C787CA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E939E10EAC3;
	Sun,  4 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PchpSqVh";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F42D10E0A0
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 02:18:02 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01fd0ff1so343308f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 19:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790907481; x=1791512281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K3VaIb3BtBdftLmeTIXBSMEw6OrRCg+sJcH/2TWbb2M=;
 b=PchpSqVhMDNMvnT2jyoCBoKAcihCJzRbwLyxMBBA8uRGM5eFH6AsawRfcdVAkA09ww
 CVG6FmvdSBRon0a9OoTwPophn9lATJWy3TL8wH121A9GbxZT4MGZ4NK2hozDn9pvQdi3
 Y2HqRCfOUTt7wiYB0MGuFXFcA4gDs45YXxf0W8pe+sKacq67TJIV9uPRyqhCYTHqwOzb
 NNU0rEGR7wHSKY9QBKBiskrn3WzJzqmMKdPNCbiHPxnUdhWKMojU346kpBKX96KWgCVk
 ja93wZCMeoE0QIRqbmGcT2uQNfKj1e2h9jbLcM7OXVY9kl1rnigi1bARd25txb8KjrCI
 8ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790907481; x=1791512281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K3VaIb3BtBdftLmeTIXBSMEw6OrRCg+sJcH/2TWbb2M=;
 b=Tg+HEQFiVbZn+gu/h0r/GsZ93GaYBdpU+JdPPdtUv92k8J1qHBtdOOyrKoFR1OB4kq
 uLG+OqyOr0OrLHOtmirLxO1iXCEHs51rM5jPF18lU3XfCqOiwELvd0aiBNygNFZ5pOtC
 aUPviGP6jQE0DkdtOR1t+TpDsWwUnb+jXYbUHYJN3CwGjOhAY9QTkg9dExfjqg7gbbAu
 TI3Yg+IBefI6NUkUkarobvJPvdugwNc7OIG51AmPLA/ylq1inZd7NbNKkmxfZ+jjamuR
 CP5KpAu/TZ2+PygMaw6bMmMA6oA1nS0uAcAXCBxvONG+o517rOx94dyWr8rdQuAXZWMQ
 jmCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJlFd/BpyNhVGNllpBvH8Fqkfbt+YW1Epk2o7PHdpkB7KLtr8h4loPkmORAbLFJTCBUuwXI7fcWZc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJNk7DndTkAdsWKg+2x+at6mLf8zl3WB8/DNPlsUVM2QZTkk6yu
 saSERvfdKbLT0ewjiRO3NOe2vZBxrhhR+bKbj5PD9FVp57oI038TWZ8v
X-Gm-Gg: AYBFou3GDt81R7/EH4Ks1pxNFzo39QEbOXDOu88lhDS9R8HWTvA36HDt0p7hh5G1QY4
 8iVfvwb+pfhfIP/SQ6ojWf619g/ijZCsvZUbzEUOzJiqZ5H6DryXT9/8YUrPFQ+nnF9JPh0T9U5
 xC+qamf6ZLHNr9sZExes/bgRg/FlmJi7ZsUkleGZMw6A+BewfGgXiM9DZ7jsz9CrxcHDBETjxp7
 49XXOqzmB2tVLrQrfMrkSQgxpFnzn/0SGsoKUNvtrcZFAc/lcNCIUSZrNbp3Gu02G6qzGiVqtrf
 2MsaCqFShbFvjBH/3MbwfjyOyumLOxibJ1PHLRUFvTfj1KcGLED3TVuI9+bgAiOdQocJv4ORWIX
 uFLGJGU0G/IEwZj+u3+A8dXrpUPJ8H6dk9Q+/LWGlYQmsijc1ESEv9Z0fI6N1X8l56aVhdb67hh
 xnyk9apIP1ocZ0uk4e0ri/CcmPvDVhM8bJqv9CLnQK3A0/DLyvvMbUaNEIbb5z86/n/Le7F19Ip
 3cn9XuKdjvwFFvour8MpA==
X-Received: by 2002:a05:6000:2007:b0:48a:f4c1:4301 with SMTP id
 ffacd0b85a97d-48b127206d0mr2096245f8f.6.1790907480475; 
 Thu, 01 Oct 2026 19:18:00 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.71.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253e6bsm1605411f8f.6.2026.10.01.19.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 19:18:00 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, emmaonana18@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] drm/amd/display: fix kernel-doc warnings for cgs register
 typedefs
Date: Fri,  2 Oct 2026 03:17:50 +0100
Message-ID: <20261002021750.13596-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

kernel-doc reports prototype mismatches for the cgs register accessor
typedefs, whose comments do not use the documented typedef format, e.g.:

  drivers/gpu/drm/amd/include/cgs_common.h:89 ... expecting prototype
  for cgs_read_register(). Prototype was for uint32_t() instead

Use the typedef comment format for all four accessors (also restoring
the dropped _t suffix) and replace the wrong @offset with the real
@space/@index params in the two indirect-register comments.

Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 drivers/gpu/drm/amd/include/cgs_common.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.h
index f40b6a03fe63..3a25c3c75a3a 100644
--- a/drivers/gpu/drm/amd/include/cgs_common.h
+++ b/drivers/gpu/drm/amd/include/cgs_common.h
@@ -81,7 +81,7 @@ struct cgs_firmware_info {
 typedef unsigned long cgs_handle_t;
 
 /**
- * cgs_read_register() - Read an MMIO register
+ * typedef cgs_read_register_t - Read an MMIO register
  * @cgs_device:	opaque device handle
  * @offset:	register offset
  *
@@ -90,7 +90,7 @@ typedef unsigned long cgs_handle_t;
 typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, unsigned offset);
 
 /**
- * cgs_write_register() - Write an MMIO register
+ * typedef cgs_write_register_t - Write an MMIO register
  * @cgs_device:	opaque device handle
  * @offset:	register offset
  * @value:	register value
@@ -99,9 +99,10 @@ typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsigned off
 				     uint32_t value);
 
 /**
- * cgs_read_ind_register() - Read an indirect register
+ * typedef cgs_read_ind_register_t - Read an indirect register
  * @cgs_device:	opaque device handle
- * @offset:	register offset
+ * @space:	indirect register space
+ * @index:	register index
  *
  * Return:  register value
  */
@@ -109,9 +110,10 @@ typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_device, enum
 					    unsigned index);
 
 /**
- * cgs_write_ind_register() - Write an indirect register
+ * typedef cgs_write_ind_register_t - Write an indirect register
  * @cgs_device:	opaque device handle
- * @offset:	register offset
+ * @space:	indirect register space
+ * @index:	register index
  * @value:	register value
  */
 typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
-- 
2.43.0

