Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A0606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B0W7TcKH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TdgalE+W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA7C10E5FE;
	Wed, 28 Oct 2026 11:10:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C27910FB40
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:10:23 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S8K8gq253377
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5zvZtmIGa6NExyZc8Y5XlEQJuWyGr6+9vTxKDmPXbhw=; b=B0W7TcKHoZmbnhJe
 xQfsL+9qVBpPiG60ubo+Uosw2UOGOOoKXBeZh5hH3inv0s58sOmmqNHyUlXMIt9W
 pLfkXADu7oN2VeCVl46ylXB2aUra8H2RKSnyMkun8mLBQpDjF+Bd2wXqK+Ww6ID7
 TKS1LaQyocGLdUFvvdfEamGdbGvBoGIjAUF3Ej5RdSTzN8hqOb5hQL8/oO+y4yq+
 y1X5jw/q7d+1ZoU7CuXD9GHq6vZCr5TGXUkk08beAEvFgNkYw1PWbVk3MzwrQ7A5
 bX5aOJqZpi/Lcx04rzwVTIQz3GxW2hemDD1TucrOve+NhzLToh09eNK0337bMRES
 I5M4BA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6be2545-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:10:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e9d52f684fso8219445ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793185821; x=1793790621;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5zvZtmIGa6NExyZc8Y5XlEQJuWyGr6+9vTxKDmPXbhw=;
 b=TdgalE+WlXKUrgAr9YqBDTMXpeB5Tqr2CM5PUMfxwiZpLjF9jXeFlPHOhaOxoJDG7o
 oVYCCv6d18dwtUEQFvRqJy6YiZwQYGhwCE6RvYN0/LyYpNwV0qsjzuH81WTwcVdJM4c3
 pN+N9FrNhwiSskEb4j5e233PyhMNxvtvIX9cyIQh6WdiLoSFFJa4Ynbqs86dJtEdtI2h
 pTR3DFxtrWKafB2SDdXboQKw3NFl3b/MnOj6lw4Xrj0Azj9mLzVLW7HSJWIANmPtfnox
 5liZ0Or0C4VnPytWjhnXlqtaLcop2gZcSSz5VDO0pqdNf9kYoe0CK6LmMWsqwZusfIfJ
 yNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793185821; x=1793790621;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5zvZtmIGa6NExyZc8Y5XlEQJuWyGr6+9vTxKDmPXbhw=;
 b=RuHmigt+hcWs7VwBVr8LrgTcGqTno7pE+4VCzI1nTp62LywzLspPiNL7QG8o9HdCSV
 YsX0Rp3OdZ5lcZXwtbVi22KoqZs7YVpjmhVH/G0WEXmDcwtU7NUHItaLxlgpwETT4PIM
 5YXZXP9XZoANh8VyZeviUA9K81omxXGw+BblX443nzENlwdW4LJHbGFwLuf8aVP2XTd4
 cvXkkhvI5gdX0zecju+Bio9VE7h8ppnoPjn2dvXGxnfSIQwn2NI6dISoDC3nGE0NqZlG
 fqFMcMOWYP2SB7C80K/yl674n0fTdMdF35Xj+w91mobVW7Vq3L3QX+ByY5GRMOEepg3a
 YYpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+c7E4xhft4jMqFaGgWKlvPLVOpIY8XaGZaGcch1yLy6C4iTS8z3ZkXTco5j3VdRBcTu06ta7T+eM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJBCGRe2iwWen59kX/aMUVOjt7YvlfC1wiAcEjogtDv4wfDV1Ym
 vKfQC5qBhnfbe85+yt472+vzK2GJT6DAvWiHTZJso7PeWITF94pwmmXkfiR9JNwMek9CTOldHcG
 b+r/STO9LS3vGc4hypBIHl/+H3zcUCl/zbe0FAXwgbTa70IAsxVb7NhiKkjx3Ypgowbk8aVY=
