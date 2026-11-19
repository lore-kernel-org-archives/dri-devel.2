Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F960A262A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hudzPn6J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D7411210B;
	Thu, 19 Nov 2026 01:38:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B2E11210A;
 Thu, 19 Nov 2026 01:38:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6466643BD3;
 Thu, 19 Nov 2026 01:38:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795052321;
 b=ABb7CQ6XWmIevRjQixmfkSH4qTD4iI0xMd8rnQzv1JatxkfxDmlpypICTOj/N9IwemKD
 +vtf48GtZk90lRVf508MV7UlCB8lJLD3Uo9G+Eu84DtrT7XQmNPNSRWBtzMkCgUwM809z
 p/Wg9mv4ZcfZ0RnU2baYijsdQGMWakaNU2YqHsONNy01zU+j5fslKeRCjfHMNHnv5Dcqe
 UAWjvjTXGQbPt6le3H+VOuNwyw9hhTOWlwp8v1Q8HzFKG2o5IyHluxJEuRPugRk0Gg1z5
 V4tXuk8rNjWJfGQjPmF5oKKrsLQv7THxMJktJMSPQikXmDyTAJviDh3vyxKS+0zUq1A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795052321;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=ovGdiYBMeTx1zN0ULwKyloFOLqLaBSuDGpKTNG0CTCI=;
 b=meVscExcxAM34OmKMpYswbg3bUzC0BxGOUpwvfZ9F45pv3tTTNOiATRPMSc/HYz5hKXv
 JWu6O2iTKYVtPrPiU5R9yWQmkjBDqSin+XSshKfOfCtrXl8T1pmC4fwbs/LcOcbMxeRkZ
 McsCyZ+WkPpQl3fZz+og3vq+fKws2TYypcfdV6Cqx7BpPaNAcfG7onq2lVeXfgrpH44sS
 upxWJ3hQ2ShKEUXRcpAEx5fMouHAMSuamSd6/aFRzmG22GiXS+FgVi92WY+zg0OBWcr3l
 beLuYThHcx+m+oyzvrDh/WgNQGC1zFzmhga4gi8Zyw29zMjydkY+iRSayfzoBt0M8TQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DBB6C1F000CF;
 Thu, 19 Nov 2026 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795052321;
 bh=ovGdiYBMeTx1zN0ULwKyloFOLqLaBSuDGpKTNG0CTCI=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=hudzPn6J0bUS18VyUGznGkbPeAuz4ZMwVa5OEgVlGo7KD9aC81b531lgOGT5TfJK8
 DvAp9t+lDn4IsYR05nf1jhLW5kO//WR80as756NnStcKv1eCcbj5DNxIkJI244NbhC
 kcs6p8qSONWP1hsJuITvUwdluREXek7/zLNPKjUl3ksdF3ragvh7pCenCUBT+sR8A8
 qvh7PMyJZsF8DFp37Q8ReL/3U97ckXxcX/fCYZYZr6MlIqqDGfwDMzZr4Il4HY1sFZ
 XixiBnch37TtCUrmWyucOosTELFChcamOFg2pjql6Z28HwilHUC39vIM4Ii82hYOqH
 nJ3iVfgwAJq+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 349334B072;
 Thu, 19 Nov 2026 01:38:38 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Subject: [PATCH 0/2] nova/nouveau: add configs/module options to control
 binding behaviour
Date: Thu, 19 Nov 2026 11:38:23 +1000
Message-Id: <20261119-nova-nouveau-gsp-v1-0-4cde2bc41132@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TnBFyvpKdJBabS8aShKIf0+6D
 MxhpkKmxJRhHSokKpw5hi44DnBcNngSfHYHJdWEiIsIsdiOp5B9hM+3QOnMbJReDGno2Z3I8fs
 vt721D0uK5XpiAAAA
X-Change-ID: 20261119-nova-nouveau-gsp-10f8782498e4
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=a4R+CA33McYCg3MsCLoZGkMds+XhCjyC2e9aLNwAvnk=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq/lMX3zuL8Y2AWISRh7ealRDpz9EVaxPcLG55H
 GUDkx93P6OJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCav5TFwAKCRAMdPNZecSG
 vnCHD/9A8JSADHK6u4S3PFnLGfl3AlKX1XQ/M3NgiCJ2C/H5ixG2dGNm+EU58QykVRu8LBs8hBT
 DVTXl9Z5O/Wj+pNBCvAKcHj7cF9Ies0wFE1AkGjUm9pYKt+elLDwaihXjU6JQZ05GSQoixtIpdP
 +bIS/iGqbXI02QUT7fAtUCkMiMdsqpor38Xp4ZQ11BKKbafgkctr7eRydHvfpZLDCKL+7fD68tD
 gpjxuXUQ5bOj0qKuHKfFoBdpnMTvwZ86Jj5efdQl/5KVLKslE2B1aYZR767NZCNNqLso617eddz
 j5IZCQxTQMIgZMBJQOnvHyl1jRUiTCyJCSXHjR9X1XL6o67hVKPtp3haObrG6cf2Qbn3VODEG+n
 H3dTFbLKcxYfHdn8pvKprQEVjdhU/wP50jIRiPl3ckqjPnaZZ2F6sF88D2ei1NDLqgagJIFND+D
 +gNRwqw9mad0BWBAVqSOiGATCKeaSnqVKKPQzB40/aM3naGzV6punmsu5Rh937al3PI5MKm9wN/
 PZttHKHlHh8zd0TSojV05nk3uKLIWY+mxL/wAsJL9TpVXIbHSNRVVpKxzQfJ7upeirLgk5VKO8H
 fxIlao9BYQNitFgWVoL7qaQqK6uBCU2/37rHGjdJcCbzWO3RDUJEgMdJ+AuQFdpnTT7IWb7y+RG
 sNmVVxMYIFcsV8A==
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

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
Dave Airlie (2):
      drm/nouveau: add option to leave GSP-capable GPUs to other drivers
      nova-core: only bind to GPUs when explicitly requested

 drivers/gpu/drm/nouveau/Kconfig                    | 17 +++++++++++++++++
 drivers/gpu/drm/nouveau/include/nvkm/core/pci.h    |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  9 ++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  | 16 +++++++++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c   |  4 ++--
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h  |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |  5 ++++-
 drivers/gpu/nova-core/Kconfig                      | 21 +++++++++++++++++++++
 drivers/gpu/nova-core/driver.rs                    | 13 +++++++++++++
 drivers/gpu/nova-core/nova_core.rs                 |  4 ++++
 10 files changed, 86 insertions(+), 7 deletions(-)
---
base-commit: e55a991e09e3b44f0b0d8206bb523dc57c086341
change-id: 20261119-nova-nouveau-gsp-10f8782498e4

Best regards,
-- 
Dave Airlie <airlied@redhat.com>


