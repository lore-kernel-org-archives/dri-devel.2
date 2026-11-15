Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43B606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AWkERLyU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2F310E04D;
	Sun, 15 Nov 2026 15:25:13 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E506310E04D
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 15:25:06 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-563a0462094so1934176b6e.1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 07:25:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794756306; cv=none;
 d=google.com; s=arc-20260327;
 b=eAiE2PbYYwc3unK9lmRSYcI3ZEbILuUNfJ5auA2ywPLq/eNYS59Di0PehMsuAzPB8c
 FQGFiOB7Emt8xM0FaoT8bhYT5Ub+g1D6iuqnBVLq3BJz3SYPCyET8+iDcYFb5PkDxgwR
 J8WLeIodZTj91UAAfKuJNiucwLDoip+9RGJEWP+BFm2pnQCN+x1/2M/M801lfdyAIQjO
 UAxqgTuDSuMtTPCq51GuRjVzG3Yn7I8za8bJFouUbm33Vq7o8rTxYbThmFbxCbd5AU2X
 BbE1xHc7TjlJm7tFaXv8VtScURilaihZ/oCQB7Ji/otYabKPsv9+vdkcdO3+oTXs+awW
 091g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UeeEThuh222TXFAsYtZtRa1ScqQ+7ELFGplLuxcMQxk=;
 fh=jRzZCrTRJXgoFYL0/UFnHmKf+LElAtwLsdHBNWOrH5U=;
 b=ny85EFN3Rq5BaimGIgyzUWy7dRGwGz/9tSLqoGjrd5BIFPgf0dqunbwIoNt87yg70a
 fnuZeHtKVC4qkpY8SN0P8zaURJT3BiqPCDNW/yOnEWGjaoVvvueWYeA5lQJVMhyd1d3F
 x4rRRenR1lX/KR1ekaV0N6KdebXp3j/6D+OPQJY4yYE5h4Ac17bj2GdDuDlWDEHO4QB8
 cP+K06MHQ8u4wVLEXA2Mg2X6LH70jjLIUbTQg6VRxq+KPHTqQII0Q7ve40saNuD1SCc3
 Te+btll/lORnnXqb9MiOnDQbbDz5vX5CXS6X63Utji8sM2sfYuBCjcZkPHfbgVxY5Fw3
 exWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794756306; x=1795361106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UeeEThuh222TXFAsYtZtRa1ScqQ+7ELFGplLuxcMQxk=;
 b=AWkERLyUoVxw1RC/ZYh142gVWsptS/YPGUQfphQADY6tZhTcO6lRVZVj4F4BM7duea
 vWegYdYXVB2ICO7WZkj/GHbhtWhuadmNiy0PuTCMDnx8/i25CMlYcz3o3CxPyAScPeMg
 e3xpdcN5p58IUZH6SS5Coqf4x+bJfdk3il0c7hhcZ3Y90HZbzg0nA/s3pNQM7UvvUyMj
 JdNksVIh26zJ0W1qzAfApboXpPsN89PJ7jGiUYX217n6dBOMIFWXXV/NizfQAHQhCv3a
 J4wkqMtNx1dL6Ghg9xg35nhMkAVUmymceO/PPNWGmqgFS8kCRclVEOWt/+yJe0wjZtvf
 OYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794756306; x=1795361106;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UeeEThuh222TXFAsYtZtRa1ScqQ+7ELFGplLuxcMQxk=;
 b=DhsTb5ilDpMIu/kzyM0z9fTsPYucs4J1kYg0dtNw14EGYKRgIJudmg7+F4fHo/arYo
 jKbhvZYNVDt4XxhGH21iwfyfq6CF2ZYYAEJiAR+yFh99b8MeBTvYe2j45pFLmEiNyGKg
 4gyTT2h7lj5ntZs1/INJdAcIsbc65/DG6k3kBjm+p3+CXboNHptxVa3WN/7z7XqlQFJS
 kCLpHqxms14x56yuilp+Zgok7tmAxoP35VDvaQbKhN8G2mt+kPIFKo9BgLkI62BZhw0J
 OJEuEDdAhW8WKjRtBYnP03xybN535RlRIIwmckmXZkUKJWa+vRwTyK9Ngj2Gle0ya2TG
 265g==
