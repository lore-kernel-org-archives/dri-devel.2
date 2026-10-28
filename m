Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F30606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y+vSERIw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGidbLW3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9861710E4F4;
	Wed, 28 Oct 2026 01:15:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4EF10E4DA
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:14:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S0iuQG3274153
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xZH3utzkTV32x5e3Qo7yc9QK
 lSSV4XGUFUs3fU/VUmE=; b=Y+vSERIwAKZcDLiMG2qxIfjdEWYbo7A036dCT/dE
 aug6zLuixgg+G0du54YZ8eLh8j66I4gk97XD2Ju3GXe/VsAKA8AAaZVJ/chcsu/K
 p42DyppHFHITrha/JroAmgpwDTajQrLTqrooMQJ7isegPzIfFy3yurB8Atna+/yE
 EXksK+X1LX10lKWuk6ROl+RyAxWROTJ2xjulw3WW2oEeG6Z6BSTu+esvkUgu53mJ
 5rnShGoN69TvP34c2p/SPVl/we9HgIejyQi5KgvmgnPSxIzfIzb+sWcJi40Vjwi4
 C4tSe5W3pLHP/99fEgyQYWgcD8A4+GePfqYNBnId0E2vBg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g1vfu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:14:56 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5ec21d5bf78so160522e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793150095; x=1793754895;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xZH3utzkTV32x5e3Qo7yc9QKlSSV4XGUFUs3fU/VUmE=;
 b=FGidbLW3rxbpBrVITlGeQGcGIqxz9SscWolAvREXBgwTcUkwTJr3btval75vLwx8/w
 /2adDiplOh5L8gFfE9IPPW9WoGZY7487uL/VcPq5Yu4kXM/7FmKPTEDZ32O+vUEs6AwA
 s05TIakV+RhlZbf2VxaPZ59XswX6dwKbUPNIaCCTcflGV93PIpmo5LOVhRwOQj7JAxn9
 Xt+hJL/KX/auqe9ZsgwGAaqaaY3kM7TeIJo/CNZ2oMmMhtAYUG7eB+WDInGFBt2AZDJq
 6UX4t+yLhqtU1HQu4nlaIPvTs/M7PKXBgBLxWzOqSkZMYQQ8UTi47X50t3iPbk3niySO
 tdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793150095; x=1793754895;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xZH3utzkTV32x5e3Qo7yc9QKlSSV4XGUFUs3fU/VUmE=;
 b=gj+OEWftSjqbob0nvv0R4BdCxNbH7B2yxauQTqPXpdOqIFeNVIr1fZdtDPaz8RfTSO
 QSLdjWjgB3vviCYy/2y8XAkNgj/9BYGwLyl+j+Ixg+TJEgFdNEQTHOt7l+UIXdHM39Y0
 4WJf1hGNXBf5jxSSuSUt9DJOR46S6uRJ0wdU638ZC5DABw8zLm3TwzYObV80P7HNVI0s
 /o9WSCpCV7lAzcrwacTsrSEtOB4rNJepQQZzBsuAMjZepdXK/ssT3Xn9nazoV/u7mr1S
 Km6ONG5MrRHeIzsNeYHaDtAujDaLmSDJ4BgBWzZUUDA44XiGcAfdHU4L7v6nc/SLx1Pi
 Bf5w==
X-Gm-Message-State: AFq9FYKj0LlHBcn4V/g6GBtDIERsPo8YMiKJUSYMcKEdGAbDlEvTy3kY
 sit/mGRpIw5FCTt1u4n7P1GZ0ifDBL6cJrW5gK03n0bAc9lreukwvm/CXy+kZJAGJNh9UMTLUWg
 m88RyJAK/5Sagv90obG97Za949UuM7fWe8jsrCp13luJnr/UVRG4afJot4XBqRNzmdaESt+0=
X-Gm-Gg: AYBFou12dPnSJ5pvjl/4vfHanwUFloCxGbJhxJ3gTyzikPWLGLACAM8uCFNwr14plzF
 /IqXyL0c2ByxlW5qjVZKzbYzeTzt1i/76DVkWyYV3g/k4ieBic6IcwsZEkKMfNSeqjc0Sm9YVgC
 MPvPKaM9eXnlskp+B4Bq51PvNQEIBFTcJrxrfqxHQI6OL+jTES1Ch5olTHQXhht6C1+hSNgjSvv
 CNO1DtTn7Ohir+3SCJXXb2CXJ21Li4GLHndRVMR2HxLpWqmWiQ0tKywJgddQvi/rBns9x3B3Msy
 GZ7iNJ4jKrk/q6C9rCnxrOlkk0srH2Wh4dDNybQq7IdkNB88zUYtemJacuHBj/1MgRyLoVNI4Yb
 SwHMER0hkhMMlEfrVHTuvn2OXhTbYm+PFyHd1dEqR9nC4GSVPRdHQupv2XJSVSJIvB6eVU2wgxO
 6tar+nffBNWJ1kiZjAxYGRKeSAySi7SaUHOSqDynN+NtuIgRvxvszyjKGLs2qI9Q==
