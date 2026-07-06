Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070BAC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBC610E378;
	Mon,  6 Jul 2026 13:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6jD3g6q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y2MZ4Erg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0A110E378
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:27:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxB90361297
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 13:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z62ZCofdO2RSyyIJCVJx2qppYjkSOPFanx+87YcffZY=; b=J6jD3g6q1gm777Y0
 tCEhSej+igS1polSMQBKyYChhg+l/XZ4uwIc80VGLNbhFVtISQD3SpBmjE1ZwhbF
 Gyy+MZ6yrmI/cemN48srn8oUg6zOIJn4hEBXEccdQEQcbYcJLAmnJCa3pO8gwWMS
 hQX0gz+gfZGsFO0XhX7ADUamBPev1aPouLxYej3AVjWqNyitOIqt+jg5xamMruy9
 mXClb3UePhfIV1iJDxj1j8O0FupwqsG6JhREVpfdK6IKl5SgTqCojkkEdR0ZVmop
 bmddZIy/is8juTCeZv8+eboKz68wZOZqboke98c+QKCX6raXn8VcSx3hJMac8F3h
 cxmmQw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h5183t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 13:27:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc77a6943eso62639985ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783344427; x=1783949227;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z62ZCofdO2RSyyIJCVJx2qppYjkSOPFanx+87YcffZY=;
 b=Y2MZ4ErgaDR4VfHorTkwdeDJ67N6X0yFtvheZOxYyRsgsjvCqMLUamnMnoCwHZyWmv
 mieIFu2ANw7k3WdWf3iPXdDE8aKmEEACVWi4ceF8nvjN8Wk/julIfC2fEEZ3SbixOW0n
 6xhpB2cQF6unrx8T1bWT8PJ8mTrLSQyK44KGogRsCx+XT4Ja+xw24Va7PGLob3wUykib
 pN6KiraXZkOJ+7Mtv1r8XuAjSm7q+UNUr4A+8X2Crxz22WXF93k3jfrEHuTcjvMTD+AR
 N9dkK74YUNRh5dVIgQdTWVVYmsfpsPp9OdvTZ2JthbRO+HZf5wc4lBxbLKUGUqdMF97z
 AgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344427; x=1783949227;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z62ZCofdO2RSyyIJCVJx2qppYjkSOPFanx+87YcffZY=;
 b=W8cz0UaBUxK+QPV8ta6yY8bu7bw9o0HbVYs5GrS00Bs+ba3f+lS0vCOoLxBNOysIPF
 v40XtTKzcFYm+w4t/jGn9TAUeJNpzM+rhnpVs1po4BsHc431X8cukmqsuZWMAOlIuZH6
 +eyeIt6VDWrNSlz0x+isXFtmYXZsfv/iap9e5LamMUnWtcx/1lzWhEvfE4COlqmSCZSB
 3m9zNR7iZloRra+7zPjhcZkdF0GKt6+H5f3yrLGAxprmcDRKiS6wYVGDZTcAa/m6TGOJ
 ZUYk8mgc7xMXEcPsctswueriurTM4vgpa488Itmvnuq7ECw+TdWbRppstwGlM3nWEwVQ
 Hz4g==
X-Gm-Message-State: AOJu0Yzkj/wBpIy3bjfVfS4eVM35gvEF1pNw6o+RnbCfNmKW7bP4WCZi
 4kGj2FEbpG6PyJ5f49vNFeVUOoB8xpfC2saK9V1rlckrRnJCKhBGOYR0MIMdJEDpGohTImpPlMP
 DNZG+mpOnTG5vt05mqFO71deYqK7EUtazK1vf7BdYjhEfEpYs+fqznAAN1YoO0YbtAPvVJf4=
