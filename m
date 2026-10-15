Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6DBCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E814010E23E;
	Thu, 15 Oct 2026 10:56:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE481122CF
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:55:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jeko1955639
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ABwLG7KYl9IdbJ2x5X9Ra6++rVxuwQh+p9U88YU8QKs=; b=i9hfkUJHlEtK81m6
 p9H6hfY/FNFrTUz8p+j0Ft9TyYSh3evai63/rhLdyRqZy/040bHtIbPyNxTAweAT
 OOqW004aHVAyab/ihvOWkox7fbUGAI7CGkWBLiB0mVoVIA1/LOt45fBs5Xd591Qc
 MJCkpL4A8+XPagTB837WUUNMXbBo/70uhLeKvSyWIaaB8nhetGEckwMTPxtOsC1I
 MlhnXG8cFdFNV4aJFk3AHlnWGr+eh8TZLvZyYr5jtvJ5SPUtHAZwNa/ySKxel4AB
 EHBRJfhJ9NIC0E+nfIeitrLrXAyPAejiMbK2bwAvUfhpO1v8aIJwe4/SuszFLSTY
 eN9mcg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdetg3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:55:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53568f05f8bso14884261cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792061750; x=1792666550;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ABwLG7KYl9IdbJ2x5X9Ra6++rVxuwQh+p9U88YU8QKs=;
 b=VxgKaP9+KybbOFHHY/TQs2OTdfNVK0vwDFIX+7m5B95S0zqyiGjcQdh27CVhLLK+yo
 e6PlUw5it4bIWDZnKynxjg+luHxucU6HdTRcgfoS+8nxL8/4Eq7Rfiyuri4ZvKYPOy0R
 z+I1SAEi3e0gabUc9lBSAjKmKuIpJOPALA9AFlcDoZFx/r4D/Mpa1gBzHGDxC2McKHRF
 /aWE1mcHSYv7RvPgXA6AD5sjPv1QYTJM3kNrpqjeIC+9UPGCFyscpWKlgH5tb5WUotUK
 uj3Z/NysqUXpcMFLybMAvNv+LpD30GWU73OHSd7Zxep4PeGp35urnf2FZtvBZkXpno4r
 ohBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061750; x=1792666550;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ABwLG7KYl9IdbJ2x5X9Ra6++rVxuwQh+p9U88YU8QKs=;
 b=axzcrHXU4135ZkjYDKKSRdTO7Wg6hSBvDBEYkP4M+J1dbVxsM1qaYXo6aELfNa1A5S
 60U/L9nVWKEgKlZQJLYDeNZzGFZg6+acy4kSOV0du4jYJhU2lS1KeHrukasuGXO5goTP
 Kjv6LRxxFZ5VGQzHe6b+8VsIMWr0nLQfOBCFSm5OwD64melRiPdMBSuRtspMKGIzYHPQ
 e3y/dG5jVWvnDkW3tca7ma44FVRocbI1gZb6H5LvRJ6Max6gqTstbndWUC9OSV9aUhfh
 eAtmEpua2HQ5lfi8FEQp9b0nT4ZEPETM1R9FnWCoa5JY5Zw6BN4O4Kt5zrCa6yJ5c+eX
 aKTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8U/oVWLzeelKQQ91HLTIFnNz0mSqRexbdwMPa4HMaG7xRuCBdwxRmtA3ZuAnjCDeplSAQm7caNUY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLNPufokpLRnLVdaIAJY15ddAEgi+jtgMHmbqz5njq8px2hL0e+
 hb6vOZN0YiTyakJpB4DM0xARzCIDmfxW6CJ3uzvsVPFcDq9Y7IeuPalNYo5Ufhi3wwaxZ7iF1dv
 JPvw9Rm/GsXdGmwFieZVjw3clGOIWgB8Eu29ysKodShnIu4MsLaW/+oatUMX7Xp1NARWpZSo=
