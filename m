Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987D606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=e84A/8or
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D7210E2AE;
	Sat, 28 Nov 2026 06:39:30 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B0410E0CB
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 06:39:12 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8a070781f63so4177303b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 22:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795847952; x=1796452752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9eubjqyEqSUf1SnweeCwXHyF/MyfNmZC7QvIQ6aTX4=;
 b=e84A/8ornlSfVGMzPjRdLFETc8vB81zTFkDJsnoilNFoNY7mVAuBp0xrExXDqvq/m0
 Xnn7TyUKiU73bPgDfllCqRT61XFNrtQSo/oWps0WE3Oj5OchLQBsotMh7AxhzUxoPduE
 +ItpTnmtrn3//R+GEqnZJDunXXj+E79hdG3JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795847952; x=1796452752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o9eubjqyEqSUf1SnweeCwXHyF/MyfNmZC7QvIQ6aTX4=;
 b=EYrVtFzRpHfX9yuzq8KhNx2Vyh8ArPLcpysk8KtG7DBMyvARKqwqIeoWxrpoGh3P+W
 e6A0xmCpamaArTM55qZ4OlHIveQE1H0cNbigz5j8+Fk+pD1VobF3OFV+2m2c5aeLKxer
 IzgEiV+WhPJ94wqZVV/bYlAV/KQ5K0GN89F5FCVM1zVX+6wzOSIl5C96/OgGTwBvZ2Al
 epMYjcNrnmRTFlBOhyGZR3H8hVJXHLbzkZRcPjUsHIj7M/omDL4D8IGZnP3FIhMBq3rs
 Go7GYo5Z30jVRFxKmYf5rG1i5eKp6DeuDJXNNWrROGuDJ8WhhQGNxNtx+3kfLmOt5LQ8
 o6hw==
X-Forwarded-Encrypted: i=1;
 AL+hErFF6zVOBxm4dMTHEsN2sA0ShwcQ0Ox8yFX+eNoodRAaqeeOL7kv3yu2/tTWCq0xl3cpriyLb39ErDw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/7ge4+w916a9ZcMMDD1+m3ItmTcxT9Z4ggECz9Cvxuh0dFjCMn
 MNlFQcS+wPALHdNikrEdjBtHgk+4s7unMJqxn6ApRnWXcrlGURtASilN46PItI5oHoA=
X-Gm-Gg: AZFdTZeqmBeaJDMkmWgjJUkFGMUqSErpAwjdEyt6oNehIR3oKiXnrWTNJ6dZnV1z7sA
 c0IYWd8V3R4RS1sLB6t18GrruTles2ceMrqd70y7fa8jCEUamvAlOQeZIQtHq1qnEvmj44oDHin
 rZYkoz5WxHTVX4Ekr8qf+dkzXu2LBc9e8KEprlcc2J2/pugv+bVEDPVJIQGClRR4yP5QfjGvaCT
 xSqR0HULCOorVkSHg5TIxOnnLGDu4lvYsCY3TId2Ll11gFIO9K4ufR8yoXp8gmra4D4pGEkE3IR
 ZxbYzIQ9rkiPRGKgKVzKDzQZ76/EZT6vxc+z3B6Ddrbuhz1SZr/GTd6Srh3oDcNU5dwUdzFToq3
 8UpOT57aaJLNcgKfKtT903WWUCDmNEEPZ5mKQiAXS4yxAOymT1hnGFuUXxu+CLHRgD81mBkVcR6
 nifh91GhSciMyTkfjjJROZia0CYmCSRpPnTB8mduUE8yavCKWjZQ1KVGZOvEAlcLt3op8O8jtXJ
 ua+9BsbTDfSzJHImxYlWV8bS99phJx5cGe1eEuhZ6lFBmlZ3mwxVpX7AuqOBpkBx9XRWLgm4SDY
 BCr5Q/VUVMpgyBlgd6petkfF82zNyyj7Gt1PhI/hmajHoVmJbtJgrFwFPRKvI/MwCIq/lVz+7aK
 +4UC/MVOma+14hzkEBpwa7H7+x6YDxhaQIg==
X-Received: by 2002:a05:6a00:3403:b0:8a0:3307:c46c with SMTP id
 d2e1a72fcca58-8c87cb4678fmr24975744b3a.36.1795847952011; 
 Fri, 27 Nov 2026 22:39:12 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077944bsm13939838b3a.2.2026.11.27.22.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 22:39:11 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Haoming Gao <Naixumogu@whut.edu.cn>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>, stable@vger.kernel.org
Subject: [PATCH 3/4] accel/rocket: Skip CPU cache sync when prep_bo wait fails
Date: Sat, 28 Nov 2026 15:38:43 +0900
Message-ID: <20261128063844.1537615-4-sidong.yang@furiosa.ai>
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

rocket_ioctl_prep_bo() calls dma_sync_sgtable_for_cpu() unconditionally,
even when dma_resv_wait_timeout() fails with -ETIMEDOUT, -EBUSY, or
-ERESTARTSYS.

When the wait fails, the NPU may still be performing DMA on the buffer.
Syncing the scatter-gather table for CPU access while the device still
owns the buffer violates DMA ownership rules and can corrupt in-flight
DMA data.

Only sync the buffer for CPU access when the wait succeeds.

Fixes: 525ad89dd904 ("accel/rocket: Add IOCTLs for synchronizing memory accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_gem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index e52fc6ea7cf0..dddaf9d2fbc8 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -171,9 +171,11 @@ int rocket_ioctl_prep_bo(struct drm_device *dev, void *data, struct drm_file *fi
 	else if (ret > 0)
 		ret = 0;
 
-	shmem_obj = &to_rocket_bo(gem_obj)->base;
-
-	dma_sync_sgtable_for_cpu(dev->dev, shmem_obj->sgt, DMA_BIDIRECTIONAL);
+	if (!ret) {
+		shmem_obj = &to_rocket_bo(gem_obj)->base;
+		dma_sync_sgtable_for_cpu(dev->dev, shmem_obj->sgt,
+					 DMA_BIDIRECTIONAL);
+	}
 
 	drm_gem_object_put(gem_obj);
 
-- 
2.53.0

