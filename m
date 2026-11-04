Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56273606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=KEWKw7Ed
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6C010F064;
	Wed,  4 Nov 2026 08:58:35 +0000 (UTC)
X-Greylist: delayed 445 seconds by postgrey-1.36 at gabe;
 Wed, 04 Nov 2026 02:55:54 UTC
Received: from 19.mo561.mail-out.ovh.net (19.mo561.mail-out.ovh.net
 [178.32.98.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E3F10F97D
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:55:54 +0000 (UTC)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.231.96])
 by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4jK8yM3plpz5w7g
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:48:27 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-jz7gr (unknown [10.108.42.75])
 by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C5C9DC1523;
 Wed,  4 Nov 2026 02:48:26 +0000 (UTC)
Received: from medichon.fr ([37.59.142.108])
 by ghost-submission-7ccd8bbbb6-jz7gr with ESMTPSA
 id PN3GJPqc6mr/PiYAgOqjLQ
 (envelope-from <abo@medichon.fr>); Wed, 04 Nov 2026 02:48:26 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S00247644e1e-4f71-4c44-956a-a2de4972a974,
 477B2B87E0FA57B148EB530668B90EB0C3478676) smtp.auth=abo@medichon.fr
X-OVh-ClientIp: 88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH] drm/amdgpu: add missing parameter documentation in
 amdgpu_ttm_map_buffer
Date: Wed,  4 Nov 2026 03:47:54 +0100
Message-ID: <20261104024754.166260-1-abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11311634892579298910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEZRCGDjRiIwozqePrIKNfp/DaGmSOhFHm8U6mbmnzcJtMp1uK6Q9RQ6SbzIoDy2BK3V9OqbO2BHan8A7VFlk4YjaKERPB4HICkMvPSXaGrhmb5CAlkAd16RC10x18ilj2AbPr43PJPWPdiZd1Zm9fpf+Kx5BTHRFFfv3kakSkrYvf2T1c64KiAU6cBjtS0VQ7D6jyZ+k/azsjOh6XMHDDgbrC/4RXHKAJ42+mvpEHL8NVNXDsimtgG2DOz+xJtH9u0HHpT4/3tnMq/OskS4O1g1uXTf1f/SJz0vz6fRJgdf6FxaDlg7iGbtG5PE4dxstXmL7nsQcDf5YCrRgZZnHvQWsaZqTTZ5wizRVoxWHt0zZ9A/8qoy5O0znTAve+Tg6af+9rJ+DgyO5XQtFLRckTIOCP8CEaKXKR+M1CMUvrgXFR74jK8DSwv8xO2C+dIMYwrcwPRdacKNJ4cSvTb98KCLf9/IIN818Ij9o241bxslCCdbKW2ZhWCQEXP4tkY1zbZnY1Lijc+cxlNonPAqmqhdJPaLbQZwabTDPOrIx8fJewKqY0cCscvEPGMiJ5cjWV6UZee3x6s6UB+7no9/iJRXqTkx2eEJm9XWxp87KjZXNkj7nyrUHx+ozB6r/MZQ3431J9Vl4jNredlDkCuXs18COxgPOa9MWIAq9VV2pqchg
DKIM-Signature: a=rsa-sha256; bh=mR5v4li+ptnrKvy6BsEfurDx9PVueMJjS5SmYvSe2WQ=; 
 c=relaxed/relaxed; d=medichon.fr; h=From;
 s=ovhmo3801317-selector1; t=1793760507; v=1;
 b=KEWKw7EdzUNJ1AXmQq9lFx8n35cqeCATvwV6i0Izkr3Vzrk9N8HzdnjEwkTovdHtxH0JnB7o
 W8cV6FFg33HBRCga5h7VvnOvVi6PRWDSwT6VrZ7kDiu6Mv4+ZfMytgL4Uextg9pOOArHGfKe1CO
 LuHvHllIzzWcrzZeHEFy3P262hg6GPyUhzrkE/OgcU+ulciTc1vQh3XshwsO5zVIIs0lhnKsz95
 ZLo0tXBCu4jQ906CZJ14Xc6QaVhe9lhn6q3WbOJjBQ/mYbmk6T5Gggqt5LtxYY+6nLKOPLEIZ3B
 WSUPhAUSe6+13oei10P6nbgCZQnvTSeuQqneHaXmpZ1Fg==
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 48c4aaeef621 ("drm/amdgpu/ttm: Make buffer copy source readonly")
introduces a new parameter @readonly in function amdgpu_ttm_map_buffer()
but doesn't update the documentation, leading to the following warning:

  Warning: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:209 function
  parameter 'readonly' not described in 'amdgpu_ttm_map_buffer'

Add the missing description to the kernel doc comments for the readonly
parameter.

Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f86777250fc..d3a875a32af1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -195,6 +195,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
  * @addr: resulting address inside the MC address space
  * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
  *		    needed) or false for a direct address
+ * @readonly: true if the mapping should be created with non-writeable pages
  *
  * Setup one of the GART windows to access a specific piece of memory or return
  * the physical address for local memory.
-- 
2.53.0

