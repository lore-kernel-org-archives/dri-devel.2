Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229EF6082BED
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jX7Gu1e1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E276610EB99;
	Sat,  7 Nov 2026 15:06:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80F810EB9B
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 15:06:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBDD4407AA;
 Sat,  7 Nov 2026 15:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA151F0089F;
 Sat,  7 Nov 2026 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1794064011;
 bh=01NRPBj8mtUges7Wc3KS2LFmopn1+/ZzR1I9ZO0jMKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jX7Gu1e1+Vb89M5hdD9Q18YdgP1XBkeGYxsalWRw7CZ9hW3WyyjX9YvOxdmQSznlQ
 V1dfs08A4sxPVrRkReZJ+b/jB2Vu3RwrJju/1tG7gJwPu4vgNCXUjENbwjUrw1PQ42
 4DEf1XQhx6ZGpBOglMQCiTY8d/Ow84kNuPowwPww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3 0190/1257] drm/panic: Test address from kmap op for NULL
Date: Sat,  7 Nov 2026 08:41:26 -0500
Message-ID: <20261107134944.705597912@linuxfoundation.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>
References: <20261107134939.434104957@linuxfoundation.org>
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

7.3-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 6a6304ec3ceee879e3a2545b217eb11c8b7870e5 ]

Do nothing if kmap_local_page_try_from_panic() returns NULL. This is
not likely to hapen, as the previous page from the same memory area
has been mapped successfully.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 23437509a694 ("drm/panic: Fix 24bit pixel crossing page boundaries")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.18+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patch.msgid.link/20260911124540.279841-3-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index ba21df4be3380..d28ce8878e055 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -178,6 +178,8 @@ static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_page,
 	u8 *p = vaddr + offset;
 
 	vaddr2 = kmap_local_page_try_from_panic(next_page);
+	if (!vaddr2)
+		return;
 
 	*p++ = color & 0xff;
 	color >>= 8;
-- 
2.53.0



