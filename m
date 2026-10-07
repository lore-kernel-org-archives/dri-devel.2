Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBCACA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 05:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B77C10E47B;
	Wed,  7 Oct 2026 05:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dcuvSz99";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF2310E47B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 05:23:37 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso9723135e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 22:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791350615; x=1791955415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x/R+pCgI2rA8DLvVd3Hp39WUeD8ue9hp8M4OoGV9/5s=;
 b=dcuvSz99ozBLUY1U7Ay5jbMdsb7cL+0D9HvQeohmIS4/m5NL5wclxTEfkRLO2SyNsZ
 QTpBQus3A/6tFNSyhLEdRVCjnSXQDVXBS4z/eHRXbqBSqeu6avBxIHYQtSWjB/MoAIvt
 aTdsYcDazNZvkEhHMmAlM3QE+IcYE12t7RaTxBiD8YfuZHLI/iIyPEg+Pu8h4s474pNi
 3ATfWVxL0RnBF4ylX6kcnK6V3lCYYtSmzbkh+gkGzrLh7KoVPD6MDmNcjyt3sifpyPa8
 gkXMODdGEVYMZpR8SzbWmJX8VbkpFvK+zOEyfQsGOPiNHrvX4rw437Erpf1n9qd2S47t
 LkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791350615; x=1791955415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x/R+pCgI2rA8DLvVd3Hp39WUeD8ue9hp8M4OoGV9/5s=;
 b=JeJ5hCvwc0NiqwUr+IwdTEFqSqfGU41sf9sS4rNPoRtwWbJPKVg+yectv94mVOnnE9
 SkKMxFLkXoeoeRLWFsGuXTJLn2+CUgrnQJWhVB4wnNoZpYRpkvY5D0/N8fbi1JHDocE6
 YIvqFlzrsLVRP4S12xKd3lWfpEn6HmZWYO/X83nb2mEga3PsNqx6Z5sMmCW6LVUFBPDx
 04eHy8IEc9bnJS7p/yZJ9JIZ96pxuwQvn3aIOOdEzxkoPQ5RpBcgZex1Zb7OHko7bhHD
 W3YjE7j1aO6kD6nujI5isM7Ccbrgek24wcC3jpYHAGM41CDSzUrEOl7iVo6EqrT2eUmI
 qNPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyo4otCHKdWnW+oBGU/FJPmzPzhPl0553sKjxW40Ew9z6wOB0GyOdgDBLh6wHtbbS3Zs4qKnfTw4E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kOeZAwuLZWkkt71ykeYBU8FdR/OYhbS0UKWWJHolfjcNQjMu6Y
 xvwSLpPt7uZt4eNKqrZ9wztS7WHdW76JvpJo+Sny/hvQs3lcKXolgptL
X-Gm-Gg: AYBFou1UQYJ+VZbkSegfEVRr+86AnQtEYvKoUhqCXZvj11yaEgUDZ7EGr8Qr7rhNy9w
 iXHKn+jLZxrvdMe6yqid8taOSHLtpPP2IPU0z4/BzU+iFrruj4tTgrnzUiJil4q7QLDz4/dHwe+
 7gmDOXiss4bc0prFdjuCxiwBqjMfPpJUDkER9TtGvVAQtFq1ORczDHfwi0xpin0tT8tFxOkblTZ
 3Mv84Wuwl+dDZG5wWvCtRVxAmvxkhxFWnPueWkrQIQn/IxpxbRWBGblacVV1/Xi1YKUw4aA77iB
 lXDyqRaiAhJyeUCCwYMyjOofUTIQ2/+avDXCMbOpopZFUoCIB6e/2silzK8OSV6dvFtzDJAjLoQ
 5pxOXprrI4nLMrOvP/UlEqgiKdkdn6ueoO+WFZhZipb2NGAZfb+khWksJY8/UDa5HvJuCKl+A4d
 hTxnmS5GcCX4bN3MZoaLs3S9s93E3J2K5IbkCSn0zXsIi6AJm1AFzc+IvYhp746sazMnshb8kGc
 wM3hl1zFWQZcUkepN+VsArOLP1i8Q2FufAVY4LjMpcP8GiEVyoQOpa+r5iJ93RIjA2u1Hc1yLkC
 qmhQw8HQb7476TMjHopmgrOga5Y+bDwehzaqGCl+2m0rfYbDiBLC/4DHJ+0ybWSKL7kt5igYLFI
 RsECrngE=
X-Received: by 2002:a05:600c:c16d:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4a18067f68cmr11531475e9.34.1791350615217; 
 Tue, 06 Oct 2026 22:23:35 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a1e1-2201-60f4-32e0-4d59-5772.310.pool.telefonica.de.
 [2a02:3100:a1e1:2201:60f4:32e0:4d59:5772])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f54a55esm34907585e9.3.2026.10.06.22.23.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 22:23:34 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFT 4/5] drm/msm: Convert iommu map/unmap to helpers
Date: Wed,  7 Oct 2026 07:23:30 +0200
Message-Id: <20261007052330.39998-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261006132545.8BFD51F000FF@smtp.kernel.org>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
 <20261006131000.81501-5-robin.clark@oss.qualcomm.com>
 <20261006132545.8BFD51F000FF@smtp.kernel.org>
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

> By passing NULL for iotlb_gather, does this bypass the IOMMU driver's TLB
> gathering and flushing mechanism?

Yes. On arm64 QEMU/SMMUv3, unmap_pages(..., NULL) returned 4096 after
device DMA populated the IOTLB, but the next DMA still reached the old
page. It faulted after an explicit IOTLB flush.

Using iommu_unmap() invalidated the translation:

	return iommu_unmap(domain, iova, pgsize * pgcount);

> It appears this replaces iommu_map_sgtable() with a call to __do_map(),
> but there is no declaration or definition of __do_map() available.
>
> [...]
>
> Similar to the mapping path, is __do_unmap() actually defined?

Patch 3 defines both helpers. msm_iommu.o builds with all five patches.

Karl
