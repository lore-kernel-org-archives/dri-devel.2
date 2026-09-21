Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFB9C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E54D10E5C7;
	Mon, 21 Sep 2026 12:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vit9d/S+";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB9D10E09A
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:50:01 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso2624087a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789977001; x=1790581801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Hygh9yjLTAw14bbP362MY2rWRpJP0PkurR+442/BpWU=;
 b=Vit9d/S+uC/B2qTNMsRIVtEgNtbIuTLva1XPG5I0eiCFBpKOoEBYchov0PTqXTEAlb
 eThv1mC8bzSVZQynRLDlU9eOJ5+h9Tsdjswec1fqQAZZyLy5du1KSeYu3yuRZAWwhmvU
 wOxrdf6MxqfDdjY28snczUC1pjcE7PJSIM2AooFitlnK/mnZsawmM2v63Uk0MyAZkj8d
 ko/B4A9AzI1cHeOcKvmJePRiiIx/5IfPmtpQ2YrhLme44mFK652Vo0sdjduGBaPWQ8i0
 4xCYsxnNM2AJEq9sXB5tgalhIVgRZlkxlY3VkB79yk+yH7LbAjFCfVxg5yCf/Rgo7pwW
 /OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789977001; x=1790581801;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hygh9yjLTAw14bbP362MY2rWRpJP0PkurR+442/BpWU=;
 b=Ta2f/K3Z1HiJImYdUh5nl84irif0aiNqeSX/NIN+Y8zRpbZH7v82t9SIXiTqbPsW4L
 nVVT1g/WcJ4cZ3EdbenHzumOVGBWqCtonmzexB9OXagVdcuot891z1ZmPKritZEibx4M
 i1qwrNzA9gK0MvkuN4XHqJu+8H7wWdYMVQ3dWESjD60wtDDPoYb+HT6pcC4kbuR0BKLp
 uykpCXXM58wdyyDWITq3zXleysBVXFemLKVHeNSulFwVrSZe+XS5E80QkuXWVQjUyIbL
 2PqcrM6cmfgITccYFghGVB+g8Y/Uv0CFxdTXdWxpPxE2JBlHJxAH53pVLbVTuAumLOgK
 tKJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+G8V2pmR7i+M4uQQcM6ZBrrYaOB5snzWlB2Mxgn8IsrBOP5YyJRfexbcQsYvGS608O1n40X66U78=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1j4oi8MVUNY73ik0ASmWDylohHcda8mKAa244JpIjPuB3qYRU
 hNqyTJASW0lSOoufzhc3bXF6bHYVd7Uuw+Q0fH+07jrAZX2sTbC+I+r+
X-Gm-Gg: AYBFou0G6WwaqBdw/vOaFs+H3nMsxGegGkyyVic8HpOUHi1M1g4aovBjxxt1Hc/MJFJ
 yQg9rqPpYhT+dYyjG6xNS561mOKUKVV4Y8zCQloEhW3QKxU1qyJSgkwoxa3YvzhON8aDm65dNMU
 UEGHA5N5YRzJBJxaZZRqqZJhZbHAzMmupwZAtdU0E53631daPy6Ysuzh5/PkhXtQ6TE76KML8Ye
 C3v35qYM+wNXpPSqo+M8bx9/fii1hv2iutoMfxUkeoaHJAe4d5pNv3Zfv4rb7tJmz3pqoUvW6nT
 oFoM30PeMlxqaFXRgr3SZ9U9YIh8Z2zYyW2DCPij5EAhcYj0rb9dkNrbzU8cyO9jCD8q5KaWHo7
 +lo4YdzdJhLsglesqat9M4bRGWUuEju83QVKKcmoQlnUwResh8qUQd4dpn4vW3ucWv8ms1WQzKH
 JNaCPwbkQ1db0jPOK4Reup62mXBSFn9lKF4S7ElDnyiae4afunu0wSBgzFitZWr7AxnHWTYq/VL
 UxboxxbeGWnDNHDFwKJUVKogegZzsxOSbgYSlQbCG0q3nAdTpj9bTVACbdWvwvfYA==
X-Received: by 2002:a17:90a:bd0:b0:3a0:22bd:6ef6 with SMTP id
 98e67ed59e1d1-3a022be0af7mr5110747a91.2.1789977001038; 
 Mon, 21 Sep 2026 00:50:01 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a041b87bfesm5623407a91.3.2026.09.21.00.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 00:50:00 -0700 (PDT)
Message-ID: <b589c197-2297-42c4-b017-3594cdd1cd56@gmail.com>
Date: Mon, 21 Sep 2026 15:49:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] drm/verisilicon: fix DC8200 primary plane disable
 clearing FB_EN
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260918030125.315978-1-a0987203069@gmail.com>
 <20260918030125.315978-8-a0987203069@gmail.com>
 <4a7b271d2a90eff94c27dec3bf24114ce44df1fd.camel@iscas.ac.cn>
 <1d988dfb-c930-4c17-ae77-47b93ff9f159@gmail.com>
 <cb30f57c0ac124aac85efad32626e6182b9f1369.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <cb30f57c0ac124aac85efad32626e6182b9f1369.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:18:56 +0000
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


Icenowy Zheng 於 2026/9/21 下午 03:30 寫道:
> Maybe it's better to just make it the 2nd patch in this patchset, just
> after the binding change.
>
> Waiting for something into drm-misc-fixes again will need another fixes
> pull and another RC back merge, which can consume weeks and miss the
> current merging window.
>
> In addition, it's possible that `drm/verisilicon: introduce per-variant
> hardware ops table` also gets backported for a more clean primary plane
> atomic_update disabling fix.
Understood. I'll fold the FB_EN fix in as patch 2, right after the
dt-bindings patch, targeting the current vs_primary_plane.c directly,
so the ops-table patch just carries the already-corrected code forward
into vs_dc8200.c. Agreed that's faster than round-tripping.

On primary_plane_disable_ex - I'll keep the "_ex" suffix. DC8200 still
has a real per-variant operation there (clearing FB_EN + commit), while
DC8000 leaves it NULL and does nothing, so the suffix still reflects
an actual per-variant difference, not just structure introduced by the
refactor.

While testing the cursor plane, I found the same class of bug there:
the disable register write was being triggered from the plane's
atomic_update() invisible-branch using the old plane state to look up
the CRTC/output, which can be stale or NULL on a plane's very first
commit if it's already invisible then. I've fixed it locally by having
atomic_update() derive the CRTC/output from the state it already holds
before checking visibility, instead of falling through to the
old-state-based disable path. Just flagging it here for now -
vs_cursor_plane.c isn't touched by any of my patches.

Thanks.
