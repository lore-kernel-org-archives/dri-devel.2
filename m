Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D7CC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA86810E9F4;
	Mon, 31 Aug 2026 16:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUgEG5zH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VeXE5hC1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FC910E9EC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:41:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFpSqj540954
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5XCYPqQA2/de/ZdEUTzkwaR/TQwoMx1WEwb0RhWlBhc=; b=aUgEG5zH1OMt8PXk
 zvjhjP7vjmiyD9mOykEvoqf9abH6aYPyPVOGusQXFU6DHcWRcHahgEmYcOFxt/Sz
 iY4RWuZn/lhHvtDucofwfQ8j2mdeFETnPB/vZoxYMUtRYokPFTrso0l6YrDT0c6v
 qedfXKgH/sN15iVb+GZOcmS1Ik7x48hY+6a3tikokcsclnjX/nUwGKLlULPqKBsu
 g4lOALTfH94eDXh7qXqBGoQncz7pIBpysmvo6goxq02X9LeGHgEEeQiw69MyQrrl
 C8QjsUgrwxCWJ13Zwe8RRnvuZD86yCE8Ij40yEfMCDjZ3c206qDCAoF/DX3wGKEj
 hAJOng==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4x0afqp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:41:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9310484c005so54984585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788194463; x=1788799263;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5XCYPqQA2/de/ZdEUTzkwaR/TQwoMx1WEwb0RhWlBhc=;
 b=VeXE5hC1/AlO5Cc0mjjCGAIrg8W9gy0ZmqtwWFNEueBYI2gCgNV3aXuD5AP7kKWLl6
 whdeV5WnOOpwBrQsl5lAuGM3UhZT+8wy9NZkjpg+0l5J4tvk+Z3WA8Mxs8GPKyQVVI53
 bx2AMK08yHTU/88cUSxOkXZFvCpIGpk7S8Gy3XlXaHtEfaWnLCKwDzB72EeHeUWcuett
 qKMAZ5VbvdM5b59CXzVFG3eBmbWioun4AJN7rr0qC6mLAGUuyylfkokloLKAVyUCZ6KR
 kdqEiQvihO18S0cIlI9XDphWj7u1/MN9+aIEcmgNoFdtsHuskM1tFyPHnyZ1Ksb7p0u5
 vDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194463; x=1788799263;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5XCYPqQA2/de/ZdEUTzkwaR/TQwoMx1WEwb0RhWlBhc=;
 b=hlL7Gy7G7qOXLNxuyVif063T3gc/mGaWqMcFfanv59xCXZxsZLr2DwOVpeNQtmDAGu
 I/TbmmF3ir+96svv/K8LC/kNXYpk1cMrakdhPFVglucHF3I2ZqyUkjZwtcw47isufFLE
 RZ9gCZXHVef3+lT9qrKI9pgSuC4t+MFzZfIcwpcIn/ewFz4Oz+Bvas6eqExKI6ADIm4s
 fAXYmcdhUVm2EU6FwJwXzZYkcHEFzsfs6MzmuIcKG9D0elDbZYqfTxrAMM+wEzwqWUSH
 rELExrIWaKiYH7O6JmPQ8vhv2e1M56kHbr99JiRBd37w9qHqDGHBEqtGZB6KMVtZNCES
 FhpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNU7fcPVzT1M7Xyxjegzw5/nknkDzlJaeUl8WKMB+1uRwYyj5RtrpgBqC7PTrb1XPUD0V71jlxoXA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++khoVu+uThpfLHenSiS+AGDdG7UiwlrfE8cYNETph7WRKGihVWs
 j0oOx+/KiukTcZowJILJBPr9jcEwvDro4rx6cJdSUEy+Xt7BB50o9Pdv/LlRxHnLDkE8XD9icZJ
 BAvrv4bxAYXZiehM+QtCUDTjmpxB1ZnK4hmrkY+1HJuo+RM+cY2yp8CFfVCBE6RhbTZyYrc8=
