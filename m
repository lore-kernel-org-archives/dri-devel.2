Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE9606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SBEApJVi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MjngrRUx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D1510ED3B;
	Mon,  2 Nov 2026 11:46:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0323010ED3B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:45:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AM6i1821213
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZWlFwcxl2xS4n689x8a7L4fhFq9uoke36N6N4X0UXRU=; b=SBEApJViBHSkDqW4
 JVisjVeacG339NzlxoFxJd6O0+T8qDa6jW9eYnuWJL84ZiI6z2/b1SeAM9oXP1uW
 SF8/qI5ioqTv7UfMIz4Ay99lT8EISO3zL8+b79xRNSTrZYn02K3WP8DW4CJn3KK1
 7376RSXCa5A7D9pJIzNvoRupn7HuJvlpLZ7N0uKCtIi5k0UOJBCdeyaZwUPjMlhy
 hd0yi5EX87hv5JElC775RIjE3fKoqL8PGVAOsMyOth1XebP3n4xSRdzQuP2slCGX
 K8xPXO4ENMS3Vx10Iq/0G+7UlyuMce3xkxfFXULNivLoDxrKBluEExV8sIBVd3HB
 jys7fw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4hg61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:45:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91ca23ede8fso7104266d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793619958; x=1794224758;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZWlFwcxl2xS4n689x8a7L4fhFq9uoke36N6N4X0UXRU=;
 b=MjngrRUxmSexL/u/irJa1M7TyeIBWT6FFf1/Z61UXGYGtdgIAbHf0ptU8xa9tjdyO4
 63WnYQVl8BRrXtN/zKJPyAoNe2L6Z3zORVJLEmvkCWGnSKGTngSRqgq3hjaLmoOdNFoS
 x5rQrG+OiXvdcRfft3qoxyKm9uE3jTF5YNDj+TOZRlpN/5SomTOMo9bT59uwa14ovrIi
 bP8cd1AKAL54NX2VppMLpDEsa9d1jrfEuCJjoqD30pK7R6fx4yQ9+HVkYixdpmv37YUi
 T6NPqSXEJojGCMl2rxRK33l4gOzMAUQpQB5TA20xPBkEZ+g3rRnilv9NR0wSqURBJKU3
 YrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619958; x=1794224758;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZWlFwcxl2xS4n689x8a7L4fhFq9uoke36N6N4X0UXRU=;
 b=gPvdUD+xKsKntvc+PcbGeAcB43xeXXLPYQNycl7EaBd6SsbKDR96BOTGiUtNuSjvh/
 CMDHr5/MOXlG0TvtScpmtU8+YA2JSW6+8W7l7vZSGRPJKnHiDQ75lS+jPmnNnug2fzAF
 z+3lhM6vOcai+JSqPbQtSvr/knS5OWQYNsIYusf5YSdFC3zRUYuDPBseNQ5PgqF7DumW
 hu868bgPFOZM9DFkENI9hHAMJjxPjLckDWEWEUKLNtlMdxxxakLfhJPasUHFWJe6Plr8
 /ouDQIWf2TT/TLI9ANn/FwenMbf1NmcavRYC6oL8gmXgczXtefbZx3CoP0xdwJ5bvWYQ
 +Bog==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHmFpGNP/PlRCiMpCnQx1H5aeR80KPe6KobL5738kGq+G0ZuhcCeFEJFQsUL7e1/v50AaB54vs390=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKAuxhyp90xWjuZ+akD0sfcLdVAlbPpe4UbmHXj0iFPGWzr7ene
 vx9kvTuH2YCh3zAznRV2qNZQrZezAjrSLY1QpBbNAS/IRcoJZjK0akPGCgmThF6+BtdeJOqOaMv
 pOtmTwxBe9G9W9Iv4ZbA5oAUhnlPwsAx4XBhJU4PXqDm5Y2nr7XHst84blAMhsIEtSvWw0vo=
