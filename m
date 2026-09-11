Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25DCC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91B610E783;
	Fri, 11 Sep 2026 15:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NCpPo+MJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NGvXPZZ+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E1D10E3DF
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:48:01 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm2mS1370692
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UfwvCJZ18lp93+WPqAxfERzMxNsd00Xm06mrFwnyhZs=; b=NCpPo+MJDgFf29jc
 jKcs3c7NPOXvzixt1cRi/VTasJ3xtoZZbYy/22fn4N0GiRKcaW4/kTtajBvta1fj
 bzGVpSwg+dCjMrhUn19SM14/L83MLfmuDpmVJfw6MkLo8drwuJhVNXJKWhfN69b+
 D9b+AC2fUKo3J6J0mcgSfZL+YUvCoU3gC5WvYzJ0px7mTqh2mm80dxAxLWCFuTte
 +diXadbQUlcpQT3bxwfD/8+eEkbtFzABNB9Cw8b20Uinr+6S7arO+KVENv8659GD
 wRaU8ubXpBt9cFkrKoFKZ4VbhxPW06t254skdkxJy9FEkGUIQ6y20sbN83qFAM18
 ol9atg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8jk3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:48:01 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c8328eb979so43249e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141680; x=1789746480;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UfwvCJZ18lp93+WPqAxfERzMxNsd00Xm06mrFwnyhZs=;
 b=NGvXPZZ+Rh2GF77Q1Ch31YMLHIv0DwEin6j85wj3eg1ozoJttxX9qZMCEoakmm4Dh9
 wR1kepGfQ3fTlWX+YTECHdVH6Urem8b4U+F0W6CTiPRzpu7PJUQ/Pd+Mla4TUy8Zz+Yr
 S8P42NSQe2yAL5D7NeTwWC7486pkDNl/lC0lvcxSIN7U4jnAvFayrZJeFAFbRHUP6gjt
 eD8R84pmmvR868l64o2fEAcO+tC293cPd61d2Detq6HwFlnVZ+azYIvUUdTZjXRfH2/A
 Hcn03LufR5WJpHd4kWsSrQgPxe0Iz0ZEgCyvlZdoLx2Xalw5MoRdb9DHqJMqtT7J90f1
 5j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141680; x=1789746480;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UfwvCJZ18lp93+WPqAxfERzMxNsd00Xm06mrFwnyhZs=;
 b=JRv4rDkKm0e48fZGPw+DvUrpx7BWD/MT7jLr0hyAcddUUbh1SndI+FNUCfWLyC/Zol
 0VRu7nZ+yZBLF/ByPMDrOK6FSff1wnnn3YYVH0n5Ih3xiytSAg0ZqEExMjCcpMLPRCGS
 ExMVuExciWSn877YPqW3eOMZBrKEOklAN/bfOTB088JzeC+JhzhiCG0e2x0UHjU3oj+s
 tlesMyUeXF6uoySeLajeg7pSMZCCqxpBQ/XnQNOJiw+vXIUTkVnKRBRisnCZsWjuCWUq
 9/O1vAcsdH6tez3YWh00MH8QkNOalSZOUVpowQ+hSuo1xBtfq4kCqc/QRdrcaIeO1rDM
 O4zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBydry1QpLNk9tJ7TD/LlEIHnphudW4mIoWnywNZNXjsVOekd1Zw3mueEgBqiQJ5wEAaixZm/6RDcQE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m1/SrwsdMzMvsTTf85vT+4u51zkPIAoe4fTYU92v7NfjGc6fvV
 JkiYE6atwAsLoepqcZrEBYvub8SLgWgKet0YotSYQqqY6CFR9OkPZLwKpPSi336zDh7KswzmNy4
 ec1oWKUE3U0Vzg0QK7mgTyMFUPzHiuXyhtQncJEQX6L5hsjBWco4fThujDQmITxVnMcYdjgo=
