Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505E606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=GxRjk8Gs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2538C10E0CB;
	Sat, 28 Nov 2026 06:39:38 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FD310E17F
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 06:39:15 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8b58d6f67a5so4326649b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 22:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795847955; x=1796452755; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9gp1NYV9MXlZIke0oUQdNHBR+MQ+XNi8DFIhrHDnoJQ=;
 b=GxRjk8GsBxM1vXYOryhfEomMMGH6JnP0tXg46JTcHp3ZUm+2sU7ouAxN6IeC2hQCnm
 WoBNaz24kbEFU0jcqL6buLpA0aIHmzxa23kTBtJhVhRfoNDVI01q7PDP+3k2oCjH2ilm
 fli6KtP7no9meDPO+H45aGh8240TmvDSdxU94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795847955; x=1796452755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9gp1NYV9MXlZIke0oUQdNHBR+MQ+XNi8DFIhrHDnoJQ=;
 b=vvBvSMciR5zLDKCcmt0659jOuXN7ykh5po1jhVPOhpAPzUUkD9jLm/Cb8ebEhFKwmO
 3t9WKZ2AgFW5Ogor9LzLpNiXIOliibZ5KXEiUqAUnNQeLLOd7q5yBnpnw2z4142kJyLP
 hl6SLig3DuUgcs4jbt+Fe2TXn1WH3ZMHLuv1bRJkKWeuW84+T1jL0gLE1Vq+3Lw9uWyJ
 rK4/DO08b89Y36HyMVemhbt7UdtdLgEs31XdLjiwRizo+gPRYPSqAj3C57hbqc/e/+Zh
 7pchEO186XERp3QcLLty/cYfj7mKYpHBJSNMk/lsinIZAAPrgH4wgozrI2lqFDIjMQyg
 W5AQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFNH2gMQjFr5lGUm4SxlZy55YwwC5zrspgCQFlsT5QLHPbCSs0+FSkg6/CR2QgBCd9zZPI3wITSBUQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8TRMBwLnc16rnTF+TwSxB9kLJLYDpdQZylE/6rMQJcdpyiCKLk
 C212lfpEuRPAthJW+rhDSt38L62o20VeSeBj9IAm+OjIOdnIXXiTyNvE4A0hcSq7pjM=
X-Gm-Gg: AZFdTZcaiYcUVVwqrD5k8JPk8kPj+DGahaFRm7Q8vJN0ek2gMvZSkW+bn65/Fpbn0bg
 bWtE/5SnYxRhUeyS1oRcG3/rtAjiYLTMbtpAXJNR8gU79JNt7+TumzQpZX1py4A7bxU6LkoQqKj
 3acqo5z1L/aGgf2FM+cnt/1Lqj/HaT0/lGwx38Lxwzb8wK/g+XACR6STbAVe+akth7BgtAl914s
 i+rYYexbeQST9neNJv0FNtnfMgnhlNX8DqG2gnFAgkX84Ff1REcZ0BKt6zn/Bz4H4si73rIqume
 W1Zsb4vfeVzBU7R0diW8hCFSUKlgosKyIzjSH9x5z7FxvcabVY/NTCkh8jp8/9N96ya6vb6S0e8
 cflaxu+af15D8rAEDQljrPt1rHJtzRySeuhax+8M5cAXe3g8lSREGrkU3dH1iIt14g2ChH2uYGV
 78C6K7CcgCu/hbKgOFYLXArSsgocY2z0XeHWuBRqcNRTRafCbcDMfZXSsjbVAiNR327jJykuenB
 +wlNbrOkXq2gSZ90bJee60/EBhg2ifBluj1nzOqZXFmjwEcioWpEMYRdbKwm8NuYYjFsnMNmlUF
 FZOITbY/wvaxghfinpMFGoU4wDDUBIsJblCbTmCgb0FeVYHi7mdWNoGFN7Hh/6aK0hfir0TsJc7
 /Gst+E8cTbvR5CS7fVvoD0BmNQBrLg45BMg==
X-Received: by 2002:a05:6a00:368e:b0:89e:3742:3e16 with SMTP id
 d2e1a72fcca58-8c87bdb526amr26434266b3a.18.1795847955449; 
 Fri, 27 Nov 2026 22:39:15 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077944bsm13939838b3a.2.2026.11.27.22.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 22:39:15 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Haoming Gao <Naixumogu@whut.edu.cn>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 4/4] accel/rocket: Wait for read fences in
 rocket_ioctl_prep_bo()
Date: Sat, 28 Nov 2026 15:38:44 +0900
Message-ID: <20261128063844.1537615-5-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
References: <20261128063844.1537615-1-sidong.yang@furiosa.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DRM_IOCTL_ROCKET_PREP_BO begins CPU ownership of a BO and has no
read/write direction flag: userspace calls it before reading an output
buffer as well as before overwriting an input buffer for reuse.

Since commit 4d8cb7be620e ("accel/rocket: publish read fences for input
buffers"), in-flight jobs attach DMA_RESV_USAGE_READ fences to their
input BOs. Waiting only for DMA_RESV_USAGE_WRITE therefore returns
immediately while an NPU job is still reading the buffer.

Wait for DMA_RESV_USAGE_READ so PREP_BO waits for both write and read
fences before transferring ownership back to the CPU.

Fixes: 4d8cb7be620e ("accel/rocket: publish read fences for input buffers")
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index dddaf9d2fbc8..c5c08da72f76 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -165,7 +165,7 @@ int rocket_ioctl_prep_bo(struct drm_device *dev, void *data, struct drm_file *fi
 	if (!gem_obj)
 		return -ENOENT;
 
-	ret = dma_resv_wait_timeout(gem_obj->resv, DMA_RESV_USAGE_WRITE, true, timeout);
+	ret = dma_resv_wait_timeout(gem_obj->resv, DMA_RESV_USAGE_READ, true, timeout);
 	if (!ret)
 		ret = timeout ? -ETIMEDOUT : -EBUSY;
 	else if (ret > 0)
-- 
2.53.0

