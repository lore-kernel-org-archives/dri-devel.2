Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3BFF531E9
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 09:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11B010E6AE;
	Wed, 15 Apr 2026 09:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uu+4hoAL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sia1BWFn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CEB910E6AF
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:12:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F984Vj4053105
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hmB34MFBSuyjUwzKZQavgV0G4aSRkdm5OzKkkYdbP3g=; b=Uu+4hoALSjwbB2D+
 U9/yBY7CX1wvCPJFcv+3mTcGE0aFs9DlzvRjWc/wR1oxMYbXNhWaijZ2DhCDcUKB
 4ph0rvI7T/eL5dxuVABNCNGLNnB2qvKIgFXbtza2kmzE62F8oXFXNeNjMLivMsR8
 HXFgnpOSJ4rDSj3Kb41Yfp2gYAZukguFrwMGnLMmU3dBBBBK8GMui3Z+o20jOj7P
 31T4sC2FIJ5OfnEb2bFmm87d+dl8YpiNy2aZAw/ujrQn/nCuDi9f8zWw1F4PyQso
 6Y04NHbiMyvtsGzPOBzgceI7mKsj+j5Xt4/3xjPBpup/TjN1p6Gw4f8LS6mVMWa5
 9zuoag==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj7s5r0pm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:12:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8e141739794so71301285a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776244376; x=1776849176;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hmB34MFBSuyjUwzKZQavgV0G4aSRkdm5OzKkkYdbP3g=;
 b=Sia1BWFnQwn/uLHMn8MKF5G2ndlH4NSOr911QDdv1m/UeYWeOPcmOyoxFCIWyFDRVm
 otb3LQSjF/d8a/I4ogBtY/aGp/4mM7BLe8bBd1yUYw4fYrF5GAQbSwtUfnRm6WFRE/er
 BXKu4UvqmnJ3NTkERukzog7Lda8fvbLRJos8E66L0mo7QRR+nNUH4aqM58Wn9Id0lnAv
 sWWM6MDmaCTxJmIx2tEFBA3gKzJRT4nYGUfuAOnqXkN46bTrNvfPPiwpHy3TsZ3jryQ2
 iNppXT7hXx4z1/sudGCXOmmSRX0VRez9/qqbBdzFV3bzA6ruDkgqHtNEZtfcQnacaCLB
 oA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776244376; x=1776849176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hmB34MFBSuyjUwzKZQavgV0G4aSRkdm5OzKkkYdbP3g=;
 b=pE06+nmI9grHeqpVwD8HPBj1JKIDr8o94ZHj5tacbAxQY0fJuilV6Gzd2EJnGdOjf0
 1UCr7n7zSZTwXpxF1quMmxdAqDk8liNRVspRH40TbD/RbugQr6NGtBoYnsaF8LBq5v+5
 6gNw8DSl3PtQHyFqUKCkND61Abk8F+NO10m1+DKvdn+JEjIuIKpn2X3pCAgG7xF5v8FY
 tCuEcVGluRdlopkBK1PIQ7s4pPSu0z1ml2XYv5gYcVawrOfinlk+zzHbijr0FDxSkUGb
 ZCm8gsOtpmL5vTott25LQbSRPPPPGhDBWA1BGnUPZs9NMvffuGYtQro3oJMJu3whzODB
 LCgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8n4YhMxlfOHLbMDWKLUBGEgQjqjFiyIYTxBNHErH464Myqp9XYAkbDKD/1zWs+rSu6G8d+XeZqxL8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVx6DgQ8QdVOQVQ5AYf1UEnzpOohC6ixAR3cJ8nJHqfwGh/+WM
 Gp5mL03d0kAK+5YsjVy8fnUoNdf2D75i0oZHGekya3VntoPB6ABjBwOqm/nGvZp7f5rn6OV4wHd
 miA07grLH6s1TY5RpOVRz7K5eP5rzJRmMO9bgYG9l08NUn8c6xWlhQ3Y10ukPtWWYiByYqI4=
