Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43D8C5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6687910E30C;
	Sun, 16 Aug 2026 14:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iy3F23K0";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7132310E1FB
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 15:22:55 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so21409085e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786807374; x=1787412174; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ySDGKiW6KAfDEAKyZ+TvFma+gFzvsqvzjDXe1UcSZNs=;
 b=iy3F23K0KWPsVKwRbJWtzwrg6fWNse92XqBf6H+CVLOmDucpOiXmDVe4UnOc9IoNPH
 wVHdclkjDTzruH/dYf4ugSI197TbBi3voGW6h/afLQIj2tjDSA2CM8xfhYS7Ir3QZFvI
 B5jqrTIxB6GzJo72OD4yovTsMxYtn0wzocSM58mSRCOgADG0dK67h8bfJ+IuctI9Svpg
 lvuJobmdjEDdQwwcDwE0mcI+NRGo/ijFxAEEIiff+MytNrF0PFMD895svaDmoZwPElMh
 lY/1OY+UIfdOp79e62J/xN1TWyIN09N/45zOgeXnsbtLm34LMd/rIWu/Tb38aTUWGEJE
 Gh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786807374; x=1787412174;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ySDGKiW6KAfDEAKyZ+TvFma+gFzvsqvzjDXe1UcSZNs=;
 b=UVEdgWF6jtBg0gm09xxeU+M2iCPVAgxVBPrwm0tl074PtYT8DA1mpn8/CVxlj+MIMt
 ST6+MAPIa7qCSSCDS3JguXE7bZf2wE4VBna0qudG96s8CEQK61cL8IAxjwv6ywOJdPIk
 ZScr1Bbn96N26hRWCbLB3+cirEJ8dbQ4M+TDapSmHkHg4ZgmZpKXHwVTx+JDUvGqkPfD
 kENvRTo0v3YpH5ntBslv9F+O51ofjfvx9LcytObDgl/1R8E5f4vy/Ai5BRImDKw2o41I
 Dv2MvFnu6ZOUhG6eXD2KscKFjjm4Tco2Q9EyX01z58lxeN9YyEqwTiXeO4E/4LlTWV5I
 Ze/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvxNMZkifaOW+at0D+L4sIE28IvmsfqpCQyxB/h9rGeQm4FhtM5k0waqmaCsoAa2OYYIOx/ugGYA8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJ+dzQZOSY331pf1fG77mGGa35eRGouwfYN24t6CZRqIGbG+zg
 slIXWQ/1qh5ce2h5LJ37wfYMwDGmMimSbr8p2SeYuMng/8l6EBpCzOoL
X-Gm-Gg: AR+sD12XI8UJXP9/AMhLY0IO6CWvOFj5MFMxEWlSnefyRNGfTWHR2KQdOwWAjq6MKZT
 evl51FDQ/zcrthdPT3woLVJMN/gm3pw1m/yy+x5REmZuH4YfrGRt3t6x+GS7zku2QpSWtaQj9nN
 R7H3ebQcUqyp/7QySsTQF+k9/GXb0lf/f/eheX2QypvJhVWAxLzyEuI1M0Vd5ZuFj6mEjHjxx2J
 pBTklneBShHXyP+ivhl9tKGYb8AZdX6PqqOb7Rj7T+5jdJQuclppobDUwHpOAoper4L5bSfT4Eq
 aoCtaYHKoYsNemr5tLqXFz0XmbzViEoVI9Trm8cTws+pzsFAnfX0Y4kIqb2FB26U/L7qV9FhNy1
 F03Jjp7qQ5XDdHvuypJoqq3LamInN8YC9UHxzxSR8+909nG1qtJJHGrofvnl7deLZpkpDpdJxc3
 8UfLKBG+zPxNPKQvrFf72OGVhA8tsaMdrk6qgybynfGj+8+3FkXZr40p0e8T76YTyQz1tXEWY2s
 8ezLhf6cLFaf3uAx/ZqrUFAOgtQtxDlMaiRj6Oj8NYzcn1DFcqAW7L3JNyzCAqgRaTaVwXAAEM4
 /lr759L7VXYbjpn96CNZemEUWvZl2BznTmxcXu5NBonuMbZAscn8lxH2rVAF31Lc6Q==
X-Received: by 2002:a05:600c:37ca:b0:499:858e:de42 with SMTP id
 5b1f17b1804b1-49987935039mr195889625e9.6.1786807373788; 
 Sat, 15 Aug 2026 08:22:53 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de.
 [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988af1068sm161216485e9.8.2026.08.15.08.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 08:22:53 -0700 (PDT)
Date: Sat, 15 Aug 2026 17:22:51 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
Message-ID: <aoCEGJXl5k6IrhT5@gmail.com>
References: <20260815145914.84154-1-kmehltretter@gmail.com>
 <cdfaab3c-89b4-470b-aae4-d16f7aaf18ea@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdfaab3c-89b4-470b-aae4-d16f7aaf18ea@igalia.com>
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

On Sat, Aug 15, 2026 at 12:15:46PM +0100, Maíra Canal wrote:
> Hi Karl,
> 
> Thank you for your contribution! Unfortunately, this issue is already
> addressed in drm-misc-next.

Great to hear this is addressed in drm-misc-next. Is a
stable backport plannend for this ?

Thanks,
Karl
