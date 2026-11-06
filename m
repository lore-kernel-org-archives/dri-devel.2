Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE9606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LWd7RSib;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CI5ky/iP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C37810E31C;
	Fri,  6 Nov 2026 09:15:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83E210E2C8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:15:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R96D2333819
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 09:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WOvgA3Dd9qL5xew3nXRI7HiQdsmXf/0pyYG4MlTBi3U=; b=LWd7RSibu/BXc8C8
 1ooN4oJSnFH4vqexewTRgqXn8C9MFGV6nE7By94Q9Mz5Oacun4yMVGsJXx4foTQK
 8sHtWNJAjUYkIKGVtqGc9VNLBHgcJ+8GiX5mhfhLB+kEC9mtfLiMJToHXgsYFyoA
 JVqSJCp3Q21+LuusrZFHvtQhW0+tLFGmFRHz/iGcUr1U5SJt74jlKs7DpBrb/TSn
 2gLsdusz4M/J0NX5c2On3J+UggLPJdnw8XmIdQbOcE6U0FSG3obpCqUGfdw9vTSH
 vbnGMhDCDxcvW/Bv4wv071Akcy20c7IaIQo3hmThg7ZOuDlmn0/ke71gtGvN3+c6
 NhmTUg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9a4sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 09:15:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb1091fffso7639085a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 01:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793956541; x=1794561341;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WOvgA3Dd9qL5xew3nXRI7HiQdsmXf/0pyYG4MlTBi3U=;
 b=CI5ky/iPcQ+RTAxvrQ7yQ+mineSWU0Y7/bQW7SQ4KHg/ELkvNRFHnvmm7k+ISapS8T
 d6TU/zjPwHnWvOBP11RLJoOkM9+o6cka9s3GMNHzsB3yf1ulKZnnE3RyDI1I8vAB/V/9
 O6PEyYtjjlAsDgdUDIXVVv7PH2yNbocwal/Snrega+b3RHb5oonKvFfA5V4aiCeK78Vj
 JNe0tpgV4Cwd9diHEbZoXabjW30oCeZiCwglQhsJm3Zc4qKwJlx1B6ahIqONIFRSxs0Q
 vIGIjCYsOfYlNVz5DtvJdT5Y+Ru4+pfb/0cOilwaepJYNb5gqjFNHT2jT+kIFn09VQbr
 x2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793956541; x=1794561341;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WOvgA3Dd9qL5xew3nXRI7HiQdsmXf/0pyYG4MlTBi3U=;
 b=XRaAJRAnDA31LHenzTvDhk7oA/FhVLzz9+4izkNEeQ364zXmBIWuewRsmzrWcTyKRm
 2MnAjeF38hfuY511yy5mf3Sa2VxCUcmNiKVvXw1hCXN6gghTxlv+9gqm5B3GRfMkvw6H
 MiI+m13mtesp7jBWLReEZt0jMZUPuribBQV96lx/POQX038P63xQPXVERArl5jKtzrS8
 5zuxROzoxKNAEpADmizdql/NzddMmYQrPPacyTXKPbE2YAJiOWk1G2Za1DkD/DT4if47
 BvpaIMMSrIDjYtAbkgCmIkdtQaRMvXJsSx811HR/16YR3a+/5WAlg6WfqG6cQrECwdHN
 jdhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBylnMHLWw2Y6FOI4vOsivbN52mMeOicmyEzUs/nkcbDzVzqyPtCfsMURZm8DlCyrMHemAcLuLbdDII=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Ocl6ayn1JRA2f5YRXjOTO+CuuYVklYfFDxibD/2hSv4aRinvu
 VBx8+TOSNcjdabqJ/S3PcZHzqlC6q2BFoy422wjHlT+O84IGDr2TwgtEqfmMu6boMh0eDNjl+7B
 J/jp5zoWIl7Q9T/VTZhBkNpbZ5TzP3eiPAbDuNH9+0d5f74FRV15FVUSd7bVHov+rK710gdw=
