Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3140FC98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A2110E787;
	Mon, 28 Sep 2026 05:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I4JpBbcK";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC8610E787
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 05:39:14 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b1a806664so317959a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 22:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790573954; x=1791178754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oYoN39qS2O9tTjo4AMAAx7esJiOig4Qk9Kzt2+/v1lw=;
 b=I4JpBbcK7inNTRq+4O4BvRvULALfWidzisee4m8/c3HJY+W/2BXMEh6EqRrSrGc3wt
 /fMRs0OcgLd2Uk2cpBMJ7Ot/5+ZzjvrlFnl9eDdmYMpXU8a96oQwUYffXaZx5VxwtLfx
 Jajw02wK07PeWOdreqTI+2zvsCv8sOfCZnsAyaBUccWDEs8DJAKsQdBXMgVYXO3QDzXS
 Ip9QfI+ryuFVU0nx8ZIFSL0nHsNtouG1cRPAwR7WZ5nm/buPE/aFkcXN8dt5PkvVSKMA
 30bf8G1jsW00iPJ9Ur3WiD8IcxTU1zICBy1+KsPE9qmIDr8zMSqxYNDuwpdLw8cK+JHz
 c7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790573954; x=1791178754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oYoN39qS2O9tTjo4AMAAx7esJiOig4Qk9Kzt2+/v1lw=;
 b=t0NG6ZIBiLt5HKMYQUdWjvv9JFmOAJnuiTcOm0lEfUqF68NGlK4y96jGXI/SJqtwLA
 BNW6adWJo0FZir5Znoc0nD7s6bdGRG3eHclVoQbHX1YVtuZhw1y5eAr1GkSId+WomvOG
 g3yKTkyHWC3jqDoJszJxA4nM2B7mKk8A9/6qVbMCO+eNAhM3iz5+uFlzmqEA/NB0ElXg
 6N5k1zgNtJTvBc1dmK8PVXjgsLDSlIH8FgwmU2kkq4j1Wj+pHWFERjN0pnJuz+LIe/PO
 Xothfc1HW1/SsPTzYQBEAhxZRIg9T3c2grMD/jda05HxAnddq3UY/qmGtmHRHuvDKW/H
 syKA==
X-Gm-Message-State: AFuF++mYnykJ1Pl9FJhHEH2x05bwsAIoU3NMl3pN3B5C01yf3sPHqacs
 xsV2SMw5qnVvORRQQcOa4InI40z3S+/6y43hRrmA17zdfbvsava7LWn9OYu7r84j
X-Gm-Gg: AYBFou0hJpoBNKLL6XpaaFBuydsnv9wJ/SdBE737EJxqDhP6desk9yVRLz30xglkzno
 g4F6jrv7qcCKcrmbUIJbGcin/A0VYPHVOb3+oXZ/uUSyZn5F8ugbbhFEg3xcVnb4VKzB4+tPqjt
 GdOd9cgw4fal2+eHIus3C+VanZSh2Jr1yEsk5aFUWApW+eKJ8FXbV/cV4uR1mwikuiTKRwQdfn4
 fnIAobnHbSom6mQJu6rN4yHrtZvjzEiby8v25dRxpG5kv5vzSvxVsC593eEcydXUpnNDB3rJKy2
 9kRlp9ReQcgRqTOYeceizadYN/skj2FoNWHFI+X/r81urpbxwTqv0A87SUrs0tYD+gIasPbVY+4
 9W0P93ia5D0YXe8XpN+wh4roHm1/HN+SRQPaJaqVHMq6Ll10fYEQJGOCsTk7TF2UaQ+ktdVj6gx
 mQUmmCE6bYYV8RxQkahUBdRkth89/baPH8n5Li98jxbEZ3ozXASetNgZLr/cZh8DVZw156cN4bv
 DB/W7v/gdj7mA==
X-Received: by 2002:a05:6a21:1645:b0:3c3:2dc0:7cbd with SMTP id
 adf61e73a8af0-3de22b356bbmr12488753637.1.1790573954396; 
 Sun, 27 Sep 2026 22:39:14 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87febb82357sm3591121b3a.61.2026.09.27.22.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:39:13 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, freedreno@lists.freedesktop.org,
 iommu@lists.linux.dev, Dmitry Baryshkov <lumag@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 Bryan O'Donoghue <bod.linux@nxsw.ie>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v1 1/2] iommu: export iommu_get_dma_domain()
Date: Mon, 28 Sep 2026 13:38:50 +0800
Message-ID: <20260928053901.7270-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928053901.7270-1-liujianfeng1994@gmail.com>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
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

drm/msm needs to recover the physical address behind a DMA address of
imported dma-bufs: with CONFIG_DMABUF_DEBUG=y the attachment sg_table
it hands to importers carries no struct page, and msm has to translate
sg_dma_address() back to a physical address through the attaching
device's DMA-API domain to map such buffers into its own pagetables
(see the follow-up drm/msm patch).

Export the helper so modularized drivers can use it.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9af..330f9a79248bd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2327,6 +2327,7 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 {
 	return dev->iommu_group->default_domain;
 }
+EXPORT_SYMBOL_GPL(iommu_get_dma_domain);
 
 static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
 					  struct iommu_attach_handle *handle)
-- 
2.47.3