X-Gm-Gg: AfdE7cl6GMtJF2IhiPvW6uq39zmlPmt/F/Xin4uvkieuBNj93OnMa9eEIDWkUEelSjR
 WLByFVFcsn272pOTq/S5GhXNylrekSWaiFlJ+0NmkIjHAQLviN+YzMHs/c1AhFp7po6Zv0gK7sY
 uOkxjFeiV+2awmhk3ZW+h8BV3DXBcBBpY97q75qc5n1Sf9x1xe9o56kdfDD+MCmsKKM6kJiToIq
 uUH4GInP8K72REZC0Tvbz4lPNBn9eGXeOe+vNLd6kWaBeGM+g3U0e2GpPiuS5WP4cVXogVWiDdD
 Be7B7zBTcIoCg8KDHbBGBxQwb4ne15qzGy6XDLaxDapDTcRve9o5HJer/m81TH23b0W2zG90zQ8
 djUGuqwMuUy/ATO8=
X-Received: by 2002:a17:903:2409:b0:2ca:4cfd:a6ea with SMTP id
 d9443c01a7336-2ccbe729806mr5550665ad.16.1783344426574; 
 Mon, 06 Jul 2026 06:27:06 -0700 (PDT)
X-Received: by 2002:a17:903:2409:b0:2ca:4cfd:a6ea with SMTP id
 d9443c01a7336-2ccbe729806mr5550005ad.16.1783344425931; 
 Mon, 06 Jul 2026 06:27:05 -0700 (PDT)
