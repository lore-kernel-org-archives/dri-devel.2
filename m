Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0A1C4452F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD7610E9DB;
	Tue, 21 Jul 2026 12:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gnfQvCm9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7gmjGzX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E95210E9DB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:38:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARJ1J1385792
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=oFR/ZjnA7aiJL98A84yTG7kq
 GldPgkhkZvdUyz39BOI=; b=gnfQvCm9rRhi5DfOsyPOt/sZRovX0OmiJZ9Ca8uA
 PVSuq1GPQzmsZsNPUDSxMIIFy0KVW7AhMNoLa5H6MVD7UgeFtV7s69HN+jgEGeU9
 TAGrZukdY/LP/0j4EQTDlO4zDWPSZ9ANatoz+SZSOlsMC7ympiKJB50l3pzcXTqV
 H2vaPizc7ezkXg/w/xmnOvqcMr2Eys+fo+UYP2IemJ98YfQmywaAer3+fiI1w28F
 Tj4KJK398lHxT1lW9BsNSl5TqBbJUQ6SmU7AwFMV864y+UoBhcelmpqcZHNQRAG7
 wyX+ACDz+xtvKL6NPvpN8FdOTGD6epWLwiMn03zRWxGwwQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se267c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:38:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso12251605a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784637489; x=1785242289;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oFR/ZjnA7aiJL98A84yTG7kqGldPgkhkZvdUyz39BOI=;
 b=F7gmjGzXHiNzWBGAfxZ9xJxAiNQpIqgzf6LLYXxAYuiVzHjucSGGwF5mNJayjm0RXI
 foP8JTL33JyN4ZqUrPoXKNtKvOdbRP9iXnITvydj1dByhLPEWN+66R+JF2hssS8kXtJB
 jkiJuNp/x0kQ5CpvFkVcZS2TUPxtaL9v5+Iv0isZkcswZ8KHuwzDmHY7UrVe+nksNMn3
 gvhIoDyZOMdm0i07tGW3B+XHe1du7A1lUgF5FWGVYVljnYmiOZHQH8KR4cojHvP5T3/S
 9PXxbRwNhaDJh1Zf5PTVJl3M3mpmnn2jvDtMljUoIoiHuBUEjsX1Mu1IUZphNGMJ32QG
 L/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637489; x=1785242289;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oFR/ZjnA7aiJL98A84yTG7kqGldPgkhkZvdUyz39BOI=;
 b=LzJTvAP1dZFwdQwtjNy3QTr/F0dexur4L/wdbDdAN1faBfG1PbLHz44637j4DpnNBd
 Dez5EZNiPi/nNhRzRpv33ZZFAwCoD9atDXM35mE/qzMbjaHX8f8jFgjmMTC7qvHC6dhi
 vQbgHwoESWqfXX0M8ErHF9CxHOB4XH9tnZt+VGmPE9NHJAV7PaMsmSqQGYlZnAaLkjh4
 0a46rDnPpkC657HOS1oN0022TO0LOBSQw7cyibHTrxS1vVNCWnnjZgxGqJC+fpsxsCI9
 EfqArhGMRDBF6GhzkAqwrQZYznse1M1ljWZHjeWRKApAdjQccMaiMQxAh5ROz1oWtiIs
 F7Yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rofue8TSuRu4IJKyAT2D6yukWZDm1C7IsIR5KZRmxbq/pdXG+CA+fTSDgOgQMcXIkefRVwPJRjauPQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDIcSgbuMI7BmZZJf+KyLF1BDW084x8IchqXp6AvMGVINh3HMM
 yU+LIaUHFPElMDN7SFm2RRdHgAmbBnw0+mAdHHRS8Q1+TOMPo1QW/h1jiNMXelbII8PXmQVvpm3
 GUsqUjFQKqU5+2y/PxFLcLdkZG1JA/7v7gmqU1PYFQB2H/WElwt6IkHnO1faawR0fDGcHTEY=
X-Gm-Gg: AR+sD13VIJ5A72+zeipqC83LXh4ggvFrcaApN1seI0a8RxPx9WmofF48IaDJ4lkPki4
 LdSv/WF/q11NDQBN2Oh0tGqv8xYvTxdDoheKZ1Tng/QEsgFC6IsKQeDqcPPO1gsOvvWkG4ZLDEU
 eVhHiefAkymLkOFf206nudR6oExkZir7iV1EYmHvtOtTi8wKqRVIP0tzKxPtgmFS1UszQ5NK0S+
 V8ycc9FWOUmR+SNRd3qqaQNdg98E2+q8Q4LxQHVQCAmClv+lY/UrxUxdGlB+r/UbfoXOAScTkyF
 3tFItkbSRZ2PYRgo1rZoWkqncEmQuD+9h3nMLXyugz8HY8CeVrdP9y8wYmb7Mp25Y881s1Erwga
 vsgexdAuc82tF7QXi5g3Jagxt/g==
X-Received: by 2002:a17:90b:258d:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-38e4b446c37mr16944612a91.14.1784637488720; 
 Tue, 21 Jul 2026 05:38:08 -0700 (PDT)
X-Received: by 2002:a17:90b:258d:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-38e4b446c37mr16944576a91.14.1784637488212; 
 Tue, 21 Jul 2026 05:38:08 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e9237cd97sm1576802a91.15.2026.07.21.05.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:38:07 -0700 (PDT)
