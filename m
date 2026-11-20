Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00E606A332
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w/Ahuhnz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E734710E0FA;
	Fri, 20 Nov 2026 06:51:38 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E6310E0FA
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 06:51:32 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id
 006d021491bc7-6df5e315bd1so545848eaf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795157492; cv=none;
 d=google.com; s=arc-20260327;
 b=mPGLZrTe71Lzu2PBUzMJBQMz+GsPoNrfJUOkGr9GYkhEDviJMDDWk2dOLtjSJRji0q
 Q5Cu2tQ2bA+5NvNwz1IM+g/oLdWgVK/zUUYvoQvRx3/1q+DyFA49OgfjNjkc7RMc4Nra
 myCNjsBcX69+NGR5MtPImLguXl0NVJqd0qQF/JhY7DMFuufEQUJExxsl5YeLWxITEvz0
 +FwdEfwODkPQmhpVL3uL3GutCks8WAWkT7J/POzn/o4t1NxMA93NqC8d3YWfpSO5QRwS
 OWie4qLrzRYhxAgQU+MjCFy1lu8o01LIKcDvgFQheOql+ceVzJmDifM7Lebjq4pWVuJh
 kNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PtA8qFFBXG6iEUpmFm1DFbbkNSGlt5cA5Pbfh67zRN0=;
 fh=FoppdSpYsFp5lFtxyBUr9PL0k0+gtW9Gw7AjSiB23tI=;
 b=n7PBPU3UY0Q12dn1Jl4w5G5Vmxmwo7etOW+TQNshOGjHWifSyp8u+8SLzUIq1lbowk
 nYYZrP5/xdMFiHjnlCSdxl1XbDXrCyDPKVOdveG8pKroXkph0pEMxOuI+To2ovndHFwi
 xZjHmZsre53Pezkuov9rvB7C5+5Ayr2JQYJvY4d7V4SSXN+buaxhQTr9CAP3KjD7eBQ8
 WkFDXOYOPiNL/sJqJQiaLLsNtsRADtth84XmugYx2qe4p86i/72pnLVkAgE/A5qM9B5j
 l6zq4WolPlBis9E3yWrcz/8fjzvoLPsAx6C3I6sBez5wuZMnNbySnCLbvu4KYv+6kSZR
 lylQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795157492; x=1795762292; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PtA8qFFBXG6iEUpmFm1DFbbkNSGlt5cA5Pbfh67zRN0=;
 b=w/Ahuhnzm6ZRb1FyJaY2gTa6Dxnp8FHQ2ntn8armPDkRcR1vCnFT4/1tbtPlzIPZlc
 mQElu7Nn3x7jSXkRcKV9pM8ywzeGZVEJnuHvWmhCZSNDWHHRDDybUdh/L0H7GHk/aKVb
 l1ctHpYAGcuzkO24TkWu85jLqMyapxyurAusiJozYLgje47mqFMKrk/HX1fztHq1ZjB0
 50PoO4B1fEqM7ePqb3FP4Tp96X7AnienrtseaDZWhPl9HLSNt9H2vhGXuELh6trdgYIQ
 8yu4GsoqMoJMFJ67tzjv/SqeHnFOiuUTOTmRlGKhn3/TXyY9K83lJL4hGj6TNXDZg4yI
 PfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795157492; x=1795762292;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PtA8qFFBXG6iEUpmFm1DFbbkNSGlt5cA5Pbfh67zRN0=;
 b=v6PrIZlpFU7whDb3ZnFbhrdRqYWejDllCW2b+jXoScLZ8si2GjYnC//OAlzpybNU7y
 71mN2c7DDHac9RmN1TM0EYQ0w6KcRqPbXPJqVVUa/8Jn0Q4ZxKkYlkakvXjPsKWxnGfx
 pS5IOCphsQlwnAQlrtHbJumAGlnWZ+qh09oOKlrgLiPPk96GlBzKsz5ISuJtEJ//3z1n
 Y7x6vtlTo866RKQDOXHO49ijNbXhn6asJ0cek7l4XpG702YNzNT27hMg5Z2+0/mVRQPB
 vAqB/lkzS8tIBJ6RRH7lfEDT/gjIRWU6NKMMxbJxr/RzF3umpVc0LVhczpI7iEYPsIdU
 aD5A==
X-Forwarded-Encrypted: i=1;
 AL+hErF1s1gKItDpx1VqGf3vIW0n1ITXAlaCx8ryAC484OJ0Wo3Dc1++6wOgfndCDuqYN5hmopAY29iHU6A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/BE3300Z8mjbWa33K62+c2edgVqQGzJvI5PAZiXJGQ91PUejvs
 JhG9ag7DY4lM71PgkYroCGoNTy5jZuQbYGojAw0EI40Pdo1f1KYEODH+mo15qxuZcSRJeoCdi+x
 LoC4661eaOspJq8K85tfEg186YozFh3Y=
