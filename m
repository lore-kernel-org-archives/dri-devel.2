Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C848FD5F9C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 09:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F010010E4EF;
	Wed,  8 Apr 2026 09:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7rCm74s";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fFSP9h7C";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E1510E606
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 09:18:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387N3El2451335
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Apr 2026 09:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TYggGOjVlT4mp+hDzDKO6HSG3vJzDPA1Z90Dqf0V0ss=; b=C7rCm74sJpazlT6Q
 BRQ2xR826TS7ThDgtH7wb1JkYJLL5v7In94MlDjkHNPj/7NSEFiMaMcOuX89bD4Y
 Kl/eTZUXzOUo+1nmnPOZZVmaTF3zcIwbzz+enOSLuUTEYstNFJmxd4xnrtpUXKeN
 +P/1Ha9Zk4atp64tPOCc0BIIslMQwkCQMosBe4gd5rqaESN9Qf5fxsfRAu+6XxRF
 VdD0pkDWTvCInybbvrQAkvU4DHKjU53xCFri1aMvPgRjYrkjUNRFZ52HkClEu9Xr
 r5Ty3HeEjrV7kQgn34fF/SmP6kfpyylic0fP5Ay+8LakT/uDxeRVhutmVTFew+bA
 nTHOCg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae6a0x9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 09:18:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d7128e038so13392531cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639924; x=1776244724;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TYggGOjVlT4mp+hDzDKO6HSG3vJzDPA1Z90Dqf0V0ss=;
 b=fFSP9h7Chqos61m1yiCRd7cnCF0Vrf3/SNYnXnGqFXa7cVrcjv8JQ9r3Guhj6FyZER
 l2LY+RGGgWhgy6SVULoRmAOXA9aeP34tzT45yW54iwN2614yh9cBFUm+O9q4yOmnhBF3
 ENGssvyep/RB+XFfD5BaeHepMTM78CGzuBQ0AH6mL7XLBUYSsWZaBxN3x8wFKNpOWMoA
 /aM7MYfEHOrWAfRkqhHriCfnmUC2W2wK3oFUtgES+WtphsThN/WdcHKr5zoIzCXGPCwE
 6rV0W2PC3iMqChfXc8S0+8UxgZHXMY6u0W5YFav4sIOJoK5rX72vRw7UPppxx7Bz5tSQ
 +4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639924; x=1776244724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYggGOjVlT4mp+hDzDKO6HSG3vJzDPA1Z90Dqf0V0ss=;
 b=J53DmmzqkJ3Fl4w8K+Gam20AXGNMeIU/piZGauAifmGcNga//zfGYCIDGn2yQ5FAkM
 HnPK62melhwcCJE+zHSSMxz+dIqtQDWfzTqRwuUn+mN54N5eZEYDUDpx7X5ZeKVx1J+R
 vKRnM2DwLRGt5gnO4fc6X82CysahDpL9FQxvnHtpcQQ0k67T2Fzu3uDrFeeHYDEVqqLs
 R/H/S6g5KnQl215el5AOG8cIuG1fxy28o3zZCVx2QEm3vAE/ert/ugXp94DJj5q3SzZ4
 ph4qwxAcLjyxUrCHWBmTWRYTzBTiHIziNSkCfQ2mQf99KIuE2GC77UrLNKmJrAveCsq1
 hJNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf7Xchj3qA4PorpQYmqQd8HxIitCZTERo0r0TBqVimcemIojHzPc2EwAeSS0NK7bV5mAn9/EU4m9M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc4Z+UFnW22ioPIGxWVhcKZmrCPx332JM8dtKkgUZfm1Zt68Ki
 h2QUiBfAfgM53BdrezlFfmtgWOi+XDUmIqZI2w/YO2zbrlmu4cMoGvXs9GHmoVSVorg/mzIU75R
 ZtHqWfhgn0aYSYhjgLioL6FZ0z6lGCSEyPGsB0U6Q+/jPNnvK0vg+GBqw+IqIGKTPF7CAo9Q=
X-Gm-Gg: AeBDievcq3u/C6qRbDRip8XJ8V37Sbt6oxgW+laMOWa+PGpAcDFoDaM71JIteZvjr9r
 NPjS8vDimxxr3/yhw5nIzJmjiuc52qzEFJvmGwO7Bpkn0VFWpC1uTXvnvqS5alRX5Ghu11G1URy
 veMQlKxEeL4nEy3n0W45iQj0+UCkOz5J4LD/K+NN1YNbdxq11IvxQ4pek6zLQFJo9MY0ZmmZAUo
 dxP5+fjljm2qXmA/o04neMNM1fknc8cVZ3zt5psiE8gYgTIcKWo/FacDgbrm21+jW6QsCfCbMOB
 TJ3nDjudwOkU98dk9cLvpoWW1rANyurp7Zz2zi71ujJPafcK6iYUfpi4pnoSgwdhYqohwvhw87Q
 e/+nEViesSCBhJxyOdb4c8VQXYWW0XxpvoCmz5vmk6oOyaeKNk54Qb7NG4F24h8spG3/XA7NHOD
 UKBas=
X-Received: by 2002:ac8:5d10:0:b0:509:1b76:e9ba with SMTP id
 d75a77b69052e-50d62d4a14amr214065351cf.8.1775639923870; 
 Wed, 08 Apr 2026 02:18:43 -0700 (PDT)
X-Received: by 2002:ac8:5d10:0:b0:509:1b76:e9ba with SMTP id
 d75a77b69052e-50d62d4a14amr214065171cf.8.1775639923394; 
 Wed, 08 Apr 2026 02:18:43 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cfef4f9sm615267366b.45.2026.04.08.02.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 02:18:42 -0700 (PDT)
Message-ID: <6e248bd3-1692-453c-9012-cee1bf1cbb8d@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 11:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/4] arm64: dts: qcom: glymur: Add GPU smmu node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
 <20260405-glymur-gpu-dt-v1-2-2135eb11c562@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260405-glymur-gpu-dt-v1-2-2135eb11c562@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfX7DqFB221+EtF
 Fl9TxYUptKqC+ULKum/f8aEgdiNMmfmuS2Z3ROtLAl65HG+7nR5u2Amcs24Crmm6gQMaR2x8CeQ
 W0zCqxCushNbAq0IkD9U8Yh3ypXb2TTdn6IwCVlkoRDylxIu1eaR3POxCDXx4SgBzr0Nh5+RWFC
 TlLMPoA8yBBTbMhRErtRqvx6UQnwMJ78ETy0uKswWgSb73k5mu3omrIzU/A2IQLMiqqn4FRReez
 j3TgSSd02oOZaMSBkuQdbT8fan1OgU+S2fOBlrqqt0NZFXkVKUjjmAtpZPkAsWy5kRW1fcr4D3V
 BvJ5Pecob2ki7IdEuL8rB5rTz51cf35Uub3bD2+F6vaZXi14+cDfqbictrc2UNtNjtXDBW1r30X
 GB1UEQJ8mL9nFCFuR9oq48Q2HC8P0/zg1yrute1RshUwgxiiJGFD4XARI9VBFjawe98lKu0At2P
 0VB21gGIqLHYYBf1qIw==
X-Proofpoint-GUID: 4aF3yoknZHwSNIkwe73uYLx7EVAVGFp8
X-Proofpoint-ORIG-GUID: 4aF3yoknZHwSNIkwe73uYLx7EVAVGFp8
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d61d74 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080082
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

On 4/4/26 11:03 PM, Akhil P Oommen wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add the nodes to describe the GPU SMMU node.
> 
> Signed-off-by: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
