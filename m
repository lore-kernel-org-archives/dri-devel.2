Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990A1C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A553210E94C;
	Fri, 18 Sep 2026 16:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F862iJkl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kaOV9X20";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BADA10E94C
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:58:45 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGnvuN2364101
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FmJ9l5QFBMMe48wI+FnvFQSDXsCaB79a0WihlyuJstA=; b=F862iJklfTEspXfc
 UjvRsNylWUiwop35P1muhLn10HTOL/M7stdoCV5Frgx1dJJyqJCtb9FvturdV8sv
 z3alBIEzMWiVlVthfKBVozYtF7rTFVwi4etMJQaCL3Xb1OMzWcr3mo94SqS0NKef
 R2spGU2cf3Z4YDgyNC0YvETba6iLNRQtX+MmCmDbez6Y2pZzcL6/1A49LPfbZR3+
 EwSgfygJ0q8qQ9GphKHYvddiZI3X3ZqEQSOuyLKfi60D+5Gm3ZpMKc/Bkp7QtCxC
 19jlA5mLGS4eEQmM2YLhernOpYqFKGMWVlTYHqEyqO4snc1SdLMMuu7ckn2KAGe8
 b6XcSg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grtdpusas-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:58:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-855315ccb64so1018684b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789750723; x=1790355523;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FmJ9l5QFBMMe48wI+FnvFQSDXsCaB79a0WihlyuJstA=;
 b=kaOV9X20FujHuc1giQCQk3KsjqIU8wnypt9/DZDt6kt9KmmO250pn2X5anKmXcSBU4
 f+QHcXXDbl9HyY44C7AHMy4tqaqiWZmgaPKyroItObalq54F2sHK2211W8VU3KMl4AhC
 g13dLT0bgkHsLxKXgBIF3FNnmtFhfNA6w060gjYlmAxItixQgjjv/endcNP61eG1mJ2+
 te5/jrz2iWWZLqdyM0WOmZen4czHcW387f/qwxBaSscGYwecR+2peGMuHoq+lRr7lfIT
 fmu4ngGpNVKQlxNNw6GlDsMT7lGLNPYEeZRjuvd4jDsMF0BRUKxdbYx817KB81yGpQfT
 nvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789750723; x=1790355523;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FmJ9l5QFBMMe48wI+FnvFQSDXsCaB79a0WihlyuJstA=;
 b=mzuds0NSttdr7iIa/tcvYcTZAoaK8N6Pd3ynfa9T2F3bCrOcpiw6vFSEhvPpEyzQbs
 iposKjCoWgd8KSQgG529mtBreXtwt+nwFKlv2OetPJaau/2l2poSarJiWFLEEYqW9vk/
 1DEifMFQcfdkyum3mDvjva1b9yR+KWll+Y9zQ07ukoaxFzmJxmt5ILLpJZGs9tI+rbHd
 2P1QwhzTRYGMgC9J5d1vh6HGO7IF1YoGLzVfDrrd3uNd38lwyh44SIUtmPDyIJa3YNSs
 /p8FtnWe+pA4uIck0MIwXwQxRIj8SbQU2Ze1MFZlXcnq63UcqwRN9WeyGXKf35jjb3eD
 Pa7g==
X-Gm-Message-State: AFuF++nnBKdYPYlZfK2jDbFq9DGo1zI0stCkRIbhI1nzQoSFU4ACqx6Y
 PL+wFQqRwVOwBLgth6hnYvPXTTzMGWeFZ7aK+/LrdcjRG7K3bF9lje0/nwH0F2vKwbNqHFPppMI
 hQG3btRMwDNGJ0drKljRzkteVsKWyCpj+kAVdwv6qn6jJmcABU90+nvdudt6eZWenslS/CYc=
X-Gm-Gg: AYBFou3675jEkG3whk0zYPOruYIA9+LESO4z/pdXgks2iJfWy2izNbfXUBZJodvc2NF
 ZXTHzL/VezxhjzBajhSSbD9jWpUwUC3CEGo1gknDIB1xO6bXzEs/z4jWXpf8CzDC9DYOcSJlsmz
 ntPyaQ2GNC5I0PcDo73Mp4ZhV+dGgb1rJzVrse3R8THyyRLT7mK+hRTwKuERhWmEDUYvMLxQNfQ
 TaUAUetduNtHBTAtAKPZQx+lrwULLH94X8Pd+kCu9NhprYkfVHxyG4wFaHnYYGsTbZzecziUYZS
 STsKAFxFoCH6Kpa/mywu36903GkLsGGDwwFKEOAjXXp3wf/ygjSKs8qN4L686Fb99/zIa81gABc
 0oEBo0g==
X-Received: by 2002:a05:6a20:d707:b0:3dd:a195:fa0e with SMTP id
 adf61e73a8af0-3dda195fd95mr361292637.51.1789750723361; 
 Fri, 18 Sep 2026 09:58:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:d707:b0:3dd:a195:fa0e with SMTP id
 adf61e73a8af0-3dda195fd95mr361267637.51.1789750722830; 
 Fri, 18 Sep 2026 09:58:42 -0700 (PDT)
