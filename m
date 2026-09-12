Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36679C88E6A
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD21D10E9E6;
	Sun, 13 Sep 2026 20:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cbGbijDA";
	dkim-atps=neutral
Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96E610E076
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 02:58:42 +0000 (UTC)
Received: by mail-oa2-f0.google.com with SMTP id
 586e51a60fabf-451e8472960so1019702fac.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789181922; x=1789786722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v5NXJrefjVCbSoUXB82MU8b4oR/5xGZAbgRkHWjhOrg=;
 b=cbGbijDAt13x0pbIBSvzoSdb44/EKL6h7NzwZRo0LiQGn/lAuczc5u22xBdMiiMIJF
 V7Gi9UiCggBZVU0WIPrUyf2h0SnUIsa17GEeTSabAe2x/gZUjejiMugGx95FPSitTfit
 fUz5WjIUELjH1QNKnl8+8tgM4Ns1fCi4A04R8BbZ63VnGmIzwpLfEW7l1Hu0vKWKfx42
 XIm0pQQCGJP9vzZO15khlxZbAF7LlWzMHMlqFdjrYoQY4gM5O0x55gknPaRYU7dMpawO
 5zOFgzRhGNJA46OQMSVCjatni7QjhrUgdb0lnjuc7bUvUp0Yd6Wc+pSFHGKdEREmNKEw
 CpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789181922; x=1789786722;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v5NXJrefjVCbSoUXB82MU8b4oR/5xGZAbgRkHWjhOrg=;
 b=oyK/7pyC+e4NAa3mIS9rNIHo1zhT8RlCgjc4fuNTI/HVko/bv9dd78sUXXpAOxPPKG
 +XwF2Fn6XLerkvGBBi5rez2w7033JLYfWQgp7lYD08d6+S7UUC2giF14Xl708JJKcP+M
 05rwsUz1OGrvKe7Y18O4/n8smzHi7yDaJwj9s0AjqiJEeo4fvLOXqVYAbQ3OjmPdqLVU
 ytQWSP4B97eraalXh6erdwnlcRblE94bL6T/h6+FIxVwUubu8EXcJeELG0+KlG/J4zoW
 wGgQ9771aF2ksiDKsn1BkRRQIWyBDJ680/YsJi5yo3tgv/vv1bMg/f8rWVzdVGX8Pkje
 mpPQ==
X-Gm-Message-State: AFuF++mLRZ62hcSq+SY5x7f6F7O38y00oSo6ttnmIhAtm4G89WC+1tAm
 WkTytb0lv23WsK0pnUMQBo9uIWZszgftKFyO3xycAKjRna0E7p2tGKkZ
X-Gm-Gg: AYBFou178GAyfiIOrQbr6cOIGAVaT6srAuVX+d6uor5DAVncNCrZH/cCPsQefdDQMDF
 WJdRyBWh4SFhmXHqkLhqfJh847FRfO6CBBaeNOzsO1fWn/MD1hiKt55xPrrS9qF4OYAwh00uIjt
 jsmUYjYO1nyIRWaEajtp5BzW6rhK+pHONz8jgyHS26Op/rnVaXBpUDJp5+T4ZEMP0wQnKdHqUF2
 MHmed6igGADmV3i+uJFsyV2cBxxLjGQzh9GHCuqYoyphD3hFwiIQc6MtoMNDKi68q8LQAj1lsVL
 wITKhXnRhZKYLzEK4gTmvZFo/Aep32qkqJrTo0Y5WMfdqWGVVOtIRFnIp+mWSiYtj/udzC4Ff6T
 oWgV96neGHfseNwY8g0DmuKXOwYKk5KObEsXeak/b2loSMk6SsVHX3YlWhUsGWkJp6zTYi5DjDI
 DgAsK5AWJjwqbX6leArsK+HnVi+ZJ9iRP/fSGEI8E8cvWiNvXbeyomUxxMdhISo30RBdRd3T1X1
 ilAY4/m7j0HFirU
X-Received: by 2002:a05:6820:28c9:b0:6b7:46fa:1692 with SMTP id
 006d021491bc7-6c0bbce6f3cmr3794765eaf.39.1789181921726; 
 Fri, 11 Sep 2026 19:58:41 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df8699647sm3636585fac.5.2026.09.11.19.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 19:58:40 -0700 (PDT)
Message-ID: <56dcdf77-2a82-4efc-888b-736f512e63f5@gmail.com>
Date: Fri, 11 Sep 2026 21:58:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Novatek NT51021 DSI panel IC driver
To: Nickolay Goppen <setotau@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
References: <20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On 9/11/26 10:37 AM, Nickolay Goppen wrote:
> This series adds support for Novatek NT51021-based panels
> for upcoming xiaomi-clover submission
>
> Although according to datasheet, the IС has three power rails
> in the use case of xiaomi-clover, all of them are wired to one
> fixed regulator
>
> Maybe I should create a dt option for enabling CABC for panel
>
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
> Changes in v2:
> - Use devm_functions and renamed structs and functions (Neil)
> - Added delay before deasserting reset for stable initialization (Sashiko and Ryan)
> - Fixed dt-bindings (Sashiko and Neil)
> - Added a comment about set_display_on command
> - Link to v1: https://patch.msgid.link/20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org
>
> To: Nickolay Goppen <setotau@mainlining.org>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Jessica Zhang <jesszhan0024@gmail.com>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: ryanbrue.dev@gmail.com
>
> ---
> Nickolay Goppen (3):
>        dt-bindings: display: panel: Add bindings for Novatek NT51021
>        drivers: gpu: drm: panel: Add BOE NT51021 driver
>        MAINTAINERS: Add myself as a maintainer of NT51021 panel driver
>
>   .../bindings/display/panel/novatek,nt51021.yaml    |  89 +++
>   MAINTAINERS                                        |   6 +
>   drivers/gpu/drm/panel/Kconfig                      |   9 +
>   drivers/gpu/drm/panel/Makefile                     |   1 +
>   drivers/gpu/drm/panel/panel-novatek-nt51021.c      | 791 +++++++++++++++++++++
>   5 files changed, 896 insertions(+)
> ---
> base-commit: 99cc957e3ef3cccd72d2119c8eacbab39af0d1d6
> change-id: 20260829-qcom-novatek-nt51021-panels-e2f9db85a967
>
> Best regards,
> --
> Nickolay Goppen <setotau@mainlining.org>
Hi Nickolay,
I have patches ready on top of your v2 series for the Amazon Fire HD 10 
(2017)'s panel; however, given that Sashiko has found an issue with this 
series, would it be best for me to wait for a v3, or would you like my 
patches now to incorporate into your next series?

Thank you,
Ryan
