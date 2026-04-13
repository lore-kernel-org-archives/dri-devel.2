Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A7DEBFD08
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A10F10E32E;
	Mon, 13 Apr 2026 07:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ogAorxhi";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D0510E32E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:12:16 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso69030335e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776064335; x=1776669135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nlmjxh1MtlwNMpIIddLFKoO92223Pp5bRATczu14GeY=;
 b=ogAorxhiuKKKcD1usAI7AQ18HNnP/4kwVMO08K865y0lGdJ7GiLr5SHANKuaan4YMa
 MR5yg/inJYuoETvmIGV5WuyaaiueMtu0LfXksf2ec90lcpNnihvGgg1IRxv3nlmaRcN4
 riPYHxvjjifKvyjbuaF3ksBRx5dNyGUThYskSEdV44QnGqYqNkOMWNP24+57NJm+PK38
 g6kewYi4A2Lp0bRXYsj0gKZGzt/wxinFfYx3gNEmtdxXpwrTq1PfwTIqf6ZnM8fcJDIr
 0fuyNlhz+nb6k4lbo9ZkHnA1Z40U1yFOMgEpOQphNcPRWiFIpvNc27GL+Vr+VDf97HPW
 kQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776064335; x=1776669135;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlmjxh1MtlwNMpIIddLFKoO92223Pp5bRATczu14GeY=;
 b=o80h6yk/l5OpwKglvD1JI1qzAhWkRhxaglkXLGUdRu4BEbjBTgpiAj+0I/VJLJwSo0
 +GyYMNhF3ty9aFVNUbuzSkfvfM7xRrX9mMuc0rai5zyCQr4qBy1Mbq8jzpfI6qtXpOt8
 Zqieq9hWtWLS/fzrNhFVpLKSoMd4v9AtkjPbl+I1T+dl/RYkIpKZ0oCytBSpHMoN4u4i
 kqFdFaPyXOOQIIB0Du7GpSOSGXJ9e3i7463hNhUEtfFSi2aRaD340gR7wwRVz2orhSvr
 tsvBk1L3cHQGXP4B+o4/refiHHdJ1oDYrxoVwzOYK9gNVv95lljt8JmbbtIlOV/clXXd
 Gb9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vgpSpIAbRvhPynI6QV91d3try4aOHUbG1rPsrH9W4IAKyaAXcaWwniRDnFlREW9VufLJDmWL8uSo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPkwO4Fk4y5xhcEPIMKctXkrtKINn650H5y2dT274z25kam59s
 P6Zcihj4i/Tteg9GwhLZZOT3LqWppV13n9oYEat/gyGfi1m3xBr9aZJs3FLTLqCVmf8=
X-Gm-Gg: AeBDievhxqsXKKuYFDgNmyVwex1UsmQ/sE/rRhOU/OXBadV7k/2pPv/7kO0Sn6HOw62
 KYqAkAeCwaES/TWQXYsJz7TvzDpWEQ4h/9GHWPrTQ0sNer+7qeMmzajINBNyaYgAaCGAdyi8elp
 jmAmLrCHUO5FBpnTHssZGKvs91dVLncFh/fZHUmEW6ewZkeHep2gazjGp5rPTGUq36UmT4l8N6r
 ivUWuCCGQb74k30I4hZOkGHso8FH75JO6M1FOKuBVeXpgiECmpIyGtaARkl3EwNt1KyKr8gYV7s
 iYFogaiSZgQAYl7AetUBCpRxfYdDvM31WvSjaw71tUUZdBhqXl/KpMEM9mmVCOg1bVC2joxzAsa
 LXoGF2/4TX5BDIzu8GDRTX8Dln8cIYdubDlj2GaymYRYo1+IafqpKf5NXaakM+dUu7dKYo0eyFQ
 7ZrpXM/6F05DaoCZwDLgu24haAnlz1GdghRKBcJo7GF9a0k1s3fLU7wcnVlGnosfo+O1lEHCWwf
 aVMaBo=
X-Received: by 2002:a05:600c:c16d:b0:488:be21:54ae with SMTP id
 5b1f17b1804b1-488d66504bfmr174467825e9.0.1776064334547; 
 Mon, 13 Apr 2026 00:12:14 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25?
 ([2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d592db30sm255250805e9.10.2026.04.13.00.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 00:12:14 -0700 (PDT)
Message-ID: <a598a765-531a-4709-99e5-4597427d52b3@linaro.org>
Date: Mon, 13 Apr 2026 09:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH 1/2] drm: Introduce drm_panel_prepare_for_mode callback
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alicja Michalska <alicja.michalska@9elements.com>,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260412113851.355944-1-val@packett.cool>
 <20260412113851.355944-2-val@packett.cool>
 <uckcm7zviwss3jdjrapzd2fpivpdkrdbpcgju2hmrayulfzeaf@2tnli5evjtuh>
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
In-Reply-To: <uckcm7zviwss3jdjrapzd2fpivpdkrdbpcgju2hmrayulfzeaf@2tnli5evjtuh>
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

On 4/13/26 03:05, Dmitry Baryshkov wrote:
> On Sun, Apr 12, 2026 at 08:00:44AM -0300, Val Packett wrote:
>> Modern OLED panels often need to vary their prepare commands based on the
>> mode being set (resolution and refresh rate). Introduce a new variant of
>> the drm_panel_prepare callback that passes the chosen mode as an argument
>> to allow for this.
>>
>> Signed-off-by: Val Packett <val@packett.cool>
>> ---
>>   drivers/gpu/drm/bridge/panel.c |  8 ++++++--
>>   drivers/gpu/drm/drm_panel.c    | 15 +++++++++++++--
>>   include/drm/drm_panel.h        | 12 ++++++++++++
>>   3 files changed, 31 insertions(+), 4 deletions(-)
>>
> 
> A (somewhat) better approach would be to let add .atomic_foo callbacks,
> which would receive drm_atomic_state instance. See  the discussion
> around [1].
> 
> [1] https://lore.kernel.org/dri-devel/nfc6ih43gjpi5u67fpkkxgwwygv53grdldq7tfp5iiukrkiy2u@53fsrtezzkyt/
> 

I agree, the plan to add a new atomic ops if much better.

Neil
