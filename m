Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B088CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B48E10E53A;
	Mon, 19 Oct 2026 13:12:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F4110E5B2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8YkFI2688759
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /qNr5y4ZAaHaRtm/DLNxynk27BAss8MqyZxIcCw0oJY=; b=i9nUne6vhgE41aXf
 lSkrffUUfuRxkHp+gVA599Dd9cZ6xzZdCAQaOMZ9WHyyaXG6Ws602kjBjePooA2l
 Epg4wreDPVh2RFlOdHr3XDcSQ92z0Jf+0ibFsS0HUF2qnHGRaqF2Q+UnYfJ2BfBk
 kham9SHdLrcRxej7OsfBtZ8CXavt9x20hlnTwptzX3KBZWJp97VpmeRGOCyH4hJb
 GHyok9sQhrb+hNPHah+0QGlQNnPpit00diYem2TbNTclbQbJPdhn59CC3fA4uhlO
 E6tw77sEpXtXgDOxfy2dA10OiyyXIl/NcAAvWAHATKSZbiLiB2nxZ2OmWG3MV7F1
 ELq/4w==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn11fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5e9b3b44aaeso63453e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415559; x=1793020359;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/qNr5y4ZAaHaRtm/DLNxynk27BAss8MqyZxIcCw0oJY=;
 b=N9pD8aKopGHhWv4yWCKsIHMDvRQ/EkrGBI+LhVvzHY4prqIK44g4ZT7ScdBaRxAP5r
 unLvKbyfafnwTa+VlVEHaVMFcMLf1rHePGC7+EVK6ZkV0XBoMrO32ub4zPf5JMOCACzw
 n33XI22Ton6PYVtPEckhxqfrYRHEXvOKsbRqIhvnX14eylcNmj9Pf/zO/4KwY90lzfdW
 phrvR0slkjCe584s1Wg+QfsSj4kb4QdIzwTGlx2N62YFIcWJxQn2smWWyNZa1sg9LvTO
 mqKdTGZ1qcMSTgydH6j2Mh+sEShCarwYy9M3+v7Wp6aE60/3ryWZDJLOJ5KbEeLWHXkG
 aIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415559; x=1793020359;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/qNr5y4ZAaHaRtm/DLNxynk27BAss8MqyZxIcCw0oJY=;
 b=JiNpAacLKXAnhZv1z8dvto6jyogZDOUvIFuUquidvQTmfJ/s7yc0o0p6Mh3vw/NN38
 NS8vbxejkV/q4yLgYPXrs36zwqD/mMS5gXx1FqUThTjDaD0r7IAVfbLu6156P/cBy+CM
 E4iJyp6mFLrVdPkQR9bnXRNeVzRE3KXTGw8VrLh+P5ttIREJ9MPhpi9P8En3iqxbQTVD
 Vxf03QeyCUvYYbWn7JFlbtUl6FA52HtCtVv6G2jF9nxgx1xQkZ84iQROVkjyQaeuKgop
 K95lWYWTJmnigeYOjajeeO65xdbM+dMbZ8ktj1Hoi7Vv5amRRg8gZjN9VDWD7dn3m40K
 /rlw==
X-Forwarded-Encrypted: i=1;
 AKwUvByjxJFmgMc3si5KUkS0YrOTm5VusRMjkkl32aJq0u+1L9DbLlTWa5O4ojRq7QJvH28M+0pVK+jmgLQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkz6gg7PBHx2hbyI/tvOaQPb7neitBJ1buaGlt+IUWlXz/UGuO
 XSmcCnZZnJ2w4iuqPzTyQ92xg3y9w/VT4Z+mL/HKrerEPTX+V5GJNFo209l+0na+AiqS48N/czl
 AN4i32xtlkwqXLSPDY9d2PrLd7KMJ38uH8v9eby5jVD30iPV4ua8YNRMRZ7fF0bBbcxNufOI=
X-Gm-Gg: AYBFou2SCBkxCr1TrFq/pJSwE9PlQuMra2gzdCV6sDlm99NXpIW9FaNAhsfxmRWHeoC
 YKlZTbq7CDww1uKbLNwUgo5WhFz/AsgQBLtLwXtmPsemli6IDDl2n31cV0RFZnpEPoEivHtPdku
 /Jgy+actZekJKh4iUzzl8g7jkX6WMJyfLVV3vjBYZf9k01AEtDFPfTHhNqhwj28pDWaOKxU62sy
 Fsx4crQ/24lpf4cyI3yIbeL794RYrmD5fYYmZx8DAT2ZHMfuT3ahgcbyc5LgvFAW71sIcy+MRnw
 x0VsqUtBk33iDg+bmWJr+2Oon1ejdQZ3ska4m5K89heLPpjLeNm2iJIVlyrc9xt979AwmtWQs31
 Tz0bbqBhU+NXeaj01xtZyqQ==
