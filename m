Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A57606A31D
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvZ9l33V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E55910E187;
	Sat, 31 Oct 2026 16:35:07 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F71810E187
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:35:01 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-6798af41644so1089355d50.2
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 09:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793464500; cv=none;
 d=google.com; s=arc-20260327;
 b=i0UNcc5RxpV1ca9JeIFnGCWxQ/xv5WT9CfdnU4pL2vwXIlsIRhlChQ/Hdf29AWft9Y
 3zubV9LOkoqqaxfWFG8GvZZoCtCQhrUimDdjDECcTPsBJWfDVe2JtktGjOEdjwKePWha
 HFzC/VUHDH81SlO1pndu6Z13bXeEaT5h9MyAHCiGVUvPVTQIFWc9+KYeCi4INs/kYfjg
 zsqTFtPi8nb74c2aR6uYiGXGMfhX1tnpVLuGckJT+HJvkQJiaoy3yUQvt5eurC8G8qBo
 EoWUFiOJ+CKfIc/R961RwIYKUje09OyQxaXD5XuJmPKnLdQc039sKUstzlev12olXEC5
 f0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xh4+zw2NsvluCtokX+uj0ZJ8AJtCAX02SKccWbKLLC0=;
 fh=c+qMkzh4ULI43jQLNwEIFVuHguLKnsNs9jmyzaCv0gI=;
 b=l05vyLoGypXzAbjb2aWWMGxEQhqu4FTH6gs5x5sFBL9PSsYAnEySga3wtDfnxnb5F+
 C6uOiFtQjSg2kZ/vSlkFGr0Ykt90X6k+AtGdSZh+T73i+eK4zbbJsi5nen19RZpXZwbx
 YFeDNyLfHPDSrKU9DnbDeIlYaOzwkx+9qw2XDKedqCY4itIopIPB3D0BslX9T5F0c3sN
 L8wrS2VqJSCNktublP/PRQt5cc7nKIZ9txGSEEAT9mC3QnpXRwcj5niijDli/Xum/63U
 Tpf51Q2jytE+lcl53KG9Bpq24wD9VDHyeUFdfBOhpTSE8wAlQT2SBA8bwsYQAGsNbpIM
 m9HQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464500; x=1794069300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xh4+zw2NsvluCtokX+uj0ZJ8AJtCAX02SKccWbKLLC0=;
 b=GvZ9l33VHU7OLqO7gPG46psmefB3ZnFIq69Wldbkkpo1fZdYogtbmSy/vc1bjAfeE+
 Ito/xWtB5qjtfiSL1ZfOP/7SeFmrcFYN445kMFKmRYRTeQdbLeVvi/R3ei1zJSv0hXCE
 kyb7rSBLo34CwL0AS1okKsS+WnUA3T6v5KqvxZHGpL+lY0Ka5CuX4YbUTJ0IIsNpCDko
 cJMNCa+QM0iXI7rEs8xXHujydz0XKXZEvSN0h15R45+kt2WX4DTZzess58A3GQqELFGH
 lCpZPlMbXagJFT2/v+kUedPDKfx4FoPu3hBWYyz50K4l+2H7Xs7Xevjp5E7hNpJDwmDK
 9MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464500; x=1794069300;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xh4+zw2NsvluCtokX+uj0ZJ8AJtCAX02SKccWbKLLC0=;
 b=IVQNXulU1GABFsmx5fgJX0WIHCD0bLc/cdj0JJTuC//d5c1NX/AFkvSIqp/41Tj/rm
 qPnF3/oc+Or65s91OXVypuxR15l7uIIRc7oGWCMGNalCUYJroaMe9VkfsBa4hxvUw5S/
 Sp66Im+d+J4DIyhbx4ZcXzRYS5D35sJQU9M92mymiUmfvALfNVhBlA0McYoOY6kQIj6a
 FKt3pJUmKqQCgHsMqxX2YTHZfZdgFo7VzmunAwaL9qEoOu4qehTaVcrqfgECA4SdrjzZ
 HzsP4HwGHX4NQzdbZ5PLSHjy7VHbKh8LNVyY4pgtyJWU/COeeRJfEN8GEPFIyO+cOjGs
 dErA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAho8+v48tCAkKjJq4gcHX9tz5EH4Yinh7Nt9xX514gnL9vT2eoO5l67jUdc4Z+OMMMzu5U6X7Sac=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+pRvOPKgEJP5gyWzMjCJ9bnXo1bslB4FeDj6DLqM4ObPKgYxD8
 JR0q78v381P+SEaEQNFLfpAVjS3VULvVZBH2swRNhLObljlWenRNpv3qZc9C1pHLqrNHzetuPrd
 8T+6JF2wMkkJfZHjs31E+TkbsR0NpqIk=
