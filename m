Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD3606A333
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hesUhtNa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481B910E2A5;
	Thu, 26 Nov 2026 06:24:34 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F6C10F40A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:24:28 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1b50a4bd2f3so4854844c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674268; x=1796279068;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1d5rRHIyLnLkkI5kSP1hcdlsa/voBQeRYBRgutIn/lg=;
 b=hesUhtNaMzLrW5ggmdf8E4nGKw5sCXjvywaSV7pwACFumJtCcf4iZPHOC87OTXplIw
 uCHnlYbqjnAGDaNKjhJ3ibEttDf67V3s85wotWtLX44ieWnPFy35IKUG8bbUX8p8J1p4
 uJc6+p/8eVmFNXdMKS4T/uifBFo9uQStHXuFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674268; x=1796279068;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1d5rRHIyLnLkkI5kSP1hcdlsa/voBQeRYBRgutIn/lg=;
 b=E630yFwTo6VQqV4ZGqtYf+e28PgFD+j6tDks9tB2DwWy9df4CSCX1KzIa89y5Ec8U6
 50AlbrfrllwvDk8cnUXV344Rs0ImJvGHd707QHI5jtaV6tGmPEARLIwDefXUNCt1m3uy
 TAU7ORSjhVhBFra2ezCgOBC2dGzjvhmRkBVhkUTUW4Moef5F6rixNLGNNSRjwaxyLSrH
 SnGSWzohgixWPRbJCjWu/izX2bzdTylAgtJqNdklKcPkmgSwt76bT2/KqkYZr1SSkSaX
 ScSMfhoBA4+o8Om/EAVVKH3LrI1f29QIaeXVfwB7FF5Zcdxg0sHHGd+J+b1zZi53KJiX
 cXsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHjHtdTAgRhsQMHBvOCOG3tuSS2DeB4G9VJVm2QqZC2lq7QjT4UG8+ZCBtM9mgQME7gL6Sc5zCRuEI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9IbvLsmux2v3E3UEZAw8waGrdmfBzEH7juuFLHaMMRYpbtz6kY
 MbVORWPxqphyOTp3+VUUwPKEWYFzRUFPeqI7t/U32AEvG24aoWUOTHUG9MFCWdsLdg==
X-Gm-Gg: AZFdTZdIEUHL0W1SRC942F8sJd8Lnvk8z1TiX+SbvDwEbnF6fEdYnHRQHK30L1/xatY
 upjRsob4fYvMdZMzwq69Vy+A087KKJ/RtIbm6um65GaqHgO8cE549ppwFp47uFOHVitd7lHNVfB
 q8LCoSBA9EmnixgQdR0xmYIRMsoqG7AO3BfbNAR7PF8ABSsMz4QfDNIZXMRONRPOSbQVn9HkC9l
 Z2KWUjL15pAyQSxaFMp9SQv65C6qKi/tQCqHaVPCXlpONIKazmSj9sR/fitVNmKu7iQiOd1U9v2
 ZHLgTm4NL5Ub8Snq/iD6Z24Boa0eyE1z1V6wHQ3tTFnbwkoyqfgB80VbTKP7MDt7KYn9dcsxU+N
 mRYmuZ7V9UKxXYhoqWS+wRSUWDGqq8ST7jye1luHv0/4eryh8IkaOCoItm8PdVmIJ6QnDJYsnjI
 c+S+lMMfJuec+SkoJVPLLJ9DJt04NT5xaiPOUqLfMWpeOqWC7QQWDPsZoA61I4knIwTL5UW9cBb
 P/2t4LOkZKPg7SvRy5LpT1KGb8OKXd0Kse9isXmVhWEkqfzvqtsGgjnnuH8BiB60FkLeY2YAT8Z
 VfxU9hD+drw83fvCOfQ2qCLP/J5MmuGpaJxqncZxKtRXs8xqTRg+9hc9BOb2uh4bl2iF89+FaZq
 jADHHawDtfBuMDaJYq8tjsg==
X-Received: by 2002:a05:7022:290:b0:1b5:283:79c8 with SMTP id
 a92af1059eb24-1b5567a6eb4mr19652296c88.4.1795674267942; 
 Wed, 25 Nov 2026 22:24:27 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:24:27 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 14:23:43 +0800
Subject: [PATCH 1/8] drm/file: Define drm_show_fdinfo as NULL when
 CONFIG_PROC_FS is disabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-drm-fops-show-fdinfo-v1-1-7cb1d1a5d6ef@chromium.org>
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

Define drm_show_fdinfo() as NULL when CONFIG_PROC_FS is disabled
(matching drm_compat_ioctl() and drm_gem_get_unmapped_area()) and guard
its definition. This prepares for simplifying .show_fdinfo assignment in
the DEFINE_DRM_*_FOPS() helpers.

Signed-off-by: Fei Shao <fshao@chromium.org>
---
 drivers/gpu/drm/drm_file.c | 2 ++
 include/drm/drm_file.h     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ec820686b302..bcc1b47616c0 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -961,6 +961,7 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 }
 EXPORT_SYMBOL(drm_show_memory_stats);
 
+#ifdef CONFIG_PROC_FS
 /**
  * drm_show_fdinfo - helper for drm file fops
  * @m: output stream
@@ -1003,6 +1004,7 @@ void drm_show_fdinfo(struct seq_file *m, struct file *f)
 	drm_dev_exit(idx);
 }
 EXPORT_SYMBOL(drm_show_fdinfo);
+#endif
 
 /**
  * drm_file_err - log process name, pid and client_name associated with a drm_file
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 6ee70ad65e1f..6fc3d7060f30 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -525,7 +525,11 @@ void drm_print_memory_stats(struct drm_printer *p,
 			    const char *region);
 
 void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file);
+#ifdef CONFIG_PROC_FS
 void drm_show_fdinfo(struct seq_file *m, struct file *f);
+#else
+#define drm_show_fdinfo NULL
+#endif
 
 struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);
 

-- 
2.56.1.839.g22a8290db9-goog

