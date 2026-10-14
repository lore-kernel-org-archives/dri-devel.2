Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2B5CC6B2E
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FC810EB40;
	Wed, 14 Oct 2026 19:34:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6D710EABC;
 Wed, 14 Oct 2026 19:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792006485; x=1823542485;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jRy6fhr5/qPHbVNSM8z6G2SxyB2RcKBU8BHmpKnYKvY=;
 b=F8JvOQ5JlUuonSBKnbb/a892LytfAqUc+9YVJffBDg+/2gD4PxXrfmci
 tglvWDbiv5GIntNTamL8SzaAo5QnMoz/PaJw724dHm60TGKgRWx6T04ss
 L0HdUHHXhmwNA8+sFbp0VDJ0GO9afCXj9xIMMh+FKN9zYBhiRU6M3PloD
 pn/FasYnt82ZGRwFb4Y1kM67jMMCBdiiAvFOlQEaTAjV9+Y24s/NkUTnz
 BDXQJ16/qfu440WgutluFXFZc4youEOJXtxEB/OWC6ZzVWrJLkrQ9QUWc
 7yM+0MUMfuzxVMRFSzjYtgJpjtMW5Dj3Nl9x4qoDAU5Ez1Mc2luqw/Hje A==;
X-CSE-ConnectionGUID: HZ0tncRfS+KDhJX+8YbFpQ==
X-CSE-MsgGUID: dFCZigvhTO6b2g3TI+SNnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="653876"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="653876"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
X-CSE-ConnectionGUID: PFdSKz1BTZySZUxtt6RHOg==
X-CSE-MsgGUID: Gm8OJZebQuSTfr1N99BKLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3270521"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:34:29 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v4 10/12] drm/msm: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:34:30 -0700
Message-ID: <20261014193421.1705112-24-niranjana.vishwanathapura@intel.com>
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

Replace the open-coded self-import check with the drm core helper
drm_gem_prime_self_import(), which performs the same ops and device
match and returns the backing GEM object with a reference.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
---
 drivers/gpu/drm/msm/msm_gem_prime.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index beb7f22fd694..a96588ecefa1 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -65,17 +65,11 @@ static const struct dma_buf_ops msm_gem_prime_dmabuf_ops =  {
 struct drm_gem_object *msm_gem_prime_import(struct drm_device *dev,
 					    struct dma_buf *buf)
 {
-	if (buf->ops == &msm_gem_prime_dmabuf_ops) {
-		struct drm_gem_object *obj = buf->priv;
-		if (obj->dev == dev) {
-			/*
-			 * Importing dmabuf exported from our own gem increases
-			 * refcount on gem itself instead of f_count of dmabuf.
-			 */
-			drm_gem_object_get(obj);
-			return obj;
-		}
-	}
+	struct drm_gem_object *obj;
+
+	obj = drm_gem_prime_self_import(dev, buf, &msm_gem_prime_dmabuf_ops);
+	if (obj)
+		return obj;
 
 	return drm_gem_prime_import(dev, buf);
 }
-- 
2.43.0

