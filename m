Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBE606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfwzMrQb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88B010F439;
	Tue, 24 Nov 2026 10:21:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C00610F439
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:21:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0467D44DCF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B6E1F000E0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795515688;
 bh=YXBcpVbwgEfTF+d5rjbl50MgaiSh1L8ku0r5a12R+AI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=lfwzMrQbZOx+v4VMg2IwYeyhr76KyZFENEpb/d2EgyvULzFAj7t02yslFrevPF123
 K8W22veG2kUfBQwL8Bs0IPnPuNQuJ+tec42zsO5W6gudJ+kl8lBwY4MNgAHlnnqqzD
 gDzKPr5roE/on9E9QSK3tbEor9heQ9pjgIzD7i1oXMElgIn9NhkxPSEPYYnyb9ivg4
 e2LgCbuvbjON6aNY4p55b6i6+do0jemyHQF6ZtwfpNaeGcVzqnExZ4igxrNbaPqvbk
 VxTlnxiRvv7Fnt1Luh40LRIVhUxWt0iEdzHQrUl5jXXs74R1GeGn0Iv+D8Re+SGXX7
 XQlmLP0Tj2+9g==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5c0a520df2eso4127204e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:21:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErH06py8Swin+BjuOGAv9UBpdgT4U867Jx5LQPbC1Fr4MgD/NQuLj3bCo1yTTnKqp0R9MqteyPxFdhI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8uJssaCJHmJKfV9+kMmTJMUq15yQaSCs1yVXAv8DV2+vh9HAYl
 Q6l/GBuFy+k1jtOcnzHZf43uZZSeYXfvMC1TUZpSaBOQhTiHgT2OYLgNIqICgZmNlAnudxY+0jh
 6Ni25/C9n759ePZB6Cahn5k6cEDkntjU=
X-Received: by 2002:a05:6512:3e26:b0:5bf:dfb9:33db with SMTP id
 2adb3069b0e04-5c1bc894b28mr4488535e87.38.1795515687650; Tue, 24 Nov 2026
 02:21:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115-ux500-drm-mcde-powerdomain-v1-1-afdc326cceb7@kernel.org>
 <CAPx+jO_w6-y82_5+DTLxb6dtiNv2KNMYLKpRJU0nLRLvy5-adg@mail.gmail.com>
In-Reply-To: <CAPx+jO_w6-y82_5+DTLxb6dtiNv2KNMYLKpRJU0nLRLvy5-adg@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Nov 2026 11:21:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLnkSRSGRKN7RAkQeKrE=NxWaWa0+e8o5pHvWsM-Ng4pkQ@mail.gmail.com>
X-Gm-Features: Aa3M54pifxQBkoANT262xLGX_zP7O6MWI1krQALhFhgz9i5QcERbJXtYNJnj1FM
Message-ID: <CAD++jLnkSRSGRKN7RAkQeKrE=NxWaWa0+e8o5pHvWsM-Ng4pkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mcde: Use power domain for display power
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ulf,

just quick answers,

On Mon, Nov 23, 2026 at 5:16=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:

> >  #include <drm/drm_atomic_helper.h>
> > @@ -1187,16 +1187,15 @@ static void mcde_crtc_helper_atomic_enable(stru=
ct drm_crtc *crtc,
> >         int ret;
> >
> >         /* This powers up the entire MCDE block and the DSI hardware */
> > -       ret =3D regulator_enable(mcde->epod);
> > +       ret =3D pm_runtime_resume_and_get(mcde->dev);
> >         if (ret) {
> > -               dev_err(drm->dev, "can't re-enable EPOD regulator\n");
> > +               dev_err(drm->dev, "can't enable MCDE power domain\n");
> >                 return;
> >         }
>
> Neither regulator_enable() or pm_runtime_resume_and_get() (unless
> marked irq_safe) are supposed to be called from atomic context.
>
> Isn't mcde_crtc_helper_atomic_enable() called from atomic context?

Atomic mode setting is a false friend.

"atomic" is one of those things used a bit like "static" in C, the
meaning depends on context :/

DRM atomic modesetting does not imply atomic context,
it's just regular context here, so this is fine.

I applied the patch your ACK!

Yours,
Linus Walleij
