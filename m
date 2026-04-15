Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2B3F41990
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4957110E6C3;
	Wed, 15 Apr 2026 11:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="VDcvtkLO";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A18510E6C3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776252562; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IWb1YkZLFC/CuxuOLzWXmWiTYwaS7CW+k1N2BcuEl8hGWa2qopGaWPOz8JjuB2woj6Wnm0GgENCUjt8QvVU7rny8fUiW1E658JgzIsZOjrc5mPF8Yy673JrAAAPRS2GUZDo1ABtZiYAuLv5CnZ3gpblO0d6vvSKZwdmwgn7lenM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776252562;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7ID9yZtY1d0yX24+AAuEMsM5Ot4KCG6NkdpFTvC+8qY=; 
 b=SPspO73OyI+Ev97+sv0x0jBNf6oMKo7EvFMzhAfmQIHhy8fNpmBPv0iAK7FtPDdFRdIAAgx21hrYTZgDQ2o3zAV1FzUR3HgV4r3YSUS5DCRT7eM3ud/zjhgXyUCuaSTzjg29uH2Q+EfM+oQi5GKO2kuFjwvsfCf6zFCveLbUkzc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776252562; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=7ID9yZtY1d0yX24+AAuEMsM5Ot4KCG6NkdpFTvC+8qY=;
 b=VDcvtkLOAX2PaWRq9SDRW1KyEMjFA23P7Mg5N/804JRdK0DZpxZrPWUxGINopAT2
 A16jq7mDItbKZuHokHBOMGK5h1hKwM+F8CRsTkQKPj9F5wO32nlybo4ziWmgIobmIsN
 awhwZu+/ZeHvqLCq09ABjnRrZjOgredw1eOYYEsw=
Received: by mx.zohomail.com with SMTPS id 1776252561681375.2202727333769;
 Wed, 15 Apr 2026 04:29:21 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v7 3/6] drm/panthor: Delete spurious whitespace from uAPI
 header
Date: Wed, 15 Apr 2026 12:28:47 +0100
Message-ID: <20260415112900.681834-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415112900.681834-1-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
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

