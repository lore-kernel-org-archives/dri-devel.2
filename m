Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CD2C88E64
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0653710EA58;
	Sun, 13 Sep 2026 22:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lz5rRZ5D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B/yZqN/w";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D77910EA58
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:48:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK03c83217860
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UClHT6BNKVMxCVVP0I8xuLd0
 OwsPHW+1D4sWw1kmvxQ=; b=Lz5rRZ5Dd5AzE7gS0Jn9i3iiurCBGSRCfwyVxN/g
 CxZYWhCMqwH3WEWRWsr/9uW+6pJ9MwFZb3iRAQSKiIuNnIE2VAjRUWM8Q0M3vv0J
 UgBygzx9XcUaRiUNUBjGhevVG1QjUP+0p4TC63tUSLCDFELTIKRf7KBiSHqA6Y/e
 YTrL2kETJ49NWMqTzuj8+wU066KHimFTtfGPlxt9pSj3RezT+r7IsawXHoXr79H1
 LRcSmuTCSqQIAuB7ZRdLuov64jdsrXKEZpiU0dly+V87iBqXPFztBBgi+zOkQIur
 CD80ex1IaAos6ScioZ40A4Aqwi9A6gTUs2V7XXEzx50GUg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dm9rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:48:09 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c7a3b3c06bso687550e0c.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789339689; x=1789944489;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UClHT6BNKVMxCVVP0I8xuLd0OwsPHW+1D4sWw1kmvxQ=;
 b=B/yZqN/wCEBPhpAC82OZU7VGUmEoaUrk6FZlRj0uSpKDYhkTHAJblQb8+Vh2Csa+En
 t5/SY5NEd2ehbwxXR2N++mmVbZUPSvWTOkAVlsQhNpnqd/d9SLwbSWfYoLGXeQnvn8+r
 IZMF0GNLK268eh/uaL1NUl+83t1/ZBTGh2EHV6N3Tr4mSOnWTyOHTAwGK3RbbWrwnPip
 wylvjo2ATLA0epw2QN8ZE6xUpKtI5ieg/CsaCMg9E+n61UiCvkXUISHWM19PsrfAvu3y
 6AMxaWa+8quFA4Lxdd9ISm4sMDUdWEZcEK+qC1hm74jA0r+Kyq2DObstj0jRbWt+dT2u
 xYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789339689; x=1789944489;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UClHT6BNKVMxCVVP0I8xuLd0OwsPHW+1D4sWw1kmvxQ=;
 b=rJmF5PG7rSjrANSJrxTeYmAQQebVJPo2MdxgPMqXyNCT+BnL/oqG7fOab/1ZzZCIGE
 /voc4XF3CCCsSCQL1cMBSnMrrMm7bUR+DIvfFn8UeF/dUCh2q+nNps95hHw4LFQas4Sz
 IY6hPOHEKMtetzZLlq1LM0JT/4WOb9uxZ4UXejfePstne3VuVBOp1ivAL5zaBuYG5ib0
 RNrxaDd6Eg4eHe3X1CGkxOciBeNu5L4ewO8xM8mhrtWJeYcgc+t40WKJqewmKV7X/BjG
 CgFSVQ5TmouNe8i/l9iy5KZB0LMjdicMbsRxE5wpoaqCkykfvWiaRHawRVJsTOjzQ8jL
 LCKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGXLKxKWpja030IVkD70bY1S1CU/qYsEC2JZHw86salwWHUNI290XQmpNBk38oPeGUtCp0NUoW9sM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nmRcYMJUKNkl56mlpz0yvYz+Nb2ncI+1Q5LIWyXlc9pUgHP4Jz
 5B78Ycykr2/cZ8aBJJBqRwNtSZydxyrZbYi2SQngCad7+cuFFRKrcqa6XMXjJgobAeYchvNogk/
 Xnm/EMDD6yMrNIQ+DM6uyjyCjWQ0XBeJ39v3UhZ7lwWwHeyHFdBoPytlK8NkEDksuiOtPay4=
