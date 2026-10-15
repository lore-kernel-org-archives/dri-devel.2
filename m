Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF36CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14EE1122B2;
	Thu, 15 Oct 2026 10:51:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C121122B2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:51:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9kR5M2999386
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dc0xqqqCiVqo5Myd8N75P9isi+bPJQnuJ8HETB5D8Mg=; b=gI7OFKrkjd41uoc6
 9jwMd++P7C7VOXdaEdLtliukD+2R7T+efvjS68Ia0LuzhTvKIEEuJEuxUlr3bOkK
 aoX5nEf8qwjY5h5yVMwsLjeBWvpICct2Nyplo6xsYtZu11SuxCWLOhqubl6SsjbC
 KPw577Rld5Yo0XrnC5asiEcsrS/DsJOyPNAeHmDDXVOSbH5Xg8Ezc0RYzoiA+0f5
 2q63U0dbv1VnMx/Ktxe6NED6XG3UYVRsaYsnpaV7A5cv4S0bqFgZG3D1rWZrRzTq
 Iavd3JwEsdDiuwvxg2x1Qwpk88tI66musnLfisOgZLGrBVXa1fTFjnEfHrvKhgKB
 2ichkA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hausm0ha9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:51:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917aacb7abcso13497976d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792061497; x=1792666297;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Dc0xqqqCiVqo5Myd8N75P9isi+bPJQnuJ8HETB5D8Mg=;
 b=b7297Q+a/clx99qm98q80/uFTLiKqjMY28vIeBGWL6RP4LxnUPC31LkHBivLyfMEdI
 iaeIalE2Wo4cOs+ZatB45LRnoBQqPpP9G6RTLMvhTNRyeCSAHJI/u/3cLMAxT+TLin4K
 yhP0OMMxKO6id+NJhyMTGVkfNXkIzfhPcNNz0BydiEiKa2SyizFmVR0yo05guBoVZHbQ
 1JbnsbYv4Vtdb1cx0eHrDouPxrXfaNxcUFI6O/Wdcg3V47V3uDrZJhhT7kH1atkjEZQJ
 92KA2HC5ju0vtztviUk2pbPERe1XkvIQ8+4IOi2NeNMhEfKDkoKo1FZQu5+NiDtXKRZl
 LXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061497; x=1792666297;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dc0xqqqCiVqo5Myd8N75P9isi+bPJQnuJ8HETB5D8Mg=;
 b=rCgQinB7L+AEkx6gV+BmdWtR3qACSpvqyOrJHJxW62j8GzpXFHUFxB7XhCRQjn1XzR
 3PRX19vIRe4XB5/mRN9+dV+BqpafuSCTwCMbHj/8cYNM9u90ewm1R7UZ4RCf8yZXq7aS
 HT/fjjuyDRcUHXYzeHMl+uwFqWea3tz9dG+6Xnwxi+rKlQWHIcEFocAMneNTFQUSL4vi
 8xjCDfE/EiUUvvWPquh8Ssakv93OVT3Ak6yGCuPj24J5PBDy22VZgsMZJKvvlCoKjaV/
 yZyHbDH7MXJOCoV1NMVwQApPE6E9xsnPAqUrLmdfTR3Hgc8cYO3kcsuxYgs6z153Ii1Z
 HYHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdk01ocd3kKEhlc3wRa3WLcHICP5jpifFN9QVuKLnsypmHPJUkLYde74rQDTrnGqezdd6ul/6et8w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIR7vzJiz7gDvSJN/pXTccQOx/IIED1Cc+uzIz0HIh+nPihL5iU
 B3/AmJDEB9f/JfOBotFhlkcA2s5n6/BwEDqp/IBHo4CpgLAT6BwPFQMmeXz8VFum7IvI7bSM5Iz
 zBFmIEaqX8eGySGXO+a72JFyx4fK/uDyWnujW2xUFIJmMOqWEpvWC1xdP5udtfx4IW+7YTD0=
