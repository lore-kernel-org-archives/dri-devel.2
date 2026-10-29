Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC2606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IdyJweug;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cPAHkPsi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0457F10FEEF;
	Thu, 29 Oct 2026 01:51:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54C610FEF1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 01:51:31 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T1jb531340155
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 01:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Rk9+wkvXRNptLffy30oeFYSi
 +1Wc6/AhSR14JPEURjY=; b=IdyJweugAsW4uikydO6c/JTsfdePltsT3KCRJr0o
 /2xODwtQyCtF7ELQaWuhZqr/JujQRu21pKJmReRe+yl4W6skPiD5tx3bsGFiV6nO
 5nLrq81IzT0NoFvpANvQOlDxqapzsEm/yOhw3aKYUEbijg/xGEBSV9FH3fo0RMSO
 xUgEeZ+aO/2RE/JVvG4t9oFWpUaHVEXEqG1R4mRTBJdQMmvwLHhg+ZZAYgDWJV3I
 qDlOojq6nRnyfGLCRQaJqTvt9cBVxcCBj2TF5BuUjBX/2XZX6ICbPYey6il7IvhG
 cvUW8a49ws6dd0ByQoPW9aH/uHV7cQEvsI2/qL9oB/jfkQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtnjtxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 01:51:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5337b591609so24775901cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793238690; x=1793843490;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rk9+wkvXRNptLffy30oeFYSi+1Wc6/AhSR14JPEURjY=;
 b=cPAHkPsiZr5lZ3bUUj3bVrtTAwqaSrG0nIQIu9KewusJWzEye7xI9dXzPlBv8ltErA
 M8MYJuF7eOzhgsTD11Ot/FQ2RjD45//RYysdNxws/qHT04+wLe71euCtmdcL9Q7reTax
 M8AHfOz4VJoGQlzqfaeoAJY5NjQxeKiP2NPC9T18RmmO+08+gZXK1juM+CI3yESVxxvG
 xdXGC1OcIlZlIhx0E1cTtnYTKCoqOn7YluopAVLc4TZU8ItJSxKPkofZsz8aT3Le0ZwV
 CkId2kWeT609PnbMnFQAqjMv2vYwvyJT52l8WN/bxHZ6WvwPfLSmWFcFTnwkIyEOsM9J
 mOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793238690; x=1793843490;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rk9+wkvXRNptLffy30oeFYSi+1Wc6/AhSR14JPEURjY=;
 b=wLDChYyMbGq+if/iCXsnaDoX4HZDI+ujPIn11jJ2i85EwqOHkNesZLmXzbWKbAaBnL
 Ch3lhHdFCtbXsHDWsBzhT1BLS4Qg8k6G5QnS4XZ4QQ6W4GLIQ9MgVg4Qevjav2YEA4Cn
 O5jXzTp5F22ECyE5CWB9q6AZL3aHszzBAPbEszV3ohYHxNqTMR4QGWfFeJNxMqlPTP/c
 8esFa7NPfcRPTnZdIzKBbi4cu92JQ+zY5TN5t7P25Ii3Nvn0mqzxydMtUzYYTwDJJlTN
 kxJZC7cQeQ50drPASdQdemyFvmG6glndKdB3NTWXdlHkNCVaTYEq+DJ0V+spc/dUfIZA
 0jWA==
X-Gm-Message-State: AFq9FYLOfE7eRWExUwfIF4phL028P5/ubPVJ7juMDy73hkJXpA4+9V3R
 OElveNj3hBQseABhs/KSLc9Tb4Y+c9q5iy1g+N1SuvTq0l2sO4rrHr6dv8OYYKlzFI5LiUFdPyG
 vuJM1RUSoM30Oa/VxCOo7pvUdTlRFb1C2rM7a8XosNIUl+7hwJClwlLWtOoKEG5MIWAZx/q8=