X-Received: by 2002:a05:6102:26d2:b0:7c3:83a9:edc9 with SMTP id
 ada2fe7eead31-7cc367447afmr1369844137.1.1792415558894; 
 Mon, 19 Oct 2026 06:12:38 -0700 (PDT)
X-Received: by 2002:a05:6102:26d2:b0:7c3:83a9:edc9 with SMTP id
 ada2fe7eead31-7cc367447afmr1369837137.1.1792415558381; 
 Mon, 19 Oct 2026 06:12:38 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4090dcf100sm353774066b.15.2026.10.19.06.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 06:12:37 -0700 (PDT)
Message-ID: <9a058856-2dbb-4ea6-93f0-ed4d2ccd3ba7@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/msm/a6xx: Program the PDC sequencer on Adreno 620
To: patches@brar.si, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016-adreno-a620-v1-0-4a7ed6210d7d@brar.si>
 <20261016-adreno-a620-v1-3-4a7ed6210d7d@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-adreno-a620-v1-3-4a7ed6210d7d@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXzAB52bq1BdlX
 BPSYuxDovnH0+fnWLCn52lDi39ahvyG62gbtK+YIVD7lSh08r6MWTFNtvwzSxWosNDc4TRUkNUs
 uybF2CSGYs/yVBYeTYbAcToQ4DkYaBs=
X-Proofpoint-GUID: L8yeEFrO2SzGclcC-iZ-BOi5Ajt8af5E
X-Proofpoint-ORIG-GUID: L8yeEFrO2SzGclcC-iZ-BOi5Ajt8af5E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXxMjjcZmXsWh3
 79IUSGbNm30w1Bxn3M1wak2DsywMi8xTHJExAZ8Lrkn10lW1EA7zEfyz8hp+Hza4hsCtnGlV20I
 Icgb2pcG2Fpo02kL2QcP7fV1Vkmb3Qne57eKX4XoQ6Un4h222i9NWw4L9bfVD4qIOxBizYV0Rc+
 3E2b9Vauhau56v4uiq4g7Bj1MM8I1AE0mzao2UzVkeN1fhd0GEmnKekld1TRBim16fBAIcdaBwU
 K1W0caUiE8Ji0rSCfVWvC6yCW1O3BFYKOp4I8vqv+4EdWoR5LmYU4PwqBPoSqhGQT0p82bI6ZK7
 D+8iuD8gJJEJsWouZPSclvS5UCYpb3FDmjAE7+Yx4JqDzZeMZxbStfQ6WOePk03OUV3wlEWkhCw
 7hEvriMagquCo+c5km4k+lixf/GYS0olwylTIEvYBy7zBRyBkjrzSnAevsR9Zm7yPs4vK5WWPRc
 EDQq/JAXrSonYxWssdg==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad61747 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ODsmY_3wxSbvKopP8XUA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190052
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

On 10/16/26 2:53 PM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> Unlike the rest of the A650 family, the A620 does not get its PDC set up
> by AOP (the downstream devicetree has no pdc_in_aop for it). Without the
> sequence, the RSC never acks the second power-up ("Unable to power on
> the GPU RSC") and the device hangs.
> 
> Program the sequence from the driver, taking the xo, mx and cx resource
> addresses from cmd-db instead of the hardcoded ones.
> 
> Assisted-by: Claude
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---

There's also this hunk in kgsl:

    _regwrite(cfg, PDC_GPU_TCS1_CMD0_ADDR + PDC_CMD_OFFSET * 2,
                        xo_resource_addr);

        _regwrite(cfg, PDC_GPU_TCS1_CMD0_DATA + PDC_CMD_OFFSET * 2, 0x0);


====
        if (vrm_resource_addr && adreno_is_a620(adreno_dev)) {
                _regwrite(cfg, PDC_GPU_TCS1_CMD0_MSGID + PDC_CMD_OFFSET * 3,
                                0x10108);
                _regwrite(cfg, PDC_GPU_TCS1_CMD0_ADDR + PDC_CMD_OFFSET * 3,
                                vrm_resource_addr + 0x4);
                _regwrite(cfg, PDC_GPU_TCS1_CMD0_DATA + PDC_CMD_OFFSET * 3,
                                0x0);
        }
====

        _regwrite(cfg, PDC_GPU_TCS3_CMD_ENABLE_BANK, 7);
        _regwrite(cfg, PDC_GPU_TCS3_CMD_WAIT_FOR_CMPL_BANK, 0);
        _regwrite(cfg, PDC_GPU_TCS3_CONTROL, 0);
        _regwrite(cfg, PDC_GPU_TCS3_CMD0_MSGID, 0x10108);


if vrm.soc exists (presumably because a620 shipped on a number of socs?)

Konrad
