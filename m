Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D50C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6D610F4DC;
	Fri, 17 Jul 2026 10:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1953pEP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EAk6EfV9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69C410F4D8
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:07:06 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H6cToS1019017
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6katBA3YYMgPj3qSfM8s5QF3Giyse2MBZ1kakUqCeyY=; b=Q1953pEPD+/NGkVz
 ZccmSzyzr3NZxcAqr0OQHwGLh/pGmI4J/FZNOG4xpD2KI/TX/mD2UNjm4+T7S5Al
 L36Weu7MzZdrr8LOgN7Uv+Q/+LY5FPTfP+VY0HtwHBnPZlgyE1vZvuVvd7v6BMXK
 z2qLw7DL7Zd9zwZs7qYME601IWtkti2A2+RNuN2A2oOqjyljuvKsRgjQd2tWJh1k
 SVrrqPp1CotqPLOCRmeHRc6/LN13sIEFBncHOV1z+oxGTgwrVKicR+qMVL3IlGAS
 le5EVRjsTY6kSFbd2ycgBTtrDLXkxvZPtT3URSOyqc3GjmDk4PV67aDaNg+2ncEX
 jxzNhg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff810tbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:07:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5110c89eso188676485a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784282825; x=1784887625;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6katBA3YYMgPj3qSfM8s5QF3Giyse2MBZ1kakUqCeyY=;
 b=EAk6EfV9e3TT1MTjnZ10YCtNXhSfeGZHE/NrdGqcRAYnBRf/Pd0Z9ALLHSoADoFaHT
 1QrD46a8iIhD1qM31AAOXLWoERS0HP5tFjOxo/ZHYobu78Y9lxtDgpOT9GXIfU2VnLsE
 FKmdt58zfQyfklGgRs3voK2SnCY5H4Y8zGbvCRaIjVQDxnHPXlSYUzZG+ZJc3DxyhR+7
 vy7wtPnSQB//Vxf0DrKJNHfeKlnjxNbIe1PSupPNmCcAYXz9sVpdfUco7i1CQGpYVqfC
 EHBMiNlEI2PnZNdemuFb0oS1K2Iie9QjiQ1SlM3Y0Xz9GZYliT/5MqPVGVHf1/JOfXMX
 U5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282825; x=1784887625;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6katBA3YYMgPj3qSfM8s5QF3Giyse2MBZ1kakUqCeyY=;
 b=IN38tgqPynui2ou7bclH4WfkUHjYyDtYZY5DRDc0RjAUwbGVk/76TTQAfeAs4E2FeL
 3Nk2kK0TVQXdnJSyjnwY0P3YojOgXDssW8TMYrZM/up9DGyrvRj+ahPN1tMiaZy/isrn
 noNuyHow93vFZ9rGfOJlGtMeV8qSq1c5JOphqIJUYI0gJp8MfA2zkZVPzXJBY0M8HDML
 fgSE2eqL9iYZJJ7npq/VvyZ2LibJ3lSgeRiq1WSCuqHU2EzyFjXQl90GCCT66p3QlfjH
 hjQLMMJNHzRpbcyIM7Q9Svn8GHGbxfu6HFaaIjfOZPWyA9qGQqgEWPRJxp3aK2N6HBcn
 maQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoryqBOk3SdakGULVlBLPnMNhKmcQ3UjDKp7ocwDNn8OHqm7jeZ0wCoDcVEDP1hO21lD6JPYWmLk5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1y2DV/9LNn+cqIenSx+3ocyZMiAv447mXlrPJGd+ly8IsZyO3
 a3yl4GkphOrRQ2IZoYVqYVVDcF4reCgEFvGCnhgwe33tdx1fmG8dRg3H0glNuBmfJeDsjDtlcac
 OV1x0ShJzVS7T/XFw/LscJkDJ9K2ebABeyMdLtsjK88flyK7G2iVptvYj+4ivX1z1o9h6LRA=
X-Gm-Gg: AfdE7clmQZmBsbLjeksNXxrMZ6Lm6xCKvQr5C9FL/+lIqqWrEfNO0KvNfKxizy9quZw
 zw3lb3vx7U1fo+oZRpC+sK+js8ZxmIj3KggNts8nKXdeDuQdJwlFX3JrvaxBQjLoGbwF+5lAaqi
 Cej2c4vkcPPgO3s8Geoo9z1Ao5kmqLAHEFAhzfEMmE+0CZEGonQ8ZQ239vNIjAb0gxMLj+necM1
 1P9HpjKspXTb5RF6vlawF5uVThiVTEkpJeVagOJGTxJY4NNDJqsJbqw2nqoWFo/iZxh+NuIkwV9
 TEHcpkbfAyF5rJnX7BiCrfA1icnmX72iLnnidZmpbrJXRm6c0Gbm3fAQZRcyTb3Fh2OfCC9aNgN
 uP+8wC7BiR5pu7K1KiWvsYCHm
