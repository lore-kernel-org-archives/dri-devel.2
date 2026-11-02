Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1B606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FOHN0Jo/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y3Peimu6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6E889E01;
	Mon,  2 Nov 2026 11:37:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AC9899D4
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:37:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29APIU3086563
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6c+cSECcs+et9sk6TFDNZhsmC/63A8z1age2GpVsHLs=; b=FOHN0Jo/PPK4bIMZ
 8ckz8jaPw64Bt/NYZ5hr6Vqm9EXJQX3hi49V98CCSiVnEzYlaNbn8uqQlBfL8wQG
 6NiI2Yq6NZDrECUimUKIRzfF+qB+WavE5yfEE533hKZZZ2uNT8tYmN3qFNmn/o/7
 qIXmokyr8r7n6iM+9Wo25RlFB9Tb+ZcWy5mAPwMmDrwCeijBqm567M+KSduQMwf7
 +QTurWTUrHxW1Tn4bmcm1qBSPRwc/Fheu3cZ4tDlrCkNMrlvsgLRtXzp7kuQb8Yi
 /jxmJGjjkgXL1XF3o0iczOMKPpntywZjNc2lGqQJep7KQVGZvTJghg3vYlGSzTf5
 9zntRQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka61kbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:37:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1f1f2ecfso48830585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793619450; x=1794224250;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6c+cSECcs+et9sk6TFDNZhsmC/63A8z1age2GpVsHLs=;
 b=Y3Peimu63ySj9aXFRuc8P2f9rJOMX07NwZElH6k6fIjcdE1SjEM6Frw6s2YqwBftT9
 4wyQiSXKmN5tCQvAVl//SPWoWkhs4wEoUmSVuseI6cblH3oBWacvLqDhZ1Yes6FRg5Pc
 aM/IzmrGCJGv1A8YRoIXgs//dXX+rZkr6QDl/wFX0QccniSuIe3De2hU+3JFYfgEIPpW
 VYZYQRuHpGfBXBhRXGFZa1nSmYsTeHCHtisSBagF6JGcw4vUx9ZqJyCnnv//A+D3rW0k
 PKaWzSo+bUbQ+dESQ2wWwpdcbdEaSVfprT4N1uriz7LiUj4xHBQ0S/xm91ZypMQnlDRv
 nqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619450; x=1794224250;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6c+cSECcs+et9sk6TFDNZhsmC/63A8z1age2GpVsHLs=;
 b=KsqellKayegzSMRbnH7hVEEEBY3SX5SLtWFOEpn+QHWztSJziBuh3WPjLMDrDeASOU
 u9V3ga+f744hs9BrYgqzdeKSpDqvy1WV5NfpJTzBFopTNdt7Gf1lcJdrdUv/kkxM6zmV
 bkNoh/FNjyfrDoi9BgXolecI62p6SPBe2d4vIuJj0JL8jijTtmqyusqbyqCPsrXgVf25
 gyciXzXN5XqKxEmVcb7Zw2BeJBZ3e2Tb8JfrblZL7/KxPeKlIcw0mksmLqgvUhBz0wvK
 4TObsliHReE84dHmBAfZ9ttDz7zKB3j01/OkjWsV3cGSFV1bfIGjVOkLlB4dUF85JsyR
 B47A==
X-Forwarded-Encrypted: i=1;
 AKwUvBylDadoqsddXxwp0QpY96Vf1aAcfJExxB5rKjSBFe9CL1Qj0N4UKt4ytQbzyk4OAQc4a9aNYnKiOkQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKz2yCgzm6lYO74UbomLa/q2dRKPV+9ktnHBq0JZ3bixE5Ucend
 A1LiV/nPHryBou7R1wHFeUPi1VhAtI22a06kAV5tbCH+9W5YW0Q58iFAUt0MTGhUhaE3YQ6QNf9
 Bqb9fDcfrRpuW1nwqUXZ76I1F9e40ioSwnycwKN3PFbQ4EELjfjR+HH2WfUtKBM4t/TnuXdQetH
 2LlwM=
