Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA833107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0743A10E008;
	Sat, 14 Mar 2026 01:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YR93oQ+W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frCMhbhb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE95A10E008
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:56:41 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DHimAJ1749278
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3rm7enm9nqUcIWJKNEewoyLg
 qNoJmjobC7Rx+fTbkBU=; b=YR93oQ+W1/suIy4ox4HKTqhU4NB8Jm7mpJvnfHrp
 NZlKLFcRsuDezsAiUwIOdHPG32XjeCaG/I9PwY3uQma1JdKc+5eLjYCTyjPqDnTc
 nMprcxKakt8RSlZFV5p0NhIKDFhEQFLvBnuC/2AWijSqlB5uuuUY1H7XJRyW/Neo
 iVJqlLtmU7ZmVgYZwzBqSULu91UqQyL4rtMPOxjxeLDqhdFhEuJ2gVq7YH/s1Xlv
 okwxnqmUl8gHR7qFtgeuDoEWar0+ktKm3X0LuF29noS2QQV9GQCDguhNjcOC7Jtd
 T2js4/TYddZWIbJZltE6fnQcluDM1dhVNubtT3FpxS7qUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvgj6jpd4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:56:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so1496213385a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773453400; x=1774058200;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3rm7enm9nqUcIWJKNEewoyLgqNoJmjobC7Rx+fTbkBU=;
 b=frCMhbhbbJysYCY6EJR6xRSwOlPbdU9py+6/mqDyMyCfGyVi0PuV758QJvQtI4uSV4
 L9c49qWl+MqXOpE+/eK6o6bOlQ2vRQBx6nt46l4SbFJimO/dZwMOFGXWRh8UxfTKWewK
 aZkxzVbrnSOnf/ce/BlplF2M0tw5sD+xFSym4QqcPQ6VwsgJrYkkIRbm5hTZ7Et1Q23j
 VYZw+tHS9ICbwu/1ZW1R19J/6muRVRC77U/tu5wup8it1wcau66T9s/pC0H357Z8b04y
 yb05US9u+L5TzFTRdLRou0WcuS2rbKk/4tkAwZGGOjBo3oJcRnKFbTQ6mr0Y1qlbj0cS
 1aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773453400; x=1774058200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rm7enm9nqUcIWJKNEewoyLgqNoJmjobC7Rx+fTbkBU=;
 b=PhG+vCImzdFquJRCFY8unOaxQD16QPGTCM80Ne3Sj2VgAp9rRQwCISkIUuvf4bMnNo
 /3bDEtkM8aWtWcMUqZ6YiznmR6th7cypT7uEw9psUKzzYKqbFzCoPZmYuqFnNTQr99tG
 CWFkd0OVulC5ksradpUJtlmRBuGarPyKThuNtrBcoEzretF6agoG5Yrsz7HlYdcFp8u0
 RlTHndAz5rfpJE1QdkQPx3CmPIXW9xRoAgGdcelCiLJaKEbhVxjcuynXJAOb0b3i1LCs
 3puKL0/Au+sn2K+590xZBd4hhSWvzXk+V6Dyfk1KMpIpv1dLIH6c7f7FrhJ9TNZjdON6
 I3+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWr80ODvDI62Ja5LpORu4Qge1Xt9v+vmm06oP1Vq6JBFU9H3OQxMl25iF1LYg3lMjhnVyMTYCUzXA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeD2QV5/y6X8598YXzgyJcWAnvaujPGWvvgcXFsLlZg/71uU0n
 vauQSo15+cFRgWhpc0cafA090tqG9K5/IgJ9+R8kCIcE85PT0q6L1qEyByt2g5TInWnhMDGUg3A
 3RHveFKpAYtt7CBHHDF/EM6apWkHRtKetpUQBkn6ltZER2/xLOa5WqVYM4YHxGgTVSbDkbI4=
X-Gm-Gg: ATEYQzx8Tn35+TVi1uCcRUYvgMRKD48pii1d/6XkXFV15ldv9nrc/ZoKQVAZQ442dt8
 PVs0Pyiw2dPY0xo4qJ+E1VURd/j0MnYcZVHGlKQp1Cqvpx96gN1tULwjjtyo2YseOdxz59GUVW0
 BMw7saaDa6tnyUhq8nTFp+8CF8zRP+4NgfwHNAH1fZifSegWFcB7MKtA901aj2xKi4i7igwobgM
 Qkfdj8/BAcDA/AM4A46OkqkOX3tC9aIrbco5H5Xo53hEfF1/EK+7L84zRV7BdKWMVlZrPMVqrwb
 xN4VUn2HIKM2xrqPoSl9xAylr6xcHb8pJsoOdqVuGVmyPEnxtFF3egJgnRh+bDl9g2UZUrElg8u
 iFbYD02c9p71v6wXDsQ1p2qTl+HRTxUuYYNsyEelTfHY0VpK9Jle2/lc/hALXRkn/1BDrZrN8xQ
 8HDcQn/m02oc8GhmhjlA2PW+gdfiJDISXUe+I=
