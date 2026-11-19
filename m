Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CFB606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fuJ5DYQc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD89112739;
	Thu, 19 Nov 2026 22:00:50 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20A2112739
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:00:43 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3ab4354db11so1800391fa.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795125642; x=1795730442;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aA7LciJps6ZDvR0//aGq+VpK53nWWFH0Da5N4W303Sc=;
 b=fuJ5DYQcY/QjxLefbdNbSYPeK26QRLDx0UF2C787fobUUVE9dLs6UnIOocXoUC1bLB
 hCDGHym6oWaRHfIW/9Shdzmd/igtAq4dMEkPM5tHak43ultwCMGxRd9NN+eft19tJZgq
 1rG8rn4w2rig9byb7nVpk1JzB9IPug1Y/EJdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795125642; x=1795730442;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aA7LciJps6ZDvR0//aGq+VpK53nWWFH0Da5N4W303Sc=;
 b=oQqh8OHA1ZcSPiGzaoGLhUv32Ndn7PB/sJrlPZMQ4vBFzX3VsYXNqhdJDV5RPYeM3k
 bfDtzyOyLflNAH4TV0mbvlV3tV5nqTBN3sgC0914kHh1e6TvwDMorLCwvc8W74RMb1c1
 AchT1fbH+ttFPW26u6bwJhg5RAg3WmgLKZz9YMovCkOcHGRn8+5rV6a/S7hsDGrUm4Bo
 GknDmtiVyp4/YucTqiRM+09F1AnBQUsWD6wxQ4eihF6Hq8CHumN+va8S9QuSO4zSbhhe
 TjjzN+3OCXYGOtr8uNvGmE4ek6+cLDhj05ftpQ3YCxtzGIX5ieMTVPB49Yhb7K57Py1K
 Bb1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHKD+P1PoKInQe5SqdYimFQQAoQBLQETW4n7iCeCG66AavWOOcmwMjgmQQMBpkBvd9emSK6SflBUYs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9jWE81zVOx0izvyejjzfSsCQ857goKYlmXVYy/oN0FSD+ejI5U
 ejyVAhje6qd1d2qGRKgHIKFPtIdCdvhX8JfCwAJDedZfaJQdrRwi7XO++k6VS5wvm4UXyxsHNXl
 b0FKPpg==
X-Gm-Gg: AYBFou2cJxjZwOJdq+MTl8g3p/V+F6kNoPxc8tDWuK7YexvsG4hu3qPjEXOSBfrKyH9
 HGWqGw7uisOPtRLt4e7yddSRR4PNh2RIyESlsHzTm26AVxXz90ilEebG1+gV56lGFx89ttGAePe
 tnOk8GNxNqR9irsa75HEdmxUH0ErIQl7g7CWPS4lJSoXTHUs3cYpqt2sxw8bszLNT6KH9mFzTpv
 J7b6Jnp3Cz2EfoA+wttaYmZG7xYsSfS0oiwgZSNxzxGniHQHrKEpwZZ1eZKVRfAWkOrjaesmTYp
 /+b6tMb008qMr3Nb2g5bdwp5iFPlNHMjgG69GoPPEEfde65YeYJgBFPsdNaBTGgAcnbxXcHqCjv
 +j53xvldlxZnwxa8x8tWpa1IefDT3lTSFfuDuggtpgC5SaVl6MVcm4TEuibb1AgOawBIKVydlkD
 KAAmCAOXd+g0sXtLHP1fBKtU5srVZ3S8pJZslabueH5sxuNIs0qKlkpORF5NXOvAWAuEgJ393YE
 tM8CScIJ+3VKfb1KIopPPUCN/M6SBiYRU3Mh8h7TkN0Jd6Rxy9rN4GctFk09iHoePbngcLDB0jx
 0/0YVhQmvUEEHiDhATzvu+67M3GMx4NnYCBxgeAwWtuhg0JORzgzUT32iEwbMFMQc6NL
X-Received: by 2002:a05:6512:ba5:b0:5bf:9f5e:fe0d with SMTP id
 2adb3069b0e04-5c1bc7b4639mr288464e87.23.1795125641772; 
 Thu, 19 Nov 2026 14:00:41 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8044e211sm2636671fa.2.2026.11.19.14.00.35
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 14:00:39 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5c10dc41270so140751e87.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:00:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEHK0voFNVctHBpcGZf2CWr/t3irHA2jh4YPmvV9RDpZAP11lzilbfQS+7XHT0R+93CGcKt+FlBh8Y=@lists.freedesktop.org
X-Received: by 2002:a05:6512:b91:b0:5bf:ce1f:674d with SMTP id
 2adb3069b0e04-5c1bc7b5b0amr294883e87.15.1795125634616; Thu, 19 Nov 2026
 14:00:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119162353.12962-1-architmore303@gmail.com>
In-Reply-To: <20261119162353.12962-1-architmore303@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Nov 2026 14:00:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VJHHHJ1-YXBrrrcbEo=zh+ieujT6Q2FpQ2gfYoLKo+PQ@mail.gmail.com>
X-Gm-Features: AclHuK8b5SuMQ1jnVWmU0hGRPWJRjOsQeE75hDNGcjbVc7Sqfy6bSlSaSsLYv4w
Message-ID: <CAD=FV=VJHHHJ1-YXBrrrcbEo=zh+ieujT6Q2FpQ2gfYoLKo+PQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/panel: Use lowercase hex literals in three panel
 drivers
To: Archit More <architmore303@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Akash Sukhavasi <akash.sukhavasi@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, Nov 19, 2026 at 8:24=E2=80=AFAM Archit More <architmore303@gmail.co=
m> wrote:
>
> Convert hexadecimal literals in the initialization sequences of
> newvision-nv3051d, kingdisplay-kd097d04, and leadtek-ltk500hd1829 to
> lowercase, as suggested by Douglas Anderson.
>
> Archit More (3):
>   drm/panel: newvision-nv3051d: Use lowercase hex literals
>   drm/panel: kingdisplay-kd097d04: Use lowercase hex literals
>   drm/panel: leadtek-ltk500hd1829: Use lowercase hex literals
>
>  .../drm/panel/panel-kingdisplay-kd097d04.c    | 242 +++++-----
>  .../drm/panel/panel-leadtek-ltk500hd1829.c    | 426 +++++++++---------
>  .../gpu/drm/panel/panel-newvision-nv3051d.c   | 286 ++++++------
>  3 files changed, 477 insertions(+), 477 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

These look good and non-controversial. Applying.

[1/3] drm/panel: newvision-nv3051d: Use lowercase hex literals
      commit: 758498460e911d51c4dc3d32c925f56cacdb5eb6
[2/3] drm/panel: kingdisplay-kd097d04: Use lowercase hex literals
      commit: 4c1ed6ad2d326b73c0a2b5bc00ad76ff90047871
[3/3] drm/panel: leadtek-ltk500hd1829: Use lowercase hex literals
      commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