X-Gm-Gg: AYBFou3+2gyAaO/CjPUgrbnb2OO6uIEQ0I8MYEfmbnld6DcJCycHmpQqv63AkncbhDA
 i7oHs+chDIvyV6xfmDs+HxQ7gYYf7nr4zX847I0Z3GQDy/6HukgyQm3PVuxHJwHXh58FbCpcAEd
 0XbHUhI7TckIGUHwLvIpIVUUFlT+JmBP2uNJhnmGuGAwSxrxPjU6Wdbp3vVUiCmvCAkfD1bfvYD
 MyVczbNBqAOHNiupwa2w2WBFOP8rGb/yPmfjKmmBEMwoqI21UmNbK6CDRuRnDWGZZ6yQuboxGRj
 vJUeLStYIGcpsmcn/4CK7lf85B4xDQeB1U2ITSlZS+KS+zaZzubkkEczaB3ca2FMgl4YgSWxkjA
 6rTfqyY8gBOwvOGTmhwN1Mg==
X-Received: by 2002:a05:620a:1a10:b0:93c:c96c:a5b4 with SMTP id
 af79cd13be357-93ebd23a4f6mr3451184985a.4.1792061750479; 
 Thu, 15 Oct 2026 03:55:50 -0700 (PDT)
X-Received: by 2002:a05:620a:1a10:b0:93c:c96c:a5b4 with SMTP id
 af79cd13be357-93ebd23a4f6mr3451182885a.4.1792061750055; 
 Thu, 15 Oct 2026 03:55:50 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b2038abf24sm2285454a12.37.2026.10.15.03.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:55:48 -0700 (PDT)
Message-ID: <90d33b88-d171-4aef-8046-332a518dafca@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:55:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm6350-lena: Enable PM7250B
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
 <20260926-pdx213-upstream-3-v2-7-b4612e3eb536@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-pdx213-upstream-3-v2-7-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0b13c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=JgZe5hknAAAA:8 a=dNZ_EX_IlpB_z2sQReYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-ORIG-GUID: fURYvbIkAL1HSiqZavULWhvPZ7g3QGmd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX+UsfoKpvZzW+
 vDozvCch8hXixa7X436d864sQJ23MweVAH30Die41vxMnTRgLDSebjMZjWFUG6H2WqcytamTSWe
 6idOVDoW7HM7IX2ptbFJalhS4zAKMtSbkxADr2k1kuCN3bGptDswS6TVw/lX0sFgMz9U9da8vS1
 h59K8fG1pZTPT93YNRxmuJuJ9bCeNDKwupE8EWT5Iuyix5NcGf17msjfAnwGF7k/NiJ8KZAlU84
 LYv9Hr31AFP0nxJvEfQwjir/ZmhCMRgCgPRvB6Pr9o4jH3h8GmEyZj9TqVCgZus5zhBdeegK/5l
 vQK15SPySFNYDloYbKv5PggIDD1+Fu+5IdnxZovRmqW0NEfKGxUiOzHyIf5kzDDMtJ4hPciwaqU
 kWm8s2MuVN8ukwbD26VHMNk2iZTGZrdiWsZn2lkJXbzOAlgQVw5dPM64sBhERKCMfRBESe7m2MV
 Whe4Ya8aUaWBhSDgSww==
X-Proofpoint-GUID: fURYvbIkAL1HSiqZavULWhvPZ7g3QGmd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX+cYY//D/NxyR
 Fqvi6tmTyGe9a2IiWZUzilX0w8BCYByTnPLb83WWmu1rOgX2F51EXolngnfsyLP6NK3GmONOfw6
 qhwTc5txgpY9aAeTOARxo/SQ9XJ3Rs0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150043
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
> Enable PM7250B and some components on it for the Xperia 10 III.
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

[...]

> +&pm7250b_vbus {
> +	regulator-min-microamp = <500000>;
> +	regulator-max-microamp = <1500000>;

GPT believes the downstream DT setting:

arch/arm64/boot/dts/somc/charger-lena-common.dtsi
18:     qcom,otg-cl-ua = <1000000>;

should translate into the max being 1 A here

Konrad
