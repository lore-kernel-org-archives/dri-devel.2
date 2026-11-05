Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8116083608
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3IzSOzG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D991122C3;
	Thu,  5 Nov 2026 09:51:03 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FAC1122C3
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:50:57 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1128872f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 01:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793872256; x=1794477056; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dyBthqcbOdm0JBXumEJTj6vVAKyTrhFZS6V5YGIPQiQ=;
 b=B3IzSOzGCkx4SHElL5bEUDo6kzIDvx8KiQCwjHXxxtLJE4hvfa98q6V5+CJvwoRfDD
 cMHXqFY3dL0IS3ANhYslF1qF8dBR03PAdwnvsPlxS0Fr6owYOH99ShIL/bs/l3wN7NDM
 GsERn9yewhUdqvkR5qnrrYWcGf8gfe4oo4EZc2OHvsqOS2eCdCpYKz6S1/0mQZCZwdVM
 speAJDDw+dXoJYXhygJQo+7iBBPv5LZqSCkeaYTHxmnE0y/VEpsOMD62m8F5AudFVIfh
 JK2528jL/Q6y4kMw3ryyA6FMYdfbp0L06usWz1C46ygi15G6/nec2ZWJ1Nc5q6bNfjcs
 NpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793872256; x=1794477056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dyBthqcbOdm0JBXumEJTj6vVAKyTrhFZS6V5YGIPQiQ=;
 b=CsEZ1fmm1UKqpEoV6U28glMaZ8a1JFvanJd1RIBwW27xzEzOOKJkyk/2d2bjodTKrf
 C3W6i+kIAUsd6e+HZxXYGIwIiex2vzKUm6gRi7XuVjiDASm67B4wMnrgd4SLBWtph11r
 s1eWLqdlNBWRxuikQYcEDhujxOVweJP0tT1rEJntXeobQhtp704hkYGPWMZRYpFu9WG3
 p4PfC+bg9HK6peeG5MU0h87fxHe7b4m2C4bRYwgS01Jpn16rBT2qBSbOZ/a51BZn99vo
 jYHtUUsUrwlwobxrtk7s5aqFFyjMO72iPRj3QVaO3HbPokH4bZELbnL9lITv/JpiR8em
 33ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9iBtl7DtzX7xcr3PpQe6o3/v9X/ncq40j5nYRRwFdZEZXGsHyMf3YmpoYOES79v3xBcL/xDz7ge4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9OSwL9YOvV7WS+CqPDlHySzVnpttLFxEmz2oDROvSxA2EYp+kJ
 jl6atxiRJHLIWmpaafQ2ddHCqsou6uvDVm8tBbGhBwtrArnwinU0QhX7
X-Gm-Gg: AYBFou1Ego+Xvpa/eFV0JlkJWgNtTLtpk3j4bKDUWaprBtYwYHu8+h33TVpBXuH1ZDC
 60RYsltNOk7fGIyLUyCkHol4QSu0smCOV8jcdEqlMiHFbuZhei+nA0KxiGgQUxynD27Z27LVllx
 I7Bw4DihddktNaP1+trQp3RDyi0bq5DXN53oIjdtbIX03a6piqjAZQJkRpFtLNorOyvZAiy40P3
 QdatTQHXZqWs3pQzbyhx1cKfwmyt+fQJcYI6YS3hA9pdDnY+89f01M2pHKZmCgx/ZFwLt1pzvyw
 QDdajanu+0dU3lR4Qxt00xj2cXln8blArnAua5pL0to3Oo/BHq2+4j/p7NRNSVVGBcZUlmyF/xK
 5HyLcCo+j2jccuFGsbuyNfCP0+abVRz9VpLW0Y45swLnjjvxIJ92bgwixLNDwgBBnHiNbVY8yLD
 TTZLrxhcq0AHuGJ6R6V1NQxoeebOvpC0zuh3Wmg+BK4USlR3oJ1iq7u0FzYb2QVZUXHd7BPGc4A
 8FuLSxaaaRwLx7qh1L+P1kg4F7FpzCmXn+eYEY8TZvP7/TG40x20LljtbynhLMy+qwLsGQLbS8f
 L0EyD4mmdts+S7mKwFzLni5wpfQXs9kJXyZhNU48JxGY5H9EhW74A6oiiZ8haA6/eBbXdHYYHOc
 ehl8FZ4iT02RWi/xnz/krID13nzI=
X-Received: by 2002:a05:6000:2282:b0:48d:f14a:9188 with SMTP id
 ffacd0b85a97d-48e73851611mr39371636f8f.17.1793872255636; 
 Thu, 05 Nov 2026 01:50:55 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.lan
 ([2001:861:39c2:e340:c87a:3b37:3ef1:5ced])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fe7189883sm9331056f8f.0.2026.11.05.01.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:50:55 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Igor Reznichenko <igor@reznichenko.net>
Cc: airlied@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jesszhan0024@gmail.com,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 4/4] drm/panel: ilitek-ili9488: add the PocketGo S30 panel
Date: Thu,  5 Nov 2026 10:50:45 +0100
Message-ID: <20261105095054.117210-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105040526.26323-1-igor@reznichenko.net>
References: <20261103110524.2812831-5-romain.tisserand@gmail.com>
 <20261105040526.26323-1-igor@reznichenko.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On Wed, Nov 04, 2026 at 08:05:26PM -0800, Igor Reznichenko wrote:
> Minor suggestion: please drop the implication that COLMOD 0x66 causes DSI to
> display at 6bpc; the datasheet doesn't establish that causality.
> I think COLMOD only applies to DPI and DBI, not DSI. The initialization
> sequence can remain unchanged. Non-blocking.

Thanks for the review. Agreed: the commit message should only say that the
init sequence keeps the stock COLMOD value, without claiming an effect on
the DSI path. If a v2 is needed I'll reword it there; otherwise maybe it can
be fixed up when applying.

Romain
