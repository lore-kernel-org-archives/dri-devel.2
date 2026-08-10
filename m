Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADC1C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057A210E8C3;
	Mon, 10 Aug 2026 14:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uxztuzcb";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28B810E8C3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:53:13 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8484f229529so1431723b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786373593; cv=none;
 d=google.com; s=arc-20260327;
 b=FROqWeFTGdmbnT7CFfHxrSyifM18fFw8ZQaAuYHxEDNEJsHfJxDDDbzPP2uISNVHDj
 tu2fDLhbkOnUTfn5ojKA8kA+xntqLPf22dVmP8ZEnm82miCArK8H/lJ3vRpspcmKuBBT
 PjIKLb89u9Y4ukqkGdwFJPSQXZcrA2VsRc33aTCIhZ/Z+J2RT2b2icp6I68AUKgHgl4p
 MwybB8HW1sUps306poLHm6jmelm1Drmw+F6gMwdXOTY5XVG5PcoXcgVwEkvxGGAGEQMh
 qAQMAopa2o5/PdRT6oZvjqOiiK7uyWrzxgooe9qzgHytSFdlcvArVMNOLz9yRSITNbX6
 ydhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h/53g6QpOuuJ0e43sZSttv166Ak9krnxNBEXlxloo04=;
 fh=TJhqyaFrI30iubkemECPvNNvj9Nte6TWNVacuNEnaR0=;
 b=UE3qhNZ2VoOUVYCahaMf2YZe1w2EtFcYKWmGaNBotWt6pxN+06WOBngnnk2bu6n6xy
 ECPO5WoveGvjZLxBc1ICIQPceVA95G0QDAFrTo+IaHmb8K/48Y06I7hbBVv/3D3CGBlo
 AeOifLNMl3VP+8YSrYaHr+lUbYW0yyw7Vjf9/yeKhwZtAEpbRAMDDNwH13nt6d+lalr8
 RhFjtp7cr4EbAZsdIswWosq4d7SwAg14B3aVTJJd84KFwteGNync4RKvteDNlBZbrzN4
 Nn7KmzRXMv6cIxLS+NPmzvgdk0NOhSi0laIQ9ht/UWG2cAvZ7tTuN8hRM/lRl/kVEM8B
 JfPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786373593; x=1786978393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h/53g6QpOuuJ0e43sZSttv166Ak9krnxNBEXlxloo04=;
 b=UxztuzcbaUwLoDnar5vO27aXFdrYeMr/Lo4MEkpKMYpdqZOmibqi7pGf9F47nEgF8b
 EsconFR24JxSvxPIk0jxG/w2Gqk2H0XIhsZ9BW4yrlyqCxnGPlgEAAa/NDmr6GlMOAax
 W+ZcSOs+M/HJ6NuhFxp8thTzGbvnYSu8X4D1OqP7dbhFqejbqYXybnu7fSTViE+p8Y3s
 yxaNcOn3SQvk7fJncNXskVAGgi4/QCY1n9Cv9wn4c9kttcFx1Qq/rSOfgTcb88LtJdEm
 b/RB22rvPnHzzGNc4vAF60yMWWzLqnoT6PCYQrHhbgEu9Jeqm2dfOlMkGGvdL3ZDXFXC
 CdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373593; x=1786978393;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/53g6QpOuuJ0e43sZSttv166Ak9krnxNBEXlxloo04=;
 b=VeKeNc2RCnvnuW8Aq3AmRjWC2dcSqFoA6xzIepacjxEDN1ttuMcL9CrhUHAEz6X8Q+
 y6519Se1fNA3M9JI5CnYKOJ8cgmFx9kFOc25aNrhH9CObJ3F7KycSr+X6seDz3LEBcaR
 eYl8Lq7sCzn3/HlvyyNWzZLdZD0XHgGRYo5MGGMEUSGuci0qybhHjPrdYSzhsy1HzHpS
 cKPC0SeSybQQqrRpq3pKlFe0tU/dyNWdaTH7NYu2MWyzHNG003Q56rZP8N/uwySGLDJx
 1MGnme7Br8a6fbF2RFkFGonZfF2CbMHVZ21fnsLRKos86mvpitBa0BpT0k7D5M55liIQ
 sT6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFHuUzti7sAhiueEQxNEIyheDfA+R4iyMNsxM3OEBUSrZxtVGHDxvE/XNOe0UvgNEaOPNqfGZFz1I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzT7R/4QScXICCW97s4vszVQMzfayoxwfFbZR/3r1pFTvdrhLIW
 cRwzy6RXh0lv1jiX7TQtsm05p1AcyHQA7A6qHe6QH4HePJDPC9+Uhy7wYWlejfFrSkV7gdteprA
 ZNddN6yqJ3chTk46MRKH3yI7o2vlX8lA=
