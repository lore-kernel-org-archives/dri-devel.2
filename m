Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F494CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 18:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C539210E2A4;
	Fri, 22 May 2026 18:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="E4owSaL2";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A7310E2AC
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 18:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779475953; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mCyD2Y2mfCMi1akCT2aZP8+tCsT5vpLzJsfHccKBxrPoh9oH+J0KiH67S4cWDNToF9TWX04cheYjNANd9TAY2uif0Y8iTkN9ktg8FFwV9ooNyczjWXFesaHN+131ZzbLnT+eIm4hqKOQ3d4rCdlGoS3H8rHgohXgv9b0n2NmlMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779475953;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=do/tIM3Ojb1Vv1appOYmHiLTKOw9/ngQpz7qtd/LP/Q=; 
 b=Ki/iIH3rE0mT9Su2zpWZLjz+hN/bEcjNnyKgIsJ9rzPYHrvNR2OJXbW/uhhxCfeGqpTx9AvVm49w4N8eulqXhSleXaQRdx928gJoadWptScMYzgdBFGZgu30nhkomQzF6Q/TPQlkOsg52LIYDtGfs7dJLnaik56CB8wqWLwIdmc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779475953; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=do/tIM3Ojb1Vv1appOYmHiLTKOw9/ngQpz7qtd/LP/Q=;
 b=E4owSaL2GY2gcwE8jRGeu7NeNioEL+rbhGH0Goudho9yyhNsb05p3IYjIX7G0ldL
 JNkasv0oTN647LdZX70EyZzbOnvrxBToI2qyPzlyuzUWZU7ir9jaHsJXc2zF8CrkMOd
 4em7DQyXRDTdwAAM8THddaE3yTes8mcyNWkf94jw=
Received: by mx.zohomail.com with SMTPS id 1779475951927658.5553860696097;
 Fri, 22 May 2026 11:52:31 -0700 (PDT)
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
Subject: [PATCH v13 3/6] drm/panthor: Delete spurious whitespace from uAPI
 header
Date: Fri, 22 May 2026 19:51:57 +0100
Message-ID: <20260522185206.2798288-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522185206.2798288-1-adrian.larumbe@collabora.com>
References: <20260522185206.2798288-1-adrian.larumbe@collabora.com>
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

