Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA462C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF82C10E3F8;
	Mon,  6 Jul 2026 21:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6vUTsF+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bw7QBNZ7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E4210E3F2
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:28:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEA5X1504917
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XVyKUn6Qgeu8Cw9tv/zF53VSVfQF2ch+8IMvAUMaMtg=; b=B6vUTsF+PZo2s8op
 k91yrrH8BFLXGcc1v+dH/Y87y48/xr52B74MZi5C5tje3zjT50YWFG9LgR5OFtoj
 uZrN7jvmayh/z0oeFDCqXT95ZjU7vAfo76FtEQpevDbYtyoExwqDWadJCmmPwgTc
 X+VB1dDee4x4WOaXZ1LWivrvuBv7hagIygLM4VZwgi+L+Zc8stvPbySIbh++poei
 UNgwUeZDOlZ1IgxfltcCPkwhSNd6fQYwfEhuzWUHmZhj//qsu3VpZbg+YQdRF0/v
 XQgqErqLYI0rzGYUWqLwQ8gYh0IDHmtYvPATrhY3u2NOpORD50A8YO+sRN7Z5QAU
 RtbGIw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98jv14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:28:16 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-73883529f3eso3250310137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783373295; x=1783978095;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XVyKUn6Qgeu8Cw9tv/zF53VSVfQF2ch+8IMvAUMaMtg=;
 b=bw7QBNZ7N8wwtkjAjMSdfSQQW6LWAfksc0UusNQrNzqw/p+iMWb6Bn9E0cWX00xnPS
 xDHBPso7yK5de47/2UxDQs8qwXScdXwNfjEmIvYQbdKrLW1+DYBjEs8WeI9akh9dgHJB
 oEcRMcElRLFftWUETJv3e+TSKzqJcNnmiAeMTix/265iUWgJTKrKuOz4M8Gc0JHQ7M0h
 97EPqxDHCxQllNyyBRhpWGv3eY7Q/42ToT73bbwOuiIJVQxcrsfWwNFoTB3vqJFlNudZ
 V7/YO0GJc/bJVoMdh7vK6OsmfBFOUvzujEhPToFEcogKv2N9CjBFpCftrMvGENnJjagY
 nrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783373295; x=1783978095;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XVyKUn6Qgeu8Cw9tv/zF53VSVfQF2ch+8IMvAUMaMtg=;
 b=eTlssXrjDU8vuwTyzIw6SDZagrd1MtEL+P+JEFNVhI5Ov+DfH/NEEuY9ebyzLxQyjw
 zjhDgUAsq/NeXd3B5goOpi2HYMfk7FjhodgZ4Yk2KsUYrZMeAfOO1flKOxDnZtUUcCYi
 dNOW77X4zrWQTrcs1VoChL2rXEtGn8A3Ph64VakS5sdeaNrV+m2HlqWTvE3EEs2dhSZJ
 k2P+pE6r7qg05FVyK0qcXDJ2EvO9tJfmt6HEGxLPhVXTfFr45GyLp1136V0uxH/6rcKj
 p+7B1VzbDhGOA1SWSsK+Uwgwd7BV5ktQ+OO8FwqitUe+1jkBS4FdUJ7sJ/WdRnNeInoj
 frLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrGWeCQTTAYjzQbrgbQTNKj8K22kOnVL4dqnSVcrPDoExB9ai/+I5A8nLUCriZuNLNb0EQRNsg3U4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRuIAuM0ggKaVV0mJZFQzwJr/zpmJ0S53/xVOO2HcBykdXK37W
 Mr22zdg+n3NTVP03b3pMsGqCaXV6/03eAWuQl2So0dkiq7O4e6xo+LlKIatrJ3pDTIeRiQB9jvc
 U2hJYRPzEeu5XZ8gSX8Ftu3AE1ipN5KKGvSimNeODLGUOR0sINtJtY/t57l7Hj1Hqr75mjxw=
