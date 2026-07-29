Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAADC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B7910E61A;
	Wed, 29 Jul 2026 02:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UPyvFKcY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDIwjZqk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EA710E61A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:06:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T1Gq3Q088934
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4mbCM/VAzhxwI20/V1g/VuFFjGNJdfpASrzSVi3V5o=; b=UPyvFKcYNKRglQyb
 qkgsxTlrnuBQNu+lnnlgHJQU928VoLXWqj2a1cXUwSFPiYbylDmorAq9pT7VUJl9
 /HD1dYO5VsiQ8rxPaVo+Iqax94MTXH2PztUz3R/whkfW+vIGhAKAf4IC9KX/zzlX
 S8lc2RzFtpbncspyRIAZIZnLp121hcrL5QFIlXxo56TBjKEP7RFqbJlyu0X1L8jh
 eZsfRZPNX3YoHqV3yeHaFVHDQo52GzUGMm27btJDkTHnomTH4rVP0ugGdYlmbxR7
 qPRJx2Jty4OVUfwXRDO0bNzTSzLHyixrP6WxX2P5Eg71YNv7FA402txK5d/Z/4/q
 G2tvAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpvd3kfhw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:06:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso4186381cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 19:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785290802; x=1785895602;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T4mbCM/VAzhxwI20/V1g/VuFFjGNJdfpASrzSVi3V5o=;
 b=PDIwjZqk+ar2eMv/XAuY84zhW2BkWqa6KjyUolQPodr+58kzjrnJJGOzNa9sxaVC0q
 qgG5hkvOAGyu4dqMkGIq21A+F1Ma+4/r+77aoQQsxRj5Lq00TvOY9vOEas/nP6s+RF8F
 YeyhTxLruqNTXq1uK2vuJysjklo83PpEnUEcmD1FGrJTvXujVAaNset6y59enkHCX0Dl
 CJ2Kx30GbXvWN329Edr5rEQPxEJSREr1wgVuWcgCKf17qz5ooCkcifsTjgCTflQNoe7e
 H2oY7aX5YxXIEEx082Ta/BJJNK5ygXzgL6xYRq2yYxQJs699b2jpiIiSJOPXxA6Iojqn
 IhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785290802; x=1785895602;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T4mbCM/VAzhxwI20/V1g/VuFFjGNJdfpASrzSVi3V5o=;
 b=MQHPdJ41LKdj+ePmSv+maZx975rkU7Fjq4GglkbN+cVYkueDT1pb0iZEx2UbJeWGcC
 1LAbUxGz5cM2E9yMIf+TdX4ddelii4U4HDPl1bGDialj9U0BEPVmFPiEaZ2eXFfiazrg
 P+ldqEW8E+E4tTZ1dBI12YKCIQ8358DEa95asf1WlWejy9R7DPjFqCQ9XZ7Z12tWrHWn
 16m8gyVYDTbee5JWEN4qODFojFS7OXWa3BQbYLkz6CFl4qXnruKfL3mdnp37lo5Ep2CN
 adUzDph6WBBfT92IjFoEQQs3OhCZQJrwxxcR3UxOut+Gacbh2d6dedZhXA1GYjv3b8Oo
 vZHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtFtWKwOz+FbSvVLadY+h6RWTnRNf2KU555FK6av5Pa3tuLSxO4aCU9QdkPBlODi6rojgEN/afK2Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxaDcKAmWb0G3jFDIiGdx10NvE0oTbAREsRC+h+fxGYAlQ4uA5
 MsUEesW2dHDgVNqtythyGTNlgyGOxKss+/ZCZOZq+vvOaJhdr6mZPK/kysP9nUgATQtYYdMcMbn
 7qGXZm276lxKhGR1Q8XsrgNXV/EWcPnpo7tXfSSAPuUzdSB+aLxZhD+rFMjb6P/ANN3r/LJk=
X-Gm-Gg: AR+sD13O2BMNzWukLAbOR9vG/eIUCV9AZH2jaS1BnE1RHzbYowKh60h/NJoH7zRfP5z
 CdJ54vl8IEcCnnmC4GZaVJdl7g2yNqWe1HYckiMnQDBZ6Ds5gcqyEsfoSUPhuepExHz9570Ne/L
 0qQ2NMJ+zKPFU/iPiL+W8qPHapEVUqil8eQ7cOoCVPrNWQCIIBXc1GLs3MNiG5zMFSYn8bLb4yn
 nc1ypA8r6lh1qQCQm0GEhAmH1hrB54PZHImCA7ospm9SqmU3kwd9uaHmdZ82ppdkoE0GbZRK8az
 RC1So85xEcrOTlnOPn+qiaDPO/FNvOlw7pssV0bWxsb0zSQWKTcbgZoZRXnJ0E+QN1hewbZRWlJ
 qFWyZriAF2sI3fOMaVvvEoJaXTF3/3OCHaW/GJpP8+aROkUNz5g4+fhqtIjSWZFzFTaYMU6XY1X
 /vKk2gpmBTtBGA/Q==
