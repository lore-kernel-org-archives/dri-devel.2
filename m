Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E69C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0625910E9AC;
	Sun, 13 Sep 2026 21:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IUJA4TFa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DDTUlLg0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D574D10E9AC
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:06:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DJxYni2631351
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CuOZZ+1bOWWW+56MFTScBnnN
 4DrpUl8zDP2tJWpYYOw=; b=IUJA4TFabIVCWVLJ1k/WNtI+t+aNF4Qx/N+NuPlV
 68/LKjTRHsxloRbPMOP9GROn1MsxIvCQ1y5nvma6lCKtf7fzdgWpv1Um4mzXF6Lp
 vDgBaJX6lMidWRDmOdD6xYM6Y1KG+tVTu6Vm6+PiG4nApUNcMMpJx0Qw3+/o7vE9
 AZf9HERE6fg7jIDNVYOS1KXlGSHugVq+a5dAI5+iEOj+fMrdiIomtb2LELvBXz9B
 r7UUwg90f2kNKp3gYNVEVDoGykOu6t/W414oHG13WMIlXeu9x+aPUdulM7Dz7GCo
 K9zOfaNb6rwR9aWEwP1uPuaPwvkFjyzg2IENHs/MkcctOg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c458m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:06:51 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78f4d6af128so484913137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789333611; x=1789938411;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CuOZZ+1bOWWW+56MFTScBnnN4DrpUl8zDP2tJWpYYOw=;
 b=DDTUlLg0uVL9fOnFZ4Dd8sWmYvT2dY7wR1U7w62jkPqaFHJwWw8pMXjKLYZwM2EA/o
 Q9SmSEMCNmB74FBOjG7+PmPPaL5skqjHXQLoKSXF2+bqIYM+7XL6oCMmmWVHmA6h52TX
 RFdupFr3yf7+oU5SMYbc3KT+GD2gg77I90DDIkUPYqegZBoTDCystZjNRvI2VytPdWwT
 /PXSrW8N2hTALXLdCZjeaOC6DDXhdDJkGGhQPbp+GF12Srq590yGoao+KfVBssZ9qwRl
 pQ5Xq7AGQBHdyB3VDkFxN9OscWWKMHyu4Qe15JCKkPn/BUc5biF1S5BMc0cjiZw+lTYq
 YmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789333611; x=1789938411;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CuOZZ+1bOWWW+56MFTScBnnN4DrpUl8zDP2tJWpYYOw=;
 b=F2xlmvf1SRuonoSFFYMBpvnL416uOtt0HCiDyU0XYr0rjmnlWZ7sh4ZUWShd2cb70K
 3+dt+Vg8gy0SgFNrWFlpYAyRYJlmEugFDv4FJgaAoYa96uW7HqEarOM30RHn5v0dyzKf
 gn/NKRbD6SGvPfgkA462JajP1Jsy479D0s57BfLBDe8zyBIFgECxRJaBSX/XXVAhi/Za
 bVUhxRnBPOV0lzL2c9rwU7Mc+oheAiaoBqNAS9Ro19rZ65Ma4MncIU63oC0QF6oBzp9C
 6NbsLpU+VoS02p3+qrQGCXOw/8Ms46U3BniE0U2YdFiZskcd8FlCCrgF8cFzoIfjidYv
 6DOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6ZcrRLeZljx6xK+Qas0eRbfzGhUd8QO6LVxH9tz4IuriFYnA/i5s9CH4rsPtGhXkjC7c/JhodFH8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kA8G/TDyI8dcgQfa0mncvFzERhlrp/MY6BGJ2tk6vZcc9f26PU
 niq06innDRhLj43P899RfDOeDqbOsHUK1B68uq6EPO5F6ibBnqK76mgzmMhCk+S+BzfPghmfZ9d
 OKZfSh+EDGhKuFn7Q59LmWdWzeQvFuLB6Cz3cu02TydkGS3THO8WyBs/r2835tAxP3HZfmaY=
