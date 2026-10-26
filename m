Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14CD60A260F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRo/l0Xs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Doq5sQyT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070B410EEC5;
	Mon, 26 Oct 2026 12:15:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF93B10EED7
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:15:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtJ0i3085733
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YmcQx9OcgaD1ZkmOw8NwOu+cadyxIp1x2breeYxHURY=; b=gRo/l0Xsb7hVMkRX
 1EkygAHZF0+2YgS/MpowSWWROkEhf+LNkEtrcEsDmhhQGc9ipXwOfyg33Jw4M8Q4
 pwCpwRV571v8rN0ze3xBYb8+j682Yi+SRuTfpllykIWTNWeOVzUVYLrcQgq5pOdW
 Yen1WzKtuA102L9t2pZMX1q+9vC3WOlREjDaJX9mdw4v55TwpjaBtDjSvwAmd0Wy
 tUFCnR2nq/FW4ghWfszlk67ejCrxxL00zH37LgVSnmLlAqfTTV2XVvqXIg0R70cS
 yw2KH9ZC3xEs2BrpOESlqS5KqMcTKhtcpCUOawvD1Ca003ZYh0GznlDkcg/zwVyq
 DjO11w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3p9dj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:15:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb1091fffso22285385a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793016932; x=1793621732;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YmcQx9OcgaD1ZkmOw8NwOu+cadyxIp1x2breeYxHURY=;
 b=Doq5sQyTpcnJFOVnh9iRI/ZW3rWj7uPBkkG8Mt9A0GC8JTdCQSGHNxXJnKjXREgvBF
 49HYLZJF6WUTz5gAWYXOR9omiY0Ie9s7T1jNatpEz3WLXTyxroQlawfBR/cdR2XVbOuE
 CKVJcnuQ4Ys7yM/wZx8ghhIbsSIxEUIEdvPwgl7mj0mmz3wdDvce/SDgf/1Wa/AcLrMu
 4qqrUt5IjZ7dRNXI49nOsMywFY2woI0FqOuTRZhS0bfDSHM2g2ebtwfb9YYCSbIG1o1k
 lOQRJtt4emCubxAnesCsYhXIrHNexOi8KR9iFaTUAEtOHS3VGPDfbooTnwy5w7Xga/1O
 MQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793016932; x=1793621732;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YmcQx9OcgaD1ZkmOw8NwOu+cadyxIp1x2breeYxHURY=;
 b=2tE9svnt7gSw9YN1CPHp3LaMXmP/EnnS+5Kj9ofgNvhark5ZuGBX5RWrmPEL7Dd2BY
 Rx+sEHiL9w/sPFjewSjGfkJ3tsVHWmxouqaFfpizNaIm1jwE23z13oxxnvF6hC5zCClU
 pcsabV7Qup2Hw6Qu0mYmYVmTTc6F66xCMNS811nNBQbn8x1ApcCFDz03h+iZYVY4NIDs
 cZYfe69tbDPaZapwKkO/5RCoxnXq7zZobjPdqt8tRWegiGbRtIz/wHWi/ani2PhN9pyo
 hD41F1GmzTm0wVe/M5iLFkBgnF8DnU6qtTiyVVqtCs4YyDFIbSmIiXBRKk/Owi/DsvHH
 giVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+mqjoB6dVF/ODeOYlVciB1+9IgOBt5MlaTOTWvtYwDEYww4ux6r0o78isQxGuJxunHA3yHBjwq6M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqg3NGeBYd9viBuzPJ67FTID7As61qVk7IyWaPrcHOpsuu7eu7
 asau4JRG1xu+UuiNP/D7hpbsgnYCPsLpK7hp2qddzYYw573zICn+utbzZHROqrX22LUkB6ruqy5
 5a/Uh6X/Ho79BKrvoG2LS3zWKEtnKaohl0dBnDphzaV3YynMG5KPOvTmwaLaFzmuBO6Gcd3o=
