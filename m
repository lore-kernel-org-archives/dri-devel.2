Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38331CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA3A10E132;
	Wed, 20 May 2026 13:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V1LiJLbT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DQOEr5Ca";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A6010E0F5
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:04:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCnfZ31237947
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kpTG2ueCP7uKXj2aLZqi4ovU
 YrM7cSBV0BgwJSqxzwc=; b=V1LiJLbTqPYTUwTneVZ2/bD4/eI/jNZYROYPYJl7
 24ogz0cLpsxdggcqr7bE2z6EXcV3+AaYa5+J9efjYu1tUvbMv0AnuUPYgSsCV5YR
 pe7lD+7TITnprsJNWZYYwDAxor45/PlCaZkDlg20RzC5pRl6KdbsjOc0KCd0fDhn
 UfXvG+5TyNqnDi/ZJ8HyoOHMiskyOJOV2dVVD8ywNi3vS3Z0N0inWTg1key2QqJZ
 3hZnWmWB9D19O/Kz2ZqopTq8uoFJxEHAfbYdIb3EEerOGYu1A6BO6uWLMuzn7fnz
 b5WDRIMaFwOeFYzVOBSVNk2WQ8Wl3uk26MwIUnnmVXp29Q==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3svw5e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:04:45 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7dce1e67fccso8073893a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779282285; x=1779887085;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kpTG2ueCP7uKXj2aLZqi4ovUYrM7cSBV0BgwJSqxzwc=;
 b=DQOEr5CaZv7FEI0S8qcIHiKJciZfpg87rRQp2x1X9mNUz+jGYDxQExw704qbps5vy/
 IYeC2zE2JCKK+fHKgExMVrSnqM6xsnZarRiaqifOqDmDsrxDsUVgV7WDMQPMDC1U3NHk
 e14hJ2+mwXLdBcs1p7ZbBoI/Srl/cFNwzZGjL1+RecU34i/HAwWR3ZbSqebjDFv8ushj
 SmdkKZjB/VbYPnCcNCNT4d00Lh/onHbz0fBWs29GJN+NOq/LIuXVYZNg7XbtcKkcLGYj
 MF+00ZWebchD8kiOPZqF1Egbi3hueDGChbdFlxeuiyKnRAW9hCVPvYr+TYPiU2pOU9to
 6smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282285; x=1779887085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpTG2ueCP7uKXj2aLZqi4ovUYrM7cSBV0BgwJSqxzwc=;
 b=MaoHceYieICyZM4ysmxcawS0ZHT+q6yosx5wVBrMRc3owG/kfy7Uyhwd4BPUDtVWi3
 pYNGyeG/VTxCDNI8Q39zetj0QWcpufKIrgqPLNbMpQlH38PzdYL9ij7MVSmQpx4oEMeq
 u7c8V1gXsrpdFyqJwcGFgx7XNfypHG6rf21X+w70zHlF7a9SsI9u8G4/i3hpqHCV2mUw
 D2CQ36PyE5M4tg0h3Z7B/IlAyXtCl4XW8P3aNZbfiDiZ52VlUl3PKPXlHwlwGIp3CEst
 4QRb1aMUIrc1xmYx6sau6oVtHunCwzHhFNMWB1wzWrQR4BwFaLFspxTDwfF+eBKHpAyi
 JSCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JdLv/rYfnlbmzPeDERQLzjrdXQkKBCSdAf994fUj8CxwEYB347oX4v6w5ovL2dRmhxpWQv5JB97g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzh9gc0FmoyzqEkFI1FGxEEDtyFKxDnaNI2sCFhw2mB6erZcVO4
 i2F54otxdXPjfEm5+KmXGfaiW1rsEbpJGxPpfHh4Ss3dzPe82Mq+0GmdTyu0xjKJ7xm+qni82iJ
 e1xQZ7DtCRG4uc7k05rYRt4sRZMMzkJHBAenYmH4Rx/ayEre8Vl4fcoOnnC+19xYlRJ8tfjw=
X-Gm-Gg: Acq92OFaWVUqVv0wlPUHfJRyUmfCzVME1Br6jXqQkJK85AdTRzbKGKM9mhK5ZYOFaHN
 c3I9OwqFAqk8ogWLdK/1TcxtCGailtqN95ximQ6lyca15Ql6QSegEhDgsxTt1T05yum/be492AY
 pNjl+ocQttJtKR1KAQWjWavOaymDqszI8X0kWL22PwFoagGkD5FAMLoPBibUbXuIMyc6Eu5/wke
 fubp33U1DzlsmTQE2BCX76L+X1sgbH8PB+0npXRGImjZnKnL+hEKh800myJekDIYZT52E4P5o3m
 wCCUhWeK6bpjKEoz/uKf0I9fEJdMq5kXUeS1xoiitA39MGJ3I1UWXBJNj/+bziYtFBqawc6mrwf
 Fnj3InkRF8wQlyDxiIFPFn49v78+Qwv13ty3rti4APjRM2ZZdfCya9s7Knkp2nI3hqxp9GJMRcY
 2iMm8P+dn8xwyHsCgLJGRdsx9fnwB6sYykg/Q=
