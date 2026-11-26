Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AA8606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BK4TgPyU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UBebFP8y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB591124FE;
	Thu, 26 Nov 2026 15:20:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C6F1124FE
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:19:41 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEV75r2649675
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f6YLhLfLVjeLIqcNMr5RDQlxnH+G7D4G2SjsiKW56tI=; b=BK4TgPyUKEgrkGSe
 cjfO92XyyZP48aQlTte+MaGUesyNPhaEwk7ZaDx2KEGdneRTe6sRNpebid2qa1Yz
 r/Oj7Mwrz4785tUFwSSU4yZBcZschjTNrclCBP2GZPIfPJmGZtq28fJrZ+RXPQv4
 I3iWgdXczX1687eCMp+GI4Jo8lp3hDp6nkjRYzWGTP3PjuIrmQt9SxM9/15bmHwn
 qYbeK+di1cPMBeGBwKyn8wLnxgiJOl8DEVOca6AyC4pe4ug9fGZUfie5iR/iKT4f
 Infz5fM2rvWvehlykjyMXWszZkNNaLwTps58iH2GcS3j+Sa1rzFwgpLULkW8knCn
 Ms6EZw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqg5x7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:19:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93edac5877bso100672585a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795706380; x=1796311180;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f6YLhLfLVjeLIqcNMr5RDQlxnH+G7D4G2SjsiKW56tI=;
 b=UBebFP8yphJWZ5IJL8QefbVgWjltIJF22YCOOwTqNIgTzMQ7/6r7zCYTgNRTMCZPSH
 3cqrIk+E/B8ENrlrKmLl9S3DEbd82KENlmFebsgE9ZrG9R5lCdQ7uZHjbK20Dgy5aH++
 B6LFftxJcco3Vzy8+NKSp34kkjpdo+wepWcJ3E+xjDjd1PNniHggx1YiO/TCjCSxcGJF
 /sBu/qDF8kuhQE743pgMVWiTtkhDeUzyVQB3a4rvr0N9Wq++AIkBP1LNbpCXYP8GnnWO
 pkFQJl6X2WO+dR/1ozKVH3ALvbXZQ8enz4P4t5ik1EapuMzVdF3pL2gS0PlNGxEtY5Um
 rOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795706380; x=1796311180;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f6YLhLfLVjeLIqcNMr5RDQlxnH+G7D4G2SjsiKW56tI=;
 b=Y/L54/Wq3noWa8qGONAhwhC427l+SQF85lRYav/+2FE3HmISsQsHt8groh5FMAGNDH
 wDYuKL2MmYIhZQVoGsyI+iIxZArUpF8P7vsPcqr3uUGEHMn3Ni7a93rPj78xT/qiXLGX
 EBmgqEvptYq3ICgfwW8YeVGK4Ch6mcECe2VfEIZyBwIHros+j54eqhqeyaJ7Aaz7zfPa
 54mcgx9Ksj9P2Pep9NJKost/Na2m6k6i8Jx1lQnSGV5sGboui3aYtQHwxeajkC1DIsw7
 IE/jkkdY1wxZkDQ092d4MdHF/lr8UA7U3g8bS7XANZLeNQGBOEDYDmTgnshOgJKXrRx3
 U9jg==
X-Forwarded-Encrypted: i=1;
 AL+hErHR6uROBe9PAJEdmpWLzkFqf9qTcb3Vxl9I8Ip+bnbvq3sacWT34AOO9/+qTMfhZ6cBbeIO4A2Ie+Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/y1wjaFwdb/bGu45RafSLZDsJHHcM0IA0f1SfuF4cJrPxZawKD
 jG9C79LM3LyBnI73/mK4LmyVWT/uHnQQ2LtnYoE8ROTLlhoJtUT7Zq4BmEdTDsg9HxSMQ6tknAz
 LFI9TTtHOl+8ZPvAtXLflZulFRN8p8m0gO5hK9UKIFLkub64A7d6PxuPgap9cvd/88BSthM0=
