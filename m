Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B84F8FA9B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D10A10ED0E;
	Tue, 21 Apr 2026 16:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzbnoL2g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvVJMa5H";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2942410E8FA
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:01:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LCsQZI3574133
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xLFoe4oGDCwTz6b0lGYMIAWT
 Rfszp9f/hXCp89ws9Mk=; b=BzbnoL2g7OaAxndjxnbTnrQXShsD7Wz96KcjUSvZ
 6Tsi/MRp0ynlWCK3xvISh++rq4+7VR3d4KxiUGp5YwU1KKObEivtapREcPNEd0ML
 9LsVPbRM6PWULYn7gISno1YYB4nIyRkS5zUU6y7Qse/xBRmki1c+KmEc6x/PpNHu
 WpwMDahQ8BWa4r2R1VEQW7r9L5xiz5hClS3Lh8YJZ8Di1Rmn/uUoACo5ot7CLtQ9
 R4G/ylpBTDdx4hMXttsZkARlomwjggP3jXUOzeY0jyJoRb0sK7hxYrVVO9ptY/vN
 TbwIOOBIlm7oYSFE04tdIxEIYSrRnpR5Fs74YVyVMxMbpg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp465j2rx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:01:08 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-463a018f61bso3669732b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776787267; x=1777392067;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xLFoe4oGDCwTz6b0lGYMIAWTRfszp9f/hXCp89ws9Mk=;
 b=SvVJMa5H53RA4eRtETeqT7rNpnyrYWjVnPWvACHcz7gMdGawkFMVg9meIu1tIaePTb
 4yaGYHUqT/IaAkk8KCIGvmBDweXMD9JgYFU+8g5OqEdKOZK+sCw4pfXOKu/B15CwKwGo
 ghh4yCUxIJlgrEkCrUVEksGyO74qINBhLADDtcQ8DL9cJVV4CcJVlWaLdCeQbjHIJ+er
 GXlP/ctNXb3DN/IETgNbsI3M9UT3/gbS5XPWgvaecp6yjWZxU6KuitHO0dhpk1bNbt9x
 HEiWeZ10+BRejpDdrlp0d8peRGa/skSujiHk36NE2LW9Kl2J1dtqDOOmseMrP5qSVYv5
 LqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776787267; x=1777392067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLFoe4oGDCwTz6b0lGYMIAWTRfszp9f/hXCp89ws9Mk=;
 b=eElpmzT4oM4MVvBCPVCyVvvDMI2/JiS/+3kz8EgI6vZfo6NiRenm36JBjoi3NYoxuF
 V8tWwA5xD4zAWs7QqDMaVZ/Qz3188SikPyhHIdRJZdI9+7n+Tbmp8Hv+AbZz5vtrZcnu
 QFkmM8dEtex5JsAZMreX/ZW6Tlbwz6KstrQ+LijNDn13vOlodNwiosrn5Cjz0D1LjoAX
 B24hS8Y8/dfya6u6n5uEnKv4G/zY+G+JYVYrqRbbzyo2WKURgLC1HlkN3OZBFN5kcatT
 4W++HZTFdQUaVrhttHRiU/1YYJgI9fJhjuOnDTq3uo+HsIXZWhUtzF9hc9rx6CGOmMKN
 EmZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LrYvg+s/bTHc+L8vPNTLNvwiLFfdr+dUx3dAbxD13qhv+QAhG6CAgnslFRh/6rMfiXSVD2RKZoBw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8Kr5VgRnS3Y4SvMXCKCus+7dDTzfUdoIQiKFqXcsq41Bm2jMv
 qCeqZERC1JQ5DvswdJzlWMrgXKo2gVgxtd6ERvgN9Ven7+IlSVx8ffe7GRBJzVoTdducRJHCkT4
 KB9pEmCwdDX4qD1HDiNO19jBbiTKmAVxdyBusH6XV7o77ZLzMOOXjSFDHfxj0yqhVRfNKG3s=
X-Gm-Gg: AeBDievVhLpZMY9ydKImsVhcOAh0jV1FuyJdfP3s3mrkgoKra+g1Ly71d4O76UCyhrB
 spp8jY60pcUwT7BHLvtFW/6BTIZ/nIFKztalVORYa32za/dj3+Ysn3lyHoa9jfxdvMhLKVZAM1j
 PA8M6eG3SWYeszxuyHHUVr53FaYMCIGbLLakaGsuJXp5xgPD+gLCmzEWA0wuT8NDd8xS6EykXDu
 y56U3I7rVjJ3xbW5JOh59/HtIIc32GpB4g1g4ejK+a7/4uqThFzAiFPWuzZdhqLiaSGXAmFXl8G
 aK6fF7a6OTqCfTRjd8gM19c6Qqt6ytq7b/PSg9l3OLblgG51HEEX7Mfm6LewRwM8KAFnZfKjjpr
 zcskkkN51/oyt5e2bOV1jtQBjQDf2Y1q3b9VpdVr9QjhvxsxdNPXCisZ8c22NHQyBLTJ8Q93cvK
 o4gMvElGnfyQq4ZW/HI9OMU+tnN9wbyT0/5W6ACiIYLL1wjA==
