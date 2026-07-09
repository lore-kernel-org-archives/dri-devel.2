Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29DBC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAC010F596;
	Thu,  9 Jul 2026 12:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKYzmWXx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YY1AT9b5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05E010F597
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:32:02 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669BNOGH1537957
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 12:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wju7AjZRirQ1hGswC0rgHkeQ
 ovYtydkybyUplA7dM40=; b=cKYzmWXxYRs+KSY9M09iFK+d57gcjBHbMEN36oth
 4i0xia1hm9t0z2yn106sNWEwclVHSWqIQhe5yOi9+WwpZgWzxiY8kiqgf0IwFBUB
 InowDIRKRuPVshgClW1uCA0nxdTWXAoUDrCN/LcfVsOe+J18TWE1Jm3NbdYDnqtg
 4k69SNd+Om/Kfi/wQbSEBmHCXrGOArk3wkuXIMf2ZN+DiVr83eeqFpyNcBelROot
 bTjOfzmq9HCCCcMOktyp2/EeQw6EL4T57/yxbYBCDbNyc+Y0xbo++1PwvDhD1gHc
 pcscAF1E2CM+UQUFtIvO5Cr95lal0DrZr4o5HRrOr1zLnQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydtnt4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 12:32:01 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9692595fe97so364534241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783600320; x=1784205120;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wju7AjZRirQ1hGswC0rgHkeQovYtydkybyUplA7dM40=;
 b=YY1AT9b5OGAuNwGiuaMHOwE1QjPE2qz8LhJU44C8lNF4uQVvagR7Fhz3tTnPatJ/xf
 91PmcdgISpxX+GyipvFh3y3ov51R0NE24la8sggJ2TBIT8TXLZtF3XE80TeowpLkAfL6
 YuKvSvomnidBGr+SuDWsbzmG+WVYw4A+rPQsaRd+my+0SBXCxCefl8yM0GVVtCZjXvrt
 HLzTqq1tjETXlxiuDx4CICT9oDX3HleosRSuzOU7hPHOLAnl+zZcLFgK6osX1bhQAlIc
 Neyww+AO7FlXVVFvS+xhXfiOsXlGwambDpsAC97PXhmwQZCBn/JPo7rzYwCw/Czhq72v
 gC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783600320; x=1784205120;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wju7AjZRirQ1hGswC0rgHkeQovYtydkybyUplA7dM40=;
 b=LC/+srXyydN6tfnyxYjM2sAAtAXgWPTmwLt3EdJGjbkkGq6G2vaI6b5O5LS+f053LE
 SQE4dkUpapTChPV5we2ELacPDz9x91yu/THWfO3PtjJGK61tgEfWpmKvanRb1gzHzYAK
 YndmzzSPcPVhqNDRY49G75REv6/0336l+mYJFmswgTuQYfyGKQT41euyjVN7NAHurYX/
 XqhNtOgUgVdzrpgsMd55RNHj+14Ln4iHvEhbGlE5BDjBmvT/xmCyMu/atnc2JyixcISF
 q0jumFoQWXX0joGLzKpWwJnZtAdNwZIOFKxO2+LYHAAl6b+HkFCfZHDnM7hCzM0cwfmq
 wmkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rof8sTqNByWYSOCi7LQBgZ3xiCBA3eK+YqKjyF1Z/KP1+XMXPMKxs0/xD1viw8jCAby222X7fkgg7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywa5RwASEyW/9dyLCSG567t2DTOoMpS6/nwve7SseWpzMitexwN
 VeR1Oxt5PSFRFGiJoVi6aflRt3PHjKQIxtKpq224YIFMFRRMbVMekR9mpNdJ+ffE6kt53VnpxX/
 OE27wMRjG8irCiS0C1myBr8GXeriHskw0jsW61ka5XXzAn4hzz1Zwt4zNeS+gOdqYOIKLlkk=
