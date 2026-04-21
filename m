Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACE9F8FA99
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DE010E250;
	Tue, 21 Apr 2026 15:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="blC0KCuS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GjENaVO3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08BE10E250
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:59:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LDT8YL1538490
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qTGT9dVHn9ZD4VlzKf8b4LWl
 wJ6q97WIUZp+d0WZsqE=; b=blC0KCuSqm9wlc6YuJb5fJBNdXfodybBI8mwiIpG
 cu6otodaBirp60rUNTgROxukDQUGZiL6De3HJPM03wiuePdz0xSeBsYSBoirf4PT
 qoLPdE+pPdkw5yTbWy+PGdRwzUBM1+HV++fY4+Q+ZbgP0RdOMBRXxnbSIjPoBKgc
 hF5Uyg91dwehoFyGu0H2aXCfOynF8KmbWq8KKtVGWSE5p7KJpLFXx+76GAYxak9D
 p94Xm6IMiIlV3m9FMlfL1EKhpkJ0NfmkV80pk1th44BQ7+TPFCpqlNJMiPj9eL6T
 se3Lg0BuYQoLayAbgATtnlnbdQjBs4NA+YoK2kDwBPuY7g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp4hahy1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:59:43 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-948476b92e8so1970487241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776787182; x=1777391982;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qTGT9dVHn9ZD4VlzKf8b4LWlwJ6q97WIUZp+d0WZsqE=;
 b=GjENaVO38+pTvn8abYzp0OFvnP3ViWXmCzeTiCcMFkkLtuDfumeB7a9KnyaExg1baG
 x6DIBek30rqQH/tVeuBiNpqQU+2AdBMolmLYtnH+vx6laJlOG6pN6VouoK4P+6j7KMus
 0/VKC0NmDMWvY5lQKnfzJhxtPby91c6/kQZls/5XddHtHkMLc5TrWN9iuFeRIxxvrEYk
 S80W34yEtbn5ZEaD/a+HqyumhbIRwyDgFaj8yBVraP8FG4pHjtPFTlqmZVRYMM3xm6zv
 XMQWysYX0wKVw4USCBY4CJC5NjZsTRCN+4IKlcm8XLGzfyR0ORStgASR6t/9svQEHJXF
 5yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776787182; x=1777391982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTGT9dVHn9ZD4VlzKf8b4LWlwJ6q97WIUZp+d0WZsqE=;
 b=CmdgzKp0/kdptrwpWNNYXY9KV9+VD3Xx1sWRvlgOlwFLyUiPlTX/yBafrUArJf1sgr
 kfUPkRYTb3iKryLYLAfBR6WUJ7ddgTHeQApIhA6qOReEKZrEFQUIbsbDp9JRc++7ryGE
 jxukVrZfceGpXyfn8C7yRQtOzbAPaTuWuvIs1fYap730WQAh59quJSTqiHxbpjnWb7QA
 +OHvwJUSa5od3SaOtG/ulVQ0gkhUlOic5SXHDv70PKcP/hLdDZy5rPJCJfXyBy/I3RUR
 boq9fQQFUlXs6T1QZT12NKsjEW06BTIKo/+vOwzi5z5rIL8ISH5IyR72AUAW8gFsJojm
 M0iA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ma4f0cG6zXwwyEuyJQDrIGjAoigvCgBfXiilWtG9Q6a8LJ6vGtywMhPjkoPM0TqL+ag7L9yRqu0k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVt8p/j0RKpfEKrCwNENFTCtobm9uzjBXYN4K4C6RVTCyiU08L
 7jSZ5EzIczvQVUfpvOrqofqJI2/PzFrmK6dq0tqeT0bpuakXTTs/2eMI7BxNLzp7NOW/ww6WpC+
 24ofN8X9gx1nAvVryIANOeaINc/7p3lm3lu8F1y8FQGKpLBGEhJjnuh2j/VsqpSCY2O4GURg=
