Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB57606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K6r8+Znz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C346110E1DB;
	Sat, 14 Nov 2026 04:57:34 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D909810E1DB
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 04:57:28 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-4d7034a99a9so1861873b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:57:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794632248; cv=none;
 d=google.com; s=arc-20260327;
 b=cCYfCtypGGkNv4YZNXvK6t7Ja4dv0MX9d9kImpyajRn+si8IhuUdi6esoprQ646oZr
 8xujVo6+xeJncWQORyqmwgfbKXdgFDqf+kyh0+ioHINcfm41CcTf4vJrUuNtoLa8o94A
 cGsfo0dPzCkw7Zl4pEinED1WqLlzA9AMvLBlybJpm4poUFB5JDlDkgh+EcLqPDv6nTCT
 mVQbBbBxc0kmafzCosPeMzoPudTnH2keihYC0DCaxrNkFXsnbR33eswafGhFgojlgKec
 Ll9jH3QAA7MLiwENz0nQ/tpBAckzWaHCl+OOX01uVueCH9tVPDZC6X3W8apKAqJqup0c
 1YPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mAWpV1M0Nu9QZUQqIslKLnJ4FSbGHgAq0csTQNUImDg=;
 fh=hERwEpKOKKIYEsaQfGF0fjPlMsn1/U6t9j+Mnny1Dhw=;
 b=DhZHXe2hZIkQpIet2VrPYiugwGSJcIEseyD5RVlssfuLISgE0166Ml/UCVJxh0q1od
 uUgpSewJfKMyqrabX7XMQziGR+bggDpxB4U2m1IlUaF+MsT4uAgAmCI6ZmczJWnGla7T
 TZcHOnPKPQ0phub/TyyfYg86lAfoiqfy5e95i4eumNk5DU71Bn3t825C+n6Nb4OD4WIz
 IUkmJAqhmslc0oSHpWU5OKi8D1TkmoCJB1AhdB6IsdSuW2gPHfzYmBs0hYcGl6lzyroo
 vtyF8WMPLDgbxvbQGi1JP7q7c4EsiJHAIWhYKlhbstI//wmCa4xHMDbU49LYG8Dfvi/t
 iggQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794632248; x=1795237048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mAWpV1M0Nu9QZUQqIslKLnJ4FSbGHgAq0csTQNUImDg=;
 b=K6r8+ZnzM2CRS1TvTJn1TUICw19gsXKEcDVjufF2OlG2I8P0PE6F1DVXUdwtCmrPkB
 YZ76+eHsHGnkdOnkzba6zIGGj6ozVnKPv9khv09/zNYF+mDqideElpzzNAhWIOA8Coh2
 7MrhAg0ALa9KnSn7QbAJ/DK2rhIS/BJmlgNaFm7fOoI1EJBqzpAt5VPWnCd1SfEXmEKH
 yQQ6wp0fUYhGWLIaF2T2XtWXfUgSCOdgmy7kgIegGbceC8CqA2ahFUxplWKZQEo6/nMU
 DfWZwdgFZjXrRbSrFHezjUNi2SnLWXfp7YTqwnfwTz0cQ4N1TiQ7y+o2NY/OIMW7f43y
 7GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794632248; x=1795237048;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mAWpV1M0Nu9QZUQqIslKLnJ4FSbGHgAq0csTQNUImDg=;
 b=Nr9stwohIpiqxabqJuC+4qj30SwM8+dHhB8wpUM0Kyn55n+wDjwkiQlKiAtmxxsUID
 FUpeOPP1Dya+Qf9bp73FSpvdXRBdI1sZ7FKkJZGJ+qpdsJthFU+OZN3JxePhPeidd460
 +0oM4P6NehIdjFVgMdFmECzgqUyVAuPPza/P8scSxNjPT80OC3CEfU5dXKpH158zq7OC
 T5ANEMeUXq34lPyGRvbaV5WO8CoykWKKy0e02sIVKAwqcmch6F+BxTHOH4NkgF81l0oH
 LfvLMAZgqtQ/SK6rdgRb/5NFqBlIO3Oc1/VPoMY9zTw6oCq1JmRfGCJZFkZ4o8Rrm04b
 xImw==
