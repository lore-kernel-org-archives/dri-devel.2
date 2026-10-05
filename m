Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A32CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BAF10EC33;
	Mon,  5 Oct 2026 09:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jw/IvOO1";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8744B10EC33
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:20:52 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a11603310fso14311175e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791192051; x=1791796851; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+t0/bgbwIAHS/RitDSg2WZrM92RV4Q4lP3kwWM+IQU=;
 b=jw/IvOO1Z9Hb0P2RYjqQHiRnqGWG/3C1QWtl4dPWt9xUZhH/RHa6v6GcKQTwgepoSL
 mXktIVZt9TUCGlF1kZwa/l8Z8z/r5UjCYXdafeTo/0HO70vJd21+aFPgsd94LucxukoF
 LyShNlaV+b3yWO5tjPQWt2ygvRN2/J+PU+qYQZL475gtm026vFfvZKtcRpb6wxqfBuZ/
 ULxync7S32XsSegOf+crr7+s/gD+BhYzYLFnQuL6XKsvgWjRBO9rrJLjqMDRQUWf7eSy
 OneuBtrK0Xcnvu4VSuBoQQy4euymyB3np19Mum4bQZZhRyrrra23GCSU/05aInXDFpMn
 pblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192051; x=1791796851;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+t0/bgbwIAHS/RitDSg2WZrM92RV4Q4lP3kwWM+IQU=;
 b=aBDxek2m+N4lId6uTOXHb4p6H7hbOGXryyU1125z9HHXGsQnC0kzS8G32wzAyx6COl
 mNzS5eZWesc+ULi+18cnwSA0ss5LvIa4EmL40zecFDz8p+571Ob9wZCGegI79uMi0kEE
 cy26dd/gRvw5Z6tMeFjC/poeT2g8f2a1y0ww353BIdpZiIW/PlM+KxRT/yUMuJSh/VS6
 zyF46ULVFzg0qhXU86bo6GsxwRJkWc+e5Fbq92xPCaaYN4umQ5YpEMJl0gSpSPoD/LR2
 pRHvXNoducZ/4XQ0JpY9Ozuk9nyXfq5HoEDhStBDyBxbfDiDDLtmfBmownPTI/d35fcL
 SC6A==
X-Gm-Message-State: AFuF++k1xpX9INFiTmfNiig6PS9jIIEKBg8nFgQWChEDrHW25iXvwMzP
 bwjGWVdLgv9rccYmWAL4Ya7/w/+Mn9iX6Zsl6u0EEBuGl90kO1enjc4CX9BB5eRCUIQ=
X-Gm-Gg: AYBFou3dd2KJP1U3+2L+GbMnGhfxtW4UwhY4kGSbW82bwdtpMd2koSVbGLVD6JWo77n
 WEoerKpf+R+1LtsFD0ZAN/A/WUEBuWQNw88EmnYR3av4IPjnEGqcuGiQ+fSqgGmWfUwgXuR8r7l
 HUfLtqwjEr0m/ST64UmyYylT6REZcCGjEWuVasiun2joAE5nB/QMAE4qCbJhTZd8IVgyDeNsbTs
 cmKcji554XrTBUh5DLPa6VpfSgcXnF5ZfbVX0/i4X2EAWMR7VzVzvQAIIEwlSArI27Oe/+r1LVk
 r9vo5vfb1NWe04eRJYcrUr1TY+Wm4nXvJQWsD4deFEallV9P8HVZVrtbLbxiTD3d5mTkH7VUVle
 LY+rUk7uqAqOUa9Jumfv89JpWe9Fm7KWXQMywwwDqV8t3d8UGVBuFiKz99yJvv79GNHLSALiofV
 H977732p0XuYmE+298e8GPPLx+bRhxqxsqnOHW6aiJLx2nrC0KozK1dMjWps+6hNCNvxOCsTcuo
 r7FLxvxiVY1tFPa0CMEzoL/2r7lHt0=
X-Received: by 2002:a05:600c:a010:b0:4a0:251f:a726 with SMTP id
 5b1f17b1804b1-4a02759badbmr165494515e9.24.1791192050671; 
 Mon, 05 Oct 2026 02:20:50 -0700 (PDT)
Received: from [192.168.151.46] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622bb17esm2201537f8f.45.2026.10.05.02.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:20:50 -0700 (PDT)
Message-ID: <0d4c9c46-18e5-4c16-855b-14f4ae64a1d6@linaro.org>
Date: Mon, 5 Oct 2026 11:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: xR-related properties
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jun Nie <jun.nie@linaro.org>
Cc: dri-devel@lists.freedesktop.org
References: <uyj25irtugtgmcr7xwt4n36ovi6tohawohqaf2mzga2iweuoqm@l2flbkpplzot>
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
In-Reply-To: <uyj25irtugtgmcr7xwt4n36ovi6tohawohqaf2mzga2iweuoqm@l2flbkpplzot>
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

On 10/5/26 05:09, Dmitry Baryshkov wrote:
> Hi,
> 
> During your presentation at the XDC this year you mentoned that the
> kernel needs to describe the attached panel to the userspace and that it
> should also describe optical characteristics of the system.
> 
> Having played with the Google Cardboard and other kits implementing the
> same idea, I'd have a controversial proposal as a reponse. What if let
> the kernel describe only the actual panel(s) being used in the device
> and let userspace describe the optics (in a way similar to libinput
> determining and applying device-specific quirks in userspace).
> 
> As I wrote, this comes from the Carboard-like devices. Users can use
> them to transform the phone into the poor man's xR headset. The kernel
> knows nothing about the attached kit, so it won't be able to export any
> information (only the phone's panel). Similarly, I think, using
> prescription lenses with the actual xR headsets would affect optical
> characteristics. Finally, devices like Snap Specs will have some, but
> not all properties (e.g. there will be FoV, distance to the screen and
> inter-display distance, but, I guess, nothing else).
> 
> Having all of that in mind, I think, the params of the device should go
> to the userspace.

I mean, yes they are for userspace, kernel would have no use of those
properties (until there's some hardware able to do the rendering), but
we need a common way to share those properties.

You're using an edge use case (Google cardboard) which has barely nothing
to do with devices crafted for XR which has per-device calibration tables.

Some will come from DT, some would come from tables in filesystem, the idea
is to perhaps standardize a well-define blob format which could hold all
those parameters you could gather from the DRM interface. So any
system (DT, ACPI, ...) could define those in an unified way.

> 
> At the same time, if the kernel grows up support for the response
> measures (e.g. performing CAC or waveguide demura), we would need to
> describe necessary properties _to_ the kernel, which mean userspace
> descibing optical characteristics to the kernel driver rather than the
> other way around.
> 

For CAC, the parameters would need to be set from user-space, no doubt on this.
Our questioning is how to handle the variety of ways to handle CAC in HW.

Neil
