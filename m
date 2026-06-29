Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FABAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A056310EA0E;
	Mon, 29 Jun 2026 20:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="W21jz/Aq";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C14610E113
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 20:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782764241; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Dbmg9soEgXJerxnVrbdHC2CP2x4lZ28/IDyg+WuwAaq1/rRaW5uTr6JVZnbJ8npKQaDDLk80uy4t1sp2aqJu+jfuNzFxM3+m3IdxYuJfEiNfjpZ8ctOY90FdzxiPOgqUWDEsOS65juKHdIO5FzbQGfI32d5inq23/YbJpf1Bkhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782764241;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RdHcF+/CjCvjfPRWnQ3YqdlxcyefNwa3h+i7ttXas40=; 
 b=m3eZQ2EmzpK82f1j/wZ1343kPwHfI9ppEjGtI9lUPGDz5qboOpKQ8m55gfk5q4+ClnYdW4kXVdnFoj417PjbEcbMV6hE50JoBKYtJn/wl5wsbhkBBgGwMEH3n4ku7/fpJ1z0y0/2X6g+HsdF8GFtCdMXoZ2uaFDTKyiA46W4kSE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782764241; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=RdHcF+/CjCvjfPRWnQ3YqdlxcyefNwa3h+i7ttXas40=;
 b=W21jz/Aq9s8uhW+B+OJykcJhvFmkmbJos+IT8NZ0bOZ8WW9JzfFHxzZbEdEJv274
 AhJsWBiG40nkFa3a21wHxrLxugnbcoTuvM0Jc4FsojP29lJqBA3e9xL9JH5Znlhtcid
 Bg3bym74Mh42VYC4f0ReyEeqVtb7/v86VFXct2A4=
Received: by mx.zohomail.com with SMTPS id 1782764239423434.51717584608707;
 Mon, 29 Jun 2026 13:17:19 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 29 Jun 2026 21:17:06 +0100
Subject: [PATCH v3 2/4] drm/panthor: Fix comment to reflect actual struct
 field name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-vm_bind_checks-v3-2-85e6740f6c2e@collabora.com>
References: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
In-Reply-To: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
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
 bh=UveEWq0q5ntCLIRkUUw1CIpeNAz/amjIO+TXK2ewkVE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqQtLDqtG+f/A2L08vyYtDlft4zsP7Ve0IGO0QZ
 pkR0HVZakWJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakLSwwAKCRAOJn5M7lND
 PRVRDACuhOVPJw/fzJnFvNt5tlttEbYRicqzYDOv24tMPtJ49roXGN9Md6KFw6g9ElW7WKIfvrU
 bQl48M8llKM88SMdMYoNsm7GGed3tbDyYcVndZ7aJP8Y4iki8SNfoPdfvcrPpDt8E6LWtEnVgOf
 oy5RDpT6z9Xre98votGYvrgchVMpdOvVEpT0vMHXHuFjM45z6CkCq++QrKtldPMl295O9eCxS3x
 FMfvuP8mujXt3ov21WP7x+TiB5M969AQrN0pFafDp+QIZ38dHJIlalWH7V4/W0AyNmJDjgvEnMQ
 jfqAZsd75jh8Qb5/7xzksgFTRWueEx5UrFtytoEFA1w8ecK7L1+xzC32longZsJtwvNVem77oOM
 x5kKB5DylUBiLC48Jz0mxNsiPysjXJwyI6vLpjW5Y98ydkn4VabhNEVLF8SZ4K/Q+OZWdJDsR/3
 r7K59+AOiNTLd0Cq9+7+bH+2x4nkRWtqTFFME6GbknfK2sUUPycnTiNMoYLP+Q59eFdF0=
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
index 94789777aac4..48aa23573cd6 100644
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
2.54.0