X-Gm-Gg: AYBFou2TRGaawjGpsCeQ0zCHC65Vklhm1DMQ/3kMOW7RMGM5pkH/zNdCZRpv8xHXwQC
 vawQA/HzKGkoHeaV1zFTLmjZJcs8TKXbBpBxoiMzm7S0hTEzCjFtNI+ploUlc/j2IGDRirFqVZ4
 Wfh2FrAEdfbG2VLJMe2tAL1sPvXdOpycqrUtfgOGDw2uQd6WRtG2x+kjk5iAjvIvwpyYidtgmjm
 KCOVonhkI9J8NpBzmNA+FDDhnuxhxPsUzVRGuVPfXVHf0mRZ8kpntkoWrm3iwrR6EUC86iO/ToE
 m/OuT4OPxogPAH0aZsqabOHikchhBnJiMTa3pbHscOLky+nbq8gZQ3qKHCfYKjCKN1dfH3E6OHW
 iF+s69SfwxpavXCjxh5jbkZKOjwY41dq0PVAtjLlmbZJM9k7yvotgDde50fBc
X-Received: by 2002:a05:690e:4514:10b0:670:fe59:3f7d with SMTP id
 956f58d0204a3-67ba502f92amr2477741d50.52.1793464500102; Sat, 31 Oct 2026
 09:35:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com>
 <DMHSRIU2XCB0.35RV6ADY6W1IE@kernel.org>
In-Reply-To: <DMHSRIU2XCB0.35RV6ADY6W1IE@kernel.org>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 1 Nov 2026 01:34:49 +0900
X-Gm-Features: AclHuK-jvh4fcghfPZ1KFb682ZDJ6x2_Cukku_cOj7Mrng853tNlYasYF_Ksjf8
Message-ID: <CAKbEzns6CYjNXmf4jTx_eGSH2j6AjpKJPx=EtoqxweGLiQ85JA@mail.gmail.com>
Subject: Re: [PATCH] drm/imagination: retry runtime idle when firmware is not
 yet idle
To: Troy Mitchell <troy@kernel.org>
Cc: Baihui Liang <liangbaihui@linux.spacemit.com>, 
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Yixun Lan <dlan@kernel.org>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Baihui, Troy,


On Fri, Oct 30, 2026 at 10:55=E2=80=AFAM Troy Mitchell <troy@kernel.org> wr=
ote:
>
> Hi Baihui,
>
> On Thu Oct 29, 2026 at 4:38 PM +0800, Baihui Liang wrote:
> > Returning -EBUSY from ->runtime_idle() prevents the PM core from
> > retrying the idle check. Schedule an autosuspend so the idle state
> > can be re-evaluated once the firmware reaches ROGUE_FWIF_POW_IDLE.
> >
> > Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>
> > ---
> > Tested on SpacemiT K3 (PowerVR Rogue BXM-4-64) by running vulkaninfo
> > repeatedly. Without this change the device intermittently stayed
> > runtime-active after the last user went away, because the firmware had
> > not yet reached ROGUE_FWIF_POW_IDLE when the idle check ran. With the
> > change the device reliably suspends.
> > ---
> >  drivers/gpu/drm/imagination/pvr_power.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/=
imagination/pvr_power.c
> > index eb4b6ecdf4f..6f38249ffcb 100644
> > --- a/drivers/gpu/drm/imagination/pvr_power.c
> > +++ b/drivers/gpu/drm/imagination/pvr_power.c
> > @@ -434,7 +434,16 @@ pvr_power_device_idle(struct device *dev)
> >       struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
> >       struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> >
> > -     return pvr_power_is_idle(pvr_dev) ? 0 : -EBUSY;
> > +     if (pvr_power_is_idle(pvr_dev))
> > +             return 0;
> > +
> > +     /*
> > +      * Firmware not yet idle; reject but schedule autosuspend so
> > +      * runtime_idle() can be retried.
> > +      */
> > +     pm_runtime_autosuspend(dev);
>
> If I read the PM core correctly, when this autosuspend timer fires it
> calls ->runtime_suspend() directly rather than retrying
> ->runtime_idle(), so this looks equivalent to returning 0. Could the
> real issue be the pm_runtime_put() in pvr_watchdog_worker(), which
> perhaps should be pm_runtime_put_autosuspend()?

I think sashiko's point is valid.

Calling pm_runtime_autosuspend() from pvr_power_device_idle() when the
FW is busy only adds a delay, and the device is then suspended without
re-checking idle, and this is effectively the same as
returning 0. I guess it worked in testing because the FW was busy at
pvr_power_device_idle() time but reached idle before the autosuspend
delay expired.

How about moving the pvr_power_is_idle() check into
pvr_power_device_suspend() (and dropping pvr_power_device_idle()), and
returning -EBUSY after pm_runtime_mark_last_busy() if the FW is busy?
The PM core then reschedules the autosuspend regardless of whether the
last put comes from the watchdog or elsewhere, so suspend is retried
until the FW becomes idle.

I think this is the pattern described in
Documentation/power/runtime_pm.rst, section 9 ("If the
->runtime_suspend() callback returns -EAGAIN or -EBUSY ...").

--
Thanks,
Gyeyoung