X-Gm-Gg: AYBFou0N/uSqrzQXKwndh/qRlyacr9hPec4iTlOsdEbbLQY0N0HeoaY4TZD6oZnbRf7
 BeWPfJEU3sIIK7H52f7Qw6qyOUMJPpQ0iv3q7hBTPcts3jWiFcu7Flh9m9qBLDtUfFgyryp80sd
 qgHZNpfjuNBEc1BpzC2gPnFu1itBCtNCHo1MQVHoumPQxKs1IuooYVy7wbVFXZUdtAC8JFD4j+8
 sRjbGLAbZ9OszYfvu6F5BqfA8Q3HtNl92nhSuM3edzF/F6lUH8GSKI5+lGbMxgnEoznCtFfa8bQ
 YSelLCeOJOJdn1YOgQBbpfUxyrzK3D/ejULhOrCCnnAaUk/EOJMd9phqsf+wWqaXMp89Sgm3nDO
 GGn2iMD9wvsN6nooBHd6TIc2RIf+Trvy/TXU811tzGhMH35pyhgwYQma9z4WIiiuDaf5PRMI=
X-Received: by 2002:a05:620a:a7d3:10b0:939:8bc:8826 with SMTP id
 af79cd13be357-94421529babmr1591534985a.2.1793619958324; 
 Mon, 02 Nov 2026 03:45:58 -0800 (PST)
X-Received: by 2002:a05:620a:a7d3:10b0:939:8bc:8826 with SMTP id
 af79cd13be357-94421529babmr1591532385a.2.1793619957897; 
 Mon, 02 Nov 2026 03:45:57 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca0fbd6sm3168706a12.24.2026.11.02.03.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:45:56 -0800 (PST)
Message-ID: <34b84049-f3cb-41e1-93a8-786ccfc3697a@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:45:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] drm/msm: Attach a driver to the GMU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
 <20261030-gmu-sync-state-fix-v2-6-89d3082d97af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-6-89d3082d97af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8ULbo3OOSfHNVBB6gc6UYvnEO5_xF7Dm
X-Proofpoint-GUID: 8ULbo3OOSfHNVBB6gc6UYvnEO5_xF7Dm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX0WLPk1Uf1jf9
 31hx2rnxvl7WV4qnfIuce956cUxOrw3fos081rbWKsxFqmeg9jhcTHb4HPvRPudcHf3Bb7g8XAq
 C5XLcXEpo0EPnFFiSJdSbTAu0LOfbv4=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae877f7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=_eAPKBbB64WD-mPM3f4A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX6j2y8IATq79s
 L9hMFo009il3nNnRbjyXJ2a9fvO7D4a9DSSgWfAm7rc4GoZ86wJhhXEhU9OuU1W4WgywIoTbHoF
 zgqFTjo/1AdDNBpbxJydEMr0GiOQYhnaWfWu1Avyjm0K8Bg8iEKTlP3i6wr5H1hNyyvDn5zWkXv
 vUJkpW9WX8hm9r4nsMgo/07kDBBl+Dl9NK3pPgK1uqC+MWxQHg8T7ObC5szjTHAynhhsijxk4+A
 jlrWr2tl0kBkbv1TzYgnF5bC4ZGSJiK3rqDzFCIBhXedM35Jwlyq3ac6X2+Jn8wZhMWww7fBugz
 XyZEOcD76+yWYymokVslIdlbMP1lvqkgNe3BwS4vGTvdkGPtqXrvvMiYSyxXKf4MhuZQg1A6VOu
 E9kr/GZga0KL6cmOC3ia1HUv6aUu7ZuAkVCm6Fvt6YK98y+jxEVUYIpJy7HgAfeHObXWRDl0rR6
 2bt7eP/cY52BAh2QKog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 6:09 PM, Akhil P Oommen wrote:
> With the introduction of sync_state in the genpd framework, any consumer
> device of GCC and GPUCC which is not bound to a driver will result in
> bootup warnings like below:
> 
> [   24.362666] gcc-kaanapali 100000.clock-controller: sync_state() pending due to 3d37000.gmu
> [   24.371210] gxclkctl-kaanapali 3d64000.clock-controller: sync_state() pending due to 3d37000.gmu
> [   24.380268] gpucc-kaanapali 3d90000.clock-controller: sync_state() pending due to 3d37000.gmu
> 
> To silence these warnings and also to have a proper state in driver core,
> attach a driver to the GMU and set it up as a component device for the drm
> master device.
> 
> Since both GPU and GMU should be bound to a driver before a
> devfreq/thermal mitigation request can be handled, move the devfreq
> registration to the bind call of the master device.

Can we do that in a preceding patch to make this one smaller?

[...]

> @@ -2308,6 +2298,8 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  		goto err_mmio;
>  	}
>  
> +	mutex_init(&gmu->lock);

Can we do the common init (just like this mutex init) in the common
function?

Sashiko has a number of comments on this patch

Konrad
