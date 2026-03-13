Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCEA106FD84
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEEB10EAE4;
	Fri, 13 Mar 2026 06:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QJfMvUBq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0OPP9zO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0346010EADF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:05:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5tbob070474
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zeM7gmRvWE3zPnFK+DBIUx8d
 4QuC9ACWMKfdIK3rw1I=; b=QJfMvUBqwcfY9u+taSrVQqTd80hEJj12tOwH5Q9j
 xaX9k0s8mlDbhIGsyeV7Sv2muOCdElzAqOAi1FkgvuzsypAnc9KVBF/OhZbRfuI0
 eP3/swrWAVVyoStb5e+YPt30JEOc7NG6psZJycX4CZ0mekZSKIfbVV2E1p5/Ff1p
 UXQnYl2ePnKSwUKn85QTF0fvIYjitY+MK2kohDZ7/b+AXxSNk2IYy0TqJGFJTwzA
 PuKJfdmvTc5N2rmnW1mvZXsxdjvfMVtx5kAOry1BM8k/Jy/nrsUlXLxe3dy8zJDP
 OluuQkZYpex1FDmbDCQwjYuzgihFZk+Hwmeljq/GFawn8A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4ymqht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:05:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aec3f67844so13251815ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773381909; x=1773986709;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zeM7gmRvWE3zPnFK+DBIUx8d4QuC9ACWMKfdIK3rw1I=;
 b=Y0OPP9zOoC2iFHp9onepzUXQyK8ugmZt+cR+XRESBD7qwokKonC3gogJGzQf9igP+w
 TBrPba0e2g5cLOInlBgVRbTtE1cpflGoEFKILLNyWv8au6Ia7VoOKq+UpeadTT8cHcUd
 jbZg4XFGteiasfvyrF00O+/hOkiUKxDoMCAvFTgdcwEci1jC0c36HzIGKa9Ho7g+2P/O
 a9epCjTQ3bkMNux5Sj57WbqlNMh/830wsWSWX8/koBr9bcPNrhSExT9tdvoKqCbymh3V
 9sREX+yE/SXohic27rkxcyNI8PFam0dQ2xBqumEUXAgyGJ+ae5UDTtVketFmhagE5pIX
 FHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773381909; x=1773986709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zeM7gmRvWE3zPnFK+DBIUx8d4QuC9ACWMKfdIK3rw1I=;
 b=XWQslKu4pXHMq4hpcNK1FUnBTDu2VrHBefseDH/cjZ/o6u4QUfWpQO+Pqu5hjTrrqt
 1w+BVdjxWSeCEluTBX/rTxCHrUxOTNUIag6HRn/cH3Wwod2OYkZAUUyvyYOqL4hjZVT7
 kdH7ah77kDpy/bsrkuAQvgzoDCVwdWfVjocKY3xtKJc68VX0qgLyyvzkU/4dmbDKh7Np
 n8h6wVyBFZwuFp4bZ6Fs8YOKswh6x4vPM36FSRnudx/4uGD4KiSLxNVOyZvZvKVldsC0
 BY1eLXJsE/u8o/V9H/QhmQgpkxRgDaDldFXDg/iBFGoLIGs4L9AkBiODx5vnvYXs2FVn
 Pd5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ5aSJwHoLNYxXWhS2myR+d92EEOrZth6vJH/ZjqN/sQn9kt9a35S5U1v+cwmWWDVDbDOXWA0ANGc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLvWfw3F9O3dJgF4CMvKO5VmLbrukAPrv30TpdnwzJ+wPnuacV
 jzG2ZVRlYyB+opl+w/4dZ1H0j+ABlFBM+DI0Bv7+TQ9fdVHmcFBlIRmgoWL8BBh+IS+OoBc3yfV
 r/3mZJoyWNCVcbv/jgdPzgTpaOsXWtLugk3fRZMN+TQ5zd0waH01eUT/IZlCOusOP1PttLrk=
X-Gm-Gg: ATEYQzz8tmQCeB9W4O/NV6IZzzRJNolwt89df8w07NcZ1bMbewz6Ei8mr6qAnoVqQbY
 fbSyQMNn8yM3EG14MYMXki+ZdQWaT5mPwsyI8mbTpuNraf+t34XOEMqL3i8gXyRnXFk3cwPlYgO
 MyY41YKBIrSMxnl/i9fgZEIadX44gXt0mSJ7kDu8odjistBA47rt4MeuRIj3sOCTtwUutxCBhud
 ZNjVvwzi+982CqFewQgJO4vjo3Hs95Fh6fEQCPteXkbzltCkSCtLb5z0Rzwfn6ahb6kKacrLbJX
 FmCDqfdwtfqKBLOXLX6BTTJtPTZH8tu8drl4JBKxvgz4VwngLc9TLA3R/batFGezEOhZrnNI4e5
 ePdBC2EeAdl/3ujrR7fRCfsTS6CzLYy6osh7vSbidhX1n4eJp
