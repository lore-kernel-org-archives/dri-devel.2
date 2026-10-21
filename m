Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420C606A322
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b5UJc61l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LeYKXAtF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D4910E37E;
	Wed, 21 Oct 2026 17:43:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8472510E394
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:42:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU9jG682672
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J6uuKNtXeb4uetwD4PZfD6Mt
 JhK9RufAjFZJblRiWyQ=; b=b5UJc61lKCk10wRlwwdluLhM8Oh0cHeTXdtRbdLw
 de5nxnODD42+dQF+Npftyjw2cbnPLTVyDsg7LVJ0Jw6V/mXEzm3UiTLnfgSu80mb
 i4yR57yXplDSr3fsm+VRFL6DsXDodLxYNIpQhHGgA4w2XT3cWH74iG4tQtke32rD
 Xl4zXJ/BJWLdxqM2iOQLUNlkhHHRMDvY/7WDZJnOL5RRMLsV08v5/zQJi75TXgFC
 1/tapy//63912OrCpVEYL08LMFAA5FsJjnfCXwtYuX9uWZjze5j3Jl92Mv4qwIOK
 S7OspoUnFSdLOgAnXKZPmMOC0AlPx91HLrx0DgxglQlyEQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vs66c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:42:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso217153085a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792604572; x=1793209372;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J6uuKNtXeb4uetwD4PZfD6MtJhK9RufAjFZJblRiWyQ=;
 b=LeYKXAtFtR11J51uSGhSt6tkQ030UoWE6DwuCD2ElunKxngEvYfxxojyciGgfTe+dT
 NY76PnjB71yH2QXfL6/JQlBC6OFK7u12Fi0XXjZDrcVm3EIq8mhfaTAY0voCoQ0ckryh
 gYHNm25gKDo8KVflS7tJHqUoZIlTmQjM+OKNWPxEgFSSG6Rtu/jDJ46iuTREfEX7uRlF
 II8/amQrdCmIT7UcYGmFOjfA3AKfyG1uT1NWoIkS4xbAZOzRa9xvY83tMROzI7DxPwD+
 uqCcM2bpSKj2lVHz6MN3RDcPL8cOJDwF/nonb5wJPEl8/+YwyIRTv9GU757aPI82jKnR
 bQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604572; x=1793209372;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J6uuKNtXeb4uetwD4PZfD6MtJhK9RufAjFZJblRiWyQ=;
 b=a+H511xGeNCm8MSbmrM5XP0h4Di0T9i5ddEAhq/TQc5Rjn3uOTxpMeCWmw2HOM6KGS
 PDgLSP3iruP42DsGBEI7ZRFYERGa3WscFYItk5FM9Vw+nTo+3iedTJ9MvqYErIfGezjA
 pvug+61lAfcGBsej9uyb1hJLFMqO8V5TQDz60RxNi7ntbgCIEz8bvjNPUvpyDE3UdIs8
 kBKk+Hr1IjHh4UwlTLjSOss3uFAnFrcohA3GzXRkO7ztJF9zlrZSXMjnbYpg5ULNyGY0
 cV/HdZ9eJD4N5xPqLr0MNOugrNl6nlE53knMz3Ou+rS1Dx+P7W1dvcm0/71Bb+THa+b0
 a8jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2fMpjpWG1VhP5aBap79mYBccTEvowOJdvgE/6EUI5PkfoXdUt6pgmnFJLgQ9n98UNNzvgC0w4VU0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKgOI+SmTSvluF3ZQrmx1lfWjg+zCSHl8lFxJnZTfXcMIedL+Vm
 3NDfZVG57Y1CwYnwXBc33AWLvKoZFTbaPfWlPaiB2k91SDaKUkmb9e7Zc2jx76+gfThn9MPNHKh
 XsTRdjehUTPjeALwn+jWpBB/+kw6BtKglFppryI/sJXANuymWTP6Pa+G95DbA+GSptGCfVj4=
X-Gm-Gg: AYBFou2tQVY7kWxHN/94PLr7AWegRGcxD2ofLE7Ep/rv7Y1CDH979Mdn1RGA8nvxhuh
 /I7fv0iHb3sbKJbiXynoqwmoLqRm0BNnVMJG0v0P2IjXXS33XMun+j7Wd5mQjTv70pzLvPs7Lfe
 7KwTuH4iju96iCdg2n0KleTZ5wYOQsEwR/ElHWpdH73Xn0tR+1Wrooiu78T1YiKYnMAWY/aWPV2
 O+jjksXPtx2Oq8kWNQnAVsH7LxCBi65WK03UgG8PGSDgYLeIa8/05tUh0nfeeFVB42VQtS4JvCx
 ysPdY9KJrJRVLD7v9PHQQdFZhGh9yJyeZgvti+G3iCb2rLrB6k1X8CaYFKZFoOnkg0LsK3H0BFr
 AGapvqsTZSY2EVoXeR2XEUM+r+KgiWObU1tcLwPYf2lrfwrpyXNFYn38i8c7J6++fF0ugPkOsQ6
 MOu5CFLY54+j0/