X-Forwarded-Encrypted: i=1;
 AL+hErEK9aIQLZ6JevFlfCNhEI4ueNpJL6UtUp7Utwp3AKbJwKdir6GwvFI6/2vu6yYP7Rr5stTizeHxzsU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+QhPSa0UpKd0ujACvf3edLGy7MnnMinfOYF4dvFsWkf5RM+RPl
 jRKEDT0+CjD81dmjSfql/oZ+N82WfmF3Abvykxdh3eo1Hw16Vvr+HabyO8x99SHvcufPLqUsbW5
 FwhbsFYMRAMAcVyiQSp8HPhA5msfVTrg=
X-Gm-Gg: AYBFou3XRC/oFnDraZRyj4oprBrwv0I30iqqF7VNrA+p6DwiFMiHg9VQyjJ1oGmeDn5
 NJf+bKRfQd43GMAgZh9e14k2ouMM43Bsfr4fd3EH7Nyw2nKx3Ux5nC3B7fNi8JRXODp9YVWFCnp
 VL9JWoLH8N0YCdiBYY6qHMt6A7TC9YXeV3AbedxiQ5gQXXMA/0V7LafPFlmtrIuP1Hl+71bEFeQ
 aseVPWItti6n6QrCwQc14LyFgVEcRrYxvf64qLRmmongfqz4chEKWXacheM19tycqFUB0UKr3++
 tVUNvfAPb0+PP6cISxUL55ILmNZMgyqhiUIrnXhgVEzAzmT7guTEgyUlzwgxwNpO5FnoBX11ACY
 wfiUHo/piT3IjW6VPEhjA3XljIjYuDUYWAuvtpY7DlS1PorA9bWSVlCXVBkLJB0w7/Bg1Jsg0wR
 VmtJWUeZYeXRuztJcx
X-Received: by 2002:a05:6808:831b:b0:572:6ee:8b6b with SMTP id
 5614622812f47-57206eeac9emr372158b6e.66.1794632247852; Fri, 13 Nov 2026
 20:57:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107174215.15818-1-swizzguy76@gmail.com>
 <f585562b-dbdc-415b-a493-475cf545a092@linux.intel.com>
In-Reply-To: <f585562b-dbdc-415b-a493-475cf545a092@linux.intel.com>
From: Toast <swizzguy76@gmail.com>
Date: Sat, 14 Nov 2026 10:27:17 +0530
X-Gm-Features: AclHuK8QlfT2uRLD1uAa8XnAGmCLr9nS6RezPS4g9Ri_LHUcmb3SIj8Cm9mcaUQ
Message-ID: <CAHBKUQYt-GjFnTNZRFbwo5DCf9hzN=sBW=XSwcGhEUKvCf-t9w@mail.gmail.com>
Subject: Re: [PATCH] accel/ivpu: Disable recovery work on probe failure
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: jacek.lawrynowicz@linux.intel.com, jeff.hugo@oss.qualcomm.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 ogabbay@kernel.org, andrzej.kacprowski@linux.intel.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware 20260219)
on top of v7.4-rc1:

- kexec from a 7.0 kernel and from 7.4 with the NPU runtime-suspended:
  both runs hit ATS_ERR during probe, recovery_work was not queued,
  probe failed once with -ETIMEDOUT, and there was no oops
- FLR plus rebind brings the NPU back
- debugfs force_recovery after a successful probe recovers the NPU

I couldn't hit an error IRQ after ivpu_boot() succeeds, so the deferred
recovery in ivpu_pm_enable() isn't covered by this.

Tested-by: Daksh Sahni <swizzguy76@gmail.com>

