Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E5FC5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BE910E302;
	Sun, 16 Aug 2026 14:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kz3F7ZFg";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1E010E0A9
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 15:39:46 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so13159875e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786808385; x=1787413185; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=63FZWuPp/rokKWnhrlhEyVlpDgyE7yf/8PcWB4UXVa4=;
 b=kz3F7ZFgVrTES+HDXGBbcvDm/AcbUaWNTmS6YpiRsVX8C1sAHpkpFEWIXOjJVaJF6b
 FqDdUzJmFInkb9dO8PuN2Moa1Dq5zg2z8Cm05u1g5KWD+TWXLtAJdHM4b/UUHAB5vMeg
 EQpvng7qQCM+qy6hcB4iFb4Yj3VBBoJ3rseomvkDVPmpPWWRXn23WGlDBxyKNDcanB56
 md7EOU2M9YFDGtXtHrpSiFJFV0e+AwHb8Hvrz+cFdVjc8ED2GwWqCwgSSGaLqOa32dVx
 qc2cioFweBrFwOeXyjit3P/EsuTHH/mlTwPTjZcavmGSVOqOBKu+IOfreoYLnzuCQyyl
 lzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786808385; x=1787413185;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=63FZWuPp/rokKWnhrlhEyVlpDgyE7yf/8PcWB4UXVa4=;
 b=Ra69WtfjHT92ao51vRIJnhf+SiS3hvh36rOqSOBVb+e0AVJqP6Sq6PZo41QOjCG0Bf
 LWgE1/8sEznR4m+RjrGMMbsB8nlhAS3b9UMgrrnjXPf+LyQfaGpCTP7aP857No3RCHp0
 0f1z+vnuyx1rpngLZYDe+BIqRh18XsAEuE+8rwcTi80D6+J66EsThXwsIjFPr4pN4vtG
 qL0lS5LQQztb7OreOAwgtWB8kLyQaeVmdrCGXFBHrGonJ4GML3UtaY5OjlUOWznf1dQA
 j+9+uRBdbAlqK+ZZHHrFi6+A30sowcKAnnI2368jXrXlgRJ3kU3UBo70hshti3r/MuA+
 Ttew==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7L4CdjpvDl+sxxgZ4qcwpsS5qXg0EZ43VbM+7a6CHx40heY7cR/s7d1P1XTsw6pMYB+QFnhps5B8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwomxxNxccCXcY9Zy8go+pibg5emZqaZmAmuiC5wnjDl1BSrwF9
 KfrnhArg1mJga5edk79sD2E03qK+KBzEFvfcRSongqBDrhCNfzgal3it
X-Gm-Gg: AR+sD12oy4LNcpTWlMy1QvX5p4yx4TlPRw2wlSs5eyElWx9vsZMcCkixCiRAi5tTo6y
 wT8f0hctr9gEmLgWk6Byp6wNaiudNlAHDeldSjhbVZU5ZzP12KYGtNTQOvFABUVXXbng0y40mkK
 35K2n3RVt/lQOFosstQO+WvGLDMlHnr83JwCWDqQsGK9wTiBJO7DSlEcnMOd2xLTwPBy5Otia8t
 6AGVXJZ4d6uZntBZF7CoaYxVLThNuV0QfH82Kq4lmg96sX8JQFx5Ad1ytgGOFMiE4Ye6ruberGK
 RZricCEI2grpJGHmbYiTzO41SziZxsiYJ7lKwD/WELaKGdckLQ6E4y0X20hzeuENpzY+oQq/cWj
 WddyO5Oqkq956zL/y04dsWlzbBgrMTn0oH4a8thz99A8ophp5eEHSqLPboF6fWtgZHEsA54YJHO
 Nogbc9HqWvgdi/LbZkcDkkAlyhAkBioIxXDy1hJKqvtZw0MEm8xGz41xKXVY6aibfx4TNp5n1y7
 PcOWskKLAhfks5N/gP0VYUkfwZF4ifj7hKUSr2KDnTGa3fGGFwJTlvR4pmf0DmjPGDXytgPzgTA
 MX3myM8MsIQLEYooy/jNLeZPSh+NgCT4DJbECSv8AS8p/jr7TB0dRblbY3W8UvdIIg==
X-Received: by 2002:a7b:ca57:0:b0:499:8777:ccba with SMTP id
 5b1f17b1804b1-49987961b86mr146990645e9.12.1786808384630; 
 Sat, 15 Aug 2026 08:39:44 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de.
 [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b24746sm259187945e9.12.2026.08.15.08.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 08:39:43 -0700 (PDT)
Date: Sat, 15 Aug 2026 17:39:42 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
Message-ID: <aoCH4xjqTOiZc0_K@gmail.com>
References: <20260815145914.84154-1-kmehltretter@gmail.com>
 <cdfaab3c-89b4-470b-aae4-d16f7aaf18ea@igalia.com>
 <aoCEGJXl5k6IrhT5@gmail.com>
 <d3aaddb2-b7f7-459f-b80a-e2c4f7b3d87a@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3aaddb2-b7f7-459f-b80a-e2c4f7b3d87a@igalia.com>
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

On Sat, Aug 15, 2026 at 12:26:37PM +0100, Maíra Canal wrote:
> ATM, no, as the fix was part of a larger refactor in V3D's submission
> code. Have you faced this issue in any real life scenarios? If so, I can
> think of a way to backport it.
> 

No, I did not hit this in real use. I found it while looking at the v3d
code and then reproduced it on my Pi 400.

So there is no hurry from my side. Please decide as you like.

Thanks,
Karl
