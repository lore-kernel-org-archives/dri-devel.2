Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D910A88E7
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C7910EB06;
	Thu, 26 Mar 2026 16:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="MCJYhDzs";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4EA10EB06
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:40:46 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-89cd8596724so11787626d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543245; cv=none;
 d=google.com; s=arc-20240605;
 b=jlREv+OTIuW7NMouivxTCRXvxmcbx6LTM8hXk6lvRnhCLPWYqgbZwoFkYRV17f5Z4W
 5lkl3GHw7VecIaxagE0aoYFBiuXpIjVUkYEMvWrXd+HRITgJTeO66X09Ov+VNuZQPjHS
 TlaY5Y/t1zyUXFA3LIi8H+2Xb4AbdCGtU3Yej1FfzjRCwVQSw1HVzvvvo8Nl/T1ssFwu
 s/A0XznIL8vS2uRix3f/hdOJ+8+00uzqnG+w0W/TYA1YencGvXdNjLe5nX7c1MM9IHCw
 OJ0vTfsEptQ/9SoZgru2q5BLtM1aPyzHUZb9UT2lmRAmlPviXrFJE6I8A5ul7RLU5PBC
 +Inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lMVh41/flJhHXUmskY74HI0cHDnV8XVUzcIyI3Tc5Ws=;
 fh=X+PaPdTQ8oltzeCx1VIG5teuR/Hb33uPe2VX5/1ytWc=;
 b=NiitVGtCcaLYYhHcrcJ+dXHb59APubdyQfgkmCQrNg+iIlMpo8jZCBd8P1/0QxCfmU
 wY0vBijgneUJxWUM9ovcavDNqxEua6Rhop3ovWbRRzetAII5vrbqG0GdI1xabNmIh0CC
 RUakFttrKB8m5zyJLqG64K9etWsIswbM7RZ1lHJMNIwq6MOfTqU7amKS4RvmEAuA6BO9
 JYQSAmLh3A7mtqkhoR0gk2Pp+xSXw045r3C1my/H2MD7HbgGXI5YtpXM35k1mCIs1B7l
 3ABiI8CcKb8zbriAanc6vp7wGn5pv8/JpqUAhaSle+AqZ4ViMbfVb45/d7w+EyTB5E8b
 kzsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1774543245; x=1775148045;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMVh41/flJhHXUmskY74HI0cHDnV8XVUzcIyI3Tc5Ws=;
 b=MCJYhDzsjUS7q93aPySKVHiMstf57KpACgEHMwYr8O+hhiWx1LjmSUZj+mmkGvO+JZ
 uh3JmZ3gdTMh52f1MX+wQ+kVDUvulleFVO6Neu/LReWUBekfgtpwNeaa5MWLDXnIF/M+
 703WwVlTz9uJNjdfOfIKKZwpO0aTO3Dz0VMs4CV5XabEjECNeF1Cpslxoiw1bCh917I2
 1k8Ejk9i9wjFTxD++koj4uGjmjKwHrMjcdYXD02+/znfu24KpLfzUobkXJd+7iBs5/oa
 LuAjmUPwU3EJbWbqwO03YaHg3wrznNBOWJ4t9gEfVAj+ZxFhqmzZx6WDLDvfD+8i8wkr
 dD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774543245; x=1775148045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lMVh41/flJhHXUmskY74HI0cHDnV8XVUzcIyI3Tc5Ws=;
 b=j99gh4OmSmOfhaDPjF8QVAVFjZEx7iF3HT9OlnUv6YrkkjBiHZlOW/mdufz6/YV7Kc
 WQjzlVOn0XRvpTH9AQUXEE6cJgvkxDTETDCyEKgDc/vCFTycOFnyoPJ7bJWGsORs9nhi
 VTSpdvXSq8XTwvYB51Ca4ZuFhtsBkaF8mUduJz8zOPHCNnId5kgQUziy6eXtaMbzXhlq
 dk/7XxdzgbeqT0+BjZnEcnMcoSN67SQoMO8UHBDaw24qtzamm8QWKKORV/Jmn0nx2DBa
 C9bwoWEe6zcmIwrYJq/dqRpB9uzA/kK5JUnNvBSip4wjf87dWSVOWyoHRcWs1UB2ofdR
 jSPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2NZyNbGB8+z3JSyNmaPtQ75w6sPWQyUoZ7/bpQA5qo779ndSAjLqmN2Y2q+voZ16vm9uLk0Z+oWE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywxk7Es2URpWoFB1XeMeiVr1N1CSCG5KqmBDMALG69FlHQ5v4iu
 LozbtRt8Q+UosjmHPylCMhJp26s7hjiQmR7iIiDBqT5iOIlhINSiycXZvzX+hqeyItlsspLA3nK
 oxmMT/UPBoGl1n/H0SCgJ8kV5FV1fR6kaEJzAQXt2ww==
