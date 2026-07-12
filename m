Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE096C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 10:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E00D610E0A5;
	Sun, 12 Jul 2026 10:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X58z8cRp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SDO3nXmE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D5A10E0A5
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:21:58 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66C7S78N1999350
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=euGwPsPogDlniuV4FhHgWZRz
 xcZ+x1hQNJ5g0xOwNmM=; b=X58z8cRps5ywNgg0ZH5F6VnwwvBCFv6bDW4o4X2y
 XjOa6whOhh2nd9VITGFOkzZ3HuhovVw37j4++/69sFS+3b0/ZhhA6hf+2iOH0PL4
 1zVGdqE7c5lNXkXjWB+W8SHX0VtI2xZMvv/oP4uONKgKkY8YG74yoEAovI7xD5JN
 DDIMddwjxtje+CrPvhk9Bf+LB9h5dagp947BdyIHCDnkDGfr5C5hdq2aCwPIZIaH
 /aRpuIEXlnNDtoaV7FKGCuIpnBoPkUeXPWLwlX61UT+4UH0BAknhRBLXPCg7wUYj
 40ios19eaDAiCyZYseDVxuPB4IqQsaByNOheIK3jg+4GGQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe8vahta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:21:58 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9728971f4b8so121682241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783851717; x=1784456517;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=euGwPsPogDlniuV4FhHgWZRzxcZ+x1hQNJ5g0xOwNmM=;
 b=SDO3nXmEkxRHXkrS7sfxqTHOgJuTBE1oq1I62lYUIhG/WNU8oogSedLyqN+7xXRclZ
 Sug2gwvOVGqN2lN/06CeMr1Q9vOaE4DFMKOjJUw4ha2f/uFsWG67O77n/CjJgG1o8azS
 Xtu5AWiHa1iiCPPFVorcjBlCk6pbLSzc/Vt5TEZH6vzFQYfAt0KcEmxJKQLIcAqcSnvw
 CYVpTES5mv+HQ9uFurvlbrLI9bmv+Uo+ZEJcf+972gTqUVuZ1ZwJRLhvP4+MmJZxhgdf
 O2Vd9atcv9bmqkqBIxg9eKmaBFkQSQluAhfVOJ25Oqvbb95ZUTmycSZFCOLw3KqrrbVc
 OpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783851717; x=1784456517;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=euGwPsPogDlniuV4FhHgWZRzxcZ+x1hQNJ5g0xOwNmM=;
 b=m3PP8xjn6mi/RqFrKJZesffzIkW/ioBrpzxCjAtk6GffIVBrs3i51h87o8vdKB/a2v
 7pYohHL7i239En/JSnAxwsn5F+/V7Fy1SlupWaPqm2hBtvncRcaJYN9W9fZ6x8xgNEwA
 XSGV+vNWTthIhoIsfBzj+ln74w1GmzdkHwBT+v0CFJe9Voi1TDoQOQ7tUGt18Pu103Fx
 lalp/jlzMjKiWetz3JIVRPZ0RlK9qNtXWDbQqYemT1pbqnz0X3WsHrcqZ1vwxNb4Aw1+
 X/pfJX0FE3y/jYUVCPghwpiSYRZDIQkM7KlHRUBVOlIQ3TnW6sgmyaeIydWfVttbUh1P
 JKCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpO803rel0a7udEIM98kvm7C3NSfQ5a4aTshhU6GrZk6bXZuh61Ik9faUS8pkd/DBvB1S/hdI6lQkg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfsOUSDUll8bPiAdYxmtBhzAjcfSD3s2QfHWra5kbYVL00uCHi
 mVFTlluewiZV2dEfQavIe0THemnQaPavfK8fxQ18agzYM7imTven2XgVKYQY8rQLQProt7Lfh3K
 MVhnRT9sNfhwLZXk15HxcU8oOSqlkUpMwDCAA1syj8psfL7irgswge0PEjEV9DLtPrNHTjEk=
X-Gm-Gg: AfdE7clC1Y4Tltunion2qazsrtzdOUOPbFvIeB9szoYOp8ZeRQsqBJVINlr0fCRehS2
 Kqipn6kzPc6fcmW9Tr0Bh/GGLMr3ObVvfwdXvjMWEK4ID9uVz8nd7t7yBjWCva0GJWUEv0v8/aI
 i0KMYj4K/AFiWrjepoge93S9GxTqD9BO1nSCq9QdgdBJGtW8sfnLst26vGqsg+RGgr0N3xRf76U
 ClXltAlliAEY7uqjK0bi1xq9LqkKwsf5OGkEiMoMUvIiCc4vePM3l0q3sZYdrN7h9Zex5Wu1Xdm
 d4PFkZWSGIl+QMDIylxqeR+7hHu5tDMSpZEdAhHE06KvUcjJQvN0XeluoU93zzoGkL/1V0veHNK
 4DU6gzvnChAB+B5oeBPCkReDo/kVW67XAC2Kop2mzmYzFZ4o4w5Tepz5L/0hP0Ufac+rmK81hqg
 RfC8PX7+po2mQtIU+bT/0gg2ZL
