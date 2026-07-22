Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B208AC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A1710EFD9;
	Thu, 23 Jul 2026 07:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ksw3O4bJ";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7393610E0C9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 17:49:04 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-81eaf3709b4so107986017b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784742543; cv=none;
 d=google.com; s=arc-20260327;
 b=dFNVlbjrRhyk8KFgY3jyKA17/1Zi/NKdOywZ/Q5w5/c5Q3colAYApGzpgNoqbGuF3i
 my+lFFGd/ekfANsn4Si3i4prf2PktjNSG8pcNz3UiIaB1+nHa9af27nWPXrFkCgihEFf
 O7YCCCplH3b2I2Em2ObZ0NRkVbhyre15iMlzSNrRhl6ox/sBLtmWPkj4bLiYKBn/PGLS
 xrwS1b3nxgJ0UzrdI8qNzXPePzCIEG4D8ZMmBWadus40Ys8uYO+dEP7jISO91t7eCVBn
 /BvOuuBW1nhjEgu4fu8wdnYMge9VnNRjMCC6ji3311lkheJywVfsb7D3cHknZVtiSRw5
 XSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+FbImOYnCjQq7E4LZcKl4osd/U/55au0kzrVGg/5Cts=;
 fh=RHt77CxFI8VNyQoQZGD2p5fp2XohHPbsKAwEtyIE+Go=;
 b=GrERLFaxQrImz+Mn6giXEocjywqWsnRP+ViUFJ2pKA+ffAc73a7YRLdLl9fCKGoZKy
 52L8X0n1Faf2LryBtfE3pyNu+mdsHRQjPMyP5TdQMKETYnTxoYPv2iaGNsJg2QZ7PNYo
 wxAgsAMG6D90Wy7PAz2UACiRaLvFSOWvtmDjV57Eo0RLs6YJFzRXwkdl+wE6k3p/rVi+
 8kicgp1tEwELUaKC8E0xv/5jNGvCQ0ipTXTgb0J9Wo01xAFXQqHFLP+OXZASrCRrnFNl
 MbllE8Qu9HfAsUWvIXh39vcCXVheHfKrtUU0hdrQ2Mo77bZSHioV5BEO3bmDctKpbCWG
 PItw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784742543; x=1785347343; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+FbImOYnCjQq7E4LZcKl4osd/U/55au0kzrVGg/5Cts=;
 b=Ksw3O4bJx6U8OmyDPTXEbN+jJGGvKkDeM/mOIY7a5DH74jaMh1eFjBBSNrjZ4rv6k7
 1Af80eIdjPp+8t+exrVVQSRadWdxR+twEgiKcplfXVR+8nG3/j+dGBTHCm29kJL1Ikzo
 fKuhm1tCBTg2Q3SywzXDwdngUDKHMAuP71SmwgWDX6bPdPB30eXbRIH+cT3g/XVhi9R+
 iQ66Cc3RN0dzxbbIe5QiVta0ljJD9CVlxeNHo5NXVs4tvIdlGH8vTSSdIxX95bHyBUBk
 FafO8PgBqqmQw/DIDwCaHQqrYuMeD1SS1BCqsS7Wj4g7IBUAr86k7F06lXzEgiLGODAy
 I7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784742543; x=1785347343;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+FbImOYnCjQq7E4LZcKl4osd/U/55au0kzrVGg/5Cts=;
 b=ZttEWRQLV+Lm55vEskgyeUiuc35r7eEyuBz2WPv9HJsQarhZPT68HbFh0cWWhL7TG5
 dqYzshXp3l+bVy4kUFntyxw+IIAn/M021jt085tQcNHTkJmtxgV1/dSGtkQoa3xgdFZp
 YdsPPzY29fRatGZPWivuqBjG2/euDRKPYEKVqwJktKpE7ZGMelouTYZB7yodbOwOyM6X
 S0UjGVaM9uagc0bNvpnDSSsa/DaLUYUcKJ2YClJNDsaPlBRwyZzQulSr7d4Sdh3t/OI5
 MojZKA9C1pSQ5U18vblSSJdMdHqNDWSmkKhsEb4NNh9bdu9VJ+ELU4GkzfjbQ65H2mnM
 TPvQ==