X-Received: by 2002:a05:622a:2605:b0:51e:aa39:4fc0 with SMTP id
 d75a77b69052e-52b2aeaf718mr3295931cf.42.1785290802128; 
 Tue, 28 Jul 2026 19:06:42 -0700 (PDT)
X-Received: by 2002:a05:622a:2605:b0:51e:aa39:4fc0 with SMTP id
 d75a77b69052e-52b2aeaf718mr3295671cf.42.1785290801689; 
 Tue, 28 Jul 2026 19:06:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2d76a36a0sm139647e87.24.2026.07.28.19.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 19:06:39 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:06:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: mohit.dsor@oss.qualcomm.com
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
 Jessica Zhang <jesszhan0024@gmail.com>, Mohit Dsor <mdsor@oss.qualcomm.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
Message-ID: <pxwcan2yajuvt44vgb5ijfgimowu2odcisxpp4tuhkzyk325jk@koxmaj7jwbnu>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
 <20260728-lt9611c-v7-v8-1-bda216bfaf37@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728-lt9611c-v7-v8-1-bda216bfaf37@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAxNCBTYWx0ZWRfXyHr5ztg3jpGo
 VO7ITz6WHP9moTOqXWO1/ZuRhcUu5eDQTkUkUBR1nI0GoNJxyczPFRMEBqodP8pdrw0oz8Ja9sr
 RYc7s3rRckr3Fo1SotWMqpKlyZ4rqNk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAxNCBTYWx0ZWRfX+hZBo1kLTnWd
 pAfFLSUlcw/+PArtWAzecC+0WSBqo1awIZolsrW8OMOEoN7+6mYV7Vxbylfx4IzgLbIeQLD6rP+
 iN7SptAmQTvbOXyo63WsqnKQYiKWa5+rJI7oUkSQLW/ow+ZXFkyma6+R2zpCuHcpC/3VGHPQYHe
 o/fNpabzo4BJILwVeyYsrct80j7BFfS6wcwjNfRVJI/c+75+LUWjAnVKXhuxnuqFhh3bigobY9S
 CcTTU+KtEpK1BIl5adsiZ0UzKUP5fwfSNv2mUwschCpzuh7E5VYJ013rGq+5FU0LAhkt50eGXFj
 aPRgy5m/fM3n5ExE4Q1i6+oVfar6XhmvWiRzMpOQSVsS8ao568OLegJD0h3bE5jdFuXnrZ3J3hO
 YGQJZQoNyZFWXBDHzEoqG8xivHa/OqaXGhVdOHPkNoYvpDGkm764vFLSyecYFpZqD40ewkaXjxA
 DEv+gVONSS5m9bfz+OQ==
X-Authority-Analysis: v=2.4 cv=SqegLvO0 c=1 sm=1 tr=0 ts=6a696033 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=VwQbUJbxAAAA:8 a=tsJPPiT7vvoKamjX9h4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: U5CqdBYcCkfCBTQJaGmNC7oWkUGf6wYw
X-Proofpoint-GUID: U5CqdBYcCkfCBTQJaGmNC7oWkUGf6wYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_01,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290014
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

On Tue, Jul 28, 2026 at 04:39:18PM +0530, mohit.dsor@oss.qualcomm.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> Signed-off-by: Mohit Dsor <mdsor@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/bridge/lontium,lt9611.yaml        | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> index 429a06057ae8..e0821a63d9d7 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> @@ -4,19 +4,23 @@
>  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
>  
>  maintainers:
>    - Vinod Koul <vkoul@kernel.org>
>  
>  description: |
> -  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
> +  The LT9611、LT9611UXC、LT9611C、LT9611EX and LT9611UXD

Fix commas

> +  are bridge devices which convert DSI to HDMI
>  
>  properties:
>    compatible:
>      enum:
>        - lontium,lt9611
> +      - lontium,lt9611c
> +      - lontium,lt9611ex
>        - lontium,lt9611uxc
> +      - lontium,lt9611uxd
>  
>    reg:
>      maxItems: 1
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
