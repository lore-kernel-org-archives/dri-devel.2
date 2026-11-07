Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149B6082BD8
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgfnCEUA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D03910EB34;
	Mon,  9 Nov 2026 09:31:16 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC8F10E011
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 16:54:35 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36e90071735so237787eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794070475; x=1794675275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/BevkJCMPcfWr9d6YrkRMRFnlRLydKHfHcaWta0vvDU=;
 b=FgfnCEUA+nvPnx0rbGmEEcougvbg+4sl8iEcK7ZZuNuaCqADVDctu4JJDl7pb2swUJ
 HWt9FsmYqnBqrH+N+/mkx0JXyfTEDMzRAhKPg+qoJVitFnba1ZURbUnLmYhhk7oG3GvF
 3Jur+jytLgKcMfx9CVSas77AEy4xZypZKsTC9xubtMHdpbHlwAhjz68J2LVcDdUKOnVa
 neS6XZrufVxfOyuYoj3Wg336Fa1DSHLEjDvzuJjp/0PL5dheqCpEDHzXC19lwqIfryoM
 x+RFs4cLp9y3fEZHHnQq9l+v9bl67PZbQaPcV7lFiy0tyD71Z1h8otTHIhMHWqhJlbzI
 vXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794070475; x=1794675275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/BevkJCMPcfWr9d6YrkRMRFnlRLydKHfHcaWta0vvDU=;
 b=pUTkJndNU0xHYUSOna3+OslK+mtjSPYseFlEbYf2hXyshyE92dREi3ijVWahb9zgoz
 SI6Hf1/84m+HuG0PXWqremVQrKYwXlBGhx8Bl9egp2DlslBb1cTEKHIkB2fZp2RpDBvG
 YyJRYrNO2oZgHQTAkzErZdSQG1eH6DxW4XIkdgBV9KdEchyP/fDI6iuiH1HtbK9FK7T9
 PmomDUZVPflNPnNL5z3aKAXURaE2QB7NcWO/PHjnZIp0lsr5fMbJO3I+2M2wHI4YgB59
 Cdu2I2deGGtaGCqe/X+Lg7G82iCMfZMhsGiWg0rJmNpFkSKE20EcqQnvxaE92yxsyWFa
 Scgw==
X-Gm-Message-State: APuU4Z+8dstusIurYy9IE8ZKeQYmgDO/QvHEEPnoLYX4gyiy8Wv5S8gy
 fiUtnIfC6/0mv0Tr753f9rtmIBM3CPtKmf9Cy3/I7SGUml9FKhvzrp7Q383bk6Nq
X-Gm-Gg: AYBFou2is8ml7NliO6t17TbRgrQ7DhITOJDeZ3yG/OTvWg64j5+okk4gVX/WbECUqV3
 RWO9o6ulCWsr0DLmolROLyr9dTKOasqEiRZnx9hCTWvS4EwvFTAJW+eIGf+yHwPEeiuEJtFGreJ
 WD1MW/8gNVjqsJ3VSSRfoDOXjRLCPoW8RQezhPooqB2ar5SQbwFvqet7czOGnLo40aSQL9oPkm9
 TiwgwbZpJp+jd9mNnQonz6RI92aeSntg+2UOjFgNN5x5IBFrg6ieZ5YVVxjQXmUjl/szsb7/wLI
 dCMf7JVgyZEoo/tAFyK4YBVIYW9hZXKEs2e/YKrEkf1LMrCmG2LA/O6mnqPa6nwwKERxWhCmMMM
 OFF5mYFYx+x9dIyic60EnVAMyKnloqk/ofCIrCq3FwkcARL+f4o9rU7xgjxD2xWScEVw3859pJy
 B9XltggCNpK1tulUmwCzDFjmqVJyucx1vz+Jp/6NnX6xIhtz7POLjVE4NEbepljoFZvQOoUFGL9
 UuHaj0AEsbWyF1eNk/oMNLXH9RGroLr9jPgoSQTbikCf3oCoE2HbCRkeMhYIFgrWFwWZlhj2lZ/
 2P5FFOJvaD+35tk0meajg4RoDRvHWqOFHsDnQMgi
X-Received: by 2002:a05:693c:2503:b0:36f:10ec:f692 with SMTP id
 5a478bee46e88-36f6fb7f196mr12136500eec.0.1794070474554; 
 Sat, 07 Nov 2026 08:54:34 -0800 (PST)
Received: from localhost.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa9aea75fsm29255250eec.15.2026.11.07.08.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 08:54:34 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH] drm/gem-atomic-helper: fix fence leak on
 dma_fence_chain_alloc() failure
Date: Sun,  8 Nov 2026 00:53:03 +0800
Message-Id: <20261107165303.13508-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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

In drm_gem_plane_helper_prepare_fb(), when both "new" (the plane's GEM
singleton fence) and "fence" (explicit or previous plane's) exist, they
are wrapped in a freshly allocated chain.  If dma_fence_chain_alloc()
fails, the error path runs before dma_fence_chain_init() adopts "new",
and error: only puts "fence" - leaking one fence reference per failure.

Put "new" in the allocation-failure branch.

Found by static analysis.

Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index abef865c5f2c..1e484f26ab31 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -153,6 +153,7 @@
 		if (new && fence) {
 			struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
 			if (!chain) {
+				dma_fence_put(new);
 				ret = -ENOMEM;
 				goto error;
 			}
-- 
2.25.1
