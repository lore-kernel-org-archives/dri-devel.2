Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F2BC5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE7710EE5A;
	Wed, 12 Aug 2026 07:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tz/Tr/MH";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328FD10E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:42:40 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4997581cdc1so1327125e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786477358; x=1787082158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k8E5dSahX2t9e8TS2QmwDHlG5eYqVM8lZBQUBjnN4jo=;
 b=Tz/Tr/MHLd7QG0P4m5m1RraAdU6ZzA5J8mNYjiAStOUs7C5/Q77V6wenB11wyUbsgm
 O5Jypof9ZCR2Vana4U45seQ6u8s0l5QGZ4BME1rXIPnC9MtwFAEX2sdipp7AEJkL00hq
 eSnoMlC/EGnZQohWJ70X19HOz6ac/6WuvvO3k3Y8W+hwBLNHm6As2l/nVX5VuGl4ALgc
 g3uvOcW6fNkbl9kH9oL7B6QJH0MDsEKjER/ajR4IKMNjxjcVGa21dmR0v6lPPRm+jdxq
 4f/1FirohVex3qQPsSLIR4/N0/ncFhrFkzzzbaykDbucUATH5FurHk7CbGoYUVQzuCh0
 2c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786477358; x=1787082158;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k8E5dSahX2t9e8TS2QmwDHlG5eYqVM8lZBQUBjnN4jo=;
 b=U/b4tPKeVPIOYC4TEBuYhOrV3kNpfcV4ih9rlvF7Q1uw2LekgAZcquDZhLEGRgdzOv
 +ifwV58zRZvNnhIv2B5NMpfqZ2KCD9rzqcbORvE+Wz1vybuwSb6n9MxnnudoZbLgW6Ln
 dSZck7F/woWJnBMfTlZPOEqsVSLLkjVyZIzb6qYtTRvKxTGjUvasZintCfXI7GT2NRGr
 PVhxKCh8wymesXNhCsM19Bp26L1rYTR20XmHQfAJcCaR+1RHLoRatAmNpWoq7lYpH5BR
 c+EqHFb+hgsqG5wJPu1wA6O/830f16Uopen/Ymfctr0lFlOFUuuOzDCspyQItoF/WB9w
 Pg4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RptaRkd8PKzNKCfZ8rKW8svuDbp48goIJO1tS3sJ0emXh4byiO920kTfae9qZy2rgKh4dmIc+pKHAo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/CIIFeXxjRe29sJbzNOZY1g2PIC+eWMz469OlQ9tdrNJ+qbbA
 c9/M4x5c8pu+p0cNwjMyxo8W5q5OdsWss9Ev5Lnmy2KzLJBemwsf4QOt
X-Gm-Gg: AR+sD11ivW08q0sg6jpKd2ojumeSgFUqGEEOa4PQbzhVJMD4bVGkCTqKb9Q6jikCjGH
 WXgGiFHEgC48epF+ZeU4HgxpXRfMedkP2R0ZUEU5DPfjKfhHk8OCuF12Y6dhw9DVmIX1PEIbFZY
 c/bv/jSEt7sD9mbpqmqaXhMP88emAZDRVwu4kLp0oP46q0WyIUsT1TsCVzRINhttqktvHwigKJh
 PRWLXcX+zR0hRQrsf6cs1ac0tJRn4jyzs9PuxU/9CUnw342S2yhXHI5ndYzTJqvZTLtce8snP6Y
 VY1jv+Vvfn4iZ1TfmsJYSeFLYWA7fReSwfOqRESMHqMTg5c8jVnhCYo2KS0KFPD3jqapnfHnSSk
 0EZ4wmuQx2fLVm1EzCqWZkaQjRYX62dr/opplTQeAssyd/B+N+P8pvGFOfZW/3F+Dw+ae6qFDxd
 /0ggX3WExRSbPmMcIARRD8TtLgtkzI3w8SxrViQZvWESHD6A7lA10WkHwmnMc10tKNG9XbFsUYn
 L9ht3NB6fbs2TGblu6ipDyHdu5Uuy6FPCy/0jYLVMo3YUpHWSK2MQqQE2h/tcw=
X-Received: by 2002:a05:600c:1c19:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-4997842aa4cmr74169505e9.3.1786477358290; 
 Tue, 11 Aug 2026 12:42:38 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:42:37 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v5 0/6] Series from memory leak on qxl unbind
Date: Tue, 11 Aug 2026 21:42:15 +0200
Message-ID: <20260811194224.121597-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

This is a series of bugs that leak memory on qxl unbind.

For test you must apply first ("[PATCH v3] drm/qxl: fix use-after-free
in qxl_irq_handler on PCI") because if not, you will get
"---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---".

Link: https://lore.kernel.org/lkml/
20260727110212.64913-1-megia.oscar@gmail.com/

Óscar Megía López (6):
  Memory leak error in qxl unbind
  list_lru_init() does not check return value
  ttm_pool_fini() does not destroy list lru
  ttm_pool_type_init() does not check return value
  ttm_pool_mgr_fini() does not destroy the list_lru
  ttm_pool_mgr_init() does not check return value

 drivers/gpu/drm/ttm/ttm_device.c |   4 +-
 drivers/gpu/drm/ttm/ttm_pool.c   | 194 +++++++++++++++++++++++++------
 include/drm/ttm/ttm_pool.h       |   2 +-
 3 files changed, 161 insertions(+), 39 deletions(-)

-- 
2.55.0