X-Gm-Message-State: APuU4Z/OQeNNq/eCu/rVsswpHKEICpHIjqtVLKG0t1LAHQei3/gfXcwN
 nTBM0vXtF2LksmU1Ge1kQiiET1SKPdcaS5vw1rNR03CKceURsnUUfMgOo3Qjw2n4WAX/M0GUxvL
 O34b4Cg3jq6aavuBhlweek6/SUVhfhuw=
X-Gm-Gg: AYBFou1hZxu1/eVRlLNnJzPBVUDpMXqst/fu4T6ty9JdjslGfo4cxCD6ji9ggqKyQaU
 Bk6kbrqRi2WcAj74oNmb0h1V6EuZrX2Wyy0vdpWkrHXCFfWWHeVUpm3d7QHizeVyBznsuze+KfE
 d76oJ+hLnOGIlpN9xih0KeN9z9e75cvoJzmJn7ApJA0ASg3XfJkuG2hx95cFSrSze7jnsEzArbV
 0BmMdsUX9OSguyJInXSQsL6LCp00laVxGO7jLJfI6l6eRZJNsN1hDWiyUjFPWgjZxWnVk4Fv7DX
 nLoJyg3Y9PspLYR7OcK3rFd+xbnbLMkbIQeUdmgUzKzYBuqDbhoe5j+IbIPfVdWkmdSpgwgdjUn
 F4UIjjA+graBj0+NfASOC6yOcfIq0+jsQ6hZzTzajg+3Xiz0NCOq9n3yFFkj5w/6pCGLTFA==
X-Received: by 2002:a05:6808:4fd2:b0:4df:5cd0:89c1 with SMTP id
 5614622812f47-56e63ba5727mr6988700b6e.23.1794756305774; Sun, 15 Nov 2026
 07:25:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
In-Reply-To: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
From: Toast <swizzguy76@gmail.com>
Date: Sun, 15 Nov 2026 20:54:54 +0530
X-Gm-Features: AclHuK9q00Y9hV3eTDXkQShBoFF6n1SS0pwFA-pss82uZgNEzVH35DmfBvC_TTg
Message-ID: <CAHBKUQaxYcVQvUc336wCOZzpS+GDw7yEbmAWvpT8CEUSg+cK2w@mail.gmail.com>
Subject: Re: [PATCH v3] accel/ivpu: Defer recovery until probe completes
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dawid.osuchowski@linux.intel.com, 
 stable@vger.kernel.org
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

Tested v3 on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware 20260219)
on top of v7.4-rc1 (d48723711bae):

- 4 kexec runs with the NPU runtime-suspended (one from a 7.0 kernel,
  three from 7.4): every run hit ATS_ERR during probe, recovery_work was
  not queued, probe failed with -ETIMEDOUT, and there was no oops
- FLR plus rebind brings the NPU back, and it autosuspends afterwards
- debugfs force_recovery after a successful probe recovers the NPU, and
  it returns to runtime-suspended

None of the runs had probe succeed after the error IRQ, so the deferred
recovery in ivpu_pm_enable() isn't covered by this.

One question: v2 had "Cc: stable@vger.kernel.org # v6.10+" and v3 dropped
the annotation. disable_work()/enable_work() only exist since v6.10 and
the Fixes: commit is in v6.3, so should the "# v6.10+" come back?

Tested-by: Daksh Sahni <swizzguy76@gmail.com>