Received: from localhost ([151.243.38.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad7146914sm51455915ad.35.2026.07.06.06.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 06:27:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 21:26:52 +0800
Message-Id: <DJRIU0Y04PXO.1B0U1KFJRF3DX@oss.qualcomm.com>
Subject: Re: [PATCH 1/9] drm/arcpgu: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>, "Ze Huang"
 <ze.huang@oss.qualcomm.com>, "Alexey Brodkin" <abrodkin@synopsys.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Stanley" <joel@jms.id.au>, "Andrew Jeffery"
 <andrew@codeconstruct.com.au>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Linus
 Walleij" <linusw@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Alex
 Lanzano" <lanzano.alex@gmail.com>, "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-1-b4e1ca053623@oss.qualcomm.com>
 <2f2f0744-02a0-44ae-a8af-df6163869be4@suse.de>
In-Reply-To: <2f2f0744-02a0-44ae-a8af-df6163869be4@suse.de>
X-Proofpoint-GUID: FRYMbfbrWggTaDq6Z6Cn-lENucWts0Qt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX8iC/9Q4RnoCp
 AO0v1YxkJPkeOezccEl+97cTlvHbZHLtl/DfYNTiib5xRhSRc+6AXyBhlunA2jv8VielQKS2IX6
 unzHSQAdlW+Gza/qMRxGPJvjdDxn9IU=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4bad2b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=rGEwuu0Ht92CbwYE1HAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX736lJYj/wa5q
 VfRG/zveXzjQtsGGKWBGfdHJtJKffpovg9anHA8l2TVZaWsSqDaSl4dTmQaH5QYZ0t59RPwIkgB
 OBrSF5pGFiZGOZDOmG8oL10LAGkB4J5xEkNoTO5AgGGsIVAHA+pWJtWe492H6Wkybi/WSS67sWU
 asOZHfGz2VvS93W4jPfHOo3dOnZpjCvh61XCiqHyejCUt/O8wUl4/4fNQz9Tj4L0Hty0oDfDIdX
 1s0PtWaqFyO61HihyVhiuqyGIJgy8MCiIXBBtWL+25YbFT1E0FTBa8Mx9WqCnkFA8z4fvJk3sSY
 YZu73N8w0KCnaLfY7X9Y/owJRH4WecthS2+ANKlN+dx3tQZQ1wr7gbc1ntHuLZuGWQfCL5wr9aI
 xqvJrDqqZSzMvV3P49kMH6G1BPCvU+1Ppa69CGN6y1PRuna7c4yynJoQfn5dl1Cq5HAHYXJr10L
 o21Mj2gnk6sz9VC2I7w==
X-Proofpoint-ORIG-GUID: FRYMbfbrWggTaDq6Z6Cn-lENucWts0Qt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060137
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

On Mon Jul 6, 2026 at 4:01 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 04.07.26 um 20:31 schrieb Ze Huang:
>> Instantiate plane, CRTC and encoder directly and wire them up with
>> standard atomic helpers.
>>
>> This removes arcpgu's dependency on deprecated simple-KMS display pipe
>> interface.
>>
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/tiny/arcpgu.c | 165 +++++++++++++++++++++++++++++++++-=
--------
>>   1 file changed, 131 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu=
.c
>> index c93d61ac0bb7..375cdb79e4e8 100644
>> --- a/drivers/gpu/drm/tiny/arcpgu.c
>> +++ b/drivers/gpu/drm/tiny/arcpgu.c
>> @@ -17,12 +17,12 @@
>>   #include <drm/drm_fbdev_dma.h>
>>   #include <drm/drm_fourcc.h>
>>   #include <drm/drm_framebuffer.h>
>> +#include <drm/drm_gem_atomic_helper.h>
>>   #include <drm/drm_gem_dma_helper.h>
>>   #include <drm/drm_gem_framebuffer_helper.h>
>>   #include <drm/drm_module.h>
>>   #include <drm/drm_of.h>
>>   #include <drm/drm_probe_helper.h>
>> -#include <drm/drm_simple_kms_helper.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/module.h>
>>   #include <linux/of_reserved_mem.h>
>> @@ -52,14 +52,14 @@ struct arcpgu_drm_private {
>>   	struct drm_device	drm;
>>   	void __iomem		*regs;
>>   	struct clk		*clk;
>> -	struct drm_simple_display_pipe pipe;
>> +	struct drm_plane	plane;
>> +	struct drm_crtc		crtc;
>> +	struct drm_encoder	encoder;
>>   	struct drm_connector	sim_conn;
>>   };
>>  =20
>>   #define dev_to_arcpgu(x) container_of(x, struct arcpgu_drm_private, dr=
m)
>>  =20
>> -#define pipe_to_arcpgu_priv(x) container_of(x, struct arcpgu_drm_privat=
e, pipe)
>> -
>>   static inline void arc_pgu_write(struct arcpgu_drm_private *arcpgu,
>>   				 unsigned int reg, u32 value)
>>   {
>> @@ -117,7 +117,7 @@ static const u32 arc_pgu_supported_formats[] =3D {
>>  =20
>>   static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
>>   {
>> -	const struct drm_framebuffer *fb =3D arcpgu->pipe.plane.state->fb;
>> +	const struct drm_framebuffer *fb =3D arcpgu->plane.state->fb;
>>   	uint32_t pixel_format =3D fb->format->format;
>>   	u32 format =3D DRM_FORMAT_INVALID;
>>   	int i;
>> @@ -139,10 +139,10 @@ static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_=
private *arcpgu)
>>   	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL, reg_ctrl);
>>   }
>>  =20
>> -static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_displa=
y_pipe *pipe,
>> -					       const struct drm_display_mode *mode)
>> +static enum drm_mode_status arcpgu_crtc_helper_mode_valid(struct drm_cr=
tc *crtc,
>> +							  const struct drm_display_mode *mode)
>>   {
>> -	struct arcpgu_drm_private *arcpgu =3D pipe_to_arcpgu_priv(pipe);
>> +	struct arcpgu_drm_private *arcpgu =3D dev_to_arcpgu(crtc->dev);
>>   	long rate, clk_rate =3D mode->clock * 1000;
>>   	long diff =3D clk_rate / 200; /* +-0.5% allowed by HDMI spec */
>>  =20
>> @@ -155,7 +155,7 @@ static enum drm_mode_status arc_pgu_mode_valid(struc=
t drm_simple_display_pipe *p
>>  =20
>>   static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
>>   {
>> -	struct drm_display_mode *m =3D &arcpgu->pipe.crtc.state->adjusted_mode=
;
>> +	struct drm_display_mode *m =3D &arcpgu->crtc.state->adjusted_mode;
>>   	u32 val;
>>  =20
>>   	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
>> @@ -194,11 +194,10 @@ static void arc_pgu_mode_set(struct arcpgu_drm_pri=
vate *arcpgu)
>>   	clk_set_rate(arcpgu->clk, m->crtc_clock * 1000);
>>   }
>>  =20
>> -static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
>> -			   struct drm_crtc_state *crtc_state,
>> -			   struct drm_plane_state *plane_state)
>> +static void arcpgu_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					     struct drm_atomic_commit *state)
>
> Since you're adding these functions anew, please use 'commit' for the=20
> name of the drm_atomic_commit.=C2=A0 Here and everywhere else in the seri=
es.=C2=A0=20
> You don't have to update existing functions, of course.
>
> The name 'state' is a bit off here and comes from when drm_atomic_commit=
=20
> was still called drm_atomic_state.
>
> CRTCs, plane, etc have state, but the update of these states is called=20
> commit.
>

