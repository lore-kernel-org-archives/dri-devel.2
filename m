Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACB5CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769C510E65F;
	Mon, 22 Jun 2026 12:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EYyjg16p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fTr7OJyx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CD610E65F
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:01:48 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAnGPo380997
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wLg98q58XffM+jX/2zG7PwjP
 TKcG9BHbX0CTkaDmaTw=; b=EYyjg16pIRKO4mH5JpZt4gpxoDvkygXDItJBkS3s
 I1Eg3Vm2PlHrh355jSNb2bjm5519ry4zClClNFaQBdlOT3o/NnFcdotHo+MMHpbc
 Y8WWPfIpHuDPICKZuilIivlxs3Kr1UKaw4WHo0pZBpjqJ6a+FNahQnXsDbEkblTl
 EpReYUFYhMIylQ+3YdSb8aas2pKHnuPQK/1vPjSWNvnWcbDgPYx6WQDzq6Ci4Ktt
 lYu4cfynSt/1g8jFrfSaFI8pImvkUBOm8utL/p+ELD/14gPZF4MtcutOUUSrU8gw
 UCm+OXaNEqC9rtNBOQekhg+z3yl9TqNU/EK7YUEiiAGzVg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0r9f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:01:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8c7f6c6069so867536a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 05:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782129707; x=1782734507;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wLg98q58XffM+jX/2zG7PwjPTKcG9BHbX0CTkaDmaTw=;
 b=fTr7OJyxLqM5GE0kwOn4YvRTm6up7BGI+k9p4errLQZQ5WbuI5/lfYbgepm5S/jBny
 WGXe82TzMHlMNBDW/kc/IX5EQUCLOk90iaBpAUtvQ1846mQXFjJSoIROQ6jWkQarZqaU
 Dl+yAQtwCtzhlq1Bl5ZNbnYmMxv11uyRfGKUWKspKnp3RQMhPUDKZhblmwykGpDAScCh
 zM54pqwfB+/qEzfyTKN45Tnn3tqmIyguRNBJapkvi4ih7NWQIrTb7Q62SuTkxOu+3aXd
 PczU5fZjEq7B9bJgikIjCCH7/aY9VNho/BkI3H1IqH/bF4cg02dtzmFBie3DctiC6Eco
 y80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782129707; x=1782734507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLg98q58XffM+jX/2zG7PwjPTKcG9BHbX0CTkaDmaTw=;
 b=L84CP8gnITiKhVAJdiNXqBQHN33V9XBLUmbO7I9mCRR008HhIJh7/HhFQhI0JMoqOM
 10hj8CDLPZ7Nxs8S4CZ0BxB+ZTRGmEDY2Ku2jRXVtpeA28R0a9F/j/kvMePXcQPefiGW
 7dLb42poDmKIis8XOjB4T81bPOcf9uW8enHeCTvtb5fv7IdjXXVeuWltknopSClOMoCV
 ymzy2Ud3BrScki9mmjTXy/bjUr6+aAR6zyqd2J2rou7gKfJdaf7e45CkhJlYesPAD9ca
 Tdqs4zjr3JgMbLxDRuNt5O0lnjH8LlP0EV7NdTYTxASXgRy2faN+mb4uQg+NEyrf+unH
 KXog==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BnOYm00bKvefqagEi/dl4nf1+ZCpDKvZoiDnBY2+WZcCxM1g6oJV9DgsgZUC5tyfdJa1zuUiZJfM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUSVv+OZHgREhd4/GNEh/Db3KKizNrgfbZKc6PMJfiSKii0kHA
 uefd/m9fSZKOAux7+NcuJW8uW2gybJFCaMa2VeOXl14FekD43916RpVHGhupvzOYZ/Rf6AfxceE
 ArNNp1Q5S1jivRcasSdj6rzTp7UxNkCr//z7IHc+ONTddNnJxBsQOeQ/gIeuk2dz96CI2gRw=
X-Gm-Gg: AfdE7cmVuKsdzLak+3z4NZQ9ujRaU3oweo13nG8Wcfw5sihsgi9+rkB7KhhOVSm6/wa
 hzNc7ItH5zrWmXu93uEIE1TjEKJz4IdbgC3iozQLca0piemvd7WnV+JKliyJUF+5tezYsa2EkPo
 4q3uOU73s1xQNO0kQ+UC+zNndNkU6UGlgZariWDM5wxhNp67OLthXJ1R1EY9BxHCGsBYt/+KAI2
 U2rBNtK9euqOnISASme5I6WIVGcaQ2FWSMw4wGGDGwLlAO1LvRkrQ+l9OHYYqBANpox9nES5Q75
 l9GjThRt/m3tqGXEvXsdEiZFLcFqWJunyk98cc4aRFdLy64TVUCtabg8ySAerA4f71ykGDJGnCB
 Dn9vBoHWJa+wFNPlAyrKH3alJrpvdmyFGLwAo
