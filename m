Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33470CD37B2
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 02:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8218A10E1BB;
	Mon, 11 May 2026 02:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4UAqiyW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FebihonN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E17410E1BB
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 02:41:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B1iGt2794634
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 02:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 csTFQhCS27/TD55NnmDyE77bhxVaxEVxBVRrSVfa5Fc=; b=Y4UAqiyW06bE9Nuh
 yD+U5y8MhKA7x6q8OpGzR7A70I/chbJzeFaHq5W/FFDtQm8YNtmzoiNGTz83ALlF
 c1vDPtpIWYPb7rKrGN1s9IWEcmzrdsdFXgoG/ROfSE1Ahi+cYVssJFgcHrfDr3mv
 m8TyjRxbMWPyyfuUCb2mvLQbxTYKwBhtL6C/H+k3JQm4ncNfS8eb1yEQoR+WKXRu
 3N+to8kh3OpbZ0g4naxhC82rZOxrNKQUVbRUej1y/gweUsFio+UgRtafx2r4CvDR
 8UCxSiRpBB689UNie5Kp0j6xhOoITBqjRY1hYw7PhjnadlzCGuM5hr56JSWjYSvD
 Lc8Saw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e2dkstaa8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 02:41:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c828659ecd4so395919a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778467309; x=1779072109;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=csTFQhCS27/TD55NnmDyE77bhxVaxEVxBVRrSVfa5Fc=;
 b=FebihonN72B9tdzt/efe7QNgsCQ2yRhMDyt3LTFvkJY9Rw7bXHLTZVxmMI4iFBbgvc
 O0kVZKEByVbSdptvXGm2JBxQ+WGhXmJBXMRN9KUZgEfTLbuSB1CYgw1WdjspUi5MkS8d
 +1Bad7BHhVvRAiIcg2gjId1gCPBNfEe+PMvfK48JjgWcTrshqBqHXJIzt6bkL8IEkm3J
 f1XKQFyJhU6TSaPs0PuHckCipxICEAKX0bx1Vc6NLXoey1282NfeQJc8seZaan2B0KUb
 ulvWoqsbKFQ88DeinN3/I/A7KzcFLyPv+nqIXkFFgfqU3ZePA7p2vUIPbNDcN/YtTwW8
 WpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778467309; x=1779072109;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=csTFQhCS27/TD55NnmDyE77bhxVaxEVxBVRrSVfa5Fc=;
 b=KxA7AsfrD9sD4rGrud4TvfGuUrtgOJX1MvnCCLLQSPST7cdpKs6QBkv9NdviKbYfgq
 gv6FEZmIQO3qBPM14hKbU3xi5brIvHloDBd4X6yBexKVoy//UAMu5zT43xCLON/qygCZ
 wyxs+qOXq1vulbAWjSKi5NHqYyHKqT70V4qwpC/GjFx/qFwAQTpvooXcXdatUX0OOhtw
 bqXW9qxTs8q8lCg8P0OoxUpIH9Dzmg+XIsRJ5/OK9+zkU+b0c+NvdojUCpWgIlF/gtXo
 dFo+4iMXs8FRvCtT2Iyr9Aqc1rq69DyuBJqflhmc/01N0AJjJK3/FPcTKfwHHwAH41Sx
 L0lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uU5T/Cpa7l/E5S4e4LUv15JSemmhorzRovbbQHBD393wi4xh6qaXMHYs8kN3XamfK6Maiqv8y2Nw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyR1xKFxtJk1NfHO1OEtOzewKKhkeNvVldsuXrhDiC2YgtEhMve
 ws33PWm8uzQJOFYhztWw2ceVdqiN50b6pcildVaJFOFnX8zwcMLihUZ/vvy602rm27wZr58PpPC
 ZwqVCIz7Kr8CpYnI0E6Dnpzx40iDwhczLs12PhqTIOV86WgfQ8yQ33Mj9a5NHqeO5Rag0Z5tDhe
 BvyBw=
X-Gm-Gg: Acq92OGflGgKCgh4fUqQiHMJ6fRNGecOdItqAc2b8EkzSlQVd8V8/Ho1cTAKfhOpI/w
 2R2nLqoFQP25zN1eBSEY1RZlZmeKJquDcQxDi9+/ACUvnqjJP0DSxiCjtBQTaEQQgyMz8zSj5yY
 +L3bliphxNXXLGlXvQ4XZ6s60h+iKtoUffqblSBxwx3qxW66ss1XOJDRhhaYc/+ZwtdzDN9vKG9
 VzvYo76yRm+eO8wEWe2sYo2LP7jBjjppGzGEKmqDr9z72+h9RZ76S8ZwSaoIIoc3Re817HL74D7
 QMEUKy6aL1Cttra1wl6yH5ylluywEIGbxUn/gVnmcPn6oGz967W76Gc90o/1JGpv6TdS6zE8o7h
 JTzZZSqi2lHCXBQePIpFkApPKp2ulGLyPRC96oUtwFe0LDas0YhWk