X-Gm-Gg: AfdE7clPQkCO93w97oQZkt+exsgtEuHI2J2G9iAhof2WuolF0ToBbM4MDhqqaT90WP0
 wCtS6l3Senj9gmopndWiudTB+LjKVp825eJXXFGk1AmX1q42/2B9m32hYIHhxCEjUUG9+3ytUFq
 ncr2xSc5XB7H7fV+q7KueNMQEtUfoGocjGcEDXo24bFwI8zS4r5J8CNGWb7iwgoYGDosJ7AUpHB
 wVJQvhvbXKxN6sLUGWf3wVzH1ssaacl19x2mRd2QG85wpQ0L3mPWP4op5Wv1GCf44XLwgJfM+Qe
 ZNB7TeSD4rTTksTQO95ebLXbx51MlWN0mvEwqmfMUjkW9zz/xz5833FXz9GVTa2Yp1nSWLAga9p
 5pPovo+otqLCXljfqUnzNK8OuTz77HWf+t70twgmixTNDBGvSrkDo6P6b0ECZFKlbXvgYW6+e39
 Iq8QYUqJeUBOD1qlAIQLYw5Oht
X-Received: by 2002:a05:6102:94c:b0:660:d26b:506e with SMTP id
 ada2fe7eead31-744dff52b67mr4231630137.1.1783600320462; 
 Thu, 09 Jul 2026 05:32:00 -0700 (PDT)
X-Received: by 2002:a05:6102:94c:b0:660:d26b:506e with SMTP id
 ada2fe7eead31-744dff52b67mr4231606137.1.1783600319944; 
 Thu, 09 Jul 2026 05:31:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b0190a61b1sm268547e87.33.2026.07.09.05.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:31:58 -0700 (PDT)
Date: Thu, 9 Jul 2026 15:31:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, abhinav.kumar@linux.dev,
 freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
 linux-arm-msm@vger.kernel.org, lumag@kernel.org,
 marijn.suijten@somainline.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run
Subject: Re: [PATCH 24/60] drm/msm/mdp4: Convert to atomic_create_state
Message-ID: <pkezqzojiizonlrb3rx7wnhbnztgs6aaaikou2bmooayigu7kg@mp2z6y3i2yts>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-24-302d986fe5f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-24-302d986fe5f0@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyMiBTYWx0ZWRfX4xojwrNNienS
 en5QG6DmYbcxZtGTmY6pvJPH4Bu4r5cCKaHLjaoQ7ilAG89XOw5rRiwXLr++u0exTWxdJAkdzhG
 9cnYbD1gUka46JGgLWohtbABT/4arvQ=
X-Proofpoint-ORIG-GUID: gQwrHbrLsWEA8PSNWk2Z4Kaq0EhZRU1b
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4f94c1 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=AEZmeeoAxQoAE610vZ4A:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: gQwrHbrLsWEA8PSNWk2Z4Kaq0EhZRU1b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyMiBTYWx0ZWRfXzaIncA6GaLek
 7qokrGOyOtjsDiGaIfYOSp07UYY759JP4yhLbuLOFckf060F4QzfkElYMUs9tZY912ksuV3JvxU
 zVumUQmTSUcPi4njx1LlKYjKwHsHjPL9OZC5FfIzS9+rIpqsxFzVaQL2mHKImbSPUmKPouJg/pN
 OOx3YQ0RLkLxl8rFO+V0tvhxEU8Qh4NGpUE2p9F3vmavb/4BEt5qF2bOA4seMtdphl+CNcPER+u
 REhb64n4pS2eQKVQEwfCY4Ka/yk+XwsFZ7TSdOJteGb55HJTXrAodSWzW5wyVSbp13AvMITZmK3
 vKQssbKNYOGgQBreWq+izIwA49pY2onAGYzKlm4f+w9gLdat8Row2mJ+MU0O0Ob5gdacGgEeqmB
 6nocuDeZrf9DrrI+FoGcJX4C5R+30KyZJHHSKOH5WQMU8pbl/ONB2qm56hmBXJagV8RE2GwCtrK
 /aDtJv8i+z8zunagwGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090122
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

On Thu, Jul 09, 2026 at 01:50:50PM +0200, Maxime Ripard wrote:
> The plane only initializes a pristine state in its reset hook
> using drm_atomic_helper_plane_reset(), which is equivalent to what
> atomic_create_state expects. Convert to it.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Ack to merge it through drm-misc
-- 
With best wishes
Dmitry
