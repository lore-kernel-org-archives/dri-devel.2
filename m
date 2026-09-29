Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D929ECA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 01:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B9610EC41;
	Tue, 29 Sep 2026 01:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eTpZBSYr";
	dkim-atps=neutral
Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com
 [74.125.227.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA8E510EC41
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 01:45:11 +0000 (UTC)
Received: by mail-pj2-f41.google.com with SMTP id
 d9443c01a7336-2df964b6893so17116875ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790646311; x=1791251111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BbPZBkG6EW7o76TGvb+IbEd7phIKmf02Hwna+vyhxaI=;
 b=eTpZBSYrZ8WVn0pe2g8Yfyk3PteAJXCN8AoebOF29fTPUVCnNHM58qztC5M6KIBKBZ
 5yEBT3u7oFxXyDtELlgdfz0rtGom0DcmKxMWAZbEMdSvCnoV6pezdn/uUe98wKqBCggC
 9Zu6cvPhnLYQQKbhkvdUR3aaqnzf7Yjgl2RiSQJNrO1XuAmldNo4VhzCa4zOBaJVXU/A
 C3A3ASPmlhM4T+xGRW+COR0nBjMsRkOmlCqLAK1E2DUF3a8mbCNXQNuLfSyw+Ek6gp4L
 NX/4FmgGB/rBrZX+sWAG2YzzR/dc5IS25j88SD9QisTpAR1RjKIQzdkQsiBn8b4+5u7B
 u1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790646311; x=1791251111;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BbPZBkG6EW7o76TGvb+IbEd7phIKmf02Hwna+vyhxaI=;
 b=uyjIi4m3fc2AhijHTW5er0hC4m5iQBgfBD+yucesY/GqedwC433HWBXNG82xbHwBON
 aUBPGlLRhJFYbjQbYrGhi6RD9I3jyxf2YcVFGxcatlNmB9CanWFMbkt32SFCHf7XFm2F
 T3Q07g6V5jcSVaV8lWFlMSLKTea9jr/29hQYq+hAbmIdvbyGhIvbh85VFUJ6Oqw0ya4c
 qazmuzJgS2bcLVTumKQ2hfecnE61t73FFlFafXbYReKBygNLbva3tgHT8NjBB38WsB93
 3xjkL/D4APvxzUTjy2P8B6iMwL8CTL/bwU76wdYCiK9jIOMFKFkzCkJKCeuJ3jquN8rY
 ugLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPa0Llx+ooezdXroAT0W1tTi6Up6SPGS4aTkuhlqvayebt3O1ebEoGFd5j8g18uKhyauh/1gsCYhA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKAuLVNqhdkuy/fYV/ATftI+614QFVtkYvQRhAE4M7BonDy8l54
 N9Z1Bdz29+ngZqlQB+tDOwWotfZ1OzUrY3qxVFlJLDKERCmXM1xcV0WD
X-Gm-Gg: AYBFou2ExUF9WUTEn/1bmp1SVB7Z/9OjSwKlvFd6WpoFg2zwO+ZJNMPS+8pZ8uhssaU
 11vcJV6ys+wTh8DSK53s73Fxg+Xn9LIan8Bz2sMStGVQaP0JxZkF53a2a1bO0d7JHY02Z19kooB
 xpHJCXxtcVrEo94gMciwRBe17Qz6i/yKADmajnmDxLjicrmqO5BWY819tny0Xhc1N0wB+Xa9wVs
 iO+h+x8fXZV7Hloq/Ee9G/fyLJ70XH4b8rgCxQ14UhsakKx3SsS19uuGIEd4DPX92hZgUggJ56u
 mzgGX7BxfevhCQ9/L+2pVieZ1Vjng4K/elhNTSRIOSoFLQ7QYAbadbJEurzX9nyHuA6J/GHEADa
 Z4jQG39+j3GgcQvL2pOfSwKzLZezqJfNSY5XGqhb9MaRwpI2aGHqErwSpVKMinHcwHdiGWc30zD
 zAlDUBI2gdllTfmWdQ1dzQR15mFqW5eutImRYE78kn5qf8t/4+xtxnZ2unjeQOiIYN4SVjiozcU
 1A3UcA7IgMQ65FhE8WOD4QZkcuhnSAKT5SAnjcod9WXnpR/ulyPGQw=
X-Received: by 2002:a17:902:ebc7:b0:2df:9625:3ecd with SMTP id
 d9443c01a7336-2df9625400fmr82748415ad.8.1790646311363; 
 Mon, 28 Sep 2026 18:45:11 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df913dd8d2sm48984825ad.20.2026.09.28.18.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 18:45:10 -0700 (PDT)
Message-ID: <ed35ac8d-ebcb-4f7f-aafd-c1b1eb3616b7@gmail.com>
Date: Tue, 29 Sep 2026 09:45:06 +0800
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
 <b589c197-2297-42c4-b017-3594cdd1cd56@gmail.com>
 <fde43d758a66a8feefc50274f3573e33a67d43f2.camel@iscas.ac.cn>
 <fc425e648644d94276bce7d3d4dac8b0acd4c5d8.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <fc425e648644d94276bce7d3d4dac8b0acd4c5d8.camel@iscas.ac.cn>
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


Icenowy Zheng 於 2026/9/26 下午 12:48 寫道:
> 在 2026-09-25五的 22:55 +0800，Icenowy Zheng写道：
>> 在 2026-09-21一的 15:49 +0800，Joey Lu写道：
>>> Icenowy Zheng 於 2026/9/21 下午 03:30 寫道:
>>>> Maybe it's better to just make it the 2nd patch in this patchset,
>>>> just
>>>> after the binding change.
>>>>
>>>> Waiting for something into drm-misc-fixes again will need another
>>>> fixes
>>>> pull and another RC back merge, which can consume weeks and miss
>>>> the
>>>> current merging window.
>>>>
>>>> In addition, it's possible that `drm/verisilicon: introduce per-
>>>> variant
>>>> hardware ops table` also gets backported for a more clean primary
>>>> plane
>>>> atomic_update disabling fix.
>>> Understood. I'll fold the FB_EN fix in as patch 2, right after the
>> Should I just apply this revision of patch with this reorder?
> Oh I think more fixes are coming.
>
> There's one more DC8200-specific problem (which might be problematic on
> DC8000 but I am not sure): The vs_dc8200_panel_disable_ex sequence must
> be executed before vs_dc8200_panel_enable_ex, because some timing
> parameters seem to be latched when the value going from 0 to 1, and
> when a stale state is programmed before the driver is loaded (e.g. a
> firmware driving the display) and the timing isn't the same with the
> timing of the first modeset, the modeset will fail.
>
> I'm thinking about sending a fix patchset first, which will pick the
> FB_EN fix here, implement a fix for the stale state problem and maybe
> implement fixes for the old state dereference problems for hidden
> planes in their atomic_update callback (although this fix will
> introduce a helper, which will then be moved and renamed in the DC8200
> ops patch).
>
> Thanks,
> Icenowy
Understood, happy to hold the DCUltraLite series until your fix
patchset lands, and rebase the ops-table patch on top of it then.

On DC8000: its panel enable/disable path just toggles a plain
FB_CONFIG_RESET bit, not the staged PANEL_CONFIG/PANEL_START latch
registers DC8200 uses, so it doesn't look like it shares this specific
ordering hazard from the register layout alone. I'll run the tests again 
after
applying our variant on top of it.
>> Thanks,
>> Icenowy
>>
>>> dt-bindings patch, targeting the current vs_primary_plane.c
>>> directly,
>>> so the ops-table patch just carries the already-corrected code
>>> forward
>>> into vs_dc8200.c. Agreed that's faster than round-tripping.
>>>
>>> On primary_plane_disable_ex - I'll keep the "_ex" suffix. DC8200
>>> still
>>> has a real per-variant operation there (clearing FB_EN + commit),
>>> while
>>> DC8000 leaves it NULL and does nothing, so the suffix still
>>> reflects
>>> an actual per-variant difference, not just structure introduced by
>>> the
>>> refactor.
>>>
>>> While testing the cursor plane, I found the same class of bug
>>> there:
>>> the disable register write was being triggered from the plane's
>>> atomic_update() invisible-branch using the old plane state to look
>>> up
>>> the CRTC/output, which can be stale or NULL on a plane's very first
>>> commit if it's already invisible then. I've fixed it locally by
>>> having
>>> atomic_update() derive the CRTC/output from the state it already
>>> holds
>>> before checking visibility, instead of falling through to the
>>> old-state-based disable path. Just flagging it here for now -
>>> vs_cursor_plane.c isn't touched by any of my patches.
>>>
>>> Thanks.
