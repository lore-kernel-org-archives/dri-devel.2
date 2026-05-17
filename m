Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD87CD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 20:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF98510E079;
	Sun, 17 May 2026 20:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfDkIigZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bLEss2C2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F52A10E079
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:59:02 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64H4uha63769234
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2dKp9YnG53YGWrs9aAI98NZT
 hxDIm5i1rqFv/DosqOU=; b=hfDkIigZkbZdJ6Kzh5AzT7tLgSq+opsv4MJhXVrE
 WFwq2PndcbKYuZ/VWoms6I6bPldhMD7gJaxY+T5YJnt8HcL1n97nwmIvzsNtzXNx
 w+ELtQDaZgXpnKIt3/f769l6lKUykv3h4vlnQaTc6dIKE7wKmG53oYMStfIoe33T
 p1O2StkaIu+Vq+e7g2frakwRM8o3UgjOjkg09MRxrNZlgdsSTqAmfGXUbcLCpN0j
 6nH3xDXnBtuRzjv0Cx3OQYCkWr2N79J5n4mHeBjYbWCRyfMURFdElVytrDp3/2E8
 RKibffLoMQKXjr17f6GE3SSK+s5//tEwsalL888MtsQqaQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hbcbh85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:59:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-516879bf1a7so20875761cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779051540; x=1779656340;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2dKp9YnG53YGWrs9aAI98NZThxDIm5i1rqFv/DosqOU=;
 b=bLEss2C2o5EGgytgm62N3LI0fSCHjX+k8XRtd4qtpB/9/MEMyhDd/bSeClpGTdsPhp
 EzR5ncqb4im3xaLZHNrNwgxNrKXyNKdaG3kexL+eC8HxZNKltGcWXVhAWURm6SFpmESQ
 MmNKVoQA04+iozGzSH1pgmn9GXysj0gMr/sfxcdncQ5EugbkQxuy5/PUkmG4q3d8Tsai
 yHj4EhPTGNpVvn4ijOQE6RL+9LvhIzqkZdN096zN7HSPgBoJl3xOX6M0wSGD0HmYYljU
 ulzcTNnvS+nGUpILQolcQ79YRYzcx1xT0fJZoKythmo4ME9TERDCyh4jcOQuIy3nIA52
 1LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779051540; x=1779656340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dKp9YnG53YGWrs9aAI98NZThxDIm5i1rqFv/DosqOU=;
 b=ObsPEiGS4oTNFuWGr5XjMVR9V8E8YnY14Q/eGzVzoaMCebaxGIouAEZ4Wv6Qb3PxYU
 4n6+jorOZQl5E35Zmmp+FEE5GRh9cpDUo+Gk4FeIQf6QqQHdzDKlWvBMXmYpOsESG5hY
 3Bc8FviASu6zdjajZKYpG6ZHIrO1JVV6gsGWDmo7s5t9EOrePdTLq1AQB8a1IxXo0WtG
 rDcyMq50j0S8/Oykug0oMNpQ/19l6FZxpKTpnO1tlTxW2rqqfV0mK9OheOV6uhzbt3v8
 PwP5iqU0ijxiIz1kryFTkHdxVb9kXsG0smAZcrPdvy111nI7mzFCPEk+HIlnCuOEjs0T
 n4sA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DbjbkGsI3HVnwTkxQawWbjsghLTnvWowb/Qnkn4M5sFKK8kRbeHxr7Hz3R08/J2hYKh1+Vi6Z42I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/fTByZpOVsFB0qG6FqYEXEhHbsZf3xZYZgkPkEVIeQ1ONbpH1
 VEA8F3t0JgGBCrWaL9pWVMJ+8ApGjXnMNSKhJvxcM3NDpOJIyyS9ZN6ID3w+imfqKSncqJ62YMJ
 8N5m5UIT2IPmm9Ied7On/stX/1HrFrObL/lDoT5C3B+GE76p+MPK3tlpLsaC5xesUn9mDkSE=