X-Received: by 2002:a05:620a:ab08:b0:92b:7420:bd58 with SMTP id
 af79cd13be357-930b3cdf523mr129230785a.0.1784282825250; 
 Fri, 17 Jul 2026 03:07:05 -0700 (PDT)
X-Received: by 2002:a05:620a:ab08:b0:92b:7420:bd58 with SMTP id
 af79cd13be357-930b3cdf523mr129227785a.0.1784282824741; 
 Fri, 17 Jul 2026 03:07:04 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1705a09a4fsm51391466b.18.2026.07.17.03.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 03:07:03 -0700 (PDT)
Message-ID: <6d12cbb6-23de-4e41-b449-9d9b6cbab342@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 12:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
 <clfy5lvz7vm3ogw7pvyyidiujqcjxftx55p67szwgc6ivsq6r6@xrrcbfdkqkjo>
 <2d9d6724-a3ea-42ad-8cb3-ef08fd0882be@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2d9d6724-a3ea-42ad-8cb3-ef08fd0882be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RbqgzVtv c=1 sm=1 tr=0 ts=6a59fec9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=J1ZTZr7FdFypxrWY4IMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: vo95tYZIc64S2JvQa4sNQ8bMunpbMXln
X-Proofpoint-ORIG-GUID: vo95tYZIc64S2JvQa4sNQ8bMunpbMXln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMCBTYWx0ZWRfX+5JBoOEqlxex
 +SkXxOu+R3k4frln+2ceqgXiT1hQIhRU9NyMKZ02fE81U3ib7YfEz92lk2yYU50Y6FG41ZHSU1a
 ma5ccvnzueSSXcVH8Kezf5v6DJbL7g4V+UmDItfngo0aS47PQAcVFxNfzhYGGvSy4aQUXXRA3B8
 aGmWFz9fQnpf1UtPJrpnuXsdlBCDk5Uk5gHgYrA7YUjqwtL7frAOLjLp4crH9VpCT5sVTswsiiY
 sh3azIem0IciAmOrBQgyg+O3P+XBbJsHEr+Df7w1gyzgTh6CZgtaEyoT5ZQk3rLPuz0vb47jaBK
 I0R31FxLoMuqG6jtQpN3FseYpbH0qKGZGSJI+cjQ0yngTS9BwaczT/MrHaYelEXrbov2FLpbIHW
 GaeuhWYloXtyOaBE5IPoUFSE95DIVh5kVggNNeq1UJGLN7t/PIuprQrznDnfQmj5EsuWNi+rmUv
 PAGi+VtLjG5XfgY2iwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMCBTYWx0ZWRfX/a6AqPKOVo+F
 vfpsS9bi4GAtR1oZIiqxTVHjs/muU+fIb7i+Kp6fQrcabt8TOX0wIU602qbhjbqEXNOsXffeh9x
 KDELSZPDc2V6pQRjdiWL/N63mIHegiU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170100
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

On 7/13/26 9:50 PM, Akhil P Oommen wrote:
> On 7/7/2026 3:53 AM, Dmitry Baryshkov wrote:
>> On Sun, Jul 05, 2026 at 01:44:23PM +0530, Akhil P Oommen wrote:
>>> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>>>
>>> Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
>>> shader firmware path.
>>>
>>> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>>> index 1374afd9d14e..b280d8e845b1 100644
>>> --- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>>> @@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
>>>  	};
>>>  };
>>>  
>>> +&gpu {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&gpu_zap_shader {
>>> +	firmware-name = "qcom/eliza/gen70e00_zap.mbn";
>>
>> Should it be gen71700_zap.mbn?
> 
> Downstream uses gen70e00_zap.mbn as this fw is shared between Eliza and
> another GPU. But, for upstream we can rename it. In linux-firmware, I
> will keep gen71700_zap.mbn as a symlink to gen70e00_zap.mbn.

Let's use the name you proposed. I mistook it for the GMU fw, which is
named differently.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


