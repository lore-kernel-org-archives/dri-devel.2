Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCEB606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qmt7auRW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A33610E7D6;
	Wed, 18 Nov 2026 12:34:35 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B201610FBDA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:34:28 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so4985565e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795005267; x=1795610067; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nvPt3fCk+CsXSOqBkgE7UtRZc1xZmTaUxS/+53ef6bE=;
 b=qmt7auRWpTOWVWSMTb7j7L0WDl6/DwZlZ2MqAL01oetoBtyDzKeo+GFcH98UO4G0kl
 SF4zdvyXnPAUxChRvpanq3+5I4HZDESvftgMK4mWzRUccTCMwUEuAIs5JbPlA1Zza01E
 rMGJdaPS/k9mXCVFIOYmlVt4/GHD6n6yNIuFttpUw2sf5tRIEfl4cHWVguqpczI//spN
 /kJuCP0ccRB24+CMi6FeX8HSJn8OvagMRp1NMzL9keVwiQ/Uv1LMFeIEqhk+rLR5hQpF
 csSjairmzzNsSq/OenIQ7m6dmmG/NcLQVD1FQymgBfe7xI4zUMW6aGNhr3O6ZT9GWAuK
 S/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795005267; x=1795610067;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nvPt3fCk+CsXSOqBkgE7UtRZc1xZmTaUxS/+53ef6bE=;
 b=bToSYkPwn4nALROp/sUJl6ULATi95EoS+MyjqhL51oqqVxrGTt1K2ZWniLIMiNTI06
 4lSV5RhtrY0AQB5aBssEp5Pu0HvB1qoTYTSYEoH+F8ztUvM63Z0r6ClVHytOoi70bQid
 s5GJLHMyI4dyamMnbiLwh/g6Q9wLmA+d9WFaVVDpToQS7scRa4RI/73sGyMDBprdwAq0
 QsiceIJsn6TWqvBqH/LtS6PejDmg4eJ/OtQ7GtqyCHMnZUDIDWSgcAUpNarSA1MpaqgD
 vR1mvHBNK9MY9R7WTON6R0udN+NGwyI/W8+WnM4CFBRRy86newz8wFnkqalDTFkQVNND
 rvTg==
X-Forwarded-Encrypted: i=1;
 AL+hErG9/0bOperKKAxxblNCHc2jfUEd/ibx8t21F1MlR4tUkSWzMf+5rkK/kr16Fx2kHyWNnJGfE/hbgtk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9FYHhAj4/PGEV6f2a1QE+KPjNVMdSz6KPlfAF2tQtaiIlPxyjB
 7s6ECrtY9uFFbCUUQaouJXE2cZHYlQyc6ylVbXyb7UKLTCmoL8u9kYfBBT8QurBEXoDn9aXL73H
 vxuARhItReg==
X-Gm-Gg: AYBFou1zri72P6R2cw1MoBDJ0REG0sZOLIwjBJ3WuutMZBRaioqdYb3+7jdCeN6iwaN
 8NV182PSjQNTrR76hb6s62XcubWHcqMQpn7Yrx2Fa4T3egZxVlJLqjAVNHRR6TtNI5rEBBcVXyV
 MFWVuKMWsJ8uFuhgdo5YcwpgBpqu1pb9Qrbdm5/R7ag3UUvmuEiYxcYiHs0t/RANybebOMcxTqD
 Xw4tPiTMP3nGbStLi4CFR9GmEO3AfyNY8hWoTtXuoLAxz3w3kCNwO/Q2zK89TOTFQ3ajANDgfVz
 aIwYu4IpmzMCKty24GW+GyiCWjnv8P6qkwralzyZ9W4neIQhKaGcKuh+Su6txp2f2Vlhx73tlnQ
 mAwFE/CTk0InhY8RR1SquVfKj5FXcJpSY6IsyclplhR9b2kp6Gvalc76N3QA7FNpTWUtUz65RiZ
 5A6pxb/5NL5BUyCbmSSHKjqIT9Wk1I9YTd637Vd4M7Yu2QjbuaKuy2jIAw9Vm16TX4KuNdsXO+U
 M7g2eJO9DrCgB9I2/WZtqTAuIm0VDktTuTlsO7/iGpINqbwpb5OoIMV28c2ZEc24h1MkGTbd8rb
 u9u5YsYP7hZmD/oPJVep6tsRI7rb/PwpbhEs5sDtw/SLdGgqNk5QniLCU7Jlj4DNvEhLRTJev9q
 rWJBhaqh5
X-Received: by 2002:a05:600c:1d06:b0:4bb:6a5a:783d with SMTP id
 5b1f17b1804b1-4bb7da25158mr46260185e9.18.1795005266845; 
 Wed, 18 Nov 2026 04:34:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:6ca2:2772:9e53:115b?
 ([2a01:e0a:106d:1080:6ca2:2772:9e53:115b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e57664esm26749835e9.1.2026.11.18.04.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 04:34:26 -0800 (PST)
Message-ID: <3e82658f-1152-4c98-b996-242abc203f74@linaro.org>
Date: Wed, 18 Nov 2026 13:34:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/10] dt-bindings: display: amlogic,meson-dw-hdmi: Add
 phys and phy-names
To: linux-kernel-dev@aliel.fr, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <20261117-meson-drm-create-hdmitx-phy-v1-5-9e0ac931381c@aliel.fr>
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
In-Reply-To: <20261117-meson-drm-create-hdmitx-phy-v1-5-9e0ac931381c@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 20:33, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> The HDMI TX PHY now has its own binding and driver. Describe the link
> between the HDMI TX controller and its PHY with a "phys" property
> holding a single phandle, named "hdmi" through "phy-names", and update
> the example accordingly.
> 
> The properties are optional so that existing DT, which do not describe
> the PHY, keep validating; the driver falls back to creating the PHY
> itself in that case.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml        | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
> index 416fe263ac92..5a033fec21b0 100644
> --- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
> @@ -108,6 +108,12 @@ properties:
>   
>     sound-name-prefix: true
>   
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: hdmi

I don't think phys-name is necessary here.

Neil

> +
>   required:
>     - compatible
>     - reg
> @@ -136,6 +142,8 @@ examples:
>           power-domains = <&pd_vpu>;
>           #address-cells = <1>;
>           #size-cells = <0>;
> +        phys = <&hdmi_tx_phy>;
> +        phy-names = "hdmi";
>   
>           /* VPU VENC Input */
>           hdmi_tx_venc_port: port@0 {
> 

