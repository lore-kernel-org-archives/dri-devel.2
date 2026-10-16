Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0215CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB1610E036;
	Fri, 16 Oct 2026 10:03:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A7410E036
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:03:15 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G8lV0v2815459
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jFbHLAE9BiJ1N0vyGL3ie1gpBbVjTxSTc+KSkAOv1XM=; b=oALA3otZmDAlZdx4
 8iiKqi2IGmCVYLfr8WUIKUQhfvfm/S62TJlLEvGuMQY56ktIXK3X59POI3RyHroN
 6mha4cdVlbf2tIWM1FoxKSPcXMuuiPDMRDmUgz5FUQRjqJ5YKxN47WQ8ERJD9Cl8
 QMAlyfiKlvlDC2JvNbi35AXI8GwIPnyHIf65bDoVpRAFl+/dr5TlPdPApiqJlCep
 iEbJ1+GY7T9SuZpV+giKV7fkJ5V9tb+g1uKg9dx9cw4EPdcEqaIQDHPNz7aVChKh
 oFuB7M/Fa55EKDudMwhL1BBYQVFPsD8yU60K71kguD3A+jZOGWVjQm4j5Ik/mMBm
 5wuthw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r121hn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:03:14 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-152d1363a29so22170560c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792144994; x=1792749794;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jFbHLAE9BiJ1N0vyGL3ie1gpBbVjTxSTc+KSkAOv1XM=;
 b=N6RcZ7BZEtHb3PaUUb/AiarupDheh0PYb6UMHs9SXxG5rYf9zQotDvioYv0SzI2zu7
 RgK1PfdW5Lw9uLVQgdXLQvdRgXSU+J2YaVfpTG5fkCjqMtsAjQ0PJnNNT9/z4cLYKp4U
 OS67A1dbfeSoZalisbE+XhBYKK9vk9RArsNe9P4rsXZB18fLTbw/uQ+OJacZnMvO9KUF
 +iBiWAvs+/O4aKrxiakm0iuIkNVxz4ilJ4TQOIP1Qz/+tvISUYJleaeeqKjdx2nXb14V
 96PAxy4Oq7I3AXr+R6wyE9L5v4eysPG4qBVXi36vijb9oh1PaZHx/4Wp9Rvx31/vMegn
 Iz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792144994; x=1792749794;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jFbHLAE9BiJ1N0vyGL3ie1gpBbVjTxSTc+KSkAOv1XM=;
 b=gxhDGVwBJSlpOTKL/++OoHYmd7KUPoeiO0G6iVPg0qovcsXI3lBf+qmZ2dvEhAyxIS
 V0Mph9ZtEuqEZvDblt3d7yIfRSPE25dBvUpHCjrlk/udxIS0rFlL8sKSdMKCk2NvZBs7
 wRUUbK+Lm7Dn97W6TtvwehE8RO1jhr7R7lW3RiWJRmDqPzU6JZdM6z8zOfMFXboaK5Ru
 Barqo5Xl5I+wwIjHpFpdTUnZk6HPUHBpDMPDMmJm4NtabvKl6Z5Yt1LmipSWY3jFgKsE
 RG1t6CHqdq2kL75Ne6UyoT+Y/j1UUADBm/fSNDjXwWxB6cOs5h4Gp+p8Oykk1Ctr+Ter
 vOvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+1R0UAZ/PHqOI8wcjLtLbs6q/icDkAnM1BudLQwbmTLQkQJxwXTdhJlEduNMYwxRM6I09+nt+8+k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMWBiv1b/RpggLbfDqFBSTwknQ8G85fo9vaT2h09X5M0AmsSly
 v+9rebiVXBMyPX3vdCRPJFeTqoIZT5rRXk3b8SrYfbG3fXE30K8skOtSuUjeQv63JgX4b497IJd
 E4da2X7csPKc839qT0sX7CsTbrjaDENbUX8cagf5rMlriS58hTXUB1yzQvUnflWDF0y9VKCQ=
X-Gm-Gg: AYBFou18n0gY+Z1gBPbgSejtZZbRpT3GjzbndHq2n+UgYFEp5HRY/fT+1wXpPuMNgNP
 mJ9xqkeSpxBNkV0LGTebUu0ZORvilySUEp1GKDtV6xvOAW/fU5qAQirItVwlhmE2D9zjQbmPxcW
 +NFKtNrfi0sJhZTu3IOCX90528oikwWUrsW3XeaosUmZxSKQl/WRLmwzQx0r117qNYeRzzAkUZT
 ZNc9L9sRmSYn02NX3RMlPtdOhOFOZ+GmhkVKqbDV7hcVU/sCBPThK6ZaPe2/1ZII/igtV4GZBVA
 W5nRmPuC/uHcuGm/NXH7i8d/dx1MtxbewLU5lhNmA0qzx/1pHue9WYNV4ascbqrOFJzjKh+842s
 p5HaWQHZVlxeKULEBwMTdt8VhWd4W
