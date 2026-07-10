Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC657C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538F810E13B;
	Fri, 10 Jul 2026 05:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="bHSA1A5r";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6330610E141
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 05:52:05 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cc84e77e78so4039855ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 22:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783662725; cv=none;
 d=google.com; s=arc-20260327;
 b=f/H3VSNkBW6LQffG9p3haGNGGzQ7dQ0WV9EYkKfMjc1bYBUycH1JBpKhLcVzoPKV1I
 WsUw+R/vZZKOLlq9N83cKW+sAcz1LD2VXRhBMgvQTg4k4W9NbPfC0zO6Tk6QFUunsoHz
 8nbnVyt8nfqDGL8Sluh7xY7tK9YyQ7KJAoWIO7N/nYxh+D3tdYEJ52P3twU7OpNP/Y/M
 9zUwaTWRXdHDXQy4AMxBOHQqvk1b+E5DubYzyr8uzjv9qHgxrLK+ApjBYcX8eMTPRyfj
 Gobauq2f86hXYTUj+cY256HdYHWu/BcnRoyEGBFlPhUwvJus1QD9bIhaEGzDtsTpJQlq
 +voQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nM5Txl5PUCIYtmpQVuxaJ2s6Fzf95yv2bzIgjxFh4kY=;
 fh=g4YpCByELDBB/6+pv6Lm5ZQeUWNzZtS1DBehWhB7yvc=;
 b=KkZu7UE2AaF0qW12o6Qc0RwjkXcgtFvrwT9VI9pCvpHvPmw8BHHsbU4rW2vX4Uk6Bs
 x150qDy49vKLxYGH64QZgHfj+E5y8kxYZgD5+DGpCKJFS50U23beN2CIb9YoR6UrlgKh
 stldWgrtsdt5cyuRHHP7OItOYpHKrVu2FXSunkTlKj8R7fC6m1w5fYtqXp3Wjrr9/TJy
 Y2TOn8E7OUa35VL2FZA3vk7zrrQ5l6BcgcUBeGk71IAQPdAyMFA5yOQG8gTCSs1FPn8v
 q0VTwd3WDC/P/Q60sXbu9e7qQnX5/EoC5tG16WZk0o2OlQ9RGLjxAONjBqvFHcHSuW1M
 eCfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1783662725; x=1784267525;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nM5Txl5PUCIYtmpQVuxaJ2s6Fzf95yv2bzIgjxFh4kY=;
 b=bHSA1A5r3+JBebGAWNR4EL/16nkZzHBArpI0n7r/O72cHcznGc8wU0iFSStKainEY+
 fgsoyU9Yff+GFNXfssQYdLtUupQ//Ml55tX6oOsz3qoYc+t9fTMwmt+9/o9jiQbJ0CBv
 riFRWcK7Si52VR5qaXk6wL0xc5qSJ7RNZ0cmzGS0cQK5wxfxJsJwRZBJfoMp6HIpLdgI
 FYtCSudUxzuB+gXoLAfZgI6GRWJFYKrEYWQ1orBJs5DjTUS0Os6COClay+IDnc7xzImq
 9TRDnnHwAzc8LW+XmzZ88VMRiKmHgIjJHDgTUXAjfPisPvUnJ1M88C49TuTTUZeTjGty
 2UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662725; x=1784267525;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nM5Txl5PUCIYtmpQVuxaJ2s6Fzf95yv2bzIgjxFh4kY=;
 b=euTboLwddn3veWtUKX55jKuH/b4BdSRxBQOReOEkpVXw5r67NcoPRxbkhAzxEDOZTq
 Q1wBEI2zwDCF7p2D6+O2onUL0D+fmB5EzkWy+JrhcEWmp6+bLG7b1FWSA0dMmUmTl/lg
 +ZAC4Di5vUqQNirBRP9B0cc1bt94AAo89f9y1/8lxCf1Ke1FPTeHRDdHYd+iVZfhwZuJ
 ljTNwtJ9DXKj5PMRoXp9iRytwmNYLpmkJ5eGSk585RWNJPIAJSOcQZmOUPLusNlDqWVV
 LNvxUFqtoVxrmDwqk5bNEyQFMJqh7Z2RdEbmtTpKvUYgRqX7Sc0+T86vGob+uTBS8sYi
 jy9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpi4emLTDDRiOVoNfFUBHVi8q978xCAQI0u2Cd0Yi6TNzYp+o7//mRZw/9VJb/zBKqDIN4W/bLlph4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGquLCJxP5GsSqeR61d++wbEzvFXQFxWU4MpaZccfWM02HFn8Z
 j4NsHV3eo2HpwM/oat8blPWXJ+6BI5mBiJgyTHWf9VByOKQVPtuRwwEvSeA2Vls9eGepQl1KKSN
 8yd9hMPQeGvNlytp7I/95VYRfg4UVkc8=
X-Gm-Gg: AfdE7cmMMO9uXrx5x3yip9ZBLyJBuIePt/JkjPbXLwbZWaVZkLmU2XWBlO5uL2A+cKg
 svSGEl5EaCmnF04X9xBm+MDvpB+aY3opzdCSybnekXgQkZvgDaHwwJ3kyPpVZA6G1NLlKObpMIa
 0Zm2UKAeojvr32UY4Jif1VzVH7kn8n91Pkw8xFV+fHWYgF6ngNC/kzA1Em+1wC3zukYwhltQ04C
 vxN/HvNooUwE85zsh3k3bzmo7lhWZQ19Na5II0PW4Ji3FtVOL+O1cSWR+WU4aAYk1t64ajf67C7
 a0ob7frCAHRAV9CLG17SUxBM8P3E7Q==
X-Received: by 2002:a17:902:cec2:b0:2ca:ea56:7a58 with SMTP id
 d9443c01a7336-2ccea58039amr108040895ad.37.1783662724844; Thu, 09 Jul 2026
 22:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-23-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-23-302d986fe5f0@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 10 Jul 2026 07:51:53 +0200
X-Gm-Features: AUfX_mw7meUv4qkFmsOwX-oOv3_0V3pYNleMU-cUI1ei3foVYgmTF1K4dDloyU0
Message-ID: <CAFBinCBZ4JxY=rRLM+m780VjceNgCKUObuwBDYzS-KJmuqsDeQ@mail.gmail.com>
Subject: Re: [PATCH 23/60] drm/meson: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, jbrunet@baylibre.com, khilman@baylibre.com, 
 linux-amlogic@lists.infradead.org
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

On Thu, Jul 9, 2026 at 1:51=E2=80=AFPM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> The plane only initializes a pristine state in its reset hook
> using drm_atomic_helper_plane_reset(), which is equivalent to what
> atomic_create_state expects. Convert to it.
[...]
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
