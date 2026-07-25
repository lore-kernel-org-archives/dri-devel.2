Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918DEC531FC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B1010E310;
	Mon, 27 Jul 2026 07:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FugZ3ADS";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1559810F4D3
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:19:45 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-c8c1ebd68a1so683532a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784949584; x=1785554384; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPm4vAPFuqHX+tZvYjtk0Fs8fzHRPkuRBc0bjXwe1GI=;
 b=FugZ3ADSve2AuwRn0CZDG/w+PJP6MjKJ+1T3uqdCZpBJa53RPkJlVp9IbktTXGHQmw
 jvX3DvsyfFGWPiuCuPM0k49Qx0DsHfwiwIJGPV5fgbNLZqf8btNWfh7drf5ktTd8gnsl
 hJ9g529EDyvmrUV2ZpVxldw5nKXj7Z8H+Z19ihgsk1uKPiYPjEc0GMt4aXaJzN59Yofp
 4dKFW4dNP6gD6u5O3PpW1Xj1BTjCMWeLcQBryCDwpIzQdQOjcIea2U+1bq9N0pYtz/kj
 DEfACPCyBbnaAh3fVYvh+vlaYPIfGUPO30cidoAZPAcKxOuBZQiYrP+S6FLlrqy9R+an
 XNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784949584; x=1785554384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DPm4vAPFuqHX+tZvYjtk0Fs8fzHRPkuRBc0bjXwe1GI=;
 b=XaLJKLl9k/UOCeFnZ4qwslVShfsb6vCc7+nU6McMBW04jiww6knLA9KcwYktoEUmUz
 baFAOFwHBNPi5GMGAGCdhUF77iaOUxlbOm5+JQy2hy0yR2asDhvBRqxKfLQs4Vnc8Y/t
 l08rM3UcYQPZYp9rTSGsBmdy3n4pL1DQ2IGrVfI57T42y77MIy+aCmIUHsmdG+Jni5rZ
 kKQlGXkyI6gfErBzQzanSYicQYeV5K1CDgFZdwDUWnYtgjKYsY3zv0Xt81graMYz9zR2
 Nf5GZGT4T0oUhcf5tc6zo5+8G5IylTcqdP8/bNBwwyWnGHnJ2o8D3ZEOjhRZuvtvt/VQ
 U54A==
X-Gm-Message-State: AOJu0YxlLHBIgb2+JQ9PO3JVnbcMtHtPfFx/CVYvpDx9cndvBQIothx4
 BAT6T6OmueXf5jjfW1gbrLBjcrQgzKfaIxPWHbB2RzHq3VD/2Nv2Rq+u
X-Gm-Gg: AR+sD125Fl6DkSAc8Y/5WrdupSgVHAWJTAWyn6uOYBsISfqZa4w6Xabxr/uI+odz71q
 tB+MTiOCdhy5lNFoj+JaNcI3La2hdLXNZSTfluNKeKfq2Tf2UmLYYkhpLkqZzTAkF/nMR8C4d8L
 20FhyVR5AwD6oGvTV9ifP4xAjlmMYhd/e6y8sMNZvTDYYHa7mFM5MK9hd2uDf/008NP7d56daCU
 4UtOhzj3AEJqTI7tqeUz/dcErocc4zgyKsOHQjlQ8qsyWoDbgEa3Q5LGQdqYIQxcKMIsf08vj+d
 FNWkhj3Sb0IT7l6ts7bKo7j5jddaOdS/mHZfky8RVuW8aPak7Dd176zOESwea9ooA8ZPaWnix+D
 bRPtz210CmPleWLOkGktZKtn+t97OTia8+hq6wRlMPrPIml9ngD6Ow8k=
X-Received: by 2002:a05:6a00:4c11:b0:847:8b0f:2508 with SMTP id
 d2e1a72fcca58-84e5942eaecmr647092b3a.13.1784949584567; 
 Fri, 24 Jul 2026 20:19:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:19:43 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:49 -0400
Subject: [PATCH 17/17] riscv: defconfig: spacemit: k3: enable display
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-17-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Enable the Saturn DPU and the DP/eDP controller as modules, matching the
other DRM drivers in this defconfig; the DP PHY follows through the
controller's imply.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 74ba5acc12a4..c38853d69d55 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -191,6 +191,8 @@ CONFIG_VIDEO_CADENCE_CSI2RX=m
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
+CONFIG_DRM_SPACEMIT=m
+CONFIG_SPACEMIT_INNO_DP=m
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_FB=y

-- 
2.43.0

