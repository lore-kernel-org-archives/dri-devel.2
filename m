Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D54C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244F710E8D7;
	Wed, 19 Aug 2026 18:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i4WgCSgz";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D836710E58A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:48:34 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47fe45db360so161469f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787165313; x=1787770113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EW739r7Mim0OCsUop6lWVdH7PWAyT2daLn1wLOzX3fI=;
 b=i4WgCSgzuu6ilBMaDyQIhPsS8cq5vgIwfOcWFzziNlPC84+wY8jmYF0fYqJuWqpYHB
 wqJbFHpv/4UQrVrsitb38WBawTdvlvhkepURgtHZSmAaWtV7AubyFdrNFR35YFlKK+TP
 ci/aJqJJDHXCe3RoWUgZkZ0eZB908b6AYjuMg7tV7snJ+qUiLOqJYVTyP4DI8pY2T8pP
 cN946A8OBNGLrR42Q6n/bnwklTPMtxuZJ4HheDe3OgbUIlSabir7bcyNy65GUkOv+Z2q
 UJb5VCFoSyqxB9iCd1W5qfVSRGvYFFoUoXUyHjNXHm63BVth0fcR6THnEvDwXIbqvORa
 oB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165313; x=1787770113;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EW739r7Mim0OCsUop6lWVdH7PWAyT2daLn1wLOzX3fI=;
 b=UwFqLn8hyzHltqrvQczSoWLyp1ZiR4qyyR3drUY3MaCfOfVvR+LxBrUx6JbKLVhy8t
 A/i3IUWV1nyL5fs474aYD/DpQirzY85ASGywaBTbUXUvGM09Ykm1/3qsnWWedm1q6Jmg
 IyAOWZ/YqsDTjebSLn+twzADrkjZcugMUIhGWWa1dCsVogvthEnu05xGrWt9qx40dz//
 fUDem3aI33/HgQwi0yKkdg0ZxVfiDkAWVjUR5HEqZivyrY8StSNDxOoe//tBLer1+5Kh
 RiL1Yw6bwZIsKyDITbsNoa6IJEbXCjtrwPofaXLuR7ft0ZKV11W7veA+d5c1T/6hjMDN
 mLpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDYbVtEdvqZ0b9m85ftxYJd/S2Jor23Ttx/KwUpN03jb4yOn3CckitL1PJiSqjvuYLqdf9z4h3FPo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6sM8d+z+lYHO4SEeJVWF3DroQaMeC5CoDkkDhRWWZev36U0po
 ntX+bflKqN1WPEh4A9BoczillAYAVvEEBbilRHQCuPQUfsMZEiFhaCWU
X-Gm-Gg: AR+sD13WVwdJY2VRRpYSozKMajYmioSRu3kjHf2VCrPq65MrMFrvNj2jCa+5EZy6Jql
 HN0bjEwP2wsv9Ny3dNWOIBDBwaHMpOZenOQDPqCKQEPeGMNh5Askv4AVILLxZzJUIn9IdeWfYbi
 cw/4Uz/VNmy19MylxYH7nj56BiGed8JKRLGpYoqtgYoHq4euuO8IzrCd5S9jYot9A1OzyPVggmE
 vfjR5MGkqxNOW7eVAr78b65S+RlL8rWir3ASLzj+gVrZtITAc7ujC7u/Dkw5eGksDCMZLA0gDy1
 TyB9R5VnvjL5NqRTeDLTKLQiLfJoNQInWyChK7NttAMFr0NlB4kBpQmv1ubv68kZ9DcklWJcqA3
 BDl9IH8MrfBhCLQKRn9KPpgCIrIngJYuMdleITSHA6GaGoUWy3GkNY3MxMXVZsE53k0JpI2S7cH
 WE7uACE0KoZPU4U4DRcVda9lB8FtCTJB76FIjCAjAvAKKN+NV90CfVSy73n4PHGsH7vUpN7YQ6e
 3WgoWziUBHSRJqsy7vhgcpm/eNX+xpfK+1MaNsmzjrdpnoWGe1Q5P5LCt0yLgZwcZXA5Lm0h1yr
 lG9Z
X-Received: by 2002:a05:600c:4f56:b0:498:8e6:d463 with SMTP id
 5b1f17b1804b1-499aa19a75fmr67821295e9.1.1787165313072; 
 Wed, 19 Aug 2026 11:48:33 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B9296006957154F80580DB7.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:6957:154f:8058:db7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9b7c987sm40444085e9.1.2026.08.19.11.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:48:32 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Wed, 19 Aug 2026 20:48:00 +0200
Message-ID: <20260819184807.6665-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
 <20260819125932.5853-1-royalnet026@gmail.com>
 <82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Jonas,

On 8/19/2026 6:20 PM, Jonas Karlman wrote:
> Correct, the power domain must be powered on when PVTPLL is used, I
> thought this had already been concluded. It is hard to fully keep track
> when context keeps being removed in each new mail ;-)

Fair point taken - I will keep more of the quoted context from here on.
And yes: what the reset run added over the earlier conclusion is only
the differential part (bus clocks measurably contribute nothing), plus
that the failure is an immediate firmware-level reset rather than a
recoverable error.

> It is probably not just set_rate, with PD and/or CLKs disabled just
> reading clk_summary to read SCMI clock rate can issue SError or a freeze.

That is a very useful data point - it widens the hazard from "rate
changes" to "any SCMI clock op", so the series' guards have to cover
get_rate paths too. It will be quoted in the cover letter.

> To my knowledge there are status regs that can be used to get the
> measured rate of the PVTPLL, at least upstream TF-A have a commit [3]
> for RK3588 that changes to report the measured rate when PVTPLL mode is
> used.

This was exactly the missing piece - thank you. I tried it from the
kernel side tonight, and here is an honest negative result: with the
ring demonstrably live (CON74 bit0=1, CON0..2 readback matching the
TF-A table for 1 GHz), the domain on, pclk_npu_root held, all three
NPU PVTM gates in CLKGATE_CON(29) opened (bits 12/14/15), udelay(2)
before each read, and even with the whole set_rate sequence re-run by
the firmware after the gates were opened - NPU GRF+0x24 reads a hard
0x00000000 from EL1, twenty samples per arm, four arms.

So a question for you and for Hüseyin (added to Cc): is that
STATUS register perhaps readable from EL3 only, with EL1 reads as
zero? That would explain everything, since [3] reads it inside the
firmware. If so, the clean path is the one [3] already implements -
after my trip I will cherry-pick it into the BL31 my board runs (it is
plain upstream v2.12 there) and re-measure through plain clk_get_rate,
which also spares the kernel any GRF access at all.

[3] https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a.git/+/d2d6928641bacfa2370a9bb38cdddad229d99ad6

Regards,
Igor
