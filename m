Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368ECCA9ECA
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 22:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071D610E0F7;
	Sat, 10 Oct 2026 22:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="CP+SfeK4";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179EF10E136
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 22:44:43 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-67921b515a7so542785d50.2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791672282; cv=none;
 d=google.com; s=arc-20260327;
 b=aV8tC7INRO2wZY8QSyUBTItGC23pJlcmxvDVmU186NI9QpVMkTTiaDl5ciwbx336fa
 Of4rbRqIlqdVJdsgOKn9RuNsKCtk2YX0Q+BYp1XPpe0m0blI+6SGuzTqZ68PksCHHNCy
 7xk+9sP5EhCMSmxC0IOpaGcypYPyliNYCrcK28tevQwe4IzZElJ+5XtOhbthOxD1iwvW
 i9E4P/ZzyOGqRZJnIf/XP5mG+kzXA4W2/NvSxEbuDHLrmPKFMmgWJqni5bPVXFUaDv37
 GlsQUCM7W5fmQd57HtaLJR4tGANR+infBlwMz/tKtYoopueu2CVVoC55s4aa66sk2qxz
 XlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nbb/AEzxbWb1wH79cWu6esvVp0pjm+0ygNJUrbpwYnI=;
 fh=ucjVZTKFYbiMCk/YMfRDDJ0ME1qdAMC9r45Wh82jTRo=;
 b=YZmm5ZXsHdQbNWjbB242CD4cRqX2s70maxciNyCyMic/ag1hhSvgw2vMjgjop1TBcu
 HYgIFuCNWZZBV7uhKdJ5d3bZZ18EciUGz9O3+1dSigzpg5bemAv1dM6N3gB54X+aQyMv
 Cz0N/IFXxgqlBTscHAZVZhPDEtHHdUf6p/kBYbOqHXtnVNbbAJPs9iY4sBUd0bSNwMJi
 bQZK9cJns0zmdGVSo0J11n+9O/b35Gg4wUGC1ZKHdsF37kUsGTRiIhZrdtPGBa/05tMW
 ckTJxPz6K8kLUnF2+1Eyl9DHqV/jvMVRvO8bPyo5RcJhswKT4fB3QbCGyROwIzTe8SO5
 VPsA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1791672282; x=1792277082;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nbb/AEzxbWb1wH79cWu6esvVp0pjm+0ygNJUrbpwYnI=;
 b=CP+SfeK4xjiFAi4HC5YT7SRfRnd4RSIyC9VSzqaMfgyq4jR3uAeq05MjTsfcmkaLek
 6piZRx+arI5qP8ifUEnWy1h7BqF6GrBw8vbzkiTjpnkPuHJLrUeOY6dAXGJkLSugaig2
 juTbjDD36zBZLARQNhXZv+M0h4stKUF/Dpb5anh/81mG/1iSWE+I7u2g1qnH1YFKfVtP
 mv5GeQ1kSBJsr43ecpM40tMfzXLVgKm0L6GGU2eCelBjePRd9jYS5xAT7q4VWaHAi7By
 a4gFukRbu1crKomYwvQHOD4d84sJ6JbVVZmLjm4jQOoZU1+JszCPWxF0C7EBJJvaTJe6
 DkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791672282; x=1792277082;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nbb/AEzxbWb1wH79cWu6esvVp0pjm+0ygNJUrbpwYnI=;
 b=MHZsB263JO0rQhUfrxvgcHnUg2cERpvt2YxI3S2bkcqVzRLlYjvN89etRj0Q6o92gw
 eYB5qzYLUhj642ccALZQQ3HNnquMOSCqddYwEaLprott6v8Cy3ncbV40oc28dvajZmwF
 ZpALI/xDVHDUBZtxHkeIlMQJvU98e6NLsOMchGg1JwlQ2KfErMJo7zDfCtD5EVUmI7qV
 I31oN9xZ+bPf/2irLDS5i6eS0qQlO3H+eol++BNkUcnzv9ULtcqXEoCIzb6yAtHh4EgP
 vk4aW+DSwc0SOZoLxFUalTtUNnqXuT1A+hUtQjzP3xVjjrKTtjSmunJz+so4jtLg5lrZ
 Dqng==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu5gR3SuDBnbdRlC4xzf1Djdz2NmJElDyqzOEqQpDNwl22sNGRQ3iGhOZXM1zVpBp/DC9y5CxM9Mo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKYoyconUiwYTCuniu+i4Ag/oYvY2pXIgOw43KKSZWMcmceObck
 SddoBOVUcy/tGBTzxUj/pf3UqR0tm5L9+gL9V1y/wh2Y4gEiFHBWyYOs9nxlOjxD6Vpc8elgKGS
 Lc3vaELtGnW48PigrrLfdGVe9FZniUWQ=
X-Gm-Gg: AYBFou22AvxVIHGx/4qQbLjeRTe9mADCpjzPCHGzn34Ig9taRa9TD4ECqx8hh/8nWX0
 AjaWBPtf/7ZhJh48lX1oE9Fgy8wpTd5mnolTlwinJFLC4VEQOVFcQz4gE9Hzg06HkffrIsl4VeV
 5wA5ZQ4PhXuZmZWOEXL45Z4+aoPylbnDJ2GaS6euIU2AAkrLK4vMIziaDmsgWLla/Ng8/Tl8X2I
 Gwd64fD19F/jNxx2PVlXnHo/Hr8jLwvB+p6p8v9tHnA/Mu+dlCw742/ztYJNht6md5JPpsC/5hb
 hh9JgB+8RU/5P3gp11KJppdXgUE/CUryQrYT5L53SeBpc4tEq2ogGaH+L2PJ/GMuVMpMwQKWaWR
 d3upJ4RhfLgvV
X-Received: by 2002:a05:690e:4144:b0:676:8c58:c607 with SMTP id
 956f58d0204a3-6793606970emr2386943d50.27.1791672281835; Sat, 10 Oct 2026
 15:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-2-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-2-1835d4966da3@radxa.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 11 Oct 2026 00:44:31 +0200
X-Gm-Features: AclHuK9SzxfYbidbXHkCFy5EESOculWVRi3ikF-IkFS2nFcOSocjCQZtavNl1aY
Message-ID: <CAFBinCDtwrEpLY7W-VKn=ekCPbwAeq63nDX9y-nuV_TviHFJAA@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] drm/connector: Drop early state allocation for
 max bpc registration
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, dragon@radxa.com, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 9, 2026 at 5:17=E2=80=AFAM Xilin Wu <sophon@radxa.com> wrote:
>
> The max bpc property can now be attached before connector state exists,
> and the atomic state helper restores its default when creating state.
> Remove the early state allocation that was only needed to satisfy the
> old property attachment requirement in the HDMI connector helper, Meson
> and DW HDMI.
>
> Update the HDMI connector tests to check bit-depth defaults after the
> normal mode configuration reset, and check that property registration
> itself no longer allocates state.
>
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