Date: Tue, 21 Jul 2026 18:07:57 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>, y@hu-mdsor-hyd.qualcomm.com
Subject: Re: [PATCH v7 2/2] drm/bridge: Add Lontium LT9609C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <al9oJQfVo9XO7rAZ@hu-mdsor-hyd.qualcomm.com>
References: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
 <20260716-lt9611c-v7-v7-2-7553a14735fc@oss.qualcomm.com>
 <85505d92-ebe3-4ffd-84e1-8fe26994e053@kernel.org>
 <altfrJgx2IjO1g33@hu-mdsor-hyd.qualcomm.com>
 <767e5a58-3d2e-4f80-bb85-d300757a9dbc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767e5a58-3d2e-4f80-bb85-d300757a9dbc@kernel.org>
X-Proofpoint-ORIG-GUID: za3vaDjbZL1PDrdyalKOcobXippofO5_
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f6832 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=VwQbUJbxAAAA:8 a=EXFPzEZa-quHJTxolLAA:9
 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzNCBTYWx0ZWRfX64aGctvZm3cb
 p5HA4yhwphVRHH9kz1fgaj9oLHhHlMtxsRd/unvl1hQDV9Atw/9e6MptQc6ABO3wzugFw1oDaw1
 GK2TzRPHaEKHfpKVPNIs9Ih8+714Meg=
X-Proofpoint-GUID: za3vaDjbZL1PDrdyalKOcobXippofO5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzNCBTYWx0ZWRfX/S4D7XVbjIek
 W3h/+Es2DQToumXyH3Z1OiS8hLvsj4aSybynaPK7PVbJPdqNELd+PRV+0SO4vVOUgUybO5Jo31s
 4e/vQuOq5UguFMWIt9jRlX3TXIQXfWF6laycVrFXBvy65LBc+NsMywHtPj8qN+KFXChBBzANVr0
 0gBIzr7o8st20oyV9FQGjAsCp+utbNOwxWcCr6cbrpNrVzfCf2QLkHzR5vwT3NTd91WTmJREVGb
 DowZstgQ270zEvB6+r/QBw3YuSC27PwnAfkeqkHi7jfQ9TgR+sJlPJkyJmT7TUxWi0xVG3F8e8H
 tnCErqp1PDylFmLAvbO2Awe9rJ1C0he8kMraqHFLDyjLIxDi+R735k1LEsh8GHcePAkiq8E/al3
 IUxFgsLbMUNxIIBke6lwZOfHzKLmARqJYLB/gBA2PybpRBEhWht2d6zrRmu9DRy67JT6dixJHYA
 w3D9mFLrkO2gBd5W6eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210134
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

On Sat, Jul 18, 2026 at 05:55:18PM +0200, Krzysztof Kozlowski wrote:
> On 18/07/2026 13:12, Mohit Dsor wrote:
> > On Thu, Jul 16, 2026 at 02:56:02PM +0200, Krzysztof Kozlowski wrote:
> >> On 16/07/2026 13:31, mohit.dsor@oss.qualcomm.com wrote:
> >>> From: Sunyun Yang <syyang@lontium.com>
> >>>
> >>> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> >>> mipi dsi and output hdmi, differences in hardware features:
> >>> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> >>> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> >>> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> >>>
> >>> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> >>> Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> >>> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> >>> ---
> >>>  MAINTAINERS                              |    7 +
> >>>  drivers/gpu/drm/bridge/Kconfig           |   18 +
> >>>  drivers/gpu/drm/bridge/Makefile          |    1 +
> >>>  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1293 ++++++++++++++++++++++++++++++
> >>>  4 files changed, 1319 insertions(+)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 6dea93a41962..30be2eaf2bec 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -15184,6 +15184,13 @@ S:	Maintained
> >>>  F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
> >>>  F:	drivers/gpu/drm/bridge/lontium-lt8912b.c
> >>>  
> >>> +LONTIUM LT9611C MIPI DSI TO HDMI BRIDGE
> >>> +M:	Sunyun Yang <syyang@lontium.com>
> >>> +M:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> >>> +S:	Maintained
> >>> +F:	Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> >>> +F:	drivers/gpu/drm/bridge/lontium-lt9611c.c
> >>> +
> >>>  LOONGARCH
> >>>  M:	Huacai Chen <chenhuacai@kernel.org>
> >>>  R:	WANG Xuerui <kernel@xen0n.name>
> >>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> >>> index 4a57d49b4c6d..b8959b8e2ad0 100644
> >>> --- a/drivers/gpu/drm/bridge/Kconfig
> >>> +++ b/drivers/gpu/drm/bridge/Kconfig
> >>> @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
> >>>  	  HDMI signals
> >>>  	  Please say Y if you have such hardware.
> >>>  
> >>> +config DRM_LONTIUM_LT9611C
> >>> +	tristate "Lontium LT9611C DSI/HDMI bridge"
> >>> +	select SND_SOC_HDMI_CODEC if SND_SOC
> >>> +	depends on OF
> >>> +	select CRC8
> >>> +	select FW_LOADER
> >>> +	select DRM_PANEL_BRIDGE
> >>> +	select DRM_KMS_HELPER
> >>> +	select DRM_MIPI_DSI
> >>> +	select DRM_DISPLAY_HELPER
> >>> +	select DRM_DISPLAY_HDMI_STATE_HELPER
> >>> +	select REGMAP_I2C
> >>> +	help
> >>> +	  Driver for Lontium DSI to HDMI bridge
> >>> +	  chip driver that converts dual DSI and I2S to
> >>> +	  HDMI signals
> >>> +	  Please say Y if you have such hardware.
> >>
> >> Please wrap the code to appropriate limits.
> > I checked the others in Kconfigs they appear to be similar,
> > still i will try to fix it.
> 
> This is nowhere close to the limit expressed by coding style.
I will fix this.
> 
> Best regards,
> Krzysztof
