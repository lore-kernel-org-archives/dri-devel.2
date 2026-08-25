Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A042FC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E774F892C1;
	Tue, 25 Aug 2026 12:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q2yRQNtp";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D3B892C1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:31:32 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-66787b93a0aso582784d50.3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661091; cv=none;
 d=google.com; s=arc-20260327;
 b=N4wGk2RcDT6roMe6Ime0X4t1I561lxiBPuPAWQvBXAXQq5Ochlpcmdh49w/u5VsW1r
 5S4yd4XGdsSF53HByzwzcXL6BvUKNyx3MaeoIHHr2H6P0AV/l7UXlxnK+NH+TtSN10Cf
 Q1Y+B+M1W73DJgG/UT6w1y8ah4wNp/Hc4cbNaRJOGdBbX46Hb0/S9Mvnk1zq8mu6RU5O
 K4I4gjUjRRHnGUgGSG4cijwwx5+a0iCUMn88vvkRaK3bv7KbvzxxbiaMQgG8BQirUxNX
 nXy5MAULcMUF0RqJnr1AkyOJCOTSzLfGD+RK7Dg+tBFwcshgz2T6YItrtHijAzKrkoFC
 rfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q0gYjv1ucDokxKoaaL4BAfVfT4VkNcel3INzlS65MsI=;
 fh=1BaU4/HAwYPj7l7biT/7OI1RWXiNFbk8TIEt3RmFd5c=;
 b=MKG67IqEERMDiTyuRu600tHC4iYzFCTXJ/DjKwtAzEcOgwLIO4urDxvjb90J7KuDWx
 JchsGNyYuHM4RVCAeD09BS6VqfHCHN9R3vZpslTvtLNtzejNhM1Zeugw1poG3FL/nk0+
 HF3ZN6gu7TomeSQCuFIte1h249qi7lL9Kz8pK7z5wQB73xoYlCwCu6DTUgmdnQmzncfZ
 NlgjRYrPCMPenCXTyOV4GlL0YgU+IHkaeM3rhKxqfBXdUcYGN7wTapkn4+aslv0eg7nL
 k3npGwSQ5Hq9odXBHuDQ2G2/JTvpzWcXMUqhYEY/CoVj8a0e771qOtdCXN/vbs43tF5/
 QQqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787661091; x=1788265891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q0gYjv1ucDokxKoaaL4BAfVfT4VkNcel3INzlS65MsI=;
 b=Q2yRQNtp15SqfAi4x765cZIfQWdHdMhak+WfqJNGAHVn7b3+pG6MKqI9UOv4tCEHcx
 mo+DzSvI9f08vZ8QkVU4z1smH7Kzg/dTr7/Kifn3pwnFs+xi2MHmR37D8prowK13v9QI
 4/1Tjbn9g2upuEPdNQo+dlJ4USL5W7TF4mxOMWj+KntQ0ZP6XLTe/7qX42Y2nOrl0HbV
 nY2v8AO9TcrFNvcPO7dM6/B0BruXmh/CLFrTAi5qNsNsgLtW+7XUBbYzDRoxKBO4GtVz
 5WthPtd4//43URyBy7bdbJwoL7zcWULWgl9Yy1JMdGf01yF5jWKmo1iIk+hc6qeSF+07
 ePrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661091; x=1788265891;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q0gYjv1ucDokxKoaaL4BAfVfT4VkNcel3INzlS65MsI=;
 b=qvZJa0IPwNtA4bvob+uZvhFPNRVyaV5kop658ugyZH0GJwZtIEDBAGlIjSwb4qlf/i
 Rg+PppWwEbsuAOMgfw3pINDzyK2Jeb0z9EobC9th2/8Ivdw++PRogCiFrAlHqcRrI9c6
 iOQC5JvEYSx7pNxaba4M0LWSB7pPYJOcrXh2giIZSNe6k10MLyeX8RHR44GBwI/Nvkro
 h/7RwbjhH/HELfmMoNHAHW9f81kOGmSkhadsgN387eQP2gC3ujWonzLjtCU0nMU3FIKV
 zy09TlOOd38EQ3DUMm3nCukKQWnduI7pPNGv+EbfJp6fslen4wbuL/C9IxJlwcFPoAUp
 I79g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+oy+eHHF9bs+NmXPipjQBM+fVgRSkqd3DapEcaonsJGfHATiYkAbsSb0I6XFgbl/fNbhdQto98+4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWZeGd8iDgF2NFp2SZe+VeLd1iIA5MlJQYmoVN1l4n+C3a/Doz
 Rc579SKLv0tKlrfKKmV4AIk3tHexwgJyzCFhdl+QWl9B/WTF0La2gPjUs+GddteilxK5anLNtwF
 ZwAWW/WO1uJa83NV2WQoFswMqy+/9W60=