X-Received: by 2002:a05:6a00:c95:b0:82f:74dc:5f48 with SMTP id
 d2e1a72fcca58-83a5b2d34ffmr20957175b3a.2.1778467309318; 
 Sun, 10 May 2026 19:41:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:c95:b0:82f:74dc:5f48 with SMTP id
 d2e1a72fcca58-83a5b2d34ffmr20957150b3a.2.1778467308715; 
 Sun, 10 May 2026 19:41:48 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.195.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839679c7ba9sm18671564b3a.35.2026.05.10.19.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 19:41:47 -0700 (PDT)
Message-ID: <06380d7c-e6d1-4245-9518-a1155011c68c@oss.qualcomm.com>
Date: Mon, 11 May 2026 08:11:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] arm64: dts: glymur: Add LPASS macro codecs and
 pinctrl
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
References: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
 <20260325035338.1393287-5-sibi.sankar@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260325035338.1393287-5-sibi.sankar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XP9S8GDYoxBiK4EuWtz-vPvnkvtziExR
X-Authority-Analysis: v=2.4 cv=d93FDxjE c=1 sm=1 tr=0 ts=6a0141ee cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=FDuvZuZHjihTmU/CkdNO9w==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Q0yBPzA-_2TLdE4bsmYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: XP9S8GDYoxBiK4EuWtz-vPvnkvtziExR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyOCBTYWx0ZWRfX0UOjMVW+djd5
 lPM6GNd0QV4MsMzgMpfsJnzEFEp/agnYLDgKhVmRw6hMouYEz2MtxpH0v5wVlvY23gyZCdDio2d
 5+wVbNpKEZGlaL13vYiSJPe8vRKWLFLcv2snbUVbOBxQqr8CU1bzj2f5D3D/I5E7Zm2GKxNJVpK
 fGq63t9uOVpT8I0il943du+llr0xTdtfV63vujaYAZteylz6XWwIdWFK7fiRKo5PwH4wUg1N4Lk
 RdYzmkm29okakH5OnBfV6pmkrcLkZ4va26s4EkY3OI9BisGaOew8hGPj2sU9TsUULaJH49+dD7J
 6qi1TNN5dCYpNynerSGJkOE5q08tuSgvYs90WMfnXY1D5oUAOxDS+mpn4n1zLSNc5cUmOfgDLUX
 8IiMv8+32zBftUo09EXfxODelA4djUE0MAAjkezkGujBu7bmCc1ioF6Al8/4c8fV4OI3/cKMNsd
 1DyfrNLc1kx0svBFPxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110028
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


On 3/25/2026 9:23 AM, Sibi Sankar wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>
> Add LPASS macro codecs and LPASS TLMM pin controller on Qualcomm glymur.
> for proper sound support.
>
> Also add GPR(Generic Pack router) node along with
> APM(Audio Process Manager) and PRM(Proxy resource
> Manager) audio services.
>
> Co-developed-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/glymur.dtsi | 263 +++++++++++++++++++++++++++
>   1 file changed, 263 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index e571710de40e..61a5f263f5ad 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -17,7 +17,9 @@
>   #include <dt-bindings/power/qcom,rpmhpd.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>   #include <dt-bindings/spmi/spmi.h>
>   
>   #include "glymur-ipcc.h"
> @@ -3818,9 +3820,138 @@ compute-cb@8 {
>   						dma-coherent;
>   					};
>   				};
> +
> +				gpr {
> +					compatible = "qcom,gpr";
> +					qcom,glink-channels = "adsp_apps";
> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +					qcom,intents = <512 20>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					q6apm: service@1 {
> +						compatible = "qcom,q6apm";
> +						reg = <GPR_APM_MODULE_IID>;
> +						#sound-dai-cells = <0>;
> +						qcom,protection-domain = "avs/audio",
> +									 "msm/adsp/audio_pd";
> +
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +
> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							iommus = <&apps_smmu 0x1004 0x80>,

This SID mask should be 0x1001 0x80 instead. Current listed SID 
incorrectly overlaps
with the ADSP fastrpc node. Will fix this in the next re-spin.
-Sibi
> +
>   		lpass_ag_noc: interconnect@7e40000 {
>   			compatible = "qcom,glymur-lpass-ag-noc";
>   			reg = <0x0 0x07e40000 0x0 0xe080>;
