Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432760A380F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=imzn9mgE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RafAG5nJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F24B10EDBD;
	Mon,  2 Nov 2026 12:42:59 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1034010EDB1
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 12:42:47 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29ALPK1821086
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 12:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=; b=imzn9mgE7jpQF7UJ
 l5NhN9P2tCVnLxb4TdTBR2FOSNJYdj8wTOT26//AF1GPF5PuPIQFSP5ViGDCvCa2
 4mmGrgG3D6wFmc0KCDipUueSrm3NRhQkBzh3GoNpLwmwC9BYu7cq7Ua57vaYcUdl
 7YgM3f7Fj1J108Q1ZgoO2WvAuWPIwY2sapviVFR5lXCi3+SLKGXIo/izg2gXY3oL
 7iTbK1ENuliAtSaY73WLoFYMb56uptzP5XHbepiephZGbLxaLYsO/JhzEU4QKGII
 YlJK7qieMGwQeYo3B/Q8gJ8RC+Ywd4G10lvOIH5zpCYXkTkGoH1cH/FMvobYmo0l
 TdgZ3g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4hpps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 12:42:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5476f5bd009so1838171cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793623365; x=1794228165;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
 b=RafAG5nJf+AUZ5JnmOZk2q64UgcK00xAB2A6Zpl+G/v4+Qo+Cz/u/98g58js0+m7Si
 CbF/6S7lNHbsxRDjwXKT72bhMwnAKuDntxktnmThyivPNt5ZHPF8s+W4KfdPnK8dO/DB
 49NNcOsF1zoDVt2nshKPk4tPWTcq+s17cBEhvVX1OXhysxm9LSczQ4YlQhtKDHVrXGII
 aFqJ5sCmFY0VGxQaPkhV+mJc84ogGvLOmap1KW3KkhI+ezXh3nhbMl67rm+SvgU3Vb2V
 QI1vqlB2ls4xXjOb0fMu1dn29TzwUUpJxnjBQWNAiZmQE9/GdFwwGejfmm+0H68Lk4kc
 wcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793623365; x=1794228165;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
 b=03soLFA/NJpn0TTvsLKq9s0lCEMgcWc2aTtBEqCas2KzkFCuBRDOoOvbX1t4YW9mqi
 IMxeqSQUTNnjjKu5QXL+GmSSTpcXzyiPic/J6/KPKqFdxDS4u4nrv2fzq882yY3pz/yk
 VXXUTRPWd1DDh7KOMoVVR8ZNgfVRDowd8/Q2AmiT4ZnRT4SjOYP8PSpeKXDHMJsQb/Df
 7QFYbkw9YBOV6miZ+VpceMgkken3dEhtl0tdA4OJavc5yT3lXRr0I0M+YI7fF6qdN/AN
 BEbuC6r5gBxWg0tqzP+77Rs4Qa6lFsX6v/nXo8rsS7WpOmzu5q8bhQqBdprW/q6FaRJ7
 dLZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXcUSD+Npl3iTxgZ1218dBO9YD6tkyxZDPtN1Cg61m+u35re0wiaTx3ABfh+6V2oZZ9/tY9JzTbQA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIBY1yDCSuKBTXW+stI/IG9JMj6NdvFaJd0IpZCnkmjmzuFTV0c
 6DU6l8ZDD72lcHku7dUfQuuZ2aIt7tQncnHzgDzUfdnqewUUXCDbQWjH3G7Kpy8AfKBGyIXFfYj
 BFLAVbWSA1/HORoBrX6w/qf3bX8/olvK/O0zsKs0vPBC7naFwBxLleMsCW/JgQbnN2Kb8cSA=
X-Gm-Gg: AYBFou3lTCWrTA3eFAz4OCJaByixAQB8TRWK9JNFkc6zjpOXauQL6OEjkFuOcqMEUGl
 cl+ARzGbUpoNDO418TIoZid72XTlk1zKaDekQjkyf/ITTpmu81Ol4nkTDnXDHba/gR6YAXaYg6c
 /G18d47/Q3wQM5xf2CglbLe5yyb9FtBcx2rjyYj6muAYAdtbs+trHs7rmgXr4wQCnesZ+VDtZSN
 ebxFHRIBqBY6m+4XRx4cXmfRRq04LbEZeqOCejysl3oihtoijGVdUg7Txq5Br7okAb1KR0zzNVD
 AOW1t9tx2DVoMaHYcdgzRnLd1/CkQVoYb4pNBGVRZQHdz6DRGTwY0j/6KnROhnYuA7dAdQ7+73F
 3pdf6VAWSzU7R9YA7AI4gVpiuW9MA0+E1ZRocuKuvZCrDJprrfhI3Brqv5XuP1IDb+C5d6Yk=
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-9442151da69mr1608066885a.2.1793623365398; 
 Mon, 02 Nov 2026 04:42:45 -0800 (PST)
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-9442151da69mr1608063585a.2.1793623364967; 
 Mon, 02 Nov 2026 04:42:44 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc18e78sm399183066b.9.2026.11.02.04.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 04:42:44 -0800 (PST)
Message-ID: <99023059-0d9f-4ad4-a861-299006ae32a3@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:42:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] arm64: dts: qcom: Add initial support for MSM8952
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>,
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OOqomphXBWTCltU5tG5YWttqdRj_exUc
X-Proofpoint-GUID: OOqomphXBWTCltU5tG5YWttqdRj_exUc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX64j9akw/oC+c
 B5LC9CfR6rg0XckNTJaa6+Nix4G5F4Dv+SkPgunCs/zOJE6fQvMxA/h2JGfS/0mNnSIFil30UCu
 kuVY6NgF3NHn1Um6ab40YRXipDdMygM=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae88546 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OuZLqq7tAAAA:8 a=pjH4mUHWGEoP9p1cUU8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXw5PwB+PTl/vX
 NmyEpi7ToFYpktqadV9db6HAW80BGuBOBELfJfdgmpBsm8j3ksiQWRGV8lcDPs+txrHAlElX2ju
 IcNAlX50eD5eGF0mmzRnA2lWLIAOZPyi7B2XO7Jqdf+Zx45B18d/GpFGAun3JwAQv6YDQclC/qf
 MsmfOSjUNRC1yUIPrvmI+gp0DRECb7HtFX/x+0l2j/jHe+D638Gau25BehDmbmFCenXvA66Rq/Z
 R/WTgVH0dfCfhMZRrL+i0/pJAvU2G04+rLcvF24W3xBsB9aMAolO3JgSsJWXuVUwe/AKVtWmYyC
 ZmxjfWcRplPWO20By5e2lEzQGtsf9HkOgO7qGnhBXo1WlsgyO2FSyWeqxSIZEVw6cGvxTO3k7+G
 UDdTigpXGC/mGIpY1rN+c9yH0K6zXSNgHhTUoqXTfLewzBfmea4z9qXKNE/Pnwghycvsjh3Zc4K
 l/6MLWReyJ+S1JiHkYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.
[...]

> +		mpm: interrupt-controller {
> +			compatible = "qcom,mpm";
> +
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
> +
> +			mboxes = <&apcs1 1>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			#power-domain-cells = <0>;
> +			interrupt-parent = <&intc>;
> +			qcom,rpm-msg-ram = <&apss_mpm>;
> +			qcom,mpm-pin-count = <64>;
> +			qcom,mpm-pin-map = <2 184>, /* TSENS UPLOW */
> +					   <49 140>, /* USB ASYNC */

USB DP> +					   <53 72>, /* MDSS */
> +					   <58 134>, /* USB */

USB DM

> +					   <62 190>; /* SPMI */



Konrad