X-Received: by 2002:a17:902:e80c:b0:2ae:a786:6663 with SMTP id
 d9443c01a7336-2aecab1e86cmr19453735ad.26.1773381908529; 
 Thu, 12 Mar 2026 23:05:08 -0700 (PDT)
X-Received: by 2002:a17:902:e80c:b0:2ae:a786:6663 with SMTP id
 d9443c01a7336-2aecab1e86cmr19452995ad.26.1773381907930; 
 Thu, 12 Mar 2026 23:05:07 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ee5b1sm10183605ad.46.2026.03.12.23.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 23:05:07 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:34:51 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 01/15] arm64: dts: qcom: kodiak: Add EL2 overlay
Message-ID: <20260313060451.hswg6snnnexchmzs@hu-mojha-hyd.qualcomm.com>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-2-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312062756.694390-2-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA0NyBTYWx0ZWRfX2QOzxv/N417Z
 gDGjxTk03IL6yR00XIaYBOy1CB57PSTCJQfH2JrKDZIK1+yZeRGakbu/iFyb2qs21NwipQchned
 U772jitUs/tPr04Qg2jM14hpX47UtBdb95JuH0M+4ayb2mOulm3KN74PjD88hkEer3MZSdo7WrF
 lbvpW4JumAa3BK32pBA9fQOsNJSeMKI6hT7EtBjIYvQ6h84da7D1viGyVgv9nkDg0T3rhXaUWRO
 UuywsYLPCt/DtFnKftDcE71JO9nYqrSXNA+ZnkK4Vbs5Hdi06dRe/pN80PdiljXI4Ri8z0AWnpp
 2ZRAnNWUwr4XMRRQW5aUSIBdLfRJDH4L/DSiybiWhBBfpljDG2bPqzTw9fwaFnnNvpEkDW5KDkO
 Eu5ZBDX5cg0wTR0ctWdtyCivSCpzpOGHvMFtW0kThBsoBD3ThlZdvCJDGVPXXEXDZyhOT5nhiBd
 zJzvslA/yvNW0we2Sog==
X-Proofpoint-ORIG-GUID: D-e7wGnsPAyMEgZv4QmROw02eDUmZpaz
X-Authority-Analysis: v=2.4 cv=C+7kCAP+ c=1 sm=1 tr=0 ts=69b3a915 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=D5leSQ3MSkE6s3ds0kQA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: D-e7wGnsPAyMEgZv4QmROw02eDUmZpaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130047
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

On Thu, Mar 12, 2026 at 11:57:42AM +0530, Sumit Garg wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> All the existing variants Kodiak boards are using Gunyah hypervisor
> which means that, so far, Linux-based OS could only boot in EL1 on those
> devices.  However, it is possible for us to boot Linux at EL2 on these
> devices [1].
> 
> When running under Gunyah, the remote processor firmware IOMMU
> streams are controlled by Gunyah. However, without Gunyah, the IOMMU is
> managed by the consumer of this DeviceTree. Therefore, describe the
> firmware streams for each remote processor.
> 
> Add a EL2-specific DT overlay and apply it to Kodiak IOT variant
> devices to create -el2.dtb for each of them alongside "normal" dtb.
> 
> [1]
> https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> [SG: watchdog fixup]
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |  2 ++
>  arch/arm64/boot/dts/qcom/kodiak-el2.dtso | 35 ++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f80b5d9cf1e8..09a7f943190e 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -139,6 +139,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-radxa-dragon-q6a.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
> +qcs6490-rb3gen2-el2-dtbs := qcs6490-rb3gen2.dtb kodiak-el2.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-el2.dtb

We may need to add for couple of more variants..

>  
>  qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
>  qcs6490-rb3gen2-industrial-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-industrial-mezzanine.dtbo
> diff --git a/arch/arm64/boot/dts/qcom/kodiak-el2.dtso b/arch/arm64/boot/dts/qcom/kodiak-el2.dtso
> new file mode 100644
> index 000000000000..0b3a69a0d765
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/kodiak-el2.dtso
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Kodiak specific modifications required to boot in EL2.
> + */
> +
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&gpu_zap_shader {
> +	status = "disabled";
> +};
> +
> +&remoteproc_adsp {
> +	iommus = <&apps_smmu 0x1800 0x0>;
> +};
> +
> +&remoteproc_cdsp {
> +	iommus = <&apps_smmu 0x11a0 0x0400>;
> +};
> +
> +&remoteproc_wpss {
> +	iommus = <&apps_smmu 0x1c03 0x1>,
> +		 <&apps_smmu 0x1c83 0x1>;
> +};
> +
> +&venus {
> +	status = "disabled";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};


rb3gen2 has modem as well, did we test that as well ?

-- 
-Mukesh Ojha
