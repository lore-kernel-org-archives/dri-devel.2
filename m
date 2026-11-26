Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC2606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=m6PYmqqI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B496D10F596;
	Thu, 26 Nov 2026 06:25:30 +0000 (UTC)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D5D10F528
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:25:17 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1b3acec6677so10090341c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674317; x=1796279117;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNRVcWsUwEqRjHp3GCePDYV+jK31QihzT78TeRmMmIA=;
 b=m6PYmqqIcOCS6kbF64zaNuIjTgj4qCodwKNaNyQv/HRQC5Ss/tnV4zzAQW6egXgTQ0
 8Mu2BZFLI5ozKUyYIDvTuJ+Zpyy2KKXPq9hKuGAjTV15sB258cR/0Qrx8wzez00uek3j
 FgSuQbbY7w4PH/CfuWoygtn1U9///0iuZMxZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674317; x=1796279117;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HNRVcWsUwEqRjHp3GCePDYV+jK31QihzT78TeRmMmIA=;
 b=OPXiR7aBCr8YNwmLL6TyGTqXkkFDiNXHYFwEWyX5NVSjoZ0ZuESrxTt/61vvoMnHZt
 x2g0++8I6NbVKqj7bHyhi94HZGSGJcIJm7+qhWln2bgMl++eZL7ZGm+/LsfCGTAJ1uPE
 iWmN5yt1LZtf514bDBEBm6jwAglvvZAB24ZOIRXjUGyz7Y7bjVZCiQSWTeh4BTGrAao4
 q6nrpVTd0Kzozm8jd4fiIEDUBDMJach7qaMHfVEGIGZs2yM6YorGpmdJDyDG0i9w+aSw
 qfCjeiARFMlPPImvMo2Yx4CSxCXxwEVDJ7gQLuuU8ehkQFIcHiFJeXpxLyGfJQarLV1Q
 7Z3A==
X-Forwarded-Encrypted: i=1;
 AL+hErEQSGtwxYZ2zz4RXnrhH6sJn5LsN+S3TsI29ilRNoKUxyp33JQnqpvgm/yaUwhAVSzMFNLWK+27osQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+FbhbCAW56DH27j4cHN1NNZLtsgD2WmcANSEDm/Rm5v3AFAhmq
 ESaFqfnF56yqXQY71SlfoFBB5Fh0fK0rLsW3Yy35GlBbz8Xy6awhcRy4OG1yiWCWEg==
X-Gm-Gg: AZFdTZd2nODvZ7UyqXyr4XnrzOtAao3wTp0dyJkXOlkgF9esfG5WIjdbA/cYbnzdy6Z
 P3pPFUOfEgWzbYocqv8/Pch1ywH/JMOwqvfgyVtA9SEd8MAuzIZPL//kqNG2pe+ISREGnRicMRz
 U/cyuo2rJgtsrWGJwndITbohvxY5b60+bhH4VPVje4GpRL8GzTyyh1SSFvnTPWjoiG92nND9Am2
 wfTX3jxlicsdJFAywLnmyW8v95yEl/hwgKVoPR8r5x1t68hhH7wAxG+4CC08uwdow0WLeEOxLzo
 MtNTiuWxwA2SwcnB8cjFHVi8F8+4z5+F4KNEV81Ekj1QaZUYL8cZk4FBu6XH7htxNo65JetZzXh
 JjQqwZb34wIgIJYb+8W/qRqba0gPzKI5GsNrY1OrHxFVSEeix+lYK4tSXlxry23nnvReXGXo5Wb
 dNw51JEvDgCd2c8KhbfgBNscfzkbJ0DgcoEY8EPffNJAkOy9MK6h4tU2mVeEVnJbrGY29nJCsOP
 jXRjVzk9Rs825CnbuZcqthZZNiWRioib20sJCNSSw/CMjsNHkYsBs8MRLvJAzkyrD6DSZnJA43W
 QmH+20uhhlla6+lZOojiU1zCJf9BM1MNmrXPshmspWaZ5Jr0osmNw9UCIr2JHuifTgFfvWoYQDZ
 bF+nh+5Atd0MZgozgdcQVVQ==
X-Received: by 2002:a05:7022:3a8c:b0:1b5:3490:d715 with SMTP id
 a92af1059eb24-1b55691e0camr20072859c88.34.1795674317094; 
 Wed, 25 Nov 2026 22:25:17 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:25:16 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 14:23:49 +0800
Subject: [PATCH 7/8] accel/ivpu: Use DEFINE_DRM_ACCEL_FOPS()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-drm-fops-show-fdinfo-v1-7-7cb1d1a5d6ef@chromium.org>
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

DEFINE_DRM_ACCEL_FOPS() now wires .show_fdinfo to drm_show_fdinfo() by
default (evaluating to NULL when CONFIG_PROC_FS is disabled). Migrate
the driver to use DEFINE_DRM_ACCEL_FOPS().

Signed-off-by: Fei Shao <fshao@chromium.org>
---
 drivers/accel/ivpu/ivpu_drv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 28cb18dcfa9b..933edc272f05 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -609,13 +609,7 @@ int ivpu_shutdown(struct ivpu_device *vdev)
 	return ret;
 }
 
-static const struct file_operations ivpu_fops = {
-	.owner = THIS_MODULE,
-	DRM_ACCEL_FOPS,
-#ifdef CONFIG_PROC_FS
-	.show_fdinfo = drm_show_fdinfo,
-#endif
-};
+DEFINE_DRM_ACCEL_FOPS(ivpu_fops);
 
 static int ivpu_gem_prime_handle_to_fd(struct drm_device *dev, struct drm_file *file_priv,
 				       u32 handle, u32 flags, int *prime_fd)

-- 
2.56.1.839.g22a8290db9-goog

