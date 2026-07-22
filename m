Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7653BC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 03:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D8910E425;
	Wed, 22 Jul 2026 03:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jn8Cpv5t";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D751C10E425
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 03:48:15 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8ee6912d86dso60973266d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784692095; x=1785296895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQuvP1fDBqO0c7MvModbSGdOEb+K8fGjvHhbuLs5Alw=;
 b=jn8Cpv5tSfLI7bA0BBtuNz+MXIMqbmrLtHrhncpfFc7Whr0+HFu7CkpihYP/cI1GBo
 +F7pkMKxpF3HyDQt9276b9psh8i5hnn7C2SpC5gSdVeM1KAHL8ZzjLrn1XJIyVXXjiHw
 rjlGJYTiM/GJrcEmRiueLm9bLGmI/KGK8+3gfL1T6guAKVpuZK7vxUtpRbVL1ihSWPQw
 y5GEU5AFTXrmqOPToJPkEbjp+L9mStY3T1OJ9t6G9wXvsye1XVCNk7fECtjrwuMbl6T9
 8FSIrQG18PpbPVeQD+il0SKR2oJad7Xxa0hVlPbW6G+kJ/CG00w1u1Bq3V/hpbW4wb34
 wMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784692095; x=1785296895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mQuvP1fDBqO0c7MvModbSGdOEb+K8fGjvHhbuLs5Alw=;
 b=ZXceTt+yvKK8J8R+WlfUU/Suw8svjLA8b43KkcX7GgLFy4U5DJ21/WvMazFtJr9Dwx
 rLkrNHfB86biCUo5kGhT1e80axHWuNArAxb2z5uhIcZDwZITWkfvJI2oraH5/139Vq/r
 jxj7BhrQp4mtgDBlAQYSXwHKukQCjkHpvybDcLsZ+mhDX61fTWZImrpv23leeoVsv2GL
 QfaS2ZEvOefbmp3DwZ5Rsd4sMPYZN9SHv9eyDLMj25zeokjhsWDMgOnvbOgbyrjcXqgi
 Lv+fZ4VEyin+o6w0G9MYh+eOIAIP1nUq2sOdO9ZeYv/sAxFw5kUFgnRjIC4vr+hGfJYy
 Fc0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqymZhPCQpkUTJhclF9DSlIShaHNjGohiaWWxGQ5MD1KtAaDmZjj0/LyEspaw/kdKY7m2LFBroC3pA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZMov0iDUWLfbMnRZOBBFB7uNl8xzmZuh0WIm8TGGW6gWoASUA
 x579AVdtWpr3kgs5SB4r6x1EYNLfQlxvZ7iafr3qaY7aloePgbYWQU9q
X-Gm-Gg: AR+sD10TLzK1AKtM8CZ2jNjP86leOZ1eKAquIl2AXfd6zBYQSEesUUwf808GKD2uSvv
 Sv+c5sei69M2IS78L0+KqJrviyMKKoEgIKaPtuRQbBJDQHRjvIXMH8aMidz1V4qmqaoMHvayAvn
 cp0qxndE6P+qUfv5PE8k2fKLDcKEaKI6scibSDni6DiXNu8FF2u6Rs1qFZVSaS+VM+vRIWOilcq
 Ta4XlHzS2jMbxqb6W65HMYLxGJSETwUoAXmKQ6DfPeArjNKUBRhGxu261PzKAfDffu7v9UVvHVd
 hJQgfWs7b/vBfdMzIFXk9K03ObXTpUsNtjjJB93pqHif9AN1MTZe7VR9cOYMbWIvOlHwSe7iMO4
 nKc7xJvPzQruGOJsVoMCtO0uIu+IF01bDBItv5tzr/6Xuik68JCd9E05jHHVLQdiNAhupFZYzp2
 yTraI7oNq/rh1D1mnc6iMc4uNGw+vEKycZyEy2DID3hI4=
X-Received: by 2002:a05:6214:e81:b0:8e9:f62b:8f99 with SMTP id
 6a1803df08f44-907783cebeamr237912806d6.46.1784692094667; 
 Tue, 21 Jul 2026 20:48:14 -0700 (PDT)
Received: from thinker (syn-072-043-128-189.biz.spectrum.com. [72.43.128.189])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9e19f6sm11466546d6.27.2026.07.21.20.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 20:48:14 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: airlied@gmail.com, andriy.shevchenko@intel.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v3 2/3] drm/ssd130x: Change SSD133X color format to RGB565
 from RGB332
Date: Wed, 22 Jul 2026 06:47:39 +0300
Message-ID: <20260722034741.12572-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87mrvrbabo.fsf@ocarina.mail-host-address-is-not-set>
References: 
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

Javier Martinez Canillas <javierm@redhat.com> wrote:
> Patch looks good to me now. Thanks for the respin.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Could you please rebase on top of latest drm-misc-next, now that your
> column/row fixes landed? Then I should be able to apply this patchset.

Hey Javier,
Thanks for the Reviewed-by.
I'm generating a v4 for this series per your and Andy's comments on patch 4,
I'll rebase on top of drm-misc-next and add your Reviewed-by there.

-- 
Thanks,
Amit
