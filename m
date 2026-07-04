Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41CDC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 04:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0536210E2A2;
	Sat,  4 Jul 2026 04:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="X/H82+cQ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DDF10E01F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 04:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783140434; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EdGzKhApR6A73AwkcsG1Z9phjZDh6HjvZ1QqZr6vRFmfiyKGfjKjDY40vcdh1QD0+F1CpIYEGBTWBPNSpbKQ8OFWbzumIo9mnuJDLENqCisaWVUey67F/c1SA7Py3MHjKisHjY31BTJ3WdHQQni6YlDQuqXR4SmseLb6rLtyPTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783140434;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zA5sMr+drQYO05Evq8OX1erpzKd5oFkvLzQFTvOsMIQ=; 
 b=Vrh5wQk/F6zWk7VUrqlmxeWdd23/pCfJD1Axg1UKB7rsrwm1AB64Cq6wGSvFZxLXPJp1QtvJal9wBwTdDz3+jcmhVzon2JJlae6stPbDXZyqy4GTx2zphh8vwN2nbzdj8PT8KyPdrZGpIk2wn/9Kq2NU+DsbwI9Y17m5qg3pbD4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783140434; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=zA5sMr+drQYO05Evq8OX1erpzKd5oFkvLzQFTvOsMIQ=;
 b=X/H82+cQM0xXehKXofg3BboqbQIuFCSUTg28nBWcIG3GtQUz1L7zLdqWIgJecEyU
 OEUKT97FjuCtTWr97lKh0jvbW98tcwGI1U02iyfpxwpl46/hkQsTiDaFXyrYNG5KMWN
 3K0shKCp8yJNSA2/ZD6Wcw39fBxHUezA8RPfW+4o=
Received: by mx.zohomail.com with SMTPS id 1783140432981206.22377307476734;
 Fri, 3 Jul 2026 21:47:12 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 04 Jul 2026 05:46:46 +0100
Subject: [PATCH v4 3/3] drm/panthor: Fix comment to reflect actual struct
 field name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260704-vm_bind_checks-v4-3-4705b6ca9f8a@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=915;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=6fQqTcZ8Jjzb2Ir40w+9CswzswOOUI9RFdQMwQAEnFw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqSJA/TeHQROl98MBJeT8rfSN0EiWl8fHL5xEat
 4GQCUWk41aJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakiQPwAKCRAOJn5M7lND
 PanKDACGBB6uyzGCryUlNWTJNET6L//HexH1dDjIvDP85O9ojjs5ptQySWc3DuAs2CM0m4FbQt4
 xKBnSGulE5f20vYUqY2/GfeCE8UaE4ntGLK+7GoDlELql0Nd0vosK9ywztBXhHEbmRydKCsfJGD
 ZLHIniCihBVfU/wErRGLz10S4zd2audIDeGlQv95LSzqJP12oczBpHiHtpdQW/jGHb4oJEMEpYS
 wxq9VIog6fNpu2NSrFQCOhec1rrK4X8YjYZOVeDh38zV15IQgKf32700dOkXD884sXinvAIciv5
 bbMGx19ZFBETWSgLx6m2Jz0pZgxCWTAj81HcLkoVTLpSb+LONusZEvQgyFDJNDCDBn23e3n+h39
 T5lrXwB/i7m/sxFhH7SP0zTu1efpHQc3ddG3j5WQVEzibpBeEe2BXT4zE1YQP4464P9nNaHEyGz
 dxjuhvCc0+1H3hWaHkM0tWu/YwyWx9TXJ1Ninnyo26sR/u3NP49YA1YwotRN2fma4SUKI=
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

The mismatch would pop up when building the kernel with W=1.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 662a2c13b467..d09d5641e6c0 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -306,7 +306,7 @@ struct panthor_vm {
 		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel BOs. */
 		u64 start;
 
-		/** @kernel_auto_va.size: Size of the automatic VA-range for kernel BOs. */
+		/** @kernel_auto_va.end: End of the automatic VA-range for kernel BOs. */
 		u64 end;
 	} kernel_auto_va;
 

-- 
2.55.0

