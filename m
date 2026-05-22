Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D620CD4F5B
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 06:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4062710E0F8;
	Fri, 22 May 2026 06:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xyX1jmqh";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB1D10E0F8
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:44:03 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso57822865e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779432241; x=1780037041; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=V95QtxOjNpk/eFHCICMdSHCCCiyFoiVHQUBE50qTcZQ=;
 b=xyX1jmqhCVZkJrtuvkU3/B2LpVqL8zAletH7ggdEZ9Xwnx29Xs7NvyJCRUnrjLnVbo
 6Cl0bZIQ8uYtEoEX2HHM6wnad8iApHvDBeMLrt0q0+zIwh8BZ4vDWXvVjA8GxNoswmso
 IDItpNtQ1OWkg69Mk/BV7d1CSbWtuvG6KsoPojDMSlATA1rgDyq4WdcKMHkPJOdeTZyR
 j1fOadQPH5GjrnRm/5nWzRyRrHjLiHMRxuNHgBo0UcEe3Z5dEE7owcgN7ACyuLFGrfu+
 iYwDpCFLQ0Zwr3moQT8oiXGh2oVeg6xdSUcmlWBGybDdg+BhY34+djUs2rgexy5WrhVp
 K3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779432241; x=1780037041;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V95QtxOjNpk/eFHCICMdSHCCCiyFoiVHQUBE50qTcZQ=;
 b=CQ+cOkzdFLPMr44Pb+S3+qzTpfq6lp4VuQKleT0K68alQIVwXOziTcY29pPSqOhqtO
 WTzFbgsjkMXgYhm7NBwT1hN1IS3VL15DR+CukF94i3QbBsjLOt5JleQEMvKq+B2WQE+q
 P2zqxxv7mpI7Ccme2zZptygkK6+gM88azSKidYWIBhisihBCXmkMmsKWav2cGK1EszFp
 1Qi8iyF3+dGFcVSjOwYyQoGBjsWIWn2eQI4l+1Ya3pb/Qf6PYpT5w7donkSnL2OOizvO
 RkwHcKeHSwDCP0bqYtQGsq0UqYXUavGWNB6ReD/qpNJRJxegF+MCKNSw1iTXKbiojePg
 Q6dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gTy9tkwINAyYqKxeHDAarMzG8haE9nysT1UE0Nj0qtsIpjAqVnxjtt8B4cnkZmRa8ZWwzuPJvDAc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzj9ZIIstPmZAqdDcy7Ag3jt6JwuOluzBUg/9zkDs3tKXgYJi3g
 PpOWrfy1vT2pmeKSs913ZgdddTVo3CZelGMouqsRxGu3gctEHV5fTp1HzvXSa0kIlpo=
X-Gm-Gg: Acq92OEvhzsug93+NIAq0hOiGhXdtTR+/ccNaAd0Z/COzAVZMDUgfIN/XMxJ9gqEZPR
 heEehJAksnBzSu3D/v+KIXBSMMmXs//mOrYKCa4584HpBNH0UNh59BN6HXxnrQE9LvAuwPyNI7q
 BZRHl+ACZql7ztZxZ3tKpoh50tVtXRNYTN8qcK3Cmgq3JrOMWxkfRafbGzxvhfm1MkYgPBUCOiV
 8Z3A0O4m8THx05Uf6EXgaHx0jaXHIfra7RrANulHcjdjqeeMv3v5Ap07o1sng9YETFzgycMqWt6
 pge/gjSiBfnagzw/cj2Mc4mjRKrZJWKPMjAnW/ujAc4HDTY7bcpGEkpF5YeUniqLQpjlCuxeqlY
 cVuWVuVKzbpH33NZei/UVeJbhtvnxYdeyHzoBJVXBrW7WpOENlzJz+QZpHZ0h8KhKmtlWg0bQBE
 1Vn3SjlbBxYDqeUiOEpvPn/KKAUbAwwM9z7phrQgUwATE5ffQeNaBknCIBMEVWgZKqkcFay6s8g
 LtC9As=
X-Received: by 2002:a05:600c:4ecc:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-490426d190cmr26027355e9.22.1779432241368; 
 Thu, 21 May 2026 23:44:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:192b:8d21:b456:cb51?
 ([2a01:e0a:106d:1080:192b:8d21:b456:cb51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490417ac7dasm10859115e9.7.2026.05.21.23.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 23:44:00 -0700 (PDT)
Message-ID: <def01730-bd5d-4c61-a302-a9ca625cda7a@linaro.org>
Date: Fri, 22 May 2026 08:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Enable
 GPU and display pipeline
To: Graham O'Connor <graham.oconnor@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-6-graham.oconnor@gmail.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260522060645.4399-6-graham.oconnor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

On 5/22/26 08:06, Graham O'Connor wrote:
> Enable the GPU clock controller (gpucc), GMU, display clock controller
> (dispcc), and MDSS display subsystem.
> 
> Add DisplayPort HPD pinctrl state for GPIO47 and wire up the DP output
> pipeline through the RA620 DP-to-HDMI bridge. The RA620 is a passive
> hardware bridge requiring no driver - it converts DP to HDMI
> autonomously. Add the dp-connector and hdmi-connector nodes to complete
> the display graph.
> 
> Disable DSI, DSI PHY, eDP, and eDP PHY as these interfaces are not
> present on the Radxa Dragon Q6A hardware.
> 
> Tested on Radxa Dragon Q6A (QCS6490) with RA620 DP-to-HDMI bridge
> connected to an HDMI monitor.
> 
> Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
> ---
>   .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 85 +++++++++++++++++++
>   1 file changed, 85 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> index 4003837ad..e8ad6e666 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> @@ -1113,3 +1113,88 @@ &pcie1 {
>   &eud {
>   	status = "disabled";
>   };
> +
> +&gpucc {
> +	status = "okay";
> +};
> +
> +&gmu {
> +	status = "okay";
> +};
> +
> +&dispcc {
> +	status = "okay";
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	dp_hot_plug_det: dp-hot-plug-det-state {
> +		pins = "gpio47";
> +		function = "dp_hot";
> +		bias-disable;
> +	};
> +};
> +
> +/ {
> +	hdmi-bridge {
> +		compatible = "dp-connector";

This is not the right way to enable the HDMI connector.

This patch https://lore.kernel.org/all/20250914-radxa-dragon-q6a-v2-5-045f7e92b3bb@radxa.com/
is the right way by exposing the HDMI bridge and setting the right usb_1_qmpphy data lanes.

Neil

> +		label = "hdmi";
> +		type = "full-size";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&dp_hot_plug_det>;
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				reg = <0>;
> +				hdmi_bridge_in: endpoint {
> +					remote-endpoint = <&usb_dp_qmpphy_out_dp>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				hdmi_bridge_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_bridge_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dp {
> +	status = "okay";
> +};
> +
> +&mdss_dp_out {
> +	data-lanes = <0 1>;
> +};
> +
> +&mdss_dsi {
> +	status = "disabled";
> +};
> +
> +&mdss_dsi_phy {
> +	status = "disabled";
> +};
> +
> +&mdss_edp {
> +	status = "disabled";
> +};
> +
> +&mdss_edp_phy {
> +	status = "disabled";
> +};

