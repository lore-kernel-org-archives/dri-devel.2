Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9946C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073CA10EB73;
	Tue,  8 Sep 2026 11:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OW8SIQ+B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VfcOqS/l";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3B410EB73
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:43:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688ADM8h2596019
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 11:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=eJtXEg7vUHM0z0XVM9YoohNJ
 DcSIprCrERl1dn/YsEE=; b=OW8SIQ+BWiTQ4NAr/sWsoSSCrvxrmTzclnnTdZK6
 jBUHASaBiQTy7Gv5ZMwczIYe2NGaX5NiXrJeyJq67KCClIeN7QT09a7DePqn5YIm
 ab/z2gDOgXY5+4GlmgaI2NoVQWKeYxweycwz0Uq3zUUY1t+jXNYwk8nolK6xwahI
 iypTBdfTkxNdlT4GziH/AjIv77KwSTNopEYc0Gr1eglP94H2fEBhXK05QsbpvOkC
 dlUEOFtDxGpBLR5f39EsA+J0HG4skPE7oTwaq73rQNStMYIEIaJUPPprhXpS/Nqn
 gmFgvZVWUuqfKAUhjKkojLuL9s16qI8v9nV6Fc4SVW0A1A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjf1cgqr1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 11:43:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-980c3b71002so1318788241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788867833; x=1789472633;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eJtXEg7vUHM0z0XVM9YoohNJDcSIprCrERl1dn/YsEE=;
 b=VfcOqS/ljl43SsZRmuMQh2OWwaFQcN0sh/0on4qbIKL9jUsfoGVZQtbcZu9YQp02my
 vaefDlhjbyokQfW3IBVhUM4PS5MlVaBCE48R9KZ1VqmVRjUiluSCLCm1IIdRS/zD7/5w
 /JQoGUfL3z5OgcjRc2TzVMwPohD3nnmqSGbzDGzItxrJMsz3s3bngyfXz5Mj/KYOcSp2
 h5uSmg2nmDixyIX3HgG7jrAV0vZIDGjEPWETrv5HqcmgrlQ59LXAfirf+HnTVUFDPpHO
 wwY5HSs81QmLGQ6X0lPiLIGOgs+bAq9mG7vBawResFn/BQA7kDL3DEqHefwxvmqN2ZJa
 InSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788867833; x=1789472633;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eJtXEg7vUHM0z0XVM9YoohNJDcSIprCrERl1dn/YsEE=;
 b=r/XIxoUMXCdPGkazn7nt1aSl8V7x5xFiqZwyHf/tm+ClZpuEk0f2mAx2I3mwEwAn+9
 1ru696Wy8CI/qk5ku7QvZviIN9r16mRaPVbFA3JSQbkLp1i0uX8/cCSlnPXCPVG4nanu
 c7HzMzu7do8quK7qKf7YViQfSt8jvPaLMHXA6Jw3NSYeuXGTi2Uz+PgST587oD5FSXhL
 dWkGLhbXAHDr0mcCCQhtSHKTkby4nq8ZcKGqxYZ/rGOD4+VPCbmK9WMCu6fVBTbVP2B1
 Wu/ZXSki+lJKvcquf3hCDYYtyJbNvdvxfykD3J1QW1O+2snlHdF8m790eyJFFNrZgXyJ
 IBJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzU55BqLrQYdS9/d68odxjbfoGvEZrE+uf49SBbaIlJX/1qkqRlhplgFcM7tDRuqZgA2y8N6Oc0Oek=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mHXQKk0NTDYqcfIixOD2If76vOSKJWU+OxG8iohikjDal3ZnHl
 as53bm8cr5DGEqv4bVSFuXt33vNIXII24EpLsD7IePGhDoXWXJeKNSjYTMk9EY9WtTaHupXQzRv
 FyEzSGO06ZKANV6/w5Y83kdz6mci6z3coSZym3KwDB6EjQZ0DP0sXlhkeXJvxASXs7Ur3G0w=
X-Gm-Gg: AYBFou34pWfU1DRWSt56Aii0Hvq35de/YgCuU3P4FfNFMXO5hE+Tf7qHndQjuRj5ULT
 KTnRjRbTSIE4vuP8osDJcSfjQsVVlc2rx28Lz+ujoWyd8zrYevZBUritn25QzJFPeawYSCg2IKT
 CwrmGgYPQz0Mla6vL7BNXaMtS2zjSugZI7oHxtE6RLdqrDmAAvt7HjdSvMTzIf6UXQgLDAQO1tR
 vLbNh+1RZDbwgobUVpXJAM3taDDXrfyNHAtcCfVWostPNcaUsA2OjYqF6aQJRss1KthZpNG8Cop
 SlMqF4pXyESDKS+uNTck+SYlkbd/WVUfIId8nUG/CB0lc86/3cKtCWwVYxGd2jitNimyx/4eVPX
 BRFRQ59CsPvdnKc36JZtF8ZNM5Dl07FP42C+oilRMmcUYAIiYdbLwv+icbFQBjZwy/JxlOw5PO8
 WCAhreTcG5Vpjl
