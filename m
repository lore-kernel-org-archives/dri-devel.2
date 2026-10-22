Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53941606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HVzHEZqR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R7Fc5tl5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A237511241F;
	Thu, 22 Oct 2026 09:06:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739ED10E2E7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:06:33 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M6xx1p1560220
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 npHEiXGMMSXSXF+CGuDidepu3HoUinr3fxrhvRGkkok=; b=HVzHEZqRXjuNxTUw
 Y6uNhSObfyF61bcnJkBnCdKjLh2B9gfCcEOYKFVF80ZP9qq5J9QyopCgrdBPa0nc
 kwNbh0mQHDcrih5EhIc3B8VIlpxPuv/GMh5UHAIQGgahTUfohjr3aXLxNfTVDbii
 sUoXr0b47H9f0/xixsACr/cjW5fq9e22EsUNry29sACOHOma32LkD9Ho4mFQnvIG
 E3aJeuxvAnHGjoKOfJg3lWAokAqpp5Nhg950biMkiFlmFBZwChwmFFCbC+jkzhnP
 J+aBNOBcneAZasrkKP7mqDC6h3YFbxtlEEmZ49yS2BVlRf9zb0TKeK8SGDQOzvps
 EVzd4A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahmq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:06:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so1723714a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792659992; x=1793264792;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=npHEiXGMMSXSXF+CGuDidepu3HoUinr3fxrhvRGkkok=;
 b=R7Fc5tl5Qro8HCRyv/t1zPu4pATRkmaNy9h21xvybiW8HnhLcnjtfYM1j0SCUwK4Ai
 74xr+8TaP63/o1k7coZ9/TZpDVYayJSjAWl8R9PZsOgLQBIi+17wYt3fhGdw9XKpbcVe
 Sk84X2l0LrcNDZfB3gv3U1o9gmfJfurS1OvdkFk7+LdLhFt1AnqfXrWN6IpC9326UGyb
 KKrOPeJ6/zYGxIk5hBnsLHLASDi4z6k+xhXeJdPF8PGygZPtoJ4FSig1dQlJh7nUdQN4
 NztG2JOH5Vy9H/NkcTpA4z3vWKrgEEGZpHQv9x2/qRB8BIAyNxZeCM8ICLTQT3FiWCpj
 uRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792659992; x=1793264792;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=npHEiXGMMSXSXF+CGuDidepu3HoUinr3fxrhvRGkkok=;
 b=RGmuuIwnBKw6/wP+l8Z9OHYPUArKNIx/pM15m7igLYx2smIbblW0yKAuGfpY9/0Bie
 8h1wMfhKIsbq6gAbf41nbwacpGBGtvD5BLhV+ze5Jlv0uuzmF/WaZ3XRAcINyRlVEj2X
 t9UOmtFQncowH6p5n/Zg2W/mo08peVV2RJ3BvnMwL++jGnySmWyhUg5wQXoKu7HRg4h8
 H7kz1lz0x7TqVPY0onLlXaxImOaeazt0E5YlkWeX4d8NsnlcLeYyGUTWWxiwNrTEd8UZ
 cITjt3+Vg1cNOqdppDg+nFYGBPM0Mt/AU5MeM4ui6IeFlfTOEWvTPE+n6i/VfoQMqUwq
 BT+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4rbPceBGp7DFS/7ejVa1g3cphukeAiF0DwEvkc9KYecnwNKXUzJi/YbiKbhEjuoYKANbFkiFgJgM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJrlDNHxxCoG9UIEzeUaXIKMRm41fwvT9N6CdhSxFiuuvbBF1QN
 aq2UkT/GBV0W0kAIoNCBNOIe6/eG2Zb4vjlYMrEUBki7J40FHE6Qyj7ltkrU7z3xAiB+XQJs0Q6
 VYunIspGlMtq3Oqn21xv4fmwIRcANjq7ML520pJ+qsOOh+aYkVpamEU6vGSbOTwXhkn3gdzk=
X-Gm-Gg: AYBFou2cmQCDjZk24bvaodwS0HAvREy3Pt4MBG59O2J5M8m6fC62eKbCz6i/kFOh5+W
 MJ61k7BSRpdTcNNDWNis3QVMHHCiIbbvojTLlxwbys4eXZX4goaWMA7lPNstaqCDFwmhRkXNhK2
 z4POMCKo+qgFoqxAPEE1HNFVjvPdCAEelG6IRVI9wapYvmThWNh3bGlkqe87b7wX2EWtonsEk05
 F7BSo3daNbSPtmufv24o9ueD20IVPeSjxPgJDt6X1K+c1XbbtwzGh+XuQCbr9yysa/V9Yp93sbD
 NJITm86rzmcqlh2mOcliXxLqO1GwPTwqpzjMLOY/AcrY8R3muZ84xgPBr6VG9fk9QpIEqdCVbtl
 9eGiuwhVt7iaPIWfh4vv0Xv9AuV5RZyUO
X-Received: by 2002:a17:90b:4d02:b0:3a5:133:ca5f with SMTP id
 98e67ed59e1d1-3ad86d27ae5mr3754015a91.46.1792659992025; 
 Thu, 22 Oct 2026 02:06:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4d02:b0:3a5:133:ca5f with SMTP id
 98e67ed59e1d1-3ad86d27ae5mr3753983a91.46.1792659991396; 
 Thu, 22 Oct 2026 02:06:31 -0700 (PDT)
