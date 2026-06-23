Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EBBCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2DE10EC80;
	Tue, 23 Jun 2026 20:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="rXhCXYqo";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F94C10EC80
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:11:55 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2c7c684353dso1935945ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245515; cv=none;
 d=google.com; s=arc-20240605;
 b=XSrQvGzgu9zNDd+UKE8o2/2EG2pDJwRW7XXzazKthnYj9iTdm164r3SnGSR60+3xEb
 usm1SG12G9qIPYt2Bl4nNGmA4TpYUmBUL2nCeuvt+Cpk+l3jp+bHMjyf8VopS6zDVhVl
 xDM7on2GfU+kriTVTLWzLdkARuzB6zewRr9fsGe9WG9mYvBH+aBnEtNhZraJcTgbwhJT
 VFz4j3Wp7+UxyhLV+VOkorPskN0Xr+a/dwVMW/BnVU8xqg7wdflqqbmj20a7B2BAqZiH
 5EyZUt1bn60/Q6DaDwkg6WxyaKQSjix8wPEWSq5LVZEMDgIkW4TURMe42fNjpK3yYo48
 kLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 fh=nshl6UmU7wcpOqGWKdyX3SsN0cHdVO1TtOc3eFugse4=;
 b=OQe6v/TFZcVPq1lcd5fbqId2VDP7yIAvpP0XgnemaC96GHy2H0xtKnxK3CCN23Xni3
 9IRw+IvQGksrl5QU6w/fRkbJclrKNdsrRugh8WQ0/RVI8S8v8yAzE9b1zvr4/5eaU6gB
 8riEYLZs4/cktf89/iWG9uhC1RTaGiSNw7oy8TNbXocDFrb5F1jIYezhnN02emm4WWjD
 hGrs5FfZ7SKmzLuBjmLI5pnCOXnTUAOzFoIgNRgR0YUMYTCMn5QpDDntuN84g8EFB0mQ
 tavYnlXccacER8JEgIv7rTbEGCIFUBWpz9CI9DJFF8+/g3tim5aM0cBtL28HyMkEts8W
 OGlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1782245515; x=1782850315;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 b=rXhCXYqoEGHUtn21nspFhEGqcTraGjvd30szLf2JUa6XUzel3lFWRjcgHQLHCf8G5S
 yfirYTZ/HslYNOQKuZ6xtXXTTBj0wleEieORYRLIUTv2WJhpXg9O3Cfu3t3y3XpZb090
 h+mfjU9keEl/By8r8jbnKR6vRYj7bvu/KuyEYML1txIzLRT34b66OGklY5FA9POcUoVE
 RwE+oC7hlObhom781c8tGnd+H9sPhANmO07rec5f3CKANEWholcdMziVDE2KXTWyJTUt
 HVXajCtgDH0VbKM2kNmNCEzZ65akajlhYRTYHlQZOqnQFsu3fKF5HE7oOeiE6DpLnaA9
 jIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782245515; x=1782850315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 b=QJvR+M68cLwsbfcmM0ShdZFfghe4V1bwPKvfIRv17EH08thNDPhgrAUOMUGa1Pqc1m
 Kek0g93yPvwniA/1lC4Si20HXROkUF+3N1Mn+9e/psJX5k12P97b89U0sdAhoi4RuMDf
 jljxaOTCJmyKY+TypTEwnjXpzfvx5SDCoJxtJTt2SYp1dzvsAIO+HD07cvNIumqT/W99
 bu6fG0Mi/spfoFa3y3+jPyrZLJfzksrLvPxGRAmypYdNwdWu2agWatN3iiXyqnHU8DMv
 AoIzH+x261rlGRMxacA4kMDXSdsA8ccFKn97F+1GYa1x5jVRbLqTMi+w4EIbLhEDFhO3
 9FXA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrbnr93T2RPvSj0T56/8M9/5e2noquxw/HSweuGFZJ2jinoGM8+AneZosh72+D6gV+4I7FuibcI6Oc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzApj0V2j6ghfqxSrKflz2uNxLVsCvBSLMUOGsPfDcQuYifsPlN
 a1PzkUr5Cm4tFFdeTQfhhe0yjbD8tTrvFijwSdCUBHGqzXbM3V6rvqVfV1w8ctp112Ar6HhKS+Y
 CclXe9fqHASK9ouEgu+TUDE/oShVxim4=
X-Gm-Gg: AfdE7cmpAba/tYyHp0yqAaABVdMHehyDorovDJE5sq84dcYEXbj2XnbePZzLQItjMlF
 UYO1UAIFudfMMPOdTX93bhrBu6sfU+ez3Hvt/TR0i4CZBH3dvHgZIJTbEACiA41sBRGhl0Zlwez
 mR88mr46NQ+FcGsujtMiKYc+B6owr0+pOiXASjPQIfsHi6tJ4cXOu0lROMD4XWTwj3yHQJdOeBz
 FDgTLEFy/rfZjgWn0ZkRmFhyX7K4koTPRmzyNxlnCHr3zyOClCGMsp/HguaN8UM/cxpf/uYj0eJ
 gni6jDMhfRCMDY1v3w1UMk/UUJip3A==
X-Received: by 2002:a17:902:c40d:b0:2bf:160f:7043 with SMTP id
 d9443c01a7336-2c7e16f52ebmr3796575ad.34.1782245514637; Tue, 23 Jun 2026
 13:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
 <20260619-drm-no-more-bridge-reset-v3-55-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-55-ff399263111b@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 23 Jun 2026 22:11:42 +0200
X-Gm-Features: AVVi8CclP812_MCc2l3_hynpLrJPPYN9UiQ3ld_pgUPdTcXAwwfZrBnBsjf6dHk
Message-ID: <CAFBinCD3suLGY4ZVK6bH_F4O2-OAtVAD81HSped+LkYUaEeNxA@mail.gmail.com>
Subject: Re: [PATCH v3 55/78] drm/meson: encoder_dsi: Switch to
 atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 19, 2026 at 2:27=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
>
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
