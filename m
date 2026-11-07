Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06645606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WTycPMw/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B46A10EB92;
	Sat,  7 Nov 2026 14:48:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6B910EB7F
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 14:47:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60B9860618;
 Sat,  7 Nov 2026 14:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9051F0089F;
 Sat,  7 Nov 2026 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1794062873;
 bh=pbq+gh+2s8PSuMr+1iFDlit4CKg8xZiFkZyIHosWMsg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WTycPMw/y5jHErUFM28kOb+yMZogWBg3mKdQfn6fu8aPk3qMpsTJNS6auejgLsIe2
 2XiivC0nUUi08GywzN+ZbGFCnYVqbG1OlfGLJZgXHDCElX6yIeFuXeMV08yg/pQpX0
 7+poMdZC7AeKHIS+D1r62RMxMry0Y66Jfw6iH3kM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 156/869] drm/panic: Do not use un-escaped URL as format
 string
Date: Sat,  7 Nov 2026 08:47:18 -0500
Message-ID: <20261107134857.595959615@linuxfoundation.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107134852.069646174@linuxfoundation.org>
References: <20261107134852.069646174@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 6596aae25585b183ebd528206bde6f12efaf8db1 ]

Replace the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in snprintf()
with a %s conversion specifier. Avoids a possible vulnerabilty from
a crafted URL string.

As the attacker needs to control the kernel at the Kconfig level, the
potential for an exploit is likely low.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.12+
Link: https://patch.msgid.link/20260911124540.279841-2-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index d4b6ea42db0fe..b95d869257a84 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -662,7 +662,8 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
 	char *kmsg;
 	int max_qr_data_size, url_len;
 
-	url_len = snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL "?a=%s&v=%s&z=",
+	url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&z=",
+			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
 			   utsname()->machine, utsname()->release);
 
 	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);
-- 
2.53.0



