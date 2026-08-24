Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC75DC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13DC410E615;
	Mon, 24 Aug 2026 15:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Z9UIOaot";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B285010E615
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787584572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lwN1IBw6ISFUhBtlLGpwjjwq2qTPw+f0zNub19DhCGI=;
 b=Z9UIOaotm8FdaoJoTtQW1rxd/NcJjQxUH5F+mpNcMkzAMOfuKt9xOhQt5cpEg2aq6HI0X0
 t3wlWWSf2f1/cni7T8IjnvGKJdZn6pUoExnc+7DZtcdsMZJjk2xQSySbNKzyofk7vQYPyR
 gCxbBG7mFla8Q1SYe5dt5Rrjldi4vwg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-el4YWEBGOWaW6njSJeO0GQ-1; Mon, 24 Aug 2026 11:16:10 -0400
X-MC-Unique: el4YWEBGOWaW6njSJeO0GQ-1
X-Mimecast-MFC-AGG-ID: el4YWEBGOWaW6njSJeO0GQ_1787584570
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d33c89a29so49015451cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584570; x=1788189370;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lwN1IBw6ISFUhBtlLGpwjjwq2qTPw+f0zNub19DhCGI=;
 b=PRIILJ9S330Nm2k4qj26l8w3yB0fodiE25b9ItNtjwgN5Mdr+zadRaFeN0BbQ9fThN
 7vBKS7tOf1eNpXMl4PkCBrRtNekU5IJMjTukK/r5WuK9HpSUFHVjJDmw9pVHdAzGxSPO
 jN7FKinSSgMc8rZGSHDrWGACxn86VttwaG23aVP0Q/k0IT5O4yCPYRJuSG4Ex1Rd6Oj3
 sRJevAbcrreKvYMDTkwIkN5t7CuuI6FHhAy6fjUKFWe+YjuJcoouWTbdr3hrtQuROVns
 T5J2jn1z5WXFXGXwuxF14npDVgrHlIIoyPx54YgJr3uTLn3r/Utw5aAZmtAG2koZ1CYX
 LSSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNCBekpNVHS4/nsdVBxbTBHhLozabX4CTO29dcWUrXij4LokxJ9g77gSUMe02LqRmpo+tgqzSryNA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nap/moL8bI95KRlKqLmP+/VyZnktrS/04fFkJiFaQbXUuMbQbc
 J3as28m8WhI9zPNDUQRhg0sCWiu8oj+tberq5xORka9vPXY5ml4ozhPfSAN+pImEX2H1HkYguk+
 l2+BhAd58XQDpcpZ6mh2z/l5RPWMsfWOlOhpiAUg95nzlNFcM9Ev4Je9wI+LhlFInatq+3Q==
X-Gm-Gg: AR+sD10uYS0s4M6SVdvaRq5tze0a7pD0NaxB2IX1EaylYI3N0i/AIrkW2+zlAUaqQxR
 8Lsl6WA9hj5HWyg+dC4ASeKvxlLoL4eODwtzf0jFUR/HJ7rdXFdkNyh6H5MfBuW6DK3y121DA2o
 PglFK9UJqsPTmMzgC2wTVckxOsR3PzLL5GQG6zrjT255+2y9H1x7ql4H4AkGTW4IZc8Xy7mybcx
 /sy2aXfUBN33DGL+mXRKZaAQyO7WUTonHERFIEqfPTFcgmSBBs9H57/FQEI3pbxm6jo8t1ELFgd
 rbMO/C3jQoLBfoIe+XSo90F19IWD05HSAHCUPZD5jZSpd0PkqUJHg6ESxgWxwjftnWNcxHMZQOu
 LvX3N5Z17NULmUHBS4FAi/z4SG/oGd5yN0I4=
X-Received: by 2002:a05:622a:1249:b0:528:a8c:aa00 with SMTP id
 d75a77b69052e-52df56e1163mr279730261cf.8.1787584569870; 
 Mon, 24 Aug 2026 08:16:09 -0700 (PDT)
X-Received: by 2002:a05:622a:1249:b0:528:a8c:aa00 with SMTP id
 d75a77b69052e-52df56e1163mr279728951cf.8.1787584569268; 
 Mon, 24 Aug 2026 08:16:09 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net.
 [73.183.53.213]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c93a4c1a1sm63772856d6.34.2026.08.24.08.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:16:05 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:16:03 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/tegra: Make sure clk_init_data is fully
 initialized
Message-ID: <aoxgM9vY01nLeX_f@redhat.com>
References: <cover.1787239944.git.geert+renesas@glider.be>
 <9bc5029f7ad84b0b1e02be231a5abd7e5fa03946.1787239944.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <9bc5029f7ad84b0b1e02be231a5abd7e5fa03946.1787239944.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7LstVPxkulbx_oFL_URgEMEb-jSh6HsNVbyhb2pyD6I_1787584570
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Fri, Aug 21, 2026 at 12:03:03PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

