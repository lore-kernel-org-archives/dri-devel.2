Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9298DCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB21110EFBE;
	Wed, 13 May 2026 17:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S3m5osUJ";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0027410EFBE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:14:12 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so6961316d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778692452; cv=none;
 d=google.com; s=arc-20240605;
 b=B8QwexzY8bJSadfvXZRDlF+4A1NHJ+xo3fkp8UMaP0Xcmd6jmd8myK6FW6Fdur1fye
 GC28wBr8Xf/v4TwS75WAcPiXSzSMcH7DX7UiHxeUhwEfPstmJpN7+C9+SaPwRePRhnKw
 IfP4sjlXUiHjVmN7QPuz0Sa6NfJYQpWOdPzFqVask5eonlJdn8cCZ+7RLQfwHdB16Rnv
 ZJMs/Jjz8HSyPK0Dbju8DgdkryLP6337oDvgZ3DXriWhHHoWQIuNqyr9Oik2Rrkp1kHH
 MTrtQZYWGmABSLzWUqdsy2z4ymHQUdrO0KIoIl6vHy6xkDwXuYKdSocb2Bw0mzVLHP38
 /RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oisuNanuMjz1L0GV1nlwcaNMrehOKNF/BX+HSx8SYko=;
 fh=V5rZVaE9rvGgETosbWkUh/O5MtXOoZ6duCLZ3hZCI+I=;
 b=lQCoX/y4I5BK/oClDhpn2UAmw5lLmkt2AWv0ECHv6uFIl0Ckhc857i7SDDYJrWaBN8
 vhuOJGme3l60NpGJH/o3L7rydDcZEd9SYXX3KT+JxvzEfWxGzzgm5NqUxoNJWOzB4HwT
 u2SVxa3tTLLsv9JL8q4WtGApYWfctxy08Eym64N3+UEt0QNyeKeg7I8pkAmmb/1aymuv
 1IsxFLcnP96rfEVurimEDT1sNmYUNeLzePI7NNfbvVSZAuHFIUKLyOn9va5y0htv26QE
 33WaMY/1WtPZGqAaeT5qQ7ZtbSlpD0BPH8eLptu/tj/ErIFz1eT3IS8IaRSklTOA987y
 vtLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778692452; x=1779297252; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oisuNanuMjz1L0GV1nlwcaNMrehOKNF/BX+HSx8SYko=;
 b=S3m5osUJdmhbkocdeHjQE1Gm+zYJIpuerb9ZmCoC9O/lLOaKdmLuR2T4pTlNZx7V0M
 HlguM31axy4ms0B68B/ymGpmr6hleJFLZSUd/ZKuB6sqHLx3NVCCJmUQ0Fpk8kEWpG3r
 HCFmUoTIPOEgXOmtxU5YJUgA9QeSJdsmvAD6F6XrNlQeHlGucLytvOz+qywC0VwRp/gr
 7toA7Q9GQk8S+6L99TaIDVngLiRELVcVt8eDU6Tn+ULkpZ3CkR3beSdB4y8TBiZzHlUi
 6Ut8KnDBDMxAjpXzpNv9cIAVJ8tWCp8d/WxTu+ga84xE0HV0JfAEHG3bynoN55uwBcO6
 pOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778692452; x=1779297252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oisuNanuMjz1L0GV1nlwcaNMrehOKNF/BX+HSx8SYko=;
 b=JMJn5fSO/uujnkgGV6Bh6lXSsafb/zlz4aIR/lUYaK+QaFbPZdn3H12E1H4t/9bJBt
 WcgYAp8nB6VUju0OE4JoivmU05EyjSYZtEiS14HRct78RuYzJJUaGdWXBxjpt5tbQhO6
 qNWRBtw08J7Ij0yFNqxJsgRypB+VFFP+TUGiGTKSUSEJtEBsDgbTDemsxxZIK1u3vHvq
 IuCq9r5fKorQTLaP++iVC+Nzc19Yk8bjYj+8FfI9A81me7XjCdcgv8yEfber3PbLVqVR
 NpbV9nvXVwtZcDqo+AVcy1tqIPVwlblp4a2IewQy72Zxno3YuLjoOLd4EeYKpnpJt3Zm
 cDgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Dykc4zD+XTDdJbBMBgV6Ebi78XBrDobvs43Qklmw0WW6fd7X4WpO4bbfUDuO1bjf2O9DIb8BZE2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGF4AkdCRll4u4x7NEqrUYLE/6qsZHN/K6LG+9hdn5wWdwhJ7y
 SWJatGNgQ7JHvT2NtAtjDcIxHMaysGP2DHj3j7zlwvgTgYVloFobLCzsFfGj9PUhLcIA9+CmH/S
 y+5WZjX128DA3Q+iCdJ9FfBeeuF1x3uc=
X-Gm-Gg: Acq92OFudI8W61il+5Kjj0LfekO1AsSY6K2C03A0XDDg9U5QBRQdkdZUm9YhvmNO0RX
 SIB5cxfha957qi/ZcD3ODS/uHD8Dw0xPFBx3+5t29ugI6z3DonVI8eSE/J05yjtm9WHwW8l8qZC
 nKmervlwFNVNvbcwSycg0PxHEPXXyBJDTHNw412SJtXmN8y9qWpw1RUrXanXjSEiRja2wGlCzmV
 pDZjCjpHiXgwKnKLnSdowAKttQS9yMGMjiIqprvHi7aDaONvdsisvyNKIcyCf/GDmwuSsNG2PQq
 O55fxpoLjuNE9iCTwKUGTirltXgChzupK3egsJlrP1AXUqkNpyA2moy6UW3UFzEfvlVXowzBIw=
 =