X-Gm-Gg: AZFdTZc+eoe1IX5JG6/FNh2jPlgI3SIc26ELT6+lzibf1QZEcOjawrHy8wKAzNr3ANJ
 Jd6EjSNv/BC4LlJjrmXqkfOIx84JoDr5cLOAzyu9tWUQdnwf+jDAt574zyFRrJ9IgFoMunKP5nU
 JasOPcF07GhJrUotUQc8XvRrEDDvDshBUjrKRDNoZ92mH9WNFPeDAuVdT5UJhSILbG3yp4wzACs
 oJOwB5LSzC/00rsc51Ok0dUBVUsfm2dwvqJ6uV0ccXsp0xHfSKQpyM0H6Jj/hxZ9j6jkNdc1bD8
 uL/WSN/mpzXyG1DRqkFBc225CE83FGnZiBiD0Z7LL2V/hKEO5aL7+Z1JnZ/5dM16mLxj26YByOZ
 K2f0Ie3/WxQiklnRPuvYfjLjVd/tknaigFiHYy0FCxisk4TIp640hs384kDcppeM/4uwFl+U=
X-Received: by 2002:a05:620a:6f82:10b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-949ba7fc843mr3538274385a.1.1795706380375; 
 Thu, 26 Nov 2026 07:19:40 -0800 (PST)
X-Received: by 2002:a05:620a:6f82:10b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-949ba7fc843mr3538269785a.1.1795706379937; 
 Thu, 26 Nov 2026 07:19:39 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37108c8esm9867226a12.31.2026.11.26.07.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 07:19:38 -0800 (PST)
Message-ID: <c351c004-50a7-407c-acde-0ca1a615efa2@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:19:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm/a3xx: update the CP_ME_INIT data to msm-3.10
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
 <20261111-a3xx-fix-me-v1-3-d81f50f1ba1e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261111-a3xx-fix-me-v1-3-d81f50f1ba1e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8i-aaJUxXX8LiAT9NP--Rmc1HxNJKZAK
X-Proofpoint-ORIG-GUID: 8i-aaJUxXX8LiAT9NP--Rmc1HxNJKZAK
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b084e0d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=LkFtg0SWbGx8eehL8ZQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1OSBTYWx0ZWRfX4KytHOKPrUFW
 FRm4kK+ND3XzR/MgAYGxdh/hTGNRZszghf66aozty6BTrqsXYVwQs+lCRQJVo3TZwJnj3IK9Zmd
 ooKX50NSJxggXxTvT8Pwr4JHFcmBAlo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1OSBTYWx0ZWRfXw0cFlqNZJmIz
 FsFcQIN5zDE5xPnHiqHmdqBW9DNVuZqhwwB4RO11cLgNVqly4HCY33ofpwXCfpw37zuRdvR8xL7
 AZNjqnzLhfBk8IAXxkfHKAav1LeEbS6ZhcJ/TDw6B0Xl0vFgulZmtXfzND8raGuhy0J+xRp/p/L
 o0wSFek/HZoPPmd1+rx+/otGz5gFlgwWTz4ry22Jl8ADaTf7+RZnxUYHPTUyfE0m+FZVaJOYTMl
 Ldx1BEuPn4WJT4q3PI0CT/CMwUut83VAD61wPSsEVz9zmGxX8xlEzYkS0wtWfF7dtcv62h4/2do
 yXduhrbt1HAeiCSiHMlP3RBsbDlNnalGmoDrrzHNysmjQwXek+1Kzl6TlGwxg5GA59yWvEOZnOV
 R4vRMZxAKh/UwUdhy9j1rMSu9en6ojC8NCPgj1GnQfoWU3AzWnCVyx6ennAfYMJjIPu1eItO6xH
 1ud6XUqqhZW/2YAdHxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260059
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

On 11/11/26 2:05 PM, Dmitry Baryshkov wrote:
> Update the CP_ME_INIT payload to the values used by the msm-3.10 kgsl
> driver.
> 
> Fixes: 7198e6b03155 ("drm/msm: add a3xx gpu support")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
