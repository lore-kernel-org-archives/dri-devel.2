Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888A606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+6aFS12
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8CA5112A1D;
	Fri, 23 Oct 2026 08:21:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BD0112A08
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:21:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0574602C3;
 Fri, 23 Oct 2026 08:21:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792743681;
 b=ThYx9QsVXVA2VKk7D0EHSt7nAjUr0vkiF3s20A+KHMNfGsyL5hOkRUfNiJcC50JuQ+Xd
 fOCmdkU1sIWji1SL002LEPcLk+Vtu8rcg9KqeEwx5qPb/ujMHclACGUO8GziihqduZ+RV
 cww9PtQAxftNBvqJuCLYcCASO2BqI/5uh8rN4/MpneEhIG+CcfOMCc/jRYZxsIlIWIw8e
 v6VaGJU1X4AXgQWMv/xcUVq2Kl5H4bUzu6TNdktQWB1LiQ7WPQ5jjeHQEDDHO3BoAqjWH
 BFqO4pvu8pbTw+PpoypOdWzuU+DyD8ru9I4wLTxcMhQVX/yhXgt5DNgaaLRvLGVwQoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792743681;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=M3JE++dbaV8C5sXy1QFm4dJO2E5jczTPA8T3a7KBBrk=;
 b=m6sxvxUqCeLeFla+kwjCZ3HRXe50LLCh21M7B8rbar0FfETql6bgHxsbjDB9W3GikYsU
 tI5gw+XuZr9ylmyes1H6+Jn4C5F8ncCMtngDML0d0Mihecraq5ITCxuTNrVc6eBo8XfEP
 u4JW2Y/BtX0OK4DNmAIE98gfQOYkO5Vcaga7MuVUdjvIHkMriQCVjZQLvZMSMsLKrENl/
 6DcnnPHAU2PiqA//7mz6zc3EYF8SnHsFguN7BExCYG5UdRFfkP01uIuyi6Ypt5c9jA1YU
 Q+RhDrv0TmKLRqGSMum1SE7cK5LbsWpE90LUr4U3khHxlvQjPaZ9SpvCVFnsAW3fpxQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 2D7DF1F01828;
 Fri, 23 Oct 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792743681;
 bh=M3JE++dbaV8C5sXy1QFm4dJO2E5jczTPA8T3a7KBBrk=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=N+6aFS12MLbAGWDmZpfF+/7NCFW8TKljJ3V1gd0/RAe3OsfQs+QsbaJNZe39dlltf
 ccXnCxI3cS7Lub6Zz03u+4u56C11agUXHr06/IzsVd56/JZ2PFCrfpVfmVZJqs/71l
 CHPgJNkpOT3MqyU5U1Vu6BHfBSfWjP+svlKanUY6MrbfGsYIj5JBf4J1WXfFalZXFi
 SCjnVV3K5BJw5MLkFlwjAVDLoZZ15FE77vV/WKg6ofA1Gvl3/f5e5SShqeJU63P3pw
 1sQDzekvp+g3WEWc8JPDPZKnzc8ukn2c6jVVHtupbO0XFHw+70F6wYBul70OEDZO40
 UBLviGcv+T4Gg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B80FA4441C;
 Fri, 23 Oct 2026 08:21:20 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH 0/2] drm/panel: Add Samsung AMS644VK04 panel
Date: Fri, 23 Oct 2026 13:51:15 +0530
Message-Id: <20261023-panel-ams644vk04-v1-0-56096aecd0ff@brar.si>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBBG4Vchs7ZJOzbE+CrGRYt/cbxU0kFiQ
 nh3iiy/xTkzKYpA6dzMVDCJyidXuEND3T3kHkZu1cSWW2f5aIaQ8TLhra3309N6g3SKHNmDmal
 mQ0GS3395ue7Wb3ygG7cPLcsKOeVzJXQAAAA=
X-Change-ID: 20261023-panel-ams644vk04-ef8b2b24e222
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792743679; l=1791;
 i=patches@brar.si; h=from:subject:message-id;
 bh=CmyaiwJWwoIMm1mdMGXzb84Z0m35G/pLGpSpkLPfqbk=;
 b=tWJfdchfzzcMsz0ZZmLr/J/rhEsP7HlXepsJOewkxdR9nqjFRuWQScnNSu8dZNObkScA23PTQ
 AjiVFN0U98sDzyZtaohbhJu7AvzvLqfvnWHRoTIyhZHbwRiHwjauXsP
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a binding and a driver for the Samsung AMS644VK04, a 6.44 inch
1080x2400 MIPI DSI command mode AMOLED panel with DSC, used in the
OnePlus Nord (SM7250).

The driver describes only the 90 Hz mode for now; the panel also does
60 Hz, which needs a way to pick the mode from the display pipeline that
I did not want to invent here.

One question for the reviewers: the DSC picture parameter set is the one
the downstream driver sends (DCS 0x9e, 88 bytes). It differs from what
drm_dsc_pps_payload_pack() computes for the same geometry, mainly
first_line_bpg_offset (15 downstream, 12 from the helper) and the last
rate control ranges. The msm DSI host fills the shared drm_dsc_config
with the helper values, so the encoder and the panel decoder use
different rate control parameters; the picture looks correct. If you
prefer, I can switch to the helper PPS once I have tested that the panel
accepts it.

Tested on a OnePlus Nord with the msm DSI host (a 7.3-rc7 based tree),
including suspend and resume. The SoC devicetree nodes are not part of
this series.

Signed-off-by: Ishu Brar <patches@brar.si>
---
Ishu Brar (2):
      dt-bindings: display: panel: Add Samsung AMS644VK04
      drm/panel: Add Samsung AMS644VK04 panel driver

 .../bindings/display/panel/samsung,ams644vk04.yaml |  76 +++++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/panel/Kconfig                      |  15 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-samsung-ams644vk04.c   | 373 +++++++++++++++++++++
 5 files changed, 472 insertions(+)
---
base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f
change-id: 20261023-panel-ams644vk04-ef8b2b24e222

Best regards,
--  
Ishu Brar <patches@brar.si>


