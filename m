Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B3BCCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12A510E12B;
	Sun, 18 Oct 2026 16:26:32 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F6210E12B
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 16:26:26 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso1074196a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792340786; x=1792945586; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
 b=GUTkppTB9rW7OIbVun8syKkSW78mpFnh4bcaL7kZd7XVTaDWuwBBeO61msjvexoOXf
 fzMl4lfA3Xjd42vXnzH2wcYrLO4QSAhVqL4lm8Hkxh8mo1QaRbPBmOYmZQVflysV23a1
 5hz72qiDETcfGxR63jMfIfYuVosxuWGcVhrl2mz1CWGXXtvLMdFXcfKZCXJ5/igHvepc
 Z/+g/cSIwXz01Fay7BaX70b9RGtDJuC1Ig8jbkf7ZzWvGbKBZsw9KNw+MmstvFVSAiJc
 FjMLuhBW6SC7oymw+FcHJVeCFkjcAXibkb/Rbci8xV+mcUPIzOJSGtSk0/Ac2nsApG7m
 LdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792340786; x=1792945586;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
 b=BkzBSIa60vkmbhqLUfXUX5bWYZRd95QoIfDVEnMKUN89TRHVvZtyZhI6F3RlkAQCxL
 EwGKF9L1Gdm1sIM4HW5HpwkTnxzzgwzlNnODkb5v1BWkE53T6ZlRRdiE4OP5llEqSTs8
 Jeqz6ubdDzQjgp4x0M/crIqWT5shhEc8/IhOgWkYul2SPhZ+gBas4UR3J2rzDK08KzdC
 A7OtxsHoP6m/NLHHTGB/RKcD3vOGZp5ObgDHD0J9F7xIvFSzy6cyN3khxcaiF+HMOjm+
 zRMfhC/tKYyvAtlo9t6pPnj9reSOmqTmgAOUQLSkBmyI6X2VbNlBkfWXrlIlyTxB1uPI
 XEqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5LIDFk2sqsPMnOitp6um63tbDR2qeI3/dnoyxNHRuSYQ16bGxSZyQP96l4KxNUhanxMIWzHYpMxY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJLJBIWjM/xxXFBLAeW97KcUZVXY5f65UnhXT6oeHvopOLTF0v9
 CmRh993uXnTv0P81Je9m6g4ktpqkJAmPowahxIgOBR62nZLy32i1Fsyt
X-Gm-Gg: AYBFou1fsdK1hHm0MZ734TGJBbtj2Q9HprlSYD8cuBRLC22UdDzCrzzMZgtCikpj2kP
 IFgm0pOSf/uy42fxcMDUZTDSESAWKQXaIc91QB/PuLZLtyRz33dEh02rvAsboRyNZOr0dwg5PHY
 TQPsyJ8CWDP5DgdcabPq65VGR8uzsZrrBr0lhXiP1PluT7lyf28gCRjJzRKAZ7/gPuoWUWATweT
 4ynqtw+5TSMy0MuAvq6pjeapOH/zwcNs01IomqGsA5G46LZSfAOUTVA9emoiqGpMTZ/O3Vm2Crg
 kud7I39vpHK8pU/8m4or953r1bthmRO2Xb6L1dxFJk4b5zIm7lwU8nxUGFyjNB7M4Bz7a0bbbDX
 VFiOZLUeRw8jj4M1d2evqq9BrMch8qRROaH+IrHJ7O/QCkhSxZZob3AMu0CEffCC/Nj8DmUXfqA
 SHBlBoQ/UNHPwCqKYS1/yL8SeLL1J9elWNu0kl9uPhV4INhqX88QAmjqQC5d7obNkilT45CunpD
 LyKwofYv1hr
X-Received: by 2002:a17:90a:da87:b0:3ab:36c4:b502 with SMTP id
 98e67ed59e1d1-3acef19656fmr4952624a91.30.1792340785847; 
 Sun, 18 Oct 2026 09:26:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc43a1981sm12210945a91.2.2026.10.18.09.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 09:26:25 -0700 (PDT)
Date: Sun, 18 Oct 2026 09:26:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with __stringify()
Message-ID: <49d1de69-ffce-490f-bbee-80513cfd0cba@roeck-us.net>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
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

On Fri, Oct 02, 2026 at 10:31:01AM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Applied.

Thanks,
Guenter
