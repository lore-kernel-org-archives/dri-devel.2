Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A482606D827
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kStNg1/g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C17031127B7;
	Thu,  5 Nov 2026 15:34:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F6C1127B7
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BE9660A90;
 Thu,  5 Nov 2026 15:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5981C1F00919;
 Thu,  5 Nov 2026 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892841;
 bh=LCu8g1ouSQmMe0xhFJYEocY1Lv8PIwtbIv9BiDrPe2A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kStNg1/gQu6MBiuUFoEMAMOCLtjFMKcStZVHtGvX7tQvBCaoZ4jRO53Q/xDvQ4voM
 SqqTckNhE/dbni9rRAEexFWtz5bJnt6xKaKK//FCElLR2f98UTlQynJttBC+u1PmVX
 PBe6YPzWw0CWbI+z2OgKxlMwZKWw56doe8MkIriqzxyIQDBA2vdCfRHad2dQ3k8GlD
 VT1dV/mwHamNxCluVdpiBGKJX6PUz5+IUop3iUpihNp65TfpHEMkTXs08QxVpGg+Gn
 yJit+D+qojGSrfYnBH4aELjYLTnN1BTDg+s0ZslndQvYMHY5Wo9eyytfKzkjj61+ak
 3+y63bBipYUEQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:12 +0100
Subject: [PATCH RESEND 63/83] drm/gm12u320: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-63-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1ndj0vMOrJ2WJaosCV7/8vqxi+4XtjgKEdm08OseVTg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvws+qvk2J2dPGN91gxbNfb419YaV44Ibvtu1CGTu
 SP/yjuJjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRRa6MdWrL4yZ83HZ4zuGI
 wMh5XXHmB+7GB7x8mvBSZGHPeQPHx082nU/tcsy/qJL5uzeqcH5MAmO9ew17pPjmHTp9W8MvF0+
 denzNvB0N9jF7ZvNtyctvOLtcT16vcmN5ZtjLVUu6oq7kvrgEAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/tiny/gm12u320.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 5c4004346ff8..527b830e4465 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -773,5 +773,7 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	usb_set_intfdata(interface, dev);

-- 
2.55.0

