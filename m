Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3469C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B90210E6BB;
	Mon, 24 Aug 2026 09:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wpblXRqI";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF96410E6BB
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 09:33:20 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so25366535e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 02:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787563999; x=1788168799;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FqqX1Mln5GUPxDhrH5Nc5ECsMnro9xqpY8P5ZgebS4M=;
 b=wpblXRqISJiZWsH5GO0/JNfLTB8ZPwtCQ3F3KUELoGdvhfdWUvFz75LmxbIrj34jUT
 0M4kW24Ws28Pc+q14qmb2NSR7tOMuIua3g0PJ0BQA8hZO1SNQ6bsBmlPGrFDwmpNwNbm
 holcq9YXatEvryVujCsWiO374WmFrIJCkCIeQ0zl3xR+GpLU+GsbaAc9y5zSssseMXTA
 0BB7MBope2SsFAMB86dMzmbJJvU8sbaIU65GAiRG+1Aibvm1fgCiF189mn4s+Gbmu7ci
 dq6izW+3/RAL2lb9e4fXE0IoeWwmFy71rFfqC2A95KAoO+dMqmG6c8mi7kDfk0Z3i1vA
 zrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787563999; x=1788168799;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FqqX1Mln5GUPxDhrH5Nc5ECsMnro9xqpY8P5ZgebS4M=;
 b=HMJzcmzk+FdkfFAf3G23+cCNF6SQoxzbQTBYJmTBHdNCm6TEGiXc/9l8N6401C4zmL
 Wqh2YeOiC9H75FLBZ6ykog1/eS3HlRtnLQzckBf9MDiOkPElNeHYLea7Lpy/SCmA+zGD
 XW43d4Ef5+QPha/BeBvsym2UGZ53Eam8tSug37J1PMhy1oGKWReKuMaRSp1zOXbEHcZQ
 jz+9UP9onopM291hlMlG3Me58kmvUuNhHPKfajYNhcFZxjIEXqex2mknDUNsv4tIbFOx
 0Qg6nrEzmak9WjPMEaxCWsRgSWI9zt4dFopa3OOTCaALH2r/ZWy7dGgod7Z8QUgvnqrd
 xIzg==
X-Gm-Message-State: AFuF++mzSHiA5GMA2KVAVQU9lPD0THB9Licuox5jbKQAhYpEXhwwQ+aF
 YVjCpYKMr1Ys3yS9X2eZ+IC2rHi500mN+LJMGlJBaD85x29Lh423YfznoMsUkOkaBMY=
X-Gm-Gg: AR+sD12czYEFIzlgUXb/5dhKhd5HGjdCWsyDBAqBOukIJDrmmKRD5CnyBbYg/Z9sHZ3
 WwyRPzv6e3CG2pdDNPBRBte21kTsjG0C107bTwB7yeMvA8j2RpYkgfgHOobUUESgXwRZjqbgCZS
 yvg7jIqebzC+qtYeAVm1HsQwBaiGck1Ixgz9IsrPfkBdCOMnBnFu7niuuQ26ulh7kmwFGPSfdWj
 pjxnVAFfL3A1EZyn7KVXqE3cxqYhYndKgbRsgqQKhZmA8lWCfZQq5wFYp7r5f1Zw2wjsk0+dd/9
 d1puwlCClcLygkv54Oy7P6oJacqaS9TSJcdehlIkbYdd3B1MWn8wBibTI4eNX30+giXBrmPZNms
 ELFYGx5eMJ3/XKop0LW7efKMw5uogwK6nib9jTLu1TGxAsXSn6AnHPl8EtZsrz+f0cN1OqA+yCJ
 0KZEIK8F3YaAaSk8WPzStNfu651H0t2CrySx+vO9M1PGOFvkAWW7mo2NWtQIhNDa1f69ULXD0M2
 dcYGJYX3KMGYzn14+nuXHK8tcqdvrpUA0LAKmb+JIrRt1yamGEeZbrfgoQ+FXqvC+ajLPaFkWk8
 jCft23AgBlUl4gzUyg5ia5O3c+eWmTkSYUpMEkSHjphd+A==
X-Received: by 2002:a05:600c:19cc:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-499b847725emr306902295e9.15.1787563999161; 
 Mon, 24 Aug 2026 02:33:19 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499bebfa94esm70641885e9.1.2026.08.24.02.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 02:33:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:33:16 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp8864: Register a backlight device
Message-ID: <aowP3K7sgXKnsonS@aspen.lan>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
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

On Mon, Aug 17, 2026 at 07:08:15PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> The LP8864/LP8866 is a display-cluster LED backlight driver. Expose a
> standard backlight class interface in addition to the LED class device,
> so it can be used by display/panel stacks that expect a backlight.
>
> Use the new devm_led_backlight_register() helper, which spawns a
> led-backlight device driven by our LED and tied to the I2C device
> lifetime. This keeps the driver a plain LED driver, requires no
> device-tree changes and remains backwards compatible with existing DTs.
> It is a no-op when the led-backlight support is not enabled.

... but when led-backlight support is enabled it will prohibit the use
of the LED sysfs interface.

Having zero DT changes is a nice property but it seems rather fragile to
change the ABI the userspace must use to manipulate the LED based on
CONFIG_LED_BL.

Is there no way to explictly configure which ABI should be used?


Daniel.