X-Gm-Gg: AR+sD10DcvOeGPc01VAmCu9sjgs69Rmg4BTrhzsHJlmYtxhMkn1Ahq1B6tXl4e5fXsP
 9zQwLN++5vmWdFrMbct8vOGH7p1b1XUasNhNzkPyzD/7SFhPXCMUlbj8QsBUjCdpa4APA+bIotl
 xSmBrM7spJnuDnRlGNRLM+pukcO5Og1zBeM/QQLzCEzyLcYz7tQ2jGqn0QsmOewnn6wvDMsQCgE
 vF10aPLS+pISyunt7L0SFarNRZAYSwr7lzrkyI0Y9lBzzOIDvLGwkfNRvHsvPdhoUS+fRyNpuV7
 XcWsMiLd/G3Q3io9vA1rOSA0aYJ/nS49CuZ5b0JLG8/MbQ==
X-Received: by 2002:a05:690c:610d:b0:81f:45f0:21b7 with SMTP id
 00721157ae682-854bd19ce2bmr22184007b3.0.1787661091147; Tue, 25 Aug 2026
 05:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <7d47bbef8b629eb287fdfa3e8d6c62b95de6b61d.1787568944.git.gahing@gahingwoo.com>
In-Reply-To: <7d47bbef8b629eb287fdfa3e8d6c62b95de6b61d.1787568944.git.gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Tue, 25 Aug 2026 14:31:19 +0200
X-Gm-Features: AcwNN1UBjSiDmBbvi-rdrGxY2QMseNtuQmYMP06jtM-iH2d8s_qF62MX0JMUhl8
Message-ID: <CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com>
Subject: Re: [PATCH v9 02/13] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
 ogabbay@kernel.org, zhangqing@rock-chips.com, u.kleine-koenig@baylibre.com, 
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
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

As promised, the 19 August protocol re-run on v9, as-is.

Setup, identical to the run reported against v8 1-2/12: same
board (RK3588, Orange Pi 5 Plus), same personal 7.2-rc6 tree,
same config (PROVE_LOCKING=3Dy, DEBUG_ATOMIC_SLEEP=3Dy), all three
cores bound with scheduler-driven placement, and the same local
test-only patch lowering JOB_TIMEOUT_MS to 2 ms. The serial
console was captured on a second machine for the whole session.
Two passes per kernel, at console_loglevel 8 and 4. The only
difference from 19 August: the two rocket changes on top of the
base are now v9 1/13 and 2/13 instead of the v8 pair. Both
applied cleanly.

v9 arm: two passes, 12 and 11 induced "NPU job timed out"
resets. Every reset recovered, every inference matched the CPU
oracle within 1 (48/48), including the one issued after a
forced autosuspend and resume. No MMU faults, no raw reset
messages, no lockdep hits, nothing on the serial console.

Differential arm, fresh in the same session (same base with the
two patches removed, same config, same timeout): five runs -
the protocol pair at loglevel 8 and 4, plus three extra runs at
loglevel 8 to gauge repeatability. Reset counts 8/10/12/8/15,
all recovered. Four runs clean. One of the extra runs came back
with something I had not seen before: the inference after the
forced autosuspend "succeeded" but returned a constant buffer -
all 48 output channels uniformly 128 (0x80), which is not the
output zero point of this model, while the CPU reference varies
normally. Zero kernel messages, zero lockdep hits, nothing on
the serial console. A job that signals completion while its
output buffer is never written is exactly the silent flavour of
the race these two patches close, and in 102 induced resets
across nine runs today it appeared only on the arm that does
not carry them. Full artifacts are preserved (scorer output,
runtime and genpd state, journal, serial log) if anyone wants
them.

Before testing I also compared the tagged patches against their
v8 counterparts: 1/13 is byte-identical to v8 1/12 up to the
base-commit trailer, and 4/13 is identical to v8 3/12, so the
tags they carry describe exactly what was tested here.

For this patch:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three
cores, induced reset, differential base, JOB_TIMEOUT_MS=3D2

Regards,
Igor

