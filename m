Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A54C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1923310E9D1;
	Sun, 13 Sep 2026 20:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="CDPcNiOK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="9Bh6pzve";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCECF10E436
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1789214702; bh=u8myC1jiNWPSND6jaTeBmI/
 7+nYxV64Z9V+k1jO42CA=; b=CDPcNiOKxzam1w59NACzqglFRzHlZJHJpGtTUPCe6UEqyJdC8k
 RyNWSFZjyTl0mJl8gpuHiYQuNNiqElfdekfhPu69bYCa7vFz7H3dlIVUk4WgAh3S91TANUgZAYo
 rtm79YKx4fH0MM2CRe2ZNnE9gvOtmyxxO/7OwN1EEjU48mnSZgCaQrD5IKiOgkxV/Kfu9EMV+wS
 EqhuChLx8CYqUtxyPSzubOZd577Ey/3znCztPl8mVm56d2PpH/jCovZS+7nLRIyCNxmSFYFgfir
 aUulVXltXJsJQIItBHdTdqgBopTBysZ/7zVjpT9ftpXz5nwBAmv2yCeo63flo/kOfXg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1789214702; bh=u8myC1jiNWPSND6jaTeBmI/
 7+nYxV64Z9V+k1jO42CA=; b=9Bh6pzveTujNlEp2+e6BsPCiNakHL77NBoD0zaKhBnPvNg9KQt
 CRubo/CUdZE57jEO8ZaOyh8okG5VT/BeffDg==;
Message-ID: <6fc67e27-a36c-4974-96e4-1f68b85b3114@mainlining.org>
Date: Sat, 12 Sep 2026 15:05:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Novatek NT51021 DSI panel IC driver
To: Ryan Brue <ryanbrue.dev@gmail.com>,
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
 <56dcdf77-2a82-4efc-888b-736f512e63f5@gmail.com>
Content-Language: ru-RU, en-US
From: Nickolay Goppen <setotau@mainlining.org>
In-Reply-To: <56dcdf77-2a82-4efc-888b-736f512e63f5@gmail.com>
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


12.09.2026 05:58, Ryan Brue пишет:
>
> On 9/11/26 10:37 AM, Nickolay Goppen wrote:
>> This series adds support for Novatek NT51021-based panels
>> for upcoming xiaomi-clover submission
>>
>> Although according to datasheet, the IС has three power rails
>> in the use case of xiaomi-clover, all of them are wired to one
>> fixed regulator
>>
>> Maybe I should create a dt option for enabling CABC for panel
>>
>> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
>> ---
>> Changes in v2:
>> - Use devm_functions and renamed structs and functions (Neil)
>> - Added delay before deasserting reset for stable initialization 
>> (Sashiko and Ryan)
>> - Fixed dt-bindings (Sashiko and Neil)
>> - Added a comment about set_display_on command
>> - Link to v1: 
>> https://patch.msgid.link/20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org
>>
>> To: Nickolay Goppen <setotau@mainlining.org>
>> To: Neil Armstrong <neil.armstrong@linaro.org>
>> To: Jessica Zhang <jesszhan0024@gmail.com>
>> To: David Airlie <airlied@gmail.com>
>> To: Simona Vetter <simona@ffwll.ch>
>> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> To: Maxime Ripard <mripard@kernel.org>
>> To: Thomas Zimmermann <tzimmermann@suse.de>
>> To: Rob Herring <robh@kernel.org>
>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> To: Conor Dooley <conor+dt@kernel.org>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: ryanbrue.dev@gmail.com
>>
>> ---
>> Nickolay Goppen (3):
>>        dt-bindings: display: panel: Add bindings for Novatek NT51021
>>        drivers: gpu: drm: panel: Add BOE NT51021 driver
>>        MAINTAINERS: Add myself as a maintainer of NT51021 panel driver
>>
>>   .../bindings/display/panel/novatek,nt51021.yaml    |  89 +++
>>   MAINTAINERS                                        |   6 +
>>   drivers/gpu/drm/panel/Kconfig                      |   9 +
>>   drivers/gpu/drm/panel/Makefile                     |   1 +
>>   drivers/gpu/drm/panel/panel-novatek-nt51021.c      | 791 
>> +++++++++++++++++++++
>>   5 files changed, 896 insertions(+)
>> ---
>> base-commit: 99cc957e3ef3cccd72d2119c8eacbab39af0d1d6
>> change-id: 20260829-qcom-novatek-nt51021-panels-e2f9db85a967
>>
>> Best regards,
>> -- 
>> Nickolay Goppen <setotau@mainlining.org>
> Hi Nickolay,
> I have patches ready on top of your v2 series for the Amazon Fire HD 
> 10 (2017)'s panel; however, given that Sashiko has found an issue with 
> this series, would it be best for me to wait for a v3, or would you 
> like my patches now to incorporate into your next series?
>
Maybe I can incorporate your panel to my driver.
> Thank you,
> Ryan

-- 
Best regards,
Nickolay