On Tue, Nov 10, 2026 at 2:03=E2=80=AFPM Karol Wachowski
<karol.wachowski@linux.intel.com> wrote:
>
> On 07-Nov-26 18:42, Daksh Sahni wrote:
> > If the NPU raises an error interrupt while ivpu_dev_init() boots the
> > firmware, the Buttress, MMU or WDT IRQ handler calls
> > ivpu_pm_trigger_recovery(), which queues recovery_work. When ivpu_boot(=
)
> > then fails, the err_ipc_fini path tears the device down without
> > disabling recovery_work and probe returns an error. devres unmaps the
> > register BARs while the work is still queued or running, and the work
> > faults on the first register access:
> >
> >    BUG: unable to handle page fault for address: ffffcfc6680200f4
> >    Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
> >    RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
> >    Call Trace:
> >     ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
> >     ivpu_boot+0x9e/0x270 [intel_vpu]
> >     ivpu_resume+0xa4/0xd0 [intel_vpu]
> >     ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
> >     ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]
> >     process_one_work+0x1da/0x3c0
> >     worker_thread+0x1af/0x340
> >     kthread+0xfa/0x130
> >     ret_from_fork+0x2b9/0x380
> >     ret_from_fork_asm+0x1a/0x30
> >
> > The work dies between pm_runtime_disable() in ivpu_pm_reset_begin() and
> > pm_runtime_enable() in ivpu_pm_reset_complete(), so the PCI device is
> > also left with runtime PM disabled and never autosuspends after a later
> > rebind.
> >
> > Commit 5eaa49741119 ("accel/ivpu: Prevent recovery invocation during
> > probe and resume") stopped IPC failures during probe from triggering
> > recovery, but the IRQ handlers still can.
> >
> > Call ivpu_pm_disable_recovery() at the start of the err_ipc_fini path,
> > as ivpu_dev_fini() already does, so the work is flushed and cannot be
> > queued again before the device is torn down.
> >
> > Reproduced on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware
> > 20260219) by kexec'ing with the NPU runtime-suspended: probe in the new
> > kernel gets an ATS_ERR Buttress IRQ during firmware boot. With this
> > change probe still fails with -ECANCELED, there is no oops, and an FLR
> > followed by a rebind brings the NPU back.
> >
> > Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Daksh Sahni <swizzguy76@gmail.com>
>
>   Hi Daksh,
>
>   Thanks for the report and the thorough analysis, it's correct. An error
>   IRQ that fires once ivpu_boot() has enabled interrupts can queue
>   recovery_work during probe, and nothing on the probe error path stops
>   it.
>
>   As Sashiko pointed out, disabling the work on err_ipc_fini comes too
>   late. By then recovery_work may already have run concurrently with
>   ivpu_boot(). It can also race with a probe that succeeds, which you saw
>   yourself in one of your runs.
>
>   I'll send a v2 that addresses this along the lines you offered and
>   Sashiko suggested. recovery_work stays disabled for the whole of probe
>   and is enabled in ivpu_pm_enable(). A recovery requested during probe
>   is not lost. If ivpu_boot() fails, probe unwinds with nothing pending.
>
>   If  probe succeeds, ivpu_pm_enable() runs the deferred recovery and
>   waits for it before issuing the initial autosuspend request. The NPU is
>   then reset before first use, and the autosuspend no longer lands while
>   runtime PM is disabled, which covers your second note too. The patch
>   will keep your Reported-by.
>
>   I'm running it through our internal CI first and will post it once that
>   passes. When it's out, could you test it on your Meteor Lake kexec
>   setup and reply with your Tested-by? Once I have it, I'll go ahead
>   and merge.
>
>   Thanks,
>   Karol
> > ---
> >
> > Notes:
> >      Tested on v7.4-rc1 (d48723711bae).
> >
> >      Two things this patch does not address:
> >
> >      The trigger is kexec with the NPU runtime-suspended in the old ker=
nel.
> >      The driver has no .shutdown hook, so the new kernel's probe sees s=
tale
> >      NPU state and gets ATS_ERR. A cold boot doesn't hit it. Whether th=
at
> >      wants a shutdown hook or a reset at probe seems like your call.
> >
> >      In one of four runs that hit ATS_ERR, probe succeeded while
> >      recovery_work was running concurrently. Probe returned 0, but the
> >      autosuspend request from ivpu_pm_enable() landed while recovery ha=
d
> >      runtime PM disabled, so the NPU stayed active until first use. Not
> >      allowing IRQ-triggered recovery until ivpu_pm_enable() would cover=
 both
> >      cases; I can send a v2 that does that if you prefer.
> >
> >   drivers/accel/ivpu/ivpu_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_dr=
v.c
> > index 247ed6b2ff62..4fcccf78ec5d 100644
> > --- a/drivers/accel/ivpu/ivpu_drv.c
> > +++ b/drivers/accel/ivpu/ivpu_drv.c
> > @@ -852,6 +852,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
> >       return 0;
> >
> >   err_ipc_fini:
> > +     ivpu_pm_disable_recovery(vdev);
> >       ivpu_ipc_fini(vdev);
> >   err_fw_fini:
> >       ivpu_fw_fini(vdev);
>
