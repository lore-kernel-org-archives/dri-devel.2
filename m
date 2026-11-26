Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027B606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6CJl2QJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5044310E3DB;
	Thu, 26 Nov 2026 14:36:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16BE10E3DB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:36:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65705429D0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7BD1F000EE;
 Thu, 26 Nov 2026 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795703777;
 bh=LdjOoiXeehWtbpp3joqWYH7KXdOYaDVysqdAR168riw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=K6CJl2QJWsXD0j/+/kTfHBsoAwFXTr1lVPQFUZVBPQbLLgIpGYSi3snlKZV1ZJna4
 p5eHKRD0NUw49acsmZzdYbnnk1POswRfjIOKX01S5UzI99EkuyvuDYEMM2HTHrhung
 pnClODM9+W83DTjryc9V5cCd5Rju8v/D3b965ZG35iooRHEM5VL0GXSltYV0T8WyXP
 znyxh9akajMrFengZTsJuyFdo+rDC2twMKXI6j3hfrG8tDkQOnxFe/xAl4uUV6/VRX
 +ef1Kn12Wx4dYMyiDMg40ZleGGtphzU2YTQnFDHDgR6D/Ly7YJ3sO+avcYijhPMxtZ
 3LA179I4jzP1w==
Message-ID: <36922492-3c87-4587-bf77-acff6ddb1a67@kernel.org>
Date: Thu, 26 Nov 2026 16:36:13 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/panel: novatek-nt36672e: Fix the reset GPIO
 polarity
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
References: <20261126134508.320700-1-vz@kernel.org>
 <20261126134508.320700-4-vz@kernel.org> <sashiko-outbox-235656@kernel.org>
From: Vladimir Zapolskiy <vz@kernel.org>
In-Reply-To: <sashiko-outbox-235656@kernel.org>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 15:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] drm/panel: novatek-nt36672e: missing Fixes trailer for reset
>    GPIO polarity fix
> --
> 
> commit 9b3b20020b17a5e54e69c4e88df2960f428e2e60
> Author: Vladimir Zapolskiy <vz@kernel.org>
> 
>> drm/panel: novatek-nt36672e: Fix the reset GPIO polarity
>>
>> The RESET_N pin of NT36672E panels is an active low signal, however
>> the driver drives the reset GPIO with inverted logical values, thus
>> the reset GPIO has to be described as active high in device trees,
>> which contradicts the panel hardware as well as the panel-common.yaml
>> convention.
>>
>> Fix the driver to assert the reset GPIO to put the panel into reset,
>> and to deassert it to release the panel from reset along with adding
>> a gpiolib-of quirk, which enforces the active low polarity of the
>> NT36672E panel reset GPIO. With the quirk the reset signal levels
>> remain unchanged for dtbs, which describe the reset GPIO as active
>> high, and device trees, which describe it as active low, start to work.
>>
>> To: Linus Walleij <linusw@kernel.org>
>> To: Bartosz Golaszewski <brgl@kernel.org>
>> Cc: linux-gpio@vger.kernel.org
>> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> 
> [Severity: Low]
> This fixes the inverted reset GPIO logical polarity from the initial driver
> commit.  Should this include:
> 
>    Fixes: ea4f9975625a ("drm/panel: Add support for Novatek NT36672E panel driver")
> 

It is a false positive report by the Sashiko bot, there is no runtime
problem to be fixed, and backport is not needed.

-- 
Best wishes,
Vladimir
