Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F401CCA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D1710E6F9;
	Sat,  3 Oct 2026 00:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MVAl5iG8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MMMFDC83";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CEA10E6F8
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:47:00 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Nedpx1957170
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n+oeytl8ILE2lGP9tC08C8X3AyaLqZaWEZaYxX5SV4c=; b=MVAl5iG8Lo15jt5m
 aeO2/4y4NEt2oIlneY7iMQe6SPm7IIkm4YUip77RwFIkhAgq1b3DC7UVkazVlyWS
 409t6yFoHgIwQ8qaeBQKPURlGKJj8ZmU9TlgPjuq8Y+o8dRmh781mTMtT/9zRukg
 aqejn/IrWOxKbonrlb424CnFjj+1i4hhgGOkMxu6XXX/ZJQWH4j9p05yrR+iJOQx
 uKMlBYqVpHDoi5ZFbrGkrUlQ1gLyxAmnyUrxPeRT8xmJSu6rBufePqJzZycbBRy3
 GZhkIc1A5q15OAAPUwl2nKBBAQ8lssJAibEHtkVwisgzX+ADk+xfVTXyW6rWqURf
 3+SbBw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2j0ks54x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:46:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c5ab5c136so12170785a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790988419; x=1791593219;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n+oeytl8ILE2lGP9tC08C8X3AyaLqZaWEZaYxX5SV4c=;
 b=MMMFDC83s/lbU/u9SUXl52Kq31YYQ+bOwnXh4lTqCMSMy1/Gh5oN/ZSpEgNjLbvs+u
 iCQ9+haBeYVWr8as6v4EnUfIEEuhWC2i5v+2UpsNZrN9vwItmBJL9dbRCDq4Kfcb+v1k
 QQrOATzom5uV7Ue81QJdAOfcEQzvmy6VNTmUZUNolEiPx+n1AzpvDi/LmBjN/6v+9nm9
 sz9jWmxSf1oKlIT0SgFgu7U4cK/3kL2wO+4zjjRL9DbX3fZWhJEuWeSSuEp/onjw3/Ox
 lGM0P6Y2xzDDs7B6rWTKZEUu/BC7yAjHuoy50EvRHecQYHJMjzQ3nsF4vVWrbVU2xvcf
 VWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790988419; x=1791593219;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n+oeytl8ILE2lGP9tC08C8X3AyaLqZaWEZaYxX5SV4c=;
 b=xLEJTFPzuwAaQt+PVZEd9bv3Ha4AWQKr313itT2zStL1Rv/Eo4h3Tl5uhRStkL4JKb
 iX6vnipp/fw+gz9ErIey+U1AHzxr9Ty6bE5ynSfKUlNy7coRyMuBM5GELo0rlii5ZBEG
 KjgxnSl26Z3GHKAvJ30vBASpuBuvjWSSQeV1fQBGiIhz9tu9hxRNqESCtZHwTbpUrOTc
 mQLm4Pmy98oWh7cPy5wVBG02aFxHppWrCxNDM3gVJ+qFbd7GGjeS7selrgzivBIyUNaW
 ax9e5FIxj5FFGkkMIYPEKWkGD6GYRBKK1STmsrqeyZJzz8wKomY6y6b4nkg/QNw6Arrw
 AVug==
X-Forwarded-Encrypted: i=1;
 AKwUvByiFK2XJIHEeMaOpdbiXYYTvD02K06seHTkQHB7t1iBfV0SQX6z6+GrAqIMSi2p2GXL12yKqHpj7ys=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+007wQg44lgIQNS5VyftwEqySELSHndo5YUJ/HmXQwgccVBVB
 0cBGzb18/Yu/sKI4gihGdfglWMjprIglpo2XovrQjentUr5ySgl8QtnHrf9a9n9gJ5Xo4+SWYgj
 wm7StpOIUuGINVUX3E/F+v5pNrwRQUcIH9QpoU5NUdkKlaooY23dStIxKApRa/dnvW375YG8=
X-Gm-Gg: AYBFou02hhWIhPH6DzuHUY2OXCpkKB6jBs/iEZupUaiA14GC1VJzc1FTq8s3aBi3k/T
 VhOhed8NzxJFjC3vfs7EUZVK9DeW1Q1HtKztfBGiUmpp+f8vffoo9zEjWFXUsl6slMCQSeZ6C9K
 If6fcPvTsrbnI8c6wCSqMQE1cnoxv6hjnbWFsnKSFY9lmKVEFrF/+I4UjrephhbRpvh4l7neK0q
 +pnwZVVsYhrRQG0ILjijq29N98hg9xg9l5agi+P5XEAFkPb91vgJPtfMDKrOeKgIRjcaCmoNmI2
 Z/01zcwioMlXThrzNpigcXR8+9NJnUOnbjqItN96hj33Gzk3pRpFCQQAzdVn0EdlD3Jc03l9cIK
 FfAaYLwinzOqlcFqfO0EeOY1kVNxVKmsohRN7e/7QzTwrLy+LKjmc5jLiVwD7SqMal/cg9d2YdV
 ktvy5znGvsIg1f
