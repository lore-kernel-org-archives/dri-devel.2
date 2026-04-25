Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFADFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 11:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6486E10E429;
	Sat, 25 Apr 2026 11:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BaNfdQBo";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1CB10E436
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:02:39 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so41940475e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777114958; x=1777719758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krEC5W4u3Zy98qJoM/+vZPkJBJL5qw1cHHHERcq1ubA=;
 b=BaNfdQBode+jUzHBq1sB0dt4LUQyekf8wmhCrJ7lmaIwgIhh8kVGb8APTwPGOiF4xC
 kAEYvTNdUNxB4VLucbl2y8Fmbi1jyiktFPjrgGG9AxJuyYyxAfWC/8VvWqRnGTKPVS3u
 QLZVH77gN2qCaGHzc1sSsy/ryPGzRinjQKUrU+nsnzb7DpnhhqjEsiLqV+GGmFJNbcAe
 tWHAL92dyqdt30eFAD0MertLAQr5KMsU2ksQL8H1VjT60F3l/2OKGySmS35m0nOSRFV9
 KptmpO9ucv+RK268wIFp+EMZCH4puHnUosc+e/kD57InJNnTjO/rqNFMqzqAuRjzWYX8
 WV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777114958; x=1777719758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=krEC5W4u3Zy98qJoM/+vZPkJBJL5qw1cHHHERcq1ubA=;
 b=PkgEZIBTHTIMYY2LK8xKm/to88iAZUHpMZNL+TcqpBzVCXTGLtx/uWTk3I6tF5qrLP
 XljYLzjOcaQe5viVvt8nO35GITF5k7C5dApUgKiXj01SG+sRkNcCjTXC27+yYyQijxnp
 APHiE15KmSpNzIfwndIgpep/UFJGVkjS5zZ4ESEFTDQ315iaJPbgwU+7W6vAxRlqO93t
 ePY0EzHZB8PVPKb7QnMmjzfJ9Ujy49apgyjCJfxruZZkuu//DSnBx3oVn+njLAXeHWnK
 4PmyMGduizgX+yeHjgiqkoE3/YpNJy9JhlVYzFBrASmRLs+/H0z9OcHhLVsG4Fg2Bdpx
 MfIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sLGO6JkE/8sTDOD8dx35RzHy723UyMoqNgNolCbAhNWBEUK+EYO6+3V/+DilU2SFtSfVHfz702uk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmJIUGrbXfrF6KHDf2cRH2t6g03awZbS+J+JxAfodDELZw0luJ
 L8dSGhu+azirDkyHibswL/5YMv65KyESNf4Jy75SMS8BdGtUKbWF/4NJ
X-Gm-Gg: AeBDieserFIdJMlFZqgke/hW8JL7T2j1kWqoYTNCXgVk+29h8CIxM5PhViP+Vd07JAL
 NDGWbwjxNqHXdboDz2azr6ifljEOYF/vZ2MXM3ME6rM0DlcXqCeUSwBHoXRjslYkPqhIxcoRjZD
 VgJvYeOGZ822+TqpTbmcwlbVmFK03nCQS9bllJQnO2VmTWyyy6jzkJnfHkNHaA4vgZshBI5jVWt
 oD9z+CgTb79SMAo3LRsKjcI4JZdLzJFcVjglybOtg5A2++Jo0U67SCw0XnpwQPVg1VOS28SZyKu
 dE/2XZk652WuDP00gEU37ci9mJXgunAdHsGPjQcOtVR+jyuR1Jf8jaydXH5KSYJweOuOZiPfiUb
 s9ctph6wvOZ7SkX79ua1iiewHqDFBEQi3KP4nNML9FFJ5l1E24jQ4NG4+vvSYXJjdkv6piwdng4
 SO71dyaiv5YbidD74s19tYAa5gQlTQ5QEUL/l/1iPs+NALT6n8FVupPtfQf1mCozUh20hIB5dtv
 780zmeTFQSsGQ==
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48a53390f6cmr295415295e9.9.1777114957837; 
 Sat, 25 Apr 2026 04:02:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb77b001sm312125075e9.3.2026.04.25.04.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 04:02:37 -0700 (PDT)
Date: Sat, 25 Apr 2026 12:02:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Ai Chao <aichao@kylinos.cn>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux@armlinux.org.uk, dilinger@queued.net, adaplas@gmail.com,
 James.Bottomley@HansenPartnership.com, FlorianSchandinat@gmx.de,
 alchark@gmail.com, krzk@kernel.org, kees@kernel.org, rene@exactco.de,
 tzimmermann@suse.de, rongqianfeng@vivo.com, thorsten.blum@linux.dev,
 chelsyratnawat2001@gmail.com, soci@c64.rulez.org,
 gregkh@linuxfoundation.org, daniel@thingy.jp, linmq006@gmail.com,
 fourier.thomas@gmail.com, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-geode@lists.infradead.org,
 linux-parisc@vger.kernel.org
Subject: Re: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of
 strcpy()
Message-ID: <20260425120235.2ec10089@pumpkin>
In-Reply-To: <ccd01f97-d4b7-4bd0-92c1-adc3b1136cbc@gmx.de>
References: <20260425065926.1091168-1-aichao@kylinos.cn>
 <20260425065926.1091168-4-aichao@kylinos.cn>
 <ccd01f97-d4b7-4bd0-92c1-adc3b1136cbc@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 25 Apr 2026 10:08:08 +0200
Helge Deller <deller@gmx.de> wrote:

> Hello Ai,
...
> > -			strcpy(ivideo->myid, "SiS 730");
> > +			strscpy(ivideo->myid, "SiS 730");  
> 
> The compiler knows at build time the length of myid, and the "SIS 730" string.
> Using strscpy() has no benefit here either. Contrary, the code generated
> because of using strscpy() is probably even larger.
> Don't replace such code with strscpy().

Both should get converted to a memcpy().

If you increase the literal to be too long I'm pretty sure you'll
get a compiler warning/error from strcpy().
OTOH strscpy() is more likely to truncate the string (I'd need to
check).

So leaving it as strcpy() is fine - and possibly even better.
The header files might get changed to error strcpy() unless the compiler
knows the source string has a constant length and the destination is
big enough - but that hasn't been done yet.

	David
 

