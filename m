Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00432C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57ADE10EBF2;
	Tue, 30 Jun 2026 09:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OPx2fdtI";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B576510E1B8
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:56:18 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so2679455e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782813377; x=1783418177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pxr0Kr4lzLvN9nvux/U8V8k3z8ULnbsk5lqwt68cCCE=;
 b=OPx2fdtIOKZu/2dRoWnEHf3i+twIKPBrTax5z572fNMreiiRQiQTlhSavikXqKeE+Z
 UOz+A9b4Jvg/tN2ZE/M/IWApJ7A11VZ2lSwkZFFOYUo+TDsdP2U7+tQErqjnLEdy8cns
 dWmc3NacmL7IYbWMS2ifR4BCOyTmETgjOyOHu6me33U6nkk5al2d1VCEup0/cz4YnYyE
 XH4K0Np7FAl9dXygizRH6aOyEdCVheLofryFm8WqOnXZdb9aQXMx7CROZu10NCHhRMR8
 XUYtIqo9Qzr4kv6RNtJHe0Soy5ZxQOalBJFDnGOHZEB6RpWks4UqcU87nuC/KyRqENam
 2G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782813377; x=1783418177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pxr0Kr4lzLvN9nvux/U8V8k3z8ULnbsk5lqwt68cCCE=;
 b=Hwk/cSvFL3/ZIxUOS7hvsF/09qeCF0sSdzVoScQeyC4//xCpCGdjx4wZBy5TFg2S00
 6WEJF4riK8Sg2wqh26I1NKTll46PEzSI/WH6SSTsaWZW6CRLX6h6m0p2wd0SFO/KwfnH
 Oyho/lt+bdm1RkHyrOo0GudVuKyV1HYu69B8U0aZGpVqGcjkdDMoYJ/756l5jgitZ+UC
 cmcsfdWXdSHhmaE30lzBtjaZTYD4d+7TzdQCKPZQtKCrz22vDx3Y8jAQop1HXuC4kJAQ
 p039SahEeOG99pVerH/+7hKtEEeO4rDUbOf1C9sTywSNVYXIEPI1GfkDEgjgKhLJjA/S
 jQlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XW9BByTdRGLHRNYb+POQMxhSiatSVQO/RdaBZNZgGHaMufmzZESjC/vDed6JxG8FTiQ78HaV6EWY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykvRVXvj1sgB5qUImh9Cjeh3uGRS3QstiIsGD0iw5c2V+inJSl
 u4bPrVP0mkm/D9ub/hcqbwLsLBMCAIZHVRS7JJYcClnsb+DPQClWv0l2
X-Gm-Gg: AfdE7cnxAbAzprbj2IAad+fuhMnLdDWd7g1C1GZ+pOG5CnpZCc6dJ2leC8zrkTvIIG0
 4FTWsouYgcWq5eheHWYE4R4ddvsQ8fCnVRTYhk7RuUYvophhrJcMRjoRCGkodTqBYCoYbgmnDp9
 QGyYhcMtDtQoEbtpsMzdtNxCWJ7o4wII0PmLBmDmhYLQ++ll3F8UBQecgqy+guxQdZWoo4CcBoQ
 7iEdp+Qv9TEDBsgHuE2bGs+Lx70SxfFD6ennyNd0UADeV3iMgak6SrUHQDG99HlxiHNhv8qNwUy
 MPbIvxGdYAEBeOP1kbPtEJ6DSMNae/QUgP0HQIvZcExJ8YzAenK/zJfrXw/8Juf++CNmeBdZYMt
 TFcHl/WEMFEmRuNKNtmJnoOQuDxPJwtbBJiZLzk9yXqFJxULAG/lSH0A3jdW+UafC7JJcy7jPXR
 wxINzQ8AdcvSlfJjhGZNBddKMOInc=
X-Received: by 2002:a05:600c:4f55:b0:493:b4a3:5ab0 with SMTP id
 5b1f17b1804b1-493bc741b67mr16274405e9.13.1782813376697; 
 Tue, 30 Jun 2026 02:56:16 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8cd8bccsm61379375e9.8.2026.06.30.02.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 02:56:16 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 1/3] drm/ssd130x: fix column and row end address in
 partial updates for ssd132x
Date: Tue, 30 Jun 2026 12:56:00 +0300
Message-ID: <20260630095600.8392-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <87mrwdd8t5.fsf@ocarina.mail-host-address-is-not-set>
References: <87mrwdd8t5.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
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

Javier Martinez Canillas <javierm@redhat.com> writes:
> Sorry, I was on PTO and couldn't take a look to your series. I plan to do
> it this week.

Thank you for the update and there is no need to apologize.

> One question, though. How did you find these issues and came up with the
> fixes ?
>
> It was just reading the code and the datasheets or were the issues (and
> fixes?) identified by an LLM? If the latter, then you need to add an
> Assisted-by tag to your pa+tches.

I found the bug and solution while debugging the ssd1351 extention to ssd130x.
I used an LLM to make sure my patches made sense and to recheck my patch logically
and I wasn't sure whether that was enough to warrant the tag.
I'll submit a v2 of this series with the tag - let me know if you'd prefer it handled
differently.

-- 
Thanks,
Amit
