Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5259DCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 07:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D9A10EF84;
	Thu,  7 May 2026 07:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YmsAlV6g";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3712610EF84
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 07:13:16 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so281049f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 00:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778137995; x=1778742795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=G41bDsatk3cCulgpFzbpkSJCbrl3/zJ51rH92RZf3TQ=;
 b=YmsAlV6gL1mVFXlUDJVho5TjGhMw019plhCrPU7B+5FInPIcCDaOwdUPK0RKJgE+Rq
 J7M2h2HsJCtC3lpn4qUjyTu4oV93PGp5Lh9LugiXpNN8ayYro/+inx8TDu2fdmMGF4Ht
 EL/yZ7p+Ko2DWajy3P7926QM9uzFxTUrgZl6S1nE0bMiS9UwvpO7iZLEIENHpBH32qzv
 SXvi57DOSyHZOvQwsAwY0OfPYPjrUeaBp2zigeG+R3v09aeDG5LlXAw9gZHBwZjF2Rcd
 g8OKat3N7/dflPIFSEbfqWDW5MSHlpMeh9FtsuXAvRYm5ep6I2GyLfWmztprfey2p8Dk
 zbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778137995; x=1778742795;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G41bDsatk3cCulgpFzbpkSJCbrl3/zJ51rH92RZf3TQ=;
 b=VMnHY6sasUSOBCuoUjAvbZ5t9Z3FsHgxBPS8fFTgHR8NLtcjicTKq13FpDeCSjnEU1
 shfXD3jjzDTZJBsnlI/E/rC6Jporyno0IgKCPNjjmh2eD5GgHkzAorEQ1NK0GgobNxVB
 sEIrkbEwplI/QkIRdy8PraAUlpa9XValKC7clowK7g3earaisSSpWoIfzqLqBNuL4kxH
 2mspbUnEqYB5Mn8SB2kXsROIG7km2KvBIVzCXuBy738kVfpykLgiqF2yAIaUD/Ft5AD0
 w02G4Q9ST7s+f6AMoEaRYWgJ4/3y6Tzznd1DbHdMvYZiZm9weBodLNP4Kyixo9JgL4PI
 mVAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hEKZeKISFIAJK8TayKiwr08XUYrHbwhdxRkLk8L5lJ1n3QqHPcm+DLUoEooxgFTlzSc4l5Z0TjqQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw9OApf4wCSbFnPR0tapIET4vBC/9lv03001qxKj2LHEMx15Zo
 lwhj3OLZyTZNlj9UtsbQICTLfCNv7VjSCtge+JK7vNlY9MZUE8nXj+lN6YI8JXe8upQ=
X-Gm-Gg: AeBDies4VfrwmxwcE8p0oSrBSqUcFTHkZrfNcd8HnLgxo/ZX6Ib0gIQIx2MgJ+uPTqu
 Zu3FyvKPMvFKRSY2LJ5obvJ0fQkplMKAQKH0l21LhFPOM9Yyp18MVtdcG42fmNZuLlCe9E+cCbh
 s+sNCh50F1rLaJmQhKlTJ5AcNEXA2UDv2JRgQ1WZxbKW90aY2PsKHq2nZlU/AW4eYZLEffEC31R
 TMan2KyCh+Rp8tMmoojcIiYP5hQyQzKCu67Ynm8B7RJfzSLS8scWcR+FkZeyOxAMRUnU6rGIqEI
 C/0JIGP5ei9XA+RdK3Mxeoi+TwaDbychSBYWVA+Y6E/oDzkcrlvQelMixtFrN0WsgtAvtpHfzAS
 I6AUwT5GS6CMMir0T+jwN4OfdwuuRxPhw6BW6KIaCit8JvlRpEdPzR6AndauVJMBD+Vtfpz4KFA
 QWERVM4RsuEPGoJJuM19jVQe3zxepn5mjQtu55vcWGR2LFvBZPzmrWIHUC8Tu6TzctTr0THP5xZ
 bbsNtqXcdTkP+qRng==
X-Received: by 2002:a5d:64e3:0:b0:43e:a73e:cc8a with SMTP id
 ffacd0b85a97d-4515d6bbb26mr11455692f8f.36.1778137994443; 
 Thu, 07 May 2026 00:13:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5798:67fd:c866:b378?
 ([2a01:e0a:106d:1080:5798:67fd:c866:b378])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a4878fsm17288755f8f.9.2026.05.07.00.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:13:13 -0700 (PDT)
Message-ID: <8da442ed-a651-4feb-aee9-ac7cccd576ca@linaro.org>
Date: Thu, 7 May 2026 09:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/3] drm/panel: switch panel registration to
 devm_drm_panel_add()
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260423125922.57428-1-mhun512@gmail.com>
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
In-Reply-To: <20260423125922.57428-1-mhun512@gmail.com>
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

On 4/23/26 14:59, Myeonghun Pak wrote:
> This respins the previous attach-failure fixes as a single series.
> 
> drm-misc-next now has devm_drm_panel_add() in commit e43a8e3ad8fa
> ("drm/panel: add devm_drm_panel_add() helper"), so convert the three
> affected panel drivers to the managed helper instead of open-coding
> drm_panel_remove() in their failure and remove paths.
> 
> Changes in v2:
> - group the three related panel fixes into one series
> - rebase onto drm-misc-next and use devm_drm_panel_add()
> - drop manual drm_panel_remove() handling from probe/remove
> 
> Myeonghun Pak (3):
>    drm/panel: ilitek-ili9881c: use devm_drm_panel_add()
>    drm/panel: jdi-fhd-r63452: use devm_drm_panel_add()
>    drm/panel: lg-sw43408: use devm_drm_panel_add()
> 
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  7 +++----
>   drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c  |  7 +++----
>   drivers/gpu/drm/panel/panel-lg-sw43408.c      | 10 +++++-----
>   3 files changed, 11 insertions(+), 13 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