Thanks for your explanation.

I will change to name 'commit' for type drm_atomic_commit, here and
everywhere else in the series.

>
>>   {
>> -	struct arcpgu_drm_private *arcpgu =3D pipe_to_arcpgu_priv(pipe);
>> +	struct arcpgu_drm_private *arcpgu =3D dev_to_arcpgu(crtc->dev);
>>  =20
>>   	arc_pgu_mode_set(arcpgu);
>>  =20
>> @@ -208,9 +207,10 @@ static void arc_pgu_enable(struct drm_simple_displa=
y_pipe *pipe,
>>   		      ARCPGU_CTRL_ENABLE_MASK);
>>   }
>>  =20
>> -static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
>> +static void arcpgu_crtc_helper_atomic_disable(struct drm_crtc *crtc,
>> +					      struct drm_atomic_commit *state)
>>   {
>> -	struct arcpgu_drm_private *arcpgu =3D pipe_to_arcpgu_priv(pipe);
>> +	struct arcpgu_drm_private *arcpgu =3D dev_to_arcpgu(crtc->dev);
>>  =20
>>   	clk_disable_unprepare(arcpgu->clk);
>>   	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
>> @@ -218,35 +218,106 @@ static void arc_pgu_disable(struct drm_simple_dis=
play_pipe *pipe)
>>   			      ~ARCPGU_CTRL_ENABLE_MASK);
>>   }
>>  =20
>> -static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
>> -			   struct drm_plane_state *state)
>> +static void arcpgu_plane_helper_atomic_update(struct drm_plane *plane,
>> +					      struct drm_atomic_commit *state)
>>   {
>>   	struct arcpgu_drm_private *arcpgu;
>>   	struct drm_gem_dma_object *gem;
>>  =20
>> -	if (!pipe->plane.state->fb)
>> +	if (!plane->state->fb)
>>   		return;
>>  =20
>> -	arcpgu =3D pipe_to_arcpgu_priv(pipe);
>> -	gem =3D drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
>> +	arcpgu =3D dev_to_arcpgu(plane->dev);
>> +	gem =3D drm_fb_dma_get_gem_obj(plane->state->fb, 0);
>>   	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);
>>   }
>>  =20
>> -static const struct drm_simple_display_pipe_funcs arc_pgu_pipe_funcs =
=3D {
>> -	.update =3D arc_pgu_update,
>> -	.mode_valid =3D arc_pgu_mode_valid,
>> -	.enable	=3D arc_pgu_enable,
>> -	.disable =3D arc_pgu_disable,
>> -};
>> -
>>   static const struct drm_mode_config_funcs arcpgu_drm_modecfg_funcs =3D=
 {
>> -	.fb_create  =3D drm_gem_fb_create,
>> +	.fb_create =3D drm_gem_fb_create,
>>   	.atomic_check =3D drm_atomic_helper_check,
>>   	.atomic_commit =3D drm_atomic_helper_commit,
>>   };
>>  =20
>>   DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
>>  =20
>> +static int arcpgu_plane_helper_atomic_check(struct drm_plane *plane,
>> +					    struct drm_atomic_commit *state)
>> +{
>> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state=
(state, plane);
>> +	struct drm_crtc *crtc =3D plane_state->crtc;
>> +	struct drm_crtc_state *crtc_state =3D NULL;
>> +	int ret;
>> +
>> +	if (crtc)
>> +		crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
>> +
>> +	ret =3D drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  false, false);
>> +	return ret;
>
>
> Return directly here.
>

