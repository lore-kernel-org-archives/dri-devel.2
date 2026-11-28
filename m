Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D144606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=bCC+tESx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F383C10E28D;
	Sat, 28 Nov 2026 06:39:16 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B4410E0CB
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 06:39:06 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8c20d68c83fso5137315b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 22:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795847946; x=1796452746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJUrKT1/8wtWEpCHd0NA5Y6u4vvqC4B4ufA7sT35KDU=;
 b=bCC+tESxUosFI29RNyhIufXiW7f9mbwFfx+0e3pEBqiwC3Gq6H/FyIwl5syy65dNAz
 96cajLljtG3omxl06cXz0DFWHSpVmiCzV9aPugXZ+R6TM8XF3YnbdQFOd7DgP21X75xE
 inePNClxuTd+ugkIJfrHdO9088N9LIJIYfbLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795847946; x=1796452746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xJUrKT1/8wtWEpCHd0NA5Y6u4vvqC4B4ufA7sT35KDU=;
 b=JnT2ksyoaIUfeBhJYaoSCEm0ux/HneoDcD/rHu53528TsLa14rrdbjxK8SPKAuvqYz
 RaEGamHEEI7gX32OhuzJaNlXP9hSDlndo5J2u/UfdFoFNnjqSvnlfkqOpfOv+qL2VDSu
 9ukRPbNnWdTdTgGsOhyRltl2ROC7j5SijKP4RTj9TFNPfnI4E51bkE/j+JKU/+FyXkUO
 Fp6KyGZ2G9tMdMfvh+SW+n5OC/Nj33bokr/1SRHCEnomMS7ZklTghEfL6V/Hy6DopYIW
 kX4dzUuLC6Tv+s36lw7t4MsoWuiBvMZHEqC/W7ocSZupiJRy8Qbo9viMncJkfJUIJRC0
 K0XA==
X-Forwarded-Encrypted: i=1;
 AL+hErHv0xuNz2XdXcDk+tJIreU0TyXkTyJZBLt5oR9taZXKEDsHbVBIvcUoKEo9sC4vpl9uganBWp6is0k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+w8lZc3DH8zlKPSMbHIFEPZLi8kQx+VrVCmqeSII7Wa+fZifwa
 TmK14mBvmXSREBW0FfVx7lb/KnxkEt98pa6hhoL9f8PJxMI06fuEcPnGtuk6g/s/S48=
X-Gm-Gg: AZFdTZcuEAtJC4rihWgcNd4Nu2Yz4bTHvn1yBwxOqUXWXfp2KwPouMHG20n42ISstrL
 i91N+RTDcPoUTr9OWp1lPbYZ6m/FposNQzEp8mQQY7YoYgqs2n14fXhhjCy7pNFywfPkeimS0ly
 zWrMfzo/hrwNrnCycLqJxtBsKbTrUG4y3BUBuPZfisksL59cQsIeWVGTmzR4r+Ftq5Civ/f03m0
 RUxH7QrTtPm5UD8LlsUXfdA+iMbmsCzkQ72TNr/2AclLYxclu1QFOzZvBiUYsv/eSovSIGbNTJ2
 nWTzGla8UBNzGmdMQCCm2YOZv+pMQCqzcgPwLizf1TkvVup3eqXTC2+BaauHZoDChc4yIePkzms
 e3WC4DTaQC6J950vl9phTr8Gre1apl5r3u9caHs250P5qHbLfAcsMDiiO82g5ad9A7fk1aC5XrG
 Y3pPJd9zH4TxHeUi8wevI4R/+C4WMBNfusdxIKyhHdDInqMELbeT+f9iQ3uTsvFRmVpkCvfevJp
 rY1RYbHR64rmjvLvnhl0z4E3SMr2KX0UpfPkhxvxBN+R0FjfEItcG9JpyIsFGcs2Ao7HZu4iJ1E
 9ycN7OtgwfeM/HfviJi8pJnziIkWg2bMQU6wxSawLBt5fVM7rRcsiFfkTokApMFk3eqJ5AJB9yL
 xIDEvcStZrRag
X-Received: by 2002:a05:6a20:a106:b0:3fa:53f1:abf2 with SMTP id
 adf61e73a8af0-4014de5db77mr21193451637.29.1795847946035; 
 Fri, 27 Nov 2026 22:39:06 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077944bsm13939838b3a.2.2026.11.27.22.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 22:39:05 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Haoming Gao <Naixumogu@whut.edu.cn>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>, stable@vger.kernel.org
Subject: [PATCH 1/4] accel/rocket: Reject zero-sized BO creation
Date: Sat, 28 Nov 2026 15:38:41 +0900
Message-ID: <20261128063844.1537615-2-sidong.yang@furiosa.ai>
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

rocket_ioctl_create_bo() does not reject a zero size (or a size that
wraps to zero on PAGE_ALIGN()).

When args->size is 0, drm_gem_shmem_create() succeeds with obj->size == 0.
drm_gem_shmem_get_pages_sgt() then calls drm_gem_get_pages(), which
returns ZERO_SIZE_PTR from kvmalloc_objs(..., 0), and passes it with
n_pages = 0 to sg_alloc_append_table_from_pages(). That function
unconditionally sets chunks = 1 and dereferences pages[0], crashing the
kernel with a page fault on ZERO_SIZE_PTR.

Reject zero page-aligned BO sizes with -EINVAL before creating the GEM
object.

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_gem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index 8f802df3e0f1..9f3d85e3dd30 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -66,9 +66,13 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	struct drm_gem_object *gem_obj;
 	struct rocket_vm *vm;
 	struct sg_table *sgt;
+	size_t size = PAGE_ALIGN((size_t)args->size);
 	int ret;
 
-	shmem_obj = drm_gem_shmem_create(dev, args->size);
+	if (!size)
+		return -EINVAL;
+
+	shmem_obj = drm_gem_shmem_create(dev, size);
 	if (IS_ERR(shmem_obj))
 		return PTR_ERR(shmem_obj);
 
-- 
2.53.0

