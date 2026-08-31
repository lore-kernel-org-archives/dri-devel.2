Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3178CC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4915510E191;
	Mon, 31 Aug 2026 16:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="er3aqxC8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9yXwd3K";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6311F10E2E4
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:43:53 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFphWI3395952
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cVfCCX/QbLHdAwzzCna+Dt34SELB9Z4yDIidd7xilm4=; b=er3aqxC8PVHtCYzV
 L4jlvAHk+obCR5qbz7Y0Ad2XJSb+WD+CHraBf5cnTLZsrtYLwExozv2sslWJgNoX
 DWuKWlJBMFLG80/GsnBAL/ESRCF9MafyALmedoTfs2rSnAzmnbGLgyXBmeoH3rM5
 yEiwdVTq4ACOJUUqooef9R7YtHdYRpEVj9sXQXEdTFMlvKHeM7vKqAONyEFoRS5/
 gTB6rrTkKFtu+0mK+XpGDQ54vztxgA34oJryU4ygCmlTSgPJtIRU7uRCGM8M8yA+
 KI1v9JouAhTUYwR3Op32gcurGiJ8+qYVOx310B6g7HB+FgrFnlRzogMFuuK4Swht
 m3naMw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vcsy67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:43:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930bd2bfc45so122608985a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788194632; x=1788799432;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cVfCCX/QbLHdAwzzCna+Dt34SELB9Z4yDIidd7xilm4=;
 b=c9yXwd3KvTAAIkS9Wn/jDFxOsuySQ97diYhfbJ1SJyWCFRFRN9sk9DVKWlipFySQyd
 gnvo29vO/V8c/IbEScAIPo9U8eCQ8tR35GqAy6+BzLQAV5EZ+jn2dQtqs1lXYGrqyElz
 6NQLN8WPVUaHAroLzymfIauZEHO2x6Iicl8yW+KtMljYpearxSa7aJWxraChcdQ2EP4/
 Ywvc24I4QYr7SC6jZmMpJoSdtynPpDkI/zq+crxTZ60r9Ls2GEL/XUNo8pWfSw0RepYO
 Onky+q6NGMWjj5h/tHlnHpKYUteyCVcGKM778Dnb9aJhKznNxEhukGS2O1XkBBcZ3+vN
 Gv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194632; x=1788799432;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cVfCCX/QbLHdAwzzCna+Dt34SELB9Z4yDIidd7xilm4=;
 b=C45PSvCmWxZs5TBczvtyfjFfEcjKnodMa/rIkaN0JzZglBjf3h76zlzmNE+A4ZytB8
 Y9QzEUrlf0spATPQ4ch2Fm+lsSWhNRzed7Wj5W/Faaf27YRg+pt43FNY3CjkXCT75HV5
 RFarM93A5Yr/giC5ZMV5vcOsreopmtYJnG57AQMC/Huv7MKlA+u0DaMb4RwMfJnnIJOg
 p+oEM6RSQahLKZQ5nhTK/yNVupBdg4xm9k3reUFoQ2nh0omLQ/7L9ZP02z0INJeUvrYk
 4YdUfOgR/kSO0U8lUZZp7ivxXPbIZLYwdWNTUDobx7cx1CD8xgZ8eYBANEklK5mSY0RZ
 J82A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxAIF8sseN7MyrIA26oHJzWEhs5mK3BvtWA3+vuWb9b3t/SoeXsWj5Kws8lsusSzlYPqyc0amBhv4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRQmmRCfYQRS8OwuxhTsFbo/1vHTt0d81aQIG3witVHicjfbzW
 20sdUsS/6Gx5UKMNbGY0kRRo60XJkOF3Ni36EMnMlzzV7yQ7SIwnlTdf/SMo2d2HFc7Bu9V/R/g
 G6OAV93MyRh0LfPbjEwqlui4mahCUsiBmoS1zd3vC4t8qesJGICmkwoHTRlv7bQac4zvVTsg=
