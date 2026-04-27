Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C12FF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DC310E95B;
	Mon, 27 Apr 2026 21:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XuSY9Nfd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I2HrjsQ7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A3E10E95B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:46:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RK0mf82383087
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Qy9dkggDlG/oyWyAEZqLIpFq
 SrbxrGP9rj3trvdXwlE=; b=XuSY9Nfdj0TTkjZbxEx8vqiWo5cvm6+o9hv/2tXa
 tyBuHcn/g3m3I96iuXILrhhTHT0I+DHin6OIlEt2l1SU8Bk1WDWclSqLFrwimA3Q
 GBEYbGWrJ+xCGZ/p5lXAAQcCloVpbDay13+HIHV4tgk/qj2QiwGcyeCwOu1AOnYe
 TI9ol1ETGWYB8gotbUoCGrhpFx8EWunoUkOlUvgyAOigocMYrXp8rqDfbd+kdLh0
 CUwr+3eVXqieZIH7Unworskb4qnaEjcuCy5p9OWG8jIv9fzKabzDgipDeFzdtEkG
 lwCNyHSDwiMZtpYpJOaqeWj3PPt+s1Zrl8qRhIcnPq8KmQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt85xsy0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:46:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a275472d89so166343486d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777326394; x=1777931194;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qy9dkggDlG/oyWyAEZqLIpFqSrbxrGP9rj3trvdXwlE=;
 b=I2HrjsQ7gRxyF7QZmtCxUW9n+MCkZkrFFhJ+ukqwYyGy3qHsxpozpuiBqnlaP0w7NX
 2TGzJdeuTMPGVBoDEtUp4vWTOIbwXoGXq0BxjZJrl3g1G45AadU2AmRrqhH2AF0exzCN
 xwvMhwIUsrYe3IEtuV8X3jWh47LHc+Hp+ZiLZFoXHf7KrAgQu75v+LCvBqK7wnPEAy7s
 hWxBijrxwwkkMYZ7OJh0K1cgIKvjLvIhG3tsbMqbGNxqCYWy3Ad8hBddAUyMmx3xUoiS
 /JABI1FdbjIjtkc5A2n5ur/vPWNTRy8OS3SqMkep5BSlhasmlkt8CIeyJtWUiKyphl3s
 3ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777326394; x=1777931194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qy9dkggDlG/oyWyAEZqLIpFqSrbxrGP9rj3trvdXwlE=;
 b=Vn1tIq6MmEqW7FkDmKcnQ+PR69hEyGfaj9GH8QFl2phF9SaUzHcRj0aYMM4hi4C3sH
 MGil/YwCWahHTe95j5j9VbucHw04+wo1OMZD/FMkUx/RnaqyWMDSB0RHky6Lb/XUwEbY
 iZkZIltqrHkWdLiuJbZ/kxrC1x3jFDZzNXj31QvAd5mKeZkqD4mvCbowhdRaM2Rrrx+7
 8fXrRQ2NSMfYE3sf4TeSTYllkpvePwdd0hNcoLjNaGoiGpowx7C56cGz6iTeNStcvmKL
 3AWPwfbmcNnSkwouHes+0oswJBG9UwgqWooG3CiL6hDoT7iAQpG7sNmlV5L2U0ZNkrif
 bbvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MpJ34O77Goaf7GqtG3QWHmQUXZE18HszL9JngDTbXqnk8Vns7mwEjT4FB685s5mLP+RFHOiACCAg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoA4+NO35PDhnKvGk8woTRqi+YIbbjwWRipGm/TXmCwJPeJpP3
 2EBSqTAjXNEaK4RWxEPpf7xInum2+Hpdb8f1aBG+WD1Rl+MDrXpXM2yxXTCFqxQmgZ3UCJatghq
 nNz3BScIlMxCQe/mRzfg1jl1T+PqAA7+p/VpfFamhmXQBsYCx909PQZzM2sN2W6eyhUHIZW0=
