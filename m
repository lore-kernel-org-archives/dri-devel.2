Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E4CC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 05:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70CE10E132;
	Wed, 16 Sep 2026 05:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLv/OZGG";
	dkim-atps=neutral
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com
 [74.125.231.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C040210E132
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:55:09 +0000 (UTC)
Received: by mail-oo2-f10.google.com with SMTP id
 006d021491bc7-6c7150a9098so511561eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 22:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789538109; x=1790142909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MqFU5BpLPG1Ad79y0zq7m4k9RGfhTKwi6mVEHKHgkMk=;
 b=mLv/OZGGhA9914aGh/kKt0W0nFo6TS0zKkI+2LoWtmP8NOZGFqdWwcN8H97wtPyHIg
 QHulxVXopeJOwO55V6Ur2U7p2Pi5IuQYDWi3X9M+dUAxhl+OopwUu8Q0stzq2LETGWqb
 LrMHu4HWKXDEtoOTWZBgddiLoUTPlfGXA+lt9Y2/SXZgHDF3xkCo7fUUMOs8eD0+4sGT
 mS/57kZBx3y7YVoVm7N2m70KdTwFmR6F1rxDVx64dQ+H8zYQ4SyIftgrOK4LuKozPFbj
 JA/eJrsf9uetmLtKmrvNQtRH0Y9RiS/FM4dbdEnXRg/EnVlyPia0r3iDW7jd1Gm21pW6
 rwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789538109; x=1790142909;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MqFU5BpLPG1Ad79y0zq7m4k9RGfhTKwi6mVEHKHgkMk=;
 b=s6dUXSaEB9SpC7R/SwnoDDP4iKBhoAaOY0b9SJtzjy2VegZLUzH25skm6qHTMqY5oe
 dQoiKaoFqTJZ9IV3RikOSBizARBAsNs1pp3f2zC2MO7USOFLtSlVgILDeRgIweWj4ecG
 gQRON8jQ0kz8cRpiZQ39cH5Sqv7j0XiONoM591bEyX0Krw3avUyv61yL87h7uopoWbyD
 gBPS+Dnwp4+XNUNqS8RlqsUOApYGmw+qjH0OIonqqGnXWx2TJ6QvzwcFqj0idPAi7kss
 r05HXKMfD+aje/jblKrJOeFPpFIJ1i+uQVJfLCnRS1P4gHNJIzufU+O/G2E63HnDssMi
 YkLw==
X-Gm-Message-State: AFuF++mxX1Qna6GmVZ5yYKqMo+p8VsVJPdgk0aV3tn/XXJLBAJ5Es1hK
 DybsA6O+dtaRZhstDqFouAYZMqFl7rbyHYI+4zDpQWbQEYicXZAp/pwh
X-Gm-Gg: AYBFou2DKN23d8c9frXiYSziSW2AfJY6LSnSkpU5fqGcjRKGeAJqaA2cBYD1l6DKvAx
 0K1ofc53y3RtGshryVgQv5ZIMozZUhZqtLYhZ5nnWLyvXEFicQc1ugFoN5cYT1jvhxnoMVJsW5f
 nHQaZt2WXdLo2WtSthrrK/dHchcXsdUARxSvlIRN34qGIDUC2YUvByGsACSowwGeQHrlb3DVS6d
 S07SOZJVJpJ+FGPywLsTLwGCXOXDXsIumGCksvsGs6QliJzJYRn+s8C2V546f+ccjqh+np+IWtl
 tHWbH+kO1VD0dGVCbY8O7dZMiDTp+vDiyksMQ7eUPSUuF6Xfvc8bMlJIXhcheZVQ1BhwUz8tBtq
 jmVumaW7BCSuael4PhI+O1zzg3paN1euR8mWLCpIzis/SQelZ1vgpPqfgkJGmTD7XBNS7yoXOS5
 AivPik8WHQo8nFwV8qTPZyFZPRHkkwseHVTRSZAEVCofussMsyoAXHz0srwxXpmCnSexe+tEzE4
 SBMnvLNTjK3UG3B
X-Received: by 2002:a05:6820:188e:b0:6b3:f4b8:bb86 with SMTP id
 006d021491bc7-6c7d1bc852cmr1410414eaf.22.1789538108821; 
 Tue, 15 Sep 2026 22:55:08 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c7a78ac1c6sm1949699eaf.13.2026.09.15.22.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 22:55:07 -0700 (PDT)
Message-ID: <b9a58aac-4a49-43ed-93f9-32c295609312@gmail.com>
Date: Wed, 16 Sep 2026 00:55:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drivers: gpu: drm: panel: Add BOE NT51021 driver
To: Nickolay Goppen <setotau@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org>
 <20260913-qcom-novatek-nt51021-panels-v3-2-266bc5d7e8c9@mainlining.org>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260913-qcom-novatek-nt51021-panels-v3-2-266bc5d7e8c9@mainlining.org>
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

Not sure if I was supposed to reply with the trailer again, but to the 
individual patch, or if I should leave it since I already messed it up 
in the thread, so I hope I'm not doing this wrong:

Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # Amazon Fire HD 10 
(2017), boe,tv101wum-nm0

Best regards,
Ryan