On Mon, Aug 24, 2026 at 1:09=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_reset() calls drm_sched_stop(), which stops the scheduler and
> returns. It does not wait for a threaded handler that is already
> running, so the comment that follows, "Remaining interrupts have been
> handled", states an assumption rather than something the code arranges.
>
> Call synchronize_irq(core->irq) after drm_sched_stop() and reword the
> comment to say what holds afterwards.
>
> It has to go before the scoped_guard(mutex, &core->job_lock) rather than
> inside it. rocket_job_handle_irq() takes job_lock, so waiting for the
> handler while holding that lock would be waiting for a handler that is
> waiting for us. Nothing is held at that point, and both callers,
> rocket_job_timedout() and rocket_reset_work(), run in process context,
> so sleeping there is allowed.
>
> This does not stop a handler that has already read in_flight_job from
> finishing its work on the job the reset is about to drop. That window
> needs the check and the register writes to be one step under the lock,
> which is what the previous patch does; the two are complementary.
>
> Mask the block before the sync as well. INTERRUPT_MASK is armed by
> hw_submit() on every submit and cleared only by the hardirq, so on an
> ordinary timeout it is still live and a completion can arrive after
> synchronize_irq() returns. Nothing is lost by clearing it, since the next
> submit arms it again.
>
> That write is the first register access this function has ever made, and
> it is guarded, because the function holds no runtime PM reference of its
> own. The only reference in the window belongs to in_flight_job, and the
> completion path can have put it and cleared the pointer before the
> timeout worker arrives: drm_sched_stop() sits in between and can block on
> cancel_work_sync() and on a dma_fence_wait(), and it subtracts every
> pending job's credits, so rocket_job_is_idle() is true and
> rocket_device_runtime_suspend() will not refuse. With the autosuspend
> delay elapsed the clocks are off and both NPU domains are down. A
> register access in that state takes an async SError on this hardware,
> which is the failure two later patches in this series describe from the
> power-on side.
>
> pm_runtime_get_if_active() resumes nothing and allocates nothing; if the
> core is already down there is no live interrupt to mask and the following
> synchronize_irq() is all that is needed. Igor Paunovic asked the general
> form of this on v8 -- whether rocket_reset() should hold a reference --
> and it was deferred then because nothing in the path touched a register.
> This patch is what makes it matter.
>
> The deadlock this placement avoids would not have been reported. The wait
> is on desc->wait_for_threads rather than on a lock, so lockdep does not
> model it and it would have hung silently.
>
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 34 ++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5f0f9682e..3c0ed4605 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -377,9 +377,37 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
>         drm_sched_stop(&core->sched, bad);
>
>         /*
> -        * Remaining interrupts have been handled, but we might still hav=
e
> -        * stuck jobs. Let's make sure the PM counters stay balanced by
> -        * manually calling pm_runtime_put_noidle().
> +        * Mask the block before waiting. hw_submit() arms INTERRUPT_MASK=
 on
> +        * every submit and only the hardirq clears it, so on an ordinary
> +        * timeout it is still live and a completion can arrive after the=
 sync
> +        * returns. The next submit re-arms it, so nothing is lost here.
> +        *
> +        * Only when the device is already awake, though. This function h=
olds no
> +        * runtime PM reference of its own: the only one in the window be=
longs to
> +        * in_flight_job, and the completion path may have put it and cle=
ared the
> +        * pointer before the timeout worker got here. drm_sched_stop() a=
bove can
> +        * block for a long time, and it drops every pending job's credit=
s, so
> +        * rocket_job_is_idle() is true and nothing keeps the core resume=
d. On
> +        * this hardware a register access with the domain down takes an =
async
> +        * SError, so a reset must not be the thing that causes one.
> +        */
> +       if (pm_runtime_get_if_active(core->dev) > 0) {
> +               rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +               pm_runtime_put_autosuspend(core->dev);
> +       }
> +
> +       /*
> +        * drm_sched_stop() returns without waiting for a threaded handle=
r that
> +        * is already running, so wait for one here. This has to stay out=
side
> +        * job_lock: the handler takes that lock, so waiting for it while
> +        * holding it would deadlock instead of fencing anything.
> +        */
> +       synchronize_irq(core->irq);
> +
> +       /*
> +        * No handler is running now, but we might still have stuck jobs.=
 Let's
> +        * make sure the PM counters stay balanced by manually calling
> +        * pm_runtime_put_noidle().
>          */
>         scoped_guard(mutex, &core->job_lock) {
>                 if (core->in_flight_job)
> --
> 2.43.0
>
