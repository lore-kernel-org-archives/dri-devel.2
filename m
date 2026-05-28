Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500F8CD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8014210EC57;
	Thu, 28 May 2026 05:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dmtpMgoJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A8710EC56
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:50:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 578714178A;
 Thu, 28 May 2026 05:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925E51F00A3A;
 Thu, 28 May 2026 05:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779947409;
 bh=COvVma4JFJ+56Zie/gSdTfo95yDA+o3mrxVBEGDPQ9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dmtpMgoJt4fN8WPBqDYQ6RsBJ7iDJ1oOH35ERNZeL4/t5Dih7b3QF8KdB2FTJscHI
 /SPPkKrswpKpkGw1exf3aMtZ475M58CzFVg+XMVMMaPdr1SEAEWLXHjEizf+3oQUOI
 nzu9OScQIEQlDyzZmnF7oEsbvZxc7keYxn7wrxotdt9Rcb2OH9hoWXMGywZiGklLh+
 kK48wLqYmUs6yRC8ZFtG9FD7mNQ2IbxYyjv9Lw5GeX8bMDcHiRiampARBrOMV34AhI
 z+QZAQr/JqXXzEgyctYKYDtxv/VFU2ZO/P/lDUgkqwyfeVcYtXyUVocJsSCcn2jvSY
 2GxUbJW/tPAnA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v4 6/9] drm/amd: Indicate driver supports luminance
Date: Thu, 28 May 2026 00:49:08 -0500
Message-ID: <20260528054911.1513208-7-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528054911.1513208-1-superm1@kernel.org>
References: <20260528054911.1513208-1-superm1@kernel.org>
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

This will allow the connector to show luminance information for
eDP panels.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 988ee3bbfce7..e9ec5f9ad118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3072,6 +3072,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	    DRIVER_ATOMIC |
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ |
+	    DRIVER_CONNECTOR_LUMINANCE |
 	    DRIVER_SYNCOBJ_TIMELINE,
 	.open = amdgpu_driver_open_kms,
 	.postclose = amdgpu_driver_postclose_kms,
-- 
2.54.0