X-Received: by 2002:a05:620a:690d:b0:93b:d79a:c463 with SMTP id
 af79cd13be357-93f57f5ec48mr547612685a.59.1792604572207; 
 Wed, 21 Oct 2026 10:42:52 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:93b:d79a:c463 with SMTP id
 af79cd13be357-93f57f5ec48mr547607985a.59.1792604571628; 
 Wed, 21 Oct 2026 10:42:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac4f4df0c9sm1729191fa.4.2026.10.21.10.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:42:50 -0700 (PDT)
Date: Wed, 21 Oct 2026 20:42:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fabricio Akio <fabricioakio@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Paul Sajna <sajattack@postmarketos.org>
Subject: Re: [PATCH v2 3/3] drm/msm/a5xx: Use the downstream GPU idle timeout
 on A508, A509 and A512
Message-ID: <s5qnjxh7sj4rtzwg46oeeukeg3exjxjxnlp53c7ldyi7edpau2@sf6wt5xdw2q5>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-3-457aafbb28da@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-a5xx-gpu-pm-v2-3-457aafbb28da@gmail.com>
X-Proofpoint-ORIG-GUID: -NEawIzt0lrVNlFRnMe1JvAFWsr-untU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfXz33H4f7kAPyO
 cT6ZnsX1LvMfR4H3llQoboTbklFFHqZgU9RCr881+fqvGR248qWCn6B3nxA5rpn9CNL/6imiVgg
 zoL5YL29+KaCgiziF+8BLzrAJL3r5N4=
X-Proofpoint-GUID: -NEawIzt0lrVNlFRnMe1JvAFWsr-untU
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8f99c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ajoyPTHG4wiO7EjX:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=OQN141zOAAAA:20 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VJCrZHs55krGogs9KgYA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX51kGRQZU49gI
 anNrWzUeNEthHl1FMVujUBW+O3IxPaJ63EKWn9eoZPORLTSa/fvn6gw1FSdSNLt0bVca4v7DymJ
 Xz8bw6+Lf0qkkwmitibQR+qVE9vNTI8XhS/6nMjI9myJYEPiIaX2tFN+TgkKQrWOwNd/V4JeV0N
 iaEUnJvPktQjPfVCcIUlMZSeKgs4wjkE0pTLh0Lxb5W1lhWGP2tCFywkloinJgXFk+Qb4d69jWs
 Twvp4GlqniXi7NevHHtALMKrsFAmF4kPYOnjcFZAcKEY/1/D3IbaY3uznVEaYwVCLvw+N5KMkIx
 0aRDcKNzlRdMaeHkzgXe7+MTSRHdJ77m8ysVRrIj1kYP/x3p8OXgtHCpWJB0u/gnXEU4H4pKhUE
 5yB+wT7lH+hgL7c/jnpV+0BOUTW1tm/URfqlKrwTSHkYW3KKGsYV/2VVHeUKBZhhuqEMTnqJadD
 WYzkXl6ppcHsdeEJDEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210070
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 11:05:10PM -0300, Fabricio Akio wrote:
> The A508, A509 and A512 took the 250 ms runtime-PM autosuspend delay
> of the A530, raised there because quickly cycling that GPU's power
> hung the system. Qualcomm's downstream driver powers these GPUs down
> after 80 ms idle, qcom,idle-timeout, on SDM630, SDM636 and SDM660
> alike.
> 
> Use 80 ms for these three, so the GPU powers down, and releases its
> CPU latency request, sooner after its last work.
> 
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
> The value is downstream's idle timeout for these SoCs:
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm630-gpu.dtsi#L71
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm660-gpu.dtsi#L73
> SDM636 includes sdm660.dtsi:
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm636.dtsi#L13
> Downstream reads it at probe, restarts the idle timer when the last
> work completes, and slumbers the GPU when it fires, dropping its CPU
> latency request:
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno.c#L901
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/kgsl_pwrctrl.c#L2981
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/kgsl_pwrctrl.c#L2467
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/kgsl_pwrctrl.c#L2753
> 
> Tested on an A508 with the previous patch: 1381 GPU power cycles at
> gaps from 50 ms to 3 s without a fault. The A509 and A512 values are
> downstream's for SDM636 and SDM660; tested on an A508 only.
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_catalog.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
