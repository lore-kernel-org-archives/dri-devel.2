Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECC9CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690DD10E549;
	Mon, 12 Oct 2026 08:41:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37AE10EF68
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:41:32 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8KeYd741644
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TfifKJ8I33eiXdf/klxs3GNNDvTmM8v6aZs6OA4HHNE=; b=nQw2AwyXi2To4/SM
 3h/eyfQ11FkCJcorbwJDfu1jgwgRpRJzRARwoWWK3bXEUOSVMPJc5CuADnhRLuLM
 tM4UHZrMFeUP1aYCcp4jmrNNCIMWxSGDbWj9nge9kiwPBIV3QUoydpbtBVbqxC59
 OZE7Tenhn1cNQ83btS53p3k0w8LiH5Q9hhUugykOpM8hpg4+3qmOIMxUg39FNW/5
 vpq3ga1qhtORFJ5OdaBthubl/sv+RY561v0/HqbsWZi0CpZEEG9EFSfjHKr/i5lD
 faXoXFe/cQGwx8IZVxP4bnzNiNuiVYN7/noKTZduHdkToBdVJ3KTL2y/KSBLs1jy
 LT0DOQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dhvph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:41:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a47617a0b3so1247464a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791794491; x=1792399291;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TfifKJ8I33eiXdf/klxs3GNNDvTmM8v6aZs6OA4HHNE=;
 b=av/SCF7V9/+z+ZPUQlGxuP9BEB0eJJPCY6Owy+UKTPB5QfM8hmYUpRF8apugMLup/+
 gBC/B7BKHRff/ZVo6LnCawFbTKnk+fBVnudwkk6Hi06uHJWOctbD1LTtnSkL7JvGTQ/b
 RyCXuYxfeW5hbUlRVuHsfGY0wuZJhUJyPRUIs4QDlDai/Ftagcdet7U6mGQ8i9dcGCDe
 ZYWeTsX30Oyr0wsiPhMK2eirk7espc1Lvc6jPQ/pgyrwE9CV+5/ncwSCvHgoe9r8sMwj
 ANlsPtiUg/wDOmUbYk3SVgSdvCU1ezNm7It9mCCq6Z1d31aNkIYfG3YfVBWx7iqRiPHT
 oOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791794491; x=1792399291;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TfifKJ8I33eiXdf/klxs3GNNDvTmM8v6aZs6OA4HHNE=;
 b=UpqWuKvlReLpPh03UVhZ9GDQdZlUKBX7zF3nq71ekziabQZcwGUM5/PWjji8nWY+p7
 CSEzyjGp3qIjLoE3HMOic+4pkQAut3vEJlcNrA5rbaTb8Rxz1ciYvBZkEvRkqhh6wbiH
 dNun+i+Kejfg6eb0yObNtdR/TQ4Kg+pdGZuHT2boMame843IdeKDKMTFS4WmT/AwZWSM
 rPGl6Kxenu1BcrlhdR6v1MthFiu8JW/XFKNgmfQpklax7idPoS+arb6RAbyTFot6fom8
 TaJJV2Jk90NhHSat9KNHPuqD5JJ8HWSNhemhv6lo/e3jCMTamWKyCi5rjX4RB5T6WC4x
 hlyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbNyWFROyEKXN/5sUNF3P50/gYQsupOIr8VM8s4f2Wyq/Ud1POVODg/ifN4ynY5O5o+1izJj1m9dY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKf7T8oW1VUvuARBQprWD0z58OKCpIcrK4cf3fqtAAsG8QoVDeQ
 UcRm7UjBzBirHCsOOLL9BVG5/r/6704NQm5ivcqVVGue7ZkYJETeLAVR47jrQEUGH54DNz8wWuG
 B/saSsyWSE7ZvvegIt40Sof3hFh0W/SEOv9Q3bxQde7kueRauetUN2IjYj4Qub7fQ+Gg1NuQ=
X-Gm-Gg: AYBFou18nUcT0H9RCOLqwWQ0/1y8rWxE7YHJUKIVjPKEhVY2LZrbHkaMdNIKgcQzq11
 dFc9eRIJXp2cgz1tkRMNJKO+cEqYgUB7c6SprEcFbsHZo2BcKHQ2XsgFQOaiLtrMpDvKyhPkQ22
 xddWyzt7uVmcTXVLwVqbX94R1yLYe1Zj/rHNG83rsFGx5UHTcWJpiwgChzJcGDcPmVV8RNLbO93
 fYynL3Rmr11papaoHr55frAYultnnWeBnDAtr2r4VG4oClxXinrC69oEtn+2k32J0no5+hlcOpz
 TUq9+lM5FeBm3DkLKq7d/5lRK6HaSTkCWE8G1kh0RBKaP5QbtM/VcRXF3jDJXzwPIg+sW2xgFp1
 w7+T50Zf98fEuVvDH0/4ydenj/8cXrit/ukh2FGEUbKt0aDxAUrSLVyNNGDDn03HWOOS0Ow==