X-Gm-Gg: AYBFou1XSvGNP95gM/sSTqRnfYHybvP0MjYA4s4cAlIDJEJ9mwncOu+KC5bFP+guqjq
 kAuRTzDb3jSwOrsQ9rT1ANZkEeen8RJ4su55jssCnx/+EL591VyxwNx2PYt4jv8KapGo/AdPT6m
 yNL33fmFE3ksoMtTCf/zLMMnWW7LcTf7yujJHtyvnEqpElr+9YsahlKE+3gi5H+ihyheottKjCQ
 mv5VhREtgyk9GkcMhtRZALLs5O/65WqOf2M1E3vsIYdrsyKEilbZzaKPCa5wZLPmeRttKhMsBDY
 SaSc7gn4dDz3Kz6ZltV7GpBaF3OVw92Ro56nfgzCo+Qg3Kfuyoxl46zndp91J9UaRz5k+YP7Bo9
 GXOrCVIkRX3FHBOLlHzEyayOYfzxVKPU4j/MaS1blSqGhjyKjT1gzFUEFyJBk2/gYkoSgbab4vD
 ljB/CJnOK8KCz10EVG70oOcHkKEiDkaUNldZ20+zllWMKFUzvYvv1upudjZkdrHg==
X-Received: by 2002:ac8:5987:0:b0:535:958:b9c1 with SMTP id
 d75a77b69052e-53fc8bc2e33mr71787781cf.11.1793238690176; 
 Wed, 28 Oct 2026 18:51:30 -0700 (PDT)
X-Received: by 2002:ac8:5987:0:b0:535:958:b9c1 with SMTP id
 d75a77b69052e-53fc8bc2e33mr71787621cf.11.1793238689674; 
 Wed, 28 Oct 2026 18:51:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f33b5sm34356161fa.23.2026.10.28.18.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 18:51:27 -0700 (PDT)
Date: Thu, 29 Oct 2026 03:51:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno: Soften no-firmware message
Message-ID: <uoziyz2q5wmgxtlchecfm3bo5mzlmxczldxfq5lsutrst7nrdx@5dk5xtwft5sj>
References: <20261029001601.82269-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029001601.82269-1-robin.clark@oss.qualcomm.com>
X-Proofpoint-GUID: oW6okDTcqDE-Ueg5oRmvhJ6bD1hTXinu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwNyBTYWx0ZWRfX3/zsIbJrp1xG
 9DzgRzcBQqKMRwcexvz9qgG+gAxV5ib29s1Bt8EXL7JrzswejQsDsCb+rUQfWiq8ktISP50pYPZ
 l8fygLTMuXCq1sPOgELR+h60SgUTARtZtDAvpu3sHYZCKB2I76CR8u70c7Hgh2j68K/t7iaNYzu
 Q3wJpp8DVEIAp5JFv15grFPC4wQ/ePe2mgxnFPjZXoYcf48TKdQS1KWc7A9YH9dcX+aE9HDqjr6
 zC6DXrlcOA222X4ZxhzB4GfiNfAYMlFXwDHhXgWzp+GcxIsddBgX8QaZQGKr3cm2RMm2L1GbA8P
 Dkcmo4ffh7ssXws9fwv5OWS6nCrvXZiAqic+lFYkV1s7V/MBQj9vuPDzn2aRvYprVUCWyA3xtZC
 zxplaEkeJqM7X01TtsCRHwr4+WuU+QwjPjcJSirgSFwlLPmLTbfbZk7mHCT6p+shB4mCqT6m9Lt
 WjYrvjLnnZB9DmJ9rwA==
X-Authority-Analysis: v=2.4 cv=c/A+0h9l c=1 sm=1 tr=0 ts=6ae2a6a3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=jF9eNvnS1b8AvMrK6iMA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: oW6okDTcqDE-Ueg5oRmvhJ6bD1hTXinu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwNyBTYWx0ZWRfX/nJdjexSEr7A
 ZQjsJeHNqi+FM6JJuBHe+CbEBkYe7jPRFqRNIRkjkp0VdHB7C0o5NMez+3FrzrfcY3h2TOwwwdD
 9J1luT1hc7fnkg/oy/3LHDtnwsygLYs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290007
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 05:16:00PM -0700, Rob Clark wrote:
> It isn't _necessarily_ an error, the driver will try again each time the
> device file is opened.  But if you don't have GPU fw in the initrd, you
> end up seeing this error message at least once.  Which seems to confuse
> users.  So try to re-word it slightly.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
