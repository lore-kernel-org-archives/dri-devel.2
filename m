Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F54C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDEF10EF3B;
	Thu, 30 Jul 2026 14:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DyhAbkPL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PX9di38p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 061A110EF3B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:19:37 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UEHXYd570700
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=t+oYZclcsoyBpPMuFhCDB16e
 voi/Be0njDL+8RrwXAE=; b=DyhAbkPLmpDz8Fk6GCx2bPi/DWaEufFRre0P0qxE
 oSMzgKiDTv/oYWO0lZELMQXXGz0x01CutRG/PMREYYomKABL0d7coL7K0wfCO5VN
 zQlRAt63jNpzcvqNuWZWpmMD86Xat2tca6OQwkgRzYoq/wEHhJIjqtMsnpKHi52y
 z/eg6y4fNBGzhy1lr1owiqHBj0y3RCd5PlrHDRMGtyY8pzj/KWtxnw3ZdF1mH0dk
 r2/SaHT4TsR7yHCAqSnDY1lv/GhSEGEhoSw8q1zlhdsrHbfgVvgBgHmh4b30ms5m
 VY2Ag9fqxyMcSa42xaLufu4eNOrAGNzTvB03nuc522NcBQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr889r0ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:19:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso24117471cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785421175; x=1786025975;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t+oYZclcsoyBpPMuFhCDB16evoi/Be0njDL+8RrwXAE=;
 b=PX9di38p5nCJLjRQw5ZaUWnIt9dAuCEjXuzxb+25y7+2hEzidzpdlVmP2K3wZPkpWw
 rqvKDKWo1dsiCojPHiIqqJsd7DrLWjZMs6pCqvSR2YLF77lfC5zK8xFDzyW/TR6WZ6/+
 AfzlojXTEcAmTIBspeNPD7GIcDc2eGexL/7kZgZt8o9XEKB4I9YjnLqXX53IbPlN7xX4
 Ly/jihoHOZ7m9EILgT0iYnIYXYwFdZmEe+0KZb6j39Dsj6jwph4eWii2AyDBQ/NDbiHb
 eJh7eFJ9UFVGGTgs4bse1GlAkGSo2rpXcONr6TbJ+sPnutTMU8MpWCchIMOuLXyyw+OC
 0tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421175; x=1786025975;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t+oYZclcsoyBpPMuFhCDB16evoi/Be0njDL+8RrwXAE=;
 b=r5sBb7ptMbHYtA7awD35Ls2Bq/ft63ePSxFSvFElT/tAQjBPTV5pmPjkhWnYwJII4a
 /OjBV++KZYlF6T3xwnILoIMugtX5P9yb779qITww9u/SNPXSJfE9qetI4KeQBq+3+GhR
 IL2ezX0VArwZGS81sq/g70CNAJuU0MQkDDKF5WG//g65Me2kSy8R4wEyq3B7AIsc2de+
 GiJfApqUTDE0I+1daXh0sWJQQ8WM6fnKVyyU0rSBXtCmhPfyvkSQ9N7hxheSPH/6fIyh
 jAH7cKt6PeOGRRUwOdcSZSjwyzYROKR7/9bx+lefDsv8kdcC8XtwpI0HXz7T/S1Fl173
 ntOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB7x01xq9+1EBEarOyVyQXhaeIdQMhNO3NTr9WV+lO6HoSlcTGUEO75ov3nU79ouK1IbOD4kLSjjo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZIyHwRW3t+GfXC+sNcNqG0n8sMrfk30D7aomPgT0lFHdCuvHZ
 S4hvgU3yR+jZJbj+djJQhkC9TPqYp5n9CNbisg5sDuPSnk5zf69Tp/JQWbWS7Q0dphUlgZFDoel
 aFnrnhUFsnSys8F6YQdGfW4CGVgePD3zB6lJKQQenFUY0z0LFy8rxXFKohx86VpARB94E7x0=
X-Gm-Gg: AR+sD12BZxlLPxasTvc4rgVbSJylPJ1ekGbz8xwAsWLsjwCA9N8bplZqHDTJdG0oCDr
 V51hwZskiIe2I4wYZ/GyXEnxREadmSQVMq/5OjXuXqUZ1vnwaTv0WABQgVyDvdHThf4SYVRhzr9
 mPloXTifweWmSKam54+2qr3pqAZvsSk6LgLpg/z3MHVfRbsnQTVS+K+MtX68T44r88V1pgha1V2
 QiVYV2lOb0MGbnRupQSTNlxvh/1BULzpYkk8gp7rIyuh5FbnjG6Vr8JxpjvdYWlVDUZkl8WiMsz
 vKnjPPUxM+dodiU1LHkTx3Ma+9mS9zL6Ngm0ePE4KsFctVYcAkYiN0mHupNRkqxGHqPGHpsUB6M
 Yzx06z8hsKXcU/Hn/OylcR/Uc5jueZySkLIuiYJDB205xQS4MAFK4Kwp1Ms7buwz8f+MlCG+u0c
 HqD8c7fHpz/4iPfA==