X-Received: by 2002:a05:6102:5688:b0:7cc:ccb:ce5a with SMTP id
 ada2fe7eead31-7d03a5c5b97mr394304137.28.1793150095368; 
 Tue, 27 Oct 2026 18:14:55 -0700 (PDT)
X-Received: by 2002:a05:6102:5688:b0:7cc:ccb:ce5a with SMTP id
 ada2fe7eead31-7d03a5c5b97mr394300137.28.1793150094940; 
 Tue, 27 Oct 2026 18:14:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3d9esm27236441fa.26.2026.10.27.18.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 18:14:52 -0700 (PDT)
Date: Wed, 28 Oct 2026 03:14:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] drm/msm: Convert map helper to use dma-address
Message-ID: <wxfx4nhwdx6dud4ahy3rfz3btfto4t2zor2pjbotlqpglvwolx@jhnm65bzecnq>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
 <20261027230452.130031-6-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027230452.130031-6-robin.clark@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwNCBTYWx0ZWRfX9IthgCudGcUZ
 JP/5420weO15z/DQ/XEyE/dVKWWgyiCOepG1M7xxInhaho1jZSD8Cw1iht68aH8ru0mXcYv9LYS
 E6BFFvQFKN4hBb2W7CKnETfeq+AnzjpyzZ2OsQURRmxccFT+AWa42UFoR5evPwv+s8sW6LYAp52
 zjGaUiU+kG7YowHf4Qa/hZOlZAwDxlg0u75w6vJ1xidfm0XYLPaM+G81NU9+a/gC7OwTnwa0x+2
 EykzM7W+d0pUwVu0tE9zN0yuvrZqe1zmSUysrNNgEmLbyc3WOMoABRJMnVpRiCUpBzXpUTaEPIZ
 soVVjmVTleZOAnQ5yVfnM4pa3sVZm4oy+RSUKHbFMyZ6X2PalSOnT+Sphv9JBNVcz42aC8T6sdN
 dk3yFViZe4DZNByMVhKuvtFWpEkQ9s7RD9YRF78vbl12z4qdIfIJ+fSFZ8pa0nv55ucfktCzNIk
 iLFbac6xkAk3hxnfbyA==
X-Proofpoint-GUID: oR-QRn82PtdQQ5NPvKhsLa4cBj1GOpyE
X-Proofpoint-ORIG-GUID: oR-QRn82PtdQQ5NPvKhsLa4cBj1GOpyE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwNCBTYWx0ZWRfXzRVbFjhCx3Rt
 vonzLJviB6fr7aWJSv6GQXc/qXsq57NGsRW624t+7KsiCLliy3arHd2VMQMGnK6enWq8/ElrruF
 DfBSNeLh7jGuRDVwGTNuDA1ukyBdDz8=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae14c90 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Uw3JNNrttYxbrt0Y1o4A:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280004
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 04:04:48PM -0700, Rob Clark wrote:
> Now that we have everything unified in one path, switch over to using
> dma addresses for setting up the mapping.  This avoids issues with
> CONFIG_DMABUF_DEBUG stripping the pages from the sgt.
> 
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This commit seems to break GPU on db410c (which uses qcom_iommu).

[  104.954564] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
to idle!
[  104.954932] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
*ERROR* gpu hw init failed: -22
[  105.958559] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
to idle!
[  109.082571] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
to idle!
[  109.082670] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
*ERROR* gpu hw init failed: -22
[  110.086572] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
to idle!
[  111.098576] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
to idle!
[  111.098674] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
*ERROR* gpu hw init failed: -22
c[  112.102576] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for
GPU to idle!
> 
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 479e5450a4dc..c2950d32c507 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -153,9 +153,9 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off
>  	u64 addr = iova;
>  	unsigned int i;
>  
> -	for_each_sgtable_sg (sgt, sg, i) {
> -		size_t size = sg->length;
> -		phys_addr_t phys = sg_phys(sg);
> +	for_each_sgtable_dma_sg (sgt, sg, i) {
> +		size_t size = sg_dma_len(sg);
> +		phys_addr_t phys = sg_dma_address(sg);
>  
>  		if (!len)
>  			break;
> -- 
> 2.56.0
> 

-- 
With best wishes
Dmitry
