Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B2606A8B7
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=HfZ8iDfm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1C410E428;
	Wed, 11 Nov 2026 15:05:48 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C8710E67D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=xmYQLB2Rn6WOu2t+0Ajd79lpXskRnWxPjC4zopbmmx0=; t=1794409538; x=2109769538; 
 b=HfZ8iDfmQUDJY19D7QEJLNfL2d35uRQDAsV2la8bH19+sb8pjOv70ZXo+uQ73K7nRCvXrU2hbyR
 yW389J9J2pAUWwke2pZrkiq0c+6w9g31lkt+X/dyD90wRJRJkk/xRwQxf4ihvDSnGuU8P9b2BKs8z
 UcAJsaqBTZ1nvh4DcUZUU5VqizARYCsPR0uND4eZkjNBHIyX1dRf7e6nQgqaLovHVTkSq7pMv3cZf
 eJh8yuPlVKx4UfmlVLZTiDTMCMKvYAZGGTS+pNmmB+5zMTBK6DkYEsn4n43DJ7TrP21a0wf9q1u+1
 ILORf8ezPoqryuj92bBIU6Aqb+xRbibwH7rw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xR9tG-008sMR-PV; Wed, 11 Nov 2026 16:05:35 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 11 Nov 2026 12:05:21 -0300
Subject: [PATCH v2 3/4] drm/vc4: Re-enable the V3D interrupt after a GPU reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-vc4-irq-cleanup-v2-3-aa757bb742f2@igalia.com>
References: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
In-Reply-To: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=kb6++4m4EPH4gX89jHgQFb0JUnfzwuM7knBZm+rEWc0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9IQ1IQT9DgIVVD+rVCaijpaE15AwwS/bTVmB3
 LjDWfsi75+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavSENQAKCRA/8w6Kdoj6
 qoxxB/9BwUn6dXt+fBp7q327rhiawa54ZeLLhouVhBvJ2NtjFPyl8mynqmYUfOKyOCMA9etP1e9
 tQMnpZ5UjeOKPkwoTeb4WtN69OikapT3kagTClmn1oB5jaf4AqQ5zWK+Iff49N973i9CSSciWPJ
 67b2uIGtMOo1z16eomQVvGy4WwwY0lyyxvprT+VRSvaEpALjAy/46L++rgRCG/nC49OTdZOTdFg
 oGj+6w/uKNAxpceCr+MCGJ7LIdfn0ZePdbPMYblBd7ku55jBxQmE2aHI+XnVcyRBdUsl0ZZcva9
 rBwTBfeEYv2KBZzYHGY/TTZ1lCaeCnHqw98E4pBg73bo+/oq
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vc4_reset() masks the IRQ line through vc4_irq_disable(), which calls
disable_irq(), but nothing in the reset path calls enable_irq(). The line
stays disabled after the first GPU hang, so later jobs only retire through
further hangcheck resets.

Commit 6abc8e4dcfbc ("drm/vc4: Disable the V3D interrupt across runtime
suspend") was written against drm-misc-fixes, where the GPU was still
reset with a runtime suspend/resume cycle and the resume callback
re-enabled the line. Commit b4448823f151 ("drm/vc4: Use the reset
controller to recover from a GPU hang") removed that cycle, so once both
landed, enable_irq() was no longer reached.

Move enable_irq() into vc4_irq_enable(), which both runtime resume and
vc4_irq_reset() call, so every path that disables V3D interrupts also
re-enables the IRQ line.

Fixes: b4448823f151 ("drm/vc4: Use the reset controller to recover from a GPU hang")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 2 ++
 drivers/gpu/drm/vc4/vc4_v3d.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index d7aa698526dc..ff405d3c1d4c 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -265,6 +265,8 @@ vc4_irq_enable(struct drm_device *dev)
 	/* Enable our set of interrupts, masking out any others. */
 	V3D_WRITE(V3D_INTDIS, ~mask);
 	V3D_WRITE(V3D_INTENA, mask);
+
+	enable_irq(vc4->irq);
 }
 
 void
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 2bfb8766d1b6..15a3c49b4f54 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -378,7 +378,6 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 	vc4_v3d_init_hw(&vc4->base);
 
 	vc4_irq_enable(&vc4->base);
-	enable_irq(vc4->irq);
 
 	return 0;
 }

-- 
2.56.0

