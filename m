Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BDECD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E88FD10E76D;
	Mon,  1 Jun 2026 11:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Boo0sc1U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LAIfDLNd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF6910E76D
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:21:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6518fTK0145352
 for <dri-devel@lists.freedesktop.org>; Mon, 1 Jun 2026 11:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nAio+lLQC+YDqx1dS8BKrM60
 KnX/EDWZH36PWtgdsxw=; b=Boo0sc1ULHvTyQgzVDQFRX5hHFtntVVWTcb/gIbC
 i5V+YQ8R57+6xG6OcK0mexqWZccs5DTzoofaURCpRjp0sKFrjWywz+Cu4fxe2E2j
 Npf+zGDC+3i1qVVnlpQgwKnpAHFsIrbLl8v+nDR92gDYb1TNiigGT8N0MOifqVZh
 uRNP/WlkDLY0KC+4zpV3mXNb6zR7tpq/S7WxjRVfNHbBC9Wfg8pnVyYYHd/ednDa
 xNsCv/lh21qMITtktTA93ABNSuuqeO+NQg5Wq/C5NOEaCsyrkwoUZhWYWLAyTrqL
 VZ0mlPq/yBLPST242ONnpeB4BL1kO+xS4OVLsOcdf7X3jw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6strkm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 11:21:03 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963907b1ddeso3388744241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780312862; x=1780917662;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nAio+lLQC+YDqx1dS8BKrM60KnX/EDWZH36PWtgdsxw=;
 b=LAIfDLNdBjg5GXG/z+1vYNFUcWY1AwveUmeYd3s3b1wG9woH2tsyrsogtyv/kmDsJt
 s/hIbl6TXM98rTGVSCFnW99WI/6ZmogW7OSo46cnAk4LWXw6+0QvvtnoDY5DTg8LqaWb
 dRlXe1dTCVsU0RtwJWsKUL5fomeHskdS4zEKr4P94agC0GfIN974rVrDdKS+N7+exs5T
 7WPeq2dzNV3xCYCxQVyOgg3XSLuwCzXsFj+cyoJyJ7ZcSfxhyCteeEH5v1PQwRfVnNh6
 cQyjVsc2zLDZQvGvZ540A+mw1pgHVsfGQuD53a5zqYThLRewmf9ak+/SqOHN0fBZ99e6
 kcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780312862; x=1780917662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAio+lLQC+YDqx1dS8BKrM60KnX/EDWZH36PWtgdsxw=;
 b=bcf8xD8keRWwqgjSey2Fyy9mds9EbbAi1Ty/BU07JtjflZsLd8b1sdtMkxhRarllk8
 Pyd2fdm9ABXURriTDl6hXOgplNwuulkkBp7yxuByTFnI/R/1Cj9rCAxMXJlOZkayvCY1
 +IixJimPZCWINFtS20OkJiBIv5a1YUsu9C78Kg/t5GMY3/CVCoC9Itw+rWT+vcb1jB0i
 URgERyJNdMyL2YsXDqOAMXbuPna7QJIzK9uLyd3LTzAfL24VRmYrw+SnG6su3Xrlosj5
 V00FQuv9V/GRzkcxwhlQUqZZxc4N9/JX/i8Dty/6ghJM3FbA/0WD3wUpdPOU+bJPx1RR
 SYqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EfySqHOfP4E4cxX13tYe6768x9SHoY+eTDJstrD3t/WYg4Vy8XG2C2z8YSdhRKNIM6ljNTM8YJiE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLeGuFC9S5ocoqKebh377tsby0jWn0FESyUC9t5H5nvjvuDtws
 XFQe5HFJRGkCJre36ywDTpy9TW0ZscYMiOViTJ1HpLN556gnSzCOMvYgfFmzxZUCgne2UzuqI3A
 KhGpF5NAgI1ommJrQtduqQq01G4uAFCDMP+jRfF//jXgfXdX118mS/j4TkTEWgTRT2maQpvs=
X-Gm-Gg: Acq92OG3zNH/bs2gxOEZsJYusmU6IqCPyKPceuIXAxJwhghdyYObgrIoyOfNaCz6jdJ
 ThbyfPHeiXa8FWVOwLt8J5F5saiZFFSW4fOQzVgibzbAnPceASn4B+XSWpG+K29EEhYuQLX+vZU
 QDhSLGvk7DrTsH/WvU+JSNIrE1L0njnN0H4x1bXrNZNjHwlf/OiLW0n8wNMFxrZJWp6mYvO0z2B
 aChIqtS+UhCjiqPLkUU7/xZ7Tg9B3Uj9G3ibH/jbgPcnSQaMgGi2AqQG4yEVu9b4tdgFdUfx1hZ
 p1xseho5H8qtQvjpYiyJwUBB0vhzRy4eXFWlFPfnujX7/PUzlZpoxAHzFaUUoBjcK2jSOGKvG6n
 1Xg7a+Kjld9QSVT9Ky0CG7wYjImE6b0TuJD98kFqgDhiuwUscI2YaMDN0XT4lf4Bz1GkEbHErFf
 YpIw78frUlbw4A4MuhK0WwzmThI6p0jUGZp+x36dAWCS3lkg==
