Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C23CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C067410F163;
	Thu, 14 May 2026 08:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="E9IxzMqI";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65CA10F163
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:26:34 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c796163fac5so5663165a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747194; x=1779351994;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t5YZ5/RDTjOVXbQmmL0DlnfYt163pcXn6d4m+SJiGG8=;
 b=E9IxzMqI/II/0NHt90oPRV1SrRKOH1x2lCVjL7JyBc0d2IPnli1cGt/M/z+nTGs+qp
 gCvOQF1bZWS1ObHcNzr1HzoRYqkBfJk0YZsjoGU8aD9K3+dDzIYuEAjiSijDMBR0xmJv
 xDnvONoxjka7pDCQg38wAY0qiNLW0eY5uFPrlXFEHq8QfZAjR3iYFHZUnpf9NfCyQYcU
 hI+DUR4DxH3ntlvsr/tPdUZq2qYe4+MgzHwHso3emB33PbkdVGNwKHoGGdzUgR6ELno6
 viLWBwzgwcz7UyVyve4xeYgzD4QA+8eKx79ZierdF9arwBKsWLk6N8RVr8Po9UKqDF8a
 I5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778747194; x=1779351994;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t5YZ5/RDTjOVXbQmmL0DlnfYt163pcXn6d4m+SJiGG8=;
 b=nHIBhXX6bM3RWM5W8arqO8bIqyiBrmVQCEGqKifEYhbez7WPAQefBaisQ3vyoogXoW
 Ke98FF0CeeHr+IP/mhYyHdxfD8CUzMWG11G2+N32IHmpUgJ4Ct4XVb02fdO8DE32gtvk
 ndE6uW7njyYbQ++9snVecz+3eS41C6dAEA7QqgJJEoi/mfs+72Guxfobm4dIlY0trttr
 /GpTMwe3mpYx14NyfAzOkDYTU3lWZkPVba/r3NmCCROSE5RwwxSgYCaf/+Uv8wadD5n2
 RUQOaZq//qph0Bd4H00KAEGbXy443LclzeBOcNKR1R8Sr+E3t7S3oOHP5RsIMenlAvK5
 3qQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lPyThtfIG1xNxQxllK0n60/uGLHOscAB2rJ28H1Kj9dk68c4nTQG9uuDfxaaZK8OzyXX6UkgZpa8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHSiprLiGfwRHSU3BUxdi+fKL5qEsp9utUbJfhnO9d1z7EHgft
 2nHxRtqDOzf0OPTgR7VW3jUms/lV3nADy4UMP6nQ6WP62FKyAx19dS0k6KsDR/exNF4=
X-Gm-Gg: Acq92OEXgJQWaHTkNTnYCRqoeVwFLPU5G9Z/AUkgeRGEhPFh5j/MllVotiohZeEZcF2
 gqn2WShAtorSTSjGZmGmpvM62o9v0E8U+rrcUYcWHF6berkZ5a5T6EWHYkXuTyjrQAwo9uadrbS
 e3ans6PSvknX3yDQ4G4y51cFNbMbAdVt+S0awfPIXtuLRCyp0fznPYpN25DDy72jd6UlDRt3Qpl
 nlWtDi7byTIjqOkZXWUcMkKRds+ZbSyFGCv2WV+duU+mXV4YYvz60pxgY5u5+lieG5ji8oe8z6n
 ZHzILGuwZ3FwUMIrPx0nhUj8f5XrrnK3/FSZPO71d32FvVbHwERx7uXoQVltC4TAPNHDiEssK3a
 4lm2kAPdQC/TEFmq5UStboLB2DqcwfVzIjNhiqBBOwQRZ38jwLBKD8AkWgv1SWeMFgx1oD1y0+q
 nsTZXXmhx9VEafKJHHKe4sZwnkOKqPKuYfDq/xmowdmSxiAURciICW9UwGw4GZNRK/jBCTnIQeK
 6frPU0s79YQe2qpCv3NauHDbcvE2sEJtDJxiWj7bAoJ
X-Received: by 2002:a05:6a20:4306:b0:39b:e6af:2d8 with SMTP id
 adf61e73a8af0-3af8016e0f6mr7940447637.4.1778747194198; 
 Thu, 14 May 2026 01:26:34 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:26:33 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:43 +0530
Subject: [PATCH 14/14] fbdev: sm501fb: fix potential memory leak in
 sm501fb_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-14-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0
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

The memory allocated for info->edid_data in sm501fb_probe() when
CONFIG_OF is defined is not freed in the subsequent error paths.
Fix that by freeing it in the error path if CONFIG_OF is defined.

Fixes: 4295f9bf74a8 ("video, sm501: add OF binding to support SM501")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/sm501fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index fee4b9f84592..1ee7842517b8 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -2048,6 +2048,9 @@ static int sm501fb_probe(struct platform_device *pdev)
 	framebuffer_release(info->fb[HEAD_CRT]);
 
 err_alloc:
+#if defined(CONFIG_OF)
+	kfree(info->edid_data);
+#endif
 	kfree(info);
 
 	return ret;

-- 
2.43.0