X-Received: by 2002:a05:6102:5093:b0:783:79ac:9db2 with SMTP id
 ada2fe7eead31-78a4a64b7c6mr10797466137.3.1788867832646; 
 Tue, 08 Sep 2026 04:43:52 -0700 (PDT)
X-Received: by 2002:a05:6102:5093:b0:783:79ac:9db2 with SMTP id
 ada2fe7eead31-78a4a64b7c6mr10797436137.3.1788867832062; 
 Tue, 08 Sep 2026 04:43:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b619820db9sm2943377e87.54.2026.09.08.04.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 04:43:49 -0700 (PDT)
Date: Tue, 8 Sep 2026 14:43:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
Message-ID: <le7zslxe27qauz7duczbxl4rrd3kbekg5cwxzg5tmsy77r2t2z@7gdoif3yfkgg>
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <80eb9f51-9cff-4c07-822a-759360617cbf@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80eb9f51-9cff-4c07-822a-759360617cbf@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VN3tWdPX c=1 sm=1 tr=0 ts=6a9ff4f9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=OqzjHUTi1ChSdUIkaaAA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: sgORqzr6jJWolxtpVz2CGgpckQ-kcwUL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX3T9A+QGaWg7h
 aBzVf+iQx5lnaxII0tPFVyvsSCyI6NVxTbFQF0vRYIqetNZjB2lbc6NAYs6aiFObnBSLC83wuVq
 6aaaBJPDKWNNp8q9vqnDkczLACVlrds=
X-Proofpoint-GUID: sgORqzr6jJWolxtpVz2CGgpckQ-kcwUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEyNSBTYWx0ZWRfX/B09d8CzOPvt
 uqAAgFFTfGP01QxDzl/lo2Bboafx2uIubq2I98i+T+exIHjAvETyFV2py7P4FobQu4t/vMjAxLx
 5HSG+OFpouL4IRcAv+JmDfS/hULik6eSZqnT9MwhD2Znahjotr73ZxOPCdf21Q8lb0eAdJF4F82
 zT1kH9jFkV+2FM2zehRMqDnGbINO+8kQSr/ITdhJKfEanm5y1cIkVXNZKpLAtN6anIzh8oSmckE
 pRtCAIFXTAYUTsncybYvhjohIQlOLVu3MkMW4w0+cU7Ir+JCkauN8O5GHNfFlzplaiVvAWiQ8l4
 JltrIizYDuLd0OAxbGTCmvOwEgYi8M/SD/NVP+jYVkaoUB8K5ujXb3+Ia7kg2+LYX1kdnOi6m0X
 Y2OXZh5liEiYUyPfP/zGuqpExgjwcbFSRMDW4ppiRyinxNiJvUorNpdXUkveEXTz/VZRBvMTQCC
 6c8WrcmDjY8iUi27Ekg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080125
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

On Tue, Sep 08, 2026 at 09:03:55AM +0200, Konrad Dybcio wrote:
> On 8/28/26 1:13 AM, Dmitry Baryshkov wrote:
> > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
> > zero whenever the GPU is powered up again and the timestamp reported to
> > userspace jumps backwards. On an a702 six reads three seconds apart all
> > land in the 500..1200 tick range, stepping backwards twice, and on an
> > a530 the OpenCL device timer conformance test fails because
> > clGetDeviceAndHostTimer() returns an end time below the start time.
> > 
> > Save the counter in the suspend path of the affected generations, while
> > the GPU is still powered, and add the accumulated ticks to the value
> > reported to userspace.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from zero
> > whenever the GPU is powered up again and the timestamp userspace reads
> > jumps backwards.  Accumulate what the counter reached before each suspend
> > and add it to what is reported afterwards.
> 
> Could (some) a5xx parts use A5XX_GPMU_ALWAYS_ON_COUNTER/0xa879?
> msm-3.x defines it as KGSL_PERFCOUNTER_NOT_USED fwiw..

It seems it also restarts on power collapse (so always on is not
actually always). Also if it worked, it would have helped only a530 and
a540 (MSM8996 and MSM8998), leaving SDM630/660 and all MSM8956/76/53/37
without the fix.

-- 
With best wishes
Dmitry