On Tue, Nov 10, 2026 at 5:45=E2=80=AFPM Karol Wachowski
<karol.wachowski@linux.intel.com> wrote:
>
> An error IRQ that fires after ivpu_boot() enables interrupts queues
> recovery_work during probe. If probe then fails, the device is torn
> down while the work runs, and the work faults on the unmapped BARs:
>
>   BUG: unable to handle page fault for address: ffffcfc6680200f4
>   Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
>   RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
>   Call Trace:
>    ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
>    ivpu_boot+0x9e/0x270 [intel_vpu]
>    ivpu_resume+0xa4/0xd0 [intel_vpu]
>    ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
>    ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]
>
> If probe succeeds, the recovery runs concurrently with the rest of
> probe, and its pm_runtime_disable() discards the initial autosuspend
> request, leaving the NPU active until first use. Any recovery that
> starts while the NPU is idle loses the pending autosuspend the same way.
>
> Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable().
> A trigger during probe still runs diagnostics and masks interrupts, and
> ivpu_pm_enable() runs the deferred recovery before the initial
> autosuspend request. A trigger racing with ivpu_pm_enable() can cause
> a second, harmless recovery. Request autosuspend at the end of
> ivpu_pm_reset_complete() so the NPU suspends again after every reset.
>
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Cc: stable@vger.kernel.org
> Reported-by: Daksh Sahni <swizzguy76@gmail.com>
> Closes: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail=
.com
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>
> Notes:
>     v3:
>     - Request autosuspend at the end of ivpu_pm_reset_complete().
>       pm_runtime_disable() in ivpu_pm_reset_begin() cancels a pending
>       autosuspend request and pm_runtime_enable() does not re-issue it, s=
o
>       a recovery racing with the initial autosuspend request in
>       ivpu_pm_enable() left the NPU active until first use (Sashiko).
>       A trigger racing with ivpu_pm_enable() can still queue recovery
>       twice. The second run is a full reset that leaves the device in a
>       consistent state, and autosuspend is now re-requested after each
>       reset.
>     - Replace pm_runtime_mark_last_busy() with pm_request_autosuspend() i=
n
>       ivpu_pm_reset_complete(); it marks the device busy itself.
>     - Shorten the commit message.
>     - v2: https://lore.kernel.org/r/20261110085003.3527014-1-karol.wachow=
ski@linux.intel.com
>
>     v2:
>     - Rework of Daksh's "accel/ivpu: Disable recovery work on probe failu=
re":
>       https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.c=
om
>     - Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enabl=
e()
>       instead of disabling it on the probe error path, which is too late =
as
>       recovery may already run concurrently with ivpu_boot() (Sashiko)
>     - Run a recovery requested during probe from ivpu_pm_enable() and wai=
t
>       for it before the initial autosuspend request, so the NPU is reset
>       before use and the autosuspend is not lost when probe succeeds
>
>     v1:
>     - Link: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@g=
mail.com
>
>  drivers/accel/ivpu/ivpu_pm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index aa813262253e..e4b79c946ca0 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -150,8 +150,8 @@ static void ivpu_pm_reset_complete(struct ivpu_device=
 *vdev)
>         up_write(&vdev->pm->reset_lock);
>         atomic_set(&vdev->pm->reset_pending, 0);
>
> -       pm_runtime_mark_last_busy(vdev->drm.dev);
>         pm_runtime_enable(vdev->drm.dev);
> +       pm_request_autosuspend(vdev->drm.dev);
>  }
>
>  static void ivpu_pm_recovery_work(struct work_struct *work)
> @@ -415,6 +415,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
>         atomic_set(&pm->engine_reset_counter, 0);
>
>         INIT_WORK(&pm->recovery_work, ivpu_pm_recovery_work);
> +       disable_work(&pm->recovery_work);
>         INIT_DELAYED_WORK(&pm->job_timeout_work, ivpu_job_timeout_work);
>
>         if (ivpu_disable_recovery)
> @@ -439,6 +440,12 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
>  {
>         struct device *dev =3D vdev->drm.dev;
>
> +       enable_work(&vdev->pm->recovery_work);
> +       if (atomic_read(&vdev->pm->reset_pending)) {
> +               queue_work(system_dfl_wq, &vdev->pm->recovery_work);
> +               flush_work(&vdev->pm->recovery_work);
> +       }
> +
>         pm_runtime_allow(dev);
>         pm_runtime_put_autosuspend(dev);
>  }
>
> base-commit: 54d3ff1b5ac08d0e28029b93a1719ddd9ff670a4
> --
> 2.43.0
>