X-Gm-Message-State: AOJu0Yxhc5D7goBJrW5fTF6ybaYlrzp2n4g6BTlJRclmztN410TT8Lng
 1nNwOHyC0QmDILrjkpgnNmhV7th3jnPFNrKRlGKGhirADYp3X1/7TqITLGb/jtF0mfeY0TD5gq7
 etTg/KDEEV34IOBTfVvMJrTkAbMeQw1U=
X-Gm-Gg: AR+sD12W/kbHIUNsX9DN26Oo6dTWidA9506GIil9O3V5USuCsCajY7l6m9puFqN63IN
 0ktwJRliCQ1jfk5vusu2RX0PXTYhvpquoP8o77FIJ12BEAE8C+5WZ09e5R/KUVaoCFdZyXujPPd
 +kkEscwfjZL8b4beWMSE5RCPRzEIraBR3gyeRBif17llVvsJvgrwEhXDQE+FNAwipMEmMfXkI0Y
 cimpo0XCw2dkvCPmiviwBh8P58ff60xzu+EPM94X915SjIUs9rs6nchjyLOjOS1CRBRR/XqYCK0
 ZmgRzD9H2Ak8jF3orKQ3lUldb9bxqj8QDshfQP6meL0iEsGx
X-Received: by 2002:a05:690c:9c09:b0:807:bc80:b4ac with SMTP id
 00721157ae682-81ef27f2e17mr64665217b3.40.1784742543040; Wed, 22 Jul 2026
 10:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-4-talesam@gmail.com>
In-Reply-To: <20260722004654.744249-4-talesam@gmail.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Wed, 22 Jul 2026 14:48:52 -0300
X-Gm-Features: AUfX_myEWevXxGatBnOLcKjMm-PJ4US4nFPerTva3bl1GuE_o_c3uZX1JLN3yM0
Message-ID: <CAHBRX4E+GCm7aFK4Di4YVqCZ-a=o8dkKw3ArWMBZuNbmp2SjPQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing it
 in timeout paths
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.brost@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Thanks for the review.

The check-then-queue pattern here is the same long-standing one in
xe_guc_ct_irq_handler() (xe_guc_ct.h), which also does an unlocked
xe_guc_ct_enabled() check followed by queue_work(ct->g2h_wq, ...), so
this patch does not introduce a new lifetime requirement - it relies
on the same guarantees the IRQ path already does.

Those guarantees hold for both callers: xe_tlb_inval_fence_timeout()
cannot be in flight during the drmm teardown that destroys g2h_wq,
because xe_tlb_inval_reset() cancels fence_tdr and force-signals all
pending fences with the backend already disabled before that point
(and with no pending fences the TDR is never re-armed); and
guc_ct_send_recv() is synchronous within an active CT session, so it
cannot overlap CT fini either. Note the LNL_FLUSH_WORK/flush_work
calls being replaced already required the work item to outlive the
caller in the same way.

If additional hardening is still desirable, the check+queue could be
done under ct->fast_lock, but that would equally apply to the existing
IRQ handler path.

