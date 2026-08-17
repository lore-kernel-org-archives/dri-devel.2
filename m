Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74E5C5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC9C10E6E5;
	Mon, 17 Aug 2026 09:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wZ30m+Io";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FDF10E6E5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:40:29 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso24190585e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786959628; x=1787564428;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7VGMnmkejSh3sVd1hpCqrgINcXXfow/Hx/voysWE7aM=;
 b=wZ30m+Io4I9XBL9XbPozpxsQq5bHgJ6UgA7ucoa2EWoR2qOfq1iTbeqjKsEi7P+wbH
 qx8VTG3vrBQqA9UErfjCXTw6GyG4U0QZ18mHk7QT5A69hq1g2C8h019drvpERhMNEqEy
 mMOcK1SP5mg95i0fYUltTFsT3IEhbxzWGDcGrevQbAQMDW1jTrAlT2F2Asb44PnlDw1A
 MZIootEnTvYr1MhlYn+v54UtgsItPhXHDFfdIqYMwP71w0K7VsuzEr/N9o+tCvY3gdT1
 1kINZYkQLrusZNsKOud6XcjJRxvnflMoFWCbz9KPP9sCI9CsiQb9mkMUz5599Kz2rxvK
 aqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786959628; x=1787564428;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7VGMnmkejSh3sVd1hpCqrgINcXXfow/Hx/voysWE7aM=;
 b=N0vMej16VYuxSVwiizsU8qxio4VG5D3+pwnDJT+NCH/OHoUwbjJP4QJatREpnJ52+l
 S95S8HgKNDwcqaeM4Ge648sT0V47RQdIaMT4uPojezKx/XpR0XH/hJsvR6VVO9xWFqt4
 /23i+/d8Cmlr67ZvuMJG9XN6nqcFUH/t+A1fW8MNN5gSM0CzPuzfn2T+agYNcSpeTOs/
 +xhWxAFWeQayVcWsgBYu+HZ+dUre3UQMbUeK6qx+8UR38sr3PIyh0EXbRM67bDIYGlNU
 HTBUPV0i9vrJlOZyBCcqDJAo0zCwwFNyoB3N/NgxtM6rVivovUTzSmBDD2sBVQDS1Rgc
 4oIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFzazexJrPCmnhNumHGKXPpZ/dNf/dQnJDO9G5ocJAcNQV41iWEq+S9iQINT33bjO+WvV8JNI1eUw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPTxnn6fV95ufxsm5IxyA8aErVpQknLAljh9JA9I1+bNu+QeAf
 b9Ox8cvFeXZ8pauAbpAbSoPCSxyITM4KWf6olWBrspBaaIwlAa/FIlG6RVxOaymPAZU=
X-Gm-Gg: AR+sD13UgJa4tVM7ox/JY1DCaapOYJrr0WNYyG+4rUcVWureuwZ54ZmrfeKxiRRHlpJ
 KZLqroACSAiVsnOIrzzx/XA8C1acRxXetCMwuGgeF5xIv007eNfISs2wGO+M0DZgub7VEBjr/IG
 lUl6Cd93afzIJ5+9QA5zHsLhb7uc8zwbkzb3zWSjOumQQCkXx2LtazvdRGKwshs952EN7bYis2G
 irP3Nu5J55KlK9pd5fEnSd5k1jWF0UZ+VJrwhvbiaMIcPqAAHaFYlS7m7YQ6W40dpmjBzriPj0m
 zpJyV2cepQnvGQHshEIZXaT24wxb2UDv7pens5X+wxXrW/6bMt4ljMaj23hkCuw499hQXifwXN3
 ffBJ/HcEVBjnrYgA53NZynHCALkM+si0HiumE03Ji51FxSGdrc+OeoV8mqHqXhxuhn07RG/m2E3
 3sard9YuZ+g+QBjJIlcLis6aroQ7+xKyJTlC9+497oAy9UfbzuZ6cQX6dVHbGXx0+JG/OLZPoB6
 kMtd/NIhbCNmpRJLTKPkbfIkZVCjc5JNMHA8GuW27VAg0mNWlv1AmVV/r80RCnblBbonX9Mcrzn
 K8v/udbtb2s8pA2KTuGbXzo0D2NVhCSN9UrfvUlgjcKv4Q==
X-Received: by 2002:a7b:cb1a:0:b0:498:519:e660 with SMTP id
 5b1f17b1804b1-49987935847mr230720425e9.4.1786959628339; 
 Mon, 17 Aug 2026 02:40:28 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb867sm36476785e9.10.2026.08.17.02.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 02:40:27 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:40:25 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <aoLXCY-q_o9IPDN3@aspen.lan>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
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

On Sun, Aug 16, 2026 at 12:57:03PM +0200, Wim de With wrote:
> Add device tree bindings for the Orient Chip OCP8178 LED backlight
> driver.
>
> Signed-off-by: Wim de With <wf@dewith.io>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
