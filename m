Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE37CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 14:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE7B10E0CD;
	Sat, 23 May 2026 14:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="IQ+ULTFy";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813D510E0CD
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1779546473;
 bh=Pv8z2J0lRzEt9ebAQ2NCfFAHSKrvsXeJydGM50u+Fq4=;
 b=IQ+ULTFyr4awzLJcMEzICFdjb7r6vPn2q1+t9m2PudZZoWjVk1lu9OKdN2lmo24gA+oHkNlwG
 eNDBk/1VuaDZ9VpxviVLVcb++xXT0o9X+xh9R5u9daGfepLMt5o8WE26cPRf6/VR/0/seE8B67V
 8Xx8u965mR05pZMJCTfPvRG48K8vl1GgZ/N2Hw+OeDfGBeoeCyvz6yk02bVZ3mb4bSBLIObjKks
 hqUJq/EhRg4iFm/L4uy8VFn6llk2a6yZprL4jp55QusRxOgC811RlrHuIzLQpSlpsJy8ng4DW59
 Dz6F89NHZ5aSBEkr56wDf+sofAtA+otwVGKhjaSRUb2g==
X-Forward-Email-ID: 6a11b967a1e1c50b7c2a689a
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Joshua Peisach <jpeisach@ubuntu.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Peisach <jpeisach@ubuntu.com>
Subject: [PATCH NEXT 0/2] drm/radeon/radeon_connectors: use struct drm_edid
Date: Sat, 23 May 2026 10:27:46 -0400
Message-ID: <20260523142748.50034-1-jpeisach@ubuntu.com>
X-Mailer: git-send-email 2.53.0
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

This is the equivalent of what was done with amdgpu[1], using struct
drm_edid instead of struct edid.

The radeon_connector_free_edid function can also be removed since we
can call drm_edid_free (unlike last time, I made sure to set the pointer
to NULL afterwards).

[1]: https://lore.kernel.org/amd-gfx/20260303211823.76631-1-jpeisach@ubuntu.com/

Joshua Peisach (2):
  drm/radeon/radeon_connectors: use struct drm_edid instead of struct
    edid
  drm/radeon/radeon_connectors: remove radeon_connector_free_edid

 drivers/gpu/drm/radeon/radeon_audio.c      |  4 +-
 drivers/gpu/drm/radeon/radeon_combios.c    |  4 +-
 drivers/gpu/drm/radeon/radeon_connectors.c | 60 +++++++++++-----------
 drivers/gpu/drm/radeon/radeon_mode.h       |  4 +-
 4 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.53.0

