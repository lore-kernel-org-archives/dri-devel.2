Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB1CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD9310EC69;
	Mon, 19 Oct 2026 12:24:30 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF6210EC69
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:24:23 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so6281245e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792412662; x=1793017462;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nCKEluHSWIFV51AHkRVTAd1QNSpPxxkrgvIjhQ5PXZk=;
 b=lqKKCYPiFQKK74kn+onoEmogIgq8CKrCVNzfuuL/AIenFOmlHts+XmJRp6sUEvn968
 Xs3QS+ZKDM6FDFtDzTvDDdpFtJSiVgnr/4IQswAEr65f+lb1v+dPO4OtRtl4Pa5CyXe8
 WctE9ZmCnUwMrJO8yoU/UflXQtGYfv1FZSxeHSJ024gDfFBOmGpUy2hW4v8IKd1mLOOu
 WrqbObkEMFWHxohfsGigOZXcK7rN5nIh2TyPquZBYt176v+zvGffbFPDL3ZiEgjIRLD0
 onpG3H6tG5r8EL6nZZL1nrxOhL9yEzwYE6y3oCIh3MJzQqwlGHjk1nzzzly2gy2HozIe
 pvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792412662; x=1793017462;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nCKEluHSWIFV51AHkRVTAd1QNSpPxxkrgvIjhQ5PXZk=;
 b=wRwQzCg5QWSSvsWg+GQLlMUNxwq3frYLu807we0LXU6ec5srl9rRhxW7aR7gnFqGUu
 +tZpNy+7ZJ9xMYtNPO7sFb2u0GOjDWeNsKtZtRzw/7VGooUVqWI9fAO4Rb5BqrF/IHe3
 ckL0WQiP6/lSEZvrLTOOy9OxU3QmPhHGJA0dc8qE8rL7lSh6J8DALZP+1YSENFnDtjA+
 hj56N3e6eH5zKj1/oI2r8ifCkp6E+OcHLBHLsr2TXUnm2r6lMBGtlaNjhFKXHnmpR2ld
 A34q4epcCblSJepm3mceHgYBzE0EQyF+OK1tR2rVi+CcSux0VFPITOnhf/vj9v99nYaF
 h4zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2DT0q+7s2Gxl3FO68eKISQVORNbbQ68EugGTwfX5QvFzx4wIirf4Qwhaazn8Cw5/FlXl13AZURfU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKioRnh+yncAE0OMf7s/zoVP1B4nMeNGV32YGs5sNen+ufoprNj
 xbdK4MqHSkdO2U713dWlj19gmqhiD01KTLImTGZ8nD5LKdk9Wd8MmsjVREFjqt3QB1k=
X-Gm-Gg: AYBFou3GD6r6qCuO8il3bUF8LwRTtObG5n0bSpDFtjI5oPJ4JFGdQsQnR121NeE6QAV
 7SkkB8Ax1Xyhv5keWw0IZ5RZ0AFZ5tC8DLXraS9Y4fVb3Rh3843aZRWt+VtwDNonFugL/z+L39x
 w5W2vjJp2jxj3YLz1C7HJZ1fTE0uaPUgClWuUtMbbqJoNo7fOk0RQU5RPeQTLmXkYAd8zqYgCl4
 pOQfXqxFJu4MabCHfHxspyEpepHNEb2rzj0sW29U/5DIbnusqF5No8vbsXtFFLHXP+ZOyMI5p2A
 lUnHgOXD7aTU4Ph5nNlntoP9gLhgfpJYZC+hQOj8841Ti8Dw23tlXxLPIXwwNWb0SbhoefofEUA
 Eq02CuexnSWiv3xH3/WJGpHYPta9N/m/Vgo3GzcNoUFkBoJRPLJ0xZ0zEMhAqd1c1aSmYl80ALr
 1zOHh3dX65U7sjVDjZqOUHh+iPIWOlWV6JKp4hxuHRMEJDw/nP4alDPQjP5OWe6JJ3+ZoBD7+bX
 WKi55alYp5k3ZYaYmTYh7IIkp9WNVrmr8q9os8KB4I2uYUpLoOEgB6P7mc4zVI/T3KcypSUSi6j
 yavaB6RG8eEhkFdoZLjTDH2/bAbTPX3wU2XdYc0vP5bTaGGjIddJFqbKtAM=
X-Received: by 2002:a05:600c:3484:b0:4a0:34a:588c with SMTP id
 5b1f17b1804b1-4a1d7605e04mr161218185e9.14.1792412661854; 
 Mon, 19 Oct 2026 05:24:21 -0700 (PDT)
Received: from aspen.lan
 (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dc8ee409sm284385915e9.13.2026.10.19.05.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:24:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:24:18 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Luka Panio <lukapanio@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com,
 pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, deller@gmx.de, krzk@kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, junjie.cao@linux.dev, mitltlatltl@gmail.com
Subject: Re: [PATCH 0/2] backlight: Add Awinic AW99703 driver
Message-ID: <atYL8jLQmljt3ypQ@aspen.lan>
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <CACi=Ov6Jg5eUxskBbmtWOS03jta90RK0nByhWf4EQs1PNhvuKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi=Ov6Jg5eUxskBbmtWOS03jta90RK0nByhWf4EQs1PNhvuKQ@mail.gmail.com>
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

On Mon, Oct 19, 2026 at 01:26:21PM +0200, Luka Panio wrote:
> Hi Daniel, Krzysztof,
>
> Thanks for the reviews. Before reworking this for v2 I'd like to agree
> on the approach.
>
> Following Daniel's suggestion I'll add AW99703 support to the aw99706
> driver using per-chip data instead of adding a new driver. The register
> maps differ almost entirely, so most of the DT properties stay
> per-chip (dim-mode/UVLO/ramp-ctl on AW99706, OVP/OCP/inductor on
> AW99703).
>
> Following Krzysztof's review, the AW99703 binding will drop the
> ramp/transition timing and mapping properties and use the standard
> led-sources and led-max-microamp properties.
>
> That leaves the one common property, the maximum LED current,
> spelled differently in a single driver: awinic,iled-max-microamp for
> AW99706 and led-max-microamp for AW99703. To avoid that I'd like to:
>
>   - add led-max-microamp to awinic,aw99706.yaml and mark
>     awinic,iled-max-microamp as deprecated
>   - have the driver read led-max-microamp for both chips, falling back
>     to awinic,iled-max-microamp on AW99706 so existing DTs keep working
>
> Does that sound acceptable?

IIUC you plan to improve the binding for AW99706 before adding AW99703
support, and you will keep the old DT property working to that
existing DTBs continue to work?

Both sound good to me.


Daniel.