X-Received: by 2002:a05:690c:e14c:20b0:7bd:69b8:f2e5 with SMTP id
 00721157ae682-7c6ab5e75camr34700047b3.3.1778692452052; Wed, 13 May 2026
 10:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-8-95c614a739cb@collabora.com>
 <CAPaKu7Sx85JpFFJ_4w3mZ6_OPkCHDqp68Uo+RbeYx=5v03vdww@mail.gmail.com>
 <20260513104225.0c0992d5@fedora>
In-Reply-To: <20260513104225.0c0992d5@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 13 May 2026 10:14:01 -0700
X-Gm-Features: AVHnY4KwW9W05Bin1vca7LBrwzHeJsbDEynLFAXqK1gx7mQr6xrijvToQtbl7Ig
Message-ID: <CAPaKu7Q2FnhGkhY8i04TYOjnc5m4ssCDedfgsw2o86xkTh31WQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] drm/panthor: Automatically enable interrupts in
 panthor_fw_wait_acks()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, May 13, 2026 at 1:42=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 May 2026 14:55:30 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > Rather than assuming an interrupt is always expected for request
> > > acks, temporarily enable the relevant interrupts when the polling-wai=
t
> > > failed. This should hopefully reduce the number of interrupts the CPU
> > > has to process.
> > >
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > WIth minor comments below, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_fw.c    | 34 +++++++++++++++++++----=
----------
> > >  drivers/gpu/drm/panthor/panthor_sched.c |  5 +++--
> > >  2 files changed, 23 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/p=
anthor/panthor_fw.c
> > > index 8239a6951569..f5e0ceca4130 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > > @@ -1039,16 +1039,10 @@ static void panthor_fw_init_global_iface(stru=
ct panthor_device *ptdev)
> > >         glb_iface->input->progress_timer =3D PROGRESS_TIMEOUT_CYCLES =
>> PROGRESS_TIMEOUT_SCALE_SHIFT;
> > >         glb_iface->input->idle_timer =3D panthor_fw_conv_timeout(ptde=
v, IDLE_HYSTERESIS_US);
> > >
> > > -       /* Enable interrupts we care about. */
> > > -       glb_iface->input->ack_irq_mask =3D GLB_CFG_ALLOC_EN |
> > > -                                        GLB_PING |
> > > -                                        GLB_CFG_PROGRESS_TIMER |
> > > -                                        GLB_CFG_POWEROFF_TIMER |
> > > -                                        GLB_IDLE_EN |
> > > -                                        GLB_IDLE;
> > > -
> > > -       if (panthor_fw_has_glb_state(ptdev))
> > > -               glb_iface->input->ack_irq_mask |=3D GLB_STATE_MASK;
> > > +       /* Enable interrupts for asynchronous events that are not
> > > +        * triggered by request acks.
> > > +        */
> > > +       glb_iface->input->ack_irq_mask =3D GLB_IDLE;
> > We should static_assert or & with GLB_EVT_MASK. Same for CSG and CS.
>
> Yep, good idea, I'll add a static_assert() in all places where
> ->ack_irq_mask is set.
>
> >
> > >
> > >         panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN | GLB_COUN=
TER_EN,
> > >                                GLB_IDLE_EN | GLB_COUNTER_EN);
> > > @@ -1318,8 +1312,8 @@ void panthor_fw_unplug(struct panthor_device *p=
tdev)
> > >   * Return: 0 on success, -ETIMEDOUT otherwise.
> > >   */
> > >  static int panthor_fw_wait_acks(const u32 *req_ptr, const u32 *ack_p=
tr,
> > > -                               wait_queue_head_t *wq,
> > > -                               u32 req_mask, u32 *acked,
> > > +                               u32 *ack_irq_mask_ptr, spinlock_t *lo=
ck,
> > > +                               wait_queue_head_t *wq, u32 req_mask, =
u32 *acked,
> > >                                 u32 timeout_ms)
> > >  {
> > >         u32 ack, req =3D READ_ONCE(*req_ptr) & req_mask;
> > > @@ -1334,8 +1328,16 @@ static int panthor_fw_wait_acks(const u32 *req=
_ptr, const u32 *ack_ptr,
> > >         if (!ret)
> > >                 return 0;
> > >
> > > -       if (wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) =
=3D=3D req,
> > > -                              msecs_to_jiffies(timeout_ms)))
> > > +       scoped_guard(spinlock_irqsave, lock)
> > > +               *ack_irq_mask_ptr |=3D req_mask;
> > > +
> > > +       ret =3D wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_ma=
sk) =3D=3D req,
> > > +                                msecs_to_jiffies(timeout_ms));
> > > +
> > > +       scoped_guard(spinlock_irqsave, lock)
> > > +               *ack_irq_mask_ptr &=3D ~req_mask;
> > We should add a comment saying that this is safe because
> > {GLB,CSG,CS}_REQ_MASK and {GLB,CSG,CS}_EVT_MASK are disjoint, and thus
> > req_mask and ack_irq_mask are disjoint.
>
> You mean the ack_irq_mask set at init time? Because
> xxx_iface->input->ack_irq_mask is moving target now.
>
> Well, if we expand on safety matters, I'd say none of this is safe
> since it relies on the caller knowing what it does and passing a valid
> req_mask. But I'll add a comment mentioning that the original
> ack_irq_mask shouldn't intersect with any of the bits that might be set
> in req_mask (that's basically the static_assert() you suggested).
The callers of panthor_fw_wait_acks validate req_mask. With a
static_assert on ack_irq_mask at init, we are sure the two masks are
disjoint upon entry. We just need a comment explaining why
save-and-restore is unnecessary.
