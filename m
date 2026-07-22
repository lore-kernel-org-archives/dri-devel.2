Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A9BC4453F
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF6610ED8B;
	Wed, 22 Jul 2026 12:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gzE/5dlo";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E13810E431
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:15:43 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f59f25ec4so1957968f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784722542; x=1785327342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IVLV7NjgP0TOqg9eeIPWtc9f772NSdz+whEsysuPUVM=;
 b=gzE/5dlorRPdsBF85dJzKBbDKqr6BS9Kj0IUN93lIJaEdOdBeAbeeJlXWW8bxbPZsg
 HWiDKSOAtuLhGa1i1ioSmRGxUoJRL+6hZeKTDimypO3IdEr5AssgZdVGcXs/Jbd+kFUg
 418FmBI/R80OsPgVriKTHVW0rPTti0yFwSOcfWO4grJvkEWkBAU4SnLkCWr4NbwfoUQ9
 uzF99+hdnImcjcKf3FW1eosjMA4+DUNVgrwkmhPAKPGl61kCzU4giBvfoVflu85F/A4G
 zWed70C2bTwbn/J7P2iWZO1TJ4fYHfiOVIUQhq6fGsvjbykxt07z2uTlKeq4UJzy/O0D
 xIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722542; x=1785327342;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IVLV7NjgP0TOqg9eeIPWtc9f772NSdz+whEsysuPUVM=;
 b=PedM4GIDYS3vOA8ofmnIBn4o0n+xJX4LUgL0E6yi6D1QUwZYPQ/lASt2M6Lkv0GqiO
 5dfwu1lYsHKzniAINywokmbFOaln+/thTzMx/7rcb/PKJkYGmls/v6ztXVBx6y4hmaSD
 VpuGK3kX6oqFo/QxcVWDF8Rz/LoeHirRoFLWLy6u4ELg4MNjYYIK4dfJW0ItmkWmcLxE
 k8GZ3NF2Xe5Zla2rTLr1Rd0IeCn6wZLGGclungg1MaMC6ss/MewUM55imjYbleuQ3zIx
 x+f3VpUfJRVBtL7+lv92OwK6FW6SFAD3wUnHJXUXkyALSCdUL9sH8jT/5O6vpUxpBI6s
 XE0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFdtgxAOMsOzrfmClQmM1U9TXzlHOiSci1f1CDhydxNgZN04NlVIiO6aBDQWTAKtyPx5VGdReVgc4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXKCl/K06Wh/5nxWl9Q/Z7n+Ws9gjvVyI9u4+tBxIW0P01+jy0
 A1f2vFyV+s43gR0oaBRHqD1PgBZYBZmf139ISNoeNWVXZzRN0ZfvXW01l85wWjSbZkA=
X-Gm-Gg: AR+sD10rGrCxeuYfiFhexNSiUheK5pXtfgusyMvM4MDhg1pnsRvtkWLjzS4Qls0vqHv
 Sasq2fVCD9D0v8fmCbVP3XkKt1U5DXs+Ukd2B0w41lM3o7e5G88LPWMBojxZSZcCVBsjfkqvdlp
 Ns6UAbDUbm6lTXu9/bI497I/TVK5H2sh9rrxGo3e1Ds+Z1ARBfUMnNe4H1t4ED9FOl5RT/IeDmI
 fIurPaTaqVtZ/QkcWIIuYDVL68PqTQHxv16i719PCn0Hol/IzuO8v9EzMti4u58CM1HeD63XKs7
 QI/Al+ZtajCh2ggxl3jpZzF5FggQuwu3J3ObyNG9YOdqTTybkiO1rYY7ZG49bjr3tYvrcGhviEd
 dCUCTdCAFdqIoc2OAYLJQXcm0pdOvykPzzWZRnhCh6s6oAkYhbzmePJgzvgSl45ZgGfApzvLDyk
 m+xIFRBJZsyROBI/1Ku6QhyavpZOqNwrOMhw==
X-Received: by 2002:a05:6000:4702:b0:47f:83c5:74d4 with SMTP id
 ffacd0b85a97d-47f83c574ffmr5638257f8f.23.1784722541786; 
 Wed, 22 Jul 2026 05:15:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f8635c8d7sm4379093f8f.21.2026.07.22.05.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:15:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert-Andrei Mercea <robertandreimercea@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: osd101t2587: migrate to newer mipi_dsi*
 functions
Date: Wed, 22 Jul 2026 14:15:16 +0200
Message-Id: <178472247763.1745070.6461113880184444922.b4-ty@b4>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720115126.666363-1-robertandreimercea@gmail.com>
References: <20260720115126.666363-1-robertandreimercea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Hi,

On Mon, 20 Jul 2026 14:51:26 +0300, Robert-Andrei Mercea wrote:
> Migrate osd101t2587-53ts panel driver from deprecated mipi_dsi*
> functions to their *_multi variants for improved error handling, as
> specified in the GPU subsystem TODO list.
> 
> Link: https://docs.kernel.org/gpu/todo.html#transition-away-from-using-deprecated-mipi-dsi-functions
> 
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: osd101t2587: migrate to newer mipi_dsi* functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ab3d527aaa334f843d1a5f71aa79678a34ff4e48

-- 
Neil
