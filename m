Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3002AF8FA94
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D1710ED2A;
	Tue, 21 Apr 2026 16:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DoC4TJD1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JaJTznkz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10B310ED16
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:02:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LFbB923336977
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=laMpQ/PEThA++8VKoCP5uoEG
 KvqMhipe1NJOiXj6OFA=; b=DoC4TJD1tox6cQCMrbUYn1E6UWT7nQKw64cl8O7+
 NPINHQmS86XXE01DFnSK+4Iq8z/cJ9md0LTLnXSvwDY99fNJEnGBBEtU2hXt8Tns
 X/oZu1q8unPKTYt/aULiBdGGz4oxZot83flyQIozJYQI7cHemjuH9wj7Nid6f/Ul
 8YZSwK+xIBYxPGW368kAHIHy3ICmMhIMt4BK9nnyTlys1W/VZdyVlJkg4HrkGdVW
 z/CGvbjYIFmHKcpRDrDGBTGKC+OKGu+5hx+6iAc8n9bZY8VbLIYiyeQRd+HhqlTi
 y+Afw1j0QBfYxjVU8jsbrX3BtzHQ4NhIhObbJwTXckxD3w==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpc1jg35r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:02:09 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-47545742e67so5892249b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776787329; x=1777392129;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=laMpQ/PEThA++8VKoCP5uoEGKvqMhipe1NJOiXj6OFA=;
 b=JaJTznkzrHcRh8e/Lx/FCNww4E8vXlI+VQXQ/dPAjZSQWzyKuMUMA/ypqKhuOhRsth
 nKucao8rZ1OzeSarNElsSs1L+/s/X9Hb4DDnCMvJVS4qPY4P5ju++BsmYWUI0k6OnMVl
 YvmVYXP5dv10OPZwwvVMMZ+tEH3W+LAXdeSNPf/SFB3kmwlHSqwCjpHw0f+hcvLAbAcB
 RJvo/Rj1QVF6fyrBpr7i+57guopVj109HfiVGbfXkGWcH4+05+F4fvon3uTvOeM4uzN9
 ukbW1eBpr1o3ELooiyaP8COufJJyvvznN9BcBbFmwqEN6MxnPg04doYopS8wFZYt0qQc
 DApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776787329; x=1777392129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=laMpQ/PEThA++8VKoCP5uoEGKvqMhipe1NJOiXj6OFA=;
 b=gfWPnShyILWl6yvKMdB7UhmymRmnLkkLPIwFALnqWqI8XvvlKVKfkwMHdgXkykzrkY
 lv1h/2xmuG1Fc6LHLQnq+SpxK9Uc4geElNXDG4+BQRJaEoDu4g1jX/LH1K2FauMgLCFB
 SK/9secCdDyXJazdV9MsvC3I9x91jrQd8K3Jj6WQ57MIUWfiy28XLhLEJAoRUwfmn7LX
 rVSvjKrADe5UjMMjG4wIfoGKS0y57hiSWN+D4YgJ8fDbYf9JXtZ1mqgWwYtETiUG0qNj
 0TQsAKIzDVPn/kme31//GTnknKDOkdta4M7/GNUyRgvQHSZLZTRTGn283/vPUPQjP7HH
 HgLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7iCLWE0lpCfiY763m7YjdD/6cJO2VS6gLLx1+PI65IOJQlS1x5jsiK+UBCb06BEnL4pgXWNji9bQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAMvHJG8LnJNZtCqiJXLPTIwJ5s2k1+zshHMaJoEi5M5aeAIBD
 awLFrIIoRJ01JhQrjtBqWRantW6BGh0kbXFeEr47rsIEnkiiD8/b7c/PNL72cdAmJZZEWVfcY0n
 wZcqI40vwx/351Cb3w2v7v2mrB2ScgHC4wdaE1wLzSqhzwfBfVjwVUONSfkrTf1WsbFTUHpY=