X-Received: by 2002:a05:6102:fa0:b0:631:ec2d:12bd with SMTP id
 ada2fe7eead31-6c68236ff4dmr4630748137.5.1780312862070; 
 Mon, 01 Jun 2026 04:21:02 -0700 (PDT)
X-Received: by 2002:a05:6102:fa0:b0:631:ec2d:12bd with SMTP id
 ada2fe7eead31-6c68236ff4dmr4630742137.5.1780312861692; 
 Mon, 01 Jun 2026 04:21:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b07c70fsm1967798e87.35.2026.06.01.04.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 04:21:00 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:20:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: add EDID re-read retry in
 msm_dp_panel_get_modes()
Message-ID: <6r7evbpymph4grxu2qdazdjeuwaioyjf73st3vjnlw7zwkeyrp@m45kn6wzegky>
References: <20260531-drm_plug_flaky_edid-v1-1-2708c16dce97@oldschoolsolutions.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-drm_plug_flaky_edid-v1-1-2708c16dce97@oldschoolsolutions.biz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExMyBTYWx0ZWRfX/WGxutksDbRS
 e+8PVpxIHWsQckD24DN47V6NDnFJOCpq8h+9qsSr97WwB7kfJw2agh3Ya81YPv2Aie8kyLNYlss
 rJ0iyEm+RcOsCB7QbPuzpF/DUmOsHE5Uz9td+5fbaL1jwmctPHRsnu6BnKxq/T91Rf1JSmfsTvQ
 pX+egg7lPTjt0P30twde9vVlQ6jZz6Kryizuz0i8Q93sI0DYdoP2fBPHZB6ibL8AF12pAMf76fO
 bV9J4Z9SLwklYPbzDkxGsZXhPQ5ewbAF1ciGL4l9u5KFWUTDp47wtD2m7bZMOO97IaTIxGHAbEt
 96gp4wAQTwq4vm+UK5jJTYkCTFoxzURXh62qou34nB/Kp/ixvagryRzZW3NRPJ4kB37RwBI70xb
 nl+gRJDNL29Y0HdOMmxQaT/lC5poXdz67RzxzBNo/CBUnmBzkK1W53GgjzQruuNsc3TcLatB6Ys
 vK/cMJ5mjPl9KlwTp5A==
X-Proofpoint-ORIG-GUID: y_1HHa6tC2OirsS6QZcyZnIFfcC4reCT
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1d6b1f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gxl3bz0cAAAA:8
 a=ZCn7-noLd4lGRSYnUTgA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-GUID: y_1HHa6tC2OirsS6QZcyZnIFfcC4reCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010113
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

On Sun, May 31, 2026 at 11:16:51PM +0200, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> drm_edid_read_ddc() can return a structurally valid EDID from which

When?

> drm_edid_connector_add_modes() still returns zero modes. This triggers
> the error:

Please at least add EDID contents.

> 
>   [drm:msm_dp_bridge_get_modes [msm]] *ERROR* failed to get DP sink
>    modes, rc=0
> 
> even though the link is ready. Since the EDID is only read once, this
> error persists and the display comes up with 640x480 resolution.

Please check with the current next tree, we have reworked HPD handling a
bit. Also, it might be the case that the dongle sends a placeholder
first and then sends a HPD or IRQ_HPD event. Please check if that's the
case.

> 
> Add a retry of drm_edid_read_ddc() inside get_modes() when the initial
> read produces no usable modes. The bad EDID is freed before retrying
> and container_of ensures access to the DDC channel. This directly
> addresses the observed "valid but empty/garbage" EDID case on
> flaky DP plugs and adapters.
> 
> I tested this on a few of my "flaky" type-c to HDMI adapters and hubs,
> getting no "retry failed" messages and the desired resolution. Without
> the patch most plugs would result in 640x480 external display.
> 
> Fixes: [5bea90ad9743d2] "drm/msm/dp: switch to struct drm_edid"

Hard to believe.

> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

-- 
With best wishes
Dmitry
