Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F69C44500
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 04:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4754310E010;
	Sat,  4 Jul 2026 04:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Tz5Z+gxi";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F309F10E010
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 04:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783140430; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kygQY1sDUi5fiTkTk6izdD55BSRCeK48TIHLNcfkVQlZRdqIxKvat3q2iYxzvLfcE1Jjzal24G4aAN0AOBTkzJRHHZFSDVT4V1H2iK7bA6q63b1YONW9LF2ohGF+TCxS2IGS1n2tp9SybP4NZ2vT3ztExsmTLo3A4NCgmTxOf5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783140430;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=d7Uoszei4pTN9ZOkwH6lS2xFnNjQ59ehaoL78C+4sbw=; 
 b=cwilCiAPg8HDLLS9SoirTulkSP1vB4B6nCjKoZVpKsXlhEe3goLRHuAOGMPGAQuGZBjzowu0E3V0kQwnSxbXJlyg0Tlm2QFetDxmuLjGmohkvRhDtlL0j3TSL0vk4UJNUTToQ+Ez/5aYT6/3ftof/q63f8bdQP9qcRZN7/P46bo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783140430; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=d7Uoszei4pTN9ZOkwH6lS2xFnNjQ59ehaoL78C+4sbw=;
 b=Tz5Z+gxijPYkZC4613SS058mGFQqLjaZ36PoH8buqXaleMpq3+wOIbyvLa/oDbE7
 0WH6/Efcug6yFAxSOE6kJ5gOn5sfPCUIOCfxl1VKU9VyK6HZA5FlNxo+D2QZLztp+Uu
 iowkvO6nIM0N8ZvPRKZM22bnyQGgjVz7jwzxiKss=
Received: by mx.zohomail.com with SMTPS id 1783140428753558.4435604538163;
 Fri, 3 Jul 2026 21:47:08 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 04 Jul 2026 05:46:45 +0100
Subject: [PATCH v4 2/3] drm/panthor: Add vm_bind region with kbo range
 overlap check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260704-vm_bind_checks-v4-2-4705b6ca9f8a@collabora.com>
References: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
In-Reply-To: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ypPVXz2RCkHxWoVbJvN5vLdACt1FEloFP3UeHGt0zpc=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqSJA/3tL0Z54sp0KF0CAaVUZ/blifz381hMEo3
 LSif9YA1ECJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakiQPwAKCRAOJn5M7lND
 Pb5uC/9n9WrwCGZwDU8YhKxgxeGTGIMRIqgRcuEnbJC75y1yaORS9Rlp4uWpFQc1KCmHZvAnDy7
 9vje+MaDpK/yrqLfw1jIPYs2jaFLVkX5LuS/2yBEhUOPRMErP8O931Jv02AcF94QtfCPRUMKPSD
 aC40zw5gPsmVnxh8JZU2SgtxCf8ih0yytsYXEUEt+hov1R172LVrPO7ISdi1Vkp+GJoUxYps4cp
 FbNmtmzR1H/gf0dAJv3/xOv6lzOqOUPQvz3v7Ka+arbqWQNWIxowA9uCP6gf819UuL6pV6JEOep
 Wgocjp/HDvH+OVwPl3xgoulHpan/c2/f9ETUi81JLE7gGSmZHufKkw7yCAvXPp4NHaVvjs/tT0B
 gxSZZxP+6Gwu6jVoUVeP9o9sFbu8N7p1QBeVcPQDCZUuH/8nO5N7XJUHJU+FLpXrU/N+F1eQ/e1
 LvbSUxTQKnkhefCQXnDybw8+jF+9Gvc8WNQntmcEbWkoAoqBjM6Gt64CB2+NhtwULEAgw=
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

When a VM is created, caller has to specify the range of the address space
carve-out set aside for mapping kernel BO's. That means vm_bind mappings of
UM-exposed BO's should not intersect with that region, but at the moment
we're not checking this.

At first, I thought of giving these values to drm_gpuvm_init() through its
reserve_{offset, range} arguments, but it turns out that is meant for VM
address spans that are not managed through the usual drm_gpuvm split/merge
circuit, so storing the end of the user VA range at VM creation time and
doing a quick check in the vm_bind ioctl path was the simplest workaround.

Fixes: tag and reference the relevant sparse binding support commit.
Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 163231c1703d..662a2c13b467 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -310,6 +310,9 @@ struct panthor_vm {
 		u64 end;
 	} kernel_auto_va;
 
+	/** @user_va_range: Upper boundary of VAs VM users can map objects against. */
+	u64 user_va_range;
+
 	/** @as: Address space related fields. */
 	struct {
 		/**
@@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		va_range = full_va_range;
 	}
 
+	vm->user_va_range = kernel_va_start;
+
 	mutex_init(&vm->mm_lock);
 	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
 	vm->kernel_auto_va.start = auto_kernel_va_start;
@@ -2985,6 +2990,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 	if (check_add_overflow(op->va, op->size, &end))
 		return -EINVAL;
 
+	/* We don't allow mappings that overlap with kbo's reserved range */
+	if (end > vm->user_va_range)
+		return -EINVAL;
+
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
 		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

-- 
2.55.0