X-Received: by 2002:a17:90b:164b:b0:3a7:a6bc:9d58 with SMTP id
 98e67ed59e1d1-3ab3af76821mr6800457a91.54.1791794490558; 
 Mon, 12 Oct 2026 01:41:30 -0700 (PDT)
X-Received: by 2002:a17:90b:164b:b0:3a7:a6bc:9d58 with SMTP id
 98e67ed59e1d1-3ab3af76821mr6800431a91.54.1791794490086; 
 Mon, 12 Oct 2026 01:41:30 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab39238608sm16102673a91.17.2026.10.12.01.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 01:41:29 -0700 (PDT)
Message-ID: <d61fe4a4-7101-472f-9202-404de9899ec4@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 16:41:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-3-9157237b8382@oss.qualcomm.com>
 <epga5fcyf2d3esucs5ulht4s7ixwpwlb35iygz63aqeefruc2m@mwmmkaw2z5r2>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <epga5fcyf2d3esucs5ulht4s7ixwpwlb35iygz63aqeefruc2m@mwmmkaw2z5r2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfXxbK1CnGZeJRH
 wiKlSqk3s90xj2fUIeYlIr1UvG9GEeKY7caVYoV3yaURmbS30oGAG26RyLjrPLvwJ7sKrTaGpwU
 6gSIt3Rsu9e4+aabDrYMR5kj4CE3peFAu6VTUqi7VHSgHzvmju7xRC2X8k8wwB/GLN6Cfn8dzA+
 SFXjryJKLtNmxogAF2sx/KxiLaptnDtGxG7ATd84Nk1u/8nmdmX0/2TPhzMWBKMRRpx4212Ea6O
 o2+YQo0B+qtdj0QRMaMnjw7eLjvToURWIpQnGa9VZdX8qzp/ZkUTc/gVu0gQdWsFFT9pVVu/Jxv
 AnXOkQBXUTrVmDQNdMEWUgckzVUIJRpM55ZgNuzfRa0biAlpzDC+3lYgt5LVcW/spoMxqNpY91n
 rQ5Q0h3BJhvil5XGsh4hcexGbYIQr0HutB9SO0JMQT7ZSt41Qlwo+lggPYaUTcZStWSjnQunKzp
 o7SsIGjs2KYIz0TEneQ==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acc9d3b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qfM8fCPi6zIbc8DzE_UA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: n1Z6MlvDZJ8ApUOzeJYH-6L4VkJJTXB1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX/xZrmDzow1DK
 QnTOpmt7DL1Tfa8smPL/O29N8M1zYyp1/97WJ5ySWuP0ykmNsyRIboa2GIwBGIklfkjjBKrhXcE
 MTdmbY04LIddTjgXq+Vl4zjCKqPseEs=
X-Proofpoint-ORIG-GUID: n1Z6MlvDZJ8ApUOzeJYH-6L4VkJJTXB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120034
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



On 10/5/2026 9:06 AM, Dmitry Baryshkov wrote:
> On Tue, Sep 15, 2026 at 05:27:50PM +0800, Yongxing Mou wrote:
>> The INT2 GDSC on Kaanapali (SM8850) powers a subset of the DPU
>> source pipes (VIG2/VIG3/DMA5). Add it as a second power domain of
>> the display-controller (DPU) node, alongside the existing MMCX
>> performance-state power domain.
>>
>> The MDSS node's CORE_GDSC is unaffected, since it continues to power
>> the rest of the MDSS hardware on its own.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> index ace19b8b12d7..b3e3cd1d311c 100644
>> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> @@ -3619,7 +3619,9 @@ mdss_mdp: display-controller@9801000 {
>>   
>>   				operating-points-v2 = <&mdp_opp_table>;
>>   
>> -				power-domains = <&rpmhpd RPMHPD_MMCX>;
>> +				power-domains = <&rpmhpd RPMHPD_MMCX>,
> 
> Should it continue to be RPMHPD_MMCX or should it become
> DISP_CC_MDSS_CORE_GDSC?
> 
It should remain RPMHPD_MMCX, as this power domain is used by the DPU 
OPP table for performance-state voting.

DISP_CC_MDSS_CORE_GDSC remains attached to the parent MDSS device 
because it supplies hardware shared across the MDSS subsystem. Since the 
DPU is a child of MDSS, it inherits access to this power domain through 
the parent-child runtime PM hierarchy.

Only INT2 is attached directly to the DPU, as it exclusively powers a 
subset of the DPU source pipes.

>> +						<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
>> +				power-domain-names = "mmcx", "int2";
>>   
>>   				ports {
>>   					#address-cells = <1>;
>>
>> -- 
>> 2.43.0
>>
> 

