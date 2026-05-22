Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B46CD4F5B
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 06:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F5210E20D;
	Fri, 22 May 2026 06:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XcfGSSKP";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1B710E20D
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:44:50 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso74445495e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779432289; x=1780037089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PYQd1NpG4Phq0nb70yqYM1eItmr7QKZZscpcBlKX1kE=;
 b=XcfGSSKPQEHyZzXByw6zO6YAB6AHeoCSWGebxxYHrKrc6Ixh/Q8juI0N1yriwSZuEu
 Cfc28Dhr7TC62xpTpJaXIJ95EwiTQq/v4bxkH+xNZQJnM9BrYgfOsBp8AjM4kiCFm10X
 2RUiqCjM7sE3RBpcT/wLU4TnZCUrDzXbIWQZfbCtE3lKYeT/pXAR1eFuCCy9DVmhRrKU
 9aRNNUR4oWLS9OHr6SBqOclC+VCwR4EXhk3W8rkpbOqvtL4W7qR4dRQZFLeLMBWnwqJ0
 e2NqCkHJ5lRFSPLEmgrPLO1mfm7Wug/RKyIPIaI0tE6d5kua+U/a6Dd64cmzDCc5TLaT
 jhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779432289; x=1780037089;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYQd1NpG4Phq0nb70yqYM1eItmr7QKZZscpcBlKX1kE=;
 b=ZVRw/63E/OHT+M0bGXrdZp6kspbungRgRzYiC04jSiomGoJiEgaKGXoY6wASm33BQX
 13eUoIWXukSwmXN4XppYdtuQ33dxQKRAaBwYFdbTq64RDShlo9Lo0GhE4TthOUFGoYkt
 0rWHOxEDUnFoiLr8ZHo7MW+JCBYW0IeenphBuqLdKGtdPVu8I8yijuJmBIekhdfgPsUw
 M0bC0wzaBjUcE+2ZzibRycFl9PacSh4PgvRF9ZFbU312a4fpc9JVHNoKF8Sdmb6byyBm
 BfJfVU7HMKeLMerFbdh7Ku5X3dNcqj6QW3U5j7tYuRzSmsP6OwZu8UivFtiFfWkJkYws
 GZMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82yrxoD6wdWKc1shPzJ72Ej/db/yL7pghCf2jjr8Jmcj/R4hQA83Kc4sO8CZtz8b+ueZHPAUanV80=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxotAy8nayToKWAjCQDlqXBmveHvI59rTrjTOjLgXCrxyrXfXbO
 F3v0DKNpQG88REPv69G2Oz+qbckwkm37JVD3gjk7s2+zHYMpEWEpmsnT2RbVf7Q0uro=
X-Gm-Gg: Acq92OGBFxtWCJIgCimpbFW8sW60Xzjts5PO/ZmoeW1lF+H3FckV7dVDw7t71N1gpPF
 H45VkTopLG/8X5LqLQ1fR14Yz5KJbdsTBt+tm8QsKqTiFiN1BNDGBLrsDhAeQhogO1MtsYalv4n
 hIKphG6y0okDLC/eqF7RCql2a2ELeygUThsNZ9Jt6PDFhJol/NO2Q92FpC6G4xVuDzuGJunqgOr
 j88k3IB4ovv5M4vJSMm3UHfN9MlGDG4ujJrbbbFFvmBWU5mRqBKMkzA3Cgx2Vkn5zouBYJpjcYN
 HNGAMwBV3LAjlxs8dBuEMUmFbOOh+3LIHPHNOJ4SxL/eRHDPr+2tIiowYSoXB/GzqoItwoxIKqL
 A4lWEWf/TDSrssUsZ2tIjBt6XJIq/FJVeeAGFFIRaCuFh3Nz684duk6y2m/mIr7Y9ToiESvAwCn
 CmpQAYDagyOWnR3ZriFjOQM1aE8NcKmkO4yAiWV8GWgXsHMbz1S7Aw7VtG9EPN4gOYJILcNkkkj
 7g80RK+WpALlI5znA==
X-Received: by 2002:a05:600c:4f0b:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-490426a479fmr24824925e9.15.1779432289279; 
 Thu, 21 May 2026 23:44:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:192b:8d21:b456:cb51?
 ([2a01:e0a:106d:1080:192b:8d21:b456:cb51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454e38d6sm21819665e9.7.2026.05.21.23.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 23:44:48 -0700 (PDT)
Message-ID: <340451f1-f397-4eb9-b6ff-8c6ae1bcefcb@linaro.org>
Date: Fri, 22 May 2026 08:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Enable
 USB3 SuperSpeed
To: Graham O'Connor <graham.oconnor@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-7-graham.oconnor@gmail.com>
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
In-Reply-To: <20260522060645.4399-7-graham.oconnor@gmail.com>
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

On 5/22/26 08:06, Graham O'Connor wrote:
> Enable the USB3-A port by configuring the USB HSPHY with required
> regulator supplies and the QMP combo PHY with correct lane assignments
> for this fixed USB-A connector.
> 
> The QMP combo PHY shares lanes between DisplayPort and USB3 SuperSpeed.
> Configure port@0 with two endpoints: endpoint@0 for DP output (lanes
> 0-1) connected to the HDMI bridge, and endpoint@1 for USB3 SS output
> (lanes 2-3). Remove the orientation-switch property as this is a fixed
> USB-A connector with no orientation switching.
> 
> Add a usb-a-connector node wiring the HS and SS paths to the DWC3
> controller and QMP PHY respectively. Set dr_mode to host as this is
> a fixed host-only USB-A port.
> 
> Tested on Radxa Dragon Q6A (QCS6490) with USB3 SuperSpeed confirmed
> via lsusb showing 5000M link speed.
> 
> Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
> ---
>   .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 71 +++++++++++++++++++
>   1 file changed, 71 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> index e8ad6e666..c16c3664e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> @@ -1198,3 +1198,74 @@ &mdss_edp {
>   &mdss_edp_phy {
>   	status = "disabled";
>   };
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l10c_0p88>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +	vdda33-supply = <&vreg_l2b_3p072>;
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l6b_1p2>;
> +	vdda-pll-supply = <&vreg_l1b_0p912>;
> +	/delete-property/ orientation-switch;
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/delete-node/ endpoint;
> +
> +			/* DP output - connected to hdmi-bridge */
> +			usb_dp_qmpphy_out_dp: endpoint@0 {
> +				reg = <0>;
> +				data-lanes = <0 1>;
> +				remote-endpoint = <&hdmi_bridge_in>;
> +			};

Previous patch needs this change to work, please squash.

Neil

> +
> +			/* USB3 SS output */
> +			usb_dp_qmpphy_out_usb: endpoint@1 {
> +				reg = <1>;
> +				data-lanes = <2 3>;
> +				remote-endpoint = <&usb3_con_ss_in>;
> +			};
> +		};
> +	};
> +};
> +
> +/ {
> +	usb3_con: connector {
> +		compatible = "usb-a-connector";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				usb3_con_hs_in: endpoint {
> +					remote-endpoint = <&usb_1_dwc3_hs>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				usb3_con_ss_in: endpoint {
> +					remote-endpoint = <&usb_dp_qmpphy_out_usb>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&usb_1_dwc3_hs {
> +	remote-endpoint = <&usb3_con_hs_in>;
> +};
> +
> +&usb_1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};

