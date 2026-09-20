Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D9DC982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 20:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE5110E10B;
	Sun, 20 Sep 2026 20:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a3hQoTit";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD6D10E10B
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 20:58:53 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-52fb766bfd3so19028801cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 13:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789937932; cv=none;
 d=google.com; s=arc-20260327;
 b=niCmjzUtJCcMOrei78gc+uNuI7GYEiGOaajoEtklLta+2nLiy9GYANQA1tkh+7wUoz
 3HAJM/ge54nCiYq/56UY23vP5lRogQQFqHHciKf5iejyuYgcdlBk0DlgWLQMG3BrI6oy
 yLSvgUWQOY/kOqi6FRte7ZVZaq8HrsP0M4NQZJ1zVkylqdyZxxT0D36ja1Olv+ncUPVn
 5bHdfbIaHyTZpKoSIuBrspAYbiAnWeH0KmdFqSCkeDWxSZCj9tBBdy8KrD97eHFfXbqL
 R6Pjzei28/9SAW2ovW/dtzS5x9tRABTrB8/at1AkpjHJxEbpTimm4ogiqXeq1ru3423Z
 4ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pgbYq9WZp1wLB/tLd6hSmJb2hGfdZ+kAb6DF4bI/cVw=;
 fh=bxuryAwvSIAmxsCLDTLiMpBfpvWvk8x7CXuCcFeh/4c=;
 b=KEDcWQ+o6g5aa4TRdlPvduaYREH3ANj5FluEkTqnqWWyv9arSUuMDyObADp0vylShZ
 D4ytViXVe3THnkYRokXQM+FIVMokg6X8ZElibseXfxJ3sWjuTFB5s/CG3jq3sp3gZHNf
 mhMFhb+L6mDR9OmBo7Qp6P87yW4yvkrcItuX6y82G2AdCmqN8ZPNeDtsFq7QeICCfAaN
 QYCIZp8k8aeSamXXAfHJdbeDo1ZW5PIpATwDlRBD5JX+asZg1IPS5HPyKJBbzrr3MT9k
 HJimob5YWOtsi5KU4ASHoM5FBlmebCLrExUO0gO7DLMqp6Q4ftdIevul1XIgg9Z44Jk5
 Ht7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789937932; x=1790542732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pgbYq9WZp1wLB/tLd6hSmJb2hGfdZ+kAb6DF4bI/cVw=;
 b=a3hQoTitvilYwd1pbgysqJbecjul2qsAT5ufCRBgOhJ7O/d/3BCwghCMuKFGlKXrOn
 tD0ZBWVUVwOp6hPOeSeZ4O84nMcUxxGGROMfjvOF2ETiNQ/Kd9QFF4U5j76IZKviAc9u
 uOEzbtFxzzlCsiOoUzVpwF3YYvmdDxpzD5W8W4jRQ8CI1pKh+VNDXASjaCMkqM6L5xq7
 EcG06hCHUHUMz2iUdbiGgE9wRtfCsYvSNR/zoLAlPaTNgU6fHn4Zq1Py/N1+2MYGHkAs
 TkZDBQRR882o+WJLCbOj4DocEvj7ol1FSzx26IyfWoUenknLT/hoABTfisqVaLL6zBtL
 tDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789937932; x=1790542732;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgbYq9WZp1wLB/tLd6hSmJb2hGfdZ+kAb6DF4bI/cVw=;
 b=1C8F7AW74pqfIkshWOSj7gHhFSsTQ6mRWYPFxpZACaa6ipB++Mz6+LfVbF+xIwJubr
 ED/fMEb81bjX4v63gZ/OraMj8colo9CxhMtEMF5VfH7J1FaIuRAxVi9ILhWmsQA60uuN
 y2gmlbA79st8R3kCpWKwNO6PljsVgwdI+0kI0NdtDN4LNs2WAlFFx4cgDaNgtcnJOpFa
 vlPVP1jgq1gQ15nMFSFzZUBdhl4DzNWIE1XH+fF8f22IodbXpSAixHlEThe5ccHnWJiu
 VhdKdnwRheMMbvb3V7W2yuJns2CG5gtw6ST9d/t4aWkwfdt4lD/WfbfA8N2lOve6fHho
 In7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYqzHTc+Sy6LpzxKkeePlqnFDcWWBgHOQIFeGhuQDJ+8hmBNeY9c41s+a2dJnMJCXspdbdbYbyKjs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nz1QqZqhQlFyJrLAMOZQ/OKpsOx2oco/GAXj3nn4HUj7YWb7sD
 huZWi1OWrjW04tCgKbZ/QSJMSH70kXV4UkTBJCETxTJA7PWlTgdMCJqI+HTX7oh/DIhHkC8SvDd
 Jx9ijAII/GR0iggfewNZ2GhOMEneS0zk=
X-Gm-Gg: AYBFou0esjjKBv+oGvHqPhFUCEn4BrknKLhCCyE74Zfgk382XckY++76cysdmQO12Hl
 lDGp7drY1RNofDn0gVCpXTYEjATteHt9TLmW0PlT/gSjhh1g0t0muvfVQ3bRsYO+K3dk/0zlYrE
 4yainky0ilzfUXISZ8ByF5m4QlC29U9Utj3DiJKvRUV9i4bN4qpbltQHwW/ZQSZcOLvhrfOoXH6
 daotBgMHNSi+5HI6088Z7CblFWX5bkMVRJsji7nae3pMNe+84Ohj4MKck82EYu0C+FmaUaCpz9J
 jEi0iTcTgohgTLWEFrajPQLFzIKUGOMX3CYPuBzPhilDTQSLIJ5dXmk16w==
