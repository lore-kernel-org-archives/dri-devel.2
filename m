Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31396C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C2810E071;
	Tue, 15 Sep 2026 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OAPt/ooG";
	dkim-atps=neutral
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com
 [209.85.160.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1C510E071
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:52:34 +0000 (UTC)
Received: by mail-oa1-f68.google.com with SMTP id
 586e51a60fabf-46556b9e02cso683607fac.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789483954; x=1790088754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+ahwYgxWMEileOU99DTxmNSErnxm7zxJkhpgn6sFwtI=;
 b=OAPt/ooGTwpHtNmqq7aMtLzQplDkkOm94gL3F9at+VBQdpwChyjtQQDttQINEncx7D
 /Ims4IPkMNfAJxFDSGgNVALzXCxJjUwV0xY+6tYTkK1hTAl63Q+SIY19F9hawrOrVPJw
 77bl0jFLGeO5wTfb34kq0Uh3Rx6Zf31UMnK5RmsefE0oxR+M1POZKru4e/1hqlq6qpxo
 behrZM29xhTq6d8gKDn92WvBkmHHq9S54YTucn6PuWMdXFo+c6SkAsG6hMxlwm7SGcZz
 ZSS9ikewAXXkd1lgYtA7roGV+adnYVmGfxu1M11TQiW9pz0LHiAP6EMvEVsECSWIgfgF
 zviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789483954; x=1790088754;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ahwYgxWMEileOU99DTxmNSErnxm7zxJkhpgn6sFwtI=;
 b=JH3rJYlpqMxu5bYxTr4vu90tlG+rhPn/htcbrB1/LSdccZIWQuQm6HrljRxo+t33F+
 mZ33v36IIXKjplm8JzxYX9LjxKWOnhKn2oooPCO58gIH7Wgjn3P9wjZoeHE0FiqJjPlj
 EWVfrA7GSepLdwQQh91JO3vd/q3ranBiEV9V/Ylfjtor+yCMUpzrU0wtX21l+ESMUlzj
 nIk8h+ox1H74y5JKm0JM3aFmU5gx0P4dw9hFcwtY0Rx+97cEZqD+rNofsSLPIKMlzgjf
 y0NjujqPvlWyGZn/2VnyRnDJRxd8wdcse1ZbEbGGZpfC0vevjGTG7/G65AWqI1UN7XQV
 3fwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl5+4FCQRojm7b3l7JcLADFQU+pjFYThfpI6P1QmF+QjrGEvtWJIZtnw+CHcGj+F4bg9h2MZ3DZ/k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kog9Yy0dGa/p18X2O4ZTNcFxp0y7O804RdoBc00CTqXHvfNVOL
 4nd2Y1d5xsJY89xF1FDGW3jyJ+imCcQ5pkwtqtSxkc2wMB4a9ArMvwtx
X-Gm-Gg: AYBFou3f6Sew1/x53cABNy9zdHS00eHed2KBTDRCTDwQ6JtiaGq2BOlpdnGAmN/xRvu
 NApOMPGVB/0ZVXokdVnvjNP2lq0LEC2GpwgKJjwbasv+xy6tUZN/GoZFFHDXgf/SQ8BGpBDqVuF
 Qm5fUBFkPvb2wPp+lj9khufnRVp4V8kxwQX+bnF4KN2dbnj7DHaoPwHYFtQnnNSso3Y/cPo6/nH
 JLDBi8c/DcJhYyoiadKD9oLPwko86VXVzj1oiKTFVZZZoTXUPZP55S5L6RuuKu83yb89ZqV/yLj
 uYf/oFcTLl+df5XSxz8Lxre5rx+o80tdTnXTkmLgBYBHfbifCtv2Uq7NN2zfnf2hNdJZc+Yn2lN
 ji1lO74gYT8QlZ39kACFAbHW5k2nVeAxJ5+Krscq/EdkeqLkeX8KXqRLqPrfLMHWM/ZmJA7yqjk
 +WpQOC0vmMYxcr7z1myHpS1t4GmahYLgzf8RjKqIwLbpgoH16Siu3DIkkoMM23OzRLW2nyUaSU1
 xT7sUbzGo6VO0xF
X-Received: by 2002:a05:6870:459b:b0:462:e12e:c561 with SMTP id
 586e51a60fabf-482e39ea87amr2549366fac.4.1789483953749; 
 Tue, 15 Sep 2026 07:52:33 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df86995d6sm12588398fac.6.2026.09.15.07.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 07:52:33 -0700 (PDT)
Message-ID: <2791fd80-627a-4353-be41-213240e207ed@gmail.com>
Date: Tue, 15 Sep 2026 09:52:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Novatek NT51021 DSI panel IC driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nickolay Goppen <setotau@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org>
 <2ac704f5-40e5-4212-8b16-6b23912ef4b8@gmail.com>
 <20260915-funky-hot-lobster-2eeee8@quoll>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260915-funky-hot-lobster-2eeee8@quoll>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/15/26 5:39 AM, Krzysztof Kozlowski wrote:

> On Sun, Sep 13, 2026 at 12:23:46PM -0500, Ryan Brue wrote:
>> Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # Amazon Fire HD 10 (2017),
>> boe,tv101wum-nm0
> This tag is applicable only to one patch out of tree, so just respond
> there instead of causing scripts to get this tag to all patches.
>
> Best regards,
> Krzysztof
My apologies, I'm new to kernel development, and didn't realize, but in 
hindsight it makes sense. Thanks for being kind about it, it won't 
happen again.

Best regards,
Ryan
