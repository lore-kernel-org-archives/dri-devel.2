Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79965606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TtZnrUJS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79C810F99C;
	Wed, 25 Nov 2026 08:15:02 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68BF010E29B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:14:56 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso3346495e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795594495; x=1796199295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rc4aqCyzYBjWOigmv1O5fiE2Ptnz+1fYVaVELpdQ2fQ=;
 b=TtZnrUJS4LN8vf2V/o6nYMenvGdQYosZc2JCTFezay4w1L85x48oynMMl9rMehNr4T
 ERk9U+M7jtthJ2fbnsOOYODAuK9IOMBDaA8SuMmyAlpxF/H9a3af/ux4DmmwJ+izIFIk
 3YH6Z0vGQbo9yMqaPxd5IeWKdiOyPTsd+TCV6gJfIAxwruL2fMzSlo3kh3ZFBQKHNGrb
 lTeDW0hFz0B8uY/4fvGBuAaYnbPY9px0gqj5/WPqrptOYejqQ0Z0j6kcS2kVMGXrH6os
 G/kyRWM71z0U6WUU81HLlqvBavMFTOdKs5VYgugIOWZYPsdH+o79LAf/y8lGotgEHsnj
 06GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795594495; x=1796199295;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rc4aqCyzYBjWOigmv1O5fiE2Ptnz+1fYVaVELpdQ2fQ=;
 b=dC8DjJYKIqwbqA6Rd7zEHkYI9s9bwdf5kZ/YEgp8zK6WLtBX61LEEHnRaIaKvkNjtG
 8DS8ISJjFVgahUlPGvMVXT4cPkWI65jLOy9M634w+N1MZq5FG804zM4Si6k0pnb9Iki5
 H8Qg90gF3MvT2z93M0EOrlykJEe2J3Dr6sP6s5Wcnw/FJYZuVEAl62B7aHryJ1DmWari
 BlebDoL9Ym8al9wsVXSbDUUQ+FMjafBtVgz3CPZkz0dsKC4Uiz2wFDwnEMZ4Pss7Zf6k
 8VrCX1gbTHXDnKliRPg2AQz6AgAbnNRPbfH9hUDmA2LuayyeuRyFovi2wzQfAswq2nwb
 hXDw==
X-Forwarded-Encrypted: i=1;
 AL+hErFVxcCNaN2sAIdWVO6omI4O9kZDnU7RfFnMD6cTqF/1cFU79PzLZWYQFCQPbiQLvDtMKmYPXiqboXo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9rY1YNUJgB/r9fa62KDXuI6x9vnbsRRBMimPEAgECfo7/v+pwP
 Y2R+tli/MNADk7WWD3C6WLNyqb1H3VQazlLf2EldNwO+tccjmGuES0a/FIaFViLvxoI=
X-Gm-Gg: AZFdTZfGEOXWKR4vCKYYvogJUjaZVuH2pdk7DcCjQ954G7AaKeZrdMSA+6OHJGX6PIq
 XJX2X0/cir4rUd00EZ22jH4D/Rrn4YyvCGAIohnZbEClrHCGV8nPViRHjIazMWC4gic7j3b/Gti
 BLXQyUvgj1bQjrVxRef9rb5IUJ91ZmGVnpiRgZK6O4iQ/J/1Lvr7ovOBZRCBiHRhGWfgS3gJQt8
 E3IzbiFw3EIx8rEL83/WVboXQ3KJeOr0uqSQSbGu6La1wMXuLj6iD64L0mnV82vKcqqcFgqixsJ
 XutEO3+3QpdzKBucLS0h/p0OOt7b+7z9200ljR930L5d2DX8vfUs8klzaAflH+iXhWUjKgcK60g
 hT4MlBYnft9DpRqvkmFFMqwkxVJ5LXq8A9GpJ8Qvu7J0EgLijOB0LXaUhYW5Imciue+1B9bQWxU
 R4FIBQgcAhzN6atp3TJR9Q9gqDL2l7mXS+5zP4mNRIhQxJ/Go9R1KKq+xaCGRz1lGO2JfN0ljeA
 dUw8JYfS+bzfttNgZSst8W4xUDFaKdHRjDW+ZsgMyjRpnmgMmo6nMpeBmaEWLNPvcnTHvwrFDcu
 SvzhIYxbwlE+H8hkH971kn2KWn5+6Y7wGP+G4/qKScozazcNR5/HnRiioihr1ZgUDhSzbm8mSBc
 Cg61C6XoD
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4bb88800020mr372318965e9.7.1795594494562; 
 Wed, 25 Nov 2026 00:14:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:f368:ae2e:e717:e970?
 ([2a01:e0a:106d:1080:f368:ae2e:e717:e970])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bba3d3679bsm26993885e9.2.2026.11.25.00.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 00:14:54 -0800 (PST)
Message-ID: <6e408f48-17ca-4927-ae09-c4153e294371@linaro.org>
Date: Wed, 25 Nov 2026 09:14:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 00/11] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel-dev@aliel.fr
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
 <CAFBinCD822UPQrrd_8ZbVRUVCVJ-3pGN69vbZBxUE+0yeMcysg@mail.gmail.com>
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
In-Reply-To: <CAFBinCD822UPQrrd_8ZbVRUVCVJ-3pGN69vbZBxUE+0yeMcysg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 23:05, Martin Blumenstingl wrote:
> Hi Ronald, Hi Neil,
> 
> first of all: thanks Ronald for picking this up!
> I like the overall approach. Before I dive deep into this series I
> will finish the code-review of Valerio's AUDIN series.
> 
> Two quick notes below.
> 
> On Mon, Nov 23, 2026 at 8:38 PM Ronald Claveau via B4 Relay
> <devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
> [...]
>> Overview of the series:
>> - Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
>>    add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
>>    "hdmi-phy" child node under the HHI syscon.
> It's been a long time, but I think we've been asked by the devicetree
> maintainers to have reg properties for the nodes within &hhi
> But I can't find the message at the moment.

The hhi syscon nodes doesn't have #[address|size]-cells and so far it
wasn't required, let's wait for a review from DT maintainers, I'm fine
with the current design

> 
>> - Patch 4: Add the new Meson HDMI TX PHY driver implementing the HDMI
>>    PHY configuration ops, along with the temporary legacy creation
>>    helper.
> At quick glance your PHY approach would also fit phy-meson8-hdmi-tx.c
> There seem to be minor differences:
> - two additional enable bits in HHI_HDMI_PHY_CNTL1 on GXBB and newer:
> HDMI_FIFO_ENABLE=BIT(2) and  HDMI_FIFO_WR_ENALBE=BIT(3)
> - newer SoCs seem to have HHI_HDMI_PHY_CNTL3..5
> 
> Meson8/8b/8m2 HDMI support is not upstream yet. That's why those SoC's
> won't need the backwards compatibility code. So if you need to tweak
> the driver: feel free, there's not much you can break!
> 
> 
> Best regards,
> Martin

Thanks,
Neil
