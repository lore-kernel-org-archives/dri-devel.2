Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3517CCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B4910EC43;
	Tue, 29 Sep 2026 03:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RV9MPczd";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1E410EC43
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:28:44 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-399026951a2so451689a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790652524; x=1791257324; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ppa/5bvyDHu70Z7WWJJ5TYTAyJSoEiJO45Y9vEXZ7Jg=;
 b=RV9MPczd3hVc02FVR/gj05lTZQDGhOvWRZu0oW2vZUBQHiGdWo7JFGdZtQyW0CU/XR
 zlw72In1BMDWDMMpdBcoCaqWm5i6FLM6tIST6clh9HIIp/nfuArz0TMvY1Xn9hXwRc93
 givV3m0umVN1DmqXExm/aOYvNRGbM5kZWpRYrj6afOz97xASar0fEUAW7jKN90T0Lpbz
 kpT/9X3eRs7ATlarWaWBYo7aPmKQWhPeuANnQUlseAblycOFuwUzeXr4zSMW7mqzux0Q
 Gy3s0TzLYcUWVvEoCZsaVDXVD0bqUBlcHEOZ0DnQXrOhpyhx7ztlqzNSpi0ZKn2hw5CK
 NYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790652524; x=1791257324;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ppa/5bvyDHu70Z7WWJJ5TYTAyJSoEiJO45Y9vEXZ7Jg=;
 b=kWm+umlpZ5Lih574QdnzTWSYXpHRSYWEqMwaMlvUVUWc8QcNpniZDm6vAElvyYIi98
 bUeTgyTVRvMtJ/o7UsOk+JFmNaOqL5PtosiKYw3lj6fuEDCB/DtYdn7evxSzu9KBEaWL
 EJUIRBjJLBWMzCvthz19pw8u1uifLEDbqfq/1KIDoEbMqq7bsiop1/NXvRUh4h7/GaYw
 A9GhBoUq/KV9vd4FRaiVZAOf1cBOGB2O31HVaQFJxRrmVUTDqkppYxceXw5kkZgRed/m
 4u2k7Gcb/9o7IR2TGv9Qg08s1GZFt6TITkZfAr+DcmGFKr0FOoIFpSCRw4s77UccJ2GB
 ENew==
X-Forwarded-Encrypted: i=1;
 AKwUvByuJkfPP7TfDsHpdToWi61R4EfOwn7wv8iTk19IEVZDlCWFXrkojzzTGbt62dKwHJwW+HpABRP7tV8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKzpKDbFamg8koedm9KNilupXLA4yff4SnCqEufLdT/iZ71ffVo
 S+zTxJNmKOcSs0p4nT9B6BWU+7yi17uqv96U3oLqlXsw+YqW0q77oyT/
X-Gm-Gg: AYBFou2A40h4ncuWAwfMYNJ5O0Tfbv+V/Yb4GYExCplAPQbK8jVImk6HjHl9WG1T1pC
 5CqKJRdYCj0U/0YrtZRqnB3lqv0dits6v9ZeIAVq5KTAOwnQyDBqMCN1L6obKjRSm3KiIl0reI0
 PG1c7ykJOPfrmZA7knmXculpaQUYwIEHw6woax4XU/2HDB/+UmQMTVYWDxIWkLRncSC67Ak5yaK
 H4SBJC8BwxW0Mtm/tZG4p4YSioQqOnYmORGQFPEX68r/io33tk0e/tGEHUZk20LoLoH8IUzFwOz
 C0NIb1hjIIf2uk1kCgYurYvQV+nLnkAqcokTmQO2ca/FbaDV4a2/XsD7XuHD0WkStXK9eWbm/yW
 oMALKSpZc+ZaCREtkaRb5BTtBZvnBHKGrF8zWo7Vi9Lake2cp2xCVHCvncGwO0U4zNS/cK2deie
 AGTWWS305ZmDkRTHI6KuTaNxl2YRocMzzKgSrMOx+eQkIsPjNdggINTTnEBAZQGEIGVsIkE8QYv
 5ZZ+5QWRIYOCC8=
X-Received: by 2002:a17:90b:3c4e:b0:3a4:88c2:32b8 with SMTP id
 98e67ed59e1d1-3a488c245e0mr4141496a91.1.1790652523654; 
 Mon, 28 Sep 2026 20:28:43 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4986e9656sm934089a91.0.2026.09.28.20.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 20:28:42 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Clark <rob.clark@oss.qualcomm.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iommu: export iommu_get_dma_domain()
Date: Tue, 29 Sep 2026 11:28:35 +0800
Message-ID: <20260929032836.37312-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <47bf9a4c-2a47-4e93-bcdf-8d953c9a5ab8@arm.com>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
 <20260928053901.7270-2-liujianfeng1994@gmail.com>
 <47bf9a4c-2a47-4e93-bcdf-8d953c9a5ab8@arm.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Robin,

On Mon, Sep 28, 2026 at 12:26 PM Robin Murphy wrote:
> NAK. Read the comment - this is an internal helper for iommu-dma
> (currently the only IOMMU_DOMAIN_DMA implementation) and is definitely
> not for random drivers to abuse. In fact it should really move to
> iommu-priv.h now that we have that.
>
> If you want to do sketchy things with your device's DMA domain then use
> the public iommu_get_domain_for_dev() interface like everyone else.

Fair enough - I'll drop the export.

For the record, if the msm side of the series goes anywhere, the plan
is to capture iommu_get_domain_for_dev(drm->dev) before msm takes the
device over with iommu_attach_device() - at that point the device's
current domain is still the DMA domain, so no new export is needed.
(Christian is pushing back on the msm patch itself, so that may end up
moot either way.)

Thanks for the pointer,
Jianfeng