X-Received: by 2002:a05:6a21:1493:b0:3a8:800:bdf4 with SMTP id
 adf61e73a8af0-3bb3608225amr12571538637.33.1782129706568; 
 Mon, 22 Jun 2026 05:01:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:1493:b0:3a8:800:bdf4 with SMTP id
 adf61e73a8af0-3bb3608225amr12571433637.33.1782129705662; 
 Mon, 22 Jun 2026 05:01:45 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8f392sm7019090a12.3.2026.06.22.05.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:01:45 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:31:36 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH 1/4] dt-bindings: brige: lt9611c: add port-select
 property for LT9611C
Message-ID: <ajkkINI1PzxArMzL@hu-mdsor-hyd.qualcomm.com>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
 <20260611-lt9611-b4-send-v1-1-42abbcd3bb1e@oss.qualcomm.com>
 <20260611-burrowing-fervent-serpent-584cac@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-burrowing-fervent-serpent-584cac@quoll>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExOSBTYWx0ZWRfX0ZqyLX2CVY6u
 /S8RLrSeYQWrjBBKC4KU+N0nyiaWPW+w91r1TMYUsczo5Z3+fM5YGvHdytB9VBdDZS6pEPrKlDv
 c2w0OjtOjbWgZB9CBcXIzDPgvITVXtE=
X-Proofpoint-GUID: cRltHLhAUdcvwFMs51wM4gXaHF3JqqnL
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a39242b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=biyRtXT4hMIPAN2vSTIA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExOSBTYWx0ZWRfXyxJvm1cV0po6
 6BaO+DSLjeq5N+XCYfHhGm7WjxMkAvpW6pCKehwZ6RVSuYNLSB68tYfIZsUz+Zsv9DyzCKCiQfM
 Jf43ine0dmFlitM5zL91AvPVOVvp3OfQSpADe3s3TfOHAn01QqwIT3ZH53BUcZAO2BaCPI9Ha/K
 lbYo5Kcbc+J19fJk0REgu8tgB6yh2vMZKKH8Bba6DasYhLgNn+R9/dW81O2A3VZQiUwBCFzJI3t
 zz8kKXJG+fBBSVfN4e0w+R6i7KG3IJZCQUG47h+OVzL1gH6VBUmdeT09aR8QhqsVl7OI2xyX+x9
 SDoQK8D26+6DOzoAajGQSuKdcwgw9QaXitbvxCu41IK41yiMg0AHF0z6MbCHQG/SZ82j+iqikD7
 Zvf13LnvveiqRlcxjBkoAYnVVCAOp6MZlAfWVG1AK/Y5Q+YiFZ1ep+CCkkoSrX65pA9QcsCsMTS
 lHtIrf6iJ0n/m/gcJ1A==
X-Proofpoint-ORIG-GUID: cRltHLhAUdcvwFMs51wM4gXaHF3JqqnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220119
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

On Thu, Jun 11, 2026 at 12:40:38PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jun 11, 2026 at 02:44:56AM +0530, Mohit Dsor wrote:
> > Add a new optional `lontium,port-select` property to describe the DSI
> > input port configuration for the LT9611C variant, which supports
> > single-port (A or B) and dual-port (A+B) operation.
> > 
> > This property allows explicitly selecting the active DSI input port(s):
> >   0 = port A (default)
> >   1 = port B
> >   2 = ports A and B (dual-port)
> > 
> > Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/display/bridge/lontium,lt9611.yaml  | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> > index e0821a63d9d7..77220f893bf8 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> > @@ -41,6 +41,17 @@ properties:
> >    vcc-supply:
> >      description: Regulator for 3.3V IO power.
> >  
> > +  lontium,port-select:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    default: 0
> > +    description: |
> > +      Selects which DSI input port(s) the bridge uses. Only relevant for
> > +      the lontium,lt9611c compatible.
> > +        0 = PORT_SELECT_A  - single DSI port A (default)
> > +        1 = PORT_SELECT_B  - single DSI port B
> > +        2 = PORT_SELECT_AB - dual DSI ports A and B
> 
> Why graph is not enough? Seems exactly duplicating the graph ports.
> 
> Best regards,
> Krzysztof
>
Hi Krzysztof,

Thanks for the review.

The graph describes the physical connectivity between endpoints, however it does not fully capture the internal mode of operation of the LT9611C. This variant supports multiple functional configurations (single-port A, single-port B, or dual-port A+B), which affect how the hardware internally combines or selects DSI inputs.

In particular:
- The graph can describe connections to both ports, but it does not indicate whether the device should operate in single-port or dual-port aggregation mode.
- For single-port use, both ports may be described in DT for board consistency, while the driver still needs to know which port is actively selected.
- Dual-port mode requires explicit configuration even when both endpoints are present in the graph.

So, this property is not duplicating connectivity, but rather describing the *operational mode* of the device, which cannot be reliably inferred from the graph alone.

Thanks,
Mohit