X-Received: by 2002:a05:701b:451c:20b0:14a:5d07:9b with SMTP id
 a92af1059eb24-16a5ea5d851mr27453566c88.28.1792144993534; 
 Fri, 16 Oct 2026 03:03:13 -0700 (PDT)
X-Received: by 2002:a05:701b:451c:20b0:14a:5d07:9b with SMTP id
 a92af1059eb24-16a5ea5d851mr27453539c88.28.1792144992946; 
 Fri, 16 Oct 2026 03:03:12 -0700 (PDT)
Received: from [10.219.56.188] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831919fc14sm6054155c88.6.2026.10.16.03.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 03:03:12 -0700 (PDT)
Message-ID: <9043efbb-7883-43cd-a09e-28fc5304457b@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 15:33:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: Remove FastRPC compute CB9 entries
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20261016052042.3755352-1-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261016052042.3755352-1-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2Su1zd8BkuYjboaxvzE88bCNqI4eVRoX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzOSBTYWx0ZWRfXwzsC4f2WYqlU
 nAda08TLPPk//SCF9pArDhP9Lvfs+3dBZQU8LcmxdblanEAjKChZ13t8PJdaZ1qYQNxSXnxDNRA
 gTjJ0Qr3Imn/IsTacybpw/g0tcFskOg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzOSBTYWx0ZWRfX5lpllnSVsYdX
 MtAvpnXq1m0BW6o2MUaHU1Ec/0GYBNqZiUyJ15Vl8RNLMNbH8nScOkA7asRv8q75HU0cByThif6
 LbtWIcpBKAJXbZygoQDRyfcXntyq/gZ7Ep1P3JTPqPGm2KumPnEFutKCPcTFMmEoDQE3MRbqs5b
 oRIK1QDk60m4dM4/KKxK+pi459dvR0vlAlrWsPqTKIiLtUHdLS7clvxOA2hK+8uP+Q9HYi/6rJu
 So2xaT+Fkfuhb2jWF4vDYoe0wXaeOlxfrP0pn5vrUH4Oel/h8IF93K43Kez9vHXRUlR2U1RgDxR
 236QDnTYLh+HtbySoKvZsirxNJRtJAERiwrYqpeKoEcZvnmVjZAoTSqWL0kYnT4x4QxCAaRHGxK
 RM6KnQ17wtE7yAXPHoMm9WEuNW/ZiHnLuSxzwmSqhTllg1g47sPHJtbKBhFvxSIfaTR/Odgfxrc
 GPffCXWjbxYPbwzBBFw==
X-Proofpoint-GUID: 2Su1zd8BkuYjboaxvzE88bCNqI4eVRoX
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad1f662 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=vC5WxkcjHSV_sht6c60A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160039
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

On 16-10-2026 10:50, Abhinav Parihar wrote:
> Context bank 9 is reserved for secure use cases and must not be exposed
> as a FastRPC compute context bank for non-secure offloading.
>  
> Remove the compute-cb@9 nodes from the Lemans and Monaco device trees to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
can you add Fixes: tag as well?> Signed-off-by: Abhinav Parihar
<abhinav.parihar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 16 ----------------
>  arch/arm64/boot/dts/qcom/monaco.dtsi |  7 -------
separate the patch both different platforms, also please include other
applicable platforms in your next spin>  2 files changed, 23 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 695eae1b7256..5481dfb73454 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -7861,14 +7861,6 @@ compute-cb@8 {
>  						dma-coherent;
>  					};
>  
> -					compute-cb@9 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <9>;
> -						iommus = <&apps_smmu 0x2149 0x04a0>,
> -							 <&apps_smmu 0x2189 0x0400>;
> -						dma-coherent;
> -					};
> -
>  					compute-cb@11 {
>  						compatible = "qcom,fastrpc-compute-cb";
>  						reg = <11>;
> @@ -8000,14 +7992,6 @@ compute-cb@8 {
>  						dma-coherent;
>  					};
>  
> -					compute-cb@9 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <9>;
> -						iommus = <&apps_smmu 0x2949 0x04a0>,
> -							 <&apps_smmu 0x2989 0x0400>;
> -						dma-coherent;
> -					};
> -
>  					compute-cb@10 {
>  						compatible = "qcom,fastrpc-compute-cb";
>  						reg = <10>;
> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> index cfe39f923224..e73a735f2f13 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> @@ -7822,13 +7822,6 @@ compute-cb@8 {
>  						dma-coherent;
>  					};
>  
> -					compute-cb@9 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <9>;
> -						iommus = <&apps_smmu 0x19c9 0x0400>;
> -						dma-coherent;
> -					};
> -
>  					compute-cb@11 {
>  						compatible = "qcom,fastrpc-compute-cb";
>  						reg = <0xb>;

