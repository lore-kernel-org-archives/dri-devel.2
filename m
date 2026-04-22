Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816F7F9EDC0
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC06210E9C6;
	Wed, 22 Apr 2026 12:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Fxmoci3O";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B1A10E2A8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776860762; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gI7HQVwGoLfsRoLcSvjsYG4n2Ps7pn7WpIBXgsZSK4xbl1QNZ72YSmQcagOXEaAXYHWIKjyrGTDpK9W1WVgl0va4SdFul9NaPFLua6kQgkzNQn9DKpteaPR0idAJA6PX4QZGB/dTUFT1JCS28EQgQgxY8QQxEyq2q5x52I7YCVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776860762;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wXWh4JTjO3XSS1HUIBp2EkkcOxlikol+FrLwQoFSZd4=; 
 b=XPqwHuFg3zCniGTWLwfkHQ93nKMbdTjuWHjD7PBypjURs5T8j98ZFZWmB+D/FfUYtyL9XK1e3StDoRrHngO69qp4M1YxqLIn91VEWYK5hPfVrTiiqgYV1IAW92nIFV/ZedhubfYj852UrkPnTq7p2s92Zv612Jsp7/+85DrEFXM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776860762; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wXWh4JTjO3XSS1HUIBp2EkkcOxlikol+FrLwQoFSZd4=;
 b=Fxmoci3OXQje69TeTWoN2D8n8ycalqOtXUq5bfGHaN6q1LrirjI+apTmCUiEUQB1
 EQq/nhtEP3uCjVQSsP6CNcwsoBtBj4lS1SAb9w5y07bOF4fHsdQDbU6JVKS6lUo5/4g
 3v/qdR5bFKX78ioK+Gs/iQITd+aYTrqxWyWlJnj4=
Received: by mx.zohomail.com with SMTPS id 1776860760730893.8436997127039;
 Wed, 22 Apr 2026 05:26:00 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v9 3/6] drm/panthor: Delete spurious whitespace from uAPI
 header
Date: Wed, 22 Apr 2026 13:25:30 +0100
Message-ID: <20260422122538.3117380-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422122538.3117380-1-adrian.larumbe@collabora.com>
References: <20260422122538.3117380-1-adrian.larumbe@collabora.com>
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
index dc2704fc2829..42c901ebdb7a 100644
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

