Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C7607150E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w1DCiU1q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E6810E0C8;
	Mon, 23 Nov 2026 08:06:47 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA9C10E5F1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:06:41 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso20636385e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 00:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795421199; x=1796025999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0/cAHzp2byEXTdt5JI13O+MKxbnMcLe/w5DVxG6Ogbo=;
 b=w1DCiU1qm7b2AltGu/n7irI8TfSq88jpXvOZ4O5EF5bxd5tyA9Vbdl2uOm5iE4o3oP
 8Yyaa/sGfjBlLzYEx3KR3smj8ayg+0KLoQk7EaP6SKxdg1HdDso7m5dCL9EwXZegga2k
 /AFXSxIt7lPEsdNCS3xewmn9Xxq84HQpbqWn9hFg3k9xWUBweQdex31ItvZlqMNk8gzn
 0M8TkXQ+K8944BzHDmHeae2Q+oPRzrmVbsDdoURb4G+uSBJXggFfE2GBargs1MlhtnfO
 Xf169euviub4sjLMmbbFsdxEFa20M+U9zxdkgUnBGCuSjVVAhp9KWtI/2lLBKpg8X5fb
 P8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795421199; x=1796025999;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0/cAHzp2byEXTdt5JI13O+MKxbnMcLe/w5DVxG6Ogbo=;
 b=fG9KJNk/emCZfjVyyRPT6XBi1RPFdU0rMOle+KrF9C5JRnvGu7ExIHFscf4CD1CxJW
 HCpx2Pj/k7Vuiaz3KfjLNbXpaphDJUTaOMiW4xOQJSkPeHow/G4rjR8pfARhMPa9R3Rs
 4uEtDnoZB1XTj9IV+HiseKuYC8TAEa4V+Uza/nVJarq2hXSfy9o+FjCPn9WgOOhXg14y
 +Vv6EEjLDoImTAnxAnrZp4kJgmmJLL+V3M3LFldRbU3ksN0YVa1m5RNdefBwpaAK7JmE
 yjD03QjkkGYTwPd2ZmdEJ7TQod0WQo2MxtV+NXS62VpArJAgi47CYCP49u1ij6GmBEmu
 imHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGABT5DkU0mcPhvh2mZIGH0Wy971EZo/n2rHRcc8x0sgBGtTisQB0XxFbtN4vTdH48mebZFkkvCO2Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+rGOqcckCuEd9v35afl211saVUoTKFJV1OPjDlOYA+uqh6KGAC
 7D0Pmj66hQkKq3I0wNH4GGVIGHJt2ao0Eik7KK4Yky3ZHjquyL71TI0007iD8n+pz/c=
X-Gm-Gg: AZFdTZc5vIse9orFlHMj8UdSRU203fMa/xCe905MGoC820azm85MeLg5Rfw+aGyoFXa
 KwRHgd4njW5M15UtH6YWZGSnG5gMoqHQu1KgUxZzVrnKhKlm3uru+c5Z1/ubQ6hICzqweCI9cwW
 8ExkitdZQu9Okz1pTSakSUc9/lyR23KBUErwc9OICh7znGF46nuFNfq6uxut6DZ9zAwn6WyJm4G
 ayIXqvKz5zuAjo0nDzsQHWI3yBKjTN7FbTKtbfIu07oDCpysNiHP1jeWgL82r+sxVVseUvvcNDg
 O1VmvF2ToUiTh7hgWErQlIwLsQzM8G9DGrWMwylD5x/rLYCQoTNGSkgazAQ/LbLzCKETeh4s2tY
 hS6gbH//0pWVSJ1Tr2ilOg4gZ83I9PsoA7P/SATRvrg/H3aYIZ9zhFms45uktBcoEXoPTBbhTzO
 2aRe4kojVSm/W81CEN9jLJwj0fHpVbzj4iUOS+ga3m1e7yiVMG+YPnScC7UHtKqD/YHWX1WMz7m
 NqCD8NsU/3ush+soZVO/ItRu2M6XFdxJ35u08Gr/Atq6QNQSc3kTAhJwIhc3S8Ix16C3Bb1HInR
 RKToXM6TgcFdkCNpHd8DH92l3LAU5pTkJqgfqVaLvCRcl35Z6MzVmonp1KqbxzavI0EMPpGWZJd
 vUBtwftVq
X-Received: by 2002:a05:600c:c09b:b0:4bb:665f:7e52 with SMTP id
 5b1f17b1804b1-4bb8880995dmr161630505e9.10.1795421199031; 
 Mon, 23 Nov 2026 00:06:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:121b:474b:8d1f:a239?
 ([2a01:e0a:106d:1080:121b:474b:8d1f:a239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a12acsm360424565e9.8.2026.11.23.00.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 00:06:38 -0800 (PST)
Message-ID: <2d8dd4ba-26ec-4b01-8361-09e6dfcfa5ed@linaro.org>
Date: Mon, 23 Nov 2026 09:06:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 02/11] dt-bindings: phy: amlogic: Add Meson HDMI TX PHY
 binding
To: sashiko-reviews@lists.linux.dev, Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, olteanv@gmail.com
References: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
 <20261121-meson-drm-create-hdmitx-phy-v3-2-f8f471788076@aliel.fr>
 <sashiko-outbox-227302@kernel.org>
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
In-Reply-To: <sashiko-outbox-227302@kernel.org>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/21/26 20:26, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] dt-bindings: phy: amlogic: redundant word binding in commit
>    subject
> --
> 
> commit fbd4563b5cd10db3f75db052197f808e3b36bc55
> Author: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> dt-bindings: phy: amlogic: Add Meson HDMI TX PHY binding
> 
> This commit adds a Device Tree binding schema for the HDMI TX PHY found on
> Amlogic Meson GXBB, GXL, and G12A SoCs.
> 
>> dt-bindings: phy: amlogic: Add Meson HDMI TX PHY binding
> 
> [Severity: Low]
> The dt-bindings: prefix already indicates that this patch adds a binding,
> so repeating "binding" at the end of the subject is redundant ("dt-bindings:
> phy: amlogic: Add Meson HDMI TX PHY").
> 

Use the "dt-bindings: phy: amlogic: document the Amlogic Meson HDMI TX PHY"
