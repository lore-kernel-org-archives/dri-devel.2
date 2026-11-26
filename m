Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832D606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdb+7wpr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E05210E988;
	Thu, 26 Nov 2026 11:39:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA0710E988
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:38:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 17FF6402CD;
 Thu, 26 Nov 2026 11:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0EC1F000C6;
 Thu, 26 Nov 2026 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693135;
 bh=NieOCDaQrEFPWuzINEz6m2dleqj3MHge8+tju8hrGvU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cdb+7wprnwDV9nUKYbr2VO60kNWxzmH+djgSKhUinQs9auK7W5nHj5C9qnzF3WrYM
 rUVyfvIxviW7bTQ/nvkdbnMzR9lkr5f961kUUfsuzpjVvLkguxvcPsCVe+VVY4xJUp
 kfv6XE5eXApeIJ1sNyfqA1ouQiYQuyNm+ycqFUbKe+pwCkAGOaw4fGnETLczL2gIeu
 1pwgDoksyOt1LDbq7hBMqhHYPs3z6LVJ8v6ru+i0jmC8JaLHGUsXhsAwmCEbPKeVDu
 qR7JifZn1cLVoEg3yS0OBmt7G9sOT2hCNcAvystojfKcTltjg1osP90X7PNYPrSfUJ
 WOVel2HPPCbYw==
Message-ID: <sashiko-outbox-235394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/17] drm/panfrost: Keep the job interrupts masked
 during a reset
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-panfrost-long-jobs-v4-15-23579629ceca@gmail.com>
References: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
 <20261126-panfrost-long-jobs-v4-15-23579629ceca@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:38:54 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/panfrost: level-triggered IRQ storm in
  panfrost_jm_suspend_irq()
--

commit f6cf958c59f482f84481acc7413188e321156153
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Keep the job interrupts masked during a reset

This commit replaces the open-coded JOB_INT_MASK masking and
synchronize_irq() in panfrost_reset() with panfrost_jm_suspend_irq(), and
adds a second write to JOB_INT_MASK after synchronize_irq().

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 74cc3dd025336..7a2503f4e5a40 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -459,6 +459,7 @@ void panfrost_jm_suspend_irq(struct panfrost_device *=
pfdev)
> =20
>  	job_write(pfdev, JOB_INT_MASK, 0);
>  	synchronize_irq(pfdev->js->irq);
> +	job_write(pfdev, JOB_INT_MASK, 0);
>  }
> =20
>  static void panfrost_job_handle_err(struct panfrost_device *pfdev,
> @@ -696,8 +697,7 @@ panfrost_reset(struct panfrost_device *pfdev,
>  	/* Mask job interrupts and synchronize to make sure we won't be
>  	 * interrupted during our reset.
>  	 */
> -	job_write(pfdev, JOB_INT_MASK, 0);
> -	synchronize_irq(pfdev->js->irq);
> +	panfrost_jm_suspend_irq(pfdev);

[Severity: High]
Can calling panfrost_jm_suspend_irq() while GPU jobs are still active
trigger a level-triggered hardirq storm on pfdev->js->irq?

Unlike runtime suspend, panfrost_reset() calls panfrost_jm_suspend_irq()
before issuing JS_COMMAND_SOFT_STOP, so running jobs can still complete or
fault and assert JOB_INT_RAWSTAT.  When PANFROST_COMP_BIT_JOB is set,
panfrost_jm_irq_handler() returns IRQ_NONE without masking JOB_INT_MASK:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_jm_irq_handler() {
	if (test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
		return IRQ_NONE;
    ...
	job_write(pfdev, JOB_INT_MASK, 0);
	return IRQ_WAKE_THREAD;
}

In the race that the second job_write(pfdev, JOB_INT_MASK, 0) is meant to
handle, JOB_INT_MASK is re-enabled while PANFROST_COMP_BIT_JOB is already
set:

CPU0                              CPU1
panfrost_jm_irq_handler_thread()  panfrost_reset()
  panfrost_jm_handle_irqs()         panfrost_jm_suspend_irq()
  if (!test_bit(COMP_BIT_JOB, ...))
                                      set_bit(COMP_BIT_JOB, ...)
                                      job_write(pfdev, JOB_INT_MASK, 0)
                                      synchronize_irq(pfdev->js->irq)
    job_write(pfdev, JOB_INT_MASK,
              ALL_JS_INT_MASK)
    <hardirq: job completes>
      panfrost_jm_irq_handler()
        if (test_bit(COMP_BIT_JOB))
          return IRQ_NONE;        <-- level-triggered IRQ storm

The same window exists in panfrost_jm_suspend_irq() between set_bit() and
the first job_write(pfdev, JOB_INT_MASK, 0).  Because the Mali job IRQ is
level-triggered, returning IRQ_NONE with JOB_INT_MASK unmasked causes the
interrupt to immediately re-fire, starving the interrupted CPU (including
CPU0 before the IRQ thread can finish and release synchronize_irq(), or
CPU1 before the second mask write) until note_interrupt() disables the IRQ
line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-panfrost-l=
ong-jobs-v4-0-23579629ceca@gmail.com?part=3D15
