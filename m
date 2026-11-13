Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1F606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwDJ1OE4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201CC10E118;
	Fri, 13 Nov 2026 09:45:23 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB4110E118
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:45:16 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8b5c3288e6cso287522b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794563116; x=1795167916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8hYidytS7YK6Ok3u3Q5rgMe4l1KnCmLsvRq9ljIhQUY=;
 b=dwDJ1OE4Pkh5yEFyMRvWwQkglq0DLkBtCvGyMzbZHK3YIkq+JT/lBXBpfebjpapNta
 9CMkBgZ+agU1B3ESOx6eCgz+JVEJ+jwMnU2gLHdaX4Jqkrbs4BQZzH5CLz6DkFhSPqGQ
 eQ4xrTuyYGr3axOuXkrYK/f7qUe6yoIVCzG3Pd7a2H7/rGDa1vWV6SilAbUOIBH2oCw5
 UKhr2bfKxFurHqw68v7iEtfYR6cslNZPOClcQFvdrXeUTFHc0HnTwBLyk1BTS+7ckT0f
 XKHTTMHSj9OS7Lt1HLWVJVqTw5FEXZlaxYea6vL70c4+AaQntwtWweAVn8zkAkdYRds7
 T55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794563116; x=1795167916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hYidytS7YK6Ok3u3Q5rgMe4l1KnCmLsvRq9ljIhQUY=;
 b=S7clExxY1qxtPU3HEeUR5gWyCpAhB8RVdee6505rucDPkn8JY/s6aW1m0B8XUUT4c0
 QBN0Ww/MWJNkrOMcgGOh4eFpYoo3TloPJbODmiY8z9eZbBmiwCDIt6nZ6pxk5SUCINC5
 CNJYCR3tVSejL22oQjnsgxEE6g3rPF56+Tx4lijcGKidQ2Q5Ga0D1d4npvve6aKxpgzQ
 J8pBOg0nYP299fbjIdsizSCF3Q7XdDbP/FmNY6swA5b0RxkXfWYsWiYXZn2ZkDiQS7YE
 RViYkzhGrCLSCas7xLwXNPj7shszh/uPEtqi79gpy+qGf6Ecyfovseplp+PZa2iRiHRu
 9N/g==
X-Gm-Message-State: APuU4Z8LsTnMqcPT/IP3drhUujMfPHHJ2urHCzlZ4/A3X+Kb4P5bfF0V
 9Viphy90huUa/sUhD4WJ2ItwNmPujXU3WK2ngG9TEZGmrYHdnYJu1+bz
X-Gm-Gg: AYBFou2iWZdrdewMF75PmBLrw6XFjExj03pmlG9JJvpo1JHN2SeeYl3pjnc30pNkuiR
 dKpVpEMMwj9eIcW1dM9sg+NSqTrS/5Y0csqv14XsezlF29sq29QuRZei3jBUrKS7CCRuTWPWtKZ
 JGKd23aLs9BGEYRjeV5eGmUdXlDRM6+P6oFq5qcyNZgb/ygHqCLzaSLOJ0eHfNmxmQ//BaVLVpi
 +dkOOYvJ57AOu1n5Ii7OrqomIrmTr+Laa6o0ZYC3BHzpDTuyLwqoiG6WekhkA8sPODZ1riT7lkb
 0pJB9R9c/TxYyj2Tp8dBr4HHjnMGgio7X7GK0G5kuTHghv1VFavQKaah3UkV5z+ibi1PXMvAe7i
 OaXEjLaF+kooH/WQ89xuanKbWVDqHOLkQFoskYS3ilf/eFebu3jxHPzLe2WtOckl+A+ApEMOcjD
 /je8/OVtZl40uLARobrs+eJoEmtwMx3wKp5uzmImSnoQV6g7vuN1TAbvVRutgqGvS5RAsmaoyta
 7oMV/Cuh+ywUi2Uep+F2WRshQMmeVUWFgdsBmogSbrRfSFOIuN4qabGP5kgLq8OBrNidLi2NRbD
 ekrSpRq9t/8ES0MSPpaLwK2BjviCtZLfhMnz3w58
X-Received: by 2002:a05:6a00:4b53:b0:89f:4cd9:241a with SMTP id
 d2e1a72fcca58-8beb724ceb4mr2078645b3a.41.1794563115702; 
 Fri, 13 Nov 2026 01:45:15 -0800 (PST)
Received: from oslab.. ([101.6.42.129]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed2d11ac8sm804533b3a.55.2026.11.13.01.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:45:15 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tuo Li <islituo@gmail.com>
Subject: [PATCH] drm/panthor: Fix NULL pointer dereference in sync signal
 cleanup
Date: Fri, 13 Nov 2026 17:44:56 +0800
Message-ID: <20261113094456.5000-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In panthor_submit_ctx_add_sync_signal(), drm_syncobj_find() may return
NULL. The function then jumps to err_free_sig_sync, where
panthor_sync_signal_free() unconditionally calls drm_syncobj_put() on
the NULL pointer, causing a NULL pointer dereference.

Check sig_sync->syncobj before calling drm_syncobj_put() to avoid the
NULL pointer dereference.

Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef4..8d73956530a8 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -364,7 +364,9 @@ panthor_sync_signal_free(struct panthor_sync_signal *sig_sync)
 	if (!sig_sync)
 		return;
 
-	drm_syncobj_put(sig_sync->syncobj);
+	if (sig_sync->syncobj)
+		drm_syncobj_put(sig_sync->syncobj);
+
 	dma_fence_chain_free(sig_sync->chain);
 	dma_fence_put(sig_sync->fence);
 	kfree(sig_sync);
-- 
2.43.0