X-Received: by 2002:a05:620a:278a:b0:93b:d7a0:d9e7 with SMTP id
 af79cd13be357-93cf19d98b0mr819171185a.65.1790988419177; 
 Fri, 02 Oct 2026 17:46:59 -0700 (PDT)
X-Received: by 2002:a05:620a:278a:b0:93b:d7a0:d9e7 with SMTP id
 af79cd13be357-93cf19d98b0mr819168185a.65.1790988418537; 
 Fri, 02 Oct 2026 17:46:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:46:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v3 00/19] Add Initial Support For MSM8952,
 Add General Mobile Shamrock
Date: Sat,  3 Oct 2026 03:46:52 +0300
Message-ID: <179098834078.3641559.798772743228949994.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX3aoZPu3Q/j6d
 TPFK30EijehCv8KTKmSu9rE7wcdbVGhiPrdrkF7IEmZ1I2yL3Yx53d0NGg0U8pGxiEbhbVP3Agq
 Xp004EE92yzPi1RHp+COTIRY2KLE+oyFW+GpsYhIAYMGg3/jx75HuaKlZyzav3paGqLic3ilyoc
 MUmjUJpvauFTz8IKhQOSTgqXdhBz8soBd/NSpYj+fEtkjj4NuFZS3M2jlRHcGmEGNINjMuEFjMa
 qJcUuaZg8ArNLNp4BC/qF/cJbUp4biN+OfXr9lzv1SfU2/jYxt4ZmQ4F3NwabIFtDimClMkbckd
 NfNzzY3kVplpmTANpHnydzSLxd5Wko/WE8yB6ix3EvbaZzRkqrXGpX+nC5vKLiPpeZt+5fmz13o
 5KwBWet0YGfCOspGXWfGCZk3NEntGN3yg7sELu2DcLid+7dtJ7fUh0Td4z4XURstfO8mevaDzuY
 E9j/3u96JUMniA0Ld5A==
X-Proofpoint-GUID: f-l0uQYoQ20yBIhbjDO7FQxim3d2veh4
X-Authority-Analysis: v=2.4 cv=Z8B5j3RA c=1 sm=1 tr=0 ts=6ac05083 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=sFPzMUYdAbi3-6yuofgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX1nZWPQ2gpeQ6
 78Zdc/JpN21LoGS+duxD7soODzRpRpFvGeZSUGpL7MdFwq7BfsP3AnEnThZGDZusQyWs8XTg+N9
 Dpz4zi4EvbSrXN2Bu5O+U1Qo73ioAAM=
X-Proofpoint-ORIG-GUID: f-l0uQYoQ20yBIhbjDO7FQxim3d2veh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002
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

On Mon, 21 Sep 2026 21:18:51 +0300, Muzaffer Kadir wrote:
> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
> 
> Ported without uart connection. ramoops and usb
> mainly used to debug.
> USB is not enabled in this series because it
> depends on the not yet upstreamed (and not developed by me)
> pmi8950_smbcharger.
> 
> [...]

Applied to ttt, thanks!

[01/19] dt-bindings: clock: qcom: Add MSM8952 global clock controller
        (no commit info)
[02/19] clk: qcom: Add global clock controller driver for MSM8952
        (no commit info)
[03/19] dt-bindings: nvmem: Add compatible for MSM8952
        (no commit info)
[04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
        (no commit info)
[05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
        (no commit info)
[06/19] dt-bindings: vendor-prefixes: Add General Mobile
        (no commit info)
[07/19] dt-bindings: arm: qcom: Document MSM8952 SoC binding
        (no commit info)
[08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
        (no commit info)
[09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
        (no commit info)
[10/19] dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
        https://gitlab.freedesktop.org/lumag/msm/-/commit/df6ce9e6447e
[11/19] dt-bindings: firmware: qcom,scm: Document MSM8952 SCM
        (no commit info)
[12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
        (no commit info)
[13/19] drm: msm: mdp5: Add MDP5 configuration for MSM8952
        https://gitlab.freedesktop.org/lumag/msm/-/commit/7af226f9aa59
[14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
        (no commit info)
[15/19] dt-bindings: thermal: tsens: Add MSM8952
        (no commit info)
[16/19] thermal: qcom: tsens: Add support for MSM8952 tsens
        (no commit info)
[17/19] arm64: dts: qcom: Add initial support for MSM8952
        (no commit info)
[18/19] dt-bindings: input: touchscreen: goodix: Add binding for GT970
        (no commit info)
[19/19] arm64: dts: qcom: generalmobile-shamrock: new device
        (no commit info)

Best regards,
-- 
With best wishes
Dmitry


