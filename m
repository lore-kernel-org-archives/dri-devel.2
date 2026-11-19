Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NMSuLTRW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607BA10E52E;
	Thu, 19 Nov 2026 07:58:26 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C9210E52E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:58:19 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so3989095e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795075098; x=1795679898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pdQlb2CsGbWPGWlbFcx6D3f/AbXcJrTux+zl7o+qrMU=;
 b=NMSuLTRWNjXp0mTCEys+opK0cPRxjIYwDvdT5aptcB0e8TWJCaa1pzodysUNAZUoDP
 HTmEkuQe6OrVqHI9e9m0o7wSwy62NI7acYBElFqmyGlYQNMB1cxKGYwz7SDGxRU3SVei
 N/3LoprB9kDt+RtuM4nUTcSi0G4eAKx2UtL9B1r4o1hyyXegRAJK1DKF4OO0ryz2F85I
 ZjhX0J0FaZvgBLSfz3PxVAXFxInJbud6AuWX16l8rTuZtFzBZ8WvFb1q0u+achtvciLT
 7kc2P4gO0kBGKn3Ip4ri+76hGI3luiG0jseBC3l1EIiXdsV12kD0rln3CX/AE2pY7Zr0
 BS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795075098; x=1795679898;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pdQlb2CsGbWPGWlbFcx6D3f/AbXcJrTux+zl7o+qrMU=;
 b=WknwLyaXiq9fiNnRXC/cB0TjMQlm6aUpEMMmk1F8vXjnF4Jpqi5bNe39jNSiKgEWTJ
 0YmcbKemGVQ2pcPNdUJLAs4f0EC3dGL83+xj4iOk8wVBuQbaBYwKxIPRuHw6z8JD2rAd
 jg6aKyv/ycJH9cRQY34jTPPW/RmG1/NOKFlv6AToOARHGCw9AJtZqPVoumws8nIClBSA
 ixHjXdpqtYl9QTOnxGrV+doLFsA5mUdlLC/dX8BmhtuSGrCTLEzGWxDupSuIELvjVH6f
 9vZYJiXGgJ6JztzsaaXwWMtXs2wLr5HhlbZl2poySeQRq17xp7H2qkTTByNW3p8dxC/u
 1v9g==
X-Forwarded-Encrypted: i=1;
 AL+hErHbm/bGt7F+upBfPhGVVS2Wb49mc4vCNnmPisOwjO1NU2rItP0q3C3DWofc7vf0cqG663XfqT+R+ZU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9etNSvN6ZQFLXLMUcfmzvLi5AqzHCmdLK6+IaHJP+glgUS6l2Z
 V/P9pEbVzp+f603FapBRmnPQ3swJOshaezG3dgmmvlewONfkpSyuApBgcjLVHnMZdWw=
X-Gm-Gg: AYBFou1nPYiLANypdU7mlNA5xJIaGvxM/18l0IkMg3/NGz6OW9JbUVA2dEkOTqV1gRo
 YcnY5f7bzQUG7n1vZcCUTKOHzFXxXSpowZtE0aGTlb+duvU8OyxxtQ7DsoJTga6H+XN4S9GbL1F
 SEZy00JuLQ5kYmtk/GnkrH1YIy40jecv71HXcqtYppooK+ojVLvaBCSz0j2fB9lfdf86nY6VrRp
 PbAZKzOZwZt4C2MgrFjTF68RQDIQDlQnyUbVujiv9BfUL+c4aSljCSyk5zWFgPPMNT/Xdb8GsQN
 +afqmqa/jw9cmZeWQfmAxepZ53gZo3J5s6ywDuj1ZkuE1nS9xmTkHiS6cfycMvb2RH7wSia4ZHo
 gU1WTyc/wAbP69rwvOSAfAPcWuvts8KwxyPvSilbPpM+l3ANLdEXDnU7QYrGGZBHEg5hFaJy3cn
 na2FTLisId3ARCWv5ukG98XXMdgO+VO7zE0OGmrqWoaf6TNiNp3orNOZXPOmg79t9AU3P+IAvG+
 /z3WkVhbXuppUA6jrXmz96VcPdUx4+rRiAMaYbm2OmtzH2j5F2r3Wgf8Es9lQGv6oj50Pr3YD9G
 zOZ/ZdtE58g9JcfSIhNKcvyjX1S5geKIJwrIRtz8/0xqj7kzhThYP/1Uq+Qex1tswODlF/1N4yR
 7SoFSnbkZ
