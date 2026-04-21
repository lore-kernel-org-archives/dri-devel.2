Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CDDF8FA98
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21B710E8DA;
	Tue, 21 Apr 2026 15:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oK9RP7f8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5l1U1xn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE2810E8C5
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:50:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L9bOdl046067
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Hto5MsLIcmZUVCfT6iG1LCNf
 XNnKxNxx4T+khh9MBY0=; b=oK9RP7f8lu1aYiEjyHk0aEqVOStaTYP8ae8V/J7A
 fzg+ethVOI9SKF2wkvXHoNExyOeQHiKBw03ubwQ0ZkxOuxchLGZaDFZD/6eke1ER
 lWh045Gz8CLO1BgAQernTvNiezf//bRho1r23hw7uvbfJWka/ZD7lTQ/l3Nk+3K5
 fsBJ9vLY6luVvAD3o3j6arPyJnsZmRPdwdM1yA4Bxa88vQleeuL8u+64rbv8TAog
 uyjMUw9MZx7XXEO7S+8paqmukDnwv6a9YWK9iQ13GwdEeWKUjB9WG2TjV/FvCe1T
 jdultxl8/v+ktl/VbRYH0wCB+VxraY7Tog1iwrufH9q4DA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1tpp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:50:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb007bc36so37150221cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776786627; x=1777391427;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hto5MsLIcmZUVCfT6iG1LCNfXNnKxNxx4T+khh9MBY0=;
 b=R5l1U1xnd6w2NlPLC5rj+1KR396hpHO8wn2fnrPLhYjX1OmnE/NC/nxdKK+8uObIwP
 4bfULGkblmtu0pJYxNlTShU0euwglYGy0oPU267unfhGeYHuZl0aS89sfgDgJBhiT0y3
 cHZErXIDCuMQUrJVC6hdFBZ/9gZfclEOipVadb1LfvT0ZmYmhsC7hZiJI2dCr8cPj4Xg
 vTAS+3m1KAieb6v/od4xim+G8eYps5juLDgndKenCnlHCKtgooFo/o2PRFlktX70+II4
 ThXEYc3BqNWSoo4rU9D+kghWx9SLbXltuDpg0sbZytfvk3Pyz6oeIYpgYkyIvyWV+tm5
 F2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776786627; x=1777391427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hto5MsLIcmZUVCfT6iG1LCNfXNnKxNxx4T+khh9MBY0=;
 b=NWnqS84sKBkrB9h7k+R3QLECM8a9eGr4Y7J+2PkcK0IwyHgoZi3degqXfo63XUnZnu
 bwyDK4BfSm3JPut3laVsisvb4es8jAERfZy4r3R0jeLl8V2AwThaqvv99J8zErj3nrw0
 B3L9ADVVNUHe49KTpcp9AzHJSnHdeXUas0ESkO4gvjJdKxOkr0yRlDl5xGQlm9ZsMmxq
 lvjPKr4SPuioatXRsgoHVnsiUis2phunnCPgC/J6T7PMbkRk+b6zaBZE3ggiyNRvl0M6
 aaT3zt9cniFDUTgr/HMuVJlZNb9dN870nnrhhFXinC3gEbOz3RgJ6t45qYxiI+JnPRmp
 /WCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SSIndryALcZ87qNJh8IHz0uK6YS3s1bXxjysFiOfy0EfIGEJxgxaTT944XLHCrHMpxta0qohJumc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzB+GAJn55wAdKsKxANkFM3T8rvMkre6mQHfQWJ4O0hphPYyNl5
 0oWUznw7MWTdrDXo8t2jBvpCQOLBFWtGvMUwpB14vA9nSL82hTNdf5FG8p8n8A1NxYgVg1TzHrs
 7DQu3AF2VjInzepdiepCuQp45tdUdzea+c2/wObU1j4zeGs95mjIKMQtX0cvR/jPMAgKmFw4=