X-Gm-Gg: Acq92OH7sZwMRDuTW9NEgpgukwMUuy0wP6x2Udf+9O2zZytwJYobYnlvf51n7jlNAda
 VFDSxGEB6fxgxbnBFRSBJGoWV88R58So+5SuNvTqHA7Lc9NRO/75BG7sg82cgu9B4ozOAHN5335
 ZJAeje+7yTkKHwtEpXTBNfImkdOjTzVo/tOSSAYFWhPjVce6gg+PITZXCxTY2wMMwk8RouhYMmR
 TAoPKWHxk7UmqDflaf769E9BUTRueol+nHUcBJl45hJhES/V1O0/yt+5Xb+OTGeCNaiHdvSYI+o
 H0eJy2xHGsemLBAknql2JNatzNKozm5fTiMo6GAqi5To4wFgVRYQXdji9bqXytN+naYEFxgZyJ9
 ERF7cByfMuC5pha/L3+n8ALjR+jMIu+1JOTqbvRzBjOiHv+5J3mTps9fqr33l3+Gk+Pf9p2q/fc
 aeEYf5bSQvb6hnmerlhpGOTDAGYFRwvc8zzfk=
X-Received: by 2002:ac8:1089:0:b0:516:4781:39e7 with SMTP id
 d75a77b69052e-51647813c38mr145392441cf.21.1779051539967; 
 Sun, 17 May 2026 13:58:59 -0700 (PDT)
X-Received: by 2002:ac8:1089:0:b0:516:4781:39e7 with SMTP id
 d75a77b69052e-51647813c38mr145392281cf.21.1779051539541; 
 Sun, 17 May 2026 13:58:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395882814f1sm7159191fa.2.2026.05.17.13.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 13:58:58 -0700 (PDT)
Date: Sun, 17 May 2026 23:58:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: vishnu.saini@oss.qualcomm.com
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com, Ravi Agola <raviagol@qti.qualcomm.com>
Subject: Re: [PATCH] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
Message-ID: <v6bw7iszyaoukbcgnunieuo5vcjjrqgf5mct4svpqxcomwssgv@xvfb6y32vt4f>
References: <20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-lt9611usc_edid34_misc_next-v1-1-5e2fd8c6399b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cuSrVV4i c=1 sm=1 tr=0 ts=6a0a2c15 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=AsM0TcmizTee10SJ8BgA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIyNiBTYWx0ZWRfX1KyPU5QmAh3V
 HUx9TulPUCbHZosJSJZEXngsnQ7Lvrwp+GWnilQf/zDtAcnA7xvvJY3CUC6/z17NkguBPcO676S
 Cwr6BwvGzKQ/htdsRibPOJCjrGDVZWHHYefUpLj/oOE9fesPcwq1dG27mly/NxJ2jctLGbkSJiC
 jDUQ+3IQx81A9yP7o5CEPqIWtOgP6oCmKEfLPIktfPOIuJByJqTzkeAe2N9eovhjG5ULKbQfTXK
 IOb5gCMvpiZeJmq9pbnjZZGVH0S/8GxRsASk4cqzX1TkN/+N5cx4N0sm8+AsjlJ3jM5jCIXjIrs
 4LjNz9KQ9kAldLBUSqBRbwBBclAsJhd2kVenlVrKWLociGpde9YsLnn8nmeiHQCVTBrp/vkZSEG
 ZbAF7OiDRFhoYqyoUaoNvFAkH+YSxoDZpnIQFGsv70gwWSijQkD9LTl4DZdOCBuy0hUZwGzEoTC
 Se3QfPX426ZJMCFrVtw==
X-Proofpoint-GUID: AxwTJLeh7TrsUjxunEVKz5N3PSROL_mB
X-Proofpoint-ORIG-GUID: AxwTJLeh7TrsUjxunEVKz5N3PSROL_mB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170226
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

On Sun, May 17, 2026 at 11:44:49PM +0530, vishnu.saini@oss.qualcomm.com wrote:
> From: Ravi Agola <raviagol@qti.qualcomm.com>
> 
> The LT9611UXC bridge can fetch only 2 EDID blocks at a time, which
> previously limited EDID reading to 2 blocks and prevented support
> for displays exposing more than 2 EDID blocks.
> 
> Extend the driver to support up to 4 EDID blocks by re-triggering
> EDID access after the first 2 blocks are read. For block 2, clear
> the EDID ready flag in 0xb02a so the bridge can expose the remaining
> blocks, then retry the read until the expected EDID is returned.

Won't this affect re-reading of the EDID? If so, we might need to reset
the flag at the block0 path too.

> 
> Also cache the full EDID blob in the driver and reuse it until the
> next HPD disconnect event, so repeated EDID reads do not re-query
> the bridge.

Separte commit, separate justification. Most of the drivers don't use
the cache, so, I'd say, most likely no.

> 
> Signed-off-by: Ravi Agola <raviagol@qti.qualcomm.com>
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 84 ++++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 11 deletions(-)
> 
-- 
With best wishes
Dmitry