Em ter., 21 de jul. de 2026 =C3=A0s 21:47, Tales A. Mendon=C3=A7a
<talesam@gmail.com> escreveu:
>
> Timeout-recovery paths flush the G2H worker to pick up a response that
> may have been posted by the GuC but not yet processed:
>
>  - guc_ct_send_recv() after the 1s wait for a G2H response fails
>  - the TLB invalidation backend's .flush() hook, called by
>    xe_tlb_inval_fence_timeout() before declaring a fence timed out
>
> However flush_work() on a work item that is neither queued nor running
> is a no-op. If the GUC2HOST interrupt for the response was lost or
> coalesced, the G2H worker was never queued: the flush does not read the
> G2H CTB and the response sits there unprocessed until an unrelated G2H
> interrupt arrives. For TLB invalidations this results in
>
>   TLB invalidation fence timeout, seqno=3DN recv=3DN-1
>
> with the fence force-signalled with -ETIME even though the ack may
> already be present in the CTB. Observed sporadically on ARL-H under CPU
> load, always with recv =3D=3D seqno - 1 and self-recovering on the next G=
2H
> interrupt, which is consistent with a lost wakeup rather than a
> GuC-side failure.
>
> Add xe_guc_ct_flush_g2h(), which queues the worker before flushing it,
> guaranteeing the flush always drains the CTB, and use it in both
> timeout paths. A spurious worker run is safe: g2h_read() returns no
> data under fast_lock, and receive_g2h() copes with runtime-PM state and
> disabled CT communication.
>
> After this change the fence-timeout error only fires when the ack is
> genuinely absent from the CTB, making the message a reliable indicator
> of a GuC-side stall.
>
> Signed-off-by: Tales A. Mendon=C3=A7a <talesam@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_guc_ct.c        | 23 ++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_guc_ct.h        |  1 +
>  drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  2 +-
>  3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_c=
t.c
> index fe70c0fd85c..11a05c2b8c7 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1377,7 +1377,7 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, c=
onst u32 *action, u32 len,
>  wait_again:
>         ret =3D wait_event_timeout(ct->g2h_fence_wq, READ_ONCE(g2h_fence.=
done), HZ);
>         if (!ret) {
> -               LNL_FLUSH_WORK(&ct->g2h_worker);
> +               xe_guc_ct_flush_g2h(ct);
>                 if (READ_ONCE(g2h_fence.done)) {
>                         xe_gt_warn(gt, "G2H fence %u, action %04x, done\n=
",
>                                    g2h_fence.seqno, action[0]);
> @@ -2046,6 +2046,27 @@ static void g2h_worker_func(struct work_struct *w)
>         receive_g2h(ct);
>  }
>
> +/**
> + * xe_guc_ct_flush_g2h() - Force processing of pending G2H messages
> + * @ct: GuC CT object
> + *
> + * The GUC2HOST interrupt for a G2H message may be lost or coalesced. Wh=
en
> + * that happens the G2H worker is never queued and flushing it is a no-o=
p
> + * that does not read the G2H CTB, leaving messages the GuC has already
> + * posted unprocessed until the next interrupt arrives. Queue the worker
> + * before flushing it so the flush always drains the G2H CTB. A spurious
> + * worker run is safe: it returns without side effects if the CTB is emp=
ty
> + * or CT communication is disabled.
> + */
> +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct)
> +{
> +       if (!xe_guc_ct_enabled(ct))
> +               return;
> +
> +       queue_work(ct->g2h_wq, &ct->g2h_worker);
> +       flush_work(&ct->g2h_worker);
> +}
> +
>  static struct xe_guc_ct_snapshot *guc_ct_snapshot_alloc(struct xe_guc_ct=
 *ct, bool atomic,
>                                                         bool want_ctb)
>  {
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_c=
t.h
> index 767365a33de..4e0338953f1 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.h
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.h
> @@ -22,6 +22,7 @@ void xe_guc_ct_runtime_suspend(struct xe_guc_ct *ct);
>  void xe_guc_ct_stop(struct xe_guc_ct *ct);
>  void xe_guc_ct_flush_and_stop(struct xe_guc_ct *ct);
>  void xe_guc_ct_fast_path(struct xe_guc_ct *ct);
> +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct);
>
>  struct xe_guc_ct_snapshot *xe_guc_ct_snapshot_capture(struct xe_guc_ct *=
ct);
>  void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot, struc=
t drm_printer *p);
> diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/x=
e_guc_tlb_inval.c
> index 046d0655122..91960dc4ba9 100644
> --- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> @@ -327,7 +327,7 @@ static void tlb_inval_flush(struct xe_tlb_inval *tlb_=
inval)
>  {
>         struct xe_guc *guc =3D tlb_inval->private;
>
> -       LNL_FLUSH_WORK(&guc->ct.g2h_worker);
> +       xe_guc_ct_flush_g2h(&guc->ct);
>  }
>
>  static long tlb_inval_timeout_delay(struct xe_tlb_inval *tlb_inval)
> --
> 2.55.0
>


--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
