Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA08CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 15:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC1A10E1BA;
	Sat, 16 May 2026 15:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PC6YqNrs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A6T+CH8n";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52EC10E1BA
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64G3f0DX777387
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UmI5XrkPGnRBEzq4y4AE8xpkFe5kBtdDq5bDE/u4Ncw=; b=PC6YqNrsYNsJWpGf
 1MjnbI2ErVqwyREzJ932C52J1MhVztX4nY4YLzZ/tVq/8z7YT+nxAdfVEpIMgEw2
 YMoi4xc3lMjSQ/V5DX42bPSow1gKAaJiwIWPHGT7w/sAaj8YsH8j/p79AX1pm6GD
 K6/BjoQU8yU+yl1ah6LxBwHdMfQInR0uu0AxJbWbiOCvSZKj8LVEaig115U7PNuq
 moLpdadYawAKdGYyswB/CbZiQF0cDvFhEYqwl6wAEnhaZrYLivxQIyJK4PQLxrwE
 xMvNy+LGuqkdLx8OQlhYSc9j4FF01ahJPIzweSDC2JtfNHtvHKNHxf/qzDi2KDPe
 TiPkZw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvys5tx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 15:25:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51009190feeso31168861cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778945117; x=1779549917;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmI5XrkPGnRBEzq4y4AE8xpkFe5kBtdDq5bDE/u4Ncw=;
 b=A6T+CH8nV/HFLVOjyyGiVTSABE9O59TtuG1fufRyoHHCwaCzoI0By4+qq0jl603aAS
 /TKL47eyQZe8XPCGmU9XPOnZ5l2S2OAIFtk7aZTVnDOSLaOOlYHUUl1DXEylulkpX+Z7
 vyPmVTJjSGceBjs4VeMyzm8dJZsnNIC4oVyUdrp2ayVpSpmMs4+4LgXiPt3/ZcNjeER2
 ATR4pxy6Lk7ORJcnF/oAhvapy30VnAlUU+cxIqHQQZWrTKBkdY104UPH2NqTFZ9adhjp
 Az3VkAhexIVjmXULlJschTGBJ/G31JNlxEi5SrP7hlEtolJuoOA5KcKwPtGA4TXnfH1x
 XHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778945117; x=1779549917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UmI5XrkPGnRBEzq4y4AE8xpkFe5kBtdDq5bDE/u4Ncw=;
 b=tEItTqKrPiVSgMSxK7IUelF1uB2IqIVvgzrgVtdS6sKMRIce8oezaFXcrlyIj12X+d
 EzkmVK2ilAhQZznjpEN+CPtIu8lE3TvwBgfO4hAQWxkdQxDU3pxRWKe0FYPO1L9rcMrV
 CgpxVwEWeH7spRjiiJHAVF6N7yTMZnLcj4N0WNfbFvm2zZLnUDPUkVjBOHs4NubpCvVA
 BdfegKVN7i2w5VIUsLkvPpRJgWip1RtZdpxGQQxEhZIwUtVAMNfHnEqlCasDS4708t4G
 vfBFNlT2F0Ugf2DllLAKSmj8b57FHM7J25Gc+DrOB3XKhbP9dHso5eCVKSHrNAq2c+v+
 7RWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rJi7KT8/kX/AU762B2GFwvO46HYHybqEm2w9bHCa3AFxBjNH5uJ6IFiE267ihWDlZUINQlYiYjR0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5aMstQK8U37Uy5F75RpgLiYQJze6Ob45/sLnqZtqEgYZgPQir
 kifOZ18vHVCagpYmyn/SzKqzVzHiCTkVCtoMABYfIWFnYpCJtwCKxDT6S2sI48H6dQq71ZgCTFb
 5m0kP4HLfMgSafu2aY9G5eyE2bs5TY2zvkBSn9trH7PQ0bnYblE9moNxq/l+S+yjCCAIl6ow=
