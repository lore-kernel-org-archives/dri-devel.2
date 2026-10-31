Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097D606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S8nWJ7XG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3396C10E02E;
	Sat, 31 Oct 2026 22:59:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D300A10E02E
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 22:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793487558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8ieTUMljOJ7qpikwY+C9+nNipul/W3dfq2M+DvQXoA=;
 b=S8nWJ7XG0pCeHHQEki7U7NGPJ4iAo57v6IfSn8MdWnvuFRHF1xw8vlwljpkrbh4m3Mc4+G
 Xeafm71w8wGlrkSjfwkhEv1PzS57k5N0v1+EOuUI0Ftf7mzk/G1BxcG7lU8hE8iu2sTS42
 vZgijILnym2huN6GrbZT+9AML8opqvo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-lbYATbXoOkqJPxGKZsGfHg-1; Sat, 31 Oct 2026 18:59:16 -0400
X-MC-Unique: lbYATbXoOkqJPxGKZsGfHg-1
X-Mimecast-MFC-AGG-ID: lbYATbXoOkqJPxGKZsGfHg_1793487555
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a4654add56so15103485e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 15:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793487555; x=1794092355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v8ieTUMljOJ7qpikwY+C9+nNipul/W3dfq2M+DvQXoA=;
 b=u756xNPKwCNDjq0Bky0z2xZdn91oed+00GK4doTIeusM76WFbeFVhXl2iZH/qs+lDK
 5Sx6DPpqYq3rfcaSF8O6hpvLWEpgIjxQj1aNpjgUQdSl0C+r5kf+9nl7GBPdbjH5xWOH
 DF4syTEtDUec/jjc2/6fAoxwWqfkvDFDZHbX2g0RYUr0/8Bo9RY3+nHDv+Qf2Pnmwj6k
 P0ObLCoHR1IZV7+X/aDb5a4OeekfAs5Yo7pIgoR7a4jMub05YBc9nttjs3+/t3nLivw8
 0zTkvGhed+Tt4HiTu/8HEFV/712yuUyHwGAqKL26aEyRu9ENkNRR8jOCelsY5t+fKSvz
 OMEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFGEts/+WlzbjASW5RXQJpvVns0MrPWafvvZkxmzLn7AHNkeU5YuqRZsmU6l2mZ0sIzxvgytKG1iU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJdH2pemD39aPoljMa+Jr7s93gV6bZQ578z6+SBKjv002wYyJn3
 ge1AX0ubq0oH/Mf9oblvd68DuGlIYiifxLsHBdnpOI0Utit4IFDcAnTIsYUfCk4T/i/CECO2rL6
 bztisViQJmpk7VEe+H+G/+MRvZTDDAezlRz1/xbZlXl5vwMgb7XSjS/zGDDaeI63DXDwAKw==
X-Gm-Gg: AYBFou2d31LDMI2tN8hnbngrbUqTB9AVA5xOqRnuK8fv2fvupypuFIs74ziFnVpQn2E
 Jdgt+Tjz8dT4gruoyNZYlUGDQg+JH6c/PpPbSsi5RgfLsWDSsRZCJ3IyrKvz8aNWXQ4nWmNGqZr
 uMFYcBdbg+JEzaC69zP/RoxASV74bsLwqx9WvD4r9wsZ05RMI9XFh4XViEJ3vH9Rl/ZaoWjYHHf
 KlaIm/Cfi5h7L+arU50F3wM/VTOCafNPOEyoTpzhu49qT0ELDBmlVgiSj1dA2Fc5MbTO5zlaXdG
 oohM2/mDXbmjOSrHBgesgdBSHMY2u45475E/6IgKLcdo3LeUpe+NURqvxquVKJgVzFflaM/BpCh
 MyQaVVvmPPuWorruYuTuX+mhLc2tRlvE7qD5NiIDj3iKXVcGMztciHD7YlanNBW0Eaf2gHiNHye
 ERMG6ZdVxGpH8Jg/ZBlybi1VfNTGjb8gmjoTZtAcCDy/MQI63IvA==
X-Received: by 2002:a05:600c:3b8f:b0:4a6:42cc:bf66 with SMTP id
 5b1f17b1804b1-4ac16acfdd5mr143439715e9.11.1793487555507; 
 Sat, 31 Oct 2026 15:59:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8f:b0:4a6:42cc:bf66 with SMTP id
 5b1f17b1804b1-4ac16acfdd5mr143439425e9.11.1793487555156; 
 Sat, 31 Oct 2026 15:59:15 -0700 (PDT)
Received: from toolbx.fritz.box
 (p200300c1df20b900aff65c27eee3dd92.dip0.t-ipconnect.de.
 [2003:c1:df20:b900:aff6:5c27:eee3:dd92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm204535345e9.12.2026.10.31.15.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 15:59:14 -0700 (PDT)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Sebastian Wick <sebastian.wick@redhat.com>
Subject: [PATCH 2/2] drm/vkms: Use drm_dev_unplug() for ConfigFS device removal
Date: Sat, 31 Oct 2026 23:58:59 +0100
Message-ID: <20261031225901.3200167-2-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031225901.3200167-1-sebastian.wick@redhat.com>
References: <20261031225901.3200167-1-sebastian.wick@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5GJlOeeQ6NBJNfeazsNAX9YEWIQO3FWLjipFELeCgjk_1793487555
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

VKMS ConfigFS devices can be disabled while userspace still holds open
file descriptors. Using drm_dev_unregister() leaves the device in a
state where ioctls are still accepted but internal locks can contend
with the teardown path. Specifically, drmModeGetConnector() triggers
fill_modes which acquires mode_config locks that contend with
drm_atomic_helper_shutdown().

Use drm_dev_unplug() instead, which marks the device as unplugged so
the ioctl layer rejects subsequent calls with -ENODEV. The previous
commit added drm_dev_enter()/drm_dev_exit() guards to vkms callbacks,
so synchronize_srcu() in drm_dev_unplug() properly waits for any
in-flight operations before the teardown proceeds.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531d88..716f9c966c21 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -259,7 +259,7 @@ void vkms_destroy(struct vkms_config *config)
 
 	fdev = config->dev->faux_dev;
 
-	drm_dev_unregister(&config->dev->drm);
+	drm_dev_unplug(&config->dev->drm);
 	drm_atomic_helper_shutdown(&config->dev->drm);
 	devres_release_group(&fdev->dev, NULL);
 	faux_device_destroy(fdev);
-- 
2.56.0