X-Gm-Gg: ATEYQzx7h/Tv9F9FEDjt3RO4M/QYySxCxni0eUhNSiUfgiJ90+Y9n5lZLGODWKgquGa
 cAroR/Awq7C9yz9r2zVzZTJSUoK1BW7mZAwtNd6AkRuopmmLUqEfAsEBZGYO8nazadsBIwvCwI4
 SMRwVeM03G5KT6WTMRqh6927BoIo/1xIj73kb5DQC1lYhAnXkCxYYXoiEwBLr9r0HoJo7mANmiz
 yFscwmV+KG8tJKdF8E9yyn6/0gWbVFJbvcQxtG6EXIiVYQcaFLXk0cozgGnlkGEXcvZstXfq2ZX
 RuPqyE8=
X-Received: by 2002:a05:6214:d6f:b0:89c:866d:15c9 with SMTP id
 6a1803df08f44-89cc4b07bc2mr122325186d6.56.1774543244239; Thu, 26 Mar 2026
 09:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-color-format-v11-0-605559af4fb4@collabora.com>
 <20260325-neat-elegant-raven-ebc9ab@houat> <acPA60Ci3n_t__xF@intel.com>
 <3979783.tdWV9SEqCh@workhorse>
In-Reply-To: <3979783.tdWV9SEqCh@workhorse>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 26 Mar 2026 16:40:32 +0000
X-Gm-Features: AQROBzB2J1rLcK9oOY95uN7pO5Y8iJWro7kBrTyJSKQV06IZlwAC79afqJRLPi8
Message-ID: <CAPj87rMpu-ZL45_uNPcZe3gu8Eqn2ALp3r0zRgghvT08-6RGVg@mail.gmail.com>
Subject: Re: [PATCH v11 03/22] drm: Add new general DRM property "color format"
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Werner Sembach <wse@tuxedocomputers.com>, Andri Yngvason <andri@yngvason.is>, 
 Marius Vlad <marius.vlad@collabora.com>
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

Hi there,

On Thu, 26 Mar 2026 at 12:44, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> On Wednesday, 25 March 2026 12:03:07 Central European Standard Time Ville=
 Syrj=C3=A4l=C3=A4 wrote:
> > But I'm not really concerned about documenting struct members.
> > What I'm talking about is the *uapi* docs. Surely userspace
> > will want to know what the new property actually does so the
> > uapi needs to be documented properly. And down the line some
> > new driver might also implement the wrong behaviour if there
> > is no clear specification.
> >
> > So I'm thinking (or perhaps hoping) the rule might be something like:
> > - YCbCr limited range
> > - RGB full range if "Broadcast RGB" property is not present
> > - RGB full or limited range based on the "Broadcast RGB" property
> >   if it's present
> >
> > I think the "Broadcast RGB" property itself might also be lacking
> > proper uapi docs, so that may need to be remedied as well.
>
> Alright, so in v12 I'll do the following:
>
> - Add a line to all YCBCR connector formats that specifies they're
>   limited range as long as Broadcast RGB is limited. Whether it's limited
>   range when Broadcast RGB is full is purposefully left undefined.
>   In the future, we can expand this to state they're limited range by
>   default unless some other property is set. If we're not re-using
>   Broadcast RGB for that, this will work out fine, because users who
>   don't know about the eventual new property won't have this behaviour
>   changed. If we do re-use "Broadcast RGB" for that, then only users
>   relying on things we explicitly left undefined will get surprise
>   full range YCBCR.
> - Add a line to the RGB connector format that specifies its range
>   depends on the "Broadcast RGB" property
>
> This is a bit of a mess, because it's entirely reasonable that a
> future YCBCR range property would want to default to full range
> so that users get the most color out of their monitors. But with
> this description of the connector color formats, we can't do that.
>
> If there are alternate suggestions, I'm open for them. We can't
> really rename "Broadcast RGB" but if I had a time machine, that'd
> be my first choice.

'Broadcast RGB' isn't what you want even if it could handle YUV, since
it also sets up colour transforms to modify the data ... so we need a
separate, orthogonal, property which only affects the HDMI infoframe,
rather than applying any transforms.

Cheers,
Daniel
