Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A55CCF2D5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B571110E113;
	Mon, 19 Oct 2026 10:52:04 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BAC10E113
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:51:57 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1e266fca2so6720875e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792407116; x=1793011916;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DYETpg2ch3RE6Zgv4/hYXxN4Wo2kZmgkDZJdYz89Evk=;
 b=f5gbtv//DJOiNDZGEWs6oKgkAa+EfYVdOUpRAZ9knPbIe/caO5iMwEu+jbWcbt5Ei1
 mNiZXka7gD/JsSXMwi1lge4MSVqzq01Ehc7T700LJ/ceIgfvSQwMMmxfSBi0n1W8kO/t
 +vqxRNwV9InHUvyPEIJeCBkISGH1JL8UMMTvpwzWcOoTmqxDjU7PbUF06tRr1bE8Z7mw
 M1goSTRcoKtXK3Vr2PTDEMv5UOzqonEwkkXZMfAtX7a0bb6cEUHwGbUX5qMabgaOkYTB
 1ZWKiGPQkgSSbZC1RjZqFzz/mOpG5/un0RtvOZMgyQgGm+rPWCz7tbTEa0SjcOQklmlQ
 LAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407116; x=1793011916;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DYETpg2ch3RE6Zgv4/hYXxN4Wo2kZmgkDZJdYz89Evk=;
 b=W38jeU/zXbLjLde5uAhmjP74363jQ3W5TVovueXuIE6fcSlSLF5ZGAoyduXp2IX+g9
 ABqpFxx+fkydZMSXTYg4cRlpjTD8DZcVi+Buy03oe71Hi0qs/uU0exLfT2CSkuJjU7H9
 ZMvgIEo1HhkLM6jk9oGFuH9fpYLq4vQSsUWDL21XTmgk5oRWDZogS5TQFHHzJIf3opR2
 RG7rxfVOJYuC/M82snqg/KmN9lEZF5TBXvZFo/gEPw3ZNKSW+/C8f/OBgzsAST5NEa4m
 Bmd+m2Fj9hVMLTyGCHSYnNcyXeqf2EA7Vs/D56N6sizYsgS/SFN+OtX5FWm/koy+lQz+
 CubQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBySIayeqC8JE4lw3WZCTBozKJ6v6Vjz7lGfZ6deJ+A33yT9eeaz+D1DiktIe82mgnLSs803JE4RD/Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIsOR+y0CmtgOzui6ScMdKps3SoQ2y4GDLG+LEplS3c1xDB4VpS
 /ccUw1QTY5nZ/5XoLLDymqEiwGlgpak66q3VCrCAtvQZUqlh+CVjSGEgrp2dHtnuyBo=
X-Gm-Gg: AYBFou1QlSUzLIXvYL75nc3+KtyV0gp7ThDSOEdLzJ4hHshk8qEF/h+v6gdNYuxyx1A
 4hk5ZjVT47PfC7d5yZi2OAT2jrWiQ2WWfD3bKtRZW5KUgCvXOQBAm0UAcipUl07RbEB3CppfD1A
 hCy8S041SBwqHeaEufdCVgkMAznRQozhJhs7qPD+z8wR33xpMQVmGpFgNZAzVIp7aWBv/6B0f9x
 tkhuI76Mgq5o6SnBRr29EWAnGkHjVpKduxe3HYqpbAh2QBLAKfZyISkhOSJnZB6BcW2znS30mbH
 nzJYEh/dicjwOMytet16XIKn8ujtRW/crpMdR4b8Bl8DPdmCvFyxrYF+NlV7xo5PRMfCEO7d8d/
 OJr+drG3ZM2SA76RfMoi2wM5hsoBV1GDaYNTgZaPHzrw3JW1KFfONGBhPcNSs5oh4Yk5WjKhGu3
 lg8xOj+sNRvzqu74Iy4Mn23/hQJ23oms8bVr/doUvFxbAz9ePFxmr6bqWrdXqt3cVQ6iGp7+T2x
 pAvzUN8E5EOYvWhvKb3GB21K2PGKBu6/U00XL3EHWh7JT0xiPwtYl7RYIQfng9KYveX690ajuIb
 I1uQ+lVxhm2qYlsaq4uCg8NczV5hNTMLWg4chP9KwrAxuG7N1VTF3OVz906z0MTMQjO0vA==
X-Received: by 2002:a05:600c:1da1:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a1d76011ffmr159510145e9.19.1792407115972; 
 Mon, 19 Oct 2026 03:51:55 -0700 (PDT)
Received: from aspen.lan
 (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b303csm349369535e9.8.2026.10.19.03.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:51:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:51:53 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Luka Panio <lukapanio@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com,
 pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: Add Awinic AW99703 backlight driver
Message-ID: <atX2Sf4GJNFYq2ZY@aspen.lan>
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <20261016162912.64581-3-lukapanio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016162912.64581-3-lukapanio@gmail.com>
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

On Fri, Oct 16, 2026 at 06:29:12PM +0200, Luka Panio wrote:
> Add a driver for the Awinic AW99703 3-string WLED backlight controller.
>
> Register values follow the AW99703 datasheet (V1.6), the structure
> follows the aw99706 driver.

Given how much the structure follows the aw99706 driver I'd expect there
to be more code sharing between the drivers.

Cold AW99703 support be implemented by extending the existing aw99706
driver?


Daniel.
