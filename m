Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0F8FF8860
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 14:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477BE10E0C9;
	Sat, 25 Apr 2026 14:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LV84CZbJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O/qdPt80";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D583410E0C9
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 14:24:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3Jjjo1728141
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 14:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ixUuUGkcS1ogu+Ork+yFuS7W
 ctoV+chAiSQKyR8/7As=; b=LV84CZbJ73kJp0FekAB/P5MFtE8cPCFmomVJgA8/
 HltgsE2+S3s8RndEDZoWzufhFPhHv9rrTgYsJVLsGLo9EfW4ZKo8Uy/7t5E2xpL9
 r/Ul/d435zV2Ukr6cwrKZi7VfHBAROBA35u8rKTxC95sVgHDQ5UeGZssUWcjIoal
 IkKHCnmJZJZA9T/XMO6yG8pOqkkf5cyJC04dmRMJTe+iyDuiAPrcutLRx2ixA91i
 nfrv/Mh/xsbRLLxxbY9tErJ8BxDhdbPMPHU36B9/DROKtbLukDyzJNwhu/SofGbU
 E0sK/QMRT0pTpQgi6e5k19Jh+GTVN3UScVIEEyLx3+Ef+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnkx94d0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 14:24:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso25100211cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777127067; x=1777731867;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ixUuUGkcS1ogu+Ork+yFuS7WctoV+chAiSQKyR8/7As=;
 b=O/qdPt803+D3A6HsIIZgrqOEh9fVA0V2GjA34I8mR9wENIxoM2AZ8B8vQvivCrgHap
 R4nE6ewIptODTAUUY2jOqwL1jS+mkPvxLthragoqmNpdNhVeX2YPr3f99ESyiD/S9C95
 vrhDKb4Do+CFmZug7EEh/qqVQ3VzDV6DsF8of1vV1akV+u4/C+QBJnmj/U3aCTf7+QiK
 fAkLHBWDKQYkkpOJHMdS12dT0cH5yX1AGKtxTBA031UyCQOCgYYP3k12KT6cJE24QmpD
 0PvZ5miaeK6DgrHazzjxyxV4wHPMBIAQvZLzghnwiNYH+aZ5W4G08rGBf8fTwfDU3FpI
 SXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777127067; x=1777731867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixUuUGkcS1ogu+Ork+yFuS7WctoV+chAiSQKyR8/7As=;
 b=kzIMxg3PD5DZ+gl/dx8KhnBK8EZGw8FIwNvHkvZla8MASQTDPap4esoYEV7U4spCBG
 LhfR/Adtn7nhJvr5UaSr25/Osrb/+4doKO+zHoFzGK06OqpSiOwpRaK0YAc8cP5NbW4w
 DU0CiyQ8+FXcifNRn1KN8ql6RYnZI9NkuYvGPDfUWZytiMTv57wFRMB/IWanbPaGITRj
 YUdsL3Adv5aLlHNkjCoYx0S96sWCyx5QuDYQDntvB1SaptNQuuKct50SSdjfzC3g9ds6
 pVux7QToFGVQMGPYEY6SPcl7sVnZ/jm1GXjTjgADG4gT5HntA4PZHDLwEp0VSPZe9kC2
 vvOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OufBuF0zdzuhYpv5219Bd7d3O3SuBDYDzNXMqvUFBh32+T0+SLcQgK/PmoHHJ/eK6epZCyWTn6Bs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+nUMSAKFxI8T+/jEiUqjTdb0WdZwgqK7NT/BBaIAHMaSN+KKf
 USIjCDwQAtc1KtxZzPV8hOMPJrJjzhmke5m2X+mZPeuPEpTMvH18WhJefqdBql1Q6dqDhRkDemF
 mqzlhQ+cneZ4R1VMaPNgzJLTY47155DTJ1NjPeJFyqt8qc9vEpk2IwNq2u+OIayUnbgLnoEc=
X-Gm-Gg: AeBDiesXX+iQT5WKbLRkoef4SEXJRhm2N/FT/7+9f8HAVyYn4tQuCa11AeSGw4MuTbd
 TIJ+a0htvhwvXirQUuo+qySuV3I7fAdamJ2dRVYLNJeFDsaSqkrejmq7yj0csfwRYwaDRIkP8Ks
 KjVfAq5whriYlcMrsXkVLrvjRfz2gS/Ku1JgVKoJ+M4ItYMoMAHEWj833Rzuwat/62MkV/zehlM
 L9jLRVOp8lM0X04IUZzyR7DBHW3JsgAis7Xs4JfV1j0QgXOCFEkwuiPCUe8jH5hGV8bX8+SqH6P
 6uYyN/hPwxp/ffOeT62pMf/C2SrjKhvr32k9y5Nag4wmVAMIwdxFQw+DEVXGtuiuGuPtiMM5BMA
 1IyEXracK8gJmrTmgpmyE/TCJ8YY8QM/MkptBHtJKjGKkDv8MsSHcQb1BuCf9tlGM6Nj2s0AyAK
 OJtMzQvx8iawLBRgdE4iHs4Cj42JO6N++7B5Lb3OfZalLhjQ==
