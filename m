Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30767CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8068710E8F1;
	Mon,  1 Jun 2026 19:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=derek.foreman@collabora.com header.b="g+TAfFKM";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A2810E8F1
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 19:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780343865; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GpQgn32YZibdsmcGEN8BCO+8OL2njj0kA6Vc2MnpTxrL1m8qJwY6Bg4hjJW5s7tdOBS5LUlzHZzK0R4H29HmjOtEOKJaJjJy8btX7fQQ4C/IMXoX53W4mCgL1rr67+VwTU43FEh9w8jNEaDsA7qb83BdLYSWHDFhp4gNwydupO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780343865;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QbVg9yobG/DIvE8IiB8zWT3u+0k3okH85eP1wnm1lU4=; 
 b=k4D7yEG7n7swfwitWQ+JoSLLWKS7TU+3pcrS8bJebB41sO8Tw3XZfQoTlXXyYQTWWyCpD/cqOFBKN1iFAh8wgd2i7NpU/sRfJU60gusexGLBbS97/XM/d0Gk6rI8+gG6NRX5b64HgYZRFRg4bADkh7atAWIZxkkm2zOADwXags4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=derek.foreman@collabora.com;
 dmarc=pass header.from=<derek.foreman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780343865; 
 s=zohomail; d=collabora.com; i=derek.foreman@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=QbVg9yobG/DIvE8IiB8zWT3u+0k3okH85eP1wnm1lU4=;
 b=g+TAfFKMOuwC14FbS4o3beFf9Eh+EiuIwIG6ucYH7ilWWEWDIfQAis7d5jsVZopx
 ITBPecSATXCTlRPmEvVJgUmTXwn1eD35BBpS/lAqcatGtE8EuIVJh05RpWoJYnm6o5S
 kpoVH+aJFezywTgGacsl7z1euEI7rKtZXH8jp/mw=
Received: by mx.zohomail.com with SMTPS id 1780343863347724.8151694120326;
 Mon, 1 Jun 2026 12:57:43 -0700 (PDT)
From: Derek Foreman <derek.foreman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm: writeback: Document behaviour for framebuffer size
 mismatch
Date: Mon,  1 Jun 2026 14:57:32 -0500
Message-ID: <20260601195732.72538-1-derek.foreman@collabora.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Currently we have not explicitly defined the behaviour when the width
and height of the writeback framebuffer do not match the width and
height of the attached CRTC.

Allow the driver to perform a scale operation to fit the content, so
systems with scaling blocks in the writeback path can easily expose them.
Failure remains an option for all the systems that don't have a scaler.

Cropping would make less sense, as the region to crop is underspecified
without some other properties to define an origin.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---

I have a draft merge request against weston for this at:
 https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2071

 drivers/gpu/drm/drm_writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 4da5d6094721..735a3cdff79a 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -58,6 +58,9 @@
  *	framebuffer to be written by the writeback connector. This property is
  *	similar to the FB_ID property on planes, but will always read as zero
  *	and is not preserved across commits.
+ *	If the width and height of the framebuffer do not match those of the
+ *	attached CRTC, the driver may either fail or scale (not crop) the
+ *	content to fit the framebuffer.
  *	Userspace must set this property to an output buffer every time it
  *	wishes the buffer to get filled.
  *
-- 
2.53.0

