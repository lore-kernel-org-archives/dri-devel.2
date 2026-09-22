Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4645AC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D1B10EC05;
	Tue, 22 Sep 2026 08:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GqcqEZ2x";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F69F89316
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:56:30 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482e1b55da8so21750f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790067388; x=1790672188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wq2LoFmFiObS5jB4OwtPqD7h4w1zA3ahilWAP6xrcps=;
 b=GqcqEZ2xppBUF3Y+qxIfoF0PPQgaEiDRmSEHtIMr3cI/n2m+ej0db0FgI8hjisJZOV
 uTL58rz+fltl7g5fra1NDDaLIQqDIzJPscWTGEY1FuGHzr9Dw3KO6WUL+noxUIPh8vFu
 1iC809rd3O0Rd4vXlgLJ4UtfwaUzzgVAI7Arv3gxiiqNIkltA/3418r97gMl7ChdXGkg
 vwU/DJtEtEVbzklfG6aMqL25/a0lEHoVh5PGxfLpy2fG0ii3NTBefF9b1+3RL6dwSItv
 koHIBXe58FB5gByEPxY2+gpKFjKCxcS+nxRcgyzn/bH3wGcHMttfh+lTpVstPETAgHx4
 qvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790067388; x=1790672188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wq2LoFmFiObS5jB4OwtPqD7h4w1zA3ahilWAP6xrcps=;
 b=waJkWZ/l1fTGtnPIuQAN6NPEzMIeJVbo+vwd+4hMFsFg6hfarVZHZUpJwn7z1ijkcU
 KYGCHVLUmpQXXa61HGdU9rsOdzbsS+/15C25GrcH21N7+qlF+CXkpVTdFEEyk6x+7qbw
 Yl/1J12OrgFHL3PSa8ecztU63Xl02j4xY9cAaEfEtnCTP8NvdlR1Rkc/DHD2IuM71zsk
 YkGs5a59qa+bklK61RK+oGHlwvcLKI+HNi/edlcIKz7eKUf4v8O7EE58kl/yWte7Puq7
 Q/iIQ0gsS1pX8Mk6CMy2BSwZ9qD149t+5q936onCztZuyDCYeQAU5B7Zy6XKxt0jsHce
 S3yA==
X-Forwarded-Encrypted: i=1;
 AKwUvByM3xHJ+ThQjxEpQ2T/IkRuqT6iv9qs+8802yl6Gq/NXnepr4aParsTAUjH80oTxwRx63zWIJxrXHc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lW4vnzYWEu+ErDqUU04odID46hWkrWvtyhFfc90XVslcOlIwdv
 Tl42nc663GCtqidGov2pxRq2ewllmfwfxqO1DRTNAepiuYLDbwEbqxf7
X-Gm-Gg: AYBFou0GHiTVwEyf6FRn8NOyZ1KNCMdkzL1+H0gfZi560gJQmPnyO6AQmCYT54tKqAC
 ErlI6m8UtrInvlhriWb4FdF89z1vZnr3uW/9Tda1mnM+uRcB0q5wQEmU3RlB8+qIv63CZjDAfo5
 fDsxTMug1X6rdkBq5tKivii8Lpm4+iSBVGr6p5SHeuhg7V+MTBtWUt/gDdiirYojLarFZbJPDGI
 soALySzdplopd7QsowcYs2THi6kp3SH46mq651I0Q4ofaWcFEcN1yWpelypyR8WVxM7YjphtPfT
 3hsGrsKsehnMtBWHJdizMGqrT1iR+fk9OCbVxgOrspUFvROL8V2G37qow+dF96j/frB+C+my8a7
 xrou1mFJozSOYguAqJ3yA5laMFsJkz7muspmyI9rLpcV2LVYsFwGWBpxHCrnyVtSNlD11keN2Z5
 FB6pkmwQK3ZS7dUqHWzTcQ0LHOb85mjv86vD18K2qczBV6X4xV/sTjBuAE0jB86WlItiqL5oDrT
 +CrEmg0xzUXn0zFVZYKNymAPAPbkMKbdjCExve3yERYRXjUgS1O7jyZ9nsIF+UHnCjI6yhXe1jd
 +0A=
X-Received: by 2002:a5d:64c5:0:b0:485:ac0a:e11 with SMTP id
 ffacd0b85a97d-4871f9c6776mr18336406f8f.0.1790067388322; 
 Tue, 22 Sep 2026 01:56:28 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886279298asm2881848f8f.34.2026.09.22.01.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:56:27 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] accel/rocket: add devfreq support
Date: Tue, 22 Sep 2026 10:56:17 +0200
Message-ID: <20260922085617.53620-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922081855.160451F00893@smtp.kernel.org>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-10-royalnet026@gmail.com>
 <20260922081855.160451F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On the five findings from the Sashiko review of this patch, in its
order. All of this is from reading the code; none of it was reproduced.

1. Cores left powered after unbind: not with the driver's own settings.
rocket_core_fini(), which this series does not change, calls
pm_runtime_dont_use_autosuspend() before pm_runtime_disable(); that
runs rpm_idle() synchronously and suspends the core on the spot. It
can happen if root sets power/autosuspend_delay_ms to 0 and unbinds a
core with the clock raised: the put then queues an asynchronous suspend
that pm_runtime_disable() can cancel. v3 will drop those references
synchronously on the teardown path.

2. Ignored return value: true, but here an error does not leave the
clock raised. Scaling down, the OPP core sets the clock before the
supply, so a regulator error comes after clk_set_rate() has already
asked for the 200 MHz boot rate, which TF-A serves from GPLL, and a rate
the firmware refuses never reaches the caller. v3 will say so in a
comment at both call sites.

3. Rounding the boot rate up: not with the in-tree devicetree, where
assigned-clock-rates gives exactly the lowest OPP. Without it, a boot
rate above 200 MHz would map to a PVTPLL OPP and the cores would be
released there; that is the code-read-only case under "Not done". v3
will create the devfreq device only when the boot rate is at or below
the lowest OPP (without assigned-clock-rates this firmware reports
198 MHz, GPLL/6).

4. Restore racing with rocket_devfreq_fini(): real, and this patch
introduces it. device_shutdown() pins only the core it shuts down, and
__device_release_driver() drops its runtime PM reference before
->remove(), so the last core to go idle can reach
rocket_npu_restore_boot_rate() from its autosuspend timer while
rocket_devfreq_fini() clears ->owner and removes the OPP table and
config. The window is a few microseconds and none of my runs set it up.
v3 will take pm_runtime_get_noresume() and pm_runtime_barrier() on
every core before ->owner is cleared, and drop them afterwards.

5. Concurrent unbinds: real. Each sysfs unbind takes only its own
device lock, so two unbinds can both remove the same devfreq device.
The unlocked probe and remove predate this series (Sashiko's finding on
the standalone slot-search patch, which I agreed with [1] and the cover
letter lists as open), but this patch makes the result worse. The OPP
table is not freed twice. v3 will add a driver-wide mutex around
rocket_probe(), rocket_remove() and rocket_shutdown().

I will wait for review of v2 before sending v3.

[1] https://lore.kernel.org/r/20260904135938.8757-1-royalnet026@gmail.com

Igor
