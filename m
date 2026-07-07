Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA52C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7567610E4A8;
	Tue,  7 Jul 2026 11:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rr8+hXU7";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B70C010EC70
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:44:11 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-81d152c1c39so307527b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 04:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783424650; cv=none;
 d=google.com; s=arc-20260327;
 b=seiHFsCVRAIcke5bSVx55ISlwHtbCelSucxqu3In0cOJe9dUzhHhnOvvZ0Lfmi+725
 vxpqAT6HHn4HTYObwuLCg4yQXHdHmolPt3S0Tb04p4d3LljJC4kP6Kfh3BrnexejI9PG
 +UNwxl25S+z4jV2RwHBagXlZhdJMMN7WUfS6jhyxXV0wFRtstcj5DSOKbqyO6FE4quJ7
 4H7ipz3Os6y4HJPQ3TRUJ7SsFoIjuJE8QZCkGwHO9uCmQ4d6eCDwMv9INetE/Y7ZmUbt
 dP/GyGlBVBWECm9cAy3LJcP6UIS5qdbsU+2ZSKucHypPwQBag/CcqdCRe/t86kr39Z7b
 wuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=67hEAJ0W8TbXP17az7LLoVoZORX8tOcszaeupEwlAiY=;
 fh=0/Dg4QBPCwcU7qE04rosWIFco3hgdobf0QbKyzgxVqw=;
 b=YvaW7jFdMUtSHE2riaW7aTkYo+u9FRFPrW4jjzDl62lHro/bZEA13PLNp379VL4601
 argx+Gn4yUz9y0iuKkbufy//TaR1Dea41dbX/so7BlOO9SJ6/CEEZyn3Jzu61Soica4r
 FVG/2/zbsb3q3B5bx1NTDSCRbop5L6NMmDELTewzL5FknHpJvvQWldUO6ey17MiWzg4u
 y0Xn1fJ2NFFRtGKLWYjnra+TXw6puyvJkQJ41+Quc8JabgHvEeL6WRCHB1w36uCQCGzJ
 D7xUwzxfCroCYhf8Ji0c5RVosO901IGDXw47u5Ab7GiqOXBkACE6lX5ZiQsixq0Kf1cb
 Ubow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783424650; x=1784029450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=67hEAJ0W8TbXP17az7LLoVoZORX8tOcszaeupEwlAiY=;
 b=Rr8+hXU7S+lgS5WZCwoP8UAO+Y0eaqHuew47ATDCIeGwRSPo8YeqywN+RXfLlzwfNS
 JwkMMU/iqYSmCFMmxwQo1wZaF7qhDv4L6PhgzBsar15c1cNCrCn3IvsvXLAGfcdR3mB3
 VrOQJocMmBYOCp6a1ZA7hgvN6nBzbRVTmnUbpKfD6dPiCiy7TlTMJpY/MPHqqi6GxNKh
 sAwVD9EITRffbM+3CWKbrO/T91O7yrnnJ0RjVQ0P/bRLsUo0Mmfv1qZKNIqaSWG40wry
 qPN8fo/4qgFBo0/Gg4eDBZBDHqVzhZiUFFJqSYv3CDbXwMzYT9wWV282V8YrWOxPn9u1
 o5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424650; x=1784029450;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=67hEAJ0W8TbXP17az7LLoVoZORX8tOcszaeupEwlAiY=;
 b=nPvEoIOuMWlcxLhT5UvmjiyadZPIZ4ZCWQ9Ptr1SgZNyfgyPQjHIDamIPDNJcv/7hk
 JR98pYpx71fEWOSHCPpxvsd02tzlD/0NHSaAepFAJUeJu9gaE5j5G+zT0QONliUDDdv9
 DD0I3qafGR4y9v6M8w6w1YinloXM8cr5biDRWwgMXGkEQYvplTBNfOHxAlr0vWtKIM+i
 CGkBJOguz6gPeKa7u0P7va8WbsOiwVIsMzSpTE0A7HjCGr9OIWZK97UR9sNoA6h4ul5m
 wA3shZjHkbr51X7Tru1otW1t9qVBUeMTyHYfTybVmCp6EwE7A7xEuexBl64ktdI3QNCE
 KNtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNnB5fv3mqR21+cEbNoABYRhuqaZEaTOj0CDeIi7dzypezntQmpXIgAwBFElF6qqcjIODNlL03qKA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/HVQbv8BWaA83H8vcQKDsLd5yG507VhQoVz8jVgJhj4DPnaor
 BMF/CUt5mrEVKLDbxyCiTQSw0yE59R+Uz3oBIPG3fTZEpvCiTrbl4KscLPtZs7l8590shZQpAmt
 AnzupJNx/gKf2wz9DT8Ju3Hzh2ejLn3Q=
X-Gm-Gg: AfdE7ckasEBZ789UQ3pbUSpgw86nCdebmJYEdgMlecAWJgxW+yGDsDIUXgKZDIEEcwf
 7j7wra28et2XFgpPkjeQ87+tuA3Nf3LuPVHfAgVvIkOhnWrL3lB++zi6yx0oWAHWcOhJxNNUJn/
 ZBJ9ZTN+U3oU/nc72FNWampdryE0VEXDdz95IlCGbr9Q06RVkZtYPIWaKHTBwhd1wLsv//KSC21
 0uWrmQN2xVU3ugHCY8pVdhATunHgQj0NZewlCJeet5k7OhYcj15HSKgH83SNX/RKVLyzTCD3iZt
 M8oMHPQEAFCoeJ0e2vOvLlnbUn6SJ6AQg4lc20PetxXHiPfKySjJ7A/buA==
X-Received: by 2002:a05:690c:47c4:b0:81c:bd45:478a with SMTP id
 00721157ae682-81cbd455201mr8632077b3.41.1783424650492; Tue, 07 Jul 2026
 04:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260704084133.122053-1-christian.koenig@amd.com>
 <c575453f-d798-4745-b67d-4476825dfa64@amd.com>
In-Reply-To: <c575453f-d798-4745-b67d-4476825dfa64@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 7 Jul 2026 21:43:58 +1000
X-Gm-Features: AVVi8Ce7O0KwC_YSOIzySDPamgDjtTYnQvuH_iwtOUZsxhnymDAqU3HCRhQKPB8
Message-ID: <CAPM=9tz38o_p--FGjgkcDCV43jwmbx_zYDyc8fyHKBteiHDRrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/drm_exec: avoid indirect goto
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: mikhail.v.gavrilov@gmail.com, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, peterz@infradead.org, jpoimboe@kernel.org, 
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 7 Jul 2026 at 19:11, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> Adding a few more people to comment and review.
>
> Thanks Mike for the pointers, going to add them to the patch before pushi=
ng it to drm-misc-fixes.
>
> @Thomas, Maxime, Simona, Dave can anybody give me an rb or comment?

I don't like it, but I also don't think the thing it replaces was
spectacular, so until we can figure out a nicer way let's go with it,

Like I was wondering if putting the label in a macro would make it
more explainable, but I don't think it would help much.

Reviewed-by: Dave Airlie <airlied@redhat.com>

Dave.
