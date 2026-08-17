Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D194AC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3745F10E2B6;
	Mon, 17 Aug 2026 12:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EA4nafOh";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2565110E2B6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:51:25 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-836c8cd38beso2032697b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786971084; cv=none;
 d=google.com; s=arc-20260327;
 b=CWadv7/mXQ6lw6NDlRj+z7ZE97bzCU5INHrRI0bJy+SLYSMTMSaWdsKzqvD3AIjhDi
 64a8hKWcbqEp/k5LjPOx9UuaYZt2670h5VbtL2eDmcyHhct3IdTY9LfQ1tR6gHMj7Hm2
 1UBuDhhfhZM85DgdHbAuV+3HWAufE91HuaopnZv1B9P+UY5oBQq3QGOaTFV8TtgfAA40
 wmTr1QDDk+FpNDnmZyyDl5MeYv5hgPRQM8lwvU5qmhst2Nu5eLl9gPZxxpIu2YCbMDRu
 rj/z7aUue7FRMqMuFdXI5UpJ4BxMI5e8qhnECDvLtfGV218qRfzl/OQndGk+nSASF4h1
 nnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
 fh=PVZAG0Tk236lfq3LcnL5qIZVTET81wZ0oGj2bbsiHQE=;
 b=MgonoO4Ua3SdH0tMxzEmV3yXZ2D7432zDFMhuwlxOsetgppksI1yoZZGXtmFm1Ghj4
 4fgrRVgEqYkHCHW+wcPWfNkvAEil5/rsmWTUgI+uhRSQhQkuqkzzdR2n8ye8nkhyam3L
 5wmn8P2BNyzjDUUE646qF85eDMjSIVPKMvrh4MkXxweX7Rnq4HfGt3muJa9EhWoyNvVq
 IrRFwWfKCmoX2XzlsLOGIoMPhQbtqktnJR2zJxT3xqEXtKZ2zcOVaX6zOS0OwbK74m7O
 SXsNsLlxWyrCnb+NK8gCXHAdq6DExANpr5dc8TSwXMhwncyWuoaABTydq5fPImcz3sE1
 Hfjw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786971084; x=1787575884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
 b=EA4nafOhkZBtdv28LVHIyUJnPrH+Gp8yfuXE/HPZQq1pMm88/HNZ7wk3lZIsLzwOqb
 HevOoCBZQULZgKzsJz0ln4IdYeicMT+Bv4rwG9cNu5sTDJjDFv/RsBlqq9uxf/04yCem
 ZG8Wu4F9bGyamf6Eg/QpWf/B3he7XQMQceXuUmgh5b3hEJIPZVTILGRV4Hgp5GmPGXcs
 KNadUuriUXnxMUvW2e7HXNU7nCWK1CPL1qgpmDZ9qWh7dgl4qDjDh51yVJCKlGjm+ohU
 4aWPjFXY0Expa3YDY99ef9PVBELWNy0+ashnjCE02Bkt5U0/6o4Kj9Z05A+YLg9LKb2x
 HByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786971084; x=1787575884;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
 b=fs5TAqoMYObgqsc2D/EoizHOrxTDexIuQTLdOkPYIxhHBE0jEB6+JB0fEzJMj3nxAq
 XRNpH2npHMHkg+bMYWfq5+z7g07ndFpCri490gbdz3sG4uizkkVuMnkQfsi4KTmHe72X
 ceQz9R21eaAT1uHoT3s+dTJV2qsVTi7ALfXBZjTwIWwEpEMstlJnkJjtieXqgP91F5wq
 C5JKdachHEl6lSvpZP0AiJx+Mz+9QsaVAqAnAlA+NBT+2JtR4DuTpNc6BFwTNWZPywqt
 Zi/874TfosKL3SAlO/MyKSJGRhiYZdSqPehrKpCSIr/NRChC9cOXLSjucu35pSVLiTpI
 C/Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqgFdVlWLuhrb0BrHpNZsLeSvh5Sg2FmQC91eskLr1eyz9PEsylZGiIEiLPZAXPcc1V9ihj+NjnvE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+8rGzl9oFO/aBCODdVg9WGCmsBO6QXvwWXFpVmf8ZBkJvq3fG
 q69rhwRIJjsa2RWB+YxmqB6Jkk6qa/uu11RDQJztnAajHhQjdhJqaS9QJhETtY1BRBp2oEPEB7c
 Ld8UOzfiB+zzzByuI2UuFcHZS9O08aCk=
X-Gm-Gg: AR+sD11WwktaVuo4cW65neeJztEGlmybWmjFC/004FcnrsVqmRPpCBJslRRg9n06gCA
 xjstFz1PJ9qOlwQgJJRjNTG3eragYceaJgpCtPRrBqXNvArQ7GYlj1kM00jGsvwzp5kZ6gHO/rq
 fVf6u1+XI2uMPlZ/MgTTYiSZwBWmA2Anvrj4ev3oUKSDq3Mv4xYxJ5dF8jGCN0YuxswYgMCCaDG
 uVHs0uiLuVooS6ZEKKJPxVEd+5Qi+I0z4BqzOtpGhkKgjHqqGpV+hrmxxoys9j9u7b6rK0VGUZV
 S9GACf8pVQseH7Pga80Fkq19zlRdxbhxhpnLGVydH7/+rqIg5AD18g41F8hc9yAiRWMdDmrqn30
 1Chc=