X-Gm-Gg: AeBDiesa7m192/HV2hOQJU+JkoBwMuiCGn5sDEBf3pDOMW/w00KPWPtbsDFHl3mjdEK
 Fl1gJH6JS8C0fmb//p0XDyVqd/zxVYhfA1eqkFSmmmsUCLgWkUkAoUnB3WW5Nc5ZT17XA6IDqPH
 oQA2waub3yGksY+EKGDwsuFnmRNl4ks9Q7U0k7GmlFvqVIGCLGj/16xIFADw6/iyCwrIeuL+sCB
 Y/63QTLYZGDBYrt3JWh0RirG41eL2QGOhNa/QhfftARAWbz9K82rwCL+aJXWFWh44Q9BzmOldk3
 e9SpH7QYigSaTJEw0c/SGiQcfX5Z7a1JpAgyi9yL9AvrsAMitiEMlKhIHkkhAZQzVlRFQzmDCNb
 /GHPIut5rlWCZciNNqVETCIsqz38qumKBj2g1yfWxt86Z3m3tNnJObvAqeBekrAx39HkDPwuH7c
 sPV/maJ2YowsuMtf37p40tA6P57UMUW/uYQxIdbSxSppQ8qQ==
X-Received: by 2002:a05:6808:4f1e:b0:467:1941:1f18 with SMTP id
 5614622812f47-4799c951609mr10816724b6e.14.1776787329109; 
 Tue, 21 Apr 2026 09:02:09 -0700 (PDT)
X-Received: by 2002:a05:6808:4f1e:b0:467:1941:1f18 with SMTP id
 5614622812f47-4799c951609mr10816664b6e.14.1776787328396; 
 Tue, 21 Apr 2026 09:02:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb7613a9sm31882641fa.41.2026.04.21.09.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:02:07 -0700 (PDT)
Date: Tue, 21 Apr 2026 19:02:05 +0300
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
Subject: Re: [PATCH v2 14/20] drm/mode-config: Create
 drm_mode_config_create_state()
Message-ID: <uzfggjuv3yfegfnzjd4jm5losp6zxtxzrhtbncappzekyrcdzs@7awi7qw4kchv>
References: <20260320-drm-mode-config-init-v2-0-c63f1134e76c@kernel.org>
 <20260320-drm-mode-config-init-v2-14-c63f1134e76c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-drm-mode-config-init-v2-14-c63f1134e76c@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1OSBTYWx0ZWRfX3SSfqwepaFBE
 z9z0bD2a/lT4zHZOOqk38NLOXLDXqk55UaiTnTV4Wet87LDkLhV46TuZ6vTCSfDUQfPH/nFiU+b
 4vpsl/9y+vwg33UZRbWSdcNJt3azi3Yqa8eNlGNdjDxYSNTHcZrhxu84JjvCLNFASNhX0NUpy1Z
 ELTPyQ6OaEpwPv6MLF/rliYsuUrH0+78+P4afZx3ojj02nYvUwHFxpU1xnbCDy7I7rdJ3gq2+ub
 pZadmGgQiDfTODi95reLUYjBvK8w2uUN0JBXSSumVL9enFsXTI8oSJdYuaIL9IXseNdMWLsIfPF
 MjbuuhyMYtmMN7Y2WRW9+gBrfcLcLwKGKJ5pqOqvnkem1M35poFolnO1SUCbH2g6ETItkTKCFkO
 hF6drcF7vJcUoBaWw9zg2lXUGnYzV1Aamrmi54xYqcIyZ1u9MctTQ0J67iyRjgAuUUwMf8iopug
 Qo1xwiENOUcWs3T4miA==
X-Proofpoint-GUID: Ofh4JEF5JuXYd5WA6miFFP4pL77mFFAc
X-Authority-Analysis: v=2.4 cv=IcG3n2qa c=1 sm=1 tr=0 ts=69e79f81 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-GMv20tOWX2ILgXXLssA:9 a=CjuIK1q_8ugA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: Ofh4JEF5JuXYd5WA6miFFP4pL77mFFAc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0 priorityscore=1501
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

On Fri, Mar 20, 2026 at 05:27:21PM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() can be used to create the initial state, but
> also to return to the initial state, when doing a suspend/resume cycle
> for example.
> 
> It also affects both the software and the hardware, and drivers can
> choose to reset the hardware as well. Most will just create an empty
> state and the synchronisation between hardware and software states will
> effectively be done when the first commit is done.
> 
> That dual role can be harmful, since some objects do need to be
> initialized but also need to be preserved across a suspend/resume cycle.
> drm_private_obj are such objects for example.
> 
> Thus, let's create another helper for drivers to call to initialize
> their state when the driver is loaded, so we can make
> drm_mode_config_reset() only about handling suspend/resume and similar.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic.c      | 12 +++++-
>  drivers/gpu/drm/drm_mode_config.c | 87 +++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_mode_config.h     |  1 +
>  3 files changed, 98 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
