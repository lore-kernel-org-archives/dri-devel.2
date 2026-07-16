Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F49C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD8E10E1DE;
	Thu, 16 Jul 2026 08:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dUFbHeQ7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C1610E1DE
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784190977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hbd5Ry9waQgWss8Lt6g6SRQhPC0Z+JOhqwK0zr2OMhM=;
 b=dUFbHeQ7ONRnJucxJDUWEIevrinXrpfKqz9ixzDAawTsHB1JU80ObXRv4IGhoTuG9D16Oa
 t+fUnIsA3nllCe/bCaQ0WQLJ9c2RuqP0LdhNYbL2mtw+rx7qNwNlQ5+xlfl2leF1Au6xUx
 /S2kUOOzRNalDTu9jPYDy60wOMReIio=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-o9fJt5fbOAKIWgca9lOV3w-1; Thu, 16 Jul 2026 04:36:15 -0400
X-MC-Unique: o9fJt5fbOAKIWgca9lOV3w-1
X-Mimecast-MFC-AGG-ID: o9fJt5fbOAKIWgca9lOV3w_1784190974
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c20d0468so33431755e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 01:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784190974; x=1784795774;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hbd5Ry9waQgWss8Lt6g6SRQhPC0Z+JOhqwK0zr2OMhM=;
 b=RYxFwBHOmw2H0vQ3at++QBzjN1/t3tlMNmXDqWg+LkzS/2Ff2TcrhkdZnrOnZvU7Hw
 Eabq18Wv5EqYxTx9xiNSv3fNPzlwpbE4MBIyYbh/4dLJvM47KoYqYZe/82fvaf0cuK/C
 U+thkF80pF5YgE2W26mRjAqsKP0Yj4HSxy1X6AvTGb+DETtYDK1/vfN8CoGi/cvQLDMm
 gn2rXjYxB4qjC/L5BslbbrenuIyGZ3N5InC9vBrlipDUiu3G9jCaoNsxRQmKf+z6jIBS
 p4WpOAw/2xZi91H54ldajtnCKOdYn7gb8hs3M63uYkfoZnU2/NAkvyV/YMevCG3qr4Ma
 fqoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMdnvkl+O7HCEdRrYMBj2YT0WyUsraJAKTQ/mffF4+DQJ7one4G7gfSnaJjzqju7bw64E3oKJXCUQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkLGN2KEKkkoSFy8XaP6VprIYBeXp8RD+0MAIM3Lk7G4MaQ7PF
 etzZ2zbCs8WNIuMti8bzT32Fk0+xYHffvBdADkaHrPby2r7LYdIoBvwNA1gtFVUp6Jb7ma42YkX
 w2/juTHp85mB91nbQlvgKtmiTAbt7SF8NdLouQbdnqktvP3wlKDJdHu6qlWdiKxuKx/cjC/6kf9
 s0hQ==
X-Gm-Gg: AfdE7cltHCQhd1R8QVNeZBHegr1bAP1oSSqCBh/gC5Z8y9wLqB6XQnvek3HYeRr8q5V
 vVv+3bmh8ywCtsfWoKhTaWWCH9ExjTHCJ699Di7+NXEetu5/utvPuT5FYHVtSaxGl4iUN7kelap
 awsisecpw2ngYJWjTq2L8PVOrKJN5PkofeK68izuTdoSjsWQgHMxH+xO2rnFujKVco+5Fbk5+n2
 D+86FitAzbaVmhHYOlvxA0DHg/G9kl6ENtm13XlMyPtR6afVK7UxONTD7xvncUQbyQSGHelF/80
 hr/sDq9lNhse2DfppNS2OMO1CY4v41HHftX2fumViHiwyMe3A8xIeTfioQ85FbkR/m9nNlattLT
 66QY1zgxxDBn6MzyNaA23tX50iPrPCbYZyp3tFUEeAYRb1kb5z1VMFVxm9DM=
X-Received: by 2002:a05:600c:3491:b0:495:3f64:2659 with SMTP id
 5b1f17b1804b1-4953f642be1mr50481685e9.33.1784190973999; 
 Thu, 16 Jul 2026 01:36:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3491:b0:495:3f64:2659 with SMTP id
 5b1f17b1804b1-4953f642be1mr50481025e9.33.1784190973486; 
 Thu, 16 Jul 2026 01:36:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e51f47sm38836845e9.0.2026.07.16.01.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 01:36:12 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v3 2/3] drm/ssd130x: Change SSD133X color format to
 RGB565 from RGB332
In-Reply-To: <20260704080925.75113-3-amit.barzilai22@gmail.com>
References: <20260704080925.75113-1-amit.barzilai22@gmail.com>
 <20260704080925.75113-3-amit.barzilai22@gmail.com>
Date: Thu, 16 Jul 2026 10:36:11 +0200
Message-ID: <87mrvrbabo.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fa26zvlmSIy_T9ZxLihFNZs8X3LpdPauRluhI6GBlSs_1784190974
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

> SSD133X screens were driven at 8bpp RGB332 despite supporting 16bpp RGB565.
> Switch the SSD133X data path to RGB565.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> ---

Patch looks good to me now. Thanks for the respin.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Could you please rebase on top of latest drm-misc-next, now that your
column/row fixes landed? Then I should be able to apply this patchset.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

