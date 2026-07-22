Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FCAC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03ED710EDCF;
	Wed, 22 Jul 2026 14:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G5xdB37C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E7710EDCF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:07:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82A8941A1D;
 Wed, 22 Jul 2026 14:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6A61F000E9;
 Wed, 22 Jul 2026 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784729237;
 bh=owOO+Fassc3QqoDWR+yagDCVYyd5ynm3ybtwGR00f9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G5xdB37CKUSFErCkAfzGnzDbAEmu4KBwVMjiPEu7Dq7Os51TKTsBnFC12doSbc1YH
 Tho11597Thg/9s2aqQsKVA45AqjMYKtI+MS7HceLLFfKYL96ABW146iKkY5dMAYQt0
 v8TloeQzqLh8NDs86TMK8j9KpbNm55PMRuaY7yiGI47HN2Bx1mSDaWGGVqbOUuz7S0
 cgOuqGOyNQSGASdf9mixhpNiB1D4PBWeIohTiCoAqbdfi6a9MOO7etonEnKAXc3Lth
 PXTAshs9zsKVNu8Kz5F0j63QVrv4EMUNNY64NwXbr5Q9mOxz3bWwWL9TSMUuGeJZlE
 Ziwai+RPM2Aow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing
 it in timeout paths
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722004654.744249-4-talesam@gmail.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-4-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:07:16 +0000
Message-Id: <20260722140717.3B6A61F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] TOCTOU race condition in `xe_guc_ct_flush_g2h` can cause a Use-Aft=
er-Free of `ct->g2h_wq` during device teardown.
--

--- Patch [3]: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushi=
ng it in timeout paths ---
commit 2288520019a1eaed705d5a065fcb111af0102b2f
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe/guc/ct: Queue G2H worker before flushing it in timeout paths

This commit introduces xe_guc_ct_flush_g2h() to queue the G2H worker before
flushing it in timeout-recovery paths. This guarantees the flush always
drains the CTB even if the GUC2HOST interrupt was lost or coalesced.

> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_c=
t.c
> index fe70c0fd85c52..11a05c2b8c773 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c

[ ... ]

> @@ -2046,6 +2046,27 @@ static void g2h_worker_func(struct work_struct *w)
>  	receive_g2h(ct);
>  }
> =20
> +/**
> + * xe_guc_ct_flush_g2h() - Force processing of pending G2H messages
> + * @ct: GuC CT object
> + *
> + * The GUC2HOST interrupt for a G2H message may be lost or coalesced. Wh=
en
> + * that happens the G2H worker is never queued and flushing it is a no-op
> + * that does not read the G2H CTB, leaving messages the GuC has already
> + * posted unprocessed until the next interrupt arrives. Queue the worker
> + * before flushing it so the flush always drains the G2H CTB. A spurious
> + * worker run is safe: it returns without side effects if the CTB is emp=
ty
> + * or CT communication is disabled.
> + */
> +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct)
> +{
> +	if (!xe_guc_ct_enabled(ct))
> +		return;
> +
> +	queue_work(ct->g2h_wq, &ct->g2h_worker);

[Severity: High]
Can a Time-of-Check to Time-of-Use (TOCTOU) race happen here during
concurrent device teardown?

If a timeout path like xe_tlb_inval_fence_timeout() calls this function on
an async worker, it checks xe_guc_ct_enabled(ct) without any locks. If the
thread is preempted right after evaluating to true:

Thread 1 (timeout worker):
xe_guc_ct_flush_g2h() {
    if (!xe_guc_ct_enabled(ct))
        // evaluates to true, thread preempted here

Thread 2 (device teardown):
Proceeds to disable the CT via the devm hook (guc_action_disable_ct) and
destroys the workqueue via the drmm hook (guc_ct_fini).

When Thread 1 resumes, it will call queue_work(ct->g2h_wq, ...) on the
destroyed workqueue pointer, which could result in a use-after-free.

Since drmm hooks execute in LIFO order, the guc_ct_fini() hook destroys the
workqueue before the teardown path would wait for the timeout worker via
destroy_workqueue(xe->ordered_wq).

Is there a way to safely synchronize the queue_work() call or validate
that the workqueue is still alive while holding a lock?

> +	flush_work(&ct->g2h_worker);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722004654.7442=
49-1-talesam@gmail.com?part=3D3
