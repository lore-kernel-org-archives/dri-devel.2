Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEC9C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4625710E3ED;
	Fri, 26 Jun 2026 20:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGbJOmge";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cf5kErhz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32B610E3ED
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:31:02 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8gdn1682078
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PHYL2A6nokSiemHyzYG1DAUi
 B3KVWxjzt9EocyyxjPI=; b=iGbJOmgeUyWiKlQmFZO+wxQv/Ax7MtUjEmAUB63s
 S2mR+IaIququbEfULNp8u6e6sACCt7kWYklKWyh8x9ZZBjSDvBBBsP762r8pNPTT
 9+dWKJDDWApW1yfLsBKWjiwGa9/1eINIB/WAK1b8Ya3bG/ii/OBfTOpeOSX/+7gM
 W/TXPy0T8KCiSR2SMq7NArAg/V7Ocu6aAM0ZwAz5jM4dmsESwymWKKMPrLnXuofd
 V5ZfKdJJX2CR4uIcH163vdtXjnw/EsrRaYRTsJ9Mlf5RmAYHNxg9t12qpDGcgKw/
 0GtwRiyyJzLZjF1N60RCEgP0LyBBl/hyAzg9rFt6EAJQkg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fgdv4ku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:31:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ad11e2197so189997185a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782505861; x=1783110661;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PHYL2A6nokSiemHyzYG1DAUiB3KVWxjzt9EocyyxjPI=;
 b=cf5kErhzGUnC2r72tmkqN361fTXYjhe0cnounZLtCrxo90G6Wcv1BsQrmoeFInuMfJ
 tW5/r4VbNmdbhc+f2zUCQrf3u0QKN4z0Vs/KgduPGKDLNwNc2y3J5xux0G/J4qo5zOm1
 i7obDqz5lKJVBL/vYV5nwD3KXiAXKMiSqRap4uPr0MeCllCSMmdXJ5ePVVT6or21usdH
 vhYR5zMizgXdzWpdYwYgvddAZxu8an9TN/uNEdB/MTB6IWurymGlvFup7yW5KCzR9cqy
 UnXxtuNQ3QRxEgfNWPzKyvWHq1BiD3dGEfvJgKkzFYV4D57RNqZ7K7J/5MGIkVGwyNUL
 0mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782505861; x=1783110661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PHYL2A6nokSiemHyzYG1DAUiB3KVWxjzt9EocyyxjPI=;
 b=gKzQp4DEiWBQcMQbq0S8wVU4TnqRBWbOyTY9wh704BP026CSEcKOgb1VDlEhKWuGMq
 8ngJavt2KwhzEpcw9HHnu37kguZEOT2YHFj/f3u9fJkpZUOF6rjGuZURyKUlP1Y3z092
 vcSSj4mbLlG6sWbPbaXJDT+ESpG0tk3CZWIDbtAdvN1i6DJ4LQmxei2P9Cbb9OXtLdJi
 p8EFDqVfPTHvYcCoj5c+B3SJ3G3W7epHsqoygDqo+GXGBfDYetqL/rUUH8c1YYEOH4pM
 rcRC10VJjN+Ph005SdbI5KOoorQK8MYqOpcTlQugxNNgsY1+US2n+53OnWdvGowE6tRh
 wu8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WljKbMyztFc1s55Xwa/wAuor6sCl9aGzdJolAzOqM3JfpJiCJtFwSlHD/nGXq00sO/Mici1mCbfk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM6BTo4DsdbL5bMprHImykvHtn7jBVS/y/0JB4o0uJ73WlJxS2
 Yiy4K4Kpd5JVX3tjanBHuNXj7Xpzf1FFcBa3rbEJdZbCaLVuX3KjKDvbVRxuqg4Deq/DnBLskQY
 UPI/2n3lcbzHpKmFwWvmmz5q/RZ08P7MkHkn7+cu5Y3tOMABRdrxWiCy2z4/ydVXEgyUFszM=
