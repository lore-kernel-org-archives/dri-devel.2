Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B3606A89C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=ogdnuw2N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E87810F6CF;
	Tue, 17 Nov 2026 12:51:15 +0000 (UTC)
Received: from smtpout9.mo539.mail-out.ovh.net
 (smtpout9.mo539.mail-out.ovh.net [51.210.91.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9867910F6A0;
 Tue, 17 Nov 2026 12:50:42 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4jTPjD3s07z4FXB;
 Tue, 17 Nov 2026 12:50:40 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Felix.Kuehling@amd.com>; Tue, 17 Nov 2026 12:50:40 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.178.193])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jTPjD2pnZz6Np1; Tue, 17 Nov 2026 12:50:40 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.7])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 213CD8E2103; 
 Tue, 17 Nov 2026 12:50:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002a03d8498-8a40-4814-af3a-84de42314a4d,
 00F4D7524EDFA56606BD67631AE7EA1B984E627F) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 141.95.41.139
From: Natalie Vock <nat@pixelcluster.dev>
Date: Tue, 17 Nov 2026 13:50:13 +0100
Subject: [PATCH v2 07/10] drm/amdgpu: Move some VA op validation to a
 helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-prt-explicit-sync-v2-7-bb3851cb6a0c@pixelcluster.dev>
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
In-Reply-To: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 5593470738269430076
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEPp6kNSyGSbEjWxKrIgE1HssE+3YWZIUhb0XfRH2ewIPGMkqkq/N2arh5Ba2XQsoi5FO2Dp4CMwNqhcRsTtuuHue0hCp28BUZ4zJ0TqA57zUUyVbO0l7bBL43CJzAIIiAdv5WA84KBykzFjrXE9SPeQ5+S4cmEF2gKTTKn1oxx7Kf9gnyPe0T9+82xgDFF54JYIi0QQZjaI+/YPtY6DZgfbmjXFeixY/dF87toiQQzApraltAeXn4revVJN7ti2427AgG+MVSn2Ix/8L5aquqKupx+z+OMtyTtbCjBr4A89cDBu5en4fxgT9SGL5y7nFflGbAMkJkPxL/2tHp1cNsLTicZbOiyWxmORvMszdaUOT4jSpg93N1l/IPj9dLZkrijJA88tGX4KkbY/owV6PRu5sfD5pS6F0fqtl2X3ekVYIO+LNkG1nSbrc8R647E2XrkhAf4n3HncsbcR4lI9OKFY0WRrn0+QQlWZVa97nlOjRLKEHZl3vvb8xKAy8BfCRo7BS7gqpILctLfc3V147w9sq3FkAnNlIItEK7uKDV99peGDF4A2LY/UOZmByrjomiOPXR/2R/67sHB/+ZTongANCGjTgdeTZhnpxLo301K28gwlnIF1PvaPCfA7PtqVGyLmTx1HNKUqodCMvm7twihItThb7oqZmnNR87E8MK3ig
DKIM-Signature: a=rsa-sha256; bh=dyNaVn7Mal9uVVR5LI5qqXyuhz5cOYFS0M4l+grg88Y=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1794919841; v=1;
 b=ogdnuw2NjF1keGROIVn6s6v1e+FwkcJ5DWbIMUS9NW6/jTfp5cR6BKZ3ISDuF88+p/IU2Uq9
 rYwYjhV5wnin1RK6EDp22TjjjdDcahNCj4l6z6angD0B4KhaEB/SpWLAIi86b4dmQW7FwjYqN/G
 tiZz13rCccc7M2B6ehitOMo7y6rRIfkuRkBLrBzIU9tBeY6hcg7BghtVHEuzRlsO+mb8L/Mg2nG
 O53P+j623b5OFFBH1MUcTO4bpXt0E+eBGzsRI85tKFZGHA4MLJlZJd+1KNRyafXeuCVsXMSsyqs
 yTpZ8gQyhE1+GVzrz/RigNeDDWE1gtYFeLqIR6VZy875A==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To be reused in a new VA ioctl in a subsequent patch.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 71 +++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 39c72bfb73e71..fb7abb095b8ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -878,9 +878,11 @@ amdgpu_gem_va_update_vm(struct amdgpu_vm_update_ctx *ctx,
 	return fence;
 }
 