OK

>
>> +}
>> +
>> +static const struct drm_plane_helper_funcs arcpgu_plane_helper_funcs =
=3D {
>> +	.prepare_fb	=3D drm_gem_plane_helper_prepare_fb,
>> +	.atomic_check	=3D arcpgu_plane_helper_atomic_check,
>> +	.atomic_update	=3D arcpgu_plane_helper_atomic_update,
>> +};
>> +
>> +static bool arcpgu_plane_format_mod_supported(struct drm_plane *plane,
>> +					      u32 format,
>> +					      u64 modifier)
>> +{
>> +	return modifier =3D=3D DRM_FORMAT_MOD_LINEAR;
>> +}
>
> Please remove this function. It doesn't really do anything besides DRM's=
=20
> standard behavior.
>


Will do

>> +
>> +static const struct drm_plane_funcs arcpgu_plane_funcs =3D {
>> +	.update_plane		=3D drm_atomic_helper_update_plane,
>> +	.disable_plane		=3D drm_atomic_helper_disable_plane,
>> +	.destroy		=3D drm_plane_cleanup,
>> +	.reset			=3D drm_atomic_helper_plane_reset,
>> +	.atomic_duplicate_state	=3D drm_atomic_helper_plane_duplicate_state,
>> +	.atomic_destroy_state	=3D drm_atomic_helper_plane_destroy_state,
>> +	.format_mod_supported	=3D arcpgu_plane_format_mod_supported,
>> +};
>> +
>> +static int arcpgu_crtc_helper_atomic_check(struct drm_crtc *crtc,
>> +					   struct drm_atomic_commit *state)
>> +{
>> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(st=
ate, crtc);
>> +	int ret;
>> +
>> +	if (!crtc_state->enable)
>> +		goto out;
>> +
>> +	ret =3D drm_atomic_helper_check_crtc_primary_plane(crtc_state);
>> +	if (ret)
>> +		return ret;
>> +
>> +out:
>> +	return drm_atomic_add_affected_planes(state, crtc);
>
> Instead of using out, I'd rather use
>
>  =C2=A0 if (crtc->enable) {
>  =C2=A0 =C2=A0 =C2=A0 //do checks
>  =C2=A0 }
>
>  =C2=A0 return add_affected planes.
>
> Seems more natural to me.
>

Will do

>> +}
>> +
>> +static const struct drm_crtc_helper_funcs arcpgu_crtc_helper_funcs =3D =
{
>> +	.mode_valid	=3D arcpgu_crtc_helper_mode_valid,
>> +	.atomic_check	=3D arcpgu_crtc_helper_atomic_check,
>> +	.atomic_enable	=3D arcpgu_crtc_helper_atomic_enable,
>> +	.atomic_disable	=3D arcpgu_crtc_helper_atomic_disable,
>> +};
>> +
>> +static const struct drm_crtc_funcs arcpgu_crtc_funcs =3D {
>> +	.reset			=3D drm_atomic_helper_crtc_reset,
>> +	.destroy		=3D drm_crtc_cleanup,
>> +	.set_config		=3D drm_atomic_helper_set_config,
>> +	.page_flip		=3D drm_atomic_helper_page_flip,
>> +	.atomic_duplicate_state	=3D drm_atomic_helper_crtc_duplicate_state,
>> +	.atomic_destroy_state	=3D drm_atomic_helper_crtc_destroy_state,
>> +};
>> +
>> +static const struct drm_encoder_funcs arcpgu_encoder_funcs =3D {
>> +	.destroy =3D drm_encoder_cleanup,
>> +};
>> +
>>   static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>>   {
>>   	struct platform_device *pdev =3D to_platform_device(arcpgu->drm.dev);
>> @@ -254,6 +325,9 @@ static int arcpgu_load(struct arcpgu_drm_private *ar=
cpgu)
>>   	struct device_node *endpoint_node =3D NULL;
>>   	struct drm_connector *connector =3D NULL;
>>   	struct drm_device *drm =3D &arcpgu->drm;
>> +	struct drm_plane *plane;
>> +	struct drm_encoder *encoder;
>> +	struct drm_crtc *crtc;
>>   	int ret;
>>  =20
>>   	arcpgu->clk =3D devm_clk_get(drm->dev, "pxlclk");
>> @@ -301,12 +375,35 @@ static int arcpgu_load(struct arcpgu_drm_private *=
arcpgu)
>>   			return ret;
>>   	}
>>  =20
>> -	ret =3D drm_simple_display_pipe_init(drm, &arcpgu->pipe, &arc_pgu_pipe=
_funcs,
>> -					   arc_pgu_supported_formats,
>> -					   ARRAY_SIZE(arc_pgu_supported_formats),
>> -					   NULL, connector);
>> +	plane =3D &arcpgu->plane;
>> +	ret =3D drm_universal_plane_init(drm, plane, 0,
>> +				       &arcpgu_plane_funcs,
>> +				       arc_pgu_supported_formats,
>> +				       ARRAY_SIZE(arc_pgu_supported_formats),
>> +				       NULL,
>> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
>>   	if (ret)
>>   		return ret;
>> +	drm_plane_helper_add(plane, &arcpgu_plane_helper_funcs);
>> +
>> +	crtc =3D &arcpgu->crtc;
>> +	ret =3D drm_crtc_init_with_planes(drm, crtc, plane, NULL,
>> +					&arcpgu_crtc_funcs, NULL);
>> +	if (ret)
>> +		return ret;
>> +	drm_crtc_helper_add(crtc, &arcpgu_crtc_helper_funcs);
>> +
>> +	encoder =3D &arcpgu->encoder;
>> +	ret =3D drm_encoder_init(drm, encoder, &arcpgu_encoder_funcs, DRM_MODE=
_ENCODER_NONE, NULL);
>> +	if (ret)
>> +		return ret;
>> +	encoder->possible_crtcs =3D drm_crtc_mask(crtc);
>
>
> I think plane, CRTC, and encoder should go before testing the=20
> encoder_node at [1].
>
> Then comes the encoder_node test.=C2=A0 If true, do a single encoder-node=
=20
> branch,=C2=A0 or else to a single connector-based branch.=C2=A0 =C2=A0Tha=
t would=20
> simplify the overall logic in this helper.
>
> [1]=20
> https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/tiny/arcpg=
u.c#L287
>

OK, will move them before the encoder_node test

>
>> +
>> +	if (connector) {
>> +		ret =3D drm_connector_attach_encoder(connector, encoder);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  =20
>>   	if (encoder_node) {
>>   		/* Locate drm bridge from the hdmi encoder DT node */
>> @@ -315,7 +412,7 @@ static int arcpgu_load(struct arcpgu_drm_private *ar=
cpgu)
>>   		if (!bridge)
>>   			return -EPROBE_DEFER;
>>  =20
>> -		ret =3D drm_simple_display_pipe_attach_bridge(&arcpgu->pipe, bridge);
>> +		ret =3D drm_bridge_attach(encoder, bridge, NULL, 0);
>>   		if (ret)
>>   			return ret;
>>   	}
>> @@ -342,7 +439,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, =
void *arg)
>>   	struct drm_device *drm =3D node->minor->dev;
>>   	struct arcpgu_drm_private *arcpgu =3D dev_to_arcpgu(drm);
>>   	unsigned long clkrate =3D clk_get_rate(arcpgu->clk);
>> -	unsigned long mode_clock =3D arcpgu->pipe.crtc.mode.crtc_clock * 1000;
>> +	unsigned long mode_clock =3D arcpgu->crtc.mode.crtc_clock * 1000;
>
> Here, mode is an obsolete field. The correct field is crtc->state->mode.

Will correct the field

>
> Best regards
> Thomas
>
>>  =20
>>   	seq_printf(m, "hw  : %lu\n", clkrate);
>>   	seq_printf(m, "mode: %lu\n", mode_clock);
>>

Thanks,
Ze