X-Gm-Gg: AfdE7clM9wUKuQc2r5115ds4ci90QwxNGN11nn1i523wyYViD8rL4XvXz+1uyhhodd2
 FA5R9ppBkDlh2lHbs3T4Kgo/dKn8FVSD8Oii9oJ9lfZXRZxTUSqtMidi0AFQ64rL2agqh69wFgx
 cW5tYKAF+TcIHq3BP0ByTqu9L2YcpJnsLQP5StdUpuNOjRIjHiB0Cd2p8cQDuo7pHY4KmiNsci0
 uFh0Bqu3lk9fbTiGKUpngDwylHHVNVyhSy6paQM6av3MNPb6FpNYLgsc1wpLaRJTGK6/vipOF+1
 fWvMJ1Z0HiHSULKyuxYzlRM351oGol87k0VzX0s5ZKu3szQAGIJR+IH1+dumPIB27TjNCrXorVy
 UXvJDNVIQ3EWbahzAbxY6ON+v6IfdM/m49uuato7I7EpBZjn95q5jJtK/vD/9UQIYlQokSzaEYJ
 tknwM9gwzImb84CEDXgJTMJLLJ
X-Received: by 2002:a05:620a:2856:b0:915:c858:7d3f with SMTP id
 af79cd13be357-9293bc40607mr1376499985a.19.1782505861059; 
 Fri, 26 Jun 2026 13:31:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2856:b0:915:c858:7d3f with SMTP id
 af79cd13be357-9293bc40607mr1376492285a.19.1782505860521; 
 Fri, 26 Jun 2026 13:31:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad69580fcbsm3760781e87.67.2026.06.26.13.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 13:30:58 -0700 (PDT)
Date: Fri, 26 Jun 2026 23:30:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: Re: [PATCH 3/4] drm-bridge: lontium lt9611c: fixes and improvements
Message-ID: <a64pcvbmkkszgnokarsig5gyanviqcvdxhbknkfciylpuein4u@xmn6znafguxh>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
 <20260611-lt9611-b4-send-v1-3-42abbcd3bb1e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-lt9611-b4-send-v1-3-42abbcd3bb1e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=API5kwXb c=1 sm=1 tr=0 ts=6a3ee186 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=IqmewEwAU6YGb8l4mAwA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE2OSBTYWx0ZWRfX+OphUlFivl8t
 lVAYvkAe0YNdcbx9VezGCOhzKP2MahW/OrhEFuXoeJ/vKJx0OF+GipWKfAk4dLygBGpo723wx1G
 3cnlimOFwpPiQInVlKoIA0tYusNU1VhiG1+YRArzCsUFeOBikGngFP3MSItIQ2OtvrmP9fS5Pes
 xDlWXtJroymRuckPE4I/Pr7X3ppMmkqlyjzdSFchg+nYVGaQvziV/rCiqv1Ds4imwtykFvHwfru
 Tk3/WwxeWcrMslRbjcoVlAfNa2wVoAr5DtnYRcHyfQ5QDPTM3GWHigbj6+Ugxb9rVSGPTmAm1T0
 eQmqaRn60yIFPuj+t0CjooUQGPgy9BWW4zKEyMhseTIRRlDmaL4SNdXDJf7fsUu1gRvG0wyTd3O
 g8n6YmoDj2T686Sz/2H7HW4XOEY2a9pW2Lh/LxTow2aNwB03/qvQSuJEuKbYoUYDKqIKoi8LfRz
 GpjkKxeJry42UW4/Pzg==
X-Proofpoint-ORIG-GUID: BBK6BcUjV3TbprWDx1PbQvihCq6vjTo-
X-Proofpoint-GUID: BBK6BcUjV3TbprWDx1PbQvihCq6vjTo-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE2OSBTYWx0ZWRfX/OeNf2sk3Rxm
 derrqKzA5rRCbgAODjzfcVYqzO7Q6breIdTQML5Wd+ECIo6KiZfCWCrd+eQbBoKW/2KvZ9KP/qK
 hAKaQgnlsfzF0w382ICuUNRNv0df7j8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260169
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

