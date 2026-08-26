Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D991C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C4910E35C;
	Wed, 26 Aug 2026 21:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QAwwMuWb";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEC210E35C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:21:43 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso13721085e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787779302; x=1788384102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mDytHj/ZZCdiW/HkZ+r/GYC8fwgFivEE8s5QuxEuKk8=;
 b=QAwwMuWbVedD2LqAgMi3qoqGXgPKjZlMfcWp06VxK3tqijAmHk97oGBfgn/648yDCa
 2wXsnRRcTwtNtp1R9E3DYo52nz+4YNX6mCzyKS+FOaLPOAw2Wy+tLXRY8iYY+HjrfDjY
 OLWWqSuwk/PBzgt6fJCchx72xD3nNHXlt4qAHLRXs45eK9/Ul1JHP5731s7Zrjm7a/hH
 HfzFMJZjnxeN367y3KnkddISDSMeVW1XDSBM6JyX/DxsYImScMdQqLMPAdmTDmqzjMGx
 Uzf2eji0XyBT3wbOQC0r18BBaelUBtGuRJV9MIJVCHQQvXjxEvjzG+bKPPSfjO+unrfW
 +tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787779302; x=1788384102;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mDytHj/ZZCdiW/HkZ+r/GYC8fwgFivEE8s5QuxEuKk8=;
 b=RTB8SsU4HBmLDzKcsd0NLOBXeIQI8qjq6rrZQ6fxQGxIQ24cX59ola5N7JeuyIcZAr
 IW7xbloiFv6WKI88mdRmKNVE5gdt8XANDvheU3iLrqiPejzIlON3YvDnM5dHCQn0SUuC
 i9fHdnRWbsWZYXNyaSzEiGlB8ORe/iJZPIOrqZ/+k2U1yBGU+qvUOr+pEr02ZvpWYJE4
 AmmOueM2tZiH/yFeGJ1tO1T1ZyR/j1RI7ZvzooH8j6HRg/TuzerUa6gZC+LO47N6ZQaB
 +lpd+KBo6rabY4Zt54iLF/52+JIFQwD7zdR4dxRZbhLjM+Rdk4kzxlvBf6Zf49M2hIOE
 sI7Q==
X-Gm-Message-State: AFuF++kVm1kNZQVKkpP9Tx0SGE1/+8Mdhom1IrqZGGsr+2rioowVufXC
 zrf3GvAlu0Av2sTludMC5x15FAzDqX9LRP63oLbCWLiPUccDD1XjHJM9
X-Gm-Gg: AR+sD13HPLwOwLhV8G440DZ5stvwQQztuw97M72ZAW86EA4blmwEIsxzbcKedqfCCHi
 4T7A51Uc43tiXIsaLHOWENbscqHgBNOZK3X5lW6bex65yO9A9fl1aOlBAWnOItY2gYnQ8Nkl/kY
 HWh6DR252zuUr67Onw2pgqniaCgtej+SvSjagRNauVy9SK6y2tH7FEsep6c7KTg8xuUYo6p4sgd
 qt/+SZRoGT5Ff5Bi//+klsfx3ecR9rpmhWlv2vn2CnMBg2mj7RtW+/KYDXxhpzMfXqO4Fi8v2yd
 bnpahoz+FWu3LbelH7VxW6bEeO9sOIbdcIAvreltF/qyePaRxQkGRwXW9eO+J2YdpGeGpmLzkps
 SiiKZVfRSWn0lmfIaX/YN1eneVLYuzd7Q3T2esMPXaD3z12rNh6FmNPqFdrI58mgLBXvQO7OXjs
 bK4RmKpsX0SzhMtNCAy4j+4NpStYmKf5/8y30T08HYbGzPTcP5y98uQKdpF07pWiLSA21D/TQOa
 bskXkLjhzQlSMDKS1nw2u9HY0ScZn3oAlloL2TmIJ5k3Q==
X-Received: by 2002:a05:600c:c87:b0:499:d22a:8973 with SMTP id
 5b1f17b1804b1-499dc6f47ccmr76147415e9.1.1787779301233; 
 Wed, 26 Aug 2026 14:21:41 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28fe2ecsm4095996f8f.37.2026.08.26.14.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 14:21:40 -0700 (PDT)
Message-ID: <e7484660-17d6-4df5-a841-e448bf8e025a@gmail.com>
Date: Wed, 26 Aug 2026 23:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/70] drm/sti: Switch to
 drm_atomic_helper_crtc_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Alain Volmat <alain.volmat@foss.st.com>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-25-fb793475c05a@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-25-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



Le 21/08/2026 à 16:39, Maxime Ripard a écrit :
> The sti crtc implementation uses the deprecated
> drm_atomic_helper_crtc_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_crtc_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Alain Volmat <alain.volmat@foss.st.com>
> Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>   drivers/gpu/drm/sti/sti_crtc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Thank you,
Best regards,
Raphaël
