Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538CCCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F6B10EFD1;
	Wed, 20 May 2026 09:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cl1688BZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JsG8Q0rs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD33510E407
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:51:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7R5DC1636906
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qudxujwPQrKCX8KF36qTSp7r
 GgcLFYs8qlZy6UZ5I3c=; b=cl1688BZxhwZ/fM1Tq+tR1JOl7OF4o8e6fjVDGky
 oZQZIZQblVOZpkaMlVQM/XsrxhXfYLbIrgtElvNS5RV6c1YmLmE5Qa/Khoz+PiIA
 wsy3rNIOxgpUwwGIE/IaQVFpVwhHMPUHWg6E8wWR8SLx3UHJQdj5isVR2BVgejDJ
 FtAzB20AvG2n7CoN85hVF8xNcLkH0ff2D6mwU6Mq7vOxw34q7SbpYWV1s2u0lPaf
 LBEL6K3QF6yOcOCUU+APZnqoT29jWnk3GGgfAzaNNzXGAmJS0fKLDTKWs57Eq0i0
 JtQfDVWsUiCXPEl5k/otCO0xfW3p7Soy63Lvh7bzAGEasQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3sc0s7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:51:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e423a05c8so134931671cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779270672; x=1779875472;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qudxujwPQrKCX8KF36qTSp7rGgcLFYs8qlZy6UZ5I3c=;
 b=JsG8Q0rsfR2wIDvkXWtMvjlLargBl2yJ6WbiLd62XqfPQeeCjp6/T7LuWPe6IiCPiI
 KFFPk/96Z38d3U/HUU/+XYoLth+1taFdaW4ZXoDOzfS2l9fuwq6ppYuPwIj/ielvia+Z
 uGwISIAf8yfyItD/65e8vRXgyygpuzYAJAn9aW9HlkEONdGhdtEiUcEY7PBNlR2ilrLw
 4ZyRB38BWC1QzLjktQkpTi+JSOLLx/HzgFstQa66PU6sBICgRPyI2GLNc0uTZijYFBEO
 f+8BoOdLIEmHwW28F5PjV0i9OYLZASAb147TIb5BrF6how2u5bUUG/j5m+CiyBtbKCkg
 EPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779270672; x=1779875472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qudxujwPQrKCX8KF36qTSp7rGgcLFYs8qlZy6UZ5I3c=;
 b=KMaRU1zOiYnrdFo8cp+7yXcEHQ/4VGiWjZvInFroml1hBp5Smg4PqHQiV0qOtuCCho
 LawLiGo03YhcztkyW1mHjg4NJ6M9F52sThsv4vYtMI4yk9xs5cFo16mWxmweYQ4zDdY/
 yx70ynAJlGZgKjcpK+FHM0oqv0qqDrdgCi8BYaKCQr7zdc/Fsj/rCeZlA/FFGt+INoZl
 Uxjl2YP1aL2SveQRc1+NEC0kHy4VYTf2M/ZiYNHSgOSh6PtrKtPps93cDwNRt+YeWj+C
 TKAnOMlOZu3w+TNYthXsWW68vC8vOgTmTMTV1ujccyUYENibAvIndK6BTCAOgJTj3Bbq
 RzOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RRlXk/k2kC7Bp4Mdym26Wc4v4f26UMC6HYhSs4zS2EGhm9TjcJ503tEKvZGWUIJ5xssHZEALhLQQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRz1oAXxmh2xGpLMNIfDFOLqGVc+MGgQu2Ms9FerlVXcTN/1oR
 T5aW+IIlVVLZ9MI2ply19zhw74/9UEynR2CfFwiWc9lAi3KaCK+bOEFQP/5VPlefKSiTLi0vGIs
 K2zWkLb6T3KmwXuZkvK2HqE3zFeycwCYmR89foKpkvqrnK36dpM//KuBeNMjSw/MnuUfnc2Q=
