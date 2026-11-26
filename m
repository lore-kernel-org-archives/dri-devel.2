Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704CE606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fel4mEEB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b7MW+Syc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9D11124AB;
	Thu, 26 Nov 2026 14:48:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8253D1124AB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:47:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEVYGD3298806
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8+yhG4UOZ9G9+Wb+KCpqRp/WNdBbXiIFvkS5c66yNN4=; b=fel4mEEBzuPxWI/Q
 FGaSuwN1amKxr7mb6Uqomci/2589jz2JZTO9djkwS0SgTG0ZifkeXngRrAEPBRP5
 g7V1MDzMFfBsa9rNfDx/RS+VEZoTNhEpO16hkCqRcFVLXQ7m7Jy3YwT9HPRqWjZu
 7rNrKoGnG62YilLD5dsv04FxAUlDjlgbBQvGhJbTx8ReqIxHqf18GLTkCv2wuk52
 TEkrwaOAMEnwBv39Jn759OLHCpqTmDeaN+gIRYxcZXucprGeiQE4sEPleTFJzkx3
 MVn3DsuZfD+A+90gmjYtNf+oaHrXON6vrcr6Wy8SjuifYsDbBRtH5FqcFTmegNhT
 tUTQOA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak02pth-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:47:52 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eaab6f56c7so360635e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795704472; x=1796309272;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8+yhG4UOZ9G9+Wb+KCpqRp/WNdBbXiIFvkS5c66yNN4=;
 b=b7MW+SychoUNbO6x8ltaEy/JEUxzvi1uDbnBqwXF2Tydypna+NGvRyimnqZjgxIjCR
 mPtR9oAyvirp87ECe/vfMzPWZ+BzJkQSQ4fv0Aw0xIhW/BJzdmHiZKZ+GFWnu8Xr1azn
 ajHPeT8OC5UQkhOJWWij9IVCow9Yrx5e/17o3puOG4IS/BhpJsKeNHQ5OIlM4G5ZJoHD
 3HO7umqF8csSQYqxVrLu6HaP2RY4Vvh44jjl5ARaaHwOFMRgXqdq3utn6gBUrwS8PsPL
 y2XSMP4P3vmMjcH7HWKlUTYLd4RaYKNnsAlEvE7vgDHbPi6UxFSPR9pMjzb4y2oPbH4Y
 ZvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704472; x=1796309272;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8+yhG4UOZ9G9+Wb+KCpqRp/WNdBbXiIFvkS5c66yNN4=;
 b=N4GkNEIRPCDo0JGo2yUACuRJT/s3TdquRU1vWZjATnyIAo7qU8DxfqwFYeILVLjbYh
 axuqMvYjvzHlgl94cpf8kLv2uvsrtpIjTrfGj9fZKessT5rNFZmakIzeUuvEgHXcOlKu
 jlomSs36StqVYR+KA1pwyNS5ASg9s7vTi+I+kjeUTbh/xdNNpUopVFRlwRo4SvwX48vd
 K8kH4ZE2HQzHNaP1dcJa4c3ph23zfq5TuP6jphJ5/aU0jKtwLz8CN3jvuqjVHhWap3Xt
 pZCefsYgrRuzZvh2dKt4tkhil/ze0ZP7rkMhfm2L0h0t3hSypCEwel7/YCP4P/okDOmC
 ZM3g==
X-Forwarded-Encrypted: i=1;
 AL+hErEJR6x8XGVmGeRM3fbqq4y93FVWiss5S1nQT19FCoTk7AdMDD9VXyBPfsNBfFaZA32LJRk2gVvJ4oU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+wc1ZjEOf6V5hNIc2Ox1UN+hp1KuilmomPPY3CSKKwM8FVpZcM
 TRouiDc3cv3oAtwKnwXfAfn+NpHZq4O07gQmosq8qo1mEvPRgzjXm9ucipbnijHdZyB9SEd5j7k
 mf70jfSapXeTPLbcZDp6STBTkR77w7rpaDwH5vIiDjDhDj6av1OfleCQpSU++H6QRb4a0JuQ=