X-Gm-Gg: AR+sD12QLD0DOY0whUM2mPssbZn7wbLObkgRFy18yJKW1nasUmy6rDX7OyRGIp02bTD
 GA1aSYkA1e2dvBVLKEq8B94M2uxSDGG1emr7idkMIwlN9QVv9+TPy3WC/aPrTVlWXipuIcVlut9
 7pDI+Rl/CGh2wXK4HH4DKxrTCk2ehcHb0M/ZvjqkAZBGGXKGHjYaFkAqyQCJNuXu35WkqtzBvkK
 /jd+HqzOXu9oBjvHzMRIlVI9jbSSGnr0rVoRaSRYntSHzbCZ+u8tQQExT5yhrGJXCUhLwSw3ICT
 RlVbREu0gYj4lwniNEALptr2j7aASfTOOzByENIXlRgnwMoG7x6zbunM5fpeONzaX8IOsKsdivY
 g9MY=
X-Received: by 2002:a05:6a20:9f93:b0:3c1:d78:6457 with SMTP id
 adf61e73a8af0-3cbce98fa3bmr23481463637.32.1786373593080; Mon, 10 Aug 2026
 07:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260808232120.23817-1-jonathansteffan@gmail.com>
In-Reply-To: <20260808232120.23817-1-jonathansteffan@gmail.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Mon, 10 Aug 2026 16:52:36 +0200
X-Gm-Features: AUfX_mzR-aD9uThd6YVeRDzNry-yJeN7TSRU9pD0J-TFCJ99D3a56DwlHO4AWxY
Message-ID: <CAEsyxyg0MrQ-K8MSXQegLYVeO9QwnKsLwe3S=5WHo_AaeBBMfw@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Add HTC Vive Cosmos to the non-desktop quirk
 list
To: Jonathan Steffan <jonathansteffan@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Aug 10, 2026 at 8:38=E2=80=AFAM Jonathan Steffan
<jonathansteffan@gmail.com> wrote:
>
> The HTC Vive Cosmos and Cosmos Elite head-mounted displays report an
> EDID with manufacturer ID "HVR" and product code 0xaa03. Like the
> original Vive (0xaa01) and the Vive Pro (0xaa02), they are VR headsets
> whose panel must not be treated as a regular desktop output. Flag it
> non-desktop so userspace leaves it alone and can acquire it via DRM
> leasing / direct mode instead of extending the desktop onto it.
>
> Signed-off-by: Jonathan Steffan <jonathansteffan@gmail.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index df3c25bac..437751ed3 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -245,9 +245,10 @@ static const struct edid_quirk {
>         EDID_QUIRK('V', 'L', 'V', 0x91be, BIT(EDID_QUIRK_NON_DESKTOP)),
>         EDID_QUIRK('V', 'L', 'V', 0x91bf, BIT(EDID_QUIRK_NON_DESKTOP)),
>
> -       /* HTC Vive and Vive Pro VR Headsets */
> +       /* HTC Vive, Vive Pro and Vive Cosmos VR Headsets */
>         EDID_QUIRK('H', 'V', 'R', 0xaa01, BIT(EDID_QUIRK_NON_DESKTOP)),
>         EDID_QUIRK('H', 'V', 'R', 0xaa02, BIT(EDID_QUIRK_NON_DESKTOP)),
> +       EDID_QUIRK('H', 'V', 'R', 0xaa03, BIT(EDID_QUIRK_NON_DESKTOP)),
>
>         /* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
>         EDID_QUIRK('O', 'V', 'R', 0x0001, BIT(EDID_QUIRK_NON_DESKTOP)),
> --
> 2.55.0
>

Reviewed-by: Mario Kleiner <mario.kleiner.de@gmail.com>