X-Gm-Gg: AeBDievP2CVBZqWj1coWDjUogdGQTmc8W6Tun4RufUFu4N+YXAnwlFnzP2y8o2qvtz2
 cGlbV1o0Vk8nQeFDq4t/6BzTT3zvxwelBKSJb2IO4HcAh+2uR9ylwpVlSE1atB0pEoyi2dCxd4e
 JdouuVYo8SJBsoR6A3vbiJcxQqhZwAzgCR61Ks16lmSOuLlseW1cit3KsrZ5HRwn91Akd1icDeZ
 LgQAHMYG5gqzkn+At6nZMvljzZfPgvne24oLo9uMwsIvcDWQjqpQD3EFFpR+nukWNrV1wVZnhNM
 bQp8ZGb0MVnWKYn3A4/VLyjsRmuSQ+Z8bQes7n7OSHoD8dplDUn7ggPAhVCTkZGnOQqUaRJgtzl
 19d50Nv2BEIjJ6qQbFS9wkSGVxnHbZ/zLq9KGdJ8z87xghhDrHZO3ntK3JM7w5FUxF14n1ikPtS
 2jm1Rc3wx9ep6urGs9LutoxHYX48Cx76uuDUyo23L+Z08Dog==
X-Received: by 2002:a05:622a:5c1b:b0:50d:a71d:810d with SMTP id
 d75a77b69052e-50e36e9c5bdmr268930081cf.28.1776786627072; 
 Tue, 21 Apr 2026 08:50:27 -0700 (PDT)
X-Received: by 2002:a05:622a:5c1b:b0:50d:a71d:810d with SMTP id
 d75a77b69052e-50e36e9c5bdmr268929381cf.28.1776786626578; 
 Tue, 21 Apr 2026 08:50:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad11fsm3739915e87.14.2026.04.21.08.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:50:25 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:50:23 +0300
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
Subject: Re: [PATCH v2 11/20] drm/atomic-state-helper: Rename
 __drm_atomic_helper_connector_state_reset()
Message-ID: <ogjitbayzgefsouxgwhjia4vzmmpfagupddmmoxokvdscjouqo@dyaz5v7c4lyh>
References: <20260320-drm-mode-config-init-v2-0-c63f1134e76c@kernel.org>
 <20260320-drm-mode-config-init-v2-11-c63f1134e76c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-drm-mode-config-init-v2-11-c63f1134e76c@kernel.org>
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e79cc4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=P1BnusSwAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fOc9-Nj7kuNS0fQUIscA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1NyBTYWx0ZWRfX6iK6qpFVdYZL
 2g0IEqTv956liXrIYum/7ElNr7S73bD1vepnctLXVWhk6QNy/QyMbdITIJYDZnhhzTgyjzjzIhS
 4UHfTW35Wj6uzo7xuztId2i4+ppQ9AMKQPx5hn18gKfZmwXzQOExqpX16MHQF9CtVHrdE82d1tC
 CRh9x532OA5HFw9Id7h7pwspFhznuc0oi/yx1BhpDhiujopjMo/x2LF3k3hvK3sVbzS66Q6vfji
 7XKD4e5JU+DrTQZJ2B6sCoBSBtY2aBHKqbA578SESARFMsp7CkIr8mkyIBjlYcPmQPMrYS+oq23
 wh+079J+0C0DK3otbWERHl06ZeMjGlY2t+paA1iaIMAoKZB1GMb9Jno33KHOjhC0vN9G0CVI0ks
 O8nYG7kl/pKzNppPT0KirgQ/mUL0VN7bBOjZjmAk5p86a0kaN1TBmS7k3rBX39U8I696T4tMLLZ
 ppj3N1twmpAW+GFYpKA==
X-Proofpoint-ORIG-GUID: cfX_Whj_-BTzbWhMk_edsDHkQnG1wu9M
X-Proofpoint-GUID: cfX_Whj_-BTzbWhMk_edsDHkQnG1wu9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210157
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

On Fri, Mar 20, 2026 at 05:27:18PM +0100, Maxime Ripard wrote:
> __drm_atomic_helper_connector_state_reset() is used to initialize a
> newly allocated drm_connector_state, and is being typically called by
> the drm_connector_funcs.reset implementation.
> 
> Since we want to consolidate DRM objects state allocation around the
> atomic_create_state callback that will only allocate and initialize a
> new drm_connector_state instance, we will need to call
> __drm_atomic_helper_connector_state_reset() from both the reset and
> atomic_create hooks.
> 
> To avoid any confusion, we can thus rename
> __drm_atomic_helper_connector_state_reset() to
> __drm_atomic_helper_connector_state_init().
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 10 +++++-----
>  include/drm/drm_atomic_state_helper.h     |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
