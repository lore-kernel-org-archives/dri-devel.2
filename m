Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974BDCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083D910F5BA;
	Fri, 19 Jun 2026 12:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="M3xoxvGa";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A3A10F5B7
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781872895; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VrMiZGKsXKiXGBk2XmK2TTkTc1PmozA5FdmK0DP1gFOm7QhcsGDFaADTYBNR3NujsiiU4tDXc11aZeKz5JSpjWo09av/3MKkfG3tV4/5r9hqMhlIlDpHaezOn3Kdl2XuUDxV4tshdoSvVVoKbs5HebF8odhpeSo9cCw6qyMFKes=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781872895;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=H5mTnjEpvL/5DY0Q0iZeisoUi65QdTvO/i3+wq0f0Os=; 
 b=GWD6dhDnDX96nOvtnIdAGA0MKQgFR7C3ESQ+9eEkY1kPgmWUTaMnK8B0NJN+1ushaamCz9b54e7eRqtDmfGZIlhbNFAPAaRsB9+/jzZ2jm2V+EDWaKLGt9OlPPIiVuqHgapPoi/Td/keanNKWnnjq6L02o3+LZoCcG4MRjHRVpE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781872895; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=H5mTnjEpvL/5DY0Q0iZeisoUi65QdTvO/i3+wq0f0Os=;
 b=M3xoxvGaVHzYFU6WRLeUHzvXAYPHME4u6G3YXdk/0iL97vahJLBjpY0FPKRPgAgw
 wbHl4V6cFdKMsN52gS4BgXLMNMjLN7y8FDe1q33XW172UIsfFAqAH5yh8hrrMkC5jn0
 BtkPGaEDj+TKvtsSi7fi8C/ZbDl/yCSmAXvcCHOA=
Received: by mx.zohomail.com with SMTPS id 17818728948204.441903092933785;
 Fri, 19 Jun 2026 05:41:34 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 19 Jun 2026 13:41:23 +0100
Subject: [PATCH v2 2/2] drm/panthor: Fix comment to reflect actual struct
 field name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260619-vm_bind_checks-v2-2-b51abab35f71@collabora.com>
References: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
In-Reply-To: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=qc02GIl3Bmp59VseY5L7qfuHIpLIhhZ744ftt7MlcK0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqNTj4lN3irs2xZrH833VYXfOJTJ/qwUuCAWbSW
 LO9ohyB8AOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajU4+AAKCRAOJn5M7lND
 Pb8qC/4ylQwkmE2QRr/SOGwWwQeqypCWj6FC08Gi/g1iaT4tiahcbicpVXDswu5xkkHvFI3q527
 KdnROU/hFqyJbuZ29z50ug8wn2YQc6FrnlVnEZpt9aPwGZyJu9eqG/EGOnYOTeziJQeVV1f15DL
 HBgTaWyCPfLLzUSjSMlzS1ukR7mtwoay0rQXVRzV+7x09rHHThssIRUjZvGZWtN+fuLnpsZKJ4/
 A5vDF+Nu1WImBhUsPVIm5TkLKO9jkRymHv78BQ3zhQWK7x0tiCyAPeQ02I8JFKpaG+7+NQ0HDaM
 5QwAK+KLgYak4mLJgbLftFBr6VLzsYrndK+KD8ciCC6KyLjy2kfg130BOQ5nKToQK0YkEQPwtFm
 OxJFomiPNittUD/+6jqHyjv5WjGlR9pjRwr0iuZ520yEaqfVPFddjz5HZn8SzlFkVEepSvcr0LI
 nKYErKdZEW6RGcrNt9p7x66u2Vze6/rn33XE7q3eLgBcihDulFOS9CjVXtgD7KxQxdMvY=
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
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index a8de4fe6b231..d8c6d8a9e26e 100644
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

