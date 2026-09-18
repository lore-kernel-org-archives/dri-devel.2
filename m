Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281BEC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACA310E54B;
	Fri, 18 Sep 2026 15:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTqEyIFw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uh3mWqhI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2397A10E134
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 15:15:04 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IF0WGW1234108
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 15:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 klACuV7fdAYuSy7gHXP/AwNMnEDjRFePgshatLjHrOQ=; b=DTqEyIFwhXRJLNu9
 IeYZsHOrKbXijwmdqq+ZxiPvyfet/fCUB0waQ1XFZArweh0RjYYUmoxq7nl/JEN1
 Uy5NmhOd1qusEnfpTpqRg8agzbrAvS7pZSvHR/ylobOfF2XYjSV1/YXA1xxh8us/
 0WSRuT7kO6kdLHoxx0I2EyTlfaVrjEBLOT5OPcRGUnOIkfZCR1Q/Gs7QFtUyIHF/
 pYQtElGkrqyBwxzixxweaHTo1wj2rjXG06RAMMI+IEvfVga5JiRCPKr59GAZzH1x
 JMF+HWQl287jMZVbazg42u8QTxVQ95BPg7psGMdFhgyAH+3PsFf8v+fRdN7V6mJV
 VeUpRg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs7jk81u8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 15:15:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d959904658so15126395ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789744502; x=1790349302;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=klACuV7fdAYuSy7gHXP/AwNMnEDjRFePgshatLjHrOQ=;
 b=Uh3mWqhI1JjrKHQsYToEzofSZa9NznxEEgLzgjBaUxc4AsR81K9bv1lL6ZDxUJOlrm
 Uci74p5Mzwnii4871NnW/jalGlzkymiokVp1NfCvFZ8R5O/ISsd8nDiY66sQ2SZN50yF
 V+CKnI3eTLf4KnoBL7pEhYkcqdjHyN1FqBy4taVpeCV9S/wPNp43ugTeoCoi8fXrmk0I
 Fk9SxcR7k8WydnVWKNez8+cOPkjVcFCO6jQ+mJS7ZxqP/yqL1ySvgcIsqtjy0CHM7U5R
 cpljphQOcCShjT57TjR66MHqAFCaf9lpJOACRUGMF3NKc2YtUslrqiPWTvXAL/eWpYmd
 ezgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789744502; x=1790349302;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=klACuV7fdAYuSy7gHXP/AwNMnEDjRFePgshatLjHrOQ=;
 b=G4bEu2Kbfwk05w/e4Wx01LvBIyc2K9i6BOhRQfv26yhyYGC7v1MnfCd65m9gLwCinv
 8s9up/paN7JfizfFPA9/9LZknBve3jSBStL2s+8sATfL+/4hsnONtkOlI4Z2k6INkj2w
 oA0hNKOk70MT+zVC3DbYoX49v1UQlVdQ+BgRONkvyQat1GVNeALMHHoKSlc4XrWbDQ8Y
 +ouRAUhpjkWo8RGhdlicNY/sLY4WfkYiH/ZdY9touQQSIdvrmbsVekskjO4XNd5DcW9E
 iiA3kq3uMpdsbSYiGiKnpwFiLHudZ0ybbi4n0Lj2i76yN8c/kfGJiFTcbnDc5syhAuYo
 3R5A==
X-Gm-Message-State: AFuF++mVzfr3m0VkZErmhjOZeU3+dHdt+1J+efgY/rgJw84n3q2yY09d
 WPsRxFE7r//bHt6328f3pCMhPLntaQLKvYtf1qCKQRNy3qZlmLsdb3fvXOCxwJTwitrxQy4OCYk
 pAUmI9zSSy3yWe/RijoXFkRBijrV9zplBasTM7UkpDg7bH+62GE1qDlle3iBWvxxeZWXvQv0=
X-Gm-Gg: AYBFou2/+3d8AGoLKZEXARt0z/WWfI+F/t2cK6DmQwyTmmBYgZyXil0AUsqUyKFg2XG
 p1JDvHHAmQFY8st/pgrwNs1tzlbEx4fZyo1FtTIUcvK1fdKRePlcCpRRjYe1HrMTsZ9wMngJp6K
 jh5XXseA9wlbJsMPEAj0lsOBlzHBP1kQOPU8ad4XUqGVTz/RKfZG8bVTnwXCu8lVmoAyJKwfXqk
 08mxR0wRF383i6jAtL9i3REFtnMJhczgF8yTOujQN/ubLit3z8KFMK4YNuDwCE/T20nX7NJEEE1
 vlyLJ0sz/EZqUD54iTWY8yhCFvH0nOpAViHY33NfZOxlzBA2GEB1Ow8MO/12A2x0qwGoMa0IXnO
 6V8QGsw==