X-Received: by 2002:a05:6830:6d0e:b0:7d7:d100:2613 with SMTP id
 46e09a7af769-7e4ea03bfb3mr14892440a34.1.1779282284782; 
 Wed, 20 May 2026 06:04:44 -0700 (PDT)
X-Received: by 2002:a05:6830:6d0e:b0:7d7:d100:2613 with SMTP id
 46e09a7af769-7e4ea03bfb3mr14892372a34.1.1779282284298; 
 Wed, 20 May 2026 06:04:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395887b3c3esm30377451fa.34.2026.05.20.06.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:04:43 -0700 (PDT)
Date: Wed, 20 May 2026 16:04:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: John Harrison <John.Harrison@igalia.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 0/8] drm: writeback: clean up writeback connector
 initialization
Message-ID: <wcgvogluzfrjk6rlomswkmqceilbbichxsgx3aqzpoawe7jzgw@uiy3ogtswflk>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <177894506978.2448625.17152574519326512949.b4-ty@b4>
 <8fc45730-b2e3-4ba8-b80a-9b30557e810b@Igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc45730-b2e3-4ba8-b80a-9b30557e810b@Igalia.com>
X-Proofpoint-GUID: cPwKHdh-cGV3zhkWrp7T3Y67ghfa_L_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyNiBTYWx0ZWRfX48dzwsHSfUT9
 XYu7DnH9wY261zIlFQfyIqTjo5yc5kyaItWj/GyZZ59MS++K3ZjkhtVsTQX0emiyr1sHvGyA4/3
 a/7e9vj1oTjIrOran5PHvjnv9zPGWYjbeINZcw/BF482CO2IySHMplNjl55i3K2+9gCOzthvAuC
 Fu3XwTHFU87Kf4gOd+iVVpslEmQ2qT4HaARFxJ5GMh0Lr3rxFGtQXBiHdjgr8DNk1c1ImOCOpRx
 8K06X9JLTLW3zjiQj+xpd2mcYlsjM+RTfBHF7zbhPW4Jhi8CTjZtAcNNf0sSYCpZxQg8NBbF1Y8
 sIwfTtx8XJhrgGx+YMkMiNhS73gqMnWdT++BWaqKktbneYlTkpr6CeifBRVTdYblNky2kgxH993
 2X7hAjIq8Rhha6ZkjX1TycJiZew2BgNTBw2zOifqhcz2V2cNqBjFzMdTr8vSOdT8L2DRN6Sgpre
 +yEKla/kE67tpoDVGGg==
X-Proofpoint-ORIG-GUID: cPwKHdh-cGV3zhkWrp7T3Y67ghfa_L_I
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0db16d cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=JYzImek8qnKDYlgmmesA:9 a=CjuIK1q_8ugA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200126
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

On Tue, May 19, 2026 at 09:59:00AM -0700, John Harrison wrote:
> On 5/16/26 08:25, Dmitry Baryshkov wrote:
> > On Tue, 05 May 2026 03:24:57 +0300, Dmitry Baryshkov wrote:
> > > Drivers using drm_writeback_connector_init() / _with_encoder() don't
> > > perform cleanup in a manner similar to drmm_writeback_connector_init()
> > > (see drm_writeback_connector_cleanup()). Migrate all existing drivers
> > > to use drmm_writeback_connector_init(), drop
> > > drm_writeback_connector_init() and drm_writeback_connector::encoder
> > > (it's unused afterwards).
> > > 
> > > [...]
> > Applied to msm-fixes, thanks!
> > 
> > [1/8] drm/msm/dpu: don't mix devm and drmm functions
> >        https://gitlab.freedesktop.org/lumag/msm/-/commit/c0c70a11365c
> > 
> > Best regards,
> That is only the first patch of the series, yes?

Yes, correct.

> 
> What is happening with the rest? Can they all be merged to drm-next now? As
> I understand it, only the first patch was still being discussed, the others
> have all been reviewed some time ago.

At least we need an ack from the AMD maintainers. I can pick up patches
3-6 to drm-misc-next, but it doesn't really help because the rest of the
patches are blocked by the AMD change.

-- 
With best wishes
Dmitry
