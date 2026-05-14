Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A1CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECA410F1CA;
	Thu, 14 May 2026 12:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTnpVJrS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DoGAEOMv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BD610F1CA
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:43:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeUDW3061899
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EU8VqILiVkLUPw58TAFmECDvG2KNHo2DCKZDUVw7+FI=; b=WTnpVJrSxdmUwNhd
 6OnwELisSHFfwHwNb57jJAIMiM4R/w+Zisp/JAhJgSHJbksSZTLcRgXos6ymekCV
 La1pdg7stJ8GSN+wKtWR+ONa1eqf41tiNg9suNWeI3Uiio0ugBKLoNWtKrsbKd0m
 2Jo0wJIcXcF0gyr84Kgag3qloKqLV21+lJX1aRSXCAAL1MrD+tPYG1o6FgIfkwP5
 qyQxQ0zEp0oyN4Spc2hI+41KgIfKOhWcueMKjNDbHDIZGx/APouCxSZNz0sRmAgM
 y//yKVb5qRZYteVpEg0upBvCbObqpcYr3X/8QZqzFatGZSKgHBix5fgHzCNJ/vQ5
 hRJvYw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e554aa00t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:43:29 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-57606a825easo8988e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778762608; x=1779367408;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EU8VqILiVkLUPw58TAFmECDvG2KNHo2DCKZDUVw7+FI=;
 b=DoGAEOMvYKPEhIlfrwdfCI42nnGEbMAG/MuVoeWjAfF6MXvKmzJKv+SiLlcwJKHOLE
 MuutHPGHBEUeBHme7sAQbdWaHM5FQ7J4yuNK4aZOkBJJ1BqcyEvgljNSzgMp7i0LSARh
 FuhDDUnb5HqxFiMqPNRXBdcdO26eFdNduLV4Syj1O3OvgUq4JAsVeIH4T8HO/Uv+CjnD
 7XMnFAtMqpU6wXttHXH4VuAzvHmaxg1dWot/vdYj6ciglr0NUThA/GUV5CqcRThHspQf
 I1xcexirvuLVClbItMojLDb9okTSoX0ITvz3MijXoJaq2w0+xGBABrAOmyBNJnvdlEvk
 2dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778762608; x=1779367408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EU8VqILiVkLUPw58TAFmECDvG2KNHo2DCKZDUVw7+FI=;
 b=r5Htxe7jHQ+jXoM6FOG7tubVQSxfICSX0rrLas0mpvb/bn9eCYropWud/VMdsZCEu/
 4mljHq1omA6x3ZfPnsmPmedGnMN3qCTq/xbk2ViK67GEaCHUv3FYdPJT5lTh82BixUvb
 oybCSMpumXVGawkWbkgy2EyODuNUEiMqwH6s2QaAnPYt0sRGb9UCdvXqvA5qI7euyqjK
 VxvgGZQcvaHdN309llnp76tCph9wT0eVEoEsiCmDJ/TRXaH1LIMy7TVmtMw2JopjXeNi
 8rp0WcBaaRe6MqoVh7r8IigqKHyp4+oFhfC34CJqblDj8V/bJT/tLBZgmBhFn+JjDR5i
 xzrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9s79ibpRDbjGgvRfoEZibQbhzywgQSPIFtdHZVETkUUCYVgTqz/EWxsONKAAFSd71qL6iKF2ohuGI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2mnUAHBKMgs3ZYpO1MWWwj3SjJpPLjQfDPcdxeNLdj9Ki5/Wx
 C3JQtRzfUGkWigslE70sEFbt3RFqovESzIzgEWZuAS/zKI7ir+GAN3M02xWrK3W3K3b1pWrvP3U
 POlY2fvz+3VM0tQx2qjRN8NaSWeWuE0vxE8H44nqYPX5ZAtk3eAkpVOHcI/hkpLC/PX2lf3I=
