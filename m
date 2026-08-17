Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61041C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E810810E0F9;
	Wed, 19 Aug 2026 06:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k12vjpFA";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E4610E508
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 16:13:21 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso32547a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786983201; x=1787588001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJefdQ0fcifSAbmN42YkvhRzBSsRE/Tok4/E/KLKe4w=;
 b=k12vjpFAgWCu/0zCO6MY3sbqO/mmEmY7JoADlJcxLMR1WTJXVdeKJSNAXKzmozG8wM
 Zzk9bCuJY/L92avB/XJqDIIWkvwc58kpJd9+/EuXGmhYZsn8VpoRLI22D6yRG83p2nyA
 L51B3PM8E12dmVnb9ox/zDcsaSlq88SXgkPG+XgxrBi6bQZUvIDjlRQ9SxtzrYn+719E
 hltcNe44z4eqNSJphtrMBLNCJ2S9uLbO1eIlk/tp5UoqS4lmoEgN4LfpEzypwwXqavFk
 7dcZj/ELgQk4l2DCfV4/q79O/ZuvN3oA/jhW+uwQQmpeQLQ5MazpNkvEsM4RR2W2G6Mv
 FQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786983201; x=1787588001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xJefdQ0fcifSAbmN42YkvhRzBSsRE/Tok4/E/KLKe4w=;
 b=K2JkxXv0rYnBBg4xiRh6/RnOEA01aYgu24HMn34sYr+CLbla6YC+LC+GznK4PtSVF5
 6hYTr7JiFzjSFvvG/sdxskEeXZ+MDWEmO+T6q7SdJauAfuTd6vOR5BFCeUI3YO3VjzHx
 3mITSicltoy3TrZFOzD7aLqq8/ucrd8Ne8Oh4SLFIMnaCVInYBVqO0+hTQRTFRZ349CS
 VI8EoT7tAWJQz5Odd/tatu1Bnany5cutIw+fLaY3vhT3061HGnzyZLP/PcFUjwXQBaqO
 1LlgpjH+ggXh48nWxxrZlk48fybkNSvzvQu/wenD51QZ9GD38esF9EHXGS1aDovLjgW1
 tJAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqE9o0Fs5wUsBBDxIiIUDurtP0u4ixiPvFfX5bPR4lLg/abbWgYinUHDJqsdeO8oXpsjJ9In3iGqQY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+pgUEN30Hi+mHSVvQ4FaOOJodD/lbMib6xTGZ1qFqU5v+SBwy
 3fvWZT+vx96NwAwrubbT+VabS9R3BNhSF4XA0MG4LJ0csVHR/ohDXGtU
X-Gm-Gg: AR+sD12VgUuD7nXObfK2Gy0vFySqg8jLLJuHqbN0I8GJdRy0SVB+g3dafAPZW6a7bst
 SSHo6VpkCetmCMjXKFKMeLx3jPSHbL90Cf0zfWBZ/e+1Z5gd8Y2OcMC0Rc3uzO0kNqCKCW8ikZ6
 DTeCYzF6FJO8ESzRrW+1PkanEAU/7nK0GmyCJj0xo6sYOIub7lkhL9VrlO7NtfuRLsZqAkaw2tY
 ExWFeTX+q6i3nYAi+F6YLevs+ijMXl1GZ9vcBwNJpabMdiqHFseMXlRGq3MAU6eQAihCfjsdHCA
 lvAbEGKZjCaI1Hh2NAILRmDl+9dn4sABjYGhrOWLBGf+vqeWfglAy/rvYw3g/ysrkayRvHDSDC0
 CiSYZPErT8JtruWBVAFiTBDxdlqVAOQKoixvL1rteGWXK8Bblbd5/U3rZhaL0+pj2eyFQG4gueQ
 QbGSsNDfI5ZupkapnCVbRQ9dcoxpEePe/uuy8KkG0HWx9vvhT4LZ76pWjCGd0=
X-Received: by 2002:a17:90a:d005:b0:38e:4f42:d0d6 with SMTP id
 98e67ed59e1d1-3955f1d0d60mr113069a91.12.1786983201436; 
 Mon, 17 Aug 2026 09:13:21 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:faaa:24d8:b961:4887])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32678dd22f7sm11391087eec.1.2026.08.17.09.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:13:20 -0700 (PDT)
From: mdshahid03@gmail.com
To: daeinki@gmail.com
Cc: airlied@gmail.com, alim.akhtar@samsung.com,
 dri-devel@lists.freedesktop.org, krzk@kernel.org,
 kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 peter.griffin@linaro.org, simona@ffwll.ch, sw0312.kim@samsung.com
Subject: Re: [PATCH] drm/exynos: vidi: use memdup_user() instead of kmalloc()
 and copy_from_user()
Date: Mon, 17 Aug 2026 21:42:47 +0530
Message-ID: <20260817161247.156884-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAQKjZPwb00MePpUTmKZbn67jXp=UWX7m81evttd29L+9UcVxw@mail.gmail.com>
References: <CAAQKjZPwb00MePpUTmKZbn67jXp=UWX7m81evttd29L+9UcVxw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Hi Inki,

Thanks for the response. I appreciate you taking the time to review the patch.

For context, a similar cleanup patch of mine was recently accepted by Greg KH and is now in linux-next.

Thanks,
Shahid

