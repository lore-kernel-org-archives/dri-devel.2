Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF09C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45E610E3C7;
	Tue, 21 Jul 2026 20:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="cwDLW8cb";
	dkim-atps=neutral
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com
 [209.85.217.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1EF10E1B4
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:28:27 +0000 (UTC)
Received: by mail-vs1-f99.google.com with SMTP id
 ada2fe7eead31-7396940aebcso5648174137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784665707; x=1785270507;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fTR3Osz1w4q8vT9QmaSiYsaOMtZKVCVI47aty9EAQ44=;
 b=FSKy0d3Xj71WgIwCxTStUIzj+5N/hD+2eW1G4ZnJYVP6N45K/qXMdHety2d9L2Acw9
 6jPuj7qE2AgnSJQXVjA4xvzR2naONIa+dYFq9byIseTEEST4GEQnes7luqCTaI3WGUr6
 l0Ep+zWLV074D5Ua+JDBupCdEC3P3AC4YBGk7du+DEzX62iskvCI0TzEakszfD8BCOnu
 c2xCmHhH4IeEpoUh0Ets/z7ZnvEmO7wzm3HmnJAFisYoSL+WL1mg0Ue2IPAIaAUtGx+R
 3NDw9vnDLklSoAAQvNlPwaGNGP9OjE6IQpVuvgW6fN2ofheI49Y9jVjcJUqIxN67ALDz
 NqSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwketbDr6rWWP2gLZY/aW8ziX523mma5PLXRJVa1b+d3RudK5IWKHXw8ANf5F3OF05tb0I0CCbvO8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx02K+CDaNr5lcCfVhsS9jlN6Yl37LX9EV7uB3WLev5HZJBEBAZ
 fCSO84DLBq4VLp3TXAc68gzTg+u3Wrw/vxKHkMnICC6DE3SVCpOGN5uCNJxKGP9hEWqVwBa/KSm
 Tn3tpEqbi6CwN4purUzDjRK/KYu1+odaHBgnfB4cPuAGc3FUxF4ukUHZZFEXoYQk+MudBXW+9O/
 l8hsfQCZrxi54n8m7aqtlQh+GGHFWv8k48pt47o3/vcTiH/CZehifXsBdvqCzx8WZpFFpMzZnNo
 ZMs3x2lj7cujh4KItk/wpecrGTW
X-Gm-Gg: AR+sD10BrdNTvGBMQR43prhhiamkYXP0/nCnL5v22ax5iFInf8oRR+g0j1rnVXjMf5R
 6jCmcI0i7DMcmODgjRKQHrBKeRCoKvcAJHRwPlLchk0s06XhAQqE1mMbRI97MhywnSG27hScufS
 Qk9cUS0AAdJBZZQSAiUjudxUrfJuLtrCynizIkapif5qI+7Dhnbws7o8Hh4iVTo9zL3WrK/wutn
 V3O3Y9Ze17N6OwO4pUk1HEkOZKU30zpLBaF6uyd04aK5dC9G3zLG/zM3z4efWlP35ltWhEq0iJY
 BtSeKlNOj6tOPmO05d2Tpv6amcsq8Hs77W6zyVnKiyIRlNG7RUdmFdNeuiLGVVx0fXYC4s5rCmi
 JV0x6oSXwhZiyl7iHrvmxGDpyk2Zis6sGRAuFyecGf2j7DVSb4CVvyOXowVcyF3HSlau9z5CiUc
 HM0qaRz9BSUB86vdIWrHwUEuWelIBH6q2lmeaChma7
X-Received: by 2002:a05:6102:4189:b0:726:e81f:f3f9 with SMTP id
 ada2fe7eead31-74753630309mr7755640137.15.1784665706547; 
 Tue, 21 Jul 2026 13:28:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-97743de624asm17988241.0.2026.07.21.13.28.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:28:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so7736870a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784665705; x=1785270505;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fTR3Osz1w4q8vT9QmaSiYsaOMtZKVCVI47aty9EAQ44=;
 b=cwDLW8cbwnv7LXUOiuSeK5VhaP2h6/wls3h1NQecNk/jqA3bI+2z6til63P5hB34cO
 pDXyWFoVskq/eihgXc5zmt7caM5fXCnNI7ccP6fqs+PyDd2LMNQR4HxEezUItFwqM0kw
 0yMqoc+zf3fAKir7vFZs68zf7q5xrOCOjegIg=
X-Forwarded-Encrypted: i=1;
 AHgh+RrB+UKZgxlgc4A9xKCkYVy7YXpSv29yfJq4eogZkz3rSl/4fCpJ4r4FhEmK5RpE1zM6/wPGDJg7UkU=@lists.freedesktop.org
X-Received: by 2002:a05:6a21:6f06:b0:3bf:6c08:2b27 with SMTP id
 adf61e73a8af0-3c3ada195f6mr22321530637.47.1784665705421; 
 Tue, 21 Jul 2026 13:28:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f06:b0:3bf:6c08:2b27 with SMTP id
 adf61e73a8af0-3c3ada195f6mr22321502637.47.1784665704930; 
 Tue, 21 Jul 2026 13:28:24 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm1551194eec.26.2026.07.21.13.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:28:24 -0700 (PDT)
Message-ID: <ce41837c-6305-4d31-809e-353ea6c2fcf8@broadcom.com>
Date: Tue, 21 Jul 2026 13:33:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: uninstall the IRQ before freeing the command
 buffer manager on unload
To: Fan Wu <12321260@zju.edu.cn>
Cc: Zack Rusin <zack.rusin@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260714094511.2960308-1-fanwu01@zju.edu.cn>
 <2df4713f-bf61-40de-a43f-5079e3b5d5fa@broadcom.com>
 <1F85D73C-FE3E-4838-9A54-0014AAE3913B@zju.edu.cn>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <1F85D73C-FE3E-4838-9A54-0014AAE3913B@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 7/16/26 7:24 PM, Fan Wu wrote:
> Hi Maaz,
> 
> Thanks for the review. I'll drop this reordering — keeping the IRQ alive
> for command-buffer processing during teardown is the right call.
> 
> One question before I investigate further: is there an existing teardown
> invariant that guarantees an already-woken, but not yet run, CMDBUF or
> FENCE threaded handler (vmw_thread_fn) cannot remain pending once cman or
> fman teardown begins? If there is, I may well be chasing a non-issue, and
> I'd rather not propose an alternative that fights an invariant I'm missing.
> 
> I'll re-check whether such a handler can outlive the current destroy
> sequence before suggesting anything further.
> 
> Best,
> Fan Wu
> 

You can drop this, the current teardown sequence processes things in
the correct order workqueue -> thread_fn -> irq.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