X-Gm-Gg: AeBDievEE2sW9y1A11BPetfvOno8dcAYac+FjTCgy1uQewroKTCAv/77GH9H0vejGhq
 9oaaWgRSm7YiMvxiCe/QH65yCkQIi4YNZuGG9xcb4HUch+55NHmiKdZfZIBO4c6+KLOEzuF84hS
 Owet46RGv1o1YDefQ+Q024cT4+fZ6GqcMuzWZTh9KGhvr37ukbPZjApUq83ZmLTlev7FxwmpOL7
 Mv2x9mEDGXKpb38JTcuqKly4EGZcHkmrpbOHuwnl/Zqpl4jB/E5FReOM5ac7RKHLoyItlivQ8An
 69AnO7q3zO6lS7r4ADtWJZDLwHiXWITgqZkunjRrFG9SMEl2uMY3ckvA2PpHlZnDEgyvC7yyoZT
 uzX+MZ7jJJ8FCQFKn+iYh0hu89/z3KzV8BSZaIab4yBNYHl4pMmpmo4yYDpZ138BwFMQwmalAqJ
 LMJhGL+vByLc0tNQ==
X-Received: by 2002:a05:620a:4002:b0:8cf:d2be:5796 with SMTP id
 af79cd13be357-8e4cbfa5536mr170165085a.6.1776244376105; 
 Wed, 15 Apr 2026 02:12:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4002:b0:8cf:d2be:5796 with SMTP id
 af79cd13be357-8e4cbfa5536mr170162085a.6.1776244375530; 
 Wed, 15 Apr 2026 02:12:55 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67237d842f6sm225162a12.9.2026.04.15.02.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 02:12:54 -0700 (PDT)
Message-ID: <17b2ff60-d2e7-4f88-b2ae-f4dcad44fc33@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: Enable GPU & GMU on Glymur CRD
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
 freedreno@lists.freedesktop.org
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
 <20260405-glymur-gpu-dt-v1-4-2135eb11c562@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260405-glymur-gpu-dt-v1-4-2135eb11c562@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A7Zc+aWG c=1 sm=1 tr=0 ts=69df5699 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Vhnk_s3sKeSiNHHGov4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 3TmTJmjzG_OkPKH5J9s7QcxmkwPFrP4C
X-Proofpoint-GUID: 3TmTJmjzG_OkPKH5J9s7QcxmkwPFrP4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4MiBTYWx0ZWRfXwB9niczRWvPg
 IdaXnbgcC/2rsxRxSQE9o4Zr0nRKyzuYCzGVF+V6OC+ke5CSPjMNhJEOlFX9sHE9YHCznM+cP2D
 KP4k/qmUnAvsjWHLV5xaYAxWgQKycGwd/qSbCV9+2VR7iKSIqpf4dRaA7Zfl8fp2QG0dq1EYoT+
 JiXbWDbEFu0es4BaR197K+CYR2mp8fYzAnlD/2Uw7E7AG+ORfd0LaMMPKQ6TCuRZTWFd7O6S1t8
 wPWe17Ta1W7BYWCHIcgf3xtWkr+5DF1qka6esLVWs+XZdnBEPch0P9PzJ+pPGQxgu2eZo3CXChz
 7ilPgxoB78DnM0l2ERnjJQ8Xslh4X3bHrxlGvDdFD1UdprYoukbQS6A8TRRtCC95Z3RKtemWtK/
 aS5EeP5uAV1qvJxTcDTjY5iyAjG0PUm7+HXzHV2pnfa+tFKVYYSZBLbZYJRdoF53+NEczNj0ElD
 dPPbRmPsdIt0CJKaXPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150082
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
> Enable the necessary DT nodes to add support for GPU on the Glymur CRD.
> The Glymur CRD boots Linux at EL2, which means it doesn't require the
> secure GPU firmware (zap fw).
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

This isn't a blocker per se, but since there is no more zap, do you
think we can just enable the GPU and GMU by default (i.e. no status=
"disabled" in SoC DTSI)?

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