X-Gm-Gg: AYBFou2Ii2/tgyzqcamMTvMRklhSy5e/n+PwZfKEwhuyicQ+PF8cDJtQ0wUBAheZkHp
 zJOk+OkTJZxy5DxFR33BGRIt4YiasjzoT8FN93/suPAWYCIX6H/RguB1M9UfmIaPTQvjmfN+PDW
 WUPqEGKBcLxjsNf4l7GMkCF4/3cWW/GZ3+xTeJaSJdopyUAWOW9OcpNqkfWkaYAmlYxuTaVdrsH
 GCXTVN0zDL41Q59yNrP8StmHzxw8yfYLv/xi9fTab+kg9ToOi/MY0ZBc7cSr0o60welWp0K89Nx
 2BUAVoMqqHPXUNtrdiagbYA9P613QhaNKeDNPW5T7ZAkxEPfrCwj3fXiQuSecBZlbAdfpxAmPPS
 JrrCAw1bLfoo3RlZwb4Sj+yumHCfcxfbqXcTLQPTgHohUpTYlIamxw2RWvpWSNbPFB5f0LqH9Lk
 XOAZxrR7C5NfXs51d/i+kE/M7EtT8aipyAo4KUQDEYDao/VvfR9kdOX6pyGzFcJ4ZRQe/Yt75Z4
 7yv
X-Received: by 2002:a17:902:d50c:b0:2e8:3d48:4d88 with SMTP id
 d9443c01a7336-2eb00242781mr19066325ad.7.1793185821168; 
 Wed, 28 Oct 2026 04:10:21 -0700 (PDT)
X-Received: by 2002:a17:902:d50c:b0:2e8:3d48:4d88 with SMTP id
 d9443c01a7336-2eb00242781mr19066015ad.7.1793185820636; 
 Wed, 28 Oct 2026 04:10:20 -0700 (PDT)
Received: from [10.149.108.218]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eaf77e70d5sm13979695ad.75.2026.10.28.04.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 04:10:20 -0700 (PDT)
Message-ID: <4a51422e-01f8-4651-99b6-f7d3fcc588d1@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 16:40:11 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: mahua: Support GPU and GMU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7nT0BmkEWe4SwSq2owhk1MOCP0k9G3Vs
X-Authority-Analysis: v=2.4 cv=HeuB3SE8 c=1 sm=1 tr=0 ts=6ae1d81e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VMI7CB12i6EQ-IQ_HUsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX5s9i1W89Hxe3
 +sCccBnmyyUu50aiPl3dqmDDpWRmhGx6wRPXIaht9348KxTmEMvq+HtpWkcHW/PWPIvq3e0tdFG
 ErIYY7bx6V/yEW6mcyjlIsDvoVP3Vog=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX6W9zFyY4VLjH
 XO43f/38EqrGOHLTrxIinoaSEhMQYIqxo3/XzKCWpREFpeNfvlJ/9OhFlmY3N7pw+K5Q4l4Lj8O
 zWhhWhGcweVK8vBhy4BPNWrW0rp7GmOoom6Hing9rds+5EjXRH9oMpbXlxPaHn06taDHl0JCMSD
 XYw9VxwSJJVkX0uwe0/yQrOqoeRj3TmjYORMpfidQcITKKkmZ9dvaenqgxr9D0rT4I7cAD2bsAd
 skzxc2LVQxFkkpwFr3kSgLwqWbVUh4lTBgOKBTo6v1D+1LqvwkHKmhJ3ggRmsCHAXmENfG6RijQ
 e2X1dXB3MSPbvc4CSnhtHOyYz2M3OIJZuaJB5Y4JfHkmPvfbSIsd7yccEd5xHWwYXeYHz9Ytn4Q
 FOnU4tWrDcWxLhmbdx9Ly40jyUHgZttcfLyydbiu9MGvUjA5JdE9wAWeqENEmKYiuGrcFb8i8j8
 uE1rvHdNoRNJHs8qRJw==
X-Proofpoint-GUID: 7nT0BmkEWe4SwSq2owhk1MOCP0k9G3Vs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280044
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



On 9/25/2026 2:44 AM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Mahua SoC has a new GPU called Adreno X2-85, a slightly smaller variant
> of the Adreno X2-90 found on glymur. Override the compatible strings to
> correctly support it's GPU and GMU.
> 
Tested-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com> # 
Microsoft Surface Laptop 13.8" (8th Edition)

Thanks,
Gopikrishna
