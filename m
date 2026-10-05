Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2870CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DD610E247;
	Mon,  5 Oct 2026 08:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SECs0XVt";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C6EE10E44C
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 08:57:01 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01c4f4daso1205533f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791190620; x=1791795420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XejSzSbf+ABtZToUFlQIw9XxytbopN4NR3AIBq1eEBM=;
 b=SECs0XVtteIuPkMSNVufzLtblpgmMpTHoBBmUfA7R7Pqnx5bgUP+VwVQAeakFUKdCp
 xNQHebbsplarOq9uM5emf9+dakNnbYSdF5aLxkJEhPjEI0M4hrZCBb18pskUe9Tgjon/
 TGH377J3p8W4mtAhHQhfXF9qKmPSqStO9nFgIAst9yiizMEsFugOt4xQPDZMloKdPthP
 6gYx+sEI6J1F+0aDDaitzfiq0JZU6eieCVnoslImEvXsaQVbvpn0SDLV6aLAk/5QV3hP
 pwdKB+8hiKdBWxuGbhuMwHEeXAUqtj08sOw1A3NFIvgioNdw9CZa+JeaAQtyjWlW+DD0
 iBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791190620; x=1791795420;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XejSzSbf+ABtZToUFlQIw9XxytbopN4NR3AIBq1eEBM=;
 b=Kt5WLSSgI3gAdgExcFOtjoKtobE/YeuzORprY2+CxTUod2+q6sVNklWjEn/W1Q2fYd
 CkkGi1W8QUNB3SBSDsd6YtqAZPa63wOyXagzdtxZiuA/biucuLjAWD4AAe4H5cm+J1/C
 SkujI3p1JqIhWEpKXk9Kyew2VPPMaUC7QBsJzqSskBEGJyX6KOhWRsfx3P8dHODzF6P8
 ICpcz4YYTHc24mMTIuDvhhPqkTqaikmtwtboDYYd79gjbAGIITfmGuYbuGBANm7l/bw3
 vD96SqEBMxp2Q3F/pe9Z2D8gW+VvfIgKIftVSD+Pj2+lGs8RdtmnvwwP9c+6EpFGM0On
 PeVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJeoefTYhzdyWG41keOoXoFG/DNSrULeueOllAmbZvW7aa9GTJvB5mMyYtnNslksAkQMnL7piWkrg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKs+vxkeUQ7YeuzEj/y9UsK1agdlxuGValqariF6qW5PpKcMTKU
 u1WTvtF1VNWQuRk/a+KRndHOvu8dl706Snv92h4yJcRNiKGIyQBMEZN65zBqCSiaeok=
X-Gm-Gg: AYBFou1hsxCy34REMnLTarHTszhW0JZch9DEbSMURKh2XY6Qiq4SIreS/kN/XyfqoXI
 EG/Yyg1qLGPhkXCXgXNG4nRzlgmE7K5vbKofgcNdR7Id6iLdXWX7ESSVzDVk2TkTFg6hUQQbAgc
 zLV6ZEdHRuZdME12sBnjJWSIXT2Mm3hQvqGw/uT9EYzztEHeuMFfPYLA8+3+IIF3SmuQy4N5lIW
 I1O6DNHsPWi1kUFu0FNI2DeJ5CVvkj0x/tBpijZLKGF4dAezRpagVLkh7ywdEWBPVUbwlzEalPK
 mBDc0Yh7/mJ62aprcgDZdEm7la8+IwQiTcVxdK+7AiffxrMRABG3H6XJ2HlhI9Qutf+7f9dtGrI
 uXSuV6qqIMgKmRdgzEQnM0hY3ABtZi5SFY+eTW4kPRlvfKSNDOczXgmyMe0vaHIMK+e+GFxwCHF
 0G23bjo2OAo1Qy8bAwtYHNH1jILewZraXDPC96tOaLQegzqBsJIukpRPp29yIMWtTolMGnCChtc
 nJ18RPCj1l7yvYE+8JkFeo2wg0=
X-Received: by 2002:a05:6000:4a19:b0:48b:60d:2b28 with SMTP id
 ffacd0b85a97d-48b1273bb48mr17360037f8f.39.1791190619709; 
 Mon, 05 Oct 2026 01:56:59 -0700 (PDT)
Received: from [192.168.151.46] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab5a1sm2214789f8f.36.2026.10.05.01.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 01:56:59 -0700 (PDT)
Message-ID: <538604b5-56bf-45d2-9a73-050a0f2b14ce@linaro.org>
Date: Mon, 5 Oct 2026 10:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics panel support
To: Linus Walleij <linusw@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jun Nie <jun.nie@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <20260727-spotted-winged-mantis-7aa1ce@quoll>
 <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
 <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
 <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
 <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
 <2lcpzwh7fxecpffnakpnp5lecrm3e6u64ztat7cd75nuxofxa2@clj27bzgjy3r>
 <4d053234-06d8-4268-b60a-2fccc78da654@linaro.org>
 <d3xs3kzc2wg5lkouaemdicrbtsoquff6bvmnlmuxwh4kspfs2d@b77l43axr6a4>
 <8cf6ec52-fb36-44e7-831c-2bb24214f591@linaro.org>
 <CAD++jLkHk-2MK4vUAz3q4q6v6jHhBkt33eJL297axbRqLn6w3w@mail.gmail.com>
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
In-Reply-To: <CAD++jLkHk-2MK4vUAz3q4q6v6jHhBkt33eJL297axbRqLn6w3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/4/26 22:22, Linus Walleij wrote:
> Hi Neil,
> 
> On Sun, Oct 4, 2026 at 5:51 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Describing it in separate distincts nodes is wrong since it doesn't reflect
>> that it's an unified display, so either we define :
>> - a "combined-display" bridge defined as:
>>     - a separate top node in / like connectors with a graph from the DSI links to each panel
>>     - a DSI subnode with 2 panels as subnode, port graph from both dsi to both sub-panels
>> - a "R63455" panel bindings with 2 subpanels as Linus shared in https://lore.kernel.org/all/CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com/
>>
>> I think it would be interesting to have the "combined-display", with a connector-like node,
>> which will do all the split-dsi dual-panel logic for us and leave use implementing simple panel
>> drivers.
>>
>> The outline would be:
> 
> Overall I really like the looks of this!
> 
>>          xr-display {
>>                  compatible = "combined-display";
>>
>>                  ports {
>>                          port@0 {
>>                                  combined_dsi0: endpoint {
>>                                          remote-endpoint = <&dsi0_out>;
>>                                  };
>>                          };
>>                          port@1 {
>>                                  combined_dsi1: endpoint {
>>                                          remote-endpoint = <&dsi1_out>;
>>                                  };
>>                          };
>>                          port@2 {
>>                                  combined_panel0: endpoint {
>>                                          remote-endpoint = <&r63455_right_in>;
>>                                  };
>>                          };
>>                          port@3 {
>>                                  combined_panel1: endpoint {
>>                                          remote-endpoint = <&r63455_left_in>;
>>                                  };
>>                          };
>>                  };
>>          };
> 
> The core of the crux is to make the argument that this node represents
> the hardware and isn't just something put in there to make it easier
> to implement a driver.
> 
> If I break open the headset, will I find something like this, some wires
> going around in there or so.

Well you'll find 2 lens modules with embedded panels, they are separate because they go
for each eye, since it's technically a single display for the brain. You can't
really use each panel separately, they are mounted in a specific way to be looked
closely by human eyes.

Neil

> 
> If yes, this is a go.
> 
> Yours,
> Linus Walleij