X-Received: by 2002:a05:690c:b0f:b0:80d:5c71:d08c with SMTP id
 00721157ae682-8371308c88amr90606897b3.3.1786971083604; Mon, 17 Aug 2026
 05:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-4-gahing@gahingwoo.com>
In-Reply-To: <20260817113603.1436067-4-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Mon, 17 Aug 2026 14:51:12 +0200
X-Gm-Features: AcwNN1W5X2wGC2Q1I1TaTBqzvN2kUY3psEQZvOBiX0NX6cHaLHwnhi2fG-mcjGs
Message-ID: <CAEWPSH4VAR5VTJUW4PdJczrtueQzPzzo6og8PzWaupwd-t=BFQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] accel/rocket: factor the completion tail out of
 the IRQ handler
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
 ogabbay@kernel.org, zhangqing@rock-chips.com, chaoyi.chen@rock-chips.com, 
 diederik@cknow-tech.com, alchark@flipper.net, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Jiaxing,

You asked for a look at this one, so I checked it as a no functional
change refactor rather than only reading it. It holds.

I reconstructed the three source states from the posted diffs and built
the before and after with the driver's own kernel flags for arm64.
rocket_job_handle_irq() is static and inlines into
rocket_job_irq_handler_thread(); at -O2 both states emit the same calls
and the same stack frame, and differ only in which side of the branch
the rocket_job_hw_submit() call is laid out on.

The load bearing sentence in your message is the early return, and that
checks out too. At -O1 the pre-3/12 code emits mutex_unlock twice, once
on the path straight after rocket_job_hw_submit() and once at the guard
exit. That is the scoped_guard cleanup firing on the early return. After
3/12 there is one, because the return leaves the helper and all three
paths converge on the guard exit. Both versions unlock exactly once on
every path.

"Nothing follows it" also holds through the rest of the series, not only
here. 10/12 is the only later patch that touches rocket_job.c, and its
two hunks are the defines at the top and the PC_TASK_CON write inside
rocket_job_hw_submit(). Nothing is added after the scoped_guard in the
handler anywhere in v8.

While reconstructing the base I checked where the series sits.
drivers/accel/rocket/rocket_job.c in next-20260814 hashes to 3141f210f,
which is exactly 1/12's pre-image, and applying 1, 2 and 3 in order
reproduces 5f0f9682e, d484a3a6f and 0bb11c718 byte for byte. So these
three apply to an unmodified linux-next rocket_job.c and need neither
the RK3576 patches nor my clocks-by-name patch. Tomeu, that is meant as
information in case you want to pick them up independently, not as a
request for a re-cut.

Reviewed-by: Igor Paunovic <royalnet026@gmail.com>

Regards,
Igor


On Mon, Aug 17, 2026 at 1:36=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_job_handle_irq() stops the block and then either starts the job's
> next task or retires the job. The second half is a step of its own and
> reads better with a name, now that taking the register writes under
> job_lock has moved it a level deeper inside the scoped guard.
>
> Move it to rocket_job_next_locked(). The early return that used to leave
> the handler now leaves the helper, which is the same thing here: the
> scoped guard drops job_lock either way and nothing follows it.
>
> Doing it as its own patch keeps the locking fix at the head of the
> series minimal, so a bisect that stops before this one gets that fix and
> nothing else. There is one caller, and no functional change.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index d484a3a6f..0bb11c718 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -341,6 +341,25 @@ static struct dma_fence *rocket_job_run(struct drm_s=
ched_job *sched_job)
>         return ERR_PTR(ret);
>  }
>
> +/* Start the job's next task, or retire it. Caller holds job_lock. */
> +static void rocket_job_next_locked(struct rocket_core *core)
> +{
> +       lockdep_assert_held(&core->job_lock);
> +
> +       if (!core->in_flight_job)
> +               return;
> +
> +       if (core->in_flight_job->next_task_idx < core->in_flight_job->tas=
k_count) {
> +               rocket_job_hw_submit(core, core->in_flight_job);
> +               return;
> +       }
> +
> +       iommu_detach_group(NULL, iommu_group_get(core->dev));
> +       dma_fence_signal(core->in_flight_job->done_fence);
> +       pm_runtime_put_autosuspend(core->dev);
> +       core->in_flight_job =3D NULL;
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
>         pm_runtime_mark_last_busy(core->dev);
> @@ -354,17 +373,7 @@ static void rocket_job_handle_irq(struct rocket_core=
 *core)
>                 rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
>                 rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
>
> -               if (core->in_flight_job) {
> -                       if (core->in_flight_job->next_task_idx < core->in=
_flight_job->task_count) {
> -                               rocket_job_hw_submit(core, core->in_fligh=
t_job);
> -                               return;
> -                       }
> -
> -                       iommu_detach_group(NULL, iommu_group_get(core->de=
v));
> -                       dma_fence_signal(core->in_flight_job->done_fence)=
;
> -                       pm_runtime_put_autosuspend(core->dev);
> -                       core->in_flight_job =3D NULL;
> -               }
> +               rocket_job_next_locked(core);
>         }
>  }
>
> --
> 2.43.0
>
