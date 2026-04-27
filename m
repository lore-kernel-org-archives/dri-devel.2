Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2181FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FB710E00B;
	Mon, 27 Apr 2026 22:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iAOXwrZ+";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A447510E00B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:42:08 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8eab809593cso927200785a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777329727; x=1777934527; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eiuuIIQgB/ng72B2X5qMWHFySgXXLT4/yH9F0w6bPag=;
 b=iAOXwrZ+3UDl6zguk01TvM8UDeYVr+4CUiCW7zXzrU+7tMEymCUn8a/rsXHCvL/G4C
 04CB8sSdPmRDlSuuMGZSiNm5IT/FhKJJ5QpjNlCT177jJBvzJdmh+5Y7rAMXQmrLeTaJ
 DLFxW/b+2xfkn2WXgeSHjh7WipQ1zEbtmzPKUdOxsn3SItXqbSaz3SsrLy7APlKWh0Hq
 myjrdXeUoqPF6JLx1qOP6cJ9oqvIXn7uAyqjUQR2H14aJzwUYieErIC+9FVRIS/3Uz+Z
 fGnEljmMlW/tAlfmPPRVpiWMHD+GaxrhwI9V5u4RSNZYhfoVVvAyuoZVBdvnMBWJvrjH
 J8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777329727; x=1777934527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiuuIIQgB/ng72B2X5qMWHFySgXXLT4/yH9F0w6bPag=;
 b=ogE3UWVzlNhn58ns6G02nblFStfErWr8HxaMVqX6M7jxkuHFuEwONGeQGNpeva7aTb
 /apu2CLLUmdcJg43k12BjnJAw6qMvifctEvfqQzqPOvUTRa2zHv900PcuhP+qbSTe5/V
 WXioq5tO+QOp2IqZC5F5iX0p7J9dzaSGSQ5xGXn17pwDCZh3v+CsDoA2EamuhP+Hw5pB
 2OIv9vU5HdhoeYfYMLIUSYqUaSoCrsfKTrUYVK1WKXS8GcNUc/4qqdjSvUtJ3AS6C0fY
 yC+HUiX3HyprjOgAOBj+f2sBD6KGpuzdgRK0/gUUzlys26fgoAzJ8RUpDTuDWXps76YY
 mcfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+07t96cO7YLY02nGObiG+/1Yv4H3lISyvT2BiCoeGaKwckcex51s6x+VARGyD4hj6C/f08RIRAjkk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSqa1dHFQMbxt6v/QHQy0iA33aR+MoXqwiiq+rm70SKZnIGh2G
 u57eBeKh3lC5sdwRJwR0xyudv+Ns1FGtdLbVAWrbA2jru/SuOt/HK+Er
X-Gm-Gg: AeBDiesyffrlvHdQGGkb1dSTfJz74JATFm1438Zst+x++t1KlWvr9BbH4TueSPDMEv9
 E/Rg2jZsDOwXFe4G1hBwEnHpr8pkh63HJvCIEZ3T2LkY7HC1dF2cLDYhGcv1RSOm6LnA5TeMc3+
 LwM3anFNgtLDZpLtaemYfa2m5Vlvc/GYlA+WcxdAgjnqu7aPJdr10+gl9TxJYCxOsjA9/rR+SR/
 NiHsBq4FqqIHf4ate/zPj7xVqrTrKtTFiiyd89Dj0z5BwUjGAG10gq8raIXCsJo1RtNRl0/ZQv1
 344MthhW5dmwM3e8q8KeC1IYj+9A3BsjX1Av2SrValGNawU3zyiUuRhkGACngCuViw5b5geC6sA
 dr4Kzxk8syPstPEJCBe1BabUeuOeyjfBB0+vk6Kp/f7PsXMnQ2VV/PaiDr5A78iVom4H1pOQmPv
 tw3HugI/Udpe6FIEpZFySr8BHf+TdJS6eb1ieo
X-Received: by 2002:a05:620a:4504:b0:8cf:c0c9:bca with SMTP id
 af79cd13be357-8f7d78342e7mr91392185a.17.1777329727373; 
 Mon, 27 Apr 2026 15:42:07 -0700 (PDT)
Received: from localhost ([184.144.58.243]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c50b7537sm48163785a.18.2026.04.27.15.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 15:42:06 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:42:48 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Yifei Zhan <yifei@zhan.science>
Subject: Re: [PATCH v3 0/5] Support for the Pixel 3a XL with the Tianma panel
Message-ID: <ae_maHh5IMxQWxbM@rdacayan>
References: <20260310002606.16413-1-mailingradian@gmail.com>
 <ae-yXomgNWLd8IcE@baldur>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae-yXomgNWLd8IcE@baldur>
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

On Mon, Apr 27, 2026 at 02:02:39PM -0500, Bjorn Andersson wrote:
> On Mon, Mar 09, 2026 at 08:26:01PM -0400, Richard Acayan wrote:
> > This expands Pixel 3a support to the Pixel 3a XL, starting with one of
> > the panel variants. The Pixel 3a XL has two variants with panels from
> > Samsung or from Tianma/Novatek.
> > 
> > This series depends on the IMX355 front camera devicetree patches
> > (https://lore.kernel.org/r/20260217002738.133534-1-mailingradian@gmail.com).
> 
> Please resubmit the DeviceTree patches once this dependency has been
> resolved.

Actually, did anyone see v12 of the front camera patches? I'll just
rebase this on the revision of the camera patches that get applied.

https://lore.kernel.org/r/20260331194437.41041-1-mailingradian@gmail.com
