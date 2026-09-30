Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47588CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF8A10F322;
	Wed, 30 Sep 2026 18:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="InYaUdIL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5Qu6kf6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EED10F313
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:51:33 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UIMGNf3657207
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=STICXhlmydY5ugMIn/MSZsMe
 t0adQStm/p3f87Ly+2E=; b=InYaUdILg3kHLwOu2C2SrlnKcrJZQhfPkm+Psw2E
 igUObzQrIIdGG1KyDU2F1F1/Ns54YvQuTVYguiRe/pdUqU0eVJ+bwgvt6mipUSRg
 icwgybb8mgMjbvIQAlVDpZ5EX5s6zl+6vm24yC3oL+0eWPXzfczAlpPq4YlVSecL
 O4qb2S80/JX/HSk0FWl1OleyahNwVi8lpTzIPQzv1mCi7G5KbU8TVTLRJFieyUSi
 ecXidL3dzHKURycfGAXN6CyFvXPul3jJLVbLJ3ukqzMmhQ86PkQC/sdABeUBEK9V
 vnzOs2QaxtsJ61AwnM6U3xDNDZ8Ch49/TPw7u5IXQO2MmQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvr42u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:51:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cafdbdb7cso18424585a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790794292; x=1791399092;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=STICXhlmydY5ugMIn/MSZsMet0adQStm/p3f87Ly+2E=;
 b=S5Qu6kf6iJGUxVmPLkldZv/0rkxNWh8ENXdgqISvQuXK4AWNbGepUw31/y493vHx5+
 L+SJMPzV8uz+1FqvhoorA1KaqZLE4jHE6N7a1n5ZiiHDb0ZI1s8C6BHzhe/J5uzgezxD
 cdgOEIr2Ki4bcxtE1geOkby+4Rva1u3nPzFQA6CiE/m3pC6FSCji5+pZSqnBz3tjUyMS
 u89JIRJOkwxC9Ldo76asxxWUk4GD82e9fWiPjDtb5DM6MVvgal2EJLLB+uxDI8cIhXpB
 dfKQzSZBqdLaPZZoZ/P/u7ekUQisLu2dxIRzpCwZyUB1I+gpP4WvqfBYBkX95Oa8umNX
 mONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790794292; x=1791399092;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=STICXhlmydY5ugMIn/MSZsMet0adQStm/p3f87Ly+2E=;
 b=n2gSkiZKWrgVcrA/fjsYqxx4M7DtWdoIU3B6If64RpVR3S0bRlhp2FVpDaOtFke66Z
 PQtGfaAxWg/MNEkhHzlY1YNZx2AzE9Wfh6aMu6bmp5KZ726M+mcXfXsKepXYCooOFOrR
 Mhp7dNeEgRHO86GZv5PbSSSudn+CJ1ld72aBK02P4jT8W9v9HLt1AwAXiPXpTGrtYHJW
 qXb3ZVkZKEE9eTT762/4yrmVRuD46wuZKg39uIrWxuLbxh0eHZJO5RpCqIG/UGlNKTGq
 P3Nmvcb7lsHxl5krm136LtHRuIpnTLKvP3++84TyFddsnTyBmGU2skqseXKWpdETEBPn
 hfWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFbzWFhay1WpwdeM9GK2JBFhbk6ksQ7jBYx3ixthQrDTq98h/XKkU0MSETbY+SgWGikQ+MwGWPrNE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nW5TfYx6G9CH1sB9Scw+6NnNmHQonGBIeyLX0K4pNaHKt+d3V/
 HFtBMt1cd4Yy7EGV+6ICg3jANf4I51aPM8fFuvjrCoko7fnpQjV43uYNPAKnmkjoe4WWLrg0pTa
 DpalU+EEi/i3w3P2hk2PXG9sAdoKK2sUlEkw9ScAfJc7bMur9YEvOwiL7RzhGH883j4bmcyo=
