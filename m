Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3455CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2084710EE11;
	Wed,  6 May 2026 16:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="crbGLEGr";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA68210E55C
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 16:14:17 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-59dea72099eso6693688e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778084056; x=1778688856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QpS9p5To8P4BftdAlsDaBegfX21bw2fBoqWrx1dYiXE=;
 b=crbGLEGrzV5vxSjVbmwwdPpQY1VM27d6TwwNfSqTS+NVzThiPVCVEtpPCfaK3IF6pP
 Uaup+Yh362AaLnugzCCFqcgpBnjJChlQI8e3COtNuDh1iRAMsBkfHKqw2CEc7Z8JozN8
 H325/trzHVOtCEXXTFWbxB0MPRb+DtXdHAANiozP57HbqjvkwzMuHs1yUivo7U/iUFez
 6828K0TVnrEHStHjpA9Bt6sO1FJhOc15Lu8ztbeUi115ZOYREY82AW/VnJuJdgBxtmp6
 H1MD27lMhK6dwEfmjBdj6S2k/w0UyuSkGOoKawWqZoLQP545q5ZnspJr6A4/U+6kezJj
 EXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778084056; x=1778688856;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpS9p5To8P4BftdAlsDaBegfX21bw2fBoqWrx1dYiXE=;
 b=ft94Tgru2V9apJI/tAk09KFsVDFNLz480uU3xgfQeRGUmG7J1yMFQsiC+0+Oh59oro
 vRolex+sMQ3sTlgHbFN3NojBJ8WFPytRT2X24FVwQe8+3xhQH0Iv3O+Ck33ArCSgTV0L
 /zFx7rVzIvn1DFcOmQzuyIZqWlmjJf2Xg89Yy+DieltnjHSlPoXxL0sZpapKH7woOeY/
 D6RGtdD91x1DxLRd0Kfjb9qPHFpuGvW0ygGMVKCzD/AKmap+4osEw+n6YQDXCd807QXO
 AjjvCXbJyvGr+HARVjyGZhwPrvXw4Onas8nATfW07Tl+PwA97qmNIPg+L154VhdP0H7I
 T+Dw==
X-Gm-Message-State: AOJu0YxdRgdZt1jGNMcICJa6zjZbymFSAiUrhxw55F23ESWGXYtBfCT6
 H4NwjbryUVxIeT25e6iGIrsvQ323hEwiVcV1s5ONfGyY9YYHt2Q78dJl
X-Gm-Gg: AeBDieudfOwB5QStjlBiPbquJ/ZAscWhTXPgYdjzXSlrI5sk22uMAnVei3wmTYMuZaQ
 lbhjeI/ueYFaCAp80Loyx5S3p174n3dJ2olkMPn/fvhimbK+82dC/nq5+HHVdVpbar5bXmvwpC8
 UAdlvinSdFwnVsXcPEQXklP9V5A68Edt0xN1/gboOsaxslFLXXkCingSDrKQhAzFWcu3SR5Chun
 mLc73V8P58a+OxIHyRj10oNwgh0c5p6N3su/0Hw2EGEvysnissa69rtzi8xpzQd93/E0N/B8Ii6
 nuYBOHe3dWlaPxxUwWNXJu9V1NCOQNTH4RpPgpJmr0I/uQNlQCkc46UBEf68HpFbcymjb/tqOI6
 wj6wtmQKca92QidHO2Y/qafJtF3ztJzbEabDCpz1Pfq9TjqEgEUp9RukDn6vEvDH/VTLPlFC+cY
 KRBoWJQjef+mMm9kY9PhyvaMpAk5zTj5QPn1ixdVeoEf2S8cb05QAXoRTCM8HcInHmykXwQo8hL
 Q==
X-Received: by 2002:a05:6512:308b:b0:5a8:89c5:2c0f with SMTP id
 2adb3069b0e04-5a889c52e35mr1306160e87.25.1778084055726; 
 Wed, 06 May 2026 09:14:15 -0700 (PDT)
Received: from [192.168.2.20] (109-252-156-195.dynamic.spd-mgts.ru.
 [109.252.156.195]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a86aa3d540sm3844372e87.17.2026.05.06.09.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 09:14:14 -0700 (PDT)
Message-ID: <9af23def-ffa7-4f68-8aa1-ab080b6c1c4f@gmail.com>
Date: Wed, 6 May 2026 19:14:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] media: nvidia: tegra-vde: Fix iommu_map_sgtable()
 return value check
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260421-iommu_map_sgtable-return-v1-0-fb484c07d2a1@nvidia.com>
 <20260421-iommu_map_sgtable-return-v1-4-fb484c07d2a1@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Content-Language: en-US
In-Reply-To: <20260421-iommu_map_sgtable-return-v1-4-fb484c07d2a1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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

21.04.2026 07:02, Mikko Perttunen пишет:
> Commit "iommu: return full error code from iommu_map_sg[_atomic]()"
> changed iommu_map_sgtable() to return an ssize_t and negative values
> in error cases, rather than a size_t and a zero.
> 
> Update tegra_vde_iommu_map() to correctly check for errors from
> iommu_map_sgtable.
> 
> Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/media/platform/nvidia/tegra-vde/iommu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/nvidia/tegra-vde/iommu.c b/drivers/media/platform/nvidia/tegra-vde/iommu.c
> index b1d9d841d944..824d2aa80a43 100644
> --- a/drivers/media/platform/nvidia/tegra-vde/iommu.c
> +++ b/drivers/media/platform/nvidia/tegra-vde/iommu.c
> @@ -25,6 +25,7 @@ int tegra_vde_iommu_map(struct tegra_vde *vde,
>  	unsigned long shift;
>  	unsigned long end;
>  	dma_addr_t addr;
> +	ssize_t map_err;
>  
>  	end = vde->domain->geometry.aperture_end;
>  	size = iova_align(&vde->iova, size);
> @@ -36,11 +37,11 @@ int tegra_vde_iommu_map(struct tegra_vde *vde,
>  
>  	addr = iova_dma_addr(&vde->iova, iova);
>  
> -	size = iommu_map_sgtable(vde->domain, addr, sgt,
> -				 IOMMU_READ | IOMMU_WRITE);
> -	if (!size) {
> +	map_err = iommu_map_sgtable(vde->domain, addr, sgt,
> +				    IOMMU_READ | IOMMU_WRITE);
> +	if (map_err < 0) {
>  		__free_iova(&vde->iova, iova);
> -		return -ENXIO;
> +		return map_err;
>  	}
>  
>  	*iovap = iova;
> 

Acked-by: Dmitry Osipenko <digetx@gmail.com>