X-Gm-Gg: AfdE7cm8so/Vpqymcv1xS+3OLc8FLeBFMaczTPkfJuhZuYrJSEKJD4DiGbAaHqyMI7/
 uDhp+EwgxNIUdEwU//7re0xzqG6dcBruaigEjiPj7h08m60Siw/Xa96mwPOgFPLmC5hynMF2pFI
 oJUk9SXopYcJhbmwydxoiNywfToNIkHtqQ5Z3OLhAOOzQ2xGoKbWyGVsxmTxZunIpOFaSKlOW5e
 dhW3LdWS+CVf0XaoxVhNgXQpJsQgpKrQkzJLdfjCNFn7AQ1fPybfWGxyfKIxet/7gA7/rzKsrhH
 CJKC85cp/BM1b3FCc4+F1JNmywF5odBocKDBxerm58LrEYvkiMgE3HoNVYHz3FzQaJyhJ/IKDQy
 VrJvRtk1PnqECx4j9UsyK8QSxLl6AHt88Osw9MPqZrmKXOs2E4Zv7zthdevait5+or9754Iwfwn
 9HYQhMNvyFuoUOfAlceDmoaTwH
X-Received: by 2002:a05:6102:598c:b0:744:a3fd:410a with SMTP id
 ada2fe7eead31-744b7d6e301mr1160575137.14.1783373295357; 
 Mon, 06 Jul 2026 14:28:15 -0700 (PDT)
X-Received: by 2002:a05:6102:598c:b0:744:a3fd:410a with SMTP id
 ada2fe7eead31-744b7d6e301mr1160536137.14.1783373294919; 
 Mon, 06 Jul 2026 14:28:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13839bbsm3150167e87.35.2026.07.06.14.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:28:11 -0700 (PDT)
Date: Tue, 7 Jul 2026 00:28:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH v5 6/7] arm64: dts: qcom: shikra: Add GPU cooling
Message-ID: <cikq6wyljzdlyuopvxno7fipifzc7f2zc6hs2ligiu5esnljui@5mxhammibgpc>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
 <20260707-shikra-gpu-v5-6-d2f373912d3f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707-shikra-gpu-v5-6-d2f373912d3f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c1df0 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=wZTYHpkevF83xUmX0v8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfXxUEOqKH1x5zM
 Gm3CpW1/cKQtZHXcvVg7ceWaHuCVj424gPU64nJ8/tKCrM0GtPxipdqmZf9v3WprzG+guQ23lzY
 8VQN0X+JD8qk0GBoF+ablYAqASFyrSPyO3U+zM6h30dR4MHYaja+kiTfc0Z62d1mra3jsYrAyb5
 IDOobn6fJEkqqhkp2GeOaEn6gw0hsJlERUAxq5SSFeELcc6ScHmUKs3uXehwL/4SfG13HEb5eZx
 K8RBGz+ZfTSG8QoCuds6+3xVku/203Dv5FQsWiapdfGPhjSc/fk6+uOg1UAuSSQCkGxkBSp7Dcu
 1UlobLS0U0TX8VbBz6YFkeF51ELp4R06nqk2pkCub88DDSZjP0gKTFgWFQ6lCaDoG6kZFcsRSm9
 zrKANHO6a4CZ8El/0pU1Aoc3M0g56HvLXyBnUILzDBuWvLwV6qB9C49GhpVz+U1Or9VgSV6DUIP
 8F5067bFJuHN6g5ZLmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX9b/09J9JGIm0
 kZdGAfsJZolHIkjsIjA6coz/7IwQ+JcapOpAG4erxuKXVYN4etU+cBrnGBnFEUB42fi7rgRqbtY
 biS2BYwPLPBy5OPEA1doQGMjzGiOvQo=
X-Proofpoint-GUID: lOWnA_jNmvkjmHTWmICF3CgvNU-p3MG5
X-Proofpoint-ORIG-GUID: lOWnA_jNmvkjmHTWmICF3CgvNU-p3MG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060217
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

On Tue, Jul 07, 2026 at 02:34:38AM +0530, Akhil P Oommen wrote:
> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed when reaching 115°C. And
> use a passive polling delay to ensure more than one "passive" thermal
> point is considered when throttling the GPU thermal zones.

I'm not sure I can parse this sentence. How does polling delay affect
number of thermal points to be considered?

> 
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
