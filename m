Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDB606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFzJuM3y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED0510E62C;
	Mon, 23 Nov 2026 02:50:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC0010E1F2;
 Mon, 23 Nov 2026 02:50:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3238061449;
 Mon, 23 Nov 2026 02:50:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795402244;
 b=jLzmSyoP4PbRhnqXjK5KoBtcncEcan04y6PswTq7xAOkRE1fxj8bfKnYusvOU8mlPCFe
 mpMp9jvsqt4GFHJb6Aq99d3emfAwpiHdeV6HM96GGLlLP50EmbtDAVTEaCT33sPEud3NV
 vwnL18GAoLp3rl3IJQBMEA+Ydu3rTIjRApJ8LuhuAmmx39QlZFa3/TBli0nU3VumeSJWR
 lY/x933jZhfn7AxxlOg6oRCFjkxPRgLvdDnXfwUG7AuhVmw5EXltzf+E47+98Z5OaC3wD
 CSEOQE8Ad7DeFpLP9u8Cy897bKF3nB2xPJFtxRUFluGf1/wEgjhtbI7iZJMF+ifLMKg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795402244;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=rskeYCrPM/0s7RGEmCwCmyhiLRtHCWlYi6FOlmiqDyI=;
 b=geFDppnodVaivPfHFGEpAP06JWgTrS4Um80Bw8WhzidH8YF8vNT5tF71Zpyw4mtgVqjy
 7S6KpxcU+SJ+HB8x0QL8Y9VACpjmRMw32k2Em3uYOxCKwDi4tyU7ymkTRSKUgpAucx4HE
 P3oemit7lJEJ4C149+6Fg/x1Eq5k+shDhR0fHbFTw60gOK/9xmujb+gAR1hpHVdXTmAcE
 kNpKnuKpTYEY+n6o+uMng9POd5BHPo224ZG0T8vozS299bnExcUn2QRcmPRMKeMTByVuR
 LSWhGDXDmLmg++qmPEG0v31WN2/1vPcelsxIhEY/QUsOMDPdGoX6neHx2+PfnOdD0Sg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5EF5B1F000D1;
 Mon, 23 Nov 2026 02:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795402244;
 bh=rskeYCrPM/0s7RGEmCwCmyhiLRtHCWlYi6FOlmiqDyI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=iFzJuM3yjRoki2fbMHZ+Y20k49eiVcy33yJIdcBMzhd6gpMigKeLxqQLfvS5BRb9I
 kM3mU4tyUEwdJ3CAYf0wf4nECNvZJP6NOlaqLseNeDtarcO2q8JWTjKRdw7m39MOs5
 BQNl0T0sqvBNun/jPeVCZsBPCoBcYs+frYhAMX4HW1yds4xiUwaqvv7G7IaHRbJY7A
 TMck8ZX25K0Ol+VnakJa5DYeLgPwa0+/dHP4y+NSK+qGhy88Nz28toTrKkcaZRSAb0
 UsDbpodWoSoEAcvakcM9XVmG1+Qxcv5uTeJERIq6iLFvEAmCuFe2xjeAPFyNMesFqt
 CT/cO0yvFdjJA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D8B154C2EA;
 Mon, 23 Nov 2026 02:50:35 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Mon, 23 Nov 2026 12:50:27 +1000
Subject: [PATCH v2 1/3] drm/nouveau/nvkm: fix device leak on ctor failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-nova-nouveau-gsp-v2-1-5e8c27aa8555@redhat.com>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
In-Reply-To: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3909; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=FxQfPnbiZkoWyGg4qBk10lfI9Hri+d/S962EuPutKEU=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBrA6n6anMYHK63Q0J31oUW/5PpHvs2g5RpShL2F
 L6Iu0Iq4nKJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCawOp+gAKCRAMdPNZecSG
 vvgvEACMoLrNbIEJ7IHYcOOhmSDlOr3dWKhKT5XQgLcWTBeQAKCu4EttfNbOYKMHH23Wq+oTWcp
 6+h+ckVmVkfrgI4B5SHp6ebSSexhM2VvIlRct091miELwNw4pVwWscNVr1qGTm3kcg8eeOA/0+g
 6uiZMW/KahcxS1BXtNz/oNz2vzuXhVJtwRlfANsICN1+e6RjO7IDQLcTdSh6lRNkO5qstgVVCHB
 tccWaFNo7V1LSHiHjKmnZFL+xXLRmTPFZdCzEjOE+SKZFMYvcDBn2fmzbzETbOliwUtgk9Avqhx
 6c7f50m8m2KWe9DfqnuT57LSbMKb8Fape5k+ebLrSA98cCfWdMNduXhgIS/VEpppfGpGUQoxLa4
 YC/RsTL7vC5oMG8zi3QzkKOBly/Uqx29cFvC0z3Uvik5VK85KXeQRhFXsInkcoB1KvQPci/PrwI
 VD2r+WXUpwTA1U+sN/7m72vWr/llIbsO7RcMd6eNts6tX6i6vJhw/HvNTo0hXjQA48xnU6HPGvS
 q0wc9RspgPccUSXXNPhCX8os1yheRbLnoUJHbwC5LMo4s7m0aj8VnzjffJoG+X70hRIbyYhbUuG
 RTgaEr2Aaaa4yN4eiEhy1tW/VoQE7GzjfR/K8d/EEBnmzls97CNo6h+FusgdHh9iHqMqb0uBC94
 yRefElBdy2DzMwg==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