X-Gm-Gg: AR+sD12NR/6+q90io3DMPp4P8v2gXUUZx3Id0E6r3V4aiPs54h+o6liAGLrp0fNa1hf
 KYNR9xkXL6E4WstnfSIs/Tm60BYRRBTE5x7qTZEO0k7TmA7nplOJTdpx6freG0tOrqjYa3+o81z
 DQQfldHt/qcv3BzddSaJFhKDkAjqdHEeviWZjsgbbXuM9PpfhzAjq8iH2FfVIeYD+FjJpvr9y2+
 ebW9CRPreKazzrWDt0jix2fc1q1pSOD0rzYDmw6wFfHJ+IVYPRUwsRZTDsDU2VDOLxUrXMXYi5l
 WYwNf3nuuAIhAH44BS2C4uNtqmR3KUVd2nTQWKMjUnw+GF/ERYFNIN3CMnJHiMryWBnueEJJ5oL
 d398aW4Kuku5/1MGFrUFdUQ==
X-Received: by 2002:a05:620a:90c5:20b0:939:48c8:656 with SMTP id
 af79cd13be357-93948c81290mr128479285a.1.1788194462780; 
 Mon, 31 Aug 2026 09:41:02 -0700 (PDT)
X-Received: by 2002:a05:620a:90c5:20b0:939:48c8:656 with SMTP id
 af79cd13be357-93948c81290mr128474585a.1.1788194462308; 
 Mon, 31 Aug 2026 09:41:02 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2563c74bd8sm432590166b.40.2026.08.31.09.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 09:41:01 -0700 (PDT)
Message-ID: <c1d13f41-e29e-41ee-b02a-b38013e4e7f2@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 18:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 07/12] drm/msm/hdmi: Split PHY init from
 power up
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-phy@lists.infradead.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-7-67843277de17@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-7-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfXw9rAzeqnygmu
 ftEsDPHJYL+cOj/aVmq+4aLQ/ECZJEStZeTee0owVWmpiEYcvARQblAK5ILJtpkOWH8pReQpL3H
 c0WuCbxFIpyMb/prH0oJHlfRMCLVDa8=
X-Proofpoint-ORIG-GUID: t3gl6WNbKymrIeRJ57grXEWGXk4X2wmq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfX1Ygwd3sdKm91
 2K50fn9AsseL5yp7CVw3qAoPhpFoFEPDqbffqbCTAjOhkhwMrfBM8x7tomNARxx9DtnUhp24bLh
 jRjRjJDwF4mNjud2tfDsXRJdpk+NQEB1A9ISqAtiMf/bLIJM94qNHjCvzYw/s/9UeJJqcNcFRpG
 3FzL6tMSpHJnh7i7gG5wOOsjpuJe/d+x70M48vmqjPodnM2WMoy8vpeGbqafmZUgUTdY1kxLlan
 ppLMPPxkIZjzvMM8n3MdiF+a9cOvfD+jMSu0GENRVW9VlUesDTBOElv4+89zA00oHJUxXd7rsNj
 GKam+tKdWJIf7RO683rCp0TsQ/qE4LGbWqiE7GQmLhP1olcwwMRiRsmBn8SrEe2xlF6KVynDfJZ
 XDJ4nZlDJ8OIb8r0SXdGnuc+9+Q6W71OW8FrFUT9GUgpBPzqZQV+S+/Tu3W2Zi/KkOsOqiBG7A7
 pnRz4dlISGA/m5xpFvA==
X-Authority-Analysis: v=2.4 cv=Iqsutr/g c=1 sm=1 tr=0 ts=6a95ae9f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=nbnyxt4j9IoekFAbjR0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: t3gl6WNbKymrIeRJ57grXEWGXk4X2wmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310143
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

On 8/28/26 4:05 PM, Krzysztof Kozlowski wrote:
> Future Eliza SoC HDMI PHY and HDMI block require certain clock
> operations, like reparenting pixclok to HDMI PHY PLL, once PHY is
> initialized.  Similarly to what is happening on Qualcomm MSM DSI blocks
> since SM8750.

[...]

>  static void msm_hdmi_power_on(struct drm_bridge *bridge)
> +{
> +	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
> +	struct hdmi *hdmi = hdmi_bridge->hdmi;
> +
> +	pm_runtime_resume_and_get(&hdmi->pdev->dev);
> +}

I know the caller is void and it's existing behavior, but we
should definitely not continue if this fails

Konrad
