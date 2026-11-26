Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ABD606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Tv09dO3e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D6710F532;
	Thu, 26 Nov 2026 06:25:22 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B093B10F51D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:25:09 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-170135e43c7so10346709c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674309; x=1796279109;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M/GwF7ja2EExmiOCCoGRHXQh66DBZWnwfGBy5FGHJ3U=;
 b=Tv09dO3e3HhN6Ro66ozJfVLKlOKFrunPnHZuHKGtZqA/FZWODpioDV1ipL2lZS6smW
 HcmY/GwsoN2m74t2rPEa0csmiw05YXW+jF9dOZRCon7DUAfedvT/eTbHUtuaPyw8b6R/
 KovabbwAWScO1EpUPbyVeROzV/FTSD3TXtmzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674309; x=1796279109;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M/GwF7ja2EExmiOCCoGRHXQh66DBZWnwfGBy5FGHJ3U=;
 b=kNfnglMdp5eh/5miqZwkFNWSbFlMTdfzmdS6twH4St3whBJHtjhSDM0IiAZrBFHTuY
 BZK98SrBb1jqhr3sBYLt77FkYgt/3o8ZkANcpsEtNKYqNjgBXSSh8Ekn+RY0tBi0cr9N
 0j7az2Zdmoy7UD3km8BTPzSKukLJarij8cD1gzTfEETiKAekaXD8cfwA8Ag/KvmN5YVQ
 ABgfYttDOgd6Mamy7kfhFe324tyLc6uiylSEkvjB9eg/RIA5WPXvbDC2ql/cyLnUdgFD
 JWN7hiHc9g6faO2lrOs5/whR4vR4odOWF1gqk3PwnMkTIF33q2SSLHCJZC+d9rZ4YM7P
 dKyA==
X-Forwarded-Encrypted: i=1;
 AL+hErHFb7pEyA5VxoQB2A+mkD0EDtbwCDXXK4Eh+6QcuvLMnx5ePPQuXeZMgotcEuXqZ6e4+O7Nl9G4wJE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+AbW1uSIb8sNd0uk4vOpV0u2XaeYC7lALIXyknhiFbZTHVt3WY
 HBvIH3ioE6ZMgnGRA9jwWVM56a5Akg9jQz4UtSf0Gfb60vUyxkLNi5Cp29F+MhjVHw==
X-Gm-Gg: AZFdTZex+ZmXpv5xRe8y6auJqQJG0pnFFPQMFYTE+vqnuZunTpi7bei7CbRuSoE9QTr
 IxCYHg8aMGNqR47Xj7KysHhKOXaJM9r0uXbGpcuXgOjZ8LogHgg+apiKLLnLZ9K02e7L1GpDl50
 Mr8W4Kz+nXpmeqpN5z+jyIC0Cq8w6Xx/zbjj0xtnResv2cAbarSeC68Y25angS5yaZ7707RxMa/
 0yLAITwOErUi2RLKS9KH7duTheQyQvSY0/9VijRX0ge14I0ecGE3OeeN44f/sSfz9qoD2kSHlX/
 H/QKby6SOgDOzBhk3bZGPHmFmicmBJAEYpAelrLKwW/Tlb4xA15wXS5AG1rQfd+TLl4f2WLgT+u
 Ya7qXZyJ9C8QKdTlH/PjFgasez5dAPWf1urPSH6NRbPGq2DhgSEPJgcwzHX0mByM0qYFgS7Dbpf
 /pLNFlt0nq5r6KylqBKWdM2ylpQlSqKuLP9DQ4svqDeBINC5WckC4pFp7DaxvQX3+77S380N0ce
 ysMybfGBBa72YmXUq5gG5HXK1gQNqkWkvsIFEnTU3JBvaIvkXwG/7XUZWy7lhFihjf59r3MNAIT
 1KarEm+tHlo2v01gt/qmj8Taw6mQDRFrKB94e0qAwOh+U1moqnb6thODD3alkE7H/hZIFYFsPRK
 iQDFz2a1X9MZmwgoVZSTRUA==
X-Received: by 2002:a05:701b:2918:b0:192:e5a8:6bae with SMTP id
 a92af1059eb24-1b570d52afcmr11431758c88.40.1795674308955; 
 Wed, 25 Nov 2026 22:25:08 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:25:08 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 14:23:48 +0800
Subject: [PATCH 6/8] drm/v3d: Use DEFINE_DRM_GEM_FOPS()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-drm-fops-show-fdinfo-v1-6-7cb1d1a5d6ef@chromium.org>
References: <20261126-drm-fops-show-fdinfo-v1-0-7cb1d1a5d6ef@chromium.org>
In-Reply-To: <20261126-drm-fops-show-fdinfo-v1-0-7cb1d1a5d6ef@chromium.org>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Oded Gabbay <ogabbay@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Fei Shao <fshao@chromium.org>
X-Mailer: b4 0.16.0
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

DEFINE_DRM_GEM_FOPS() now wires .show_fdinfo to drm_show_fdinfo() by
default. Migrate the driver to use DEFINE_DRM_GEM_FOPS().

Signed-off-by: Fei Shao <fshao@chromium.org>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index b790be8a7fac..bde3561c0e69 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -240,11 +240,7 @@ static void v3d_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_show_memory_stats(p, file);
 }
 
-static const struct file_operations v3d_drm_fops = {
-	.owner = THIS_MODULE,
-	DRM_GEM_FOPS,
-	.show_fdinfo = drm_show_fdinfo,
-};
+DEFINE_DRM_GEM_FOPS(v3d_drm_fops);
 
 /* DRM_AUTH is required on SUBMIT_CL for now, while we don't have GMP
  * protection between clients.  Note that render nodes would be

-- 
2.56.1.839.g22a8290db9-goog