On Thu, Jun 11, 2026 at 02:44:58AM +0530, Mohit Dsor wrote:
> Remove two redundant lt9611c_reset() calls:
> 
> 1. In lt9611c_bridge_atomic_pre_enable(): a reset is already performed
>    during probe and resume; calling it again on every display enable
>    adds ~440ms of unnecessary latency.
> 
> 2. At the end of lt9611c_probe(): a reset was already performed earlier
>    in probe before lt9611c_lock(). The second reset is redundant.
> 
> Also, the DRM HDMI bridge framework requires hdmi_write_hdmi_infoframe and
> hdmi_clear_hdmi_infoframe callbacks for HDMI vendor-specific infoframe
> (VSI) support, used for features such as HDR metadata signalling.
> 
> This patch add stub implementations that return success. Wire them into the bridge
> function table.
> 
> Also, Store the chip variant enum value in the of_match_table .data field and
> retrieve it via of_device_get_match_data() when probing from a DT node.
> Fall back to i2c_device_id.driver_data for non-DT (e.g. ACPI) probe
> paths.
> 
> This is the standard kernel pattern for passing per-compatible data
> through the OF match table, and avoids relying solely on the I2C device
> ID table for chip type detection when DT is available.
> 
> Populate bridge.vendor and bridge.product so the DRM HDMI framework can
> report the correct manufacturer and product name in the HDMI connector
> properties (visible via xrandr --prop and related sysfs entries).

I was going to write that this should be split into several commits, but
then... I stumbled upon a fact that the driver is not a part of the
drm-misc. So, instead of posting an update for the not-yet-merged
driver, please post new iteration of the LT9611C series. Don't forget to
drop the R-B tags where applicable.

> 
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611c.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> index b0402726367e..fe51f4978546 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> @@ -622,7 +622,6 @@ static void lt9611c_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
>  	if (ret)
>  		dev_err(lt9611c->dev, "regulator bulk enable failed.\n");
> -	lt9611c_reset(lt9611c);
>  }
>  
>  static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
> @@ -777,6 +776,17 @@ static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
>  	return 0;
>  }
>  
> +static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
> +					     const u8 *buffer, size_t len)
> +{
> +	return 0;
> +}
> +
> +static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
> +{
> +	return 0;
> +}

Definite NAK. The purpose of the callbacks is to write the infoframe.
Purpose of the check in the DRM framework is to ensure that the frame is
actually written. Please work with Lontium and find a way to write HDMI
/ HVS, SPD and HDR infoframes.

> +
>  static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
>  					      const u8 *buffer, size_t len)
>  {
> @@ -895,6 +905,8 @@ static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
>  	.hdmi_tmds_char_rate_valid = lt9611c_hdmi_tmds_char_rate_valid,
>  	.hdmi_write_avi_infoframe = lt9611c_hdmi_write_avi_infoframe,
>  	.hdmi_clear_avi_infoframe = lt9611c_hdmi_clear_avi_infoframe,
> +	.hdmi_write_hdmi_infoframe = lt9611c_hdmi_write_hdmi_infoframe,
> +	.hdmi_clear_hdmi_infoframe = lt9611c_hdmi_clear_hdmi_infoframe,
>  	.hdmi_write_audio_infoframe = lt9611c_hdmi_write_audio_infoframe,
>  	.hdmi_clear_audio_infoframe = lt9611c_hdmi_clear_audio_infoframe,
>  
> @@ -1025,6 +1037,13 @@ static int lt9611c_probe(struct i2c_client *client)
>  	lt9611c->dev = dev;
>  	lt9611c->client = client;
>  	lt9611c->chip_type = id->driver_data;
> +
> +	if (dev->of_node) {
> +		lt9611c->chip_type = (uintptr_t)of_device_get_match_data(dev);
> +	} else {
> +		lt9611c->chip_type = id->driver_data;
> +	}

Use i2c_get_match_data(). But, also, why? The driver will likely not
work w/o the OF in place, there is little point in doing something else.

> +
>  	ret = devm_mutex_init(dev, &lt9611c->ocm_lock);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to init mutex\n");

-- 
With best wishes
Dmitry
