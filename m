Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAAFCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4F610F5B7;
	Fri, 19 Jun 2026 12:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="cr2YXzJ3";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A197A10F5B7
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781872891; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CyN1154WZ/NAc0TQlBG+2DVffLtEWyHKS6roORjQIJXtq/50Ov3otwi9B/QhDNVhIXfLOrMllMc0vCHHNyC2kpTDDuvILWL+Jmov1ytloOmNbqNBO4hhzjP4rL5TLCooEhHAR18wYALtarCgGicJKTQY5hm6dcjBtGPPKCWXg9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781872891;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GIx7Ll6u2ayvzHSTOxM6l/+JMoifF+xcWgxeeUuSym0=; 
 b=bQvz2tBretaPO08/j4gBqPOvhii4AAgu4SGRYMq/KCtR6p5/aRkguQYp2f49WmbXHvFTIQ05fMprynIBdUb+mMXJa/9Ta8yuTrysMgsBIEustAPRCN1Zq2DNBEN9T2vswmtB2+iAoGYrKz549zKVJuVgPV/YPBga74IOlRQtYEY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781872891; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=GIx7Ll6u2ayvzHSTOxM6l/+JMoifF+xcWgxeeUuSym0=;
 b=cr2YXzJ3lT7V+a7dd4ilsFiWejKL5hmWBIECmMZek6SdTPoIKsv8z0B5MznWyGXY
 +7s2DP69SzPjse2EQ2iJ8ujf7jVHIKgholU3X9AK2RW+BT6VlDSJ4BOaaHlbYR5x6gt
 HFDO/K8c9Pb/KNilTWJfujiSnnAK63zYHVzlTVss=
Received: by mx.zohomail.com with SMTPS id 1781872890417388.1536192482554;
 Fri, 19 Jun 2026 05:41:30 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v2 0/2] Add vm_bind param check to ensure no overlap with
 kbo AS carveout
Date: Fri, 19 Jun 2026 13:41:21 +0100
Message-Id: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6CMBAFf4X0bE1bYRVP/ochpC2rrEJrWmw0h
 H8XMF48TjJv3sgiBsLIjtnIAiaK5N0MapMx22p3RU7NzEwJBQJkzlNfG3JNbVu098hzEPvCaAG
 lFmwePQJe6LUGz9WX49Pc0A5LZTFaioMP7/UxycX7xeE/niQXvCxAlgcQSuPuZH3XaeOD3lrfs
 2qapg9MMPD8wgAAAA==
X-Change-ID: 20260614-vm_bind_checks-46075ba069a0
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=FmAwkaq+//SmB2o0I2pThHzvzjhlTfCltShOTypa7X0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqNTj4BHMZRDhY/h8mL7GeaW95ciQ9NQJZb8Hu8
 +Hzdg4gxpOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajU4+AAKCRAOJn5M7lND
 PXPfDACP5n6w73EVlxIBI8s3+exl8yIU7ak6Z2xF61eWqxe2lnxOcnq/k0Kl8QEnkPDcL3tVORA
 SkfsDzX/HZSbdlkbYD/bl5SlK+xsSK+ylsY037D4jKc7oRqzymPhFT/Dht9qrIOSYfADjAkOdzG
 mRxFj20A2B4eDGlihrVMbkY0drO+yhsgcuVsDBbXDz6qtZDK122urQowLXAQyxAaEnB1CsY4Wop
 kdJ1nJw/sen40v/AVldBD2b3mm1dEzemfcSdd5sp+7342YK50cxQ9PGVpaSL8oiNs3t0smkBrjV
 c15uBPcmuas8WmUP+F/jGupZsfJBGzhH6uZfVIWiFLClEkY0vrLolf9vuscS70Sok0opPXI7SMX
 BHl7IizK/s9OOcL8neD+A+QsrXX/si6uOjgL9FOA7Aoufrm750iJOgfICNSqJHWucxhmaZsln4O
 fAgSSOZr1qCk8/+J0kDE6c8qs5Nj8mtnd6diPycqeKHdKnqh4vxUhO6n186KMxH9ogjlU=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Just a quick check to make sure user-supplied vm_bind regions aren't
clashing with the region reserved for kernel bo's.

I tried to introduce a similar check for panthor_vm_alloc_va(), to throw
back an error when mappings of kernel bo's against specific addresses fall
within the auto_va region. However that is not possible, since there's one
FW region that must be mapped right at CSF_MCU_SHARED_REGION_START. That
is usually not a problem, since drm_mm_insert_node_in_range() will pick
the next one available.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
Changes in v2:
- Simplified user VA range with kernel BO range overlap to a single statement.
- Link to v1: https://patch.msgid.link/20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com

To: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Adrián Larumbe (2):
      drm/panthor: Add vm_bind region with kbo range overlap check
      drm/panthor: Fix comment to reflect actual struct field name

 drivers/gpu/drm/panthor/panthor_mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 2afdfc658f7a7e9ee2a67ec6663922da9c799c53
change-id: 20260614-vm_bind_checks-46075ba069a0

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

