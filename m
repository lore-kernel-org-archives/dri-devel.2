Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2232DC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D9010E478;
	Wed, 22 Jul 2026 13:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C5UggOjp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H0CioxlF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63DB310E478
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:58:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDWbtR1027246
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GUQcGZqwm0TbucOxZ5RZiruh
 25zjIY7woU+b7Ags424=; b=C5UggOjp1b3jVSAhxyQO2EwRwoWv42WOEuBZrcm+
 9d053mY0TySpCPo9t7K9ieMXJZLYTgnenhRjc71sKE4QvX13GRb4dfKQEWmkx9WK
 7K/Y/zkiRCOnRdrqrmcEzNNVIL0CgOwF4pm5/7ISuKlWG+rZy8fUGIIO68d9t+HY
 tvjD//kOcfRyX8tsLojIQ/0S56hm17j+obaPQd3ftEo/IhY3ke0YfsAkdEykYsR9
 1Ku2n9RyZama+6P/Rl/DLzVsYJ7ON/PzPOs9bEYD1pz7Y1zVYvMSukzPbTQCHEIM
 X5ncZCseXv8FILoTLHoSnwcvFK0GKa9ngDj0q8xMJ3rPgQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt799bfh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:57:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso103728121cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784728678; x=1785333478;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GUQcGZqwm0TbucOxZ5RZiruh25zjIY7woU+b7Ags424=;
 b=H0CioxlFqtckNirwJuqsuglYai46NSwhycU6mIgm9OwMSmpMtXMNKx2TLRskwiIIkB
 z8uGKtWLqJa9SxrSfW3Xvi1WFDFUKjBnxiSKZXs8tFEZTB6uW943/7EduifWAWw+rUyi
 U/kxsrbkSZKrrqjk1SqD09+Mjy9kZlmmx4Kj+MbJx13cKBTe0DUMjnytS+7YofPNimEj
 ljQU//PU1A7ZXjs7VojRpqp2DYJ3lwa1QB2epcjtMSUT+/RPNabX79COCfHuiu56pIKZ
 9/mihhdhiMdNIr1ZpstPq4sr1d9RY7AMwpyrV2pDG46IqdhjyGIRQIp2rwxolBZw8zE2
 WRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784728678; x=1785333478;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GUQcGZqwm0TbucOxZ5RZiruh25zjIY7woU+b7Ags424=;
 b=jkZpHcn+VEa+wmFX1aH3FM7S85AS3eUl0RTDtCTYpnrriSvyyL9nUXcKvi8+Z23UDZ
 zmpCdAUm2RzhO9AvOkaCYfV2a94NA+6U284yCa7npeiCrZjO+FeTfBUhv2/6LYqkQWPW
 pGgXgBSe9I1pqK7uWeQ+7l+4+ARfflcjWO/WF/hGNLFQqpeY+LM9PPIYd+vLVLyTStv1
 CRMHCWyaUWuSiVatDoijavejCT8gY8vN0A75tB2Kn67mFTpMUp/Wmv2d5dEDklN9Ddn+
 EY/WCsbLKN2ffaomEI30IcUvO+fLYCNrNGsIqVKL1ihNo5V8WDdUZFVaxo9xYHvq0qnj
 KQKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov698G+zMVXJxfwvKJ4sBhdoTQ97kCfpwWgJMepZIAe7h9OovMBHcNEmNHGTy1fFCkG4axcQdU3gU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/8e3ai/OlEdn/SXi3p/s1/QrpnMPf2XBhqEsAPXbjpUPYg6e9
 oW8NDvdi/Ci/UW0MqzBfcR2TUmK6GNTl1cYnr3U9DxeG8vFx4zPCmUykC7v9lLlf6l69Nbsui3C
 ZGTFCME6kuJBnSrRi026wlFBrrM/h0aXTTL7YyjBiYr0Ruh+PLJP5GM0IQK59C+fAoWxp1y8=
X-Gm-Gg: AR+sD12BrXSSsJgyti1nAR1NZ/YpoB9k3e6JHxQF0EaZHnNAyq53OfFJlmIYrO+EEga
 By5uJL7U+DSp+c0yQhcFS3/nRoWeRfK+fsnpMYb+x13pg5CwS2XSo9idkk9idKwgvvajyeLJzuj
 gvMvUdp22Lv4AN5ExkckTI3YU59rd6F4z+gahGomoOIj+enCo5OHsU6nbPN7Qi1FOCNDoGogbBx
 ljkzG4N/V6fbbSIGGd7L0YGbQpGz4G52qAt3OAyUGXOS/EFwhYWma1/VMRYjgI95DfODKMxm8I/
 AyqNgkRnMjQ2EPB3BmV5QrJNg2t+a4uoNyFfcVQl3vjiem9XMtlhU+tEJu/0AezblOy3JoB5z3j
 1IwUcKEY1i5BAWgv+8GBZseopTyKqiwUpN4AlE8n+pLsuVz2NGUq5zsBOUKJHBjHmciPGJO3J0I
 qwxRMCfnrQ1VFrbg==