X-Gm-Gg: AYBFou2BmNm0KT0lCxe8gNHZ49BJZRtX/Ye8FT65dp1gwNDEKY4ICPD4QMMOUmH5gJP
 t8WCgJhfh5rD/b1vQFtHJCcZkeRp4+qLvk5MRGdkEY4vrib8C94TkRAkik8m1wcnn27FuTm75sk
 o8HN/twpS6X6SqyltjjOBdyp6sLWDa4escfVT0oNz7qXfksjFVvRRtEMyNwik5gExltNknWFgpA
 LpUuZ1+jYKbKh+1Io6Xu3sfjVbPYGsDzZi7TBuF7Tt60AanEqaUU/dMDCujw5PzhgbjCq2LLzhF
 P62ZVJHSvq5Dfzi4Rj3DJWk6yPKaMoWyjvRPTq1Kag2KID2tSwzKfZIURBhxZoESIxzzFbn5v7N
 iiLBTbyF50P1Y93wLQNVhBZMguD+PY6deVdK2NxRKOZa0dlHtzrYFGc+/ZTlnMm1u979AKNHzI/
 EJrRzWctcWAmBt
X-Received: by 2002:a05:6102:8607:10b0:78f:5bab:4761 with SMTP id
 ada2fe7eead31-792a93b4e87mr2736735137.8.1789333610775; 
 Sun, 13 Sep 2026 14:06:50 -0700 (PDT)
X-Received: by 2002:a05:6102:8607:10b0:78f:5bab:4761 with SMTP id
 ada2fe7eead31-792a93b4e87mr2736729137.8.1789333610333; 
 Sun, 13 Sep 2026 14:06:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a045f6f3sm1914073e87.35.2026.09.13.14.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:06:49 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:06:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teardown
Message-ID: <vwnlgp3ysnoimdxlx6gowktonakwpita2ted7tcdfd3a6vyjy2@p3slguu75r6d>
References: <20260808131624.2854412-1-lgs201920130244@gmail.com>
 <e5964398-cc23-440c-8c69-01353b5a5ecc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5964398-cc23-440c-8c69-01353b5a5ecc@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: iLGgVLl1S0YK0-_CMVb3h6UWp-5GjzSZ
X-Proofpoint-GUID: iLGgVLl1S0YK0-_CMVb3h6UWp-5GjzSZ
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa7106b cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=owhB9EOPmpqNCIfoPYQA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMwMSBTYWx0ZWRfX0o45lNVu9DMB
 QrBYC5r6ET41lxlTiWrSgknwiLCOItboeZjgJSsaTNgtD8ClwtlOeKnulszMoRz8Xw8rZvxiEQL
 Gu7OFzyPIBCdrVlyEGdH+kcxrvXOEE5J7022PjgfU2KssH1l61zYD1dW9AWfWgY4N7J9jq3qZMG
 QKnYoB9rwHHHhLXuF/K+huUqkktIX0u+MfXdTj8cdG3j9WQ0AnEAVwaE6/1eL+RqSAisS+lXLAX
 W5do/nXnfEQ47ixTo/tYSihVRB76v1Gt6sGROJPdUhZIE8XMSRfLj2wkILQm1eCu4RLirOXFfOw
 eodlLN1A0rW7Ka/+ee6SEio5lltRl2CqSxVOYbL8btK86VoUQCcAvz5YD+mFGsJpmNKxJRFt31o
 s98U2XjFqNpuvOVUsizAj9ilve4luKqStruoZLO3oosT2mv89rrQ5daMkXm3crqTnaG2SXNy12/
 OhgC4zbp8ENHH9CkWkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMwMSBTYWx0ZWRfXz+b7exuaYj7z
 2FXu9vTUuXD+xHZWNNj19GEcuJ4ye5XBJtbypeJnXaAirz4Qmca2rDrNz+tqZXzY59oNDzehwpT
 HC0tCrQWfr+HILyaoS5bi6BvflmCMaQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130301
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

On Tue, Aug 18, 2026 at 12:40:27PM +0200, Konrad Dybcio wrote:
> On 8/8/26 3:16 PM, Guangshuo Li wrote:
> > adreno_gpu_init() calls pm_runtime_use_autosuspend(), but
> > adreno_gpu_cleanup() does not call the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> > 
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> > 
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> > 
> > Add the missing pm_runtime_dont_use_autosuspend() call to
> > adreno_gpu_cleanup().
> > 
> > This issue was found by manual code inspection.
> > 
> > Fixes: eeb754746b14 ("drm/msm/gpu: use pm-runtime")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> 
> I think we can use devm_pm_runtime_enable() instead, which will take
> care of cleaning up both the autosuspend and runpm halves

Not really, beacause the driver's group device is DPU / MDP4 / MDP5
(in case of a merged display+GPU), so the patch seems to be correct.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
