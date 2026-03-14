Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEAF107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 02:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4144B10EC83;
	Sat, 14 Mar 2026 02:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xmq4hWPq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L/GVM5Uz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC3A10EC83
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 02:04:13 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DGOOxF481447
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 02:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/FLx1q2L+/2u2ZwvCEUn93j2
 CO1oCs48gYn4y0ww5gw=; b=Xmq4hWPq7yeBWvyahTveSY+opksK0FpcQWbXX+dd
 XLPIDsikbNqC9atX60Y1a9R8SKJF1zlNMPL02HZuoPhir8Hcv9DzBBuPcfWrmVau
 cCDtGhmmE9h9soyerbL1lZSd5O3O94bC0IRVBG6DPUpz02GvR/mQrYQuGUyA+ctq
 AfpsAKNKtDD14tLHsgQ1A2eHp0Z40S4RH/7bKOKCY2dRFTi4mAZJwyBuNSlJDmod
 YMGaF/ozKR5A49DbE0CtEu0xBuu+a+RjE7DbTKrEIk25pIh5EBq7x/AKJAC5y097
 pcHuyDMyuVycyq+JRYWyHUnddLBMbmF9GkxKPQwoMRMxqQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfh7u1bv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 02:04:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5094741c1c1so207643551cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 19:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773453851; x=1774058651;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/FLx1q2L+/2u2ZwvCEUn93j2CO1oCs48gYn4y0ww5gw=;
 b=L/GVM5Uz9LobRRz0FshW/NXihuK/80axcnB+cNn5/Wv+sFeb580BYeGqlbUpp0Vxtz
 TNsgCMn+nXLNm586J9sigQFnYYBCvSqfo1/r+wM5zZ3lreNIbosdzVedD9w402/qwztL
 JceV6Nc0pviQf3SeJBdezoPDSBc5u8tNzLf39Y+jfpuJbsMezxGBmjC8FIA5Jx4yS+Ca
 WpuFTPhGVLVoaNL19dQv6+DYK6yM+FRvyGfxDUtGE/QdkiqNSGHsniBCXjd2+mEaSEky
 gpIUBgv1XV2GrpOx9m48XwsaZi7J+Yzpd8xvR1SRS7N5p5m+AYNmvNdntrPwHeGwNTs9
 YEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773453851; x=1774058651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FLx1q2L+/2u2ZwvCEUn93j2CO1oCs48gYn4y0ww5gw=;
 b=Ui32lralXG7CgGUdZDc/WgP8RtDU4lCIbkgtvqmLeBKx3nrXF7bRN7lj9ayumQqQnL
 lCMPtJBTrQK39TDpwAAKFqFUX2vD7PYKpApvc++F4Dzvp2txJJveuFmcwH1RTYnOzNv4
 aD7p5SU1bQ7plskE/XXiZIGnzjUdCoIQIr0Gi+LQ1ElU7Zq8AEkQel1wbOSAIrnox3zv
 hjuDDtIO42toy6wX7Rwung+6lIgmnfFA0ecy+vJY1TYQXo5K3GpOYzo70HPhjSMIw03B
 g3pYNlInGirkERXAOjQ87UFOEmkxYDHHEfLX1gNFP6JK8JZHq1C+1Lo+QKi36SOfQ62p
 YCBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHcSYwsPQSswzc0DdyE4Ilmr25DPMN6Gn/4ShucbNAGW076vK3PepQUXuh40s+IQV1fbxrUHYaVzc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxgebYDzkG05qr0iUMaxdBq4W+QhindZRWaL9OvUMF9D5MrIHm
 YQyxe9T8MnB/tw6jyLx4iR3LkESzvKnGWdEnyoXp5nE1AUEKeyCsKQeDLC3B2b8x18JQeknkYqV
 vMqDG7vwJ5LlVRwFLrPoOrfH1pgHSykX2Gvlh1tUi1Q+0QyBceLvbgpgunRxxu8f0pAmz7QQ=
X-Gm-Gg: ATEYQzxn/w+FO9kGClF0YdFRiuGISXuI/dGyB4ktvqRqBtcM8l0GijCI1T9CN2W/kkf
 wccSyQ92rIEY4JAGKt+gcS5YWVwr6Usc5XuOSThk4ThXhKIIJyCeruzAmxTDwqIC/0NRt5CdY80
 MxAZseDpSJ54rq/g+ux2TbcWs3g5K3D8Hw+tuwoypBDu5JaJY9k8EQIvWdjrHxRwD/Ud0HYY7bV
 pymyG6vu1EKzjxVffTnxsvIOFo4L9CFY2GxySMk7ZenSeSxBUxuzhsNXVLi2ZyBiwIX9OhDvgvc
 h0ko07+zLfuQOJxordIUw1pnw+h6AmKVLho2TJ56z0xjzcvQtfgDe9LHQ0nJO5iu/vKEOYvVIm9
 P/scRQOkj58YQs1t2MwseMAjgaFMuAjWs410zQKCWkicaC+B4LWA1/zEohWQ/HEp+DDrSvR76aw
 XEY4xjajxduI0pf3RZHKQQhmEXN0jVmIDDsGk=
X-Received: by 2002:a05:620a:471f:b0:8c9:fb65:7f0d with SMTP id
 af79cd13be357-8cdb5a70377mr802813985a.28.1773453850820; 
 Fri, 13 Mar 2026 19:04:10 -0700 (PDT)
