Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6E8C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D3F10E45D;
	Wed, 22 Jul 2026 08:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r6xxF2hU";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321E010ECDA
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:44:28 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4956242332dso24378865e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784709866; x=1785314666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KZbMg7OWzH2Pfs+sNXHx2gTTU8EfG65c8RR7+jDMp2Q=;
 b=r6xxF2hUm0YUkuqh7oYtz+brY+xtAD2AkXU9QpQy4RAPmsWfYTy8FeYb1d3EE+9qtT
 C3NU1rzu2sPLONIO5iEqKlH2IELGnGvH0+pqantIWOuqW2/TUMlU+NUHylwfR/Y+VD1y
 15uzEoNFoQDOlztAcCm5pYaUkl6N6fk9Kbe5avSXU3/oR4c+DJZ53lZ3ntD+tNnJvnm3
 l9+lFIGVLoonJz5mdFUuGpYeTreXwr3wRNw5PapaRMMbbrbow3w9PdrhjWH5ed0eX70F
 p6Hkj/h0C0ZO4vexhbh8WunawJu5DsgcvB2kciuGB2JMfc+x8cN2bwWxNhgAA84A7vbu
 bIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784709866; x=1785314666;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KZbMg7OWzH2Pfs+sNXHx2gTTU8EfG65c8RR7+jDMp2Q=;
 b=myBaCEEFsI1JqAXuNM0FOZB0I2QvQiHXG7HaRqDHJ6GAuoJdLVe9VxiVWEUIvgJGxL
 c6eavfjcVL58h0Md64YcLcQgJPpr0HwJOxO7gUsEKFaXBOZXatxvGzd8ZIrKxppl0O/Y
 DWq3gh9z9ivCDQWh51bm0zNyZQmbtxACIzKMUlVOboYJWGql831HMsVuC1E1wYspaS72
 XX2WnCATb9wzjV63pxlyMbaDHkuXwaIs9QJUKp64m/Uh4VOcg6+Kwh1Fbh6uZZCNk4IY
 JZlSAEdHH+2Zv+vNmIc0UL0kMoKFzSaQUZox5V9aR2ox+EJ8d7cJD5Aql/WpVfFfF/gO
 VXXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyicYtVxfHw9UgKX5bjER72PW4HZLhghu16iSlvC7ME6nMTCSoUDKekx4s89FvztauhCpIqQWmKfI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxvtfiduaKXNER42hcmW+7fBGO2JTAu2p7QmjlnCn2dhVvTx5q
 POI8R4R5dkFYUJx1Aw7SBrtQRb2/9bLo9CQlINt0PnMAGew5o/wPtgekMyauz1SgdQA=
X-Gm-Gg: AR+sD11uORDo+8ZA5p+HBXX7Yu8sncPe2cLbJZUYJ2wHGDLCDDdInJH5DfUiGlugsu7
 PZsRzZF/+gytaMmoa/ydGmHrcoh+2mM88z5ycJJbAYK7YPDEpWF5fBRjsnfcF8Xdslh+JXiHAWl
 t+zsbToY4H3aro2zToHSrtFkEamMk+LOgSymGeVtXHZptmr5hKrpai6DiVFDjqpCEJgtJeIvM1i
 fH/cVgid2zyTejJILBMYxIQFOZoruMoWLC8I+At6sl/A2ivKv731v+bz1znOQDTzyQOFHDyvrTY
 izCwz6qrIG5taBe287iL6Qf95C9b2HCGauNACddSRn2tIb6tZ1nWcveOTjh9oi2FDuCP8lZU/g3
 n/fkSwZAnYW8vuqf8WDt5y1KLOyCjx9mCwGrleUn0wHZKG8HHmReGEnl23VSQue2w5dJicG1+WN
 3nc0lS6SdFg//KAL1FCPrTJvS6xwkRiOjJbSCtrSvAI3KvWBX8mqUSZhU=
X-Received: by 2002:a05:600c:4687:b0:495:4df2:7412 with SMTP id
 5b1f17b1804b1-4954df27450mr222563655e9.32.1784709866272; 
 Wed, 22 Jul 2026 01:44:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:51c:217c:79fe:1b0c?
 ([2a01:e0a:106d:1080:51c:217c:79fe:1b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653731b2sm130709575e9.4.2026.07.22.01.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 01:44:25 -0700 (PDT)
Message-ID: <64ed7a3e-fc9e-4b42-ba41-7928a7117221@linaro.org>
Date: Wed, 22 Jul 2026 10:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Mark Brown <broonie@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>, Maxime Ripard <mripard@kernel.org>,
 Albert Esteve <aesteve@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <al987knJq4h66FcJ@sirena.org.uk>
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
In-Reply-To: <al987knJq4h66FcJ@sirena.org.uk>
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

Hi Mark,

On 7/21/26 16:06, Mark Brown wrote:
> Hi all,
> 
> After merging the drm-misc tree, today's linux-next build
> (arm64 defconfig) failed like this:
> 
> /tmp/next/build/drivers/gpu/drm/imx/dcss/dcss-kms.c: In function 'dcss_kms_bridge_connector_init':
> /tmp/next/build/drivers/gpu/drm/imx/dcss/dcss-kms.c:81:17: error: implicit declaration of function 'drm_panel_put'; did you mean 'drm_dev_put'? [-Wimplicit-function-declaration]
>     81 |                 drm_panel_put(panel);
>        |                 ^~~~~~~~~~~~~
>        |                 drm_dev_put
> make[8]: *** [/tmp/next/build/scripts/Makefile.build:289: drivers/gpu/drm/imx/dcss/dcss-kms.o] Error 1
> make[7]: *** [/tmp/next/build/scripts/Makefile.build:549: drivers/gpu/drm/imx/dcss] Error 2
> make[6]: *** [/tmp/next/build/scripts/Makefile.build:549: drivers/gpu/drm/imx] Error 2
> make[6]: *** Waiting for unfinished jobs....
> /tmp/next/build/drivers/gpu/drm/mxsfb/mxsfb_drv.c: In function 'mxsfb_attach_bridge':
> /tmp/next/build/drivers/gpu/drm/mxsfb/mxsfb_drv.c:130:17: error: implicit declaration of function 'drm_panel_put'; did you mean 'drm_dev_put'? [-Wimplicit-function-declaration]
>    130 |                 drm_panel_put(panel);
>        |                 ^~~~~~~~~~~~~
>        |                 drm_dev_put
> 
> Caused by commit
> 
>     b71a623598d31 (drm/panel: of_drm_find_panel() return a counted reference)
>     
> I have used the version from next-20260720 instead.

Seems the patch hasn't been properly build tested, I'll send a fix today.

Thanks,
Neil
