Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969C8CA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07C010E386;
	Fri,  2 Oct 2026 07:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CrS8QrOH";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190B110E386
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:53:12 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b05fdb2f9so1717037f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790927590; x=1791532390; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=URK5hJaiby1L1KtEXv2HgCyxpcy+Et12hnj8ni1/g3I=;
 b=CrS8QrOHBDgGeGfcALM09NriLS1opTaaIFIKUjzYPxKFTLJsQ04H30zlznObBkGl2o
 grLy59F2fC9GHENGdV2qnsh4cemi2yvK18ddOoaa8E2TT3htJ6NKg27lhycSVlCH+KMO
 55wTYrly3jwiZPEFL2q0+8QbFYtqielYTH8SyVmrIGGKRA23HUdNYvAUei82kyPsqk3p
 vhzd0hso5meAYge+xr7i14Zg4E+6I/jtcOVOAULAz9a3bn/Q2JsPAXVDeU0Gzu8GVOcA
 P2/C8zeYeiOtfdOqAdhPK1Ur3VzKkrd6uEbIHf40xP+SKtPNsi/6LcK9FxyWKV5TEJcm
 lP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790927590; x=1791532390;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=URK5hJaiby1L1KtEXv2HgCyxpcy+Et12hnj8ni1/g3I=;
 b=11Ehnzh0uJRqzbhj/yoPFdPPa6Hg9C5rooFda9+4pETc4rGFPXfJ5UBoaKwS32lLYy
 ssXQmwyr8V8WnlfcDqhSw3sqrhBQ9s+COSEIFlI3FA05uMfw4n9Z7oOhKfWNNZDuthIg
 cUl3lrrj0RiH2pXdutLNIjZPL2DoUjIq+7cyi2kn3U1QpAb/jBABxLaPN378K8QCMjIm
 mhYwTXE4St60TFFR4y4fHq/oeL97jUjqSiRPNrJldQCTQyKxTUXCMjMN2l8YK6ALve9B
 rJ4VbD45Kao7f9WKXuTPby9V9EUZDLaWawzE7QhvR+mQ3OTr9pwiNfS2OcqN+EU6/yVT
 /UTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7Xw9R5XuArOBv3vLxXPDoaJFh6+HP85WiqylxDVFM22RqplxuW1qsUdE+ASt7n7okiW4E6ilKI3w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKFzT32owssQ+MQJzHAjOvi1DnqcAqvKu7qRHT5P0t/P32Irf8U
 PsphTeZA0zg/DuttWIRD9QYncGZrzLjevEVdDV+is5/HBMXXMq1DoRIVGS84XaRIyk4=
X-Gm-Gg: AYBFou1K833C+ADvPBHZGS9w3Mb33TkZ1/N3thMTwhb8dP7nDNQZvZwQLiRkSzRDGxo
 VKqOVJrcxfcJd/dVvz1YSVNI2fSMTSnxF4GBVr/b7g/n2JlKZXrfRfk1Fqjbcz0e80SBVeSrgrY
 Jdciu3yZ+Bk5W/+1UkJf97XsCVESghGxz+BV3lvORjHOiMC8pJX2wEM6uEmCz07bYbTOcn1oGFV
 Uje3JrIXPrmwAYoytpcxrSMi5je7kN6c/wPIfumxyOL/P1H0Qn00U2TJjFtrouSMnJt9TIWDWtC
 OUmaxlxSbIxuFGl8yMbjSZ+TPGUbUjxzfN3TWLwb5Pm4d+BHcQzdPZj+QSWUnZZnpQbBTb42mao
 Qx34kOJzoc+t6VeuWUgHpblzuTGSFKO0mLH58wdhPLOtwjiOdbqQ6x1zjjVzYfHzdnDRaOGDL7V
 f6b1Mjv5ivq5kKmHB53hfiJHO2PUlsXRZHxkdY+tas5axoFl838dAk4x8G9gYG4lOYcklGyWekL
 yPygcfzlcYGW04LPcOq8di+hWhS5ySKEfxIordc0gQ2oGXBG4NU
X-Received: by 2002:a05:6000:46da:b0:48b:68:592e with SMTP id
 ffacd0b85a97d-48b126c2526mr2669376f8f.4.1790927590269; 
 Fri, 02 Oct 2026 00:53:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f0ab7sm3840821f8f.7.2026.10.02.00.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 00:53:09 -0700 (PDT)
Message-ID: <a92aa0bb-d50f-4b67-a645-942090d4fe79@linaro.org>
Date: Fri, 2 Oct 2026 09:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve
 <aesteve@redhat.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org> <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org> <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org> <artpBMeM13Dd0lLy@houat>
 <xlv1wls4ebjq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <828c9108-2db1-45a6-9301-19159a094301@linaro.org> <ar4CRTMQGs5_nGKY@houat>
 <2bd17843-4a65-49b0-9e10-7b73afb206b6@linaro.org>
 <xlv1cxtsft8e.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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
In-Reply-To: <xlv1cxtsft8e.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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

On 10/2/26 09:37, Javier Martinez Canillas wrote:
> Neil Armstrong <neil.armstrong@linaro.org> writes:
> 
> Hello Neil,
> 
>> On 10/1/26 08:50, Maxime Ripard wrote:
> 
> [...]
> 
>>>>
>>>> I don't want to add a supplementary maintenance burden for the sake of using a cool
>>>> technology which has serious drawbacks and dependencies on user-space even if looks
>>>> really cool.
>>>
>>> Spoiler alert: v2 won't. I've got the in-kernel loader to work and thus
>>> you can have a built-in panel driver that works without user-space
>>> intervention. So this is not a topic of discussion anymore.
>>
>> It will still have users-space dependency, meaning the BPF files will need to
>> exist in the fs when drivers probes.
>>
> 
> It doesn't have to AFAIU. The BPF programs could be built into the kernel
> image, just like firmware binaries could be built-in as well.

Right so my main question still is: what does it solve exactly ?

All the descriptions I saw so far is that it simply moves
the panel C code to a BPF code with no other additions.

I still don't have a clear view of what is precisely solves.

It adds some complexity to load those BPF driver, adds some
maintenance complexities since with every API change we will
need validate BPF still works in addition to C (and maybe one day Rust).

As the maintainer of the panels, merging a bunch of new panels at each
releases and helping migrating to newer and modern way to interact
with panels, I think I have the right to express my interrogations.

I'm clearly not the oldest kernel contributor & maintainer around here,
but the main interrogation I have when submitting, reviewing and
merging is : does it really solve something efficiently.

I don't want people to be frustrated by my review and question,
but I feel I'm allowed to say I'm not convinced about this solution.

Neil

> 
>> Neil
>>
> 

