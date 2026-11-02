Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403F606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SHUGRsnz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PVMBrCuH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3948710E5A3;
	Mon,  2 Nov 2026 09:57:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C401910E5A7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 09:56:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AOkG3086546
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 09:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fSEJYomxVT5C4R68mRDSvCPQ
 QWerQtUgHd1oP8Jric0=; b=SHUGRsnzaCIZ3CjE1mv7LUTZlJPgud6ICwQ3ILFy
 d5/PVrH1MQdwuNXM+pK4dQMcEC+A47qdMlSrhu29GMjTBW4qwXAkTKpngIlJK1ug
 MtmJUQMs0mDpB6oV5gDOUcbAOBku9RZw2m6vumC0yPbK8SamG3vsN9W1H+v18LNs
 VqaFv2Gy6hZt3pjk0K+/5bwv6JzDwGe5xOp0StqkwNnAvi9b91PXrfSlCb596Fp5
 RLhbrp6DiGfPoz1NrqyPdPksmzxPRCedff6gXqQIlnOEP5C7161tNtsYhiXgmyis
 QeUw+FGJj6Oq7DKFVmdZmXoQawcXQ1ckNwzEE+WWxQ796A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka617k6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:56:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-943e8ff02d0so242203985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 01:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793613408; x=1794218208;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fSEJYomxVT5C4R68mRDSvCPQQWerQtUgHd1oP8Jric0=;
 b=PVMBrCuHwWdsQ+AyRwtoRl1EqdBQhRUHVyefefFMpbCKG2CuIP3q7rFOBSdxSvLpoE
 XlawBKsksqhS7thIOoHooaI6lZxLifIK44ESc1w3nN1NXGVzUremHHGt+s25CArMJt1w
 rz3ekwN1JHW0VJASNrs7vr+WUIFG6HwfsJG2MoRoQuCjIG9eSHS22Uo0yYIc2G4FLq3Y
 xcKGw7JUUlQSIZ1xdJx136W9BqztKOrAwgMi6//hjgtTWEtDDGhwdpzYWdO8l4ob1/34
 REn595WWIW3D4jv8c/KNdG5pL0NPfkhEc3dQFAgqt9R1Y0B4CKL26+mpCRpIPP7qbn+s
 foAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613408; x=1794218208;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fSEJYomxVT5C4R68mRDSvCPQQWerQtUgHd1oP8Jric0=;
 b=21zk0tkgGVyzaszL59Lhak4JRWAmkSle49rU/a2QJF+wxFJ2i+dW/1YeSVWQum/sPX
 2DrYWqUF85+rj/FxRbFYU6hTI6f77LUuPDLF98X7HcrMpW9lxY6O3zq9ozM2o+rJfxBL
 52Qftd2dquY1iiWOdeEadPM9oa/g0i80WM+Elx1gazJsyeR3a+pw18yjDcDdKqLV9NXI
 KsDIIqd1JgRvhssNQd3E4AYVXjp2mCkIxlgOSut+f8JRLAadVjtzrLVZNB502SX7t86F
 F9KrbwAnsbKaqgNSzrsXm8TlKf7445Dj38VGvu2YMDtirfbAOr8pdm7NhG1A94gFe/EN
 2lQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUm/M855so44hF/CDhd5CaZuiPFof5wpyNi6FkZHfgfNVO26kH3uGh1vPccBiTDHMGyo62PKEa0JA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxS0HmH8V2/9WiK7wJM/1Y0kAApVDaY9NqUHQ65gHHHO1Q69iG
 kJ/OA6uw8ZvrFDqr7qSNsZIpePC9K/s7XdGKUMWDZAnh3iCuQe3frEpoK9JpmllLiV/b8q0qeKk
 GGFcw7I6lt0TEBkrem+BEyHM+BPlNYhaJ2KGPibPqefwxSCp+Ibi0XmX8i3KuHpjmHua6wxk=
X-Gm-Gg: AYBFou21WSHG6dXeileFhCY9rfwVkw7HBXKz/XhbgO007KzLSkdqeelzMDI/oTj0Xgr
 IHiKK7ib4yKWbiKubHMRJr2setj1iBGMCGtY6C1dRpk+ky38EY4ecyfGdxyS2SF+Z1roXJe3lQa
 mp2F6PxPrloVN46rQvUjhxlbcDVdr/aihTItBdugD6+quCJHEXQ6QQL9RCMoTyCjYEPqb79ZIwc
 hI7WbR8uNOgFVsG3oHY+MjxmhCTz3wejT8dYnJPzjHGlR5VoTpc6iVNNB+plkBqGjY+0q0VEIis
 Q6XVqGFoGuTaeEyvZ4Mm46EG7QBHsRqo0Nktf7NJ1XGDwkYE0rEp+ZvNTLmmfvLoYODyJnnDA9c
 5hK4bNxNxxx+5fKw6xKOI7A7nyvrXxVJOFs/TbK+sorL4Yq+o0wrG+e08BtsECF6oWpmIkbnpEb
 rayPXehCCj7N+gjdULJ34dX+E5ur9FG37QNFCLBu9v2qRVJiAC88tFra+MdO7n