X-Received: by 2002:ac8:5a04:0:b0:51e:4f6a:b9b8 with SMTP id
 d75a77b69052e-5213c10aab3mr209989531cf.1.1784728678253; 
 Wed, 22 Jul 2026 06:57:58 -0700 (PDT)
X-Received: by 2002:ac8:5a04:0:b0:51e:4f6a:b9b8 with SMTP id
 d75a77b69052e-5213c10aab3mr209988571cf.1.1784728676844; 
 Wed, 22 Jul 2026 06:57:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b9a626sm521216e87.20.2026.07.22.06.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:57:55 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:57:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: add .shutdown to mask HPD IRQ before system
 shutdown
Message-ID: <4ejjhxkyuqcohkobvbmqlb6abtk6me642hnrv34mh7elxogbh5@i6ey4byagrbw>
References: <20260717-dpshutdown-v1-1-b062c2f7dfb1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-dpshutdown-v1-1-b062c2f7dfb1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a60cc66 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=XflUDCCV8CpTQQRWUBwA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: t5JmuGKvU8ODFLe45NjPbwekA27udIBe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfXyQ7A67RjCGWM
 zS4t2joR58cgsZVMjfvi5yrhzNjXBw+jddu+mhPODJy6bXb1ZcmB5vtelkURfjf44pIKEQ7EiGW
 0TWadpqwBaWLv5o7Lmz/8W7i1eZKn40jORvt6tH/785ajA2KMD5DxHHeK3zeO80EH+i1PveJ68t
 H5fgfbbxhDByXvHCIStnw+HCM2lNyhc/Uooz2Ns9uT8GHm9ouAXNR9DG7e8MpOnyukvMJ+uwPuv
 ts1xs0PBPYqsuy9TRcv60f2M3gjzlGo1vwpUfOw2aQy43k2fOGnMTfNdez/8iivzlrxpMBxtjeD
 jrUWet1y8d/WMDis41chn1piZTV1+TwoEguVSx5vFKY6ujI6M8FBZeZwoK1zZnbLbGBdEXv09UZ
 0bW/SwIvaPqbn1JXbF9jSvdUo6kwJ5F0vX2ftNqNfK9anU5z91ZNNP9Am4WCQjKyjJiEwri5EcQ
 72ycduvn+iKPUDI52mQ==
X-Proofpoint-GUID: t5JmuGKvU8ODFLe45NjPbwekA27udIBe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX5RdVMu3I8DCU
 Zcv9w+8j4MJpZ7cNG95Ea8rB6wYhj1t5EdAVlMJVaxKd4Ub87fHul8VOMOLP+5abD5V1WJAZUbd
 JeoLVk6DczuodA3p66o9HZB1IrPGCXw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220137
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

On Fri, Jul 17, 2026 at 04:56:13PM +0530, Mahadevan P wrote:
> On reboot, a late DP hot-plug-detect (HPD) IRQ can fire after
> apps_smmu has already disabled translation for the display
> subsystem, causing the HPD thread to kick off a new modeset that
> drives DPU/DP hardware and DMA through a stale IOMMU mapping.
> 
> DPU's own .shutdown disables all CRTCs first, but a pending HPD IRQ
> thread wakes up afterwards, reads the DPCD, and fires an unsolicited
> hotplug event that triggers a second atomic commit turning the
> display back on -- right as the IOMMU is disabling translation:
> 
>   systemd-shutdown[1]: Rebooting.
>   msm_dpu: drm_atomic_commit: committing (shutdown disabling CRTCs)
>   arm-smmu 3da0000.iommu: disabling translation
>   msm_dpu: drm_dp_read_dpcd_caps (late HPD IRQ thread wakes up)
>   msm_dpu: drm_sysfs_connector_hotplug_event: DP-1 hotplug event
>   msm_dpu: drm_client_modeset_probe: DP-1 found preferred mode
>   msm_dpu: drm_atomic_commit: committing (unsolicited, re-enables display)
>   dpu_crtc_commit_kickoff: crtc94 first commit
>   arm-smmu 15200000.iommu: disabling translation
> 
> Mask and flush the IRQ in .shutdown so no HPD event can retrigger a
> modeset once shutdown has started.
> Reported on lemans-evk and monaco-evk during reboot stress testing.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

I'd very much prefer if instead we fix the framework to stop polling and
HPD notifications on shutdown.

-- 
With best wishes
Dmitry
