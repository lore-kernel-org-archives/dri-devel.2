Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9955C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310C310F421;
	Thu,  3 Sep 2026 07:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lWPFfqjv";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9329110F2C0
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 16:23:48 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49557167508so12325225e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788366227; x=1788971027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1N19Tlo/HZAKhPdr7ampF9wlM1CbFMGUBMOsaJtVD7A=;
 b=lWPFfqjvg+KTiH7DmTTet/7tXGwVcv2E9GD1FA+sMnafbvgg1I8P6wFaBecbFbkYdo
 fMTwznFg4npNPkQjRj9U7j8fzjwDegd72I4w5lgLZSZpr2ROiLShfr8mVWeVPoUsCFHM
 5pk1zhD4D1F70Nk4QlrufFcsS+Vzsom8tRhqjcE1XvIPdMiEGdDenRMMc246GJeqvbxW
 FNAlBTf2LZFvG8DjWDgqaftTQO7ThfKg7ohjkwEpWMnDmcvs/T1g0obcDhuSoii6ZT15
 7EnwwYKCv6HuM9HdRd3Sk3YuMJkDdWJjyOGXx7wUXIi3FzsB1pAZz1eYJpbHyjMEKh/R
 XF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788366227; x=1788971027;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1N19Tlo/HZAKhPdr7ampF9wlM1CbFMGUBMOsaJtVD7A=;
 b=BfTMTOu+FKUm/JkcSqsJIoXop0bzXejbL7lOosQpeg8oN6+iziuJWeFUN7bfxNpHRG
 55ub4GZ+TFZU9QV3vj4pC89yBAF4OeqjodRrGuVa8RMuvbHUrdbopxu7uNEOqwdWPzz7
 cU5VJIkHmFkeY7r8x76JZ6RgXTj0FWZM0Pp1sfCWq2rcYgELWOQVqb54WB2geRs9RwF8
 19GuTAdsHI13pjc5cNF3fj2GUPLHlNsaT/OvDy6d4ZQnKFkroCwX7RDc6uX03URd+Reb
 NCvn1m5cGlR9pQ0ib94kfL1Ve99b5tc76Hfbkex3bY79F5jI4ODeahH93C9b4QHq+tPD
 Ex3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZFnI8LemNqJuFC5ZziCRp1YIKI4IF/85sFHjn+TttajnNPcGJBZ3SDGw9fHcN85mdPxRT9LQgONw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lK/ZzAkUQf3dRAXSy/yF7azKty5S6HtZe7gbgmwItZqTlaxBQ3
 L+nF+FF/9hsirYB1GuaQwII22TY3gZBD8COyTWKOlqseVRHlxVlt0i7H
X-Gm-Gg: AR+sD12Oalr8K+J2O7WJg6gYwSZ2gFFXr91mJP3XTBfTmN+QwrsLq3uAi1XMMWa1IgO
 fHrtMo1qAvUxuvJka+DdC8VWKnl1uY5emAbKZZRNVBRRJS58tFN5B0l9uMeLTIFt0K0kG4ncjKK
 dM+Hsbc+zCVr6ReLyezO9L16e9Y44kgpvB9ulmoyyk0uFuicYJzAC/31gbPMNQuNpE/GHglOJYV
 6YiaUd59HGYARhW+juMplDJAhZinw+pqxqBZHMhcOMYlXPoakdyEmrUDXnbm9q9RC19D2reaYyo
 CbtTH9LltMhIlFFuYgyFBMoINLx8EjehhIhRkr7JczQEBejW/gOxS5csVPX3iTuvTs2HbEgtM1B
 rdEx2MZryGBtoh7wuGAkKSP3jgsKFuanxh9J35BE42iTfq8dUj5xWcja1kI6g6PHJ/BrY0oJo4W
 llGfS8SGY8JF6DG75ObS5Ar7qCB6EXqXgJRt46h9ebuuZWYRGSl4gQuFWzCMwSf2h9I00+ajoc2
 msKDiVQjiGofBOPa17LvhLFJJNijjKoJEjpTOHpoe3cTHPm97bq8ANfT32nZ3mSryYnTOqR9KfE
 8x4TxlHos+EbrsLhEofZsT8SVWHmbQHSNf5wvRTep6ZSF0fjUpNF6wDpFA==
X-Received: by 2002:a05:600c:8b05:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49ce5817bfemr136244235e9.6.1788366226723; 
 Wed, 02 Sep 2026 09:23:46 -0700 (PDT)
Received: from [192.168.168.11] (a109-50-200-65.cpe.netcabo.pt.
 [109.50.200.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm2104795e9.15.2026.09.02.09.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:23:46 -0700 (PDT)
Message-ID: <1aeed63d-c7ee-426b-977f-af00a309987a@gmail.com>
Date: Wed, 2 Sep 2026 17:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] drm/amd/display: passive VRR
To: Fangzhi Zuo <jerry.zuo@amd.com>, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260901191251.2653684-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Adolfo <adolfotregosa@gmail.com>
In-Reply-To: <20260901191251.2653684-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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


I tested these patches in conjunction with the HDMI 2.1 VRR ones on 
kernel 7.3-rc1, and VRR still does not engage while on the desktop, only 
in-game.


On 01/09/2026 20:12, Fangzhi Zuo wrote:

> Passive VRR keeps a sink in its variable-refresh state during fixed-refresh
> (desktop) use, avoiding the blanking/brightness flicker that HDMI sinks
> without seamless VRR transitions show on VRR entry/exit. It is opt-out
> (enabled by default where the connector advertises passive_vrr_capable) and
> is not useful for DP/eDP, where seamless VRR transitions are mandated by the
> standard.
>
> Patch 1 adds the DRM core plumbing: the PASSIVE_VRR_DISABLED atomic CRTC
> property and the immutable passive_vrr_capable connector property, with the
> attach/set helpers.
>
> Patch 2 wires these into amdgpu via the existing DC
> stream->freesync_on_desktop path.
>
> Patch 3 fixes the MCCS FreeSync fallback so that HDMI-Forum VRR (HF-VSDB)
> sinks keep freesync_capable; without it passive VRR never engages on the
> very TMDS HF-VSDB sinks it targets.
>
>
> Fangzhi Zuo (1):
>    drm/amd/display: Keep FreeSync for HF-VSDB VRR sinks in MCCS fallback
>
> Tomasz Pakuła (2):
>    drm: Add passive_vrr properties for passive/desktop VRR
>    drm/amd/display: Use passive_vrr properties in amdgpu
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   | 13 +++-
>   .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  7 ++
>   drivers/gpu/drm/drm_atomic_uapi.c             |  4 +
>   drivers/gpu/drm/drm_connector.c               | 73 +++++++++++++++++++
>   drivers/gpu/drm/drm_crtc.c                    |  2 +
>   drivers/gpu/drm/drm_mode_config.c             |  6 ++
>   include/drm/drm_connector.h                   | 15 ++++
>   include/drm/drm_crtc.h                        |  9 +++
>   include/drm/drm_mode_config.h                 |  6 ++
>   10 files changed, 134 insertions(+), 2 deletions(-)
>
>
> base-commit: 8c77d618886a143de5cd87a35963b4993075802a