Received: from localhost ([143.246.51.243]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc5c50e7433sm1426162a12.28.2026.09.18.09.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 09:58:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 00:58:17 +0800
Message-Id: <DLILO7Y6WWXC.ON1PAKLWJM1Y@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 1/2] drm/imx/lcdc: avoid duplicate clk_per enable
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
 <oleksandr_andrushchenko@epam.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, "Marian Cichy" <m.cichy@pengutronix.de>
X-Mailer: aerc 0.22.0.r10.g73f20125
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
 <20260727-drm-simple-kms-removal-v3-1-de36e534f7a1@oss.qualcomm.com>
 <bbf8fd0e-8e1c-4899-98f4-b8231800de8c@suse.de>
In-Reply-To: <bbf8fd0e-8e1c-4899-98f4-b8231800de8c@suse.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI0MiBTYWx0ZWRfXzonYsICu19dW
 0m9qwk629EDcZ7QVzppN+nO2cRFZaX+6STT/Hzr3Vit31yadGeHdQ94b3XCeR4Mu494AYzPc8ga
 X1siIdv3l7TTPZufaaSsua5tB9CCVh8KGgEL6A5JaXcqpIa3OTonvzzaRGjmZDtP4Bfa3Wt70PJ
 UbkcAMyHgHiyEEQcohCmgvftmNji9i8I0sxNGpa2hUhBVjWf8oWvjpy2FCser/wkiLrfVd9S2sf
 0NFejiGc8aHjZEDWO4dN3OwDMT+lZbAcE5B1bLRmxbeRjrY87ZtBR9S3ixUF0yR0tbb5wxK9Xc2
 seE59XtTg4Xyk1GcWRg2b/iQPAXHoMpJjNY1QtmyO1BClsycL7HMddV4i+InunzFHxpTlgI9vFk
 TxrWGsFD76HoZbm1jWkI/WVcIgKX7ehREQbf1+6p7Py2aLDxBGAFvB85S77zzNP8MEIiBqUNHk6
 lVB9QKox5VCZqr3F5BA==
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6aad6dc4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=LNnhWNgewsfctp/cwirQdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=gNeoJdBQTLUQTwsD9V0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI0MiBTYWx0ZWRfX5EXM271hA8sg
 ytFrlmuC6mb15TN+U4nMo9qsrGyo6R1j5vHfgBMk+0IHLMVrwpETFDF3ImDh3OGfCRS0ffhDlb3
 xFHeev5CCxbcgVPWUfZWXdE/1sRFrww=
X-Proofpoint-ORIG-GUID: VBZ2zHPhJL3zzknE13FNEN3cNMUH9Yxr
X-Proofpoint-GUID: VBZ2zHPhJL3zzknE13FNEN3cNMUH9Yxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180242
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

On Wed Sep 16, 2026 at 2:24 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 26.07.26 um 21:42 schrieb Ze Huang:
>> The simple-KMS helper calls the pipe update after enabling the CRTC.
>> On an enable commit, imx_lcdc_pipe_enable() already programs the
>> mode and enables clk_per. The following pipe update sees the plane move
>> from no CRTC to the active CRTC, treats it as a mode update, and calls
>> imx_lcdc_update_hw_registers() again.
>>
>> That second call has no old CRTC state to disable clk_per first, but it
>> enables clk_per again at the end. The disable path only drops one
>> reference, leaving clk_per enabled after each on/off cycle.
>>
>> Skip the register update from the pipe update path when the CRTC already
>> needs a modeset. The enable path has already programmed the hardware for
>> that commit; keep the event handling in pipe update unchanged.
>

Thanks for your review.

> That seems reasonable. Once the driver uses regular DRM helpers instead=
=20
> of simple_kms,=20

> it can all be untangled and this test won't be necessary any longer.

Yes, that's the goal.

IMO it's better to spilt the operations in imx_lcdc_update_hw_registers()
or distinguish the caller.

However, it might be risky to make big changes without hardware validation,
I think it accpetable for now.

>
>>
>> Fixes: c87e859cdeb5 ("drm/imx/lcdc: Implement DRM driver for imx25")
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
>> ---
>>   drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/l=
cdc/imx-lcdc.c
>> index f52832b43aca..81024f7d9e96 100644
>> --- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
>> +++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
>> @@ -311,7 +311,8 @@ static void imx_lcdc_pipe_update(struct drm_simple_d=
isplay_pipe *pipe,
>>   	else if (old_crtc !=3D crtc)
>>   		mode_changed =3D true;
>>  =20
>> -	imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
>> +	if (!drm_atomic_crtc_needs_modeset(crtc->state))
>> +		imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
>>  =20
>>   	if (event) {
>>   		crtc->state->event =3D NULL;
>>


