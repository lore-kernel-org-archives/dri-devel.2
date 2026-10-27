Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C9606C92D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JECJ1hD7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eV6s+507
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABC010F409;
	Tue, 27 Oct 2026 11:45:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE53E10F409
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:44:52 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAeCcD3012047
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lE7AshOR9IvZTWb4KZq+JxDO
 O/khlLsKuqrhcF9jNKs=; b=JECJ1hD7v8moO1XN6ecJsdDt6TuQlsG5Fw8AGyBv
 SRdm5mWhtl6JZijzfe7UdoOdJP+7kP9QjjLQMphlmGNiwqUQ29O/SHADAdC0drng
 nvZOlcFkb8PSwKF1bZtbJFygVxaXT1LYi+wh1uM6ONeX3IBCLss+MJJjE0FOQicb
 vbHBdeARg9khPu4JnTTJNa4VMO0Sk98DNk1+OjAxQvnoNtkEDqGmB+/23Jsl6KCM
 +BQaqRa0d3ZBR5UC3Xf30cV7FWGyOuQUeH1HPeJNxoL6aRlfKXiWLPblY+VWw3Me
 U29bdBvrEZhKiW8OK/Wn32P0WXPaJdCkrGbH3N2nLrPE+w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3datvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:44:52 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7c15deb3794so848001137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793101491; x=1793706291;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lE7AshOR9IvZTWb4KZq+JxDOO/khlLsKuqrhcF9jNKs=;
 b=eV6s+507GKGU7Tnl70qZBrVRdNoU7ZTX2Gy6ccQgO06UsdlhZLeipXjOhbUpxCP7EI
 mGwT1NUE1rmN3R1MhpX+2rrulmjt3rSTdR6cpcEr+T22XEi9UEo+6Xcz/2RP1D0xlhu/
 OJYSSTq3Fm/y5Hob3RgUYprLddC85ssjB/dOVWrHK5LanIUjMwh15zbCC6EDmVU3MS1k
 pcr4qImeiMPjDlbTnZOHK6E/YMpaOSg7tfXlwUrv7lAAVBEqu76EuG/5RH6pmQSE8VS4
 aUjD92K61VVLKOs5+2jC9+vZ+5ThdfMtls3x1XLCMBjtPIeMyrZIGHktzuKiUVrgYC0p
 DGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101491; x=1793706291;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lE7AshOR9IvZTWb4KZq+JxDOO/khlLsKuqrhcF9jNKs=;
 b=qPD6q1JWFxl+EKV9YklTT3nDpZer1y1ORXyU3cYFGpjXcHbisGQgp8jB+4aEC3MGog
 NoNBP02wlW9/rtIpa1vZnm3X4qayDGPmObIVQg78HVJ0OH2teh/qqMob9sYO2r1IvOpC
 zkC3YAH8La74V5wW3Ewgno0dOq+aYQ/s2swMA2zl7mxJZ1IR6X9GZ+FlgmuP/BQHvn4n
 wXsNMUgsrCI/sno7ihZZOgGmclkkJ0i8q08WAW6C7gYt7JoJDCgHaoCP1oW+ce7n8b5e
 SVUqEFbw5nm+D1gVaGEjmdzY3c+gv2/hCDnFttCD7orE4Iybu6Uv6my1bh4O9btARXec
 ITMg==
X-Forwarded-Encrypted: i=1;
 AKwUvByonQ4chDpssafUsU7+LrSOA3t6G98+Q6MOY8+u/vHClqPAEGQB0w8yLU9EvCm03VoCCiKKTanJ0+E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLA+mXqKAKv1mlDd75WwbO1/yueDenhKK8vBLIaILgPhyy22dBf
 ZtfIDA5s6unHdjcIiNqfMDGMsKmaINE8VfphYFIiM1pjdnFbL4rxjCF3aBd6jf0CgGy2UJHZrJ7
 9Inrrhdmuyu32lvZ/Mor9qHaL8n/NcQIFAuQkxZeIokqBBAyXdssTYoiuqojLouZ3/Pdy29I=
X-Gm-Gg: AYBFou3hq/47XZdDkwMz/j+535Sw3E2mWBkfnDzFoxMqCd75h8HF23T2JhdcxRFDDD2
 8d9cTZ8DfmibLJdPvc9sUbbfGerDID03p3iRiRwQsf/sqFdtxdRPdTIRC2g3Y654O2CTk4Pbfyi
 vQ9k7kK+hrB6f+8PBZbgI8KWnsjN39IOOZqqqtH6jcoWO+rhbhVNB0KlAoj8PoS5ltIRfscvP0u
 AilJRRtkmrHQqHH5yLtzKVX1SeBVSe2vUX2kOCgKK4AJpZd7JziAIEWApwOmMVrhYyy8GPrTaJd
 aUw/hsrYp3CC91BRKe+/PiAAHmzM47zBZGcIs720Xz8vNrN6AV2thUlcO+FQHGPr8n8cS9mXNFU
 m9SZDWzUjlQefc+gzSK1poUoo5GHKAAPh/ohyY5ENrFupDPKdm76KMLzLWbMdjXS5apTS7xQWJV
 DjVMW9YE4UAKP2
