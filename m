Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC0BCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0436C10E0FC;
	Thu,  1 Oct 2026 19:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I/atsHNg";
	dkim-atps=neutral
Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com
 [74.125.230.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6FB10E0FC
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:30:11 +0000 (UTC)
Received: by mail-qv2-f41.google.com with SMTP id
 6a1803df08f44-917912f0b95so27355116d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790883010; cv=none;
 d=google.com; s=arc-20260327;
 b=Hz3BZGQdQH9a9ObYQY2UE6qRsStqeae/CLehKLnVju9gb3afH8krmZCFFh9Q7KfNJZ
 Hr1j3lLmO0QIT9qHH8pvmpN3pwIuxi7E6v0YUmQP0LmSF+zKM39GhNDkkeiA9HkiUx+K
 +IakUzSnJWSCfiuPhpJ9jt45Do+hLRjlCStiO4PLV/kegtnZGMuc15sDRQZBJDbLSZYp
 tX8ROlRX3yXCdRsHOiy1suZ89hiHcYjVOTKi3PbC32Kd5GRzeYynUpqVgipcpTXhgm3G
 3nqEg+KwE41g0BSAAg1pUNQUTREbyFKGIDCdXcCYXPIhylFVK1mgtlzW7rhAiCfcNN2t
 2elQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bE/ZpayYaMuQJ2cjUw/XMionGOYmv8DuAlly9njYYE8=;
 fh=gvAz0qZPBNIIQ+ye0S25nw6lxAl+hHLV9jzNQ94Dx84=;
 b=Kx/TOKPSge62+cVyPZZRQM+8FpjhAaESQhH/6tqCfN8ILs4qXrr/iOqaV7xHB5pVNY
 AtLX41u0g0sPqzoPxjece+b6SDIWp0N81LWXJ5hV5jRuBwjjdQALyF0fGbofcCt73v/v
 W93qCsVTXPQk6gsuTiS6UxE6ldETeq3+Y6ekbPDFFSzUA+KZ9QQc1yo3mfa0E7Pl2ovK
 jHN96czzR30d8DdaT2Z9ubIBzjbPSBfMhve0pKjbyVZHBH+WU44C+TFA4OwaXeuE3Xb+
 ooGy3K4kQZujR02zXNAdqi4gxyMesyDUpVtWbruT01wFTxlik2ub3X+8fxeczmEzs6HE
 IF5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790883010; x=1791487810; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bE/ZpayYaMuQJ2cjUw/XMionGOYmv8DuAlly9njYYE8=;
 b=I/atsHNg+8htBTg+w5pzrDB4AzXTGsXqw0YYMs+N9hzdUXwCXTKyBE/wU3Wml9Gwp5
 Idm7Jm+T5ZaYkjRkUHF59Avb5bj8gvj4m7GcE1uaZjJCN67u0KAQVWc1IPGPrFrkcO8R
 J8gM2MntBM/BFVXkK9zpHmvjXliRL0dj5TWmMY22/H4mnbZJp/Dv/uW3DGBQlYvIJQ0O
 jzS6e8lUemCD3vYDRUVg21SugqWhiP93x2NDvNoyyTnj5D93pJeHMW0oOqThn44f1rNJ
 VHuqBi8j+yxqiLbtx3ArUlYdDpDPtdZerOukcv8I4ogNmpJ63Y2uWNOdLUf/JwTGL8qW
 +spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790883010; x=1791487810;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bE/ZpayYaMuQJ2cjUw/XMionGOYmv8DuAlly9njYYE8=;
 b=qVLyk8qZUwWmqDIvmFMjNLHLIyyIloF7hwXNqzJiAXD5W4AoBshi5DIzlgM0/nHatC
 UcHydZ78bKqZZUKaX/6how1V8N1JJje5443hm/aGBbP7xXMsFIHWXIYt2LshJ8BEmmL7
 vuRnxWL+MePy8m/yazqBrJD9V8m9rFcfMUPflaSujs+XHD5Yzm5ZEhxx1pbeMGtlNauI
 x7P10YS3XcbsR6RHs159LtpKK3sFCDE2fPI7WV4mtHxnqQo80MprHLs10D/K9RSi6TF8
 oxuY0GPpXNlYACx5vrKbBUK1/tgLW5vyjgg2upWS4NBa2jUZuSHjp5T9dGoPj9BQzpef
 qXgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF9GZ/HlLoZ8r+9AJaDaJg5OR+DKSB5Hiq5yFil2B0mpvDQfJFsiyjXI9pqtdTSF9kmw2PxQn4MTg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJHqiW0Uhp1N5mVIY+XwRhLdtcaXNqkS8wrtcN2zOoMoZPqOw0j
 as0JBOKmmx7LAeNjFde94Rsl1AHd05vRJATX2AHUtLbDs5dWEGY2mLNZkMZsus6kaykwR3D0RXc
 jixtBkFainyZmh2Sq7c0XGu1mk1zOC8U=
X-Gm-Gg: AYBFou2v89Tfgm2DAuTTuVb6Yym8dEpxg9cs9PE657zXDEztkLoiTF9EPW0xHL+TdDq
 IM8xal70H9e/sfuNEeVB3C9/DGF1zzDcEc5XxEy0y/FjXnPOnp54WGzsBkVpkfYYCpC1UlbOwhQ
 eEyVb1whpNAw17fC3zVAXdmtc2pU+Y7dVG/h+fjkGo9hHezbEgBOMejBgM4mtMYpXCIiEdp2HoX
 D8WpOrSudvylABzotPqy7jo4PNXlubW6X9yoXTJ/r0AXTd/ctP2MMCI7E1hFXfklOOMRNMxrBff
 MrwABggZUC7SQ/tGdNF+kb87M50IUAAreCGatHxOiLBhy2izEaJ48+Va
X-Received: by 2002:a05:6214:1301:b0:914:5471:e569 with SMTP id
 6a1803df08f44-917c011aa47mr9730326d6.18.1790883009819; Thu, 01 Oct 2026
 12:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-5-mario.limonciello@amd.com>
 <25c3dd77-bedc-4822-b687-0ea429db0dc7@amd.com>
In-Reply-To: <25c3dd77-bedc-4822-b687-0ea429db0dc7@amd.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Thu, 1 Oct 2026 15:29:57 -0400
X-Gm-Features: AclHuK-bx6IInYg2xVtTEtZOke_ojMQyvMv_9lNx9GZqWxpIrzw65JUNJ9QqnL8
Message-ID: <CAFZQkGxz6Sn7AU2_ATt_kpwTf9g0Orc6tTOOsmOzkHJo94E+-Q@mail.gmail.com>
Subject: Re: [PATCH v8 04/14] drm: add connector backlight (LUMINANCE)
 infrastructure
To: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, 
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>, 
 David Herrmann <dh.herrmann@gmail.com>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Am Do., 1. Okt. 2026 um 15:12 Uhr schrieb Harry Wentland
<harry.wentland@amd.com>:
> Why not simply call it BACKLIGHT, which is what it is? Later, if we then
> add support for luminance (in absolute nits) we can use the LUMINANCE
> term for that. Otherwise it'll be lost to us and be apt to confuse
> people.
BACKLIGHT suggests there's a backlight, which isn't the case with OLED
panels for example.
I'd say luminance is the most technically correct term for this, even
if it doesn't come attached with a unit for now.

- Xaver
