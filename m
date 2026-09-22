Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999E5C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82CA10EBF2;
	Tue, 22 Sep 2026 08:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lMhuQH7+";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099AD10E19E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:48:37 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747f066d8so13480005ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790045316; x=1790650116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JQsnO6nBZnTmHd9o3wzHwpj6ldm3p0l1ScGQLsRwCts=;
 b=lMhuQH7+ux0roq2xFXvBQRtqwerikpdkR8PbtzifspTBX+RHNPa3cEgR+lCKUT/N8j
 vKD7ADrZM+CzFkxmgR1iKWtkB3b4stO/3LsLwD5oS+rT2r3DYzV4wyYMdACg3FW0Eqn8
 yFsoXY6JBhxtyaU75gHU5wmqTGz3y1q4tSoR43OY6++Veo3AyKoEV39WOpsaRQqJrOKR
 Eng7KafH5krlEERvm7knLjXTKA52Q1UuTBKeDblZt9cADTKaD86oxvfljxNqYvY+i68W
 tstFiqO4XVCjV168EG5o3z8OTZJ4m7P8sAQzOPYgvvBq7s2yA0EzSwx+kgBqXcsYl938
 pFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790045316; x=1790650116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JQsnO6nBZnTmHd9o3wzHwpj6ldm3p0l1ScGQLsRwCts=;
 b=U8R3PKH8PKzi2B5bkeLIuAV+ybQRfPqoCjOIJIr6UzbipqlH3b0fDyaObrEoOWCuAx
 QU3Lrv8eUazMFoaOWSSinRN5EpajssY+18r6AS4GMvkYl16j7t5aazXen/2prwuoC3VY
 L8Zk5pTkWnnm+nla+6nsuIvgknyOanbEmjW4uoHRp5V9gxXSCbvsz/B5ZxiHp101L0zO
 y9IKhasPfJqZv4z40HJZQx2y4NJ0UBqPmVTv2hUmvSOKbUMVX/px8v29TX4sL2r393P8
 90tXZeSogNbANn6x63eEuHtUFwnj4rHrZjGuNbB9enN/UA/gUy0kx8kMpPFNDhGuG8BS
 lSJg==
X-Forwarded-Encrypted: i=1;
 AKwUvByQqHeDUz8h/Z61pqVHuF/n3qX17nDu3cqqOfm/AezaCnliZBmmkr9OEsxBRk63jvgIGGcUc5h140Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k60y5ldpoKsjp78B5N5YnY1pRwLakis9C0ivN5mK7vMv3AYLJ+
 cQY9+kXHrBBzWaDezysQxc/I+R9zLScMwPg/d+ti6XETRxaHvXsQGjdZ
X-Gm-Gg: AYBFou0f8/ABXEPRrKawK5jJTuaqWuAYJkUum7WGdrUOPf9CzCGCvtNFmUbFDagqlAh
 6qZR6+ldd67py7DhS8yoIiwwe14r3vMwbC73sh2Br557cVkt2ucXmHwal0O8uSsScue+CwUCYWt
 VmuVFQfp//35T8dtBNU8c1M8AG2qe/OUeKylaDcBUSNZvoYvfsWsKF3xl0nBBkruFmIN6q6rNaA
 QHH4yXuuITC71BlRqiQjfRUp8oyQuUC+T9KGHTb5yycDbsqsxzrCRAANQGiDYqY3YvMhWTMozXI
 fvx+XzRy3UfgodosCkIoB/QVwY23yyZXXiB4PmOMhP9P/gwKBd1KihCJC7HnMJBKrYWUX6HkZ+o
 DqLE9wZ/0MrZ5oeicAh+8vPWldbjVZuCVtMD1gaNj2elNDWuDQfh9Ebv2sdlZ9xM+Y/mn+x3giT
 yElkcz85jlGAOhM+kmBqPlA5qXNbBy1jwEt6k5UpGPl0efrWlOgXUHOkpW9E5O5SmrY1x4ekIEq
 pYLn2KD
X-Received: by 2002:a17:903:2ecf:b0:2dd:c100:251e with SMTP id
 d9443c01a7336-2df59a72ef5mr12835995ad.39.1790045316497; 
 Mon, 21 Sep 2026 19:48:36 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d02e929sm1619035ad.33.2026.09.21.19.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 19:48:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: [RFC PATCH 5/5] drm: bridge: analogix/dp: Adapt the return value
 changed for disabled blob
Date: Tue, 22 Sep 2026 10:47:20 +0800
Message-ID: <20260922024724.191412-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922024724.191412-1-inochiama@gmail.com>
References: <20260922024724.191412-1-inochiama@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

Check EOPNOTSUPP for disabled helper function as the change in phy core.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 30c0c0b41d5a..8e26cd772482 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1360,7 +1360,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 			 * phy itself is not enabled, so we can move forward
 			 * assigning NULL to phy pointer.
 			 */
-			if (ret == -ENOSYS || ret == -ENODEV)
+			if (ret == -EOPNOTSUPP || ret == -ENODEV)
 				dp->phy = NULL;
 			else
 				return ERR_PTR(ret);
-- 
2.55.0

