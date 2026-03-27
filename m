Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0761D10F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7077B10EE9F;
	Fri, 27 Mar 2026 19:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLJ1XQ9A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AYY9rMDG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595DE10EE99
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:44 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2k2u1458669
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 teVHKGkb5tER6UyOM8vX2vU3CT20tkmDTGularD2JzA=; b=SLJ1XQ9AUQtF+mV1
 C+LyFCxHX37K4YVqKudiM9weqXdcz1X9S5iKJr6SpWiGbun4XhyzS1YpPrnMZcPc
 a4uvhMKKdJYq4LEluqfWrHoUEtUxNpFJnd9GPsdrdxEv0965ePL1/raXo2hGrgnY
 ICI/Rtp41aHnuLZI7WfCTj4I5pKTE+WO+WJwBEZG22YNYS8BGGm57AW6iolHJGKC
 iDUMl5QGggfhTNu5VQTXwSxMj5t+pIgrh+mI4hyXHQlxDbhqIPFmQ6m2HKWDQiK8
 jj1jJHWn1VlxRSHnBDICXGuwp31kefUJZxqCevOKVy9bMaTxahZN8bMSoo9hglCw
 A7tvZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5dd6m5vs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50937cf66b5so118690491cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640863; x=1775245663;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teVHKGkb5tER6UyOM8vX2vU3CT20tkmDTGularD2JzA=;
 b=AYY9rMDGtJlGF//Xy0VN/BER2CSt1WhmDeDSOhq8U+DPUkiy7f3P2nYEmTEnH+b5vD
 Il8j/IANRWUFGGeZRjyEWNRl3O9/Qu3CF28l+U3uS2quTVbg91NEWtcFS2n213wDdVzY
 /EVVVibOyZi2JE65AE7axEF6DcpBCA+F6KtKpR7TTXFibsbWfuQaW2DKcjMDKn7lZHMC
 UUr6jnyUH8zYpe2zG4z3EhadN8mM9EXXSup/AWwgHwumIctVGPwli0dr5DwTE3/+LZqS
 uuciJNZOgmjdbTzvgUkzw587isdLLa2v+xnBfUQYZ00+mTWrdhK2QiCzKFIbix7QBFe8
 bAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640863; x=1775245663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=teVHKGkb5tER6UyOM8vX2vU3CT20tkmDTGularD2JzA=;
 b=PYSrqI7C58TD6G2O/kZ1Ogc9Gs90cI6l+69Oc5Zsrxyl5UE0c+2cZbzYNG3VfS6+Hl
 3XgN2nhfUzrCmfPMVawsF6MJkp4flTj+mGsKTkWkr6TIE+2Ie+simt0nZNY9bxznBf1s
 4gpwSs1Whtrp+hGzwYVsMOpozEsnWG1oRve5EDcFx/wEqyrCH/V05VJQ8txj24L/KNiU
 6zb1Vr21V470at+ZMa2K3OlXS+VGfq+FgiFFR11sakWXOvYYGzLph/dtcN65VDr/y/K1
 vE2Daf0dm2CjwnIQe76BVyndBk2CZ6ful0dNzjVkXLDPXvyTR+duZJ3Z6bDQqqWjffAV
 q2mw==
X-Gm-Message-State: AOJu0YwdCJjMLiSmOQp93rYTg4EIkfkfnyb19o5bCE963IoYX8Z4K17U
 ZYt/eRoCHZkRPl93sSPAqZCKkoLZfiX0pkxRO4noNj5y1tgRjUKAozsWRI1h1qrWNcOrvcE+8t9
 zeitVA+D99hYcwWt57emfUVro51gBm69bF4TGM2boJOz5JUqJXpTGFkQ27IcP6/pZdnMcNzY=
