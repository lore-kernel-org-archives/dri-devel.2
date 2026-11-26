Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=miBHiG/0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC8A112142;
	Thu, 26 Nov 2026 08:11:43 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E475F10E166
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:47:32 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3282db206d3so1725113eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795661252; x=1796266052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SkDLMBnWNkNjw18oppd4sNVKE7u9dtoE/Gs5dVTHbSo=;
 b=miBHiG/0Fke5J2AZl3qgEz5Uf0fmM3BwAGdQLYbDZ6SKwmNdFYqgnQO3tA1DVGcAfp
 UA7KVeNuWJt8irQt/elY+IXCC1UzvYUwwdzpcobd7xqjZ6XoaKnxHDt6MbSfVbwbABIO
 OF+IS5o33UdsytidA9L6xyP0QadditMSq5pEYBj3mQXglFO0vJQsLlUa5M9nJL2Ih9KM
 LjKAAX6vR2/8WYYrdQaeEufHt3SUxlRaMKiOamc/HZrEWsNaKednJCV6X4saC1U848+P
 mGrwKlgx4Yq5XiMiVIZTnS+w5JPJ8QZ57UUlCxVSvJiM2XRXUMcpgkaBO3bShioDQoW8
 cqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795661252; x=1796266052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SkDLMBnWNkNjw18oppd4sNVKE7u9dtoE/Gs5dVTHbSo=;
 b=RtlRAX+sBxysS2d81790h5rWoytBWN78Wf7wb1iEksxxW5BaOitjWnRJ/tIYjpqmaX
 mx0JfExTmI5b2657RQsEfF+6ZmY2cABMIBzYj8ZAbXDH5Lz/y/KtpWJ4d3swqpvwbEdQ
 IGbG3g9+4UdodbZF3leWmZKR+7lqwixjpe72dGkSfykLyCGItkbw1n20AOlUV4nv5N+U
 rF2SssX5ketuxT6Ve42ArqOYmQCT6ynD73z8PMsR0LUa3TYvDS5r67S4jDPGl6AzdGRi
 iTlsqXslaridfBq0zJztWJ6vKrmCppa0F1Dn53/lqH5tKx5UkY4fVVLRDsrd0qVttKca
 V/TA==
X-Gm-Message-State: APuU4Z+mr6eb+WpIJam34lzn9cH0SKPXMBx/HVE4kupI7ZO9xwXRDp94
 EhqOPoIn3hCnDeiAw9xmyy8DmEib2bCpvy4dmQ9z59hNeveWsw64U1lPuZ1UETo2
X-Gm-Gg: AZFdTZc1Ei9s6lyqner1uIvRVxoJLcpK/l+eJrZ/6AsXaZ7FkTjsFk6+oRxIVVKzp0M
 Knu+KmjtUzJYpAsjqLrOEHrkWo/xNipCCyEGk9nT+FOYC5HsNN0BIX6UkOfxL9gnBhHwXbmXsi1
 RilUK/jb8zAQLptQC+ygetfZB7NozPf0/ZbWPyNvF5zchH6jSmLkHS/WP7C66g2Brq6+EXsImI7
 MfXrYsMsZEp+mHPul9CM0WoxuGYZQavpfIi7QWh1XINmbLA/DNngVQeldQRQyFOunVX2rJs+1Id
 9vijyua1MZgxfQVoI+4tIWwjRRhz+xi+wkJJQjNqyNJyE5YGVQfyh6MJm+Mr7Jm8Xly9TVNQ+JB
 zqCVw+qSZ0O+lnvG36Fm4gce6o9YJUjbIS2h8WH4+1bBaa4szOIx6qnKQHnEBu1CDi4KcrDvMSk
 1LzEoXEoQNvoMNmVYhvss5eFJhhADp0Iq6MB7nYUrREvkdkAvfmSAFw42TJYbLX82db2Wy4qJFk
 k3DTxugBOjExw4qir6AWEB3t+/NcIbS/r7BaynHtFqLLCL4hsZoSRdXzdygfhcWHd94b85iQOZD
 MXRNl8llRKCuE1IgfbiL+oALaqQvqimJjcms5XUqUw==
X-Received: by 2002:a05:7301:9a82:b0:369:4c3f:8a5 with SMTP id
 5a478bee46e88-3856ef45385mr21416687eec.14.1795661252129; 
 Wed, 25 Nov 2026 18:47:32 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm70815493eec.5.2026.11.25.18.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 18:47:31 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, benjamin.gaignard@collabora.com,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH v2 3/4] drm/sti: hqvdp: start the XP70 from device init
Date: Thu, 26 Nov 2026 11:47:09 +0900
Message-ID: <20261126024710.33401-4-hiyoukou@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126024710.33401-1-hiyoukou@gmail.com>
References: <20261126024710.33401-1-hiyoukou@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sti_hqvdp_atomic_check() boots the XP70 coprocessor on the first commit
that uses the plane, which means it requests the HQVDP firmware and
writes it into the coprocessor's memories from the check hook.

.atomic_check() must not touch the hardware.  A commit with
DRM_MODE_ATOMIC_TEST_ONLY only runs the check hooks, so a client asking
whether a configuration is possible ends up loading firmware.

The boot does not depend on anything a commit provides, and
sti_hqvdp_bind() already says it creates the plane "once xp70 is
initialized", so start it there.  sti_hqvdp_start_xp70() keeps its own
xp70_initialized guard, so the caller no longer needs one.

This moves the firmware request from the first modeset to device init.
The lazy call retried on every check until it succeeded; this one runs
once, so for a built-in driver whose firmware lives in the root
filesystem the plane can now stay unusable where it used to recover on a
later modeset.

Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Minseo Park <hiyoukou@gmail.com>
---
 drivers/gpu/drm/sti/sti_hqvdp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index 360d213f2094..c6b6ed54b899 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1081,10 +1081,6 @@ static int sti_hqvdp_atomic_check(struct drm_plane *drm_plane,
 		return -EINVAL;
 	}
 
-	if (!hqvdp->xp70_initialized)
-		/* Start HQVDP XP70 coprocessor */
-		sti_hqvdp_start_xp70(hqvdp);
-
 	if (!hqvdp->vtg_registered) {
 		/* Prevent VTG shutdown */
 		if (clk_prepare_enable(hqvdp->clk_pix_main)) {
@@ -1333,6 +1329,9 @@ static int sti_hqvdp_bind(struct device *dev, struct device *master, void *data)
 
 	hqvdp->drm_dev = drm_dev;
 
+	/* Start HQVDP XP70 coprocessor */
+	sti_hqvdp_start_xp70(hqvdp);
+
 	/* Create HQVDP plane once xp70 is initialized */
 	plane = sti_hqvdp_create(drm_dev, hqvdp->dev, STI_HQVDP_0);
 	if (!plane)
-- 
2.43.0