X-Received: by 2002:a05:600c:4e86:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4bb8609ad6dmr6876015e9.0.1795075097389; 
 Wed, 18 Nov 2026 23:58:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:3611:76ad:c4e1:77e7?
 ([2a01:e0a:106d:1080:3611:76ad:c4e1:77e7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8532f1a9sm15704175e9.3.2026.11.18.23.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 23:58:16 -0800 (PST)
Message-ID: <04447713-32bb-46ff-8dd9-ba00bce186db@linaro.org>
Date: Thu, 19 Nov 2026 08:58:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/10] phy/drm: amlogic: Extract Meson HDMI TX PHY into a
 dedicated driver
To: linux-kernel-dev@aliel.fr
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <51831581-525f-418c-86ea-3b5c6a80709b@linaro.org>
 <bb027d3b-6a43-4dd3-9771-3448c86996b5@aliel.fr>
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
In-Reply-To: <bb027d3b-6a43-4dd3-9771-3448c86996b5@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/18/26 20:35, linux-kernel-dev@aliel.fr wrote:
> On 11/18/26 13:38, Neil Armstrong wrote:
>> Hi,
>>
>> On 11/17/26 20:33, Ronald Claveau via B4 Relay wrote:
>>> This series moves the Amlogic Meson HDMI TX PHY handling (covering GXBB,
>>> GXL, GXM, and G12A SoCs) out of the meson_dw_hdmi DRM driver and into a
>>> dedicated generic PHY driver.
>>>
>>> Until now, meson_dw_hdmi directly manipulated the HHI system controller
>>> registers (HHI_HDMI_PHY_CNTL0..5) to configure analog parameters, toggle
>>> resets, and manage power states, as well as manually ungating HDMI
>>> clocks and power domains already described in the DT.
>>>
>>> By extracting this logic into a standalone PHY driver under
>>> drivers/phy/amlogic/:
>>> - Hardware representation in the DT is cleaner, modeling the HDMI TX PHY
>>>     as a child node of the HHI syscon referenced via standard "phys" and
>>>     "phy-names" properties.
>>> - The DRM bridge driver relies on the standard generic PHY API
>>>     (phy_init, phy_configure, phy_power_on/off, phy_exit) rather than
>>>     touching syscon registers directly.
>>> - Legacy DTs lacking the "phys" property remain supported via a
>>>     temporary fallback helper (meson_hdmi_phy_create_legacy) to preserve
>>>     backward compatibility to be removed on next phase of component
>>>     removal.
>>>
>>> Overview of the series:
>>> - Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
>>>     add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
>>>     "hdmi-phy" child node under the HHI syscon.
>>> - Patch 4: Add the new Meson HDMI TX PHY driver implementing the HDMI
>>>     PHY configuration ops, along with the temporary legacy creation
>>>     helper.
>>> - Patch 5: Document the optional "phys" and "phy-names" properties in
>>>     the amlogic,meson-dw-hdmi binding.
>>> - Patches 6-7: Clean up manual HHI clock/power-domain writes in
>>>     meson_dw_hdmi (relying on runtime PM instead) and convert the driver
>>>     to use the generic PHY framework.
>>> - Patches 8-10: Add the "hdmi-phy" child node and wire up the "phys"
>>>     phandle for G12, GXBB, and GXL Device Trees.
>>>
>>> Tested on:
>>> - Khadas VIM1 (GXL)
>>> - dtbs_check and dt_binding_check run cleanly with no new warnings.
>>>
>>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>> ---
>>> Ronald Claveau (10):
>>>         dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Fix compatible
>>> matching in conditionals
>>>         dt-bindings: phy: amlogic: Add Meson HDMI TX PHY binding
>>>         dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Add hdmi-phy
>>> child node
>>>         phy: amlogic: Add Meson HDMI TX PHY driver
>>>         dt-bindings: display: amlogic,meson-dw-hdmi: Add phys and phy-
>>> names
>>>         drm/meson: dw-hdmi: Drop manual HHI clock and memory PD setup
>>>         drm/meson: dw-hdmi: Use the generic PHY framework for the HDMI
>>> TX PHY
>>>         arm64: dts: amlogic: Add HDMI TX PHY node for G12
>>>         arm64: dts: amlogic: Add HDMI TX PHY node for GXBB
>>>         arm64: dts: amlogic: Add HDMI TX PHY node for GXL
>>>
>>>    .../bindings/display/amlogic,meson-dw-hdmi.yaml    |   8 +
>>>    .../bindings/phy/amlogic,meson-hdmi-tx-phy.yaml    |  33 +++
>>>    .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  |  43 ++-
>>>    arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   7 +
>>>    arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   7 +
>>>    arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   7 +
>>>    drivers/gpu/drm/meson/Kconfig                      |   1 +
>>>    drivers/gpu/drm/meson/meson_dw_hdmi.c              | 203 ++++++--------
>>>    drivers/phy/amlogic/Kconfig                        |  11 +
>>>    drivers/phy/amlogic/Makefile                       |   1 +
>>>    drivers/phy/amlogic/phy-meson-hdmi-tx.c            | 309 +++++++++++
>>> ++++++++++
>>>    include/linux/phy/phy-meson-hdmi-tx.h              |  19 ++
>>>    12 files changed, 513 insertions(+), 136 deletions(-)
>>> ---
>>> base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
>>> change-id: 20261115-meson-drm-create-hdmitx-phy-4ac40a654d09
>>>
>>> Best regards,
>>> -- 
>>> Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> Overall it's very good, but I would've prefered a more sequencial move
>> to the PHY driver, with an exact copy of the code and simplification
>> towards the current PHY code.
>>
>> Anyway, the sashiko review comments are good, especially the one on
>> patch 6 to keep the driver working on old DTs, sorry my bad...
>>
>> Neil
> 
> Thanks for your feedback, I am analyzing/testing sashiko feedback.
> 
> About the suspend/resume unbind/bind, I do not have any issue on my
> side, but I can change the orders.
> 
> About patch 6 and the old DTs, I will reintroduce them with the legacy
> check. Do you know what would be a good timeline to add a require on
> those elements and drop the fallback code ?
> 

The problem is not necessarily the kernel DT but the U-Boot DT which
could be used by the kernel.

The U-Boot DT was using v6.2 before v2024.07 and after it uses the synchronized
DT from Linux, which coincides with the v6.11 DT which contains the DT clocks
changes.

It seems most of the SBCs distro uses recent U-Boot versions, and some nice distro
ships older U-Boot version, so it could break on those if a new kernel was deployed.

But, U-Boot already set HHI_HDMI_CLK_CNTL and HHI_MEM_PD_REG0 when probing dw_hdmi
since 2019.04 so considering that I thing the risk is super low.

Add this to your commit message and send a v2.

Neil