X-Gm-Gg: ATEYQzyEaoxYoLjyWvzFvzzTJ/NaphDAAZBI0tl3o5sdMyxbSSl5MhuEc6sEdnOT0aL
 4xkXNvGIS39j1f4nSbIo1NpR5lWQdHauBFUmTrrNUyJjJt3h14mL9tLEd8H9sje0/Qh8I+JqynC
 7jPl7EqnOC5FvMulboGl+HIBWVkGWpEPa60bpUgtSKIjf5kV1x6bXhRlQeFIlbmBTfOf+PHlrux
 qV7Ss9anG7j9EO2zUquMLJnUYcKCHrJaizyXAMpMtBvB3vVnfd5c04EprxRIVI3Zw4ef/bUvyPl
 HnuLSeU8G36a41NgJAApnKm/dUrp/4GV1kC1IiVVB4lHxPtZ2XhrBMYeXHRB9NrVh29xz1zKqV2
 olDmyNZeHKzpZrN1jdv7iY6yY1yaS2sgeUnyWGiNllWZSoIyoAWY9d009AEI6YzQzbQGfF++ho4
 Lnp1uwDOs2bERrtBRXDFEWi0WwY5XnR0lb
X-Received: by 2002:a05:622a:4188:b0:509:238f:ad8f with SMTP id
 d75a77b69052e-50ba37d196emr56634441cf.5.1774640862840; 
 Fri, 27 Mar 2026 12:47:42 -0700 (PDT)
X-Received: by 2002:a05:622a:4188:b0:509:238f:ad8f with SMTP id
 d75a77b69052e-50ba37d196emr56634101cf.5.1774640862390; 
 Fri, 27 Mar 2026 12:47:42 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:47:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/5] drm/msm: add RGB101010 pixel format
Date: Fri, 27 Mar 2026 21:47:37 +0200
Message-ID: <177463970769.3488980.9125473167622953389.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324-dsi-rgb101010-support-v5-0-ff6afc904115@pm.me>
References: <20260324-dsi-rgb101010-support-v5-0-ff6afc904115@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NenrFmD4 c=1 sm=1 tr=0 ts=69c6dedf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8
 a=Q2NTn6QYng6VSU78D54A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: g_3yH_TAUvgMYFIsTneoVJFP5OLflW7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX5/UYeExi9Oqu
 fJrqgPF/iCTBYa4kS7BHYumvG7Rp65vQF1on0+Poq+M3eiGD17T2oeLoY6vkGLeZIf7+JH8AOgw
 /O62HRDrmgy1rVTcy8beBUGcBZy1B29owN2Jwm9aJV9VvpooEG27SUurwd3yBpxMvXxkm7B7UhU
 NsCLVLfdd+dMaPla4CZ4CJdBNwTEIdPU29pIRQ+NQ0lbHFyXNTk4SWaJVLbbCNLj54IsP8boDRe
 w1o36ypsuZovC3nX6auRw3psZ4x28rmbjbW0RW9Yo5C6TbKHGjqzrHhU94LCQHBYF2V562PdoOt
 kPoWpgxuiitbPN3eSLq87Lp6e0ItIJlQKw2Ai2J/u119kdfmb+fkckn/CFVsUPTxxftDlHtf60A
 xSsKXsDrru7lfGLzmEwrTuTGIDvF7presisR0+Vn6rSKjcA15K+UbifCQMuB5BBQKg4pzoW6KzD
 qiOGtr/4mdaGUrw0opA==
X-Proofpoint-ORIG-GUID: g_3yH_TAUvgMYFIsTneoVJFP5OLflW7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Tue, 24 Mar 2026 11:47:56 +0000, Alexander Koskovich wrote:
> This series adds support for the RGB101010 (30bpp) pixel format used by some
> newer panels.
> 
> Tested on the BOE BF068MWM-TD0 panel (10 bit DSC) on the Nothing Phone (3a).

Applied to msm-next, thanks!

[1/5] drm/mipi-dsi: add RGB101010 pixel format
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b50dc1e54750
[2/5] drm/meson: use default case for unsupported DSI pixel formats
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a780b7f6c8e5
[3/5] drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to V2_0_0
      https://gitlab.freedesktop.org/lumag/msm/-/commit/913a709dea0e
[4/5] drm/msm/dsi: add DSI version >= comparison helper
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a65c4d30988e
[5/5] drm/msm/dsi: Add support for RGB101010 pixel format
      https://gitlab.freedesktop.org/lumag/msm/-/commit/cebf747abeeb

Best regards,
-- 
With best wishes
Dmitry