X-Gm-Gg: AYBFou3O0T8m9FUajz5KSp82/5G0Z3xQote7Vfr6Y3gXB/JN9Gq5qEVT+Q8MVCXZ4Oq
 DMmdiwvNclHWuUIZ7arf/4QPa5kU0OuB1tMYjxwN6/KyY2YL6cmPcBvKwfETgzrlEHfv6+dwCMU
 0lvYGS1xowrSwEfIuTeLyIfmsxRqAp1yZuOXRqEFdo1ZGoqnxV1HbRS9SC6wIFXFZg//zEaw0jB
 +WXop7RQ9FlRS0LOJMiMe6P5tHUQgYFySyaOPtfyAzRa9S23c4/Spn6mNQO0ZnkfroeO/2Y//oW
 IGFvYJ3XwyeRYvZTn6WuYlXgRWaBY83KMsFArpuNB+cBkj2u0dHoemVWgJKjoSXrv5qLGO4/ELA
 Xwld7/jyeXDftcJf9uBtpRJ4/SSGHFb9hIuVDq43q2Vrui3Z5CyZtUdYkaO89ns3gj5FJgNo=
X-Received: by 2002:a05:620a:72cf:10b0:93e:e111:2771 with SMTP id
 af79cd13be357-94421619197mr1571833585a.2.1793619449779; 
 Mon, 02 Nov 2026 03:37:29 -0800 (PST)
X-Received: by 2002:a05:620a:72cf:10b0:93e:e111:2771 with SMTP id
 af79cd13be357-94421619197mr1571829085a.2.1793619449327; 
 Mon, 02 Nov 2026 03:37:29 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfd22bsm372126866b.28.2026.11.02.03.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:37:28 -0800 (PST)
Message-ID: <b967b192-b34c-4def-b7d7-35c0a21cddd2@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:37:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] drm/msm: Keep DRM private data separate from GPU
 drvdata
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
 <20261030-gmu-sync-state-fix-v2-3-89d3082d97af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-3-89d3082d97af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jzpQ8UyfWbM-CV3SvN2QOKm0QPj5EyEN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX0vNFTyOuXvP7
 z/9Qa1HE0+CeZXmy75drcXXhdtOgTtlHaxPAhKbqKO1DTs+szhXpHw39qHWagKGtZ6QD8h982ER
 4xQT97XGRLHAqOYm30PxtKbz9I1VIQk=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae875fa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ifS9znPv-Fj3RtktaGwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX4VZmR/Moosfl
 cwq+4tFKWE0sFDJSy8M5XZXHgwQFld66N+/VIFosjgIHtjnywroHidN6PSLJLCuDBsprWO4xZcF
 KZJ15vQbaXgJBPRbw1vSHcbGoCSA6bnImf03a0vl4zesHRY8GgBhC90TM7PPzvkfbthZvUlF+wB
 U9LJ1Xvaz2fu+QuXXGWtyEMKfMgYzkhbp3XR/B04kYGSmzvfr1uRYtnxHGS73Ho0HwKnULAWRPT
 xs+OLRUp+53C0n/9DcZNR941dyu4948Te6MAXklJdHQEAS5Z3RrzZXDsmyFTea1TTINCLIovJMJ
 VQwyFDjIzftp69QdYpHxuWbAZsoLXYVIacdG3zH5US9dzXl7UFDn1lR4T2EXiaqlFOuWlyHKsBo
 chqxeEtvxBQRxv6MwY0XLVQYwreW1WLsOr6FHVYX78k4opMaT+bTsCeaacq2XmATdPFE/BncpKw
 jJdN4+F9550PeBckKZA==
X-Proofpoint-GUID: jzpQ8UyfWbM-CV3SvN2QOKm0QPj5EyEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020046
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 6:09 PM, Akhil P Oommen wrote:
> In separate GPU/KMS mode, the GPU device is also the DRM component
> master. msm_drv_probe() stores priv in its drvdata, but msm_gpu_init()
> overwrites it with &gpu->adreno_smmu. So, it is better to avoid using
> drm priv data in the master's dev->drvdata.
> 
> As an alternative, store priv in a devres entry of the drm master and
> retrieve it from there during component bind. Update all component
> drivers to use the new helpers.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