X-Received: by 2002:ac8:5dd1:0:b0:509:965f:888f with SMTP id
 d75a77b69052e-50e3669f7a7mr531573841cf.0.1777127067118; 
 Sat, 25 Apr 2026 07:24:27 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:509:965f:888f with SMTP id
 d75a77b69052e-50e3669f7a7mr531573301cf.0.1777127066688; 
 Sat, 25 Apr 2026 07:24:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e1116sm6909552e87.54.2026.04.25.07.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 07:24:25 -0700 (PDT)
Date: Sat, 25 Apr 2026 17:24:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dennis Gilmore <dennis@ausil.us>, Heiko Stuebner <heiko@sntech.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] drm/bridge: simple: Add the Lontium LT8711UXD
 DP-to-HDMI bridge
Message-ID: <45evt7lkzuykoqsc2z27hsvm7fasmn6sr6gbjtdnme54jauehf@dmvon2o5emzd>
References: <20260425031011.2529364-1-dennis@ausil.us>
 <20260425031011.2529364-4-dennis@ausil.us>
 <20260425112844.GB2964234@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425112844.GB2964234@killaraus.ideasonboard.com>
X-Proofpoint-GUID: AoQPMMHsibWGNRVAB3Bll7VB3tvQKqSQ
X-Proofpoint-ORIG-GUID: AoQPMMHsibWGNRVAB3Bll7VB3tvQKqSQ
X-Authority-Analysis: v=2.4 cv=TuPWQjXh c=1 sm=1 tr=0 ts=69ecce9b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ssO-rxKZoUVbP6lRNB8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDE0NyBTYWx0ZWRfX/vsgToF/qw/R
 /JHWiTabhLe/iWGm+vP7VFtKTuSZWB0NQCYFXZbyU+EgnAJZXWg2eh4/ytQJ3bbGhk+WqI5Vccm
 hNbUb0hKDfbZuqsdJ+4EzItnESDkGnkBlW3xrOqkWvhQcUssci5qoWfa1J0J4euWoQPDcySfU28
 TEFmfWauZNN1tEBYhHpXtlAIdcK/Oz8WXCcLCk6pwExhrvoUlPyEoAXPYva2V3/KMHi0GE6sbAR
 EsP9pwpsCGkuG9qeKvfCQ2N/o/gQfaPEEMOOBGZX8fYNsZWY2quMtI6DP7tAmHtMS5YoMPseKbi
 jyIxcIoTpZcOCfZ5tmPWeDobMFL/11EO0V2yEAySTKWn9MNq+l6GovRV5wwXUzYNY3K0nbkr8wR
 Vd75o6q/QBR2vWe7mAOi0Vhf1+mvJV9UqjdbNqNa+ErZVHaVUjeMstIe1bJvKJx+Lxsd0ViwWUF
 nuh0CqzdtMveyBC6xMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250147
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

On Sat, Apr 25, 2026 at 02:28:44PM +0300, Laurent Pinchart wrote:
> Hi Dennis,
> 
> Thank you for the patch.
> 
> On Fri, Apr 24, 2026 at 10:10:08PM -0500, Dennis Gilmore wrote:
> > The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4
> > to HDMI2.0 converter, designed to connect a USB Type-C source or
> > a DP1.4 source to an HDMI2.0 sink.
> 
> As far as I can tell, the LT8711UXD has an I2C control interface.
> Shouldn't it be an I2C device ?

From the datasheet:

The device is capable of automatic operation which is
enabled by an integrated microprocessor that uses an
embedded SPI flash for firmware storage. System control
is also available through the use of a dedicated
configuration I2C slave interface.

My guess was that it can either be an I2C device or it can function as a
simple platdev with no I2C controls. Please correct me if my
understanding was wrong.

But now looking at the schematics, it seems to be connected to I2C6.
Which means that it should be desribed (and bound) as such.

> 
> > Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> > index 8aa31ca3c72d..42c1f3d5ba0c 100644
> > --- a/drivers/gpu/drm/bridge/simple-bridge.c
> > +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> > @@ -270,6 +270,11 @@ static const struct of_device_id simple_bridge_match[] = {
> >  		.data = &(const struct simple_bridge_info) {
> >  			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
> >  		},
> > +	}, {
> > +		.compatible = "lontium,lt8711uxd",
> > +		.data = &(const struct simple_bridge_info) {
> > +			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
> > +		},
> >  	}, {
> >  		.compatible = "parade,ps185hdm",
> >  		.data = &(const struct simple_bridge_info) {
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
With best wishes
Dmitry