X-Gm-Gg: AR+sD11L2SOvZ8NC5QdThnIjufZEzEm/a3sSyKwCe2peptSl+8ymIY9y3sUsgg4yu/f
 E/PoAEkNqx5npL6kk4LfQ6Ss1yZC+GIHv8KYYbA17kul1KlRs5+1gzAZH7f3xgpX0J9r8VZvl7Z
 XEy8OHC+KBii0pzVljXnBhxfCPP2/RCUw5KWVMgmqEwAOgtEb8zSvMqfwDmlsmNIes/ArdGkPOE
 1K6gFnLWyj32+k/K2HdY932qB5nL6m8uuH50KgUxYX5BIxQvOS7aHy5iP7aO41ArUtQ1stJdVkB
 NbyKV+qwUNGo61AyD1CksZKVtcqCdks6jEzv4nbo9O0sa1laGvgGKL4DWw9Rh6iy1TrqwhyqhrD
 yZZVeV6V5x7JbdOzb2cqHQw==
X-Received: by 2002:a05:620a:1722:b0:930:a08c:cf9c with SMTP id
 af79cd13be357-9392873f3c9mr1005152285a.2.1788194631580; 
 Mon, 31 Aug 2026 09:43:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1722:b0:930:a08c:cf9c with SMTP id
 af79cd13be357-9392873f3c9mr1005147085a.2.1788194631028; 
 Mon, 31 Aug 2026 09:43:51 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee27b19sm455018966b.19.2026.08.31.09.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 09:43:50 -0700 (PDT)
Message-ID: <294b2d4c-31d7-42fa-a55a-b57fc7d0ef6f@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 18:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 08/12] drm/msm/hdmi: Add support for PM
 OPP table
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
 <20260828-drm-msm-hdmi-eliza-v1-8-67843277de17@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-8-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NCBTYWx0ZWRfX7pRfuxiZNoiS
 nH+9/WOY1PbLmQk/A4uqmsZwpHy15aBhvVo6q6CzROmolVutBVmNIQ6LGsHHl7xN3XiU7DvMB2B
 Hwtmw8GKoGIaKoNMj6VsTjM0jDslGHydjSeDuahQcd+D3DEFU8EFpnSgxhysioL30nY/K5Wsf96
 I3xw+v2XMuL1a8qvKP38VAwKztOYUX3yNbadMNANh1SUF5YC5ZEVfagfrBZF7M+TQLvsfmCyzaz
 fNVCOZhA9plKEuiVL1SzlnUJXdM0Hf2+TYdah+R9JDMpAAdnrlHQaa7UtnQ9UNSAA9BPUlEMeGK
 HqDnrmqiGfSuKuwMNpAgxQFdYrMxoBStl+ZYBJYGECBXMWbD55RQbuIDECRMi9nWO75EpUS6TDd
 DsYCqtitx8tl6ujWEe5HoUMyv1EPr80yBJesILc+m5+n4Fz6DgnHtLTxAH2hw4ydpU+gTfxSg3w
 pcrN0qTiatbPSWJknaA==
X-Proofpoint-GUID: moYHFtXLyx1nGsTkzdNTs8dz0Upi5UsP
X-Proofpoint-ORIG-GUID: moYHFtXLyx1nGsTkzdNTs8dz0Upi5UsP
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a95af48 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oZguCmW5wH7aHc4LmIQA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NCBTYWx0ZWRfXys0U4MrEkSmJ
 OpfQQVoXQZHkfTfKDa3+HIFYZtQCs+PCOOWBwvilQtMRdLl3vd2Jyr7Ktrhh4bccfkH601lBqVM
 bz8Wz77EvQotrl57WVIK43DjWa5dPGk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310144
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
> Allow scaling the domain rails with PM OPP, which uses the pixclock
> ("extp").  This allows proper votes depending on requested HDMI pixel
> rate.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

[...]

> -	if (hdmi->extp_clk)
> +	if (hdmi->extp_clk) {
>  		clk_disable_unprepare(hdmi->extp_clk);
> +		dev_pm_opp_set_rate(&hdmi->pdev->dev, 0);

FWIW rescinding the vote will happen automatically as the device runtime
suspends. If you think this is necessary, let's do

dev_pm_opp_set_opp(dev, NULL);

instead, since dev_pm_opp_set_rate(0) is a ""dark pattern"" that is
usually misused, see e.g.:

https://lore.kernel.org/linux-arm-msm/20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com/

Konrad
