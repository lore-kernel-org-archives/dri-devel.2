Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D66C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8274910E9A9;
	Mon, 20 Jul 2026 15:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="F21h8Ntf";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7D410E9A9
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784562537; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VAPaz9plnQ71Y1rYTRJdmsl1nfVH6gEg+gDewwwx+0aKLuOJug9ASBaPBNOjTyl9hya917UREBjlSkyq5noTmqwOITsGGUbiA9HvrB4qrqgbnMc8X4UXbvvQqtpb3A0c8lWckN5HeBDYZ1oxEpoML8q/yTjL7lMspoLYmi8RVck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784562537;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aeq4nmM+JxGlAsti9NDM21PDtdCz75OwddqUytSgKEg=; 
 b=FhTuDDOyBmdaLWQJjxuVeGkKU3/260u9EM6087i36Z5TCsGeRvlQvO2quxtpgvOXKG84IGGUAJFtX9ThMCk7r4tyGrrFhdozgbhzcsXIpruKXn65K7sbCek+aKzwz+PUCfCmvUqaDtaa3OtZTC2msJFAaNrtaeLLgpwN9XBHX90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784562537; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=aeq4nmM+JxGlAsti9NDM21PDtdCz75OwddqUytSgKEg=;
 b=F21h8Ntf4atnh/wXGUPfeFIUcLeCaqGajunl5AJcZzatSJcV9AFdrXatAAx7ItOS
 MC70lhRi18sK48GDAu2S5aNevr4eXANMWuxWh/a+7yLPl7jLEx0gP/miMeCcWFIYqYv
 IqcmrX4S3scWcf/SimYMQFSXOSIQCWadYcpQOSOg=
Received: by mx.zohomail.com with SMTPS id 1784562535254486.0950739146084;
 Mon, 20 Jul 2026 08:48:55 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 20 Jul 2026 16:48:42 +0100
Subject: [PATCH v6 2/2] drm/panthor: Fix comment to reflect actual struct
 field name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-vm_bind_checks-v6-2-c2c7dbe93a73@collabora.com>
References: <20260720-vm_bind_checks-v6-0-c2c7dbe93a73@collabora.com>
In-Reply-To: <20260720-vm_bind_checks-v6-0-c2c7dbe93a73@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=I7bcJBWiyRWmDq9ENsy+r1iT6w27qhchjEkWP+LUsIY=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqXkNZFdooQDy+gPYYKgtf8D102kJ7YLu9PBMae
 zCdzcIL+S6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCal5DWQAKCRAOJn5M7lND
 PebHC/9VW33jbDY5XKQCuRB+uGPr7OGJ99361JnmtSKC+3S4pbG3qOwMSsIEDzD1CJX87Uieig2
 WIhI4NkrCjbx2uqCfwXfwsxGuRbw014ZbHHKFJns2VfJWMxxb5ngoUjb5Nay2iA03NYZNylVl8c
 vX5NEArJbhqNSWds1HcBfYOfYEuaUjL/GHRud1D8G/5MbZBJEa5CtD4YGgMy0JBDahTTq5KqyB2
 RZAzIQhbHdTcEtp+r3inAI28nkelFr/ZZhxYJCJc2fJ5FiBIMyWE9erJneVwk5+jBg0au2Vahrc
 CBUk3Xd8tdFJPNt9zM0tpujCGAPxRErPqnYCW09ijDsZY1mOn96OI8xVz9O+e+ovuFvuJTV4J0r
 Ycm+cRAO/frroDnSKgL+IIVSySlAwgqsV0zwzejnO16P2W6LvwiIfY5CnDbx1bAMN5swnT70kjY
 PNC2N66clzMH3nTaeVJPs/d1dRWQjaDBbJ585oDqIsKO+OteUY2QlQXAjVdzIaYy07d1M=
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
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 80a1dac40a6a..0182b72f1932 100644
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