X-Gm-Gg: AZFdTZcYcAPp55WCrJ1dMHWuLp7s1T/JOA9BTTVB1XL5AFv7JjbHKOwZeYmUaupoOfu
 mOBnfFh5KtuTYkoHxdSHz10hfZiAj/S45QP/RaYyAgD28Al7aGeVHpniRFAih5zphVBnoRzWkl4
 FA7JMlM+NqMbB5pbe+5bpS6ETVv/fYjZB+cmFdBzRln2hUAnpZdCz2sGdQeEKKKvzinyvRXA53K
 RABmLum2UvXfpdQkUaMXo0EUPXFjTSwSPxGuwziaVs+eOgVcO7MfBRTeKwyLcQggvpZz3DK6Cd8
 l2T1YhVUh5kbMJCp8hxOucLCI0Hk/EXSF+wdRy3Yg7gu9Ff3E4ZbsUC7J0lBv5S+4BsRyM3v69V
 LRv2m738JdJ8V5FQomS8HwBTic7TEPtsmMzqgmI7n2PT/JCiTz89C6RLYdtMivVdDqO77ELc=
X-Received: by 2002:a05:6122:2b1:b0:5d2:d60c:6c48 with SMTP id
 71dfb90a1353d-5ee8ad0ec78mr13495181e0c.0.1795704471725; 
 Thu, 26 Nov 2026 06:47:51 -0800 (PST)
X-Received: by 2002:a05:6122:2b1:b0:5d2:d60c:6c48 with SMTP id
 71dfb90a1353d-5ee8ad0ec78mr13495130e0c.0.1795704471268; 
 Thu, 26 Nov 2026 06:47:51 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba6f8fa5b9sm8301224a12.37.2026.11.26.06.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 06:47:50 -0800 (PST)
Message-ID: <a005f8a1-76a2-46ce-b328-2063bc307758@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:47:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/msm/a6xx: Add Adreno 753 support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
 <20261118-nord-gpu1-v2-1-8d6d9908b7c5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261118-nord-gpu1-v2-1-8d6d9908b7c5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b084698 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=GS9hGxBgXBVpQNT4ZgUA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: OV5qhEULQocQzX_F3RDFew-64csxwu5t
X-Proofpoint-GUID: OV5qhEULQocQzX_F3RDFew-64csxwu5t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfXzKJH/e2RHxn3
 g42jDzxs7we7w1sY6LveYH88ArTFpsE2ThnoJcSZuXIbWhAgG1tZYc7CEyBcPCFtZcsgf+31xhz
 s7cmJV/QU3rwP5o+2+L/n0nOPGEGaDUxMP/pqIO5lHFNoRSNm9+029tzLNMFRh12YTrMWS9DxA/
 2zr6LcStgGKZCAQdvaDNBJLj85hhJrqnqo45nT/Hp7N5+5qE2mYtSdV0ROlUXjPxtMM6dapQi/e
 dzHmpb5kQW0amkz5N4e69P42+jLJt4i2e7m3U+H2LOPpSTG8T/As05fnwUhpaB6x7zdNOS9sjxr
 pG+NUVT9WPukP+94dejj904Tv64dFdPfCaB+K0CZKHC6ChurI6Iezlep/ew2ITfiuanN9hM/lhk
 9yPsIP9zOw4ndT68i97EeMDMFk3jxbWskx5E3hXq0ALexW32yK10RFEZem0FBE7iJ03fZorslR3
 SO6X0eFn4qrvYD6wcHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfX9EBTBZb92szx
 SCYwzsjtxFm5MJx5c9xqrdU351/yEslG+DgBCkkK+yuLKr+a6tZ2FAg0Nm1dMT3zMM2GO7FAGAH
 i2rhYoXDtza7usY//FUxiIxccO3TVg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260057
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 12:00 AM, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to
> the A7xx Gen3 family. It is derived from A750 and shares the same
> IP-level configuration: protected registers, pwrup/IFPC register lists,
> GBIF CX registers, gmu_cgc_mode, 3MB GMEM, bus BCMs and preemption
> record size. The differences visible to the KMD are the chip id
> (0x43051701), the GMU chip id (0x70d0000) and the gen71300 SQE and GMU
> firmware.

[...]

> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -651,6 +651,9 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>  	if (!(adreno_gpu->info->a6xx->hwcg || adreno_is_a7xx(adreno_gpu)))
>  		return;
>  
> +	if (adreno_is_a753(adreno_gpu))
> +		state = false;

Is that intended?

Konrad
