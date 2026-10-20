Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611B606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rjui562k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD6F10F278;
	Tue, 20 Oct 2026 06:38:46 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C8C10F278
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:38:38 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2123119f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792478317; x=1793083117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SzeDh/DG7K/TRHa14eJVZ0wsnX3im6yxpMJ76+c0/dY=;
 b=rjui562katKiBGs7adDRMetj8J4HhrNTYhBvP1YzBH3QJP8ik1val8cu3Lk2HjSUhr
 YmxtmWgHIVVL1FXrKxxoI2SzsaorEFsm/dGCWEeECR3SV59jF81KzWjnebj7hLB3Wapl
 8jFB5DWP1Nr3z/Dgetqsxwg8ByN2Lq0AEhzGRdDGTUDFBaNde3ZlqJ+ss6xIdy1jDFZu
 AgsgzVegj/cjCeGneOEUlQKEjClutZMZeRX4q11wc79qdFwV0emYW+6TY7WZqXOAkcGT
 lA9GXWW+cp6mDaHx4WJk+qQPRw1BAhNYE2UF49FUp7foyiLSeI0Te949+xlZPOnYZs+x
 3IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792478317; x=1793083117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SzeDh/DG7K/TRHa14eJVZ0wsnX3im6yxpMJ76+c0/dY=;
 b=2njR48OKSDGfGLD8jmnGj/FSZn6ECsRiakWZPP5T4XieL8XuXE+BxZTDv6g4X9fxUQ
 3i85PG4hF+kRiy+yiYSuWEhLoeuFUuqnBcrVViMlLCCE9/xbobMEkRJ0lWxaXPwCI9hl
 tVpLwcGXQdp/jwFs4sbYGCfN9tjyZcJCIcg0zgoqCj2eXHlSUxOmZvwh6zihZUKYo22h
 HneAMo7xKqDbkyhg9yd13snrniTiI4yJzCTI3090kxK5DgnJmM1ZtsgCJqTS+89AfXJa
 AX3hkqTD+cNfv974usWCb5fo8hp3SccXZAt5JEajJcpHFDSalfXiBlD252ku4eCNbFhC
 H9Aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQhfNtJpl+zGvJNdSO7Z/Qn13hmtc8k2H3JsPa4RZj3aDt0bD8k2/OVyTAAUlP6C7zSEKnf3qgsoc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLIuWZA0VRK7/f73JED+r0906Ym1XzDv3c5MZYJiX1V7xuvlN8T
 wMZ6dQrEDO9o59WlUFOYDUUhqeJtNg+7ySFRCnbp//A0tDNzhRX/J+yh
X-Gm-Gg: AYBFou1yJyc0t+lao0lheUYCZ6+FqONOX9McIRd6MdB/tRht5bXjz8qGFj0vlBbPaHc
 BmYy3JypaoOjRIfewsw/aXv6JgT7Zm3RUUJIx/xJInfxBP2QA7f+K+apUC0fQBJ3gAkvySR9BHo
 79gpllFb57tZzrTi3NswMWwCgIJkrLwIS4Xw2uDZaq7gcJNMd247smWrztJqAGY2Cau4bIduIA5
 KZn8n/WvyVA4SraE1Ih9tcOZv8ya6B8xvGzFL9AoUmagWss38BNxhcjFRf2krpP0O+pfbttHZEV
 mTv5XzWY6yLF59AgO+6wSnPLVp4YXXy1LkqwfzpQK2icJc+ly3/oSrWpjU1NcL5JUiu2+dGSMM4
 r0leDkiMKPgPFOC+z61krkY7SegSHDqGEB/3efCzKIJfmOnIy0or4yX5FV0j1kqYAYvH8NWGFw7
 cHK0C+cnrgl8DA9pZ2djWYrNZLnZsTHSd+qLT0iXQ43jHcD9q41veunou0zGfbMPw12aJSf9mNW
 +2s5nBDWfpJuMQuViln4xAMsLBmpz+9cvIrP1ZNEbGrRyP8ZgE9SQRoaFVrEfR+XhzxmBSw4r6F
 KUCiKhZXvoiCZ61jNjgxcR6/06V9UWitoNtXsdcE0bMOpwm01ncKOUQjKWni5m+CFOEC5h1P04e
 XLw==
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id
 ffacd0b85a97d-48e0d27c1f4mr17275309f8f.2.1792478316869; 
 Mon, 19 Oct 2026 23:38:36 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de.
 [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 23:38:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 5/6] iommufd: Unpin the DMA-buf while holding resv
Date: Tue, 20 Oct 2026 08:37:44 +0200
Message-Id: <3ca8c42d7a597658329e77a8af92aa294f0dc4e1.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

iopt_release_pages() calls dma_buf_unpin() after releasing the DMA-buf
reservation lock. The unpin interface requires the reservation to be
held while it invokes the exporter callback.

Move the unpin into the reservation critical section used to release
the PAL physical list.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 59ee68a1a..85004a936 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1678,9 +1678,8 @@ void iopt_release_pages(struct kref *kref)
 					       pages->dmabuf.exp_phys);
 			pages->dmabuf.exp_phys = NULL;
 		}
-		dma_resv_unlock(dmabuf->resv);
-
 		dma_buf_unpin(pages->dmabuf.attach);
+		dma_resv_unlock(dmabuf->resv);
 
 		dma_buf_detach(dmabuf, pages->dmabuf.attach);
 		dma_buf_put(dmabuf);
-- 
2.39.5 (Apple Git-154)

