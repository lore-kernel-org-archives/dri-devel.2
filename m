Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC68C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F84E10E062;
	Tue, 18 Aug 2026 19:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rszPYy7X";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8D410E062
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 19:34:47 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so240513a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 12:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787081686; cv=none;
 d=google.com; s=arc-20260327;
 b=rE++7+NeWDQkF/3tgNF9r6LRrc5uErYeLprPXxGh3xDR8YGMIl7ygsST+xveYrSJJ9
 PGwbRODt2MEK1yQw7Ykcz5z1VxOoL20KojKtMUZB+F2ON7+aFNcGDdC5ZPHVYV0Nktmw
 MiSYWLtWdrBotqDxrDbiabCizJRitgEUdin2QeFewBoQYoqeZ/iqmH8TiIkgT34HSfxh
 LLnedGk8s74fcw5tHJgvFj9rfKKBzYiJuGswqnjmHR/Gl75JCIoqbp2P4dZ0D7As7X7V
 pBksTzvncl0Nme1Nx9xok+MjOClcdUJgoPUF61rUxjOxIX1O0jtNLEd5a9bBpomGe2YL
 HyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=khxcS0giWc30dF3EjL+k9ObGgfjXp61CH86spT9PE1Y=;
 fh=N1xQRKhG+rUDA6PKebN3xNHdadiWzFLf2lDFxETBt7g=;
 b=YYHTCLGoNBcul2v3UGI9A2n7y7OkeA6EbIQ+1Q1k9iGPVRy4Y7hqip5YXXME77rlCC
 nYa23qXZedUWSiNBFB3stiOsChdaEaqgG3byg9Il8JtcCUAYST1LiEY814/Ow306ZdZl
 fJfi6HTWI1QCfUw7j3KqCayOUrVzJoDZz19anGs7+ioMWTWRztp82Boi0OhRmeM4QWFt
 44rDX0EE50CIA02M682OdsvNl502NI91eC7utLqRviCgp/VtEBg5ru+4U7pX14Hu3QLq
 i8sM0bBkh/HEoG6p9O99VHb2Edqat2Hpfa7MzlinZB+NAOJ18krO+Uja8qpXBPjX8eXb
 PO9w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787081686; x=1787686486; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=khxcS0giWc30dF3EjL+k9ObGgfjXp61CH86spT9PE1Y=;
 b=rszPYy7XGxA1wTxD0h2zbCZKaM8/btrVDolx3E/J3rsH7Cz7eYNsuHf2gWe+y0OshV
 9qk0OMdts8vEJaHEqZK1ejTWZMbvm0ieZLwGIOEzWn3myL26HLPzOrf2A27YzJPR55eL
 iderQDt7yUy81n2kLicc2Rg8JZHBxUNMctUKlqu0ZwenqhprHs9+oJuMt2JSZI/WRW1Y
 1goiclX+KmqEoK+X2M0evul5q2R/05sLqY4Yi3GnwOUdrxQ/AdNAVbRwghvVpIQNruQv
 GJOVWz64xSxrtMX0aunh1tj4pVZun88wweYUMB3uL92N30r393lf2y0n5jL80zrGNKnt
 xfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081686; x=1787686486;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=khxcS0giWc30dF3EjL+k9ObGgfjXp61CH86spT9PE1Y=;
 b=L2wmosyYBx/a15xXbbbSQe5VxNAeDOsaUTPxiWLHKiF7qj7sr2tXObacayX/CGlW6M
 yTJcL55UQ6QpHOpco6eHa0ACyKBx8ZKckLtZK7uh+cKVu/PWzliTfugLpMc0tXZRNQuG
 27d3m/WaEbEj2g2+/Ln79iQkQE8P975ysnGLUmF09fwksXXfbtZ+sq5rZuDA1Zzq9aWP
 50kRIwU55LMwY7Ey8se2VFdAviDRAAND7+2QWBYwHZRz9sMhRLDYASBZJDcWMhk/cnkS
 uH0ewRbtzcGad0wHnsiPJpz61PZh4+JIqAs8MLRH7s0dLVvN0vXkfIkWZ1ANukAYrdYR
 lFTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIulTg/rTZGWgy7VTRM2g3+RsEjZpanWCg1RNYOPWXVO3q2o0oXKs3Yqjwe7MKq89R9rMODLDqd+s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywg+V3zmRTgkkbUP9yhH0VBHKrMQhgb9MdJWK88IHe2sfsTgs1y
 OBDV2eNb9C0wh5WM6iAIuR1ypJb+W6CqGYPU1iIOaj8Q9zpBtDd+S7WkEZx0fkek11Qb1VcX9D8
 TfJTvMQKA/zdKzKruMNGyf7jWyPwVh2Y=
X-Gm-Gg: AR+sD13IQVo+x3J/aiMLJpIz8J7cedQLIDVPDpnX4OIg2Di3q+uKZVaKTdiu6t/Qxoe
 SbxbAW388hnEC2k6c+TpItJEEAXEF+L/WJf/tgSBMmBwuLqd7mJ8R0MrJFKwS89I1RL9etVexvm
 E6zCKkv69cNi4qPYvRXVF0iNfoifEVC/15sDIHzc0ylExFC87iiVzwHwAL2GLu1etXHzoioLMGj
 p1nPbxct/fzni/jcAx/QWBhDu302L3z8hp+y7NQr6A4tqUBDwZvNvJJCopckDjDmakOc/3pPVTm
 7vHsMpxA13dZs7HydMUidwKsCItvXod/3qdt/2MakIeGnzMVVYAfEc1/yXgITVSllX1xN7vSVJe
 hVlI=
X-Received: by 2002:a4a:ee12:0:b0:6b0:fd2d:d338 with SMTP id
 006d021491bc7-6b11e3a24edmr9098624eaf.36.1787081686291; Tue, 18 Aug 2026
 12:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-6-amit.barzilai22@gmail.com>
 <aoQbR8lBza8kmar0@ashevche-desk.local>
In-Reply-To: <aoQbR8lBza8kmar0@ashevche-desk.local>
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Tue, 18 Aug 2026 22:34:35 +0300
X-Gm-Features: AUfX_mwtc59HriMGQNsEeKAgTrbC_8hMlc51GbBF3AXsUidCRTon9Oagb6mSMZQ
Message-ID: <CAOEgbEqhKAECWuptksR+02eF0jPW-XF8AP+2EqZhPk6OZC8JfQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] drm/ssd130x: Implement ssd130x_write_cmd() on top
 of ssd130x_write_cmds()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 18, 2026 at 11:43=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > +     if (drm_WARN_ON(&ssd130x->drm, count > ARRAY_SIZE(buf)))
>
> For byte arrays sizeof() is sufficient.

Ok, I'll change it for v5.

--=20
Thanks,
Amit