X-Gm-Gg: AeBDievXtxNkImRcT4cMBDbcLlbwTGg8bn0+bWw6yRp4j8v8v7HXEJTR3N3Qzkyj711
 inHaQ4zeD9tb1c18ci03DsuNBWfz7Ucw3D1up0rWmu93i2iZ+Z5F5aeHwgn8oQz7TyD/v3nNe2q
 +QQAtHTz6urB9cGhNbdkm4d1yomc1OI8FEW20iZY1dDQAOEn1SwE+gc9tW9hxHCjeeuT9C8K2dm
 gN9sv59MfucVxdD3Z57vAsdQw4hhw4bVYIi83RP+JuE0cxRAe5jUBrr698rnqVADvo5nJTutas4
 Qxiw1QpKtu+4fl3z6CpHCF/MFjCK3l28MkqNw0kYJhL9fuMyJ2KmFTxYwqlwXVSJhIFSjHoNGP5
 oXcCW8zbClL/vOHspSzQcgRnaVM9eLRSCRXDIc0NmW+gas9ApNOYnAtLRteV9ZtAfMRrXEI25+o
 pcFygj/6HEPdmVpCqgnYEHyLwopDQCsqANyoGbWfig4qDneQ==
X-Received: by 2002:a05:6102:6052:b0:602:8c16:b24c with SMTP id
 ada2fe7eead31-616f806992emr7568532137.19.1776787182073; 
 Tue, 21 Apr 2026 08:59:42 -0700 (PDT)
X-Received: by 2002:a05:6102:6052:b0:602:8c16:b24c with SMTP id
 ada2fe7eead31-616f806992emr7568495137.19.1776787181651; 
 Tue, 21 Apr 2026 08:59:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0bfdsm31472081fa.26.2026.04.21.08.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:59:40 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:59:38 +0300
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
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 16/20] drm/atomic: Drop private obj state allocation
Message-ID: <6fp5keyrgfic7x6rsopxpqdqfrbotkofv3vzni4bstphxwbc4l@5nlu63kpuwas>
References: <20260320-drm-mode-config-init-v2-0-c63f1134e76c@kernel.org>
 <20260320-drm-mode-config-init-v2-16-c63f1134e76c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-drm-mode-config-init-v2-16-c63f1134e76c@kernel.org>
X-Authority-Analysis: v=2.4 cv=bOQm5v+Z c=1 sm=1 tr=0 ts=69e79eef cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=P1BnusSwAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CGuZyk7pIeUWItkfYpsA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: cuDwRqh8qvz2zD0OPGkIvl3u0MIPndMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1NyBTYWx0ZWRfX62F/Yj7rP3OP
 /YnMGsDmSpAgjydugjJcZ30ZckjGjwybV7GRvTMviR6fSL3faDqkQdsY//47ChBwJZjVXKDTozN
 5ITQ/OOYyxuUzloRDyRzJtfkOWgcBPxY0oPamEkj9q0WnMiL0U7jI5RsPX2nDMfB1/ptnROdBbl
 pPklDFlfsP5gDv2+mJVF5zbTv55qXwNx8vi7O6856CzPKRFVl3As0oCSb1TatWjj7SB4LnCi/+y
 pUL8a7cWNyDoty/FC/GDXmocxcxFiTBi2Yf9dQqvuQizozJUQiiuyqODmI6M8z+uXUYS5aw3UNY
 CYv0C9FVX5VWG/E1f9ge6cvazdg60ttTDPMERHf29EWzb7aVTsqAf2S4D53QJt2xjtk1u5s92aJ
 W5dgQBELpsV3t17I8BAhMc9pLDCBv/kWxMbVGQVVLxxbSSp5oTMWUkpfkbjRZnBBIBm+MobmGGQ
 oZSyFrvgY61jF3UPEiA==
X-Proofpoint-ORIG-GUID: cuDwRqh8qvz2zD0OPGkIvl3u0MIPndMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210157
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

On Fri, Mar 20, 2026 at 05:27:23PM +0100, Maxime Ripard wrote:
> Now that drm_dev_register() calls drm_mode_config_create_state() for
> every modeset driver, the private obj states will be initialized at
> driver registration automatically if they haven't already.
> 
> Thus, the explicit initial allocation we have in
> drm_atomic_private_obj_init() is now redundant, and we can remove it.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic.c | 7 -------
>  1 file changed, 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