X-Gm-Gg: AYBFou35Q16kAIWrS0U+CIWmjdp+s/TeMRCz67H7Ch6AJ9yz84k1IXDnUzMKSxLQEEb
 lIVymvCQbjX38OO+lLB4A7GB6X5gMhXlFuqLPkhBaS+k+HRwAMryh6PDL0dcanGbLksJgCci0vi
 5llEkUN53aw5M1u6gjDXvoq9cMmgoHouEbW6ENobpCbL69/KPDZE4iEPszgo45WQ4MGndq+R4+g
 rNk8wa2J3qLUFHFAiI0PKT0VSD8R0BvNsnrJsBzdlLmuwihp1mzb1modbSa786h8H1CWvWVaLY4
 36H/ClHnM9sXN0tRj/9p4unmeDfigc1+GAbei1vLmlE87lh5LEyGzBCKRFIkYWwZfZDkXLyAR7p
 WBXA5W4nqszwF0hGmMEDrOcMFsG/f6PFxu5AXa4Jp41OVYwkIv583fJ4D+8jRqzPJ+zvywOTsJz
 JJkow0t0MO28eHkr5iepcZHL2DCLc0D24=
X-Received: by 2002:a05:6820:61a:b0:70b:960c:53d2 with SMTP id
 006d021491bc7-71b39293479mr2191361eaf.1.1795157491577; Thu, 19 Nov 2026
 22:51:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-10-tzimmermann@suse.de>
In-Reply-To: <20261119142114.152052-10-tzimmermann@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Fri, 20 Nov 2026 14:50:55 +0800
X-Gm-Features: Aa3M54oSQae2g29PSYOCxYYXAOYr41DBB5dj51KvljQ-LoxuIq1mgzPJn0qEf_8
Message-ID: <CABOQOSWQtK8mxAR0c9HDSc0=j_hzPz1hYHDk-XF5ERcfdgq0Ew@mail.gmail.com>
Subject: Re: [PATCH 09/11] drm/udl: Synchronize pending URBs on each frame
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, sean@poorly.run, tiwai@suse.com, 
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 14:48, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Wait for in-flight URBs from the previous frame before sending out
> the current frame. Throttles frame rate to USB limits.
>
> PC display usually runs with a refresh rate of 60 Hz or more. Sending
> out URBs for each frame at this rate easily overloads the USB. This
> results in display lag up to several seconds. Udl currently avoids
> this by limiting the number of URBs to 20 at a time. This prevents
> overloading the USB, but also prevents udl from using all the
> bandwidth available.
>
> Solving this requires more flexibility in the number of in-flight
> URBs. The exact value depends on the framebuffer configuration and
> the available bandwidth on the USB.
>
> Before removing the limit on the URB count, add another means of
> synchronizing the frame rate to the USB. Do this in atomic_begin, so
> that the USB has the maximum time between sending two frames.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/udl/udl_modeset.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index bbba1dee8e4f..caa0a117e3c2 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -329,6 +329,23 @@ static const struct drm_plane_funcs udl_primary_plane_funcs = {
>   * CRTC
>   */
>
> +static void udl_crtc_helper_atomic_begin(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> +{
> +       struct drm_device *dev = crtc->dev;
> +       struct udl_device *udl = to_udl(dev);
> +       int idx;
> +
> +       if (!drm_dev_enter(dev, &idx))
> +               return;
> +
> +       /*
> +        * It is acceptable to briefly block in this call, but
> +        * having it timeout frequently indicates a problem.
> +        */
> +       udl_sync_pending_urbs(udl);
Using usb anchors might work better instead of the completion I suggested
in the other message. usb_wait_anchor_empty_timeout() could be used.

> +       drm_dev_exit(idx);
> +}
> +
>  static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>  {
>         struct drm_device *dev = crtc->dev;
> @@ -395,6 +412,7 @@ static void udl_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_ato
>
>  static const struct drm_crtc_helper_funcs udl_crtc_helper_funcs = {
>         .atomic_check = drm_crtc_helper_atomic_check,
> +       .atomic_begin = udl_crtc_helper_atomic_begin,
>         .atomic_enable = udl_crtc_helper_atomic_enable,
>         .atomic_disable = udl_crtc_helper_atomic_disable,
>  };
> --
> 2.56.0
>
>

Best regards,
Jie Feng
