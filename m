Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73719C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D524810E69F;
	Mon, 21 Sep 2026 12:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a+mw3rMP";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D2710E69F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:36:18 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-912355b1bf6so10882496d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789994178; x=1790598978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kphgiGmQ9Qt5obvQb9FWIoJ6YnHw/jm7tChGQTNffwQ=;
 b=a+mw3rMPqy4Q3x8lsPw9AgOOdewppkBmxBKONwQHNbVksCl34VrHeK6AlWsxuzLTBP
 4GGNAkqucYA3cH+FCNTpwW24O+ZHQSMYJZVYzg3xqq39hwRDo/SRyFJiOy4K3j/Df/KB
 v/GfLKEMZnekrYH3TsWcVcTPtU9t0rLuS7ai1GkT0qSpiJXEX3UntFO3EYNY7m1MHJ71
 xNepDrovd+JrYgHK2Da3sPVEkOxu+49VVkecOAdfvjGcvMxkhLqolquMapdmSNjdqJu4
 ArzM+y9mt45fi2G6m8UHQdH9yvkl+7a/SPWTiCyAay8OxemLb+oUcY/SLeDIumZwzF5V
 R/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789994178; x=1790598978;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kphgiGmQ9Qt5obvQb9FWIoJ6YnHw/jm7tChGQTNffwQ=;
 b=ZpVuwn/BXkS0ZXwAfVkOvUarQXpuvZ3jy5tYEryPoc6QMpvwbdZC0hTZD0+LN7t91r
 l4+k3PPuadBszkUJZxgLVcfd9JO3rkFAOyGBGaeufDa5nLEEwsMUY1UDvcSOe6TZNuTU
 FSJbiCmv1aWX+ML3HE3r3kizEnS5fApM2fml8TbIhpYAY/Da5mwvIRjB8ktYKLg7agby
 S8GSmUclEnZWyG6k8PgAtSvW+Yg6UE6gdj9M9zG8DeGwPYbOOxhDrYwQ+l97dcBP2jz2
 8qEwQWi9FHQ4AwvdnzblP7EemtG3cjv870V8HVUYXpe1QKJ54qjzhOIAX8q/QjvhJOeH
 b1QQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWkuNMuaHJBOaa3cWbKc+tQtK6mPRlSC765tCGFigOdUJZB64RLbrOwaisEZlwLAaVSULVdWrDtjs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++myEOSn4FrkDw2jtriXTqjYJxbyqb7UVqOGHEh/CdFX4bi6FTqI
 YODyRcoRatfMwWrW6PHvcEXDIeUP/aNnQ/gxessfrCPWAZocTcEOVGcL
X-Gm-Gg: AYBFou37adMNF5eugf1+nZyJg8Peq/oba6cQ1aUetsQRpcI1gAB0b3qnhSa0ijjohsp
 6LdbQ0AN/ufemDNYPbuO1zvmswQL6p/LBfp+c7aLMZFU4DbSRwf5i5cooAKSvLTzu8ejAlQqmnX
 FTahPCtbEg5gBpnfM3klqTmdgNEWuzTDp0Ie5QQI6v6g3aoQeqwfQt71B9TOD5DFTG0qJlSzK/e
 S7OQMWW/inSRzT8ovMFYBuePoFgL63R5dK3asH60/4T7LXC6x3S9HJsWRNBqcN4eaYBVyS50ayv
 E0McIJNG+GJWkGgDEx0pVipZV1FKsWH9umtrg6AopRtyG02GtZB4Vjcl6ml3nRi9bdYCcKxcv52
 QqgKBCR94P1opn35dn/fihrxw6OkgqkZ/DJosCCHK+aQWIP7BfaHGS9nXY6GDAvNIQ4IlGh/fyy
 MvLCdb+Vm4zUTtAYViiu2O/w8fOgIlAspKvrbmq0noZ9yE7+YQhffFImrcVHHPUfxVi8sDkDg9v
 ueuOZ1pF9fwYw0arA0CtrNM6g==
X-Received: by 2002:a05:6214:3d0c:b0:910:3b67:4dd9 with SMTP id
 6a1803df08f44-913fc95142fmr4140096d6.17.1789994177921; 
 Mon, 21 Sep 2026 05:36:17 -0700 (PDT)
Received: from laptop.amd.com (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91260bb63a9sm64471056d6.49.2026.09.21.05.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 05:36:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: kevin.tian@intel.com, jgg@nvidia.com, nicolinc@nvidia.com,
 leonro@nvidia.com, leon@kernel.org, dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] dma-buf: remove pci-p2pdma include from dma-buf.h v2
Date: Mon, 21 Sep 2026 14:36:13 +0200
Message-ID: <20260921123613.683042-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

That is unecessary here and creates an unwanted dependency to the PCI
subsystem.

Use forward declare in dma-buf-mapping.h instead.

v2: switch to forward declare

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/dma-buf-mapping.h | 2 ++
 include/linux/dma-buf.h         | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-buf-mapping.h b/include/linux/dma-buf-mapping.h
index 09bde3f748e4..64c03608cce7 100644
--- a/include/linux/dma-buf-mapping.h
+++ b/include/linux/dma-buf-mapping.h
@@ -7,6 +7,8 @@
 #define __DMA_BUF_MAPPING_H__
 #include <linux/dma-buf.h>
 
+struct p2pdma_provider;
+
 struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 struct p2pdma_provider *provider,
 					 struct phys_vec *phys_vec,
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d15b2b31d3c9..159271fcf3d2 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -22,7 +22,6 @@
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
 #include <linux/wait.h>
-#include <linux/pci-p2pdma.h>
 
 struct device;
 struct dma_buf;
-- 
2.43.0