X-Received: by 2002:ac8:5955:0:b0:529:bf39:f1a with SMTP id
 d75a77b69052e-52b386be80dmr27853581cf.71.1785421174826; 
 Thu, 30 Jul 2026 07:19:34 -0700 (PDT)
X-Received: by 2002:ac8:5955:0:b0:529:bf39:f1a with SMTP id
 d75a77b69052e-52b386be80dmr27852851cf.71.1785421174000; 
 Thu, 30 Jul 2026 07:19:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db9ba882sm368911e87.43.2026.07.30.07.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:19:32 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:19:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>,
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>,
 Phong LE <ple@baylibre.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v9 03/61] drm/connector: Add drmm_connector_hdmi_init()
 with new signature
Message-ID: <exkyukl6jnkwwoap62v4n5j4obyhoks5ysbo7iqjdhzhb2ltsu@nyp7csbmzott>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-3-4fb12ea22ac9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-3-4fb12ea22ac9@collabora.com>
X-Proofpoint-ORIG-GUID: Pt_VJ2eKD3C4p2-QtDdSSUSI_CXClFsf
X-Proofpoint-GUID: Pt_VJ2eKD3C4p2-QtDdSSUSI_CXClFsf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfX8FfjcOOtyldi
 mqy4qNzmpmxyEgrR9DyTZnhKPCmsU4JIq3iLzUmhyXhoKZcscIWgAGoNCwdGPWBBTzYcUpYBH4m
 etpjqkC7T4H5/qvD0kBVuubqsnrX2To=
X-Authority-Analysis: v=2.4 cv=JpLBas4C c=1 sm=1 tr=0 ts=6a6b5d78 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QX4gbG5DAAAA:8
 a=L-MVhf8o2HZ0jOEqR2wA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfXyTpSJQ35TCeX
 /NSlkXowsLMpsuk03ecJRxI5Hc+tXgx35WTKMLmyPOKAwlcpUmWA2Vjaw9MEvHgI3OraAMI5C3V
 4U7LBVemINUfaE4ThltGfXsYo9e/2PUjsYWrYfi5QgULoyjqXm9GBtvyc9zJHVzSzoWmDdO6eEF
 cbeJJqjs0g6qt3OPYN6b/RAIJfwSbrcbbHXoihJrlkUVbaccvy/m1b9Q53qbp9tJ7ztKicsu7kO
 AQl3iuj7lLWpplGQ8mAIHtBJRBLvhYh89BIV1Dqo6DYYLSmfr3pIHb00Jf0TMV5EjkTadNB/Gbc
 GkzkMlEgKXNe1waVNpCrL3joGFiqSg85/GUPXzdIZE5KYB8pFZA1a+hN4Zwh6kGg19R3p1Xvehd
 qeS3ADD+F99In7E3N7APgNgklmGTN1TPXUSwDzYRpTYD09C7MrMpZcLA0spF/X2Elc9a3czOUvN
 Q2LFeuPID/nRYrJwa7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300109
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

On Thu, Jul 23, 2026 at 04:34:52AM +0300, Cristian Ciocaltea wrote:
> In preparation for providing HDMI 2.x source capabilities, move the
> vendor, product, supported_formats and max_bpc parameters out of the
> init function into struct drm_connector_hdmi_funcs, and add new
> supported_hdmi_ver and supported_tmds_char_rate fields there as well.

I really don't like the idea of putting data into the functions. The
data might be mutable, it might depend on the particular platform, etc.
while funcs are typically static. Even for the drm_bridge case we have
two separate structures: static funcs and changeable drm_bridge
instance.

I'd suggest populating that data in the drm_connector before calling
drmm_connector_hdmi_init(). The only exception would be vendor / product
since they use strtomem_pad() to ensure them being properly initialized.
I'd suggest leaving those two as is.

> Appending more HDMI-specific arguments to that function would not scale
> well, hence introduce drmm_connector_hdmi_init() with the reduced
> signature.
> 
> Additionally, add the max_tmds_char_rate field to struct
> drm_connector_hdmi and use the supported HDMI version to determinate the
> maximum TMDS character rate allowed by the specification.  Some
> controllers, however, may support a lower rate than that version would
> imply.  A non-zero supported_tmds_char_rate lets drivers override this
> default with the actual controller capability.  A value of zero keeps
> the limit inferred from supported_hdmi_ver.
> 
> Callers are converted in the following patches, while the old and now
> renamed *_ini2() helper is removed at the end of the series.
> 
> No functional changes expected for existing callers.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 134 ++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h     |  62 ++++++++++++++++++-
>  2 files changed, 195 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