X-Gm-Gg: AeBDieuW1pT6vREoFpqQ1Tl4BWq6+voaBK+qHYEAkXkGS4+UeNxzQYX75UjdNII/17A
 aKYgtYdNeMxmVvX+9zVCANXpjF6nyKemhgNCrDXqFKPisQmeMhvrKCa9daame7jRzjpb23SYWF5
 KyhSuooZGr82js7CmeFpEKuxLOL31+bA+urb51/UEfpAkBngeJ62rH+RCfqYPFFY7O8ZaYKClry
 PCDcEiCWOXK6q7FPqldTsC4b/oxkdehPi9Ynee9u8EXT3ZjbedCbIXkUdH+X7MNSlHTdv1ByAp3
 TlKaAyN7ZIjn0yaaSlTBgwa+DQ9ipMga0zOoRULts+LSTtSQjBMvy5/BnMa9NHVCpZY7/YTPfRY
 ZbIYoY2eMHUAwG10qsMZqKfD5dzAa8BKQ2YwlNLcjou/3vLw6pZAzuR8yu4hT6S5z+GbZpc2w5K
 mc6xZV3PHwQwYSzChU8FRfCvwCdhlgFTGAvIWmUGXOA2VP4g==
X-Received: by 2002:a05:622a:1c0a:b0:50d:9931:7054 with SMTP id
 d75a77b69052e-5100e121b23mr4483281cf.15.1777326393763; 
 Mon, 27 Apr 2026 14:46:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0a:b0:50d:9931:7054 with SMTP id
 d75a77b69052e-5100e121b23mr4482921cf.15.1777326393213; 
 Mon, 27 Apr 2026 14:46:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7463fcf6asm96326e87.61.2026.04.27.14.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 14:46:32 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:46:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 01/10] drm/bridge: Remove redundant error check in
 drm_bridge_helper_reset_crtc()
Message-ID: <bovprpd2qb65rggguc3etwxbhzfve2krvmrg2gkfmt7rohvk4t@a2olw6ph4bzs>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-1-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-1-d778e70c317b@collabora.com>
X-Authority-Analysis: v=2.4 cv=Zs3d7d7G c=1 sm=1 tr=0 ts=69efd93a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=-_LoNN0qLOdyQgNrNWwA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: POL0Sth0hRB21jU-bWBsnQviHQC5tWoT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIzMSBTYWx0ZWRfX7ozz51/Znf2O
 FIimhYH3oj8h/iRe9YYxOqFVgpgvx5546NSyBr3ja1g+wpUbxpE2HllEExUx81JXRyBoupk+Wwd
 /kERuR6mivgFnsIzNwDMNmmlbcCyxGNVIocUZvHK2Ls9R1TLqKTpmSrjH+HoD9hB4I0/YL8oKGk
 sEfZIrkB9XcGqCr11pv2XWhLol/DBMrYb4a8pKlkUTLWTrhL9ir6VS9k/r/vh6IjZqYQ+YjgboE
 ok/Ob+EomCc+TXUnpIWvsp0fTFIFU7kqScwcptdWZ45rzJG9aOL0kVZGdqafm/MamMggSaE0uM9
 M3PpJ+galYKLe6AEW8xJXA8u8nfEl4sHvLbhCh9Xl29tsTgpv6Jvb+EQuuhHglKxIOPlXVYLvw6
 ws8ORkEqMPxCUeM1hAa8Nd/OgGfxMpdMMtWtr4sbi2KOmtfAzOraR9Fe0GsVQKm0RATOe+7VLNA
 ACybGe4PjhYSDoDqLjg==
X-Proofpoint-GUID: POL0Sth0hRB21jU-bWBsnQviHQC5tWoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270231
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

On Sun, Apr 26, 2026 at 03:20:13AM +0300, Cristian Ciocaltea wrote:
> Remove the no-op error check after drm_atomic_helper_reset_crtc() since
> the goto target is the immediately following label and the return value
> is already propagated correctly without it.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_bridge_helper.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