X-Received: by 2002:a05:620a:471f:b0:8c9:fb65:7f0d with SMTP id
 af79cd13be357-8cdb5a70377mr802811285a.28.1773453850307; 
 Fri, 13 Mar 2026 19:04:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1827925e87.77.2026.03.13.19.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 19:04:09 -0700 (PDT)
Date: Sat, 14 Mar 2026 04:04:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pet.Weng@ite.com.tw,
 Kenneth.Hung@ite.com.tw, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add ITE IT6162 MIPI
 DSI to HDMI bridge
Message-ID: <p34ct3d2eftpdlfmf7yjmyuw7f67tu6tvyerilagqrjtnwegs7@wjiorhtxvvx5>
References: <20260313-upstream-6162-v3-0-8497fb7c4406@ite.com.tw>
 <20260313-upstream-6162-v3-1-8497fb7c4406@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-upstream-6162-v3-1-8497fb7c4406@ite.com.tw>
X-Proofpoint-ORIG-GUID: OCmRFNNDWyWxJ1uDZibO-5ACJasfImvH
X-Proofpoint-GUID: OCmRFNNDWyWxJ1uDZibO-5ACJasfImvH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAxMyBTYWx0ZWRfX8wJY4LT6YqC0
 E4gYy8LaNHm3zBZEE7hDW3x9+4sB7PoeDQzUuK25qcRRVZp/v9s/iNuLDN+YPu46r/jVFPwiOpN
 fnT0lZlitvDECnbpK241+kvLm/v4QO+Y+hzue0HP6pJYT7DyYWOY6YNzzGd5cFnFcI/yh7gFA81
 MmlLy5hVhgd+5bNIZODJ3PrWcYm5pmMFy72KEc02EjFPuQLwwKsq6Jt9PHxK3zm9CXsyaUtU0/I
 24stTVLQlL8AevOSpocgkF5ZnksjtSfBSAOfHcDKuLpQHjMZs4JL2vkE8oge/GK/q0DiZp8WMgy
 IZxcYljAwcTcQcbtMl/v6MEQX34/9UmgGKINf4kTPi5aeVMBCgcncP1ugnQgmwMWSFZqlvA+xKJ
 YwkqOcPnAzMXgsJ9dF7+EOi/TjVB5EFR7iQarXmXZ/ISVofrFxqib1tYJXfJrbUOfk/Pj1vLLjW
 FTJt54XOSv/kN+Iw3Dw==
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=69b4c21b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=Ns9eNvu6AAAA:8 a=qLnrkvngGj7QPv7EIKMA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0
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

On Fri, Mar 13, 2026 at 02:16:00PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> Add device tree binding documentation for the ITE IT6162 MIPI DSI to
> HDMI 2.0 bridge chip. The IT6162 is an I2C-controlled bridge that
> supports the following configurations:
> 
>   - Single MIPI DSI input: up to 4K @ 30Hz
>   - Dual MIPI DSI input (combined): up to 4K @ 60Hz
> 
> The chip also supports up to 8-channel audio output via 4 I2S data
> channels.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
> Changes in v3:
>   - Fix lane-polarities: remove $ref redefinition, allow via video-interfaces.yaml
>   - Improve ite,support-hdcp description to clarify FW-based HDCP behavior
>   - Remove descriptions repeating schema constraints
>   - Remove stray comment in ports required section
>   - Fix data-lanes spacing in example: <1 2 3 4>
>   - Add missing newline at end of file
>   - Add missing change log that Reviewed-by tag was drop in V2.
> 
> Changes in V2:
>   - Drop Reviewed-by tag due to DT bindings changed.
>   - Add property "ite,spport-hdcp" to enable HDCP
>   - Add property "lane-polarities" and "clock-noncontinuous" for DSI
>     setting
> ---
>  .../bindings/display/bridge/ite,it6162.yaml        | 178 +++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6162.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6162.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..b33fd140a9932cff3ede342298488988d337477f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6162.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ite,it6162.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE IT6162 MIPI DSI to HDMI 2.0 Bridge
> +
> +maintainers:
> +  - Hermes Wu <Hermes.Wu@ite.com.tw>
> +
> +description: |
> +  The ITE IT6162 is a high-performance, low-power HDMI bridge that converts
> +  2 MIPI DSI signals to 1 HDMI 2.0 output. It supports dual MIPI D-PHY 2.0
> +  links up to 10 Gbps each (20 Gbps total), compatible with DSI-2 v2.0.
> +
> +  The HDMI transmitter supports resolutions up to 4Kx2K@60Hz and is compliant
> +  with HDMI 2.0 specifications.
> +
> +  For audio, it supports up to 8-channel LPCM via I2S (multi-line or TDM mode),
> +  with optional S/PDIF or DSD (for SACD). Audio sampling rates up to 192 kHz
> +  are supported.

> +
> +            ite,support-hdcp;

Can it be detected / read from HW?

> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;

Emty lines before subnodes.

> +                    it6162_dsi0: endpoint {
> +                        data-lanes = <1 2 3 4>;

Thies doesn't quite make sense on the sink side. Should it be set
instead on the source (DSI host) side? At least there it would make more
sense, especially if the host allows lane remapping.

> +                        remote-endpoint = <&dsi_0_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    it6162_dsi1: endpoint {
> +                        data-lanes = <1 2 3 4>;
> +                        remote-endpoint = <&dsi_1_out>;
> +                    };
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    it6162_audio_in: endpoint {
> +                        remote-endpoint = <&i2s0_out>;
> +                    };
> +                };
> +
> +                port@3 {
> +                    reg = <3>;
> +                    it6162_hdmi_out: endpoint {
> +                        remote-endpoint = <&hdmi_connector_in>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
