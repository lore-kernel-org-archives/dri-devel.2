Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C0CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506E310F11F;
	Wed, 29 Apr 2026 18:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="JAjJ3VFk";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FDF10F11C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 18:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777487593; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b6Afx1RoUZjM0HdtpKY8ZAwnxt2w4ohYe6ro8wxNUwyP4cUhmJLkH+rvg2rQBILJrNmzDDrmK1gMEBHf75O6O/YBzgm5OxpHdzN581doUpSRVpePI2+pg0xbXcLF50SCnEjSHKTkhC+Oxc7ehEL56yzylp3cyWpjDMgC4C/+/vs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777487593;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=do/tIM3Ojb1Vv1appOYmHiLTKOw9/ngQpz7qtd/LP/Q=; 
 b=VHE1Rdd36UtQTdbTN9XPIWSCVixgNcpxSvz3YkhTs3J36MJ76YEvNE0qK8sS3g8TmZcR35xoveBd/DdJOrVGo3PCjNOvCECd44PYIl+0Pz+QSJMdBavCAejLM1qgA3ZwOvnfhkF9TIA58ZHHKcZ7BTFJFwG8/8UbbZpEUnibAQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777487593; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=do/tIM3Ojb1Vv1appOYmHiLTKOw9/ngQpz7qtd/LP/Q=;
 b=JAjJ3VFkcXmxZtM2c2L3wcFh1xQ8gnzZV4lXc4snrxt7bxysHn4IB3J217P1JnLI
 XdgdidY7bB8s2u8nYfRF/lVi+7pCXqTQ8o43HeJWKEoM2yU0AysRJXydSRZnoHEYWkz
 lsnE3x99XsUAKIbZ/Mekblb62eNRG+Wm+X6gqBQI=
Received: by mx.zohomail.com with SMTPS id 1777487592130183.52737405411426;
 Wed, 29 Apr 2026 11:33:12 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v10 3/6] drm/panthor: Delete spurious whitespace from uAPI
 header
Date: Wed, 29 Apr 2026 19:32:15 +0100
Message-ID: <20260429183253.66422-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429183253.66422-1-adrian.larumbe@collabora.com>
References: <20260429183253.66422-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There's no extra blank line after the last member of any other uAPI
structures, so delete it.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 include/uapi/drm/panthor_drm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index b462752c793d..14a93a4ef6ff 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -677,7 +677,6 @@ struct drm_panthor_vm_bind_op {
 	 * This array shall not be empty for sync-only operations.
 	 */
 	struct drm_panthor_obj_array syncs;
-
 };
 
 /**
-- 
2.53.0