X-Received: by 2002:a05:6808:1394:b0:468:2a6:e32c with SMTP id
 5614622812f47-4799c914da6mr10924375b6e.10.1776787267340; 
 Tue, 21 Apr 2026 09:01:07 -0700 (PDT)
X-Received: by 2002:a05:6808:1394:b0:468:2a6:e32c with SMTP id
 5614622812f47-4799c914da6mr10924279b6e.10.1776787266651; 
 Tue, 21 Apr 2026 09:01:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad143sm3806113e87.7.2026.04.21.09.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:01:05 -0700 (PDT)
Date: Tue, 21 Apr 2026 19:01:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, Alex Hung <alex.hung@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 10/20] drm/crtc: Add new atomic_create_state callback
Message-ID: <bmw2xqyaam6rr4c25ccxonvd5nglrw4iihiy5naznozcevs67h@ub5ycjvfrxjd>
References: <20260320-drm-mode-config-init-v2-0-c63f1134e76c@kernel.org>
 <20260320-drm-mode-config-init-v2-10-c63f1134e76c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-drm-mode-config-init-v2-10-c63f1134e76c@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1OSBTYWx0ZWRfX4DN1o3eklHEq
 jo8lBcAX36ZNYZlRQm8lM6QGZk+Wn7hMZLWb65H/8SfTge2fawARIVSwpzVq9/b1CR6zL9teHph
 K1YuD9RP3Q7r5l7EY8tyMsfAU5QWkf2GKAsXzLAZqAZobM6ZkX+kpoPNfxLkpvv/hrpcFCIQXtq
 i2rokpClZgMJwc2k2MIyIKKz2ERpw74xfeiseMVoiN8PuaPUKNkZ1nP3IJ+AvkU/reucjsF+nVF
 MpjkSsG+3mrM4OWB7Q3g5lkCX8DVJnFLQqzmcM9NF2ICa2lhdsvG2Vp6BZYxFco8r2xRXHB4ylm
 7WkUIcnt2UdESyqYoAR5SGJsL1zrT49OXu/HdFVA3ajM9hlhEvtSSRiK88efta1jcn8b08ATsZL
 IEJ3E1hy0Sr2CUsIzs325mzRwYm8axy7wLCty0URT1HYOpGdsD1qIpT1JXjd2w+aoAZbc6MkReE
 LAt3y3lm1zF2+ux0wQA==
X-Proofpoint-ORIG-GUID: qNPl3vQoC7ORfBJdordG0YwATsoCeH4t
X-Authority-Analysis: v=2.4 cv=YOSvDxGx c=1 sm=1 tr=0 ts=69e79f44 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sh7rbVFwc6wKdXg0ZAwA:9 a=CjuIK1q_8ugA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: qNPl3vQoC7ORfBJdordG0YwATsoCeH4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210159
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

On Fri, Mar 20, 2026 at 05:27:17PM +0100, Maxime Ripard wrote:
> Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
> to drm_private_obj") introduced a new pattern for allocating drm object
> states.
> 
> Instead of relying on the reset() callback, it created a new
> atomic_create_state hook. This is helpful because reset is a bit
> overloaded: it's used to create the initial software tate, reset it, but
> also reset the hardware.
> 
> It can also be used either at probe time, to create the initial state
> and possibly reset the hardware to an expected default, but also during
> suspend/resume.
> 
> Both these cases come with different expectations too: during the
> initialization, we want to initialize all states, but during
> suspend/resume, drm_private_states for example are expected to be kept
> around.
> 
> And reset() isn't fallible, which makes it harder to handle
> initialization errors properly.
> 
> And this is only really relevant for some drivers, since all the helpers
> for reset only create a new state, and don't touch the hardware at all.
> 
> It was thus decided to create a new hook that would allocate and
> initialize a pristine state without any side effect:
> atomic_create_state to untangle a bit some of it, and to separate the
> initialization with the actual reset one might need during a
> suspend/resume.
> 
> Let's continue the transition to the new pattern with crtcs.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 47 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_mode_config.c         | 21 +++++++++++++-
>  include/drm/drm_atomic_state_helper.h     |  4 +++
>  include/drm/drm_crtc.h                    | 13 +++++++++
>  4 files changed, 84 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