X-Gm-Gg: AYBFou2O1MfZ2jN4e0bozSnntHUcoGi/exrjQetd2G6XWrDeV7WEZWus7N+I0uJqgyz
 fS1+jXjkFqAidshVtn0wHPH9hnyp+b0S/ULqSCOYUzMZZugDtznmkCE40aQL7y0qLaXwWh5zFMP
 CURju+rTLiZC9Ok8XlIa3nQUE5grniRuoEB2udygPssYItmw6pJKQAxcYCFCXgFk4KHkbMN9Zoz
 DLDWcMMyocwhd2uwxI3b1lU3HbGnRE6hTOo/aaTHAZxba/Vsj84cAJdjN8GwlyjfLcoA4rGG/3c
 ikAWiFNTp4ePxM8TSGVbh9rtEgGYoN1Qge3NgOOb4Anl6VMDrlLKncFcij45Nqr4Zdeq32K5vzx
 q61TahMYPViTa2qRqjL1WIMi+d1fvxkB1QpBZId7QAQxmeP3O0ER3+XkcWDpH+w3N1GyV0WUqgU
 6XLpk9VqqD+zvL
X-Received: by 2002:a05:620a:6086:b0:939:af12:f5a0 with SMTP id
 af79cd13be357-93cb5b4b547mr103741585a.23.1790794291847; 
 Wed, 30 Sep 2026 11:51:31 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:939:af12:f5a0 with SMTP id
 af79cd13be357-93cb5b4b547mr103736085a.23.1790794291254; 
 Wed, 30 Sep 2026 11:51:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fb2702sm167395e87.34.2026.09.30.11.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:51:29 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:51:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 11/13] drm/msm/dp: Initialize the debugfs connector pointer
Message-ID: <f3pxrfm5gjrcu7j7y3f7l2vb7o5fjcy6qeb66ko7vcpqf6uccc@2svugdnka7dn>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-11-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-11-dbbf8b2b42bc@radxa.com>
X-Proofpoint-ORIG-GUID: mAZMR64Yr1R-hTsbyMokepqzmZ2UygvG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3NyBTYWx0ZWRfXz0vI5vadsUzK
 T2Ab7LQE9EZK0JztRNNTborEIioqJrxKb9hd56gp8p7u6LtDmoIOr3H9yAvrM1yRh5GuJhz/hrW
 K5hm9dnBKYqFtgJGAkVPK3TYe/JA7UYC24CqPyD4kjNSRyJwpNu3mnuC7Z046Dv+d9QhPR3VAaG
 VJM3dB4dwehnSPMx7ID6qmwEf69rv9M9sUE2EelQ16QxqPFa/2ab2gHc1oTSN09bYPPhqBL5Bvr
 ag4N8LPGpMVgO+PfNj3wZJOsyR9YzmRYjXZSvR6yslIBvSgRwggw+s8lqlebITVg2HPgu2pJAT3
 qqagu2I0UFJojZjMFmd5m50lkWpnaDOOycsqPy7vsmb/SM7/6ZQIlW1562VDai27+k2aA28khfM
 Ncrf5Ls5K2IKZbG73JuQdW7+B80lqR4S979LKQQtJ64il0fcxKuxVxEZN8x8UCzW4U5SCs1rOZ5
 rxTgduuQnzzzgMUBj3g==
X-Proofpoint-GUID: mAZMR64Yr1R-hTsbyMokepqzmZ2UygvG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3NyBTYWx0ZWRfX1Rc7P/IxImtG
 fLQY4AAD2jB5Jiksriiw7nz/QGmlT2sa18qkBbOWTal5Jk6JtJhXBgC2NJ8xKbO2Vvk41PHd1NM
 cR0s51AzrvEpJ99bEdeAJBiB/BkUuEY=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abd5a34 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=5ERa0XqK_cGZVxZ2II4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300077
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

On Wed, Sep 30, 2026 at 08:41:55PM +0800, Xilin Wu wrote:
> The debugfs cleanup removed the connector assignment from the debug
> context, but the video-pattern test files still dereference that pointer
> to check connector status. Reading those files can therefore dereference
> NULL.
> 
> Store the supplied connector before creating the debugfs files.
> 
> Fixes: ab8420418c2e ("drm/msm/dp: cleanup debugfs handling")
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Please don't add empty lines between the tags. With the commit message
fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> ---
>  drivers/gpu/drm/msm/dp/dp_debug.c | 1 +
>  1 file changed, 1 insertion(+)
> 

-- 
With best wishes
Dmitry
