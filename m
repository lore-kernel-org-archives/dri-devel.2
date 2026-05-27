Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AEACD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 16:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFE610E262;
	Wed, 27 May 2026 16:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HgTHkkXs";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B29E10E7F9
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 16:31:33 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-65eb226b1ceso6276811d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779899492; cv=none;
 d=google.com; s=arc-20240605;
 b=QpOZpVZnFR2vKscvj1ijvg5K2J7Z/NPj3YejmFwBRdIU0wff172VPyN86DClnhqm5g
 u0dBW2tZ2Rt33o5/KNQdxseC59nWGcEp52FhQmfFq1wE83ISu38Vq/vptyIOxa23gXyp
 1rHOlcqC2InFzBqLxtzTQEbiI289Gaj3d6VEbh4HO9cLXWIDoIXB1eWNFds44RxHMJCD
 F+q4GaqNceV4He04ypt7DZEeHNwtRBpJ4n6s3eis49RX7pFZK/1o2CorfsRFwUD9e0s9
 JzTvFnt24Njhit3C9Wypz1O2ofB88tJTLe8UYa92oQW7MWaUz8UYu6MvjQkL396dhLmW
 J8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
 fh=FLJoI97oVfukxeyLfZTn0UF4ncIO5JC6GcpWzwjd0RA=;
 b=f775zTQbm4tCcQIiUsmMinKMfr/RSoi618v/7eEzxpzJ6ia2k/xL79bQXkRqCyDzbc
 6r0mk/INo7rbLzGWZUsR8jdeJr09EhqINa98h6fzu8vY831LB9XuW1xyEBggh1SuA0Pp
 U3jOFNIaXaqamcZWVIflA1UZZwN24kC0PbGahsJWBAkzuNEtQpv7CgaUiM1i6tZGOK1p
 Op9FLLwVealvwrdmtRo+eM19qb2d6Rc+Ul/pPeFFNR21aYm1gKfoXy+m0+bUldwS09IG
 BvMmeS6TTx/ElRz6rc9pvmIoUVQgkOju3ZfcMcTx0XdHUlyFKyzwUAVlWRAVbdpemXXg
 63IQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779899492; x=1780504292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
 b=HgTHkkXs1YFtJgdmjxxPR2z72ubtM+as7l37XQ2VN55lTUEkJBMJuywBSlctIswxlm
 xp9wFZBdUgyGKMJ3Gs6/oqMhwLInDsfdetp9FwQDtZ24W3a7vbWGMKpr4v1/rWox6Dga
 uE9dcomPb9JFzqpg/Ekg7wSiIR+BDs+2GF4QDa1OHTWW6WiFu7val09x5Mh08K/FcQV8
 7wrUP0yB0tWZ0rrWCXot6Ptv5XrPLeeLxnw8E3jyLPJDt1ekPcJpxMxQPcHYPKZVJ1rw
 jtbS+mQ89/DtWqyLhyWUnXe17bwJue4IWx+M+2HI1XqMb7B5WB6GoZseJmq8YJ6QHYWm
 WnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779899492; x=1780504292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
 b=TgMNLTJoeSa7PX+8vJDA0BP/AP/6uSYtkSRYkhwvTE9zzFOEJE3PLFNA30/bXdu9nx
 l4ssXBvEpec0WDX86le6puqLT0+eNaDNVAnczYIBnHVioj2E05eMK3GzfkrqImbBeO9w
 tYipHELzdj2MRBt2xacpICCNAH4A0KVbvOhFsEj0M+zR5oIIBqoPCC4vpMiVnKEJ2cFw
 czXFdgAvYRv0p/rkhTFwZD0gszFnxLQ2EljZzESbJ1qw3sNAAp23JkmD3ciYvzy09FMx
 vEOJcgfyfgyRpk7DcFS7DsqUImAqraUiiWsgTtUnkPKg4QR5230niFuPrY4EO9xAot11
 VMUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+y0qzhUjP9kIOSj4yewlarEY8PmfzpDCJYb7ThwNxoSZtQG76KSAIZ3EihSaArlRtUtE8TQSxdW7s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1c667h0Q64m5XfqYy6aQUJK1VllUswX9n7UDy/st77uTMZfoF
 sJ7ucYBDM4mFxcjmlPEcNADZl+Kvu1ducgUi94B+GIAjdmHBFScDhG1bvv8H/K+0YkMo0gSZagK
 wZXmPxhH+2DOVFWu6J+1NP5+QmtWLX/M=