X-Gm-Gg: AYBFou07Wu6f5X5QYYM50WJsQ4OLlllQnsaPyLZTg4oSboUFPLW6JWjfRD+M2LQG0Xz
 PJA9/6PXgojO1s26S8KC5Syb8oUfamBDl1JeVAxT6bu66PYhZtv6IVE45gMpWwKUqUWHZgjv/9C
 qatLmXSffnGa4mpC+YKiwDo2V6L1SDtJf8klmr1p4SdAJUNyyyqJCaGWSmYqhpD8l5OtEZsgh8l
 It2FgB78CPx2xPJEjApC/L7JpVow5ugZXDGaSd8dbeqi0cL/g6pDyjpcAZ5OgyRCygJ8FgVBdlv
 uJDUlZKGAltHqEr9gnworPno8SdmO/GRl56IMouBftB5krePPq/PJIj+DL2JKwg+DcS0bmRfE95
 YOWGHP/69naakqbGmuPaY7CiVKKYjA9UmcEuUwhM104ys5GDjuEqlWhzEW8OjR31aV/zw
X-Received: by 2002:a05:620a:a994:20b0:939:8148:1e3d with SMTP id
 af79cd13be357-945f33c0c23mr263242285a.2.1793956541193; 
 Fri, 06 Nov 2026 01:15:41 -0800 (PST)
X-Received: by 2002:a05:620a:a994:20b0:939:8148:1e3d with SMTP id
 af79cd13be357-945f33c0c23mr263236885a.2.1793956540624; 
 Fri, 06 Nov 2026 01:15:40 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3569e9f7sm61637466b.51.2026.11.06.01.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 01:15:39 -0800 (PST)
Message-ID: <96cc1074-9e08-4d72-8ffb-598e120d2055@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 10:15:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] drm/msm/a8xx: Stop getting GMEM_PROTECT from
 nonctx list
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
 <20261105203057.66520-8-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-8-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: e55q1goou4IgN9IzY5eAUfgm1yCkBLEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzNiBTYWx0ZWRfX6egnZTwUt/aI
 T3hi4n0gbj3CyYls5vMvL13mauXkAVZUhxhJqdDoaUwaQ/OtMCmxNmsXEJSL2+b+R7LLQj2zhbR
 nXHfjw+BXfzX3oH9D5uKdEbNF+cAu/5q/JGa7M89sFevBRhyTyC/XZvtCU8B/oaV6jEQdL8ItAA
 D2lpoFmJLXZbUF3t6Cp6ZKg/vMVc8Xoj9oZor6qfdBlhYHQLnlEd0t0QKGxLupfckjkg61B2Je1
 sW2NBl0el7a7RLOtGxgRkyoeD/g5AcOFwMRTxRZo3UjoVrMes1Q/V2msVhQw7UR11bLJy8ZugYp
 1VuxnInefygCKuUT4B/UatbHig8Eg0KYKFMRLWrbjiS1/mq0O/La7mmRoOTiZEVWky6ZShE1zLK
 WWff8bPRWPq6jyh4rb1R8bsGtHhexSWEOJyoMIblMlk0tZUSjn1aNi9bAaMA4c+QwoYq3Nfken3
 s/DP1z73I3GzPw963CQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzNiBTYWx0ZWRfX8E1tuCdxLJp8
 W3OsZ0H26AUuoE1X1sg+7CPutp2vp7iAfMamdO0Mkc6tdk+3G2GdsfY/jWTu7+vowcC+OH6eXs9
 JhQXwV5UjYV/v2nn1OEFwLCLhz+Dbt0=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aed9abe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=J6-XaVkY2UlAEipWW64A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: e55q1goou4IgN9IzY5eAUfgm1yCkBLEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060036
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 9:29 PM, Rob Clark wrote:
> We can just simplify things and calculate the value, instead of manually
> adding it to the nonctx list.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

I believe I already revieed this..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