X-Gm-Gg: AYBFou3DY68XzccvWBiN/f2PsGXiv3vc7MA4I9mG+aBAfoE96ctJ3d1/j5IviAct9xF
 zRBr77m58MEDeejvX1u9GhmwfNmO9F6XdQ3Lvo3AGn/cLH0uDwb83ty5p5Pe7BGU9CR1wnWXLM/
 aH5UuPKhwQxxNoSjoldW1m8Qy6yXDzLW9DFeCTEyjUIYFadSH5tmX6GyVxF5kqYc+WeErO9oGfO
 3sPfuyy0EJ/xM++epi3c4WFa6p5RLyUMQ5IUDKfPV+Rs0ehmnuYGRX/LXz9TVvK3lNalzTFIMtt
 zWbtF5nHnecQKIcw53IwzKUDE8tXMHt9LdjH1z9ouLUit4xv2kL5cbwKeUaiLZgmVuP8SBZBgVQ
 Pwv3D7pffq5zPDN6yV3le2A==
X-Received: by 2002:a05:6122:4a1b:10b0:5c3:a1f5:7569 with SMTP id
 71dfb90a1353d-5c8460814acmr1633994e0c.1.1789141680154; 
 Fri, 11 Sep 2026 08:48:00 -0700 (PDT)
X-Received: by 2002:a05:6122:4a1b:10b0:5c3:a1f5:7569 with SMTP id
 71dfb90a1353d-5c8460814acmr1633976e0c.1.1789141679590; 
 Fri, 11 Sep 2026 08:47:59 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a047fd69sm716054e87.83.2026.09.11.08.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 08:47:58 -0700 (PDT)
Message-ID: <5ab7084b-1bbf-4e1d-a8b6-fa29dd9ba5ea@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NGuJe6NVTzpKngp1-tnarGNBXvW1I2WH
X-Proofpoint-ORIG-GUID: NGuJe6NVTzpKngp1-tnarGNBXvW1I2WH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX9XTAUpnrLKNS
 iFlh6nUyBwvbHykrAgwtMSfyi+nZIXvPn+VYVuXM53wQOW5f6CPt4HItVMfsGbdnqc/Jth82Lzv
 mxxpQE36/1QCRmaXoTv3mT7yP5Yk53yMYee+Rw0spKvH139fdMru6nX7imD6bYeQ0VZi8MQzXgZ
 YDmzKu1+5TR9iNEZxBSwqhLwtmZqH5ASlUCUmNpWPYHdcMw31Iwox+zMCU+XNxe2alzKpYGNtJR
 s0S6Og6Zdtq1ifgHi6zgYmJE7lcx/odRzZgKp6A2NfQZPPiuBR57ZwMO6bF5nZMR1tZWe0rxGjS
 m/3BGYQLba/hGAUxnNMBqUgI2kCRRjQ4PJ2Xtxbu83AZVre/HZpHETWUNYApSQDMSav6G2Yvaht
 nhGoniyxyLZByEDb91WeCq6xhylJ7MOwrjDyIWB7tLb75qfCVLiZTvmSEA+A/EUrN07Iksr9tby
 RkF35B2mMh+mS5uqq9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX3n/2PgXCZVE3
 JXaaqWFzy5NINcykj+8LgjtpTfOjugQphsRd5FXdqJJiq5TjtTUqkYmu/sLKu4sfJ7Eo8k2+bXH
 5IRHf6fOAszKuqy/wWZRLVKkA/veS08=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa422b1 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5N7f0bWkOQp0pCbeU4sA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110220
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

On 9/11/26 12:29 PM, Krzysztof Kozlowski wrote:
> If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
> it should reverse the state of things already changed.
> msm_hdmi_phy_resource_enable() is used also in probe path, thus such
> failure, which could be simple deferred probe, would leave these
> resources permanently enabled for the rest of the runtime.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

[...]

> +err_clk_unprepare:
> +	for (; i > 0; i--)
> +		clk_disable_unprepare(phy->clks[i - 1]);
> +	regulator_bulk_disable(cfg->num_regs, phy->regs);
> +
> +err_pm_put:
> +	pm_runtime_put_sync(dev);

This can apparently fail too.. one more argument for PM_RUNTIME_ACQUIRE_xxx

Konrad
