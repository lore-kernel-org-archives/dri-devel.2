Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C86606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EZ4TnaSG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A18C10F276;
	Tue, 20 Oct 2026 06:38:26 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B30010F276
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:38:20 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so2371637f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792478299; x=1793083099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WaoGSBUw+3Jzr2stHEJVabNKgV1ycEWdou5OEyDZ/EU=;
 b=EZ4TnaSGdiH4iM0TOm0hl+NNlIO1Vs9TNhy7LdqWn9s6cUhMq1m5Upjc7K1I5wYz9B
 7mIrxrlUFk7lCtJsnJI0kawzs2+MAryV3BJS+q+2y2C33q8fhJLarwwakUpFidjAkNLE
 QmFlecMq4QzYaA/inOZyH1lt06ThbWkq8lZK1G1k2EqBFNxzrOSjR0adQNj28bntzCrE
 q8IMvCBUIwZZqCWhPtblR34YNxIbUP2RY02lq6oWAx+HO0KXWCz4JBgvfbK/eOcu3BoP
 kPWwA8lNDjtsDuiWNqv+dtKxRlZqrSN3ElUJ1GPtZ+qZrqYBXMIhqaeWCkcdwHKTvHE0
 aOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792478299; x=1793083099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WaoGSBUw+3Jzr2stHEJVabNKgV1ycEWdou5OEyDZ/EU=;
 b=MC3U0KFSC8xqJK7RHzIS8uWu+5nqEM2QmCz+CUObRSpDfbQ7ka7UzBll1SqySf46UE
 b+fIGh8mZwGCPqdmP200uofwZRB79nnGHsBqVsUn4sbZaaeX9BvydMh3473+Cv+w9Y6r
 qndCGfYMtwQO3l3xvBpAZJZ/em7ZDrMKQ2R8UVWvR0zv+Nbr0+KDRgXSEGYr0vjNdYOR
 MLFYgFv3fldj5voKO/o7yQWXWC9kj2LAwgXR8QbViNfmZhvG6MGNz6FRLgQphMODi/Z1
 46BkmXhgE9RcXHJugI3rZpkeCwJ8YHzDKGZ2s0nT/K+xUEz/o0ORmrmdSwpTF+GGI/nA
 BeBg==
X-Forwarded-Encrypted: i=1;
 AKwUvByuiAdUoVl9cbBd4hHOE4UCmFCqu51pcSWYQE7xrfVHsC9OtnNCN1srjJ7XAd4doKbmPPo25pB8eiw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLdHStCqKdDgW4rAABFTvsFX3PEVS8sFLh2m22rrxJxpEtwmm9a
 AP5JvXeU7IfuR3c6ow2tgw8hob+1vKHq7L2UdLV7hIPUoZrqnmCIXQ2P
X-Gm-Gg: AYBFou3TUCqh/lLoB1qyZXZQVG4u4mr8lpULMIH+zHlJngtc28k29G1M+tdvvI/dvHj
 8QIg9pjvKu4DkIEFYnScQ9rV+bUAXe1JS+OhmNSDlX9V+kn/C0OHFQOyW3NmrfDH9tD7+B3V1pR
 Y9KNL+CH38xRFTbOZUxzS6sUo72PPPaG60NYr4/XWzeS9MQrBjfNJUFIbj4kZ5/OdL9Vi2EJUE4
 lbijXjY2xbJ1JNUMBFs50ybMIJp0SgyToXdSkRlJwPnrWmJCuUX4SgjfUEyG7EnNujNmK6BIiUv
 1t4eXzB7UH7oJD9Nfm8sFZc3+H5IqbO0sNRP4l5mgp9cBxRQKbtnUDP8TfDbwdLMG/CZunigWLE
 Y8RB+5nouacZZXXlMn9W0fszYXIRSfeg9PO52tbjtczMXS++j19G0FLdzEhI3DQRLD0wCrGvFfV
 NEB0qQvA5UCHYY2i+iwYbkfFQgndIO1dIWLLe/8coI/tfCUykuHEdPQA4Ka1fmCRYPFrJJG3TtH
 TucBZB0lXbAspfQ9bS77rKBSjpDiRXrtgfNYeF4ECAQhAnCIA/nSkntiSDX/qkMEpUEjFR0OLqz
 3QY8ov8UdUJuCOb5v1tEWY4AMqRkEadYMcIs32UKPDScRNxstLIEZKtZw2ssrCnfLBoOpjQSzPX
 MI2krGNIZht7G
X-Received: by 2002:a05:6000:4694:b0:48e:3d2:44b1 with SMTP id
 ffacd0b85a97d-48e07fb6991mr13514200f8f.52.1792478298615; 
 Mon, 19 Oct 2026 23:38:18 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de.
 [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 23:38:17 -0700 (PDT)
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
Subject: [RFC PATCH 1/6] iommufd: Preserve DMA-buf pin errors
Date: Tue, 20 Oct 2026 08:37:40 +0200
Message-Id: <9a3912ce01cfd1205daeb13b57de47aa8f27f076.1792477872.git.kmehltretter@gmail.com>
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

If dma_buf_pin() fails, iopt_map_dmabuf() replaces its error with
PTR_ERR(pages->dmabuf.exp_phys). The newly allocated pages object still
has a NULL exp_phys, so the function detaches and returns zero. Its
caller then accepts a DMA-buf pages object with no attachment.

Keep the error returned by dma_buf_pin() when unwinding the attachment.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 98c2a8027..0b32c65af 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1510,10 +1510,8 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
 	}
 
 	rc = dma_buf_pin(attach);
-	if (rc) {
-		rc = PTR_ERR(pages->dmabuf.exp_phys);
+	if (rc)
 		goto err_detach;
-	}
 
 	pages->dmabuf.exp_phys = dma_buf_pal_map_phys(attach);
 	if (IS_ERR(pages->dmabuf.exp_phys)) {
-- 
2.39.5 (Apple Git-154)

