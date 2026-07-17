Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33D4C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E98F10E0CD;
	Fri, 17 Jul 2026 23:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="STfjdVr3";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B32910E0CD
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 23:59:27 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so849699366b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1784332766; x=1784937566;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/YCTyaiEEXOfgMvR2Jnwuutrbo3fF6Sal7ablxv3YCI=;
 b=STfjdVr3Oh1g2n+vZECgL40VEg84tdvWGTikFz/rKhqLhvc0WADTjMMwp518dnghCr
 wU35ise2+t1RNnSsN1tn3SR9oIgHpuREWfG8g8/l6Ym0En3ngN+XIBuR7+TdEboqBVQH
 /TfXiYkVnkJT8zsYreIoYF4Elg5qpAuNM8vUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784332766; x=1784937566;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/YCTyaiEEXOfgMvR2Jnwuutrbo3fF6Sal7ablxv3YCI=;
 b=jvfPBENS8Hz2OUYzi3Stil/2qPLCw4EmlPGAkYMfERJaoSWxrTKLKF0jhnzb75x9Xa
 815Q1tY6aYcPDG5LvPMA83ZKxi3FL16wCguh8iztDhQf3sRlnYDrrIbNzWVtZ+YXvDvi
 VfokYbWUwLcJSryuZ6EB4YrIXQYY/idPjuTT0i5wRqzGiwNrMv6thsxQFYfS7Wicq8E+
 tv2sZbsTeO/IupR3uHSPU2K32r/yVGFEcQe0nm6BPTQvDNqEaQipZio9+YvX5AE3F1xA
 azO3rHV4HbCDL+/Vu5kHd393rHeKK7Mr9Vu+lJ20gJkQaPgMdznQZ/J0I29xODE10bAE
 slxg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4sjJG1dz7JQesWdNnty3KCkH62KerxpSKy6YjS1dv4qd32LHJ35+uCsczbbY0czEcaJrSJXIK68s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxR9BEi34hwTc6iL/pNlyaY5YL/auKizXJXNL6+1mnJw+60CXl4
 exNfGj6ZtPD9oXCpiegK8vLJlxkfuSvE8Djz2e1TgWIkQM+PgBrTyy7a2UXE7RlV/YKhrFjhm0T
 fpp5ASfg=
X-Gm-Gg: AfdE7clkST8dMA65sJGqOLzbf2S0J+vwB4kXoTTVnG/mzUErLHjrMnyAwnyGtY/kuFK
 JcjSCZyIeIHuJ5FsaIakENKW9yoAUaHpPDa/vpcCcC3Dt3o0uI7SG2crgqzq3HLOPT0+UR/uaMH
 B70OH9ecOL6Z435KVhhXvdR9GtQuF/lOcSbCpMLq0mprIaIeMcUaXzaaLkP7+MHd6l5CoXo+Lwm
 sB3Via/Hpy1VIH99U0K/KolOnNI/K9dnFT9i9FqlkkX9v9q6hVKSQuKS6cPmNFNJRZ9u3l/16BJ
 d42Jrq672oRc3dZM85ulzdCyC0uIKXUO+h/MKAH4nNz+wcWc+fO6Epmbr9TubMJioPjH6HYQH/g
 T8t2IKSJePFPN9X6f5ZH9hgLfbVwIbg2DqrN0b/8BXkFlpDaNHegPK1RaeQ6OyKin0X/YJk/6WA
 VhqXkld/WlmFrQAJPqVoCDaBBlkMu+dmS6Q4n2ZqO7MQmlcOEn+Gg=
X-Received: by 2002:a17:906:1005:20b0:c12:6bcc:a3d6 with SMTP id
 a640c23a62f3a-c16b4854d66mr146973166b.54.1784332766026; 
 Fri, 17 Jul 2026 16:59:26 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1705afecc3sm144694966b.24.2026.07.17.16.59.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 16:59:25 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso12425237a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 16:59:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoLzZ6TEQNLtw5X4zP2w83IfIkf5CQe310miPrOhxICHFVrCxyHQTpc7x6Ies9G9sti+TqDmaQaW8k=@lists.freedesktop.org
X-Received: by 2002:a17:907:e90:b0:c16:209f:d48e with SMTP id
 a640c23a62f3a-c16b477c680mr217497366b.30.1784332765133; Fri, 17 Jul 2026
 16:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tw1j=WYsQjs8Empd1G0CorM-YHFDD87coJSBSXfxOOoXA@mail.gmail.com>
 <CAPM=9tyHM7Vz2SyWz03w=+9Jx2rqnCoGR9FX18VR9krkrEwzzQ@mail.gmail.com>
In-Reply-To: <CAPM=9tyHM7Vz2SyWz03w=+9Jx2rqnCoGR9FX18VR9krkrEwzzQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Jul 2026 16:59:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRiyc16yrWJK=AKrFBNh1E5Nh5hsVZz8M2DVNf1qOc-w@mail.gmail.com>
X-Gm-Features: AUfX_mzreviCXDpeil84A0rFj75QrxarkTcULUKY7yZAw1MgZdgMHh96-rKyRJo
Message-ID: <CAHk-=wjRiyc16yrWJK=AKrFBNh1E5Nh5hsVZz8M2DVNf1qOc-w@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 7.2-rc4
To: Dave Airlie <airlied@gmail.com>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
 LKML <linux-kernel@vger.kernel.org>
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

On Fri, 17 Jul 2026 at 16:21, Dave Airlie <airlied@gmail.com> wrote:
>
> Please disregard this one, and use the one with the amdgpu ones in it.

I had already pulled the previous one..

But since I had then forgotten to push it out, I undid that pull and
pulled the new one instead...

              Linus
