Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D8010F3DE2
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 12:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D0210E4E8;
	Sat, 28 Mar 2026 12:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c6p5lNoK";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14AB910E4E8
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 12:01:21 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so3529307a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 05:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774699279; cv=none;
 d=google.com; s=arc-20240605;
 b=KWmSjcgXAzXvQNYgCy4EizmqY8pzygkwut/7pMuapvxs1LF8tiOGPKH1AV9MOMBLkO
 DF0jK8oVTGZkGnxjg8lTvxS6L+0h7HU290TTB5SQL9JRaBIDuGS2Ie8JoLoTHI6Q5r1b
 F6bvykB7w9JeRlcjhiyEvaZY9eHZVbZRcP04APRTfS8YvzGdXOPntD39pX4JUQBuR80B
 aplTSxYzwOWF4lknE2drbOy8wuVge00aaMbfql+rHx+GXtCCIGvIwvcRNu6zBP77jY+r
 HYE6qCm5waejaPlbFBqcyz1pE6tqAi4ljDLmbbvREnlTgFj4ap/YBb8fniVjYIqOd/em
 SxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=s1oVyIN5EVd1iMM6FpwxmeiFg5TxagYRaSc9zMn3yVs=;
 fh=rdVGboUKQTe2PQPC07+N7izNoR5Mh+KRwIz2BQB2NMY=;
 b=WqDDm12kEjdJsTHvnfhGVDH9YWoy0zQNR6CK3dkD7L0HX3Zlm4aqQWubg6imCHiaxB
 5Yrp0cgp3nEYEIM7J6mKpTqw8YFd8jyKQef+a8FX4pqdbJI4I6Zm+U4H2bhOQRHIre6i
 74RVEIAtX+UoxQIRvZqKMVqGVciDNf63LTrnzXSVv9MYcnjDNpR2dakZS5U63lsAX15S
 6fuA9dMTyAqCBNpyJMeXUcbm/MxIjnLtw+RN4mP5IDoz1f/T7pLB4liygH5/PhZMDP6M
 QTsaAGWv+dquzLPY9rt3kYUQU54VIfjsnMVT813c3nWtmFgao4+H4E+anJy0HbStujeP
 6GWg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774699279; x=1775304079; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=s1oVyIN5EVd1iMM6FpwxmeiFg5TxagYRaSc9zMn3yVs=;
 b=c6p5lNoKJ/7QRidd6NEaPoHA00qbKNqjprOME90aNg3pT6sILU8bYa+4vayG/OTxKZ
 lljWegUIsZHNXYD9VAjqBFVck6NlnI7A7v1bhUaPwUClYSwQoH9Wm9LPTa1xF+mDeFVg
 7OKwBpLJuNz5oQJ8Y99n9HWTz1tr3SFYDE1BNw/nmV+k2Gic5256R0uJKGa1iGAEeL6l
 ABRSF3ixetlyUWW1QsBZPDGARu1GuyYRpJlKYIiHEiqiTZuexde//cwr1+6ASe+jmH61
 g3AKi56IxLMC9mZGojdy6HEOjCdoYR3Lh5nf2PA4S2IKwFUTjnplCpWhx0cEYFXWq0R9
 QExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774699279; x=1775304079;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1oVyIN5EVd1iMM6FpwxmeiFg5TxagYRaSc9zMn3yVs=;
 b=SuowT4Cp3l7UVuqMybLcQd3OzV6bQXHEogjM+w6NOCfoluilhjuYKd02FJZGV61Iho
 2dha+a0rVRFiQU5SLlCQhKp4ECuwUrNNfzcNU2VrsozJQKUSM+xaHzBSpKoW+UB9fEFd
 4dNIE7VKKi2gFznHN5FcSvdNN/HMZnhJK+avMm3+/D2OcGE6RBfD20Xig01PzXF5tGBd
 qtvZq49WSFFrVxOwnyclGGK1GJ85FbhoCQOGsVEWz7f0MzJieXUvGh6r6C4vdRIz/XDc
 v9TT7xtLly9KI6LvbNv/lucbDHQzvyikBoUOnzPwGHg6PdYs4tzbfocKptfytxBY7+8+
 4Wxw==
X-Gm-Message-State: AOJu0Yyi1YGBTTKj9T/I+esFomOlnZKmKhsMJknNxHx5l0txvbd8TKjd
 LLN3th8t35Sg+Y/c08UMOvYWBFY7tpQMZCGj2Pbvzw4SlC0oQ9YD7ask2sNIV3NnKETZVhgYymB
 lgSeGkTgDZzlEqVs4VoUkHJeIPaTLrarkIGRR
X-Gm-Gg: ATEYQzwu8sI2tG1FQHqdLzeSj26okh9Pb/FeafbJRAO0PWYVQ0cITQFthSXSBNCjzUR
 ECeWZ3yfbkDS/DBBaXkFN9PIExaU7Qt8z48GZ+TPnlqLaYV19geWmfzq2ev047Ie1vEOjJjNF4+
 U2+EICqBgOzZYaOLyKIr3sQAyhlpPlX9+BvXi1z6ip57a2erbRbYKI7X+YZ+p3LypaICKR5Zoo6
 BNFrxLJ/PvujDR0ODuj89P8dlbDoWtiU+BXGfAtdpuuXD+DJX7joIOjv4+DHTm34QCyafA3FLYI
 ElbGaqMli8q4YtwxvzLG84HvZ+a8y9HblqNAxlan
X-Received: by 2002:a05:6402:1471:b0:669:b5be:1219 with SMTP id
 4fb4d7f45d1cf-66b28b565cfmr4058114a12.15.1774699278994; Sat, 28 Mar 2026
 05:01:18 -0700 (PDT)
MIME-Version: 1.0
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Date: Sat, 28 Mar 2026 17:38:52 +0530
X-Gm-Features: AQROBzB3V5NabPAdhIxXiE-rKWWef70wUew3LWPvVgyQ4uNg0b89eK98rw0y-U4
Message-ID: <CAHxc4buWn76Y=0_qzOzu2bcZL=Xc4F1vr0_uewjbKHYUoOCcdg@mail.gmail.com>
Subject: panic logo alignment on user's panic screen
To: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

Hello everyone,

Thank you all for improving and enhancing the DRM subsystem.

I am new to Linux kernel development. So on all panic screens, we
display either the Tux Ascii art or mono logo at the top left corner.
On user's panic screen (when DRM_PANIC_SCREEN = user), could we
display them at the top center instead? I think it will make things
more aligned on this screen unless we are trying to achieve a
universal UI for all panic screens.

Best regards,
Dileep Sankhla
