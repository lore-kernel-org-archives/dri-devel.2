Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E97BCC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C2410FC87;
	Wed, 14 Oct 2026 09:36:28 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905D910FC87
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:36:21 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso30632055e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791970580; x=1792575380; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9nFXolfpittgi2Lah9fQ/bqQ/j+/1tOBiVSyiO7ElMg=;
 b=EA/2AjJkc8hREjt720hCz8fiz4loJZawCZrmhXOPOnYizlOpDdojgBdAg2L0K/bN8l
 hy07NftemPTpjrp1mXiJtLWwOLI6Jg0pn/VmJqcBHQZ1BVLk2UAK2HC2HzgMuQo2nGwk
 DOVHsE6kTR7hCMowxrbq0V/DE5RUvd7urHAWHBuyK8bpf+W8kRX3R7xFui7uMLuimTEn
 QydjVZQsMQg/1LdVmKDMou77jVo+XC52Rl9o7YqsWqk/5ea2fIdWhFY3GzO6BQBvSgzr
 vjw6zGPrTmC+aeMvxCRO1xRVMj4uOAMiAk1PWMiXw8hgiT2BHHT4Cu0+r3LVubj6HEDL
 /WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970580; x=1792575380;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9nFXolfpittgi2Lah9fQ/bqQ/j+/1tOBiVSyiO7ElMg=;
 b=hvhXcvf+3bq7H3EePM1EZrAWZ14MpFg8+bIeNEEfAEOFoaTD5PuWruC3Ru6S/5M0/F
 ekx8VSjUJnk00QUa4hZcgB3GdFYxy4oOlPyb4LaHXR12pj+PVB/h6ZHvUcoQxq2VIfeO
 YDVHvgWsBUR2PxsMwzZGvLXuxT22hzZZJhSlMtVOA5mPgVUbiysRf9jhxka7eE4ZC6A0
 L9JC2ED1bPlX9W0sh9BlMBEvDltMTmVZKaTtVdRgU96owsxRsEgHL95OKrRI6XfdWXN3
 pxYguOGVNsNz8IlpyjyNMHr55GT4vK31AqDtkdIQmTqVLa/2qfgMogFN82XYBNFXT0Ae
 +p2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8sssCBhyhun+LpghQ1hHmVjCEzBylaJim69zJPaRBPQ9VICmrY4SISEru2EOqom0x/HSXpZa1mI8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIXqFhGNQpLKaPv1KH66NdYB7rKNX7bzBl+g7z9aqmg0r/nOEbu
 KVsKrEO3h+adyRE36dL8XEdkWvTbLbF9RRvPpn8RoGgC6Fy5rBbUeeNCGNutw/YDqL8=
X-Gm-Gg: AYBFou3fzxbqS5fDanddebeQZvn/nV5fGiQeTL6dXKaV4GhWFP8EqT36uBG7e8rqBpm
 IFmzlFrYP/NbszTOyAFSgOIU6QehGLS486Zzp0xVc+pfzsU1cHsF0yxSHTxsTqFlHKOCDhf2/x3
 JAjUeIX0UmfUIETMBa/WSOt/jiBtVFwZjfRqmHJQpxttMIvl9N+WyrEOgh0AIN4X6WelpMR6QJC
 GC2CYB7YZB3QPrg3OD/11v1Dww10pm5e5GsSrE6pKL5HkAIQdmt+2OwvmTXiOx4myd/yvX5bxjP
 5GWuPNEyajceIXT2VAfghbsy6TSDFtG4Tv26IKS7vBF2yfTHvsXPXd0Tm8/QU+P/7PC+fBHL8XH
 oZr4cMjUzqZX/heLCeQ9DXyDm95V1/XjHSriC4QGfkc8jFdyRvlgXngjvD/Cu91DGJebtWJ/qWV
 c3hqrjuIqOMKSU9p8KVptYiBelPFJfeBD3OkU0f3dBgHG4IQ4ic3SySbIVv/+gM1ZQtQ9mQQuS+
 hAohfVkUK1v9miAGvU1I63zRMeoyveZ3kcqmQaRUMKXl+Rttgax2XJq2I2jdgThDXZhs+RFvKiS
 9PEtxjBbVvudh62ubbgJWluwMmC9qUVvWuGLszwM
X-Received: by 2002:a05:600c:8a09:20b0:4a1:9c98:b9b8 with SMTP id
 5b1f17b1804b1-4a19c98c153mr160846965e9.11.1791970579795; 
 Wed, 14 Oct 2026 02:36:19 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa3fsm10907378f8f.10.2026.10.14.02.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 02:36:19 -0700 (PDT)
Message-ID: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Date: Wed, 14 Oct 2026 11:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=UTF-8
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

On 10/2/26 10:31 AM, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() and
> remove the macro.
> 
> Apologies for the wide distribution. Acked-bys are appreciated.
> 
> [1] https://git.kernel.org/tglx/history/c/136839a1b4

I've queued the second patch ("drivers: Replace __MODULE_STRING() with
__stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
and reviews.

The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
should go through the hwmon tree. Once these changes are in mainline,
I plan to pick up the final patch ("module: Remove obsolete
__MODULE_STRING()").

-- Petr
