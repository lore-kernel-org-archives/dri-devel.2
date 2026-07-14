Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0458FC44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B80710E466;
	Tue, 14 Jul 2026 16:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIzsnp9f";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA3A10E080
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:31:19 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493e497643fso6012885e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784046678; x=1784651478; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P+8jCTwgu5velxazBPk9XTR+aKK116XL3VK7F2AJFKk=;
 b=hIzsnp9fhSa+jXPpzmrAIei9Hb5V+OTm3a/jyWYa4ofiZtD+BoDWbEmbBGGbwSlO4f
 fi+zKP/BS85s24gk2gzBqpJlkbxLu2OpJ2D4weTw+kJsS5u+cud3mA1+3dG/H+bsIp6k
 cOih9uW2O7ubu/NZkC6K0eaDHM5AL5xKjjq1e2e8Gts3uIZBZmN115o+kObCSWDbIHs4
 pOPNJKRJE6LrmMhIyxodyAaTn9YMpXbp8LqE6HU0+REycSMxoTt2y9sxTr/ZhqIdFdbN
 wJ5xlX3LRv7XcQ5wq6RQl2MRRIgv5jSXermHoUY5QNEKkhppWjMpfG19i4y3pOQ9dA/w
 pI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784046678; x=1784651478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P+8jCTwgu5velxazBPk9XTR+aKK116XL3VK7F2AJFKk=;
 b=O8fQyUNJBBtFRwIhxeMJLUAg+AoJGjhrdsyHJXl3msDDXuZqjPzEdROTaMXKxKStQP
 R8/id/UmZNOjrKfNTSPJje0BL+FsqMBxSSgyp3KJo1OWT8k3p2Jqa1F8zyDesqfx/mg8
 PBRd/USsSSdoET1RlolQHgMMrYuu5JfkorXZUAxq//RDagktI1RoQU+QehLfG704+DNd
 ezI47wmBM74GyAs73bziRdY2S9IeC514oOZbM2bWn8jERAXgfmJRlMYfNcIo9Lw1FZWm
 amfNsGnxekQY3e9TfgJ13E6KdsQ4RTC8oXxi5vlrSAGfIvOBVg8hxE4kTAHD3Nl6tjsZ
 O1cg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5BFZ7qlj0+wNS6bTLwpwu2Cm/U8DNOKeggb7vlgryVF6rj+yGTqDQWEQiNuteQzmFzwYf65toHUQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpjSVdYKT32/HXXCbIq8t0APmL17STElYK0fL33uLsG661QGOU
 9fo8Qe+rm6DJXNmysaamcgoNpUTflMSxKp85m7IwQnB1PQvpM+2WVbUU
X-Gm-Gg: AfdE7cmsrXdsfB3XptN9rj3NEz4ShA/4nRWftWQYc9wZxMBbTD2XAEq7t2BfpaKv6l7
 PA5HovswDgrDWGFCau9pm6H+1jdSCm5T+V9knbuxPAVJzTGh6TXl8kM4mwDA4l8V6Zec4m8n3dU
 2UNLpGmGB1T6oPHdkjrPIhtf92bSyFMyxnBGeEhFtCWu2mfi9eccTemO04SLqlfahQZAKgpJGtu
 TvEt3v96hF2fpeF5UXL04LdG1HV8dQgM4fZAZhksNYgIgFvpreKNVIZcJ1vtgvRrqEeQ4cE0wnY
 JsfQoHfRsvYCQsun9AB+wDDBUBKkMhE6nrsqVclv5eA40KxAUd7A5UQ/P/hTn7ZjRFrOQLcIGVx
 b4joSLA6OxQficryyVtJ81fz574YaaYCfbQnk9b5Jl0LQnh51WYv5Gd40c2h25QsONznlhOI/3X
 VcD0xFf3JYXzJ77a8jn2chhAm/KDZZD+3tKhhofEDXqpqpuNtg6A==
X-Received: by 2002:a05:600c:b90:b0:493:b967:178d with SMTP id
 5b1f17b1804b1-493f881d05emr148460745e9.19.1784046677536; 
 Tue, 14 Jul 2026 09:31:17 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:af6d:c23e:9b4a:128c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm406414175e9.2.2026.07.14.09.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 09:31:16 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: return error on truncated firmware
Date: Tue, 14 Jul 2026 18:30:55 +0200
Message-ID: <20260714163056.22329-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

panthor_fw_load() detects truncated firmware images, but jumps to the
common cleanup path without setting ret. If no previous error was recorded,
the function can return 0 and treat the invalid firmware as successfully
loaded.

Set ret to -EINVAL before leaving the truncated-image path.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 986151681b24..39fff094ebb5 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -829,6 +829,7 @@ static int panthor_fw_load(struct panthor_device *ptdev)
 	}
 
 	if (hdr.size > iter.size) {
+		ret = -EINVAL;
 		drm_err(&ptdev->base, "Firmware image is truncated\n");
 		goto out;
 	}
-- 
2.43.0

