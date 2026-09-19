Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA52EC982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7A410E159;
	Sat, 19 Sep 2026 14:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZsfKktgG";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEFA510E159
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 14:25:20 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so22635165e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tuxon.dev; s=google; t=1789827919; x=1790432719; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VpdVAxuNOwmWu0WfirEONZSR+j3md2xsgnrcoSx6gSA=;
 b=ZsfKktgGGlLvV5f+ZxR506SP8/L0ruuDNExUy46sTykE95tBBaEE8GUgIU1+WNSXi2
 to3SFLyIaEQ9K19Yrcw3IzvYRVlh8o0AUytu7Vm9vSUusGiG2q8fcXQG580E8URGG6Er
 rMZjzfpnU7dL6xSedAYrFst8/VzGC5JALMbzhCfvNG4vyyvF/vYuaVVvWGgyOQ63sRir
 /AGfUHOixNHxzvlY9+F1TvaWSMGQR54Ga3XyecEE2mBlH1eAx85+eYG63UBTs+lfrkuy
 w3CZvwAUo6xMqS9bIyNNKkfHRBZwkhvE8aljNEif6EhsxZRzUr3a+h+9lP8ABTxISDsx
 0fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789827919; x=1790432719;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VpdVAxuNOwmWu0WfirEONZSR+j3md2xsgnrcoSx6gSA=;
 b=MDu5lkke1qDJcHb8Qj1nnr1QJJ0eDQf6MZt5b4XsQdRqSH0yrvQmIT/DTsRhUKe1R2
 3P76KYRF9UwfIqiJSG60z8PQj8dVJx693ZKtqs1NKBz3tQ/eDjmK0hdyKVg80J1dQxi8
 g2cVBduhgD/gwzIR3y7BPJRATwqCpSMyco8e3bbHM7Ey36gm2JPoK8xd2vDTrgokaWHG
 xpWMjYSd2rMMvGREefLGtlGB83PwbKYnFSrJflkOJR81cvE7Offbx3hPLZqbOD7kE06a
 tCgspZMsOsakAPYmrWmwAqV1gVpuM3If6x6r7pohFT6YIjsiq0RrA36hEpgHaYdBMEOO
 Fzgg==
X-Gm-Message-State: AFuF++lRvOWxNZRGJQ6Va9nGMxnuKBZ8fC08hVXyII4223B1n09Vx8SO
 498KHZRydjvebFGUaEoZFwwzOQuM5gD63fWxuc1pTpKMa/LHSQDyU4da9qWsccilN34=
X-Gm-Gg: AYBFou1gHukqsvQGT/hYW8lyCj/hIbK0Vs40nT2WGGiMwRjzab4LSc5RxU8QObf7cL3
 AAcjHF1kQxVW9vdA0v+9/Ks0HUwCsZ+CDb/Ium9V/4zLFxYu6FiIdcYclAw/dyOOm3ZRjgIDotm
 d9gHNqp0AuF9V6rvyWLHRlZbR3PL+WXsetcojlrg1tUhN/065uEGGHphGiTSxgYuoMB1jSj7cJr
 UmCcD6Z+7cFDB57waSfcco16gHrOxDg6BdgaJIRF7VTFlqiDOxMbD+Jx4sILZ+JoCncf//aDAQl
 CL4UfDVs/D6dduTVYnfyKxkCvYaWiEDnflm1wVS4yWG/PBVFktOCDg/vh94O/LM9sldjDi4TUTg
 45fuhK2E3eicHBCqVW8mZ8WHbPnS+riPNfu160Z1YkZ6FUQ06dqzoj7PfTvHI5Hsct/+AKuThvX
 JqXhLBQ+T8OXOS52hraEEyWs5rfpimHsKVRNzjMFROwaPC3URKT+tx2uNfNDx1xXblBgHRfeYla
 A42XXbS14tssmh7cQkLDs2YhvxHrXJTzxaESSdhYY8eC/xSM1rqSxdy
X-Received: by 2002:a05:600c:19d1:b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-49fc5743bc4mr79415245e9.23.1789827919214; 
 Sat, 19 Sep 2026 07:25:19 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77?
 ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd10273fsm78403545e9.7.2026.09.19.07.25.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 07:25:18 -0700 (PDT)
Message-ID: <c2c649b7-0f6b-4271-974e-a84559c10231@tuxon.dev>
Date: Sat, 19 Sep 2026 17:25:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] ARM: dts: microchip: sam9x7: Add GFX2D GPU
To: Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Russell King <linux@armlinux.org.uk>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Manikandan Muralidharan <manikandan.m@microchip.com>
References: <20260828-cpitchen-mainline_gfx2d-v8-0-378374559738@microchip.com>
 <20260828-cpitchen-mainline_gfx2d-v8-4-378374559738@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260828-cpitchen-mainline_gfx2d-v8-4-378374559738@microchip.com>
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



On 8/28/26 18:52, Cyrille Pitchen wrote:
> Add support for the GFX2D GPU.
> 
> Reviewed-by: Manikandan Muralidharan<manikandan.m@microchip.com>
> Signed-off-by: Cyrille Pitchen<cyrille.pitchen@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
