Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9668CC6B2C
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC9C10EAEA;
	Wed, 14 Oct 2026 19:34:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B7010EABC;
 Wed, 14 Oct 2026 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006479; x=1823542479;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZIU/l/iiujDSih6o3G3NmkCdEy9SjZ1BV4GOBQj+aeE=;
 b=UZiqcs2SGaLByDyXtjpl7EpG/dpMo2Kr79PVMhEUfaeuSXY7W+OI8ETa
 VKswhi3TeRjUo1unk/jWEIgAhMgMEX+JpcPpfln9NTylaLa3FavfyjfcH
 HkHAiJ5gwP1VJ7Ocfa19oyyJaI4eUiME87WIoRWb2qkeCpLw+laiDZfnY
 JavzbjNIrL3cs3qpw0V1XXDdeizNa+QZVbLJOAI9hHD9WI3ErY/amtjX9
 XAzDOCke+8170jIhlLLmzRDBFzPhdUdYK299oci/Tw5NSMErPEKZ06Vwx
 nXCy6PTN2/FAzduMmuGY5co3T+wYOTIa+mpVIIKH4K7c081Qe7pduhJfN Q==;
X-CSE-ConnectionGUID: mPeqo+vuSDKXJIjmVQJzig==
X-CSE-MsgGUID: QIEEADAvQUuge7j7jDLIKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653868"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653868"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
X-CSE-ConnectionGUID: xfgELstuSjaPtB6rt5Mg9g==
X-CSE-MsgGUID: 7SodECQQSZGlFrkYPikBuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270505"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 06/12] drm/amdgpu: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:34:26 -0700
Message-ID: <20261014193421.1705112-20-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014193421.1705112-14-niranjana.vishwanathapura@intel.com>
References: <20261014193421.1705112-14-niranjana.vishwanathapura@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Replace the open-coded self-import check with the drm core
helper drm_gem_prime_self_import(), which performs the same ops and
device match and returns the backing GEM object with a reference.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..5863f6605308 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -549,17 +549,9 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
 
-	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
-		obj = dma_buf->priv;
-		if (obj->dev == dev) {
-			/*
-			 * Importing dmabuf exported from out own gem increases
-			 * refcount on gem itself instead of f_count of dmabuf.
-			 */
-			drm_gem_object_get(obj);
-			return obj;
-		}
-	}
+	obj = drm_gem_prime_self_import(dev, dma_buf, &amdgpu_dmabuf_ops);
+	if (obj)
+		return obj;
 
 	obj = amdgpu_dma_buf_create_obj(dev, dma_buf);
 	if (IS_ERR(obj))
-- 
2.43.0