X-Received: by 2002:a17:903:906:b0:2dd:c053:e669 with SMTP id
 d9443c01a7336-2ddc053e6a2mr4634835ad.47.1789744501621; 
 Fri, 18 Sep 2026 08:15:01 -0700 (PDT)
X-Received: by 2002:a17:903:906:b0:2dd:c053:e669 with SMTP id
 d9443c01a7336-2ddc053e6a2mr4634335ad.47.1789744501092; 
 Fri, 18 Sep 2026 08:15:01 -0700 (PDT)
Received: from localhost ([143.246.51.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb73db302sm10267015ad.2.2026.09.18.08.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 08:15:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 23:14:35 +0800
Message-Id: <DLIJGTK5M3G0.2PNROS5SMQWNF@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 2/2] drm/imx: replace struct drm_simple_display_pipe
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
 <oleksandr_andrushchenko@epam.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, "Marian Cichy" <m.cichy@pengutronix.de>
X-Mailer: aerc 0.22.0.r10.g73f20125
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
 <20260727-drm-simple-kms-removal-v3-2-de36e534f7a1@oss.qualcomm.com>
 <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de>
In-Reply-To: <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de>
X-Proofpoint-ORIG-GUID: CvoACRwkV3fUgax6QqCOeCcBm6-E455m
X-Proofpoint-GUID: CvoACRwkV3fUgax6QqCOeCcBm6-E455m
X-Authority-Analysis: v=2.4 cv=FeSiV5+6 c=1 sm=1 tr=0 ts=6aad5576 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=LNnhWNgewsfctp/cwirQdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=nI5uWgR6GCbiVoZM8DwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNyBTYWx0ZWRfXyivqUeHU3xsn
 Wyf5axApsi2p3Zfyms47Xg6jOkAYh2FcnPb2eZwT4k01TSyh7GH2wm1ZktFpCU3whsvUOkFYS7O
 eErav6isJ2SxpASzUrfPxLvYzhvXuNEKLLy+6MPKeRYRhqYtYNhCwgPXHeeds5DU1a8BCNVlKk5
 fZdHL972aXfbFPV4AkEhBt9U196DpKV2TLGe94JZUhobgQk0R0OA2iXx++OfABQHH+k4MR28h2u
 4F1boJb4XygDo4jWwaUODAL5jpFDNDL/tcezB/AqXRAyTUcd3fwi8vrX+EcDynMT3vttIdCqARb
 XgXo9EDy7fI5d95dTGwl7TQfyHDD+nhktY4rYXzzeWbim27TcsrckkloJM/WzYXEh6lUGwxV01/
 AgzI7Cj3BGnSwthisRE0aN8y/A7uN4zAmS8JGbuej80XObJp3zIr7m/KEEZadEq+SrsJ/GsVwX0
 Vm5Miy+B+g4gEyaoSMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNyBTYWx0ZWRfXwzoJ3RIVeYXz
 9ajTyY3FiiaaXRuLcFic4zcxIEhu8+mUeTQBbhhZIFlKN/zIyZt2N3gbaH4pRIezUlH07awDGvo
 HaRaQ1qPXofCwEGgznT0Tkii3zWtL6c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180217
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

On Wed Sep 16, 2026 at 2:50 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 26.07.26 um 21:42 schrieb Ze Huang:
>> Convert i.MX LCDC to explicit primary plane, CRTC and encoder objects.
>> Keep no-scaling plane check and GEM framebuffer prepare callback from
>> simple-KMS path.
>>
>> Wire the vblank lifecycle explicitly with CRTC vblank callbacks and
>> drm_crtc_vblank_on()/drm_crtc_vblank_off(). Use the old CRTC state in th=
e
>> disable path for clock unwinding so the clock reference count remains
>> paired with the previous active state.
>>
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>> ---
>> +

[ ... ]

>> +static void imx_lcdc_crtc_helper_atomic_flush(struct drm_crtc *crtc,
>> +					      struct drm_atomic_commit *commit)
>> +{
>> +	struct drm_crtc_state *new_crtc_state =3D drm_atomic_get_new_crtc_stat=
e(commit, crtc);
>> +	struct drm_pending_vblank_event *event =3D new_crtc_state->event;
>> +
>> +	if (!event)
>> +		return;
>> +
>> +	new_crtc_state->event =3D NULL;
>> +
>> +	spin_lock_irq(&crtc->dev->event_lock);
>> +	if (new_crtc_state->active && drm_crtc_vblank_get(crtc) =3D=3D 0)
>> +		drm_crtc_arm_vblank_event(crtc, event);
>> +	else
>> +		drm_crtc_send_vblank_event(crtc, event);
>> +	spin_unlock_irq(&crtc->dev->event_lock);
>>   }
>
> Please use drm_crtc_vblank_atomic_flush(). [1]
>
> [1]=20
> https://elixir.bootlin.com/linux/v7.2.5/source/drivers/gpu/drm/drm_vblank=
_helper.c#L51

Thanks! will follow

>
> Best regards
> Thomas
>