-int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
-			  struct drm_file *filp)
+static int amdgpu_gem_va_validate_args(struct amdgpu_device *adev, uint64_t va,
+				       uint64_t size, uint32_t flags)
 {
+	uint64_t vm_size, map_end;
+
 	const uint32_t valid_flags = AMDGPU_VM_DELAY_UPDATE |
 		AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
 		AMDGPU_VM_PAGE_EXECUTABLE | AMDGPU_VM_MTYPE_MASK |
@@ -888,53 +890,60 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	const uint32_t prt_flags = AMDGPU_VM_DELAY_UPDATE |
 		AMDGPU_VM_PAGE_PRT;
 
-	struct drm_amdgpu_gem_va *args = data;
-	struct drm_gem_object *gobj;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_bo *abo;
-	struct amdgpu_bo_va *bo_va;
-	struct drm_syncobj *timeline_syncobj = NULL;
-	struct dma_fence_chain *timeline_chain = NULL;
-	struct amdgpu_vm_update_ctx update_ctx;
-	struct drm_exec exec;
-	uint64_t vm_size, tmp;
-	int r = 0;
-
-	/* Validate virtual address range against reserved regions. */
-	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
-		dev_dbg(dev->dev,
+	if (va < AMDGPU_VA_RESERVED_BOTTOM) {
+		dev_dbg(adev_to_drm(adev)->dev,
 			"va_address 0x%llx is in reserved area 0x%llx\n",
-			args->va_address, AMDGPU_VA_RESERVED_BOTTOM);
+			va, AMDGPU_VA_RESERVED_BOTTOM);
 		return -EINVAL;
 	}
 
-	if (args->va_address >= AMDGPU_GMC_HOLE_START &&
-	    args->va_address < AMDGPU_GMC_HOLE_END) {
-		dev_dbg(dev->dev,
+	if (va >= AMDGPU_GMC_HOLE_START && va < AMDGPU_GMC_HOLE_END) {
+		dev_dbg(adev_to_drm(adev)->dev,
 			"va_address 0x%llx is in VA hole 0x%llx-0x%llx\n",
-			args->va_address, AMDGPU_GMC_HOLE_START,
+			va, AMDGPU_GMC_HOLE_START,
 			AMDGPU_GMC_HOLE_END);
 		return -EINVAL;
 	}
 
-	args->va_address &= AMDGPU_GMC_HOLE_MASK;
-
 	vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 	vm_size -= AMDGPU_VA_RESERVED_TOP;
-	if (check_add_overflow(args->va_address, args->map_size, &tmp) || tmp > vm_size) {
-		dev_dbg(dev->dev,
+	if (check_add_overflow(va & AMDGPU_GMC_HOLE_MASK, size, &map_end) || map_end > vm_size) {
+		dev_dbg(adev_to_drm(adev)->dev,
 			"va_address 0x%llx is in top reserved area 0x%llx\n",
-			args->va_address + args->map_size, vm_size);
+			va + size, vm_size);
 		return -EINVAL;
 	}
 
-	if ((args->flags & ~valid_flags) && (args->flags & ~prt_flags)) {
-		dev_dbg(dev->dev, "invalid flags combination 0x%08X\n",
-			args->flags);
+	if ((flags & ~valid_flags) && (flags & ~prt_flags)) {
+		dev_dbg(adev_to_drm(adev)->dev, "invalid flags combination 0x%08X\n",
+			flags);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
+			  struct drm_file *filp)
+{
+	struct drm_amdgpu_gem_va *args = data;
+	struct drm_gem_object *gobj;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_bo *abo;
+	struct amdgpu_bo_va *bo_va;
+	struct drm_syncobj *timeline_syncobj = NULL;
+	struct dma_fence_chain *timeline_chain = NULL;
+	struct amdgpu_vm_update_ctx update_ctx;
+	struct drm_exec exec;
+	int r = 0;
+
+	r = amdgpu_gem_va_validate_args(adev, args->va_address, args->map_size, args->flags);
+	if (r)
+		return r;
+
+	args->va_address &= AMDGPU_GMC_HOLE_MASK;
+
 	/* Validate operation type. */
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:

-- 
2.56.1