X-Gm-Gg: AYBFou1TD+CyRwz7r25DZb2lBEIXaV/beKjTVp3k7IP7d4kFSh3AqHLPyc5QQPKk6bd
 hcgvT/Bp0qvDOSIQL5Vibn0Ewe0ArK2bkp/Mk0DnuhiHRzjTU1fiTrRJt7W+aeBl5pEN4RwXnUX
 cxN/EB9Ocz/KvnxIy2XNRTuntwvbKPewdUMK+yUKl/yNpwVMJRbRFaA4NUdwLX0Lh4MjV+QYbcm
 aqd3M1fMjrzmBJtzw0UGY3xyhYQAtIAW6WSyQtYQXhoEtETBLKeNVdPwvLUwLujcRaGkUVqIMJ0
 av28LghnKlhpdTmz8OqNtrkKYM5iucm4DaQSGvHqFVJs7y3v18L5/FLhscyLgiC4uCuFhXUPgW4
 778BR/gl4ApO++I0R3Vs/CA==
X-Received: by 2002:a05:620a:45a1:b0:939:9205:4d78 with SMTP id
 af79cd13be357-93ebd1ff38fmr3642743985a.3.1792061496645; 
 Thu, 15 Oct 2026 03:51:36 -0700 (PDT)
X-Received: by 2002:a05:620a:45a1:b0:939:9205:4d78 with SMTP id
 af79cd13be357-93ebd1ff38fmr3642741585a.3.1792061496206; 
 Thu, 15 Oct 2026 03:51:36 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed9640488sm108759866b.25.2026.10.15.03.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:51:34 -0700 (PDT)
Message-ID: <512837f3-597a-413f-a8de-612e26c8c78c@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: sm6350-lena: Enable wifi
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-6-b4612e3eb536@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-pdx213-upstream-3-v2-6-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CEoGE81YEW6RiBBM66BFAm_BckIGCCRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX/za8TqqiLAz4
 YhCzRRJtV4pY+I3DO83liAzuiX+7oq99slHrxysMDiGYlb881KmwDPm5oGRTstEv7t1ix0piiEB
 htL/yfHItDsthfNrokepZvBz2b+WxpBHSpTQxbEU+qzhU2aWy1z2z6Z/wOVBl2KxhI5XkiWTNoR
 oBjS89Z6FhnaK6INoOpmxG5/1SeuTUmwZmc1L/+FB3g2WCBzqa6IVDjIPJ1Zt6ZnvlEVhHw3p4/
 YvIiybN6OeAP6csu6yibkIpDwMzCY8MwyAYkXThxu98aqZNUHbZfBH7g3fqUoNnrskAQ0CHmPg7
 IMTRjSS1a1pkd7yeAd8AaYb3iKa+SIXH1hHPCiNln/QNuzx+Y/L86GWKJW2rHkHo6Jfmvhhq2If
 XEyn40Kq5px7yzHJ+6O7iog6CkPHVJIOgynimM38GT9HT/3DTgZcRKdkNGn89GdhIh4xRzgVF4f
 ukLO+koJFmQ1kdtq8rg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX+5I6i8GAM5q5
 X1gmH48n379OhVpTy65rMWiDQFthRJK1OZqH4jqTe8y/GxKB+QCBf3FnwEeAlFIn+wuoZNE/Beq
 SY3KiuSNMRmMn20JDY60fqSeP46M5JM=
X-Authority-Analysis: v=2.4 cv=Eb5d0/mC c=1 sm=1 tr=0 ts=6ad0b039 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=JgZe5hknAAAA:8 a=EUspDBNiAAAA:8 a=If3Kxn03tZdP4ytwtUoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-ORIG-GUID: CEoGE81YEW6RiBBM66BFAm_BckIGCCRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150043
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

On 9/26/26 4:00 PM, erebion wrote:
> Configure regulators and enable it for the Xperia 10 III
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

It would be nice to have some more details (chip id, etc.)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
