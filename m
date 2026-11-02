Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3A60A2609
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mwoC+XUT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BA410E63F;
	Mon,  2 Nov 2026 13:50:35 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C36C10EE6E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:50:30 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so34780115e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793627428; x=1794232228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYzZ8BXsqKNPCCkmaMclN1iluhESF/luBfx+Wwzl4G8=;
 b=mwoC+XUTHBlUoqIfcbEsMx7FrtFum+78TW+lkPgsgwWdl6epC/9fvwvBEwA6d+j+pa
 GXCdKBcsB/zXOYqE0CWwefZRgq2GVKtELiXmCO1n5sYdDIcgEnZcTd5Npeg93+bfBsuS
 C8ByMkPMKxSXXk5w9HuCIixdhiUc5raSljnhqLZmPs5YMnC+sp/+i5LA7jv4mGptzJX0
 zoG7QEMlM93bYr6t8JuPRfEW7HmLe8P2HvcKqIXIa8Ss9D+4X7+iA2gUAF9dPxtC1AhO
 BPEcPXH2SSBa8AF27ym0PUNuDqQ6vAG0GUuQW8mN3gRXJ4CEQazeYOrgN8l7BcrDWLz1
 4VhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627428; x=1794232228;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lYzZ8BXsqKNPCCkmaMclN1iluhESF/luBfx+Wwzl4G8=;
 b=YNIr1qBFmUA820oSl41gvFPeYlSG7d1Wl2d1JMPhSzgQp+9UCJ1kyT/vxSPfOa0ncy
 jBD0di5g+0E2TCFvrLnstaTiHD8Pk/c91Umj1oBUISl7S74U80pYC+GLQ4P6ANqRT/xH
 wjMV61O/ywSl0EYeirPMdfsCRqU+/3ozdsx1V95MGz8u9bUE4DqZihETflSrkoKlWNkv
 anrchFlHLaw/sgQn7Qaq1gH0wM3h9fRqYp/PSfjzQYyxk4Tpdi9m09KHgHpxK8BusEtn
 W3LPKvH4ZtsTsYANLhacdRO5E4vwMQxTlxNZ5l3k0UdJ1vvlmV7amxUVWEsgeNespuRX
 XW3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmQBsMNR9xVK/0o+b0r70RXIUVqEAZfOjc52gJkFQDlgViF0GtO8+7f8CLtJ1353NXR9batly8RAQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJby2KZ8KnV7Q91ErFzkQEWf/i2QX/e4s/+CNMEmkLfJMxq5wuA
 KSVIauOIic+566qLRsZyzMhmMANN5liEU63/Q0yuKr2EyNy+s8C30OngFgvkqQCQwlU=
X-Gm-Gg: AYBFou1uv6fcEh4b+zLa2iC0W2Xsp7NBfut2ZN01YUECw/gmrUiJLis8I9xBJOJ2Lp2
 39aDSPAbvc68A6Q93KebqnB+8co6oY86K+37Sy8zqQSdIM0ayaVhPRyplPIktOPRKKLhSD9w8xK
 yP5vCxJvUG9jvGsMM5QFKyL3Q0DOIKOXTcJaGItYu1t4bL2RtsocBxLyvfkEuBQcpobhiaBBgO6
 K9QZt21Z+h32pSusrOlChv1iSal+3UzYYO7tW5idRiqEqfOTpS0jPVmhEr78/dfWbFf2s95VdCD
 oqnwjH2AXBZI08ml8DvQtu57KqPlf6/LT17yaWO3hbhKxVWLTB2ojHrLyB86o8+aet0bJM67XLy
 ieXEvkECRAkpa3ae211I3tiFvzr+WOoVYkA+TV9z7S+Yuh3Ry0py1LPni0CERiNFTk+vxfpgGz4
 2NUzlTMO9stTGZCpqVthLma9Igr21NeEUloWV5ZJ7leXKA01mGVOqWxaEOPl9ARTl/D/4FZtQ7K
 VVWLO1EpP3KFdiPzQXj+B6VMxM7HfFzA9EiQcPjzOWXfiTSxKgj93hJdNa/taBM2j5llDFBVPND
 2ziMEe5MDAL318Zstt0oZ1WXvX4tP0qHTn2FSwlJVJDmRmz9I+l4GJb6fjzJv26QLomsmpRQv0w
 wbVaoUg==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4ac185bc4a1mr235570315e9.27.1793627428483; 
 Mon, 02 Nov 2026 05:50:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a5a7sm21252789f8f.37.2026.11.02.05.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:50:25 -0800 (PST)
Message-ID: <7116571a-ef82-4aa3-b7fc-fd7863829c9e@linaro.org>
Date: Mon, 2 Nov 2026 14:50:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] drm/panel: ili9881c: add support for Mingjun
 MJ070BI30IA2
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Icenowy Zheng <uwu@icenowy.me>,
 Han Gao <gaohan@iscas.ac.cn>
References: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
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
In-Reply-To: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/30/26 06:44, Icenowy Zheng wrote:
> Mingjun MJ070BI30IA2 is a LCD panel used by the Lichee Console 4A
> device, with a initialization sequence matching other ILI9881C
> sequences.
> 
> In addition to the normal binding + sequence panel adding part, this
> patchset contains one extra patch trying to address a hardware quirk of
> Lichee Console 4A -- the panel could never be really powered off /
> reseted in hardware (the reset pin isn't wired to the mainboard, and the
> panel is powered with a always-on regulator).
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
> Icenowy Zheng (4):
>        dt-bindings: vendor-prefixes: add Shenzhen Mingjun Optoelectronics
>        dt-bindings: ili9881c: add compatible string for Mingjun MJ070BI30IA2
>        drm/panel: ilitek-ili9881c: add Mingjun MJ070BI30IA2
>        drm/panel: ilitek-ili9881c: do a soft reset in unprepare callback
> 
>   .../bindings/display/panel/ilitek,ili9881c.yaml    |   1 +
>   .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      | 226 +++++++++++++++++++++
>   3 files changed, 229 insertions(+)
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261030-mj070bi30ia2-cd8b24ab77fe
> 
> Best regards,
> --
> Icenowy Zheng <zhengxingda@iscas.ac.cn>

Could you rebase on the lastest drm-misc-next ?

Thanks,
Neil