X-Received: by 2002:a05:620a:2a11:b0:8cd:871c:909d with SMTP id
 af79cd13be357-8cdb5b5fc9emr763351085a.53.1773453400215; 
 Fri, 13 Mar 2026 18:56:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2a11:b0:8cd:871c:909d with SMTP id
 af79cd13be357-8cdb5b5fc9emr763349585a.53.1773453399752; 
 Fri, 13 Mar 2026 18:56:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156162b08sm1819956e87.53.2026.03.13.18.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:56:37 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:56:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pet Weng <pet.weng@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hermes Wu <hermes.Wu@ite.com.tw>, Kenneth Hung <kenneth.Hung@ite.com.tw>,
 Jau-chih Tseng <jau-chih.tseng@ite.com.tw>,
 Pin-yen Lin <treapking@google.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: Add ITE IT61620 MIPI DSI to HDMI
 bridge driver
Message-ID: <bif7vjwhaclrzbhmhq2u5a533w22fxex6tfgvcgy6sbms3dr2x@nrihumsnv2zc>
References: <20260313-it61620-0714-v7-0-36a16dc036d6@ite.com.tw>
 <20260313-it61620-0714-v7-2-36a16dc036d6@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-it61620-0714-v7-2-36a16dc036d6@ite.com.tw>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAxMyBTYWx0ZWRfX820iaZWmBNJR
 rUaR700YU9eidbWyQefGOdCC1hwkOlAC/QrQdeqABSYcE8dj8PTVNxxqt6vTAKjFn17eG8QSLpZ
 oV46m0pU/Cj6rxSbBYF3zmNm05FzNZr3rpBfUjlwNwW27TpsNmOirCpwsvFiHlOAHc0hHnhUS75
 hOA1SydK5e4jYcKajp7mLAZtASI3jSf6JASCUjuT3xcBh7Q49v4WCcpAyv8tDoSm62PljKXKhOF
 w4X7pjY6qsTdQHiZjwCsBEa2sP7B+2bpgFDWcC3GapsIN61zO0KShgAM7ldB1/I6ojnEiJ2JKJp
 84qZEghJsFTnqcL1PrU+AmCl8lmuWnmgwjXoaK7CY3z1tw4i7OuKrx8Gur+oM10hRvchrbBcKmW
 BYynla8Qq7e7R6USzLi75/iGkEJ+V/2y5q5C5uv/WUQtt2xbPsblMQKbrWfGOb3ii8rgYHMKMAT
 ioobKyTKRnHF7yvdGfQ==
X-Proofpoint-GUID: JVCuvkfZ5RP2lDYBpKNx3r3EWolxbTp_
X-Proofpoint-ORIG-GUID: JVCuvkfZ5RP2lDYBpKNx3r3EWolxbTp_
X-Authority-Analysis: v=2.4 cv=H+vWAuYi c=1 sm=1 tr=0 ts=69b4c059 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Ns9eNvu6AAAA:8
 a=EUspDBNiAAAA:8 a=D6ll9-fdZcolwGNgBd0A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140013
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

On Fri, Mar 13, 2026 at 02:48:16PM +0800, Pet Weng wrote:
> This adds support for the ITE IT61620 bridge chip which converts
> MIPI DSI input to HDMI output. The Driver implements the basic
> bridge functions and integrates with the DRM bridge and connector
> frameworks.
> 
> Supported features include:
> MIPI DSI input handling
> HDMI output setup
> Basic mode configuration
> I2C-based control and initialization
> HDCP 1.4 handling
> 
> HPD handling clarification:
> Although IT61620 has an HPD pin, hotplug detection is handled by the
> system connector. The bridge only receives HPD notifications, and the
> HPD pin is used solely for short pulses during HDCP authentication.
> Therefore, this bridge does not implement OP_HPD or OP_DETECT, as it
> does not originate or determine hotplug or connection status.
> 
> This driver will be used on platforms embedding the IT61620 for
> video output via HDMI from SoCs with MIPI DSI output.
> 
> Add a MAINTAINERS entry for the IT61620 bridge driver.
> 
> Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
> ---
>  MAINTAINERS                          |    7 +
>  drivers/gpu/drm/bridge/Kconfig       |   18 +
>  drivers/gpu/drm/bridge/Makefile      |    1 +
>  drivers/gpu/drm/bridge/ite-it61620.c | 2590 ++++++++++++++++++++++++++++++++++
>  4 files changed, 2616 insertions(+)
> 
> +
> +static void it61620_bridge_hdmi_audio_shutdown(struct drm_bridge *bridge,
> +					       struct drm_connector *connector)
> +{
> +	struct it61620 *it61620 = bridge_to_it61620(bridge);

Here should be a call to
drm_atomic_helper_connector_hdmi_clear_audio_infoframe().
It can be fixed while applying.

> +
> +	it61620_disable_audio(it61620);
> +}
> +

Other than that, LGTM.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
