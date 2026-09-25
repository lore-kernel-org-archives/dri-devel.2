Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDA5C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B4710E0F8;
	Fri, 25 Sep 2026 16:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YnDGqSEA";
	dkim-atps=neutral
Received: from mail-ej2-f16.google.com (mail-ej2-f16.google.com
 [74.125.228.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5768610E0F8
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:08:52 +0000 (UTC)
Received: by mail-ej2-f16.google.com with SMTP id
 a640c23a62f3a-c2afe9fa8e0so33128866b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790352531; x=1790957331;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KoDkbvYtl5NWQD48z6cPIbsNVAJholwk5esvSBBhG3w=;
 b=YnDGqSEAXVMcWXRYreAI3dwbYghoR07VPOXb4C1ywW2T/m3ZforPPVwnGTb2b2oitm
 1zN8pCJjpE7zzmMX9Wf0R/5vk9q6gOkKE5r/6DHqDNkslDTk0edWXsIOzcG3vlmOTNq8
 FesivUeyVNoR/bjTusIZeMIzUXgRW6bg3Akak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352531; x=1790957331;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KoDkbvYtl5NWQD48z6cPIbsNVAJholwk5esvSBBhG3w=;
 b=1ksUpflNSWWNbmHAF0FpyksMAUR2OSF+NjzwFfLeIq6YEKi8PsyUF8teZPz8wozD6q
 6KXG4oVlQTz+RVfrFWWXthXTFF0YpwoIswOwXgkk/82cxqCwF7+Ksnc5405Y/1YWvf3K
 TXbyFeaCFcVXTeGwd1CCRb3+oyKzDSCbvlJbKa7l41bMrzglkpQ15R1EQacLMFiou9Zi
 LXi8j8X4uMIXOMfJgwYAJR1yCNRac8Ai0E0GipPeTxXT1f979elYpMGRBKTqhXUabKBv
 Nv1/mFEzLQKavn1Kk18iPsz/SvlkquH7JFy7STPrbwm4bnvJAg0SIHYJeAwZJfnoyGxT
 XQCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrxrIDx8L/72zf4RlBB3CnDeBVOgG5QhAhi5MM/BHQhoA9TQMdPhnJFB6mN+lse8mQmtEyWvh7Hlw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m45ASV9PKIl8rSa97QgZI8Gffx2tezfmnKzjUwKba/svaCaPOw
 Tlt8FP1jjZEZpp5Ub6But2qga7VgbJeLYUAdPazJctgIdFbf6HJnWBKsjjr7GjQNPBr0vnznWTg
 iZOI=
X-Gm-Gg: AYBFou3viX9K4OeITmtn7OLky2Rf0GskNqKkgfcdS6nyKHaIv6oh5N3Lq1R1pJIpL+F
 coFdDYltM35FedoFns5mC01ql6ixMVqMJ/ku/nBlcYAD/9ZKnYtsHWUKhrEIlnNUS2MPpzoOS9e
 /LLDTo5Zlh/MaJR5CJhTw6Snud0CTJl8Utd4Omj+w6B+NBqDEJeI5+tejNbHdVQbN/cZ5/HL7i6
 od59LmqX/vDMLm7ia8dTmX1qaw91fp9u0EDyW98c4u6NX0E8Ap6wMe+cPRTLp4+wJy3aWGQKmKF
 q1eypw0wqw7t8d0DOxFCzQHjv64+/Tel3E6Cun40Kfv3kbG+lSY8JOGxO383wianQmDLapXwNmm
 sDb0SJLjQ6oExziblzxxq8aw8lC0qbly2d94PgsJWbUsmS543MUPf4oqNP38g7rdKfLoBxBUr3G
 pgW0B8uy0DQroxysp6ckuAJvFK0o7iOaHJuwwVdK95GkQ+KB20d1LtVZpnrHTOczUFhnkSxkB8Z
 iPuPIrkG0vsS+/aLZ70PhQAs1wtWB+xMX4gNPTdOoASDbhNEQ==
X-Received: by 2002:a17:906:7946:b0:c29:6191:44ea with SMTP id
 a640c23a62f3a-c2ac2392e74mr535259566b.12.1790352530452; 
 Fri, 25 Sep 2026 09:08:50 -0700 (PDT)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com.
 [74.125.225.140]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae76ad76esm137431266b.40.2026.09.25.09.08.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:08:49 -0700 (PDT)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so8920085e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwVav00O9LCh8CLshDqu1tcuMqzM3GM/BIWxt+HpCy/rbSmGVZoyc10tolzD/GXzPhZKHApmKtP/ec=@lists.freedesktop.org
X-Received: by 2002:a05:600c:1553:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49fe66f3ca9mr104941595e9.17.1790352527270; Fri, 25 Sep 2026
 09:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260925132558.27518-1-okerixx@gmail.com>
In-Reply-To: <20260925132558.27518-1-okerixx@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Sep 2026 09:08:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UohyFHM3r4i6NoDbzVFpY9xZzg_=FvGFhBgScaCUwH2w@mail.gmail.com>
X-Gm-Features: AclHuK8278QfBh3T6IMehOEBNqzClwWRdpWLhQ6oHH2oGgXY2sg0_eqpoHwxnrs
Message-ID: <CAD=FV=UohyFHM3r4i6NoDbzVFpY9xZzg_=FvGFhBgScaCUwH2w@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: don't mark the AUX backlight enabled when
 enabling failed
To: Oleg Keri <okerixx@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi,

On Fri, Sep 25, 2026 at 6:26=E2=80=AFAM Oleg Keri <okerixx@gmail.com> wrote=
:
>
> If drm_edp_backlight_enable() fails, dp_aux_backlight_update_status()
> still marks the backlight as enabled. From then on every brightness
> change only updates the level and the enable is never retried, so the
> panel stays dark until something blanks and unblanks the backlight.
>
> I hit this after resume on a Samsung ATNA OLED panel, where the first
> AUX write can fail while the panel is still waking up.
>
> Return the error instead, so the next update tries to enable again.
>
> Fixes: 10f7b40e4f30 ("drm/panel: add basic DP AUX backlight support")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -4634,7 +4634,9 @@ static int dp_aux_backlight_update_status(struct ba=
cklight_device *bd)
>
>         if (!backlight_is_blank(bd)) {
>                 if (!bl->enabled) {
> -                       drm_edp_backlight_enable(bl->aux, &bl->info, brig=
htness);
> +                       ret =3D drm_edp_backlight_enable(bl->aux, &bl->in=
fo, brightness);
> +                       if (ret)
> +                               return ret;
>                         bl->enabled =3D true;
>                         return 0;

The above looks like a good fix. Thanks for catching and sending a patch.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Unless there is a reason not to, I'll try to apply this to
drm-misc-fixes next week.

That being said, why exactly is the first AUX command failing? That
seems fishy and warrants separate investigation. The panel should be
fully powered up and communicating by the time we get here and I
believe there are already retries in place for the AUX commands.

I'll also note that I considered whether we should also error-check
the drm_edp_backlight_disable(). I think the answer there is "no". In
general errors in "disable" and "free" are hard to handle sensibly,
and hopefully the panel will be powered off shortly after the
backlight goes off anyway.


-Doug
