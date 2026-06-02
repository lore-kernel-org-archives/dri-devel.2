Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3500DCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 19:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3F110F50D;
	Tue,  2 Jun 2026 19:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=derek.foreman@collabora.com header.b="JvyNR55g";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1A010F50D
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 19:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780427886; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F4dV1v/3wK0ycZDKoby1IgcGqwyg9JGCAkaoF3SFb2LQWaJ/CfjCnA0FSR3GikruW2OfRfhrFrcb8sk9+LqHEt8sL4biTWQ0Rzb7iPtvS9uLHmAl3eNbx9d4d8HuRVS+xDnZ1277fEyvkuytnrslpCNXMiliwvgZ9v5JzV6NTvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780427886;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7waqqh91sUuQkV5a047XXhkyRVOzLEIZcLXOLapkxzQ=; 
 b=CsJxTvPgDPfb757EOD3fyigEdxJf8byu+DcDnLgjAvtNZfD10pMCkhw7F8VGmE1KtVoUYJeAam8FFgPzdU1katAN77UMdOjxyZ+Op6tM+3N3Cqt06gFAyjI+s15p+sR49uY6byOUKHdo5PFTSysv0zCrd4vG3DFwhGkimIkgLvA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=derek.foreman@collabora.com;
 dmarc=pass header.from=<derek.foreman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780427886; 
 s=zohomail; d=collabora.com; i=derek.foreman@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=7waqqh91sUuQkV5a047XXhkyRVOzLEIZcLXOLapkxzQ=;
 b=JvyNR55gTm5GMwYC4XdsNab8VQ0KBRvbhGyGajbUTe/DQwoKNUIaXVDoifG5U1C5
 8X0SrtehvQGYfll2vDz9ZNnRSlWF1Tx9pFfhu/GZJQUmUtwsbtOrVl2bQ4dOwwW90E2
 MPIWx0WvXpKyGPEv/2m3mXJ6GKoI8ApKaRrBdSh8=
Received: by mx.zohomail.com with SMTPS id 1780427884879770.2268874405053;
 Tue, 2 Jun 2026 12:18:04 -0700 (PDT)
From: Derek Foreman <derek.foreman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm: writeback: Document behaviour for framebuffer size
 mismatch
Date: Tue,  2 Jun 2026 14:17:53 -0500
Message-ID: <20260602191754.79047-1-derek.foreman@collabora.com>
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
A partially filled buffer should never be returned, so failure remains
an option for all the systems that don't have a scaler, or when scaler
limits are exceeded.

Cropping would make less sense, as the region to crop is underspecified
without some other properties to define an origin.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
I have a draft merge request against weston for this at:
 https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2071

Changes in v2:
  - Make it clear that a buffer should not be partially filled

 drivers/gpu/drm/drm_writeback.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 4da5d6094721..b4a002e6d043 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -58,6 +58,12 @@
  *	framebuffer to be written by the writeback connector. This property is
  *	similar to the FB_ID property on planes, but will always read as zero
  *	and is not preserved across commits.
+ *	If the width and height of the framebuffer do not match those of the
+ *	attached CRTC, the driver must either fail or scale (not crop) the
+ *	content to exactly fit the framebuffer.
+ *	If the driver is unable to exactly fill the framebuffer for any reason,
+ *	such as hardware scaler constraints or an odd width for a sub-sampled
+ *	format, the writeback must fail instead of partially filling the buffer.
  *	Userspace must set this property to an output buffer every time it
  *	wishes the buffer to get filled.
  *
-- 
2.53.0