X-Received: by 2002:a05:6122:35ca:b0:5bf:d2c7:c481 with SMTP id
 71dfb90a1353d-5bfd2c7c633mr1242363e0c.7.1783851717367; 
 Sun, 12 Jul 2026 03:21:57 -0700 (PDT)
X-Received: by 2002:a05:6122:35ca:b0:5bf:d2c7:c481 with SMTP id
 71dfb90a1353d-5bfd2c7c633mr1242356e0c.7.1783851716956; 
 Sun, 12 Jul 2026 03:21:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84bb39fesm21064931fa.42.2026.07.12.03.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 03:21:54 -0700 (PDT)
Date: Sun, 12 Jul 2026 13:21:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/5] drm/bridge: allow hpd_notify() to suppress connector
 hotplug events
Message-ID: <cgk2httvebzm2jnjnb437mutez66tfozzdk77mjwukfzngdioh@mu46u3pwlf2u>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-1-646a10256233@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-msttypec-v1-1-646a10256233@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: CO-jQDQDCOgq0ZlEZidGqLy0ofPrIi0v
X-Proofpoint-GUID: CO-jQDQDCOgq0ZlEZidGqLy0ofPrIi0v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEwNyBTYWx0ZWRfX4wHMLtx804tb
 RXjxRVxzvAcwlGz0V4SgpXBcyxOk/NfnaiXSN/zmDlQ+YI4nXWi36kvx+5O6mbS9ZRvYNY5hRej
 8LuYL/vmyzBSMNf4sTWBmwokc5wao7w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEwNyBTYWx0ZWRfX19qyjCypYfbl
 oj2nxliCOo2q/Qj3dNM+ttQIKUi+BuSzjO5U3nmuAM5UAAMuD4/1OJIemo94lWCZU6Rg0KcWZ/t
 1m1yAPZYC7hUrpCw1CFFuYMVUcnyRleC+yoQyouaau/CBIJs3d2q1LL1a/MJ8zQySjsihSNgLtW
 06A7Ubr3xrZuh4kT4t878j5MV4ToF0Ge65OLBQDThcrzK41Br06kJt1JxY9gHmB7Z+AAS183Ksd
 1M4RtQujPN+sPs+A822l40LhEiSIrpur52nK5H9C2uBUdwxiOyMAzuq2HuVVWTK43QFCnduGBaw
 yD19Ml9jtgdnmD0VB8tcz2PI1SO16ihIxYreCLdxqnsEtgjiZLP9Nev7wnr7jGAEjEr4jV5ndT1
 BeUQ3q+4xbFJ6S6MCTL4xvazRixm2cPBjIrnGxWaD8jns8S+XNvDHkfFGEvkdyJvLA3ryvCZchn
 Y96sXmtRaEufBjY7MXg==
X-Authority-Analysis: v=2.4 cv=WONPmHsR c=1 sm=1 tr=0 ts=6a536ac6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ROdofPDD1fpM39RL8CQA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120107
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

On Mon, Jun 29, 2026 at 10:48:03PM +0800, Yongxing Mou wrote:
> The bridge connector framework currently invokes all bridge
> hpd_notify() callbacks and unconditionally emits a connector hotplug
> event afterwards.
> 
> However, not every HPD notification requires a userspace hotplug event.
> 
> In particular, DP MST bridges may use hpd_notify() to propagate HPD and
> IRQ notifications through the bridge chain while the actual hotplug
> handling is performed by the DRM DP MST core. Connector creation,
> removal and userspace hotplug events are already managed by the MST
> topology framework.
> 
> Allow hpd_notify() implementations to suppress the bridge connector
> hotplug event by introducing a bool *send_hotplug parameter. Drivers
> can clear this flag when HPD processing should not result in a
> connector hotplug notification.

Why? Worst case the kernel receives another hotplug notification which
gets ignored by the driver.

> 
> A NULL pointer indicates that hotplug suppression is not supported by
> the caller, such as the connector detect polling path.

And nothing in this patch makes any use of it. I'd say, it's
questionable addition. Let me check other patches...

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
>  drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++------
>  drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.c            |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
>  include/drm/drm_bridge.h                       |  3 ++-
>  7 files changed, 21 insertions(+), 12 deletions(-)

-- 
With best wishes
Dmitry
