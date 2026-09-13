Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1B0C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984FA10E0AD;
	Sun, 13 Sep 2026 17:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j0m8GJBO";
	dkim-atps=neutral
Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2BE10E0AD
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:23:51 +0000 (UTC)
Received: by mail-oa2-f1.google.com with SMTP id
 586e51a60fabf-448a12ddfb4so1181660fac.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789320230; x=1789925030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AE5k/kG8YJbF9+P0eXSyvzyutUhB0PHETgWhH6QKTKQ=;
 b=j0m8GJBOHgXDtxDB9OKDVwPFJnYbnD427Lpw8lL8g3ak4+BNeIR18BWKDLBIop2G8t
 k7BgEYKl44gCzKFSwhFbra7ALGHtzA+9qahIKT6kPTSTSDOoRGnmdNA7J+wzARZPJj+S
 5XuapPQBDbUC78CiCEEGLy7SCJfyMYZtJMwAlELjjOiYvZHCgahpggov0fsMi+hy6mTr
 nMQt8w75FVak9XT/pGEFDDxfkTUu1aZcj8CQcfLlEi5ZgLWg9p88lCSj/CHokVHTxJUc
 NFs4eaHnJBbVG8QKm6AeQKjv273RoL27I7ebCfiGzYNvOXzYTRpAXzUVeL8rQGMJZo7k
 VBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789320230; x=1789925030;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AE5k/kG8YJbF9+P0eXSyvzyutUhB0PHETgWhH6QKTKQ=;
 b=CvApb9lQm5FIEadu3BQSREmhlw1SFRlBHVdqGm00Qz+dehNRsgIkVChxueDDIQ6kq0
 DW9DK5Fb+9VBRW7FBaSjx718o/lY/R81POlM3UBEN0ZRs6Dg9kVHmpUXKlN3Gvo/MCsd
 FxqUCBtfNKJwXSJUwDslkyLsneBwjAOXF4B1bcCCqgmGHBXhId7D8EK7C9gwriDhshuq
 qTj33h3W0B5k0dqPAtU1RIOyaO2INihKLkjNyONNW+IqlFlHBKNw/DysWEob7LJRG+sw
 ZOh/tj1h/9ewXz2B/zGtDaiPxeFcaVD2ZMSi4KKMF0CuzQZDoXczedLnrj/58lc9LC/v
 Ov1w==
X-Gm-Message-State: AFuF++moDglRgMWxbhB7+wki+w+CqJ5c2CLi5H/F3rrIe9+ryvkOgJaP
 BIIFrfAnkR96Y90cuo2qnKDbR1gWreLofwQiQ8aLGKwqpftiOf5t2Bm6
X-Gm-Gg: AYBFou1g5ok/A6sOa8GTrZGINyvb1R9Xnfog/tbtkEtP0jl0TXuIRuC9PClPqg9GTwA
 PbjkWDPVem6gu8hPJt8HPq5usICf/Xn7D4LV39pG/ovvHn5VDjSHHd2yCin1/oHQnbLIl8eUR9A
 58ml+8sTBvzHRPChbbt5J13/KqlVfoY6omFUs75APRxVQJfTCCVuFM+H9srs0g9a6h6hVWfsx/6
 qWMJ01qmyRjgm8zOVeQJkAiQzCHa1zBGHySjwOg8Sge6zRcdfBiFe4HQDlXqBEmi/GpUY4OAIoF
 VwnascWwzH5oAcPmOKu3TF98LM1nAnRlk6OccJq8H/xvO7t6Hj2iaMpNC83U6VSPv5MTbEODtfo
 isrDZtQq/GH3nJNvoiAYGZxbJUQJN3IWMtGJS2PW7kz0VzEAJONBN/LsuXb7H0rj9ZX1Y0mBMNC
 +E2+SEQCUJhGfKu3V5kx+OwFIBhJXdQmtpPqAPwZZeLlUyowjFjk00cPcIvICJmPw40UMYyeViJ
 8bgZGXVhOW2DM4V
X-Received: by 2002:a05:6820:3411:10b0:6ba:5d2e:cdbc with SMTP id
 006d021491bc7-6c0b9d4e352mr11117155eaf.7.1789320230280; 
 Sun, 13 Sep 2026 10:23:50 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df8bc8884sm6899818fac.10.2026.09.13.10.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 10:23:48 -0700 (PDT)
Message-ID: <2ac704f5-40e5-4212-8b16-6b23912ef4b8@gmail.com>
Date: Sun, 13 Sep 2026 12:23:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Novatek NT51021 DSI panel IC driver
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
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org>
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

Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # Amazon Fire HD 10 
(2017), boe,tv101wum-nm0

On the CABC teardown for the nm0 variant that Sashiko found: the write 
is a single DSI generic command to the panel IC just before it is 
powered off, so there is nothing on I2C for it to collide with (the 
LP8557 backlight is a different device and is already off by then). On 
the Fire HD 10 the full disable/unprepare then prepare/enable path runs 
on every DPMS cycle and system suspend, and the panel comes back cleanly 
every time. Skipping the call for variants that never turn CABC on would 
be tidier, though, and I am fine either way; I'll let it be your call 
Nickolay. Thanks for pulling in my patches!
