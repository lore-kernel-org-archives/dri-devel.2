Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C1606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZC5tUWFO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489BE1127DF;
	Thu,  5 Nov 2026 15:35:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9D21127D1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:35:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EBE8F411F2;
 Thu,  5 Nov 2026 15:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546BF1F000C1;
 Thu,  5 Nov 2026 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892910;
 bh=KmWyzPqODDwZE1fASjdavIVw51wIuTZSw7uxaHf9/8M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZC5tUWFOD7dBoQoHnVeNdkOoqYCBSUyrainI2uEbMyh5UDIcD8NGOBafdOc9PYB0M
 afpqUIsObeX58aU8an2RQPNoNEEToBfnhj7pe2XDNmDnaxsP63IaFU5QJGDIrTZDRI
 BtDatcTzCCv0ZQIEn2GKvE5SmARPF8sHQGvu9BgwU93qFAcBJSv1lD9E49XVT2TrMq
 QqtwAdVH3nX7md+U4Oi3S7S3KPoHl5ZE7UIGG7Xr8V3b82YUgkSD/59m/L8LOYLsvf
 lbs+DwttI2kcoJJ/ymKjl0/mVvuMT/4/Pnr0ccMj0aypObaBgKkiTsgRudsZos2zfI
 Iw6d15vdGVnLg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:31 +0100
Subject: [PATCH RESEND 82/83] drm/xen: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-82-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BX7oJFhpdTt+ns3zyQ46CDVDrgBiEMiJAguSusTxssA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjKeuXzkGutx2ac6gt438ljs2hf3sYS/WG33qml68
 ZYKl9jwjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARGR/G+nrRzZHiEremLOD+
 F3hF7uPp2qvKGZ/Om7QUSk7+3vnrWqLSLMEDFW9+fbQOiFmca5qwm7FWuuKu3hXux/qn563RZ9p
 6YresY23jzU9aPscnrVE0sDvn9Wl/5qTdf+S+iXyqiDNZoiAIAA==
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
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index d193f60fad22..a0287e583a1d 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -452,5 +452,7 @@ int xen_drm_front_kms_init(struct xen_drm_front_drm_info *drm_info)
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 	drm_kms_helper_poll_init(dev);
 	return 0;

-- 
2.55.0