X-Gm-Gg: AYBFou1RAlnmb5H5Hg5zQoPvQt8JoxAxHgi6rDdQ4hk86nuvFfWGsWbXRvX41s7oUvu
 b8hqzsdQkjNx38+ehgXxj4KC7s5i8I3+U6O8yQ/L8YBL2NWLsAOKqnt8zVYAgLxklrY2FRA2+z6
 Ai5DrEUEgBbat1hQ3ERi3vVf5MPP4C6UqM7rMRCCkd1q6ekwiy1o4fowr2Tuk5CGwOzb2i8+AB4
 iNR9Yz+jh/k+uEz9Kc7Wb7vFpCajL8BdMCNseC3U27lxTI1cGBrtJFAk3M5wl7ApTerzId8G0Aa
 rJ3xfMAkcwHiwznT83KbnHLEOT1arsul6VwZHnqTEhi6p7IiAZ/Xs9EMIPg/N+Sjy323l0BI63a
 0upinc/4Ylaszu5DlrftdVw==
X-Received: by 2002:a05:620a:7302:20b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-940ef945ddcmr961459085a.5.1793016932136; 
 Mon, 26 Oct 2026 05:15:32 -0700 (PDT)
X-Received: by 2002:a05:620a:7302:20b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-940ef945ddcmr961453885a.5.1793016931605; 
 Mon, 26 Oct 2026 05:15:31 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a8b85fsm1495986e87.55.2026.10.26.05.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 05:15:30 -0700 (PDT)
Message-ID: <09a09f96-7572-4f11-924c-49f7fb21e2c2@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:15:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sdm660: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: niCI08jylV1uHjqXSoc2wLUu3rOizsLZ
X-Proofpoint-ORIG-GUID: niCI08jylV1uHjqXSoc2wLUu3rOizsLZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX43jfBonD4ZS/
 kHm4h59vmCyGdB5sNufs07MWq4ZOYSO/sPoatGSKfM9QNu7uZ3+bMYdAsVvjdKBmiwGTzoS9+OS
 f3oyo+axZETVwmNP6HE+6v+4YO+4Kog=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adf4465 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ssGiREWd8Ca_oH2jvLkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX3Icd/MUXipLr
 ldO4Xdh78n9c+KJNnkTK2wGtcDQ2FKDBV+BwSnNTlshBEs3xnXMJ5UKsYebPNRzP7aja84YsroR
 zWboCuTd11F7maZt3I+18yzWVv7kVsNA0BOx/miGtWBsPqCZuk5bHnMsAYX1WSOyU3aIMXbVWGm
 KIUgSan5ahvtGmYuOGneOd+Ii0b9rrXA944V++SRKflgiKl+aCsWGkUsIP0H7JTsp7+cwgLxujE
 RFHcBPmFdKQoOWp1KhbnpSPcNDazt1Ll7botKk5N5A+tKIybgIR/+I5M1NIz3/GsUqrr5KyWHKd
 MabCwZycfvjBcwRjI8kXJnXAf7W9KjkJKzgynIVwUA9X+OrkWF7b0w6I67edR/s4H9QOGpR5ZaU
 7XwYyge0v7k2xtUrONKFWp4cv/6ih9d+NoEuTR/Erx/gN524Lj/VrpZDdwuBELUlmzsCUvlxZwS
 ATmbSh6AfdW+TNNQCWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260048
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

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sdm660 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 708ab9d3bc5b ("arm64: dts: qcom: sdm660: set cdsp compute-cbs' regs properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm660.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
> index 0fca9662c64a..723bffc99b67 100644
> --- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
> @@ -386,12 +386,6 @@ compute-cb@8 {
>  					iommus = <&cdsp_smmu 8>;
>  				};
>  
> -				compute-cb@9 {
> -					compatible = "qcom,fastrpc-compute-cb";
> -					reg = <9>;
> -					iommus = <&cdsp_smmu 9>;
> -				};

On this platform, it seems like the secure ones are SID 1/2

Konrad