Received: from [10.219.56.252] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad83482f35sm4051702a91.1.2026.10.22.02.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 02:06:30 -0700 (PDT)
Message-ID: <a97f097b-551d-403f-ac7d-726917e5b42c@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:36:25 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: Remove FastRPC compute CB9 entries
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20261016052042.3755352-1-abhinav.parihar@oss.qualcomm.com>
 <9043efbb-7883-43cd-a09e-28fc5304457b@oss.qualcomm.com>
Content-Language: en-US
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
In-Reply-To: <9043efbb-7883-43cd-a09e-28fc5304457b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX4sztQwZx/bbO
 p6Hi1ZcTx3NO6ZdDdBdumXAEqxgOhDks1lBWgb7spe5kOEo9URpy8XCrhGsJewz7Guh9aB9bUaw
 sMEZwOBjfxQxr8sGdbevFjlUEOu5W1zMlUJamzKmHtv+LfXUvByKKeK9J9Bsqpld51bGCxvRSDi
 4t3lBVAS+SrSQDnG63xGTVa/U6PRAQbSPUA7/v/kXou1X3lNVViOvso+543Np2vYjFoNbb8Rp+T
 yNvHcScbQr53EeQk1pwQMZkzKJ2DCFUqlJyd4TITKPGof6bF/hohtgHZxCcdcVZ4OWzcIg5WYRO
 zi5/4GqWjiar0x7y+68tv6H1BE/FpgnI7deXiL3kuFxdE6iNGH11zA7zovWY+5apDe4SNGjkk57
 d68gK/Y6j8wvdA5eBURHUHde1+un7bAbltvaZvGHJN79csRar/4Erf6EcBV79dkYTrJjk8hQyqr
 4n1onl2GWS1y19xT3jA==
X-Proofpoint-GUID: 8yp5accg5V62n_hc-BFaV81yUS68mjCc
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ad9d218 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=6-TbrlyARiIxoJeac-sA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 8yp5accg5V62n_hc-BFaV81yUS68mjCc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX04JPZAH5ql5+
 Ssx0cjhKIZUKdQbbXZxMffgq8CkHFyF7a5EgR9wK/OE9uEDNL0Kypk2q3rMtbQPxSOBIpZ1wAsT
 aA5l8Egcp3s+dhUjl+PvwvxjsrZcrb0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220036
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/16/2026 3:33 PM, Ekansh Gupta wrote:
> On 16-10-2026 10:50, Abhinav Parihar wrote:
>> Context bank 9 is reserved for secure use cases and must not be exposed
>> as a FastRPC compute context bank for non-secure offloading.
>>   
>> Remove the compute-cb@9 nodes from the Lemans and Monaco device trees to
>> prevent clients from selecting a secure context bank for normal FastRPC
>> workloads.
>>
>> Secure use case support is not currently implemented upstream.
>>
> can you add Fixes: tag as well?> Signed-off-by: Abhinav Parihar
> <abhinav.parihar@oss.qualcomm.com>
Ack
>> ---
>>   arch/arm64/boot/dts/qcom/lemans.dtsi | 16 ----------------
>>   arch/arm64/boot/dts/qcom/monaco.dtsi |  7 -------
> separate the patch both different platforms, also please include other
> applicable platforms in your next spin>  2 files changed, 23 deletions(-)
Ack
>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> index 695eae1b7256..5481dfb73454 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> @@ -7861,14 +7861,6 @@ compute-cb@8 {
>>   						dma-coherent;
>>   					};
>>   
>> -					compute-cb@9 {
>> -						compatible = "qcom,fastrpc-compute-cb";
>> -						reg = <9>;
>> -						iommus = <&apps_smmu 0x2149 0x04a0>,
>> -							 <&apps_smmu 0x2189 0x0400>;
>> -						dma-coherent;
>> -					};
>> -
>>   					compute-cb@11 {
>>   						compatible = "qcom,fastrpc-compute-cb";
>>   						reg = <11>;
>> @@ -8000,14 +7992,6 @@ compute-cb@8 {
>>   						dma-coherent;
>>   					};
>>   
>> -					compute-cb@9 {
>> -						compatible = "qcom,fastrpc-compute-cb";
>> -						reg = <9>;
>> -						iommus = <&apps_smmu 0x2949 0x04a0>,
>> -							 <&apps_smmu 0x2989 0x0400>;
>> -						dma-coherent;
>> -					};
>> -
>>   					compute-cb@10 {
>>   						compatible = "qcom,fastrpc-compute-cb";
>>   						reg = <10>;
>> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
>> index cfe39f923224..e73a735f2f13 100644
>> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
>> @@ -7822,13 +7822,6 @@ compute-cb@8 {
>>   						dma-coherent;
>>   					};
>>   
>> -					compute-cb@9 {
>> -						compatible = "qcom,fastrpc-compute-cb";
>> -						reg = <9>;
>> -						iommus = <&apps_smmu 0x19c9 0x0400>;
>> -						dma-coherent;
>> -					};
>> -
>>   					compute-cb@11 {
>>   						compatible = "qcom,fastrpc-compute-cb";
>>   						reg = <0xb>;