X-Gm-Gg: Acq92OG0gHA89D3FKfxzH2MPLt4Sswhw9qacNKF6RsTMaBlX489ltgrzsoW+t3ixGD4
 Rh8OhXZ0IbFf/FMJ6d3uOFZT1i4GkfQ1TTmaVIDS8YipdYVVliGOrdO8zoUm+70Uu1OKM/70Q+f
 L6OdQj2U32pKD0tBGp9O4sElc+BS3C/phcgNT3yvZHgW6ur5xnKKjiIQd055L0oHgsjRFExG+2y
 B+cMGf/u08pCpS5ssQaAyE1a/tjraQ6KpM8PeL0z/RD4ABv4A03GXlGWBBM49FElbJJCqew/3CQ
 S7F+PHwO4DcUxAYINY9PS2pJKSTQHILw6GCkb5qvQYi6qvmQ03m01W+/boaCari47n8fQ4Gq
X-Received: by 2002:a05:690e:158f:10b0:65e:14b6:b1c3 with SMTP id
 956f58d0204a3-65ec965c9f8mr17896814d50.16.1779899491716; Wed, 27 May 2026
 09:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260527133917.207150-1-tzimmermann@suse.de>
In-Reply-To: <20260527133917.207150-1-tzimmermann@suse.de>
From: Julian Orth <ju.orth@gmail.com>
Date: Wed, 27 May 2026 18:31:22 +0200
X-Gm-Features: AVHnY4LiGKeklklqrya8rDzPqcZQqpOuXv9liIo0k9FzrL8MbPYNMzvo_QUUG_E
Message-ID: <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank
 interrupts
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, mdaenzer@redhat.com, 
 pekka.paalanen@collabora.com, jadahl@gmail.com, contact@emersion.fr, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mhklinux@outlook.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, 
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
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

On Wed, May 27, 2026 at 3:39=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
> refresh. This is meaningless with vblank timers, which run unrelated
> to the hardware's vblank.
>
> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
> for CRTCs with simulated vblank events in all such drivers. The vblank
> timers of these devices still rate-limit the number of page-flip events
> to match the display refresh.
>
> According to maintainers, user-space compositors do not require the ioctl
> for rate-limitting display output. Weston, Kwin and Mutter rely on comple=
tion
> events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize the
> time from input to output.
>
> When testing with mutter and weston, the page-flip rate appears correct
> with the patch set applied.

To avoid this being a regression, you need to test that this change
does not regress input latency.

As discussed on IRC, compositors use vblank data to predict the time
of the next flip event. For each device that you are touching here,
there are two possibilities:

- The vblank data is related to the flip timing, i.e. flip events and
vblank events are sent at almost the same time. In this case removing
these apis removes the path for compositors to predict the time of the
next flip event. Input latency will therefore regress after idle
periods when the compositor no longer has the time of the last vblank.

- The vblank data has nothing to do with the time of the next flip
event. In this case this series could in fact improve latency because
it removes the incorrect data from the compositor.

Whether the times of the flip events correspond to hardware timings is
not relevant. Everything in wayland compositors is scheduled against
flip event timings and they are also forwarded to clients for their
frame scheduling. If the flip timings are wrong/out of sync with the
hardware, then removing the vblank apis does not improve this
situation.

>
> This change has been discussed at length on IRC recently.
>
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-08&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-12&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-13&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-15&show_html=3Dtrue
>
> v2:
> - add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Michel)
> - clarify Mutter's behavior in cover letter (Michel)
>
> Thomas Zimmermann (9):
>   drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
>   drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
>   drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
>  drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++------
>  drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
>  drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
>  drivers/gpu/drm/tiny/bochs.c                |  2 +-
>  drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
>  drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
>  include/drm/drm_crtc.h                      |  2 +-
>  include/drm/drm_device.h                    |  2 +-
>  include/drm/drm_vblank.h                    | 15 +++++++++++-
>  12 files changed, 45 insertions(+), 19 deletions(-)
>
>
> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
> --
> 2.54.0
>