X-Gm-Gg: Acq92OEp5ItSDV8ZZ87Z3bsO+PreIrgr0Vp2gMNpOdagAzItqa2iznvK8bXJI4VGCFx
 mXG7PBn3K5WroC1JpIl6DEPxcmIz2Wx9bUIQMzpwN5XeUcNlPKHtjZgRXw+eF9iabjpOFgPWFS7
 6GzqfEufRBaQFS/18/emNgynAfRTXsIH05w1y7Hcaa0F6cxIZW7vbuNTZ1XMYh7YytbJvUOwB5H
 SCCdGTeIvWJjTBdlJZ4Q1UETjSfyJtEJoKJNAP2vIEIIo9GKb/XiGl0viZKy+A5feCElunmedF4
 jsAL1LUlDpOmICGpkPV+tmX973GxJvCl6PTxLxXhApq4kWlCJgWObTuKyBU0eHujKqHIyx5ZF6G
 XiXaaMvb1KywCUk8PZuk4gHOenGBqUwVA144oUC9OlPOGinHe/5A60KFYH/qADXdHRFb0IRxIAs
 /hJiglzqkwpAkaum0ku32NOe1r4qjAOIV8Npk=
X-Received: by 2002:a05:622a:1f97:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-5165a010632mr135796721cf.11.1778945116908; 
 Sat, 16 May 2026 08:25:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1f97:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-5165a010632mr135796381cf.11.1778945116499; 
 Sat, 16 May 2026 08:25:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164cd939sm2057972e87.70.2026.05.16.08.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 08:25:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: don't dump registers past the mapped region
Date: Sat, 16 May 2026 18:25:13 +0300
Message-ID: <177894506978.2448625.16346847676373449764.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428-msm-fix-dsi-dump-v1-1-5d4cb5ccfac7@oss.qualcomm.com>
References: <20260428-msm-fix-dsi-dump-v1-1-5d4cb5ccfac7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE1MiBTYWx0ZWRfXw5CUTgp7nrBr
 LXSvHdLzU4SHrMYu5w7QPpLlUR/rXF0Hi3MZL+Mupw2+w9AhKyaMNqAdQe+xHUbV3j9YQWLrDAK
 SzS+Mf2ZO5qOvhzFlZqJ9E1OM9xM1cX1zzY95OYU06SD2VeMHNo1TBRfU6eagiEbPGb+iAOY4tY
 GiZmCGXoIuzhajwNJUFqtz+y0s6XTAnvwIPGdgQ3GV70LvCzQhbqLHmfyGijS2sRKqMrD9qMOHr
 Dz1aIqotxOOs2HYPEixpRMRgrdHsKm9NDN0Ubwnty6Sbqwk/k8+yZiWLuMmIXrlhaBfOHu4rxk7
 gWCyx6ERBenovERU333MILoKh36m5CL9BKaNjq9l2l89nhTVV1e8osr0dt6opLF874PspRlICg9
 BB5XY6lIp9MQNNYAhMMSBgmavBrJvWXbKI33Va6R57IHID43HOOUYaf7Wxbar2e2XIwhXAnhuYj
 W3zFB6ecFW26kycr8cQ==
X-Proofpoint-ORIG-GUID: DSdj7utbNYyoFaHB33SGh0JpB7qtSn54
X-Proofpoint-GUID: DSdj7utbNYyoFaHB33SGh0JpB7qtSn54
X-Authority-Analysis: v=2.4 cv=X5Ni7mTe c=1 sm=1 tr=0 ts=6a088c5e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=pSQ9VKN1VO86L-afhjsA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160152
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

On Tue, 28 Apr 2026 20:21:38 +0300, Dmitry Baryshkov wrote:
> On DSI 6G platforms the IO address space is internally adjusted by
> io_offset. Later this adjusted address might be used for memory dumping.
> However the size that is used for memory dumping isn't adjusted to
> account for the io_offset, leading to the potential access to the
> unmapped region. Lower ctrl_size by the io_offset value to prevent
> access past the mapped area.
> 
> [...]

Applied to msm-fixes, thanks!

[1/1] drm/msm/dsi: don't dump registers past the mapped region
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5b49a46baa85

Best regards,
-- 
With best wishes
Dmitry