X-Received: by 2002:a05:622a:1650:b0:532:9adc:63a1 with SMTP id
 d75a77b69052e-532b7405127mr73553621cf.69.1789937932639; Sun, 20 Sep 2026
 13:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260918235351.398269-1-cyrozap@gmail.com>
In-Reply-To: <20260918235351.398269-1-cyrozap@gmail.com>
From: Forest Crossman <cyrozap@gmail.com>
Date: Sun, 20 Sep 2026 15:58:40 -0500
X-Gm-Features: AcwNN1Uwqpqv9Dxa8GL84fQ3gyPZRWEAowqxxoidYtNKJmtJS66HC0S395w6bVw
Message-ID: <CAO3ALPxvFghs8UOckRVDp=Y6taWE-gWVhwbck9AN_pZPS1oqdA@mail.gmail.com>
Subject: Re: [PATCH] drm/gm12u320: fix system freeze on surprise unplug
To: hansg@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
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

On Fri, Sep 18, 2026 at 6:54=E2=80=AFPM Forest Crossman <cyrozap@gmail.com>=
 wrote:
>
> Unplugging (or deauthorizing) a GM12U320 device while it is driving an
> output causes the system to freeze. When this happens, other screens
> stop updating and USB input (keyboard and mouse) stops working, but
> non-USB storage, audio, network and ACPI events are unaffected. Because
> the unplug never completes, the only way out is a reboot.
>
> The kernel log shows a NULL pointer dereference on every such unplug:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   RIP: 0010:drm_mode_object_put+0x9/0x20
>   Call Trace:
>    drm_atomic_helper_commit_crtc_disable
>    drm_atomic_helper_commit_tail
>    commit_tail
>    drm_atomic_helper_commit
>    drm_atomic_commit
>    drm_atomic_helper_disable_all
>    drm_atomic_helper_shutdown
>    gm12u320_usb_disconnect
>    usb_unbind_interface
>    ...
>    usb_set_configuration
>    usb_deauthorize_device
>    authorized_store
>
> The call trace above was caused by triggering a deauthorization, but a
> physical unplug reaches the same gm12u320_usb_disconnect() path through
> hub_event/usb_disconnect().
>
> The task faults while holding the USB device mutex
> (usb_set_configuration()) and the DRM modeset locks taken by
> drm_atomic_helper_shutdown(). Mutexes are not released when a task dies
> in an oops, so they stay locked forever, with the USB hub workqueue
> (hub_event) and the DRM framebuffer-removal worker both blocking on
> them. This is what freezes the system when the driver crashes.
>
> gm12u320_stop_fb_update() drops the cached upload framebuffer
> unconditionally:
>
>   old_fb =3D gm12u320->fb_update.fb;
>   gm12u320->fb_update.fb =3D NULL;
>   ...
>   drm_framebuffer_put(old_fb);
>
> gm12u320->fb_update.fb is legitimately NULL when no update is queued,
> for example when the update was already stopped, and
> drm_framebuffer_put() does not accept NULL. On unplug,
> gm12u320_usb_disconnect() calls drm_atomic_helper_shutdown(), which
> commits a CRTC disable and reaches gm12u320_stop_fb_update() with a NULL
> fb.
>
> The NULL check was lost in commit 8f2cb9379fb4 ("drm/gm12u320: Simplify
> upload work"). That commit moved the reference release out of
> fb_update.lock (so the framebuffer destructor does not run under the
> lock), but the previous form guarded the call with "if
> (gm12u320->fb_update.fb)" and that check was dropped in the rewrite.
> gm12u320_fb_mark_dirty() still has the same guard.
>
> To fix the crash, restore the NULL check before calling
> drm_framebuffer_put(). With this, the CRTC disable completes, no locks
> are leaked, and unplugging the GM12U320 device while it is in use no
> longer freezes the system. Tested by surprise-unplugging the device as
> the active output--before the change the kernel oopsed and wedged on
> every attempt, after it there is no oops and no stuck task.
>
> Fixes: 8f2cb9379fb4 ("drm/gm12u320: Simplify upload work")
> Cc: stable@vger.kernel.org

Apologies, all, I've just learned I should have added an "Assisted-by:
LLM" tag here.

I used an LLM to debug the issue, identify the root cause, write the
fix, and to write the first draft of the commit message (which I then
edited significantly before submission).

If you need me to re-send the patch with the tag added, please let me know.

Thanks,
Forest

> Signed-off-by: Forest Crossman <cyrozap@gmail.com>
> ---
>  drivers/gpu/drm/tiny/gm12u320.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u=
320.c
> index 4ad074337af0..5bb6488556de 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -446,7 +446,8 @@ static void gm12u320_stop_fb_update(struct gm12u320_d=
evice *gm12u320)
>         iosys_map_clear(&gm12u320->fb_update.src_map);
>         mutex_unlock(&gm12u320->fb_update.lock);
>
> -       drm_framebuffer_put(old_fb);
> +       if (old_fb)
> +               drm_framebuffer_put(old_fb);
>  }
>
>  static int gm12u320_set_ecomode(struct gm12u320_device *gm12u320)
>
> base-commit: 1717fcc5be575d4768279148ae9465a8b13d4339
> --
> 2.55.0
>
