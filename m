Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD9606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JOCmghPe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D230910EDBE;
	Mon,  2 Nov 2026 13:23:52 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56C610EDBE
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:23:45 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1377352f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793625824; x=1794230624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjTkavopvWP8IoUO3Tm2DHF2lem7yW434Hge7kuVhBk=;
 b=JOCmghPeNKHRrcKx80ZXzE9JHkIk2YiAdc2DbMZ2EjcUe5rLx+MbJ/20WXK8RjJfgq
 U5f+dDQLWgXG1Zvk1dz9wxLF6DsmaLN0CLfan+/tpwqOvdWHvGd8aUXROK1nK5ClRgyz
 anAkRKctBrb2Sk8wWscq7ukIkdulAf9R4Gti3fLWLO5HxehUW7BRSop6SGxXSNqFzR/d
 g6Sfg9X2bIBc+Zl1kh8jjaGUIs7SGDAKDz9IweUIMRED5H803PZoGu+PHX3vaUWQi8Xz
 PlWUzqiEXoH/Rd2SsZLt7MCfQX6Q0zqSTiAGbqyqMshxPguUaRMwTl0Ju5uhcSynzwzi
 4vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625824; x=1794230624;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjTkavopvWP8IoUO3Tm2DHF2lem7yW434Hge7kuVhBk=;
 b=j1J+TgMpa5jUSt4GYZjN8EmXYgjEeUhEDfqJJoTy00eemQf9eUj51b9Okt3cnKyY+w
 cOdSJy0Af2r3xndTT2BXx7KyHwc2BC9Psz7nNxtPI0kKOtB6MeOWu1oRPseDswkKYhQ6
 51i7ghSYrHCbf5+67GxsaiQZFxFWjBkiDd7e0fFaFY5FrJIgaVib4Ed1AZ2mPUeSRpAc
 0sNAKVAbF/FZvTK0aAxA9dI692CM+MxdVC3V7WbT8lkZyRksXfcMjDCmFUgXdYrwtEIQ
 tJdqzDjS5fuqiv8OlQ8kgS77DmAuiIwun79+p8m7gvfx3I7oTVSXVBt6GA7rIg/cYaOa
 YzHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNjg1wPHcn4m8V7e8QMbUgx47wwmW3WRgh0KBdfAuHDpARbWY+QXtq4UZChOyGZp9hyHpGkJRG78c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8A3rEYolnvAG2oKzPDDxP7xFbGMMB9DSj2kh2tKAAypRuJb8l6
 Lnqwn38jRNBQdq1I0xyK2fjDRRXqXDOVusG1FSepD7dVaT3uafVcQaKfNosBtddeNo4=
X-Gm-Gg: AYBFou0bKguEMosgkLpWbVtPaDYZWv6+K6l7u2/EeBE5r1+M3vcK4xP3sYOq7II8xZV
 MsELk6fk8UkMFMA46O7Oz0r2k9dmBIX4NAcvAzs6ts72JuH2P7d7bQlfNN1tvjdiGYzGLKKsxwB
 J84YMs5Qx1zApQbJCNZP0aeKxU72tjvNlKjJU+zbpZJ2CqKcqO1mVKg7Hjv5Irlenvlf0ImUTFC
 Hgho9JYWm561cHuGsX/DdjPapIUjRHYLdkX6p9JtLH8ZMeDxYhGTeNb9hbpcUXOkAZG09b+GLcr
 ButkozbNYzJ59eFDQP21roeayJCjn2bPbOf6clKoWLAdroAD/DSARq6ft7SmQmQewjw8TQFVAMS
 Mu+Gt3hKr+sweUgxNfWmjCc0pNe/S70sTRr7sw+rpDL/QbvQWIKNABz9Za4vF9A3jxfrN6jGCrl
 6kt/cGFjuDRq7mRL3RuQpDi35JW7acwxDuKJ6C3qbY6Uf6GhtgPcmtvrPemekQaP9lzXlwAUpts
 Iqft3+gnMshTUo3KJHd6V0476v7ka3AUDJyLJNSa4VoFkXBADhMxPnKkvp1MzO+W7kbMmii86MI
 TT3kD/nvs9aGxCfsgfa2nQdAbky580U4VjWgc8Co7wkeKhMR6DSY2gbpSRPxz6CsBMaJxxJywU1
 w46zq
X-Received: by 2002:a05:6000:3109:b0:48d:fa9c:7838 with SMTP id
 ffacd0b85a97d-48e6e2bc07amr25550097f8f.2.1793625824172; 
 Mon, 02 Nov 2026 05:23:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b727c6sm21994451f8f.16.2026.11.02.05.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:23:43 -0800 (PST)
Message-ID: <aa8863b1-6fc4-4c2f-88b9-c8f41247bf94@linaro.org>
Date: Mon, 2 Nov 2026 14:23:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 9/9] MAINTAINERS: Add Alexey Minnekhanov as maintainer
 for NT36672A panel
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>,
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 phone-devel@vger.kernel.org
References: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
 <20261011-nt36672a-panels-v3-9-9ea238627f8a@minlexx.ru>
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
In-Reply-To: <20261011-nt36672a-panels-v3-9-9ea238627f8a@minlexx.ru>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/26 13:54, Alexey Minnekhanov wrote:
> List myself as maintainer of Novatek NT36672A panels driver
> to keep a close eye on it.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 252b6d7ee1638..e85fbea55ae62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8464,6 +8464,7 @@ F:	drivers/gpu/drm/panel/panel-novatek-nt36532.c
>   
>   DRM DRIVER FOR NOVATEK NT36672A PANELS
>   M:	Sumit Semwal <sumit.semwal@linaro.org>
> +M:	Alexey Minnekhanov <alexeymin@minlexx.ru>
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
