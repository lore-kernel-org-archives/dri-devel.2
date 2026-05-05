Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7756FFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 21:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0AB10EC26;
	Tue,  5 May 2026 21:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7qXeu7S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h6jhPCTP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D15710E647
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 21:50:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645EfjLo2859059
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 21:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=GWoubTXPQdVwM4tS4Rj7Dbfl7e/Ff9zwszps/EZhuKk=; b=m7
 qXeu7SooJdrbzx+ez3ztpKc8cu4TsY67cSrZycclEIrhwsW0CPKHbigfETGzDAPo
 tDqs6F0tR7ATCG+ZsPLPnFrmhwwUQ/ifgBs/SMVU2SUCt1oT+iq91dPTztQBzWZv
 JR3GwgS4ydL6REZZuzArZCL4ngfEDkhvxYDX/IRdqIHX8xdU9Ew/yhHUcUE4gK/4
 mx2taIugSHfLnsEH9EFhiShR8bnIVERJvLpIUpS6QKzBTrep28ncwwO6kesUM+sa
 6bdttxzy5hSDRCGFKJheAH2SKwfus8FipmeSM3biuol0d3GkT9OdoAe5U4gU3Fta
 mFB81t83iwxS1HHbUXLw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dye0ajw6g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 21:49:59 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-47545742e67so6772901b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 14:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778017799; cv=none;
 d=google.com; s=arc-20240605;
 b=KAMCwsuM+YM6NANksEt3S83eJexzHpFIHI/4TQ7Sxtg1NKyE8DCQSV0eeT32Ru4+0C
 x0Fk3q83Mm49Jmx6A+S7w02FGSp3qOyDZWZFAnKQ06S+mQJYZzjaEB8vDsTLXJoHHsxe
 I3bKteHk4VYS5gjlYdfKKbLonH2xsthy9qhl6GGt5KJ1TT6eXchL99Fp4R7WTLvE+odG
 6TtmoFDvO4Z+iqSdzMaPSyxjy3ZLvBsD8rvkOnoGqliOnkndv83KbK5Rs9dWH+8zDNzx
 7AuP7HtO3st6IMTXvfUplcF/LwnWZfpH9jlvH2LzpN2b9kLny6295BvF90vpJL2yGxCB
 QLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=GWoubTXPQdVwM4tS4Rj7Dbfl7e/Ff9zwszps/EZhuKk=;
 fh=RaDm3IgRvpgjHoUjh+bpd2w6cS3b+7MJwdpyus2/koA=;
 b=aV/a4LgRQZE+tzKMRe+TIIh3cbv8KE2eX2HNm47VMhMLsTN9egrF+r+ePR0uHFCAkP
 sxpdfcqAAbikFL7BqYYil/UT+aTvL7vGa6xF1Zgxu+dSHY73X3/qIL6P/eYsAAeww3Xm
 u0DfJUY/IZtd8to+wpc/Yf/VhWSaDJZ0iv81MRNNK5DfbcLxy+hkbPqqanAve7LYbUKF
 6aHqdh1Y2YeleFKCL10HTgMyzqwKcRa9lSjJzMfh5pfjRHrk8173aJb3lwx/OrqZX+wo
 yBHL1VJxrtvU+dYHVYdIo67nUknyK3CZFR0P3ieXvWKBeVRadMZJmAa7T2SLikuv9PqC
 unPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778017799; x=1778622599;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GWoubTXPQdVwM4tS4Rj7Dbfl7e/Ff9zwszps/EZhuKk=;
 b=h6jhPCTPnK+b0FiHhBGN4KzdEWvUeET2IhzYdIMkLzyeKqu3Ad9zeYoXQtbQzg36bT
 lEUaPP2/0LOZ05HBTBL2wHaKaalOJ4Ha1Uz8qivEiEBckdFT+TdgGQ1GRiSfSiLMUxRN
 w9th+2YfHad9gD6P10vX/nkPiUDyqZ+oqYXfeejdVHQ8C0+eNFzqg+92aXdDMu4n4kvs
 VT5w4mVpyWtkXhFkK7JYQjhs50HbiOhx5gQcx4nbt6S/Sco9bBvFgXAQnkC0qFOM+58y
 TDkr1ftn0daqAzYKd58CdSXr0tdv0iAyt817phHhc+vFDMseeoMqoXtZKK5AZ7ONeTbZ
 XNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778017799; x=1778622599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWoubTXPQdVwM4tS4Rj7Dbfl7e/Ff9zwszps/EZhuKk=;
 b=Gtb7HHoF+UtT4vQzDz/Jqp2LkB3myd6amHU85Qn2fR4h/DUxeBWa7ebzcRJWDo6HfY
 2+c0ZQ0+lnNrzkBjP4q+J3nTATGtgpKnN+TA7AfTrKPHCUr7etKHXxHJ9qRHwTberJGr
 CvlUwbHiqxlxPTEzIPLx4yOfWCM5QEwhkRitHmgE7jg/0gs+nWD3ThOOShdr5uUehyc7
 I28KmIB006kTcQrqGSDqt2/AGka1YXNNPjWZ+s0xJdI815md+VhbkTkunfLFi3bc0pv1
 k5LXnTw9o11YwYMm8fIjarUue45H8C0kHYGCeKQQQ5g6gJ3FF5FwwQKNGnzhozMEh1w1
 0PlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pVmWS6lgjSjSJhZTfx9ymFbTD7M6duC9AD8/y5n65zDjdUqVm4oTcueosNCBVg4TtrtBTwSlbpkY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwU1cpQxQ9W83JL4M3nmJI69SICnrODbgZR5l8wf4yts37crNjT
 8xJQaC6HGBsPOwd8Jnn5e3AxX8sZLGT4d1I7cPhSY7j8vAw1CF8mWZOcxHcJRtqaEx10C1x+/yK
 T7IzmqKneAalEAbLZt8YGLoZxPviDSHbvgwx2OyYZRMlosPJbMy//yNUwrH2bpK8D7+Sv2vdkZ1
 VCKNe7M6mbFEBBqdcp27K5jRCZA9hF3UiWJO9ot3TMETystw==
