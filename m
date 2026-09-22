Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C52C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC66410E753;
	Tue, 22 Sep 2026 17:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oRb5+U1r";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6256E10EDBF
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 17:21:59 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747eb79f7so475315ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790097719; x=1790702519; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g51CWbLnarIyJ0OhwzK8Z/JluNHOA330HfdYyzEXpGc=;
 b=oRb5+U1rIK/7fDO4eoOeGUrglg/nJcPWSTb2lcq1c/Oa+STeiWPy3oDhoXF4pkPCFk
 4mQiNRJw0dWHP+aQq0jy3VQdmnwxItjfZYuo4JXy38B+5+rLOFhZGk+IFNGt+fNVoIID
 L9qAlSbQsRpgshX8Wi4wCQ/cMpfho6UgfTfs42ZcfsHuNuupLE+i6uWed8LUSMjeyhDI
 YORfR8x0gb3VQ6j+EcOL5JPypAciEKrhuT3ZE0o4aMk9Ha2Fqg1KKkzfrx1+ajnc4lA5
 INvXSXE8ZOh+lzc3F7sgXojQcOA91h/4aQVrLIKBBvZPR0Kzqw3SidT3C576de8eswka
 JFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790097719; x=1790702519;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g51CWbLnarIyJ0OhwzK8Z/JluNHOA330HfdYyzEXpGc=;
 b=Yh4zxWGFvpmEvrIlYVv+Lqn/9snVSNntgkUXtIQId8j7yZz4sZ1BYhwSGV1hk0/Mfs
 EJC8AJNG5/EknBQCbcIjDFOvFVfLQ3ylbtFLFCngpPiKSxr2mU/tIAQ7Lb2UhqEheBu1
 kTUS1TxDNpS+xXb5Ftm+kcjWixF+U6ZZ9nd566y1fegwZQxiWa8AQ7CFjEpGtm2a2yjU
 CToRGx8U5+XYSOfbhsR81yRcY+bezWsRiDeFHskvbolcifXwps63UnbCoRH/HP34puiU
 JBMLjYLLnJQklbBs78fyMdOCp1ypHr8cFno46rBn5fzDrI9AVR+EnrjWWvG03d1ZWny6
 GI0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBygUeMyY6t8Bk2/H/gt40ni+IuTgQnYqIC+B5ze1kltXr4AIkDjoukdM4YkcuinU2SijypfFHFCaho=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbnp8G78+39TvaDCJOv/2JXEIApYOD6UbfCjZ57Czb9UKLJwuL
 rhuc6Xqc2LtmDVdM1OsUy23Pxn+15oLmCM1tCDutOK0bQphaoQu2NxyY
X-Gm-Gg: AYBFou1rW5tBjS7DvaqOBH9Tp/UEqlk/gIpVE1xfqGVgVMALxY4TNwCmha5e9TwYxFK
 UNrU//hZC4nBBR1GOQSRNdyWDO6dE070pL2AqkPtdxciAwisH0LoSHsdOG5D9wFLdnJvoBGwY0x
 oa9i/J9itEWJLFUBZlqc7OJbbgZiHxAE4KFkG06bgz0pTal/J0W9+7469ZFe1hIqyDIMvXdgwYg
 +WqwSGvVW+DYUyxVmZm15wYDWn37sXgF9Rl0HT9JJLTqvpg99q22u0Y4lrIhoedQXxGIM0QqPcc
 FiokLgbJuG/r+b6AuOeKh0DhpR8Cacjffg38EPAUET6QpvUe028X183kUb9lsU63G3AB+R0F46u
 ki4h+05lqxEJZOmxEXT9V+plwDs2fm4jiPVdx8dowDaxi/hfzU/4tsSuhdRqgL5YGgsyDu3iT+M
 cNV7OtMDV6zkwaI3qvdsn1wQs50HfMKEH2S9bPe33EY3FaoIgivZZcnBSZsgqAeTG9SRx9JPH2F
 doTdXrO6ORa
X-Received: by 2002:a17:903:228e:b0:2dd:ad73:c984 with SMTP id
 d9443c01a7336-2df69d5ac91mr681945ad.28.1790097718673; 
 Tue, 22 Sep 2026 10:21:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d047c40sm13644575ad.50.2026.09.22.10.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 10:21:58 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:21:57 -0700
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
 Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
Message-ID: <cc03390d-8fc7-422a-bbcf-93bfbb82276f@roeck-us.net>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
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

On Tue, Sep 22, 2026 at 03:32:22PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  drivers/comedi/comedi_fops.c                          |  5 +++--
>  drivers/gpu/drm/drm_fb_helper.c                       |  3 ++-
>  drivers/hwmon/fschmd.c                                |  3 ++-
>  drivers/hwmon/nct7904.c                               |  5 +++--
>  drivers/hwmon/sch56xx-common.c                        |  3 ++-
>  drivers/hwmon/w83793.c                                |  5 +++--

I don't know how other subsystem maintainers want to handle it,
but please send the hwmon patches separately; I'll want to apply
it through the hwmon tree to avoid the potential of merge conflicts.

Thanks,
Guenter