X-Gm-Gg: Acq92OFwK0QareJEk2u9EsfCNoj2wZ3CUTCA/69hEZZKKtdEX/YsegLFZPRf8TkPhMV
 08kI+god2s4xxvby47ELeLagwcDyB8TDJcibULrfsU0zst4rgq44zEqj4tdlLzCzf8MLnFWO/qi
 ylVGT3GQ5NTFeh20rlnFTusDYRrYDgr+XZZciwgWMKVFKjplyzaNDuH49PSy/0TcESfCEnN90OE
 cDNesfmz+/HdlCI6Ggs2cTf2++CEpVtAHp93+mxKJAValUxPILYqaM+Q/EGm6gktFvUaHddIEkH
 KrDSwd+zyz3zyxDy7mSai6P6Ej96NbE7J+se8Fq56aXiDSlfQFyhEKLiZYVQevF8dhzMxqX98dK
 1j8Fyz1Eu70ENvZUl8z0Qb6ieUlnYTPWApWJGetOrERLMkghgLRchQdi+ew/Vgrd6+X2Dunx/gb
 nN/Eec7iNsysOaHNHIPVKPRzqxJTZ6pa9e5WQ=
X-Received: by 2002:ac8:7dce:0:b0:50d:af03:c9ca with SMTP id
 d75a77b69052e-5164193ed6bmr330459001cf.38.1779270672211; 
 Wed, 20 May 2026 02:51:12 -0700 (PDT)
X-Received: by 2002:ac8:7dce:0:b0:50d:af03:c9ca with SMTP id
 d75a77b69052e-5164193ed6bmr330458821cf.38.1779270671761; 
 Wed, 20 May 2026 02:51:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f11f2e6sm4783109e87.37.2026.05.20.02.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:51:10 -0700 (PDT)
Date: Wed, 20 May 2026 12:51:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Brian Masney <bmasney@redhat.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 7/8] drm/msm/hdmi: Use the common TMDS char rate
 constants in 8996 PHY
Message-ID: <s6tvsuf5fzm5gho3g4vfw2tlg5ayy7jtwbvwyu4zj6yhs35dtn@q2qoewdj4jek>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-8-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519144712.1418302-8-javierm@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5NCBTYWx0ZWRfXyWRqyAWyWe7y
 GGraSCW0KR5bkIFleH+nABRowprxvrVmd3sdrCfuGUD47VfF4D0yUCvspbdUt2vKOEq6ROkp1pL
 IbPC1/EaLnebWeoDEiTNxCS0nd7WSoneaNR1AwjMf8yPsrE0grxb9uMDGwyjSCWyIbtoa42Fia2
 qCqnwiZnKkWDdnGbnqjjhQLoLz29KUxOWU7uV0n5opaxo7GGQNMZLurQh5WfkebNsfVh+GwqTon
 ZIVQCe+l3UWZx0rWpcYINHWV7Di4hsUs2QXxjdio4d5YlzOMRxG19Njzxb0eJmHBWDKMxTDgqnU
 upwsmVc21rfQJ6P4bdOh1hRxqmTJv+kcFMoHE2JN02IiAjh4KNxILuVxR3rwzZaJG5gWv1GE6wL
 jAhrSgDEohltcnf9hU8eqmeB1/hV0FZNPSymXiaj303W/9L5OH1xrMFAt0NobYUWWx3DL1V0kxk
 c8JaK43nV6Di0wLh0Eg==
X-Authority-Analysis: v=2.4 cv=Oc6oyBTY c=1 sm=1 tr=0 ts=6a0d8410 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ZqDtBnPIfa8uGWz8rTwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: z_r6xFUSNt-yw3d720bxbJKAFs7v-Gpk
X-Proofpoint-ORIG-GUID: z_r6xFUSNt-yw3d720bxbJKAFs7v-Gpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200094
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

On Tue, May 19, 2026 at 04:47:03PM +0200, Javier Martinez Canillas wrote:
> Replace the driver local defines, for the minimum and maximum TMDS char
> rates, with shared constants defined in <drm/display/drm_hdmi_helper.h>.
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
