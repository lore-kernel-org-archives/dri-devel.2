Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BE606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+poj7FV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3096E10E1F5;
	Mon, 23 Nov 2026 02:50:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338DB10E15E;
 Mon, 23 Nov 2026 02:50:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0599941E98;
 Mon, 23 Nov 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795402240;
 b=zrMAUkPgD5aVRe0teqkdHc+2inj/pbmExokRB7dpizoh7Y/JBOKCTNntRdKpmm7w8YOD
 0nPyA+qR8riEFwPmFAHGsQ5F1TLEA5iVRFp+JEndfQWvC/+Y5yYjsO+6CARfrzI78zGaB
 NW8pxHpsKmJuj85SGkJRHSPSPXEC+w6PIjSV/lOYKuFVBL+qpIdjUAp2iMPECPghfrz2R
 y0IqKD77F3m22TM4UcBd6+mv4htSVd9UJouZ4kOYzTHEC4Y4wV5v+i19p9ypTnL5jXsPD
 ylFSQgSxtA2Vl/R7AGQdQcAi1IxDOgnd1ztyq1jwAQpujAttJoBozxKOMWZCJzsuHmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795402240;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=PCPIjJCy6tJ4SlAiHcYkV3EDM20q6q8/lAdEekmMG0g=;
 b=BkNc18ktxrzUJM7V+WVCM+Dv+c74dK9Fn0DiQNJmMSYmKa1aLjH/eEq82w1VXBF/D4WO
 hl25JjhNpiZ0L0IEH6Q0vWuLy0++0F0PWwtMRm1YKg5Nxm46LbqjSmQ0jMEXy5AHPTby3
 PFRKVDwhCS7AYd6hl+lHVap+V2sASRH9Yy1y3nLupMDQ8UcgZVSAODhHtL/R5fIH/U0e7
 SAQzFUfURI8WYiajTPNiHnTP/v78587CuSoqMFHjKABDdaGAbiSrBjJWcWokHDxYL+KJP
 3djfZtV4x5aEvuitf9sfwXgOolnkvmTBplft80jarLHnw8zAwHlj+F0AcgVPCn+OCHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5EFED1F000D2;
 Mon, 23 Nov 2026 02:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795402240;
 bh=PCPIjJCy6tJ4SlAiHcYkV3EDM20q6q8/lAdEekmMG0g=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=U+poj7FVuwIL+/6T64sfZEtmoUvDEIdtgCO/j4fnMY4tJiTPK+ES2m0AZbkZnMmg9
 7qZRZ/Z2HKcX5YkHT3SADHMuvi3ke1UVusatkaK5oM1r6mY8gpZ3rWsfhZsSXBaP5F
 swQEQzcCGE8n8LQXpMIAh2TBwUs2UGdcHuKSzJjDoqaQZuwQAX4gjtJnOV17ldv/kV
 qSBEZmR44IU7+8m7TxEQxLpGdzNEsGojT1coLXenAnJvDIJWfYNzBqqD3+poS/pu06
 e0DzVmfrPLo4+NJqKw7eWZ4AMx3ZZSHHpaVAekULtpVxKiYoXlAm10986J+mxaWWi4
 ODjcNBwRnzFYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B205B4C2F8;
 Mon, 23 Nov 2026 02:50:35 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Subject: [PATCH v2 0/3] nova/nouveau: add configs/module options to control
 binding behaviour (v2)
Date: Mon, 23 Nov 2026 12:50:26 +1000
Message-Id: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CIBREr9L8tRg+EqWueg/TBcJvYSE00BJNw
 93FHsDNJG+SebNDpuQpw73bIVHx2cfQQJw6ME6HmZi3jUFwcUXEnoVYdIutkN7YnBeGfFI3JWS
 vSEKbLYkm/z6Uj7Gx83mN6XM8FPy1f2QFGWfSWBJPIxEvYkhknV7PJr5grLV+AUqGK1mxAAAA
X-Change-ID: 20261119-nova-nouveau-gsp-10f8782498e4
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=IQCBoG1+S/7f8h44/YGxX/CWODzrYVl8kCsL3KZ4I/k=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBrA6n1R6zlkhvEaaCyFyedYEwVHp1wtW+AkOVc9
 7oo+hB3yPSJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCawOp9QAKCRAMdPNZecSG
 vtiVD/9mqrXacWm7aSQDVc5zvQqY304JMu/3BpMdQpx4kB4xbHO+kBdTPFoTvdo62Jehv2N02q/
 sCH7tp+qWk3jFaHcgIuNRn2qR6J12HOuDMNohpcBTotg7BWxjOQhonGxVe/VH6nNwub/f0lL1rA
 jTBOPMpikuD4A1ZN9xAxw3PFG1uRVhpTYoi54HSG62m/NNNNEMwApeatvTZ0OLebCgAdZcu7SBI
 BT5fopdwVmNF/DdIuKKX5eLMcCtJMEbB6X9h2wC3OawrhFrltQCbe9GkWzMAN3yjsRoUVSGBiOB
 VYdW9i7ISn/Z60qgphBZxXR6XIecq+7EzbhxRCY2mP8tzQHp6lYyYRSzzm0lcYXQtUJI4vUCeav
 ctpMeK89B6ekxielkKgJ7UZojWYniOFoL6Xt8tuL8JDDpC3BI4lCYr9BQVIL4TDpWqicQvg4Xeu
 KKoUalumlPR6SbgXtJXUsia47qUZUR8kFE6WS5oMbzbiAvBQuMRErFaW0xs2ViFr/CTSCtfIcix
 nUaK0zQfw0lnYWB0UjHHgu1OdyU+IfQX3LnqvLLVMgk6VcosdF8xcKBsXGabPtrmMBFMVjG1GJH
 usuGV0zBJpHSe3AagqGmTP10zA2iFm/KKZllfctGDGqBBH/fCVuPMx4LG+6fOK5nF2VSaRWlok8
 aUZg+xrKXqc8TwQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We want to be able to build both nova and nouveau and maintain the
status quo for now of nouveau binding to all GSP enabled GPUs.

In the future we may suggest switching the default to nova, but
for now the default is to let users use command line options for testing
and developers building their own kernel can set the kconfig.

This contains a precursor patch to fix the nouveau device cleanup paths.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
Changes in v2:
- nouveau dtor path is broken, so fix that before adding the new code. (Sashiko)
- Link to v1: https://lore.kernel.org/r/20261119-nova-nouveau-gsp-v1-0-4cde2bc41132@redhat.com

---
Dave Airlie (3):
      drm/nouveau/nvkm: fix device leak on ctor failure
      drm/nouveau: add option to leave GSP-capable GPUs to other drivers
      nova-core: only bind to GPUs when explicitly requested

 drivers/gpu/drm/nouveau/Kconfig                    | 17 +++++++++++++
 drivers/gpu/drm/nouveau/include/nvkm/core/pci.h    |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  9 ++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  | 29 +++++++++++++++++++---
 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c   |  8 +++---
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h  |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 18 ++++++++++----
 drivers/gpu/nova-core/Kconfig                      | 21 ++++++++++++++++
 drivers/gpu/nova-core/driver.rs                    | 13 ++++++++++
 drivers/gpu/nova-core/nova_core.rs                 |  4 +++
 10 files changed, 108 insertions(+), 15 deletions(-)
---
base-commit: e55a991e09e3b44f0b0d8206bb523dc57c086341
change-id: 20261119-nova-nouveau-gsp-10f8782498e4

Best regards,
-- 
Dave Airlie <airlied@redhat.com>