X-Received: by 2002:a05:620a:2989:b0:93f:5e6d:880f with SMTP id
 af79cd13be357-944217a1992mr1658097985a.74.1793613407843; 
 Mon, 02 Nov 2026 01:56:47 -0800 (PST)
X-Received: by 2002:a05:620a:2989:b0:93f:5e6d:880f with SMTP id
 af79cd13be357-944217a1992mr1658095585a.74.1793613407338; 
 Mon, 02 Nov 2026 01:56:47 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e5e6sm1554344e87.57.2026.11.02.01.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:56:46 -0800 (PST)
Date: Mon, 2 Nov 2026 11:56:44 +0200
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
 Jordan Crouse <jordan@cosmicpenguin.net>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a5xx: Write CP_RB_WPTR under the ring's
 preempt_lock
Message-ID: <bdtzw5qvdtsgeiqcr4dkvmrcnn7l7cznz2iqs72vjvabtvdbzg@ajqpgwwmmosc>
References: <20261031-a5xx-wptr-lock-v1-1-fa7d7b9a7fbe@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031-a5xx-wptr-lock-v1-1-fa7d7b9a7fbe@gmail.com>
X-Proofpoint-ORIG-GUID: 6BTXeNGXiUPOhg7rAy9OB6Ewrr__-uJJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX5H7jSKAG6t39
 jHlBkWWnNnJOcggs4IFUcFC8v3L8pIohK06y+H9C6E9cB2aGke6rTzUenPGIjJIBhix+luFcVpm
 GP2ywl7d7YyKyKYCIM2ClKW+a7eqixY=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae85e60 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=-lvlwEyg7s3_QBC--IIA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX/gC6A3Ki+AbR
 ulmmefQYQAzgywHQtj00skWv3tiFFX9GR9ijXX0wPPVYhD5VVlayi6i8HvRnck3IvREMCmh7D7p
 fOquCxEDwSovLwu8xExzIaQ/czHZBatZPN/GFIfsL9xl2cf5AlFikQbhT61JvmVw+C4KPETu7Fg
 9Sy53YWNSfqVIOlSlbLrpSrclePg4jAplKCR/0wuGfV1ZVU/5YzJTIncayf0O2MB7HGcbdH8Zj3
 UpTL79E3BqN2rjVeLK1y16GumY6agC+WPi1NCahtxQm3oQitk0Qy4Pd6K/OKgb7ILG4421M9euE
 eRJFMdK50cyQg9n7g2WKAqryqITmYko4Snd1ONNaLitU7BfVM6+CB3T6xDsJGgxDH0RjUh4W+Bl
 d8tyqRiyB2NeRal5u5G6rY7IPfsdRlOdPgb0ZOB2oI8pNnEQF+RD98Jx8MVY1nSNZeuPi7omp5d
 OTjXJ7iTZyZlWRa5H0A==
X-Proofpoint-GUID: 6BTXeNGXiUPOhg7rAy9OB6Ewrr__-uJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020039
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 11:30:55PM -0300, Fabricio Akio wrote:
> CP_RB_WPTR tells the CP how far the ring has been filled. Two functions
> write it: a5xx_flush(), after a submit is added to the ring, and
> update_wptr(), which a5xx_preempt_trigger() calls from the IRQ handler
> each time a submit completes, whenever there is more than one ring,
> even when no ring switch follows. Both read the ring's wptr holding
> ring->preempt_lock, but write the register after releasing it, so the
> two writes can land in the wrong order:
> 
>   CPU A, IRQ:   update_wptr() reads wptr N
>   CPU B, flush: a5xx_flush() reads wptr N+1, writes N+1
>   CPU A, IRQ:   update_wptr() writes N
> 
> CP_RB_WPTR then points behind the last submit. If the CP has already
> read past N, it treats the ring as nearly full and executes the
> commands left over from its previous pass through the ring. This shows
> up as CP opcode errors, and the old submits write old fences, so the
> fence in memptrs goes backwards. Recovery then finds no submit to
> blame and does not reset the GPU, which stays hung until reboot.
> 
> Write the register before releasing the lock in both places, so the
> last value written is always the newest, as a6xx_flush() does.
> 
> Fixes: b1fc2839d2f9 ("drm/msm: Implement preemption for A5XX targets")
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
> Tested on A508 (SDM630), with piglit's texelfetch tests run in
> parallel: CP opcode errors in each of seven one-minute runs, the
> seventh ending in a hang that never recovers; with this, none in 25.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # a530, a540


-- 
With best wishes
Dmitry