X-Gm-Gg: AeBDieswuF71FYEW2scsK9BHTEkUL1ZwYkZPPPS7kdM75uetIZNNcsJDQwiyIhfAZoy
 /fzaCRTIW6b86pb0aplB8E60a+hwUEizxoOiatcclI3ljJPAbDxHEcBNOCLjvalwlkcODG5ajdd
 DfnGRUgPtlKlcrKgTTjy0nddOmLUTHjl/2m476GaTuOLbBtlk6KaHIfRcyrS/DlZiESybK0EEXx
 X7pNi1hc4oSHNmpKa7aAghQ1q5Vu7yDvSog8DsMZPHJsfTt
X-Received: by 2002:a05:6808:d52:b0:467:9ca:4b8a with SMTP id
 5614622812f47-4804221828cmr643096b6e.11.1778017799371; 
 Tue, 05 May 2026 14:49:59 -0700 (PDT)
X-Received: by 2002:a05:6808:d52:b0:467:9ca:4b8a with SMTP id
 5614622812f47-4804221828cmr643081b6e.11.1778017798961; Tue, 05 May 2026
 14:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
In-Reply-To: <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 5 May 2026 14:49:47 -0700
X-Gm-Features: AVHnY4LH0uDMjgYOgFKujr3D57r6UVTyvfwJmoAF1iOOVmgpBbGDoiGs-TovmEk
Message-ID: <CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] drm/msm/dpu: don't mix devm and drmm functions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIxMiBTYWx0ZWRfX5y7Z7Z1kZKzj
 MxomAVP+UVcxP5eJtC016A/vsaU7rJSNI/neSWxbGQGK7SDBnrAOwN2lmg1bl50uLIe+1F4+Dsk
 zPLDC0SuGdbfYrgNQfre1lcIxdm4bE19UDIyiCgN9C41A3BE1dU0/ylxve4BSE6uj0KnKZijyzL
 bfZ/s62X2ZCIdeyfIKtax12XqyQh6+eqN9heikpIkU2x5Iure809ejk2H8hKKSeP/aOWdPyktUq
 pHBCC/xHFTWN3aYtuywewv2OqV+yUCBRsnHLo1W7taI1IPMMXbgq3b3QHuwW9HursBH+2S+WmlJ
 rum/O2phRmHGIVrEEJcqvakFGm+c3ae+xxui2/AsmLip9YMuVBl2oQ+wcWWyUk+chkHf1bOg+AW
 OWXvNRqdMrvSPblFxYeZah2b0sQy+F7W4wkhB8JtYy4oYog4ZxFqMBQFOviJ0GjEwVX0m38NWqG
 4WiYJhG+2RLfUVTHADA==
X-Authority-Analysis: v=2.4 cv=Wtkb99fv c=1 sm=1 tr=0 ts=69fa6608 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lAOjoZoF1AEScRdHVYcA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: Zo1V0OFIznP1picVR1PJXCC2OrBt_TOc
X-Proofpoint-ORIG-GUID: Zo1V0OFIznP1picVR1PJXCC2OrBt_TOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050212
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, May 4, 2026 at 5:25=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Mixing devm and drmm functions will result in a use-after-free on msm
> driver teardown if userspace keeps a reference on the drm device:
> The WB connector data will be destroyed because of the use of
> devm_kzalloc()), while the usersoace still can try interacting with the
> WB connector (which uses drmm_ functions).
>
> Change dpu_writeback_init() to use drmm_.

From [1] it doesn't sound like userspace holding the drm device open
is the issue (if that were possible, it seems like it would go badly),
but rather the order of managed cleanup?

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3D3a13c2de442d6bfaef9c102cd1092e6c=
ae22b753

> Fixes: 0b37ac63fc9d ("drm/msm/dpu: use drmm_writeback_connector_init()")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518@wa=
nadoo.fr
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_writeback.c
> index 7545c0293efb..6f2370c9dd98 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -5,6 +5,7 @@
>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_framebuffer.h>
> +#include <drm/drm_managed.h>
>
>  #include "dpu_writeback.h"
>
> @@ -125,7 +126,7 @@ int dpu_writeback_init(struct drm_device *dev, struct=
 drm_encoder *enc,
>         struct dpu_wb_connector *dpu_wb_conn;
>         int rc =3D 0;
>
> -       dpu_wb_conn =3D devm_kzalloc(dev->dev, sizeof(*dpu_wb_conn), GFP_=
KERNEL);
> +       dpu_wb_conn =3D drmm_kzalloc(dev, sizeof(*dpu_wb_conn), GFP_KERNE=
L);
>         if (!dpu_wb_conn)
>                 return -ENOMEM;
>
>
> --
> 2.47.3
>
