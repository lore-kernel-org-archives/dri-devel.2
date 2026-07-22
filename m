Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA9C4453E
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44A810EDFF;
	Wed, 22 Jul 2026 14:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FJDbI44q";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944FD10EDD5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:23:11 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so30316605e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784730190; x=1785334990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0LA9RG6rkAfPack/4wmvg8fnZHcKzrf8+pmqVheecvI=;
 b=FJDbI44qataiZeMDdj/+0IbJPlYP1VFn6Lb0EBqToSCCXq/oE6Rxj3dgCB/6Vv1ZUW
 BVwEHkuk8vDeHJqC0qTblkZrVwAjCQ2H1uvEzCTmeiBHo8D+sADAsOY+Bfp0RrUgBex/
 5Z1Xabdk5Z2K5VFp/G4x1IJ6l/XaMi460I4QVRozBblGfJPgs+KPPRKrnU6bCp2dlW8R
 xmQYiy8SU9wM43ssy4Wup9xgAwm2naILbdQSjyqD8uwPHB77vHd9hl4d4d+d7s7wU/gC
 HbMuUK9yvzYrwV8sAXOR8d8B9++BEJFbIb1gCc1QOKzJ8lTrK1qooEA8AS8kBoWeeIdM
 EotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730190; x=1785334990;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0LA9RG6rkAfPack/4wmvg8fnZHcKzrf8+pmqVheecvI=;
 b=YKNY5/ss0MbCCm/imCemgjHNPpRncdqAvgFWPr/i8meRG13Tg1eCqyK7GG9OJZgt9A
 MesaX4eH1PAkmA+1AOSv4doyaK2mgUoN8VNXS8U+yuskazo+uanVZ41w1hiWpWL+ZFHb
 P49z0r/vXh11X30xDCL69q/2D6L56Cav3XdGBaTApKsnXKouv/faaU17pATSxg9Z82VZ
 CYVUWuco3d7pwvN0VeHlkMGO6rJEVdBvMN1OZ4uWKo+Qi7iMWpLn/UQkxszhPMcKX2GH
 t08e+GmqCOYjDKPaavdBBf4mj5TjHFGhrW+Dv7Vzntw06VtD+lBFidopTTL9aAG4K9aQ
 7evA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2jaSaU5V8HX73XQj4lJ1g4ODCelxezZ45Xnr6qDRbBJQXnE5UVAXEOXhDPQ85iwbzGJIN8+tJoJg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhKC3idyqYX5TkoKsSlyS1sqJejbVs330VAIhD6shtKxyLVYSU
 k3gnc0ZvmHYP4licZGVEA88rdAwXNj6MPZjprEZaBwEcQc3qyo1xf4o9X0KJVXFHuZo=
X-Gm-Gg: AR+sD124xhiy7Z/ykuE8sNaQQsYjq+SCxuDhpLfs8jjo7VIb/VabgJO64A9yEyZjuwQ
 9AybTASj5Ziq8zj7VkG/TGMWE+KR2P2aiQhHtJLEqZPi0wZr08tSLfBEFmhZYIqX1Hzbvzx9jeO
 cqgvfDZVKCjh6bXwVvYPzywIyCx78YsrJL5lsNaNPb3MU94tc8L80dLcJ5fPhofMSNRC3ns8ZbQ
 2S2Z/XkrkqAknXLnIvJ+iCfbFMuWK/zAX0ooNpSOZHMM8AvWdZTJzFa4WXDXWK1DVzznZaRdyX+
 PFGPi37qBmjJIyxITl5zZ3iumYn1xUoRU3Vmeem7nkjniUoqaWAzHpudhs1g6v02f0tLYaTSXZw
 lj2inbjx0ItIfZBjpSZOWNn7IU+oV3cEXhDxTbAa5aLUDcgzS7mShsskrEiiyWJyWurmREOrUoc
 z52+x6076ADRuhR0JNldjjvcH31B7x4jW8rA==
X-Received: by 2002:a05:600c:1c0b:b0:495:46dd:e238 with SMTP id
 5b1f17b1804b1-4954a50ea30mr299565305e9.30.1784730189854; 
 Wed, 22 Jul 2026 07:23:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm138527875e9.14.2026.07.22.07.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:23:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Julian Braha <julianbraha@gmail.com>
Cc: jesszhan0024@gmail.com, arnd@arndb.de, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260712001514.2318597-1-julianbraha@gmail.com>
References: <20260712001514.2318597-1-julianbraha@gmail.com>
Subject: Re: [PATCH] drm/panel: s6e3ha8: fix unmet dependency on
 DRM_DISPLAY_HELPER
Message-Id: <178473018928.1921106.10437263242991715710.b4-ty@b4>
Date: Wed, 22 Jul 2026 16:23:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Sun, 12 Jul 2026 01:15:14 +0100, Julian Braha wrote:
> Currently, DRM_PANEL_SAMSUNG_S6E3HA8 selects DRM_DISPLAY_DSC_HELPER
> without ensuring its dependency, DRM_DISPLAY_HELPER, is enabled,
> causing an unmet dependency.
> 
> Let's select DRM_DISPLAY_HELPER as other similar options do.
> 
> This unmet dependency bug was found by kconfirm, a static analysis tool
> for Kconfig.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: s6e3ha8: fix unmet dependency on DRM_DISPLAY_HELPER
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3667bc164849fee4f1b18b182bdfe643f758ca17

-- 
Neil

