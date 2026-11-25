Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F6606A330
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YTI0XkDg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D01110FFB9;
	Wed, 25 Nov 2026 22:25:51 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA70910FFB9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:25:34 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-38355b03cb8so5977234eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795645534; x=1796250334;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RCCssxDP7VqyjtjkkMxKeVZicY7ZW2acPhjksq1uY6w=;
 b=YTI0XkDg64o/u71NfRbAWhPCPlk9Vs0qEUyK2suCRr9ghwlIURmocNNQpZCnC8oD96
 0q3IEreHiXaZ2tzVZI7NePTFvYCKteC407kgYO0JOcL/NYZ96Pd0/1qik+AKwJa5x8O2
 pe7sNXE3Q8CFExTCYdCZWrNc1NG+sKgve0wK2tyH0LOCUnt/xh65D63TJh89qC7EOHkp
 rnBzhJQ+zBLqV7xpgn7DmwDfrnCqZjNj9DOPFoqiepf6fX+SBneozz4rqKoJvCwaf/Gz
 I5lBkzKw2VJeYU7Ij83op7CAG45Xb5GrpIWNJFGPf8S6iBKICOgOSQ2IAj85BB/oDVV5
 8f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795645534; x=1796250334;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RCCssxDP7VqyjtjkkMxKeVZicY7ZW2acPhjksq1uY6w=;
 b=n72Z4koQi3H/GP+ecr/WcCZCVHiCQfnxwEYdCEsYUdJ/3t2dWY8agJjEicsOvX8q8u
 1hivVsEo5w8/yvvZkjF+Q+AFxlbFMiUmFz2vp4yJ+PIjItvh3mH0DRz58BJfLE/6LHd0
 1/Kxf2izfUExRUDOxfApatiCFsAFd+awiM1xLYSDpP5AjvC3mwl3M3m5LUx5m6NZ+ygd
 i30vyfdM/bJgkmCa6BgivM8f/KyE0cTlaLhVFHemxLg69BPpkj2sRw9O8/gEaOCpZMEy
 NYWaOwn8SFCqNyUgulnp9Ns8+zzkwhnrkS025mHr06L4GUSvWeOKdsPtIvKat9B5bG7k
 v0mA==
X-Gm-Message-State: APuU4Z8Ez6c+8GjRxQ0jz5h8uNSzk3qTK+ycAvKyCyiQ79hV7UA00kon
 dYiHL7jOKT73M2MmDLoKhpSMMnSys79iculsBOXnqpAbmZUAEy2/4TglsED81jPCdsdSHAx6dNY
 S7Q==
X-Received: from dycnn7.prod.google.com ([2002:a05:7301:1407:b0:384:71f1:1227])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:d587:b0:381:d92e:ecab
 with SMTP id 5a478bee46e88-3856f25884emr17876278eec.11.1795645533582; Wed, 25
 Nov 2026 14:25:33 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:12 +0000
In-Reply-To: <20261125222513.1446099-1-elkin@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261125222513.1446099-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222513.1446099-3-elkin@google.com>
Subject: [PATCH 2/3] drm/sitronix: st7920: Check drm_dev_enter() in crtc
 atomic disable
From: Elkin Cruz <elkin@google.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

st7920_crtc_atomic_disable() ignores the return value of
drm_dev_enter(), allowing SPI power-off writes to proceed after the DRM
device has been unplugged and unconditionally calling drm_dev_exit().

Return early when drm_dev_enter() returns false.

Fixes: 88b09229f34a ("drm: Add driver for Sitronix ST7920 LCD displays")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 091e80d8bda5..ea4566009c4b 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -580,7 +580,8 @@ static void st7920_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct st7920_device *st7920 = drm_to_st7920(drm);
 	int idx;
 
-	drm_dev_enter(drm, &idx);
+	if (!drm_dev_enter(drm, &idx))
+		return;
 
 	st7920_power_off(st7920, &err);
 
-- 
2.56.1.839.g22a8290db9-goog