X-Gm-Gg: AYBFou1+WWsZEqSvN14vq+EKb3tm/9zzpSRkf21iwN1dy2mVmxBrTsv+113xCg0nudO
 Qp1ijTqo+ft1vNug0l+V3iZrw2QwAjQcBRDjCjmzRDcTQLYvP8jIPEafUN+6BLWUC70BWEtblW9
 oAub8UOFylWu3CCGSt4EOuMBpWR1A3yb5/u6pSQ2LYmSK7rHBXTtdBvrFeJBFWqxyaDPTllVWvk
 TZhv39VryziHnIU8DMA19ahLYClw853/YXhtesnGQn9uUIym2Thcsvr0DwIUizbqiSq7az/V3Y+
 letMW6h74ObOlqssFxA0cLrpF6AbWdLlJHjh6Rjo7Tx3nyLRNkXiLa43jWJrzwk9LIBle3jH5ZM
 p0uk7l5JP6MRDUFhIir+4ChNFvhIUCMEaCzXpH3L2YwNQfrsR1+iiTlD5vyhO5FxZQwtrwuRdDD
 SmKKgfsNjOAsHq
X-Received: by 2002:a05:6102:554a:b0:784:d83f:2a59 with SMTP id
 ada2fe7eead31-795aad394c0mr5074057137.9.1789339688813; 
 Sun, 13 Sep 2026 15:48:08 -0700 (PDT)
X-Received: by 2002:a05:6102:554a:b0:784:d83f:2a59 with SMTP id
 ada2fe7eead31-795aad394c0mr5074036137.9.1789339688314; 
 Sun, 13 Sep 2026 15:48:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a3144a4esm22118731fa.0.2026.09.13.15.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:48:07 -0700 (PDT)
Date: Mon, 14 Sep 2026 01:48:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
Message-ID: <rwzplkleui7i334kfsaort2iqgqwvg6pesk7xm3v272zupgmae@7whuqr2rk7if>
References: <20260913085814.1509352-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913085814.1509352-1-lgs201920130244@gmail.com>
X-Proofpoint-GUID: e56vSQOHTbsmV-Aapw6RjZuDx_NNWkqF
X-Proofpoint-ORIG-GUID: e56vSQOHTbsmV-Aapw6RjZuDx_NNWkqF
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa72829 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=eqkjudQgZ73XcBGNVqcA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMyNiBTYWx0ZWRfX0IHklrRW2kys
 DpbkmM4HnZ64dQgDVKNPOsVv/69e05EPGAT6AWEQRtztsGgDfu/VGRrDw7cSgz4I7qSkgtUs6ik
 dTnHiLy7HOWhmG3sJksK9OuPLZCz0sE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMyNiBTYWx0ZWRfX8nBeyWX/vXOu
 MFmLhlvrBVUNTIIUQCI5dIPJC5MIPk+SmmIJ04P1qXQ7K/sQpBFJrtvs832/1w2wXrvIqOnCDo1
 0IxYuTg4I3JlvRiQN05UaMjqpzF28UgBuEGFNlFCduz+H7Xvd/FZl0wbqS6UqQPiob5V8aKwdQD
 V8Fn5C6yCNIQ2YRa3TBl4AhE8KEOLdgIJ8/iizYH3tqf8TF6g4jp6oY3fV9guKDwZ2CeVdMy4nj
 hy1llC2FDB4la58R4ZjAAOoOZU+z8MuSosEpG8Eh8aKz2Nk+cr8ypcW1E0dWgxw/c3atvEFQZNc
 NzGaXrOPA4tcVO/APAHQ5hYHE/XW5dVYFQ+t00QuA1hZc1GTpcPVIxTRZ/5dgaK39cij5m+RQUj
 nKaV0s0ZdsGLOfYiAz8rBhiFZtl5oXeVd8bzFsSUAZDDgfLKTE35v1/Nc7FlWc+b9NjyomGNYYI
 9WPwMJZwmbOUPnARoGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130326
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

On Sun, Sep 13, 2026 at 04:58:14PM +0800, Guangshuo Li wrote:
> msm_hdmi_phy_probe() enables runtime PM before enabling the PHY
> resources and initializing the PLL, but failures from either operation
> return without calling the matching pm_runtime_disable().
> 
> The remove path disables runtime PM, but it is not called when probe
> fails. As a result, runtime PM remains enabled after an unsuccessful
> probe.
> 
> Route failures after pm_runtime_enable() through a common error path
> and disable runtime PM before returning.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