When adding a new failure path from device_ctor, the missing
clean up paths in the current code were uncovered.

The device_del path doesn't work because it relies on initialisation
that hadn't been done yet.

This patch cleans up the failure paths and initialises the
things needed for the nvkm_device_del path to work.

Fixes: 0d5dd3f301bb ("drm/nouveau/lib: various tweaks")
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  | 13 ++++++++++---
 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c   |  4 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 +++++++++----
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index a2ed8c4fe52a..625bb019736a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -3152,10 +3152,19 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
 	unsigned chipset;
 
 	mutex_lock(&nv_devices_mutex);
+
+	/* Set up the state that nvkm_device_del() relies on before anything
+	 * that can fail, so that a device whose construction failed can be
+	 * cleaned up by the caller with nvkm_device_del().
+	 */
+	device->func = func;
+	INIT_LIST_HEAD(&device->head);
+	INIT_LIST_HEAD(&device->subdev);
+	nvkm_intr_ctor(device);
+
 	if (nvkm_device_find_locked(handle))
 		goto done;
 
-	device->func = func;
 	device->quirk = quirk;
 	device->dev = dev;
 	device->type = type;
@@ -3165,7 +3174,6 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
 	device->name = name;
 	list_add_tail(&device->head, &nv_devices);
 	device->debug = nvkm_dbgopt(device->dbgopt, "device");
-	INIT_LIST_HEAD(&device->subdev);
 
 	mmio_base = device->func->resource_addr(device, NVKM_BAR0_PRI);
 	mmio_size = device->func->resource_size(device, NVKM_BAR0_PRI);
@@ -3402,7 +3410,6 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
 		device->name = device->chip->name;
 
 	mutex_init(&device->mutex);
-	nvkm_intr_ctor(device);
 
 #define NVKM_LAYOUT_ONCE(type,data,ptr)                                                      \
 	if (device->chip->ptr.inst) {                                                        \
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
index 248623b91e29..269ccd4b482e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
@@ -1705,8 +1705,10 @@ nvkm_device_pci_new(struct pci_dev *pci_dev, const char *cfg, const char *dbg,
 				    PCI_FUNC(pci_dev->devfn), name,
 			       cfg, dbg, &pdev->device);
 
-	if (ret)
+	if (ret) {
+		nvkm_device_del(pdevice);
 		return ret;
+	}
 
 	/* Set DMA mask based on capabilities reported by the MMU subdev. */
 	if (pdev->device.mmu && !pdev->device.pci->agp.bridge)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 3c8d0878891a..eb4f43287796 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -332,15 +332,20 @@ nvkm_device_tegra_new(const struct nvkm_device_tegra_func *func,
 	ret = nvkm_device_ctor(&nvkm_device_tegra_func, NULL, &pdev->dev,
 			       NVKM_DEVICE_TEGRA, pdev->id, NULL,
 			       cfg, dbg, &tdev->device);
-	if (ret)
-		goto powerdown;
+	if (ret) {
+		struct nvkm_device *device = &tdev->device;
+
+		/* Cleans up the partially constructed device, including
+		 * powering it down and freeing tdev.
+		 */
+		nvkm_device_del(&device);
+		return ret;
+	}
 
 	*pdevice = &tdev->device;
 
 	return 0;
 
-powerdown:
-	nvkm_device_tegra_power_down(tdev);
 remove:
 	nvkm_device_tegra_remove_iommu(tdev);
 free:

-- 
2.56.1