X-Gm-Gg: Acq92OF39HdGdjHuKGy/7wBokzbAi1KnxhSwbK3gDGiZH+NrAEZfV1TcY/OAxwANnjt
 bN6i8QNX39oyZMcuTUCd/lZ79KVeIpjNIvB4RJP8BHEuudQnCdC9NKy+LnmWN39ZiY2zi9Dsmhz
 IaGc6mhUlRImK5IEf+u/STgbBPHsMo30TCvlR+OC3F0q9y1TobIrJbvPnklh9Zo9ezQUy/gMa31
 66fUsr2rtn8xTTw1E8sIUq/x/dAGJHDYScUoo/D/t9YGWlhyRfhtj7RF0QCg9Tcfo/K8KeXJe1/
 icGL19wSap3xFEXuxOSibsH3XgZYS6nEZWrtKdup5HYZ1mF5Baojjq2RNDwUV4C9fXOJ3JSqB7k
 hZvDwX8Xtc64pKAD4YFcOS5z0bb1fos253Nj8/FMnGdlkXA68/mrAMXRF9h9R+k++U6QV30Vhqd
 jbC/o=
X-Received: by 2002:a05:6102:2255:b0:632:509b:e399 with SMTP id
 ada2fe7eead31-6377454e62emr1205256137.3.1778762608392; 
 Thu, 14 May 2026 05:43:28 -0700 (PDT)
X-Received: by 2002:a05:6102:2255:b0:632:509b:e399 with SMTP id
 ada2fe7eead31-6377454e62emr1205248137.3.1778762607958; 
 Thu, 14 May 2026 05:43:27 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4de6f1dsm86629066b.31.2026.05.14.05.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 05:43:26 -0700 (PDT)
Message-ID: <14a2fbfd-97c1-4ba7-aa51-a07134102d3b@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UpzD4WT81XPZLG2iCMp9nYHh78NHkMup
X-Authority-Analysis: v=2.4 cv=Wag8rUhX c=1 sm=1 tr=0 ts=6a05c371 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pN7wo_Rnn8_v9tKSZuAA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: UpzD4WT81XPZLG2iCMp9nYHh78NHkMup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNyBTYWx0ZWRfXyOgcvVyS4SH1
 v+oJio41EtgRT2HG72oSPl7lVqxBzCX48MIbQF5wXLbT0yLArQIzxjr6KOuh0O6h9Gv7fJVOrQv
 /RJUzv61oM3AqDG0sW/QbVUHSb95qgjr+cs3YXSrA93dN+FpOUKuZQP5HH1HgJxxeqnswwirC9/
 PMmF99Zg5YuqpNgZv5+DM0gS7TiMqQAFgdjVKR4WMVtjgRUEKa6UQ08LjuDyMJiVJ3n0WnrWmyt
 YvYh63EZTtQTZVCpzl+/DSJxNNZn9ZETueUdWel6uXT8/SX+n7/xgTYF6RCpGRpL9Em3FN6SQZ/
 SXHy8ckrAwKOYWGaeqy62xshRXUlvovsFuSXG+QT2u7ApW2b7vvBy8cqoq6F4Ao//AagI9rTb2C
 TWgnvtq+FAyUNGWR8jYticbWfDdQLheAU1+1I6nUQ2VmMOkKeaHbHZEo9icmy73O8jOcQXl2HaW
 dGJNCc//HT4AkVV8ngw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140127
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

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It is based on the new slice architecture with 3 slices,
> higher GMEM/caches etc.
> 
> There is some re-arrangement in the reglist to properly cover maximum
> register region. Other than this, the DT description is mostly similar
> to the existing chipsets except the OPP tables.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2-adreno",
> +					     "operating-points-v2";
> +
> +				opp-222000000 {
> +					opp-hz = /bits/ 64 <222000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
> +					opp-peak-kBps = <2136718>;
> +					opp-supported-hw = <0x0f>;
> +					/* ACD is disabled */
> +				};

The clock plan also has a 160 MHz OPP @ LOWSVS_D3 and there's a couple of
interim OPPs that you have that aren't part of it (but maybe you have
better docs)

Otherwise lgtm but the size of the GPU region and the GMU base look
slightly confusing when I'm comparing them against the reg map

Konrad
