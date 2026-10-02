Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0720CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72D910EC76;
	Fri,  2 Oct 2026 07:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W5hbAON0";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2649310EC76
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:29:03 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a0977b9c20so4266335e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790926141; x=1791530941; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6zplr7QU6lV0JIsmwOjHD1EDA7HxZc99c9t5ZOt0FqI=;
 b=W5hbAON0WLnXcOtEPMIac2vLgmjxrf06yjQMdmdCGMr44Tf7VnL3YjR/rpT7mvyFdZ
 VUpuk2y+8Bg8Bk60UpWb+RYW6S9n/92uCsEL1RDbV37BVlJIAJ8ahYO/hXzu6cIXG93A
 G+akIxNUeR6SZj3K/7C7Alhv+tNQKWhsnUa1W8lBe179IIDRrusPopG8sqYT0m3ipF19
 8ixRf0/VwVwDQnTFt7br66HbAViq7gbU6m24Xx58ba7ubR53y7jUZ18zRWI0xmvY8MUu
 g1gaue7FqRr7ITQKjiFbFiyDRcL79pgQA32GkvuQD5LxF0LfA7I+QMsdTTB1RcZON6xX
 ajTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926141; x=1791530941;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6zplr7QU6lV0JIsmwOjHD1EDA7HxZc99c9t5ZOt0FqI=;
 b=pvfPVeR3b/Wu25iYtSDTuOXUy5K6KSgeIczjKyWxFvsvN9bUMDKqV68lZEIwUly/5l
 XG+HikASyY2PGLb26seR7XMXgXnX2wrmxr1811HfMuYUY2Oh/uubZC06eyc/DXMCOUG9
 7f4PhuJCQh90460ERMZkdNGCscQ5nAA9ZYsVHomt7iHqVwsNJyc9AP/s5z/aLFp03be9
 eboXRrkO3Px8JIvOkX/3+zaIcLeyNUm7lDrXGptWNjMvalIgbOX08URoprrH/Apxs5SB
 QAq6bWu2Us5S3h+x1LQcQwtmnaPJSvEz9MGPg5wXpT5fIl3sIZk4cbGzuSlBaHpjUuS4
 berQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8uQiVBMquzpR6YMjE1rTTY/Tq0D8sRDbgvobIqt0LC5Oo3yxM5TGrEGV0O9vfggN5STphH+EqIU8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mGVG9u/CsikM4PXPQTkzGTOBstml8aOjDDVpFBx8+btKHrYPU3
 0LtKf/B2sRqmz2l5qpTKUQe5S4vGSj5NsrX4dqmj2+OzA+srP8u1g0ilOr8uQi1QaeE=
X-Gm-Gg: AYBFou342LxpAoEtbfwgitvEVqgJ0McjvddcoeuWhjg6C27infraP4jE4ufz30JpqlB
 oGJNdhBvHsmm4OptgnsfwzIa6iY0mlrfXk6sFvWQdcOWqNb7lEdMJZvhZ7B11YT8BHWTi+PxzVR
 N0QN4q5fPXqGeZ4oNYeZjd3rYM01SQIRrgO97uBMSY+WvDKnH8QoFuNRzaS6n4l7vVvtY7T2Ofx
 xy78zZpIdYjNclsqLfbPRHCsZlZBXMwt2tVED3f3p5ITD8qlk9K0SP9TSFtFRM15CrWHgSEPGxL
 tD2u1+H1bwtkVbwlsMxCWU7icP/BSmGEN6fPig0Og5I4hsiCA7aWWqcjd15D11+JQ76hBwWTJ1Y
 zg9pibPPROrD/H8Bu3xw8qodoRJx4p4Yy4WMTqyzw1piZ4KiFwB/lGqdwONYKmZjJDoQOvJX8rN
 lTekqrT6rLuFpgTgTOIC/1v+BgcVspIEVcTSoKTHzLPqJIw7KvdHGa9cXhM/x11yUr43kT2tZUO
 Hn4fUF1fUyY9FUyx/EOLhZsOrr9tyiXdDEWh60qUJZkcvz3ze4aXgDZgvUTWg==
X-Received: by 2002:a05:600c:1911:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-4a02756643dmr30178595e9.10.1790926141218; 
 Fri, 02 Oct 2026 00:29:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a039505568sm42454685e9.3.2026.10.02.00.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 00:29:00 -0700 (PDT)
Message-ID: <ebe0714e-cb96-4091-a718-97dd9c081710@linaro.org>
Date: Fri, 2 Oct 2026 09:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
To: Maxime Ripard <mripard@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
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
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Benjamin Tissoires <bentiss@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org> <artyl8fD3zzng8Uh@houat>
 <742d5bab-51cc-49f0-825a-f299a055bb1e@linaro.org> <ar4G864IgYTvfNNy@houat>
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
In-Reply-To: <ar4G864IgYTvfNNy@houat>
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

On 10/1/26 09:09, Maxime Ripard wrote:
> On Wed, Sep 30, 2026 at 03:32:19PM +0200, Neil Armstrong wrote:
>> On 9/29/26 10:39, Maxime Ripard wrote:
>>> Hi,
>>>
>>>
>> <snip>
>>
>>>
>>> panel-mipi-dsi-spi is a generic panel that will load a firmware, and
>>> quite similar to this one. google,android-pipe and qcom,fastrpc don't
>>> attach to anything and will just open a tunnel to userspace, which is
>>> somewhat equivalent but more dramatic than what this driver is doing.
>>> simple-card or its variations will just instantiate a kernel driver from
>>> the DT and is used pretty much everywhere.
>>>
>>> I reused the binding from panel-mipi-dsi-spi for this. It was reviewed
>>> by rob, and acked by a panel maintainer, and 4 years ago, so we're way
>>> past the "oh but we didn't know what we were doing back then" argument.
>>>
>>> So, let's phrase this differently: what's different about the
>>> description than panel-mipi-dsi-spi, or any other binding already in
>>> tree?
>>
>> The panel-mipi-dsi-spi still describes a class of H/W control interface,
>> not a pure software driver implementation type.
>>
>> "panel-mipi-dsi-bpf" or "panel-mipi-dsi-rust" or "panel-mipi-dsi-cplusplus"
>> would be the same problem.
> 
> Rob explicitly said the bpf part wasn't the problem. Also, I don't care
> for the compatible itself, so what would be an acceptable compatible for
> you?
> 
>>> If it's the BPF part, BPF is not Linux-only, and there's hardware with
>>> direct BPF support these days, so it can be considered OS-agnostic and
>>> not an implementation detail.
>>
>> If somehow panels used a standardized MIPI firmware we could define this
>> in DT, but here we're basically inventing our own type of firmware from
>> thin air.
> 
> That's not what panel-mipi-dsi-spi is.

What you describe is how it's implemented in software

Neil

> 
> Maxime

