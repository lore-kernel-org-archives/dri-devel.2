Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BC7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD8C10E0C9;
	Thu,  2 Jul 2026 14:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UqkfyZOT";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C49C10E4F9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:39:25 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso953682f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783003163; x=1783607963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/i+wfnz4csbIqOFspyRymSD9kSCFdpRJiOKiIAQ2eo=;
 b=UqkfyZOTbCikOxf5eLiGLkeXNuGOsf0MJSJAdYK//cbKSjg35+hwen2SGIxjFp0V03
 tEzgsK1Zdiz2TE0yMIfagvY+iznGLMn97Nl3bDYSLmfzAssSrqVTkN6aQ0CxqdKPul9m
 H63F5oiAuuk2fPAqXk6LdKGkFSla/8rQOOc8l1zJMx3CVCQ/Qmg1gnSwpVVRCcP/bOeK
 IUAs2IqgWsJlUoLeuzj5kyFRU0ivU44WeG5D4PBn8+jVDt8kpZH+AiJWvvTtQfidgY6Y
 Qc9GfWIxaRy2yNxp2NBq24GexNtZ7FHE1ViHvZwlB+0yVy1bBBEBswy9GFjzosEpGJ0c
 k31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783003163; x=1783607963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A/i+wfnz4csbIqOFspyRymSD9kSCFdpRJiOKiIAQ2eo=;
 b=h00GKwPlNkyd/7ZEpzYeJq4WesTf5IizYt+Ov4wyTglonv+v6a7QwkZaDsaPfzvFVc
 bVmpKOns3Xa/SF8fI5jCSyduVC0ssb9P/P7s5UwW1F9rGmxfA1Gt8zrXwdvn8lmOZXi4
 iVp7xEh+nWuARP73ESVaqVVuDaVkfS23HnOlLN0iXl4WsbNnboTDliAsArWjeePgK+fY
 zR03k8rtxGgfJ0lmXG3rhIeF2U+hT1hwRXxzXVhupl2Eo8NOSwTpqaUgKgihC49DLRxU
 dX/O0fDEtCHEI+2Zoh8intTX3jMaUphZ4ZclgAVdQui4Jhu03EF3Ter+Mlln9MMHACCK
 Irqg==
X-Gm-Message-State: AOJu0YxC3+X1bNpM8tounFO5H8079L8R8n3n4aRQ45EuWEWDCErc9BQM
 II46g0bhvV3MtPj5tp/JWRXEScxgGe4vuhWdnQK/j5IrnagnfnPL4lw9
X-Gm-Gg: AfdE7clRJaDmPwl57d1hWFQdSlq8G/kqNus3gaKSb0+T6fVsoSaZrzLo02Tayp6dGOl
 dOp/LYaD9Gc95GCpqB1V1Ob4MThmJkpXBdrExp3qd5O7XE6dwOXnndvY0HqG026+H5Bnqk0sOfM
 U+c9YdvT/G3VXfmNAg906OycedKT526GATcc/Si3M8poeq0qxsfr3f2alxUf2ukQP+JBlXICO+d
 D9NZDzKGzxSFlvTj6Bmy+kuNajQaZWKJS0W7tAe25GQZZfYEvg3nU8lsrQbHVsa5yLXYCn+ZDcz
 PqNq3qg+4EcQZelvbNDhOJClb9CO4fCdZsJ28dlQf5Iig1w65qbpy86qHyfx0EyyPtx0PU8I3wY
 flH4m4GDgxBXSEobbyMWmH8puu4yOz0NeAosE4k+/d+R6Olo0t3sOoBi6iog2+xc2nUG3y3ky8B
 0QlgWO+wHLRCNwzOQbdAMS9Js/iwc7TxX1MhEbnv9ReRKybpASBuutbvaA08Z4syUPmkfnRVlfV
 rhal8z5iCViPInFjy5iyWpZ8TDk2qamciCI5rKVaMAJ3xpXjFx0eValovTSB/TQYJs3kfd3xg8L
 ylqtQMEK30bzQgaBFsUAZj35Ffgi/GEOe7ivyLjOTWs/Cc5MLhi5A6vvKB+XKDwC+9sXf+ee7fz
 SHEPzw8YkcEtgaUfKlA44OyVrQ4lNb7iG8cLCmJMFvqX8gBUxPGlXIA/peK21
X-Received: by 2002:a05:6000:200d:b0:475:5454:49f2 with SMTP id
 ffacd0b85a97d-47757e57dc4mr9598046f8f.24.1783003163301; 
 Thu, 02 Jul 2026 07:39:23 -0700 (PDT)
Received: from jernej-laptop.localnet (92-53-159-70.dynamic.telemach.net.
 [92.53.159.70]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbc75sm10135277f8f.5.2026.07.02.07.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:39:22 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 Diogo Silva <diogompaissilva@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Remove dependency on DRM simple helpers
Date: Thu, 02 Jul 2026 16:39:20 +0200
Message-ID: <Tm9Bj9tsS_qxKmbhRnECBA@gmail.com>
In-Reply-To: <f3f2320f-dfe7-4728-9cf4-c3eaab33d09e@suse.de>
References: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
 <PMdb9FVETQuPUnyh12NM2Q@gmail.com>
 <f3f2320f-dfe7-4728-9cf4-c3eaab33d09e@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 29. junij 2026 ob 08:51:52 Srednjeevropski poletni =C4=8Das=
 je Thomas Zimmermann napisal(a):
> Hi
>=20
> Am 27.06.26 um 08:55 schrieb Jernej =C5=A0krabec:
> > Dne torek, 23. junij 2026 ob 22:34:40 Srednjeevropski poletni =C4=8Das =
je Diogo Silva napisal(a):
> >> Simple KMS helper are deprecated since they only add an intermediate
> >> layer between drivers and the atomic modesetting.
> >> This patch removes the dependency on drm simple helpers from sun4i
> >> DRM drivers.
> >>
> >> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> > This doesn't look as useful change. Is this tree-wide attempt? If so, it
> > should be done in one go in one patch series, coordinated with DRM
> > maintainers.
>=20
> Yes, the interface is supposed to go away because it is fairly useless. =
=20
> It's a low-effort task for beginners. Hence many people send out such=20
> clean-up patches for the various drivers.  If the change is acceptable=20
> to you, it would be appreciated if you could merge it into the driver.

Ok.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