X-Received: by 2002:a05:6102:5048:b0:7bf:74c1:b606 with SMTP id
 ada2fe7eead31-7ce5ce4227dmr2779171137.34.1793101490727; 
 Tue, 27 Oct 2026 04:44:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5048:b0:7bf:74c1:b606 with SMTP id
 ada2fe7eead31-7ce5ce4227dmr2779134137.34.1793101490117; 
 Tue, 27 Oct 2026 04:44:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a8945esm2027201e87.53.2026.10.27.04.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:44:48 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:44:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 23/23] arm64: dts: qcom: hawi: Add DCP support
Message-ID: <zg235e6lnlml52ya5fj4f4ulmamnqrlvtfs4yj7i4z4ezrr5uv@zaybpfrp5hjn>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-23-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-23-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfXzddKO1lHfqZH
 6wfyJ+WTuytOMCRW1RHCLhMJ3WCoHqjSotRVng4xxMAUQ+Fpcs9jiNP9AYCnNdn0s7OaZ8qWSBT
 PSIwDJp7QKsFLsIknflM7qroW0/4q10=
X-Proofpoint-GUID: HWEh3GgkeDgsozeXsUVsIagNJM5ZuLJq
X-Proofpoint-ORIG-GUID: HWEh3GgkeDgsozeXsUVsIagNJM5ZuLJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX1m2eXZv5TeDe
 DuTrmMAk/GsKdkKk54JczpNYVacO3Fr6YChqaWWG787m3LgjyOjjYocUmR0jFbANqFFOYrDiIRw
 aFU/2bxmC90UnHSqd1GYqGzfkg8sMGCnVwAbrmSHmZh7oJVbemrYiVXx/O4GX2mI26z4Ie9jQs8
 FSb8K6shQTdXqEpLVPwap5Ab+H/Io9woIy5qYRltw6SAfBsH9LHHgq22wCkV2dDGpF83za4Hx04
 iMMwL4bSVK1Kmkyeao63Z7Z+dl5opb7PLndW67I09r+2kX6xUD2BieAL9rqE7Rm2bBXZAST7AKE
 oMWHrrLR1oaP2yylqkoBp/ZtQbU/bNckij4aePoSdt8W06Uz0n288QEUa9cLRMbuilPC4khAaF5
 5mQfIhMeZZ8Qoi6fkxTRSKX/9NAH5ZyqZqD82aZFKuiJnaRea+Q7Kve86aquFAOBbTLJMHUDJXt
 firxUpPHyhrwZhgpO2w==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae08eb4 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Imd885ZT4_v8IS7qKhkA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270046
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:51:33AM +0530, Jayant Shekhar wrote:
> Hawi display hardware is owned by DCP firmware, so the platform device tree
> must describe the Qualcomm transport wrapper, firmware display subsystem,
> power-notify channel, IOMMU contexts, and display graph used by the MSM DRM
> driver.
> 
> Describe the Qualcomm DCP transport and its VirtIO-MMIO child,
> the IPCC power-notify channel, IOMMU assignments, firmware-visible IOVA
> range, and DSI display endpoints on Hawi. Enable the DCP display device on
> the Hawi MTP platform.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hawi-mtp.dts | 129 ++++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/hawi.dtsi    |  40 +++++++++++
>  2 files changed, 169 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
> index c38e5fab7a2c..a27003f69d02 100644
> --- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
> @@ -34,6 +34,18 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	display_panel_vdd: regulator-display-panel-vdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "display-panel-vdd";

Is it the actual name in the schematics?

> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1100000>;
> +		gpio = <&pmd8028_e1_gpios 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		pinctrl-0 = <&sde_disp0_vdd_active>;
> +		pinctrl-names = "default";
> +	};
> +
>  	clocks {
>  		bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
>  			compatible = "fixed-factor-clock";
> @@ -142,6 +154,7 @@ sdcard_vdd_3p0: sdcard-vdd-3p0 {
>  
>  		vin-supply = <&vreg_bob1>;
>  	};
> +

Unrelated

>  };
>  
>  &apps_rsc {

[..]

> +&tlmm {
> +	sde_te_active: sde-te-active-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_te_suspend: sde-te-suspend-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};

What's the difference from the previous entry?

> +
> +	sde_esync0_suspend: sde-esync0-suspend-state {
> +		pins = "gpio88";
> +		function = "mdp_esync0";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_dsi_active: sde-dsi-active-state {
> +		pins = "gpio211";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	sde_dsi_suspend: sde-dsi-suspend-state {
> +		pins = "gpio211";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};

What is it used for? I don't see GPIO 211 to be used. GPIO 210 is used
for panel reset.

> +};
> diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
> index 6b0a0ff0faa4..836970cdef71 100644
> --- a/arch/arm64/boot/dts/qcom/hawi.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
> @@ -6841,4 +6841,44 @@ timer {
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>  	};
> +
> +	dcp: virtio@9be8000 {
> +		compatible = "qcom,dcp-virtio";
> +		reg = <0x0 0x09be8000 0x0 0x1000>;
> +		interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;

Align properly

> +		iommus = <&apps_smmu 0x15a3 0x0>;
> +		iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
> +		dma-coherent;
> +		mboxes = <&ipcc 13 5>;
> +		mbox-names = "dcp-power-tx";
> +
> +		dcp-subsystem {
> +			compatible = "virtio,device34";
> +
> +			iommus = <&apps_smmu 0x400 0x2>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					dcp_intf0_out: endpoint {
> +

No need for an empty line.

> +					};
> +				};
> +
> +			};
> +
> +			dcp_dsi0: dsi@0 {
> +				reg = <0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
>  };
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
