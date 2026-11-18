Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0DA606A335
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NFhLKn7j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A524610FAAD;
	Wed, 18 Nov 2026 10:36:55 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A7710E375
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:36:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0D2511A16D0;
 Wed, 18 Nov 2026 10:36:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C60DE5FE9B;
 Wed, 18 Nov 2026 10:36:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0959311BC0992; Wed, 18 Nov 2026 11:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794998206; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=iS0ExTTKsu8lUPXOUm11HT3TtWCRfZencH+aQEOFXn0=;
 b=NFhLKn7jMrTiXiqy2JjfbDyvwTsq7MjWzKxBorR46cZABRZVGhrY6er5irNuk/zWp0cXfp
 zRY8sPiBM02CfnDkaTU+7n8XdKpvGCQOnmCI/iYh0HDvKgUkFAD9097MCrYk/83tch7fqs
 i2BFcj2KKmJQXQbVITZ4TZqeoK+NnnuJOthOZx4dqgStQHh5G5lFHyXedRrEt5OaWuZewZ
 fux1+05qti9sVc/4pwOr4YVKy7EBcKB17sduBuloq9vK7nd0m5s55xEz1CYHzi+K1LP7K9
 tpPGRnqclq8TlGfc1DEOQpmrAbHUvrtgKBkBs4gmak2lfknYzJhBR3NOL73vrw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 0/8] Move DRM helpers out of i915 driver
Date: Wed, 18 Nov 2026 11:36:27 +0100
Message-Id: <20261118-feat_move_i915_helper-v1-0-652177f3107a@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKx//WoC/yXMQQ6CMBBG4auQWduk0yJEr2JMU+sPjFEgLRITw
 t2psPwW7y2UEAWJrsVCEbMkGfoMPhUUOt+3UPLMJqNNxcyVauAn9xlmOLnw2XV4j4hK21BqW8M
 bbSm3Y0Qjv/17ux9O38cLYfrPaF03odAEK3kAAAA=
X-Change-ID: 20261116-feat_move_i915_helper-03c4037ea203
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Manasi Navare <navaremanasi@google.com>, 
 Drew Davenport <ddavenport@google.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series moves several helpers from the i915 driver into the DRM
core helpers.

These helpers were first sent as a preparation for new DRM features in
the following patch series:
https://patch.msgid.link/20261022-feat_link_cap-v4-0-a4f3f6e8cad9@bootlin.com

However, as these features will take time to be discussed and accepted,
the preparation patches have been advised to be sent independently of
the original series.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (8):
      drm/dp: Move max DPRX link rate helper out of i915
      drm/dp: Move DPRX 128b/132b link rates helper out of i915
      drm/dp: Move DPRX 128b/132b support helper out of i915
      drm/dp: Move supported 128b/132b link rates helper out of i915
      drm/dp: Move DP sink link rates reading helper out of i915
      drm/dp: Make the DPRX link rates helpers static
      drm/dp: Move eDP sink link rates reading helper out of i915
      drm: Move DSC capability reading helper out of i915

 drivers/gpu/drm/display/drm_dp_helper.c | 260 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 211 ++++----------------------
 include/drm/display/drm_dp.h            |   3 +
 include/drm/display/drm_dp_helper.h     |  13 ++
 4 files changed, 308 insertions(+), 179 deletions(-)
---
base-commit: d5a6e2921e68b0cc42812376ca6c8095b6c941a2
change-id: 20261116-feat_move_i915_helper-03c4037ea203

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

