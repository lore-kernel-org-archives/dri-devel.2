Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D395606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBGzJ9zU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3116D10E41D;
	Tue, 17 Nov 2026 09:55:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DDC10E41D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:55:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CDE061E81;
 Tue, 17 Nov 2026 09:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05061F000C4;
 Tue, 17 Nov 2026 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794909339;
 bh=ZKx5OVE/b6vxiV5Kl9lnuZkq4ocdrLlAvIG65WHWwDE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FBGzJ9zUHGy45eIMtmF1STVOmZHsOLygavdalbk7Mo3JaaYmBAiW0RKEN4saZLyrJ
 7uGKaVpabO5hOsamDO2ebcrDWTinpDw44xJIpDo+9vH5qrL5SIXOk0uyCgn89TU5Z3
 FkWk9AMKq0mv37/KJRqfXlRR8VpuWjj/KPfLgGTMKqyQcbN4T9X0L6juVrDV7Uyxoj
 CpwivGGgVhrV7JCcCNXcE1pB6dEEnoJDP7rvk9Q7KEndEDXjaoEv8Qu6LfpubPgxnW
 +tRb6vwsDLRglVzupVNt8yeoHw9KWz/LaJPUTbEx8McPLp5bkVqvzLzMzgoiwjP47j
 9Lx6lpLHLKxbg==
Message-ID: <sashiko-outbox-218551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] misc: fastrpc: drop the DSP-response reference
 on channel removal
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-interrupted-invoke-v4-v4-2-2320a8a7eda2@oss.qualcomm.com>
References: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
 <20261117-interrupted-invoke-v4-v4-2-2320a8a7eda2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:55:39 +0000
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
- [High] misc: fastrpc: unconditional put_work in fastrpc_notify_users()
  causes UAF
--

commit 26d39b5b31352dcf69828a5e0df69c260f35b447
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: drop the DSP-response reference on channel removal

This commit schedules ctx->put_work in fastrpc_notify_users() for each
context on user->pending when the rpmsg channel is removed, so the
reference taken for the DSP response is released.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index bb0c30419611c..c5c3679f87f6f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2835,6 +2835,13 @@ static void fastrpc_notify_users(struct fastrpc_us=
er *user)
>  	list_for_each_entry(ctx, &user->pending, node) {
>  		ctx->retval =3D -EPIPE;
>  		complete(&ctx->work);
> +		/*
> +		 * fastrpc_invoke_send() took a second reference for the
> +		 * DSP response that will now never arrive since the
> +		 * channel is gone; schedule the matching put the same
> +		 * way a real response would via fastrpc_rpmsg_callback().
> +		 */
> +		schedule_work(&ctx->put_work);
>  	}
>  	spin_unlock(&user->lock);
>  }

[Severity: High]
Can scheduling ctx->put_work unconditionally for every entry on
user->pending drop the caller's sole reference and cause a use-after-free
on ctx?

fastrpc_context_alloc() adds ctx->node to user->pending before
fastrpc_get_args() and fastrpc_invoke_send() run, and ctx stays on
user->pending until the bail path of fastrpc_internal_invoke() removes it:

CPU0                              CPU1
fastrpc_internal_invoke()
  ctx =3D fastrpc_context_alloc()
    list_add_tail(&ctx->node, &user->pending)
    kref_init(&ctx->refcount)
  fastrpc_get_args(kernel, ctx)
                                  fastrpc_rpmsg_remove()
                                    fastrpc_notify_users()
                                      schedule_work(&ctx->put_work)
                                  fastrpc_context_put_wq()
                                    fastrpc_context_free()
                                      kfree(ctx)
  fastrpc_invoke_send(cctx, ...)  <-- use-after-free
  ...
  fastrpc_context_put(ctx)

The same mismatch occurs if rpmsg_send() in fastrpc_invoke_send() fails and
immediately drops the second reference while ctx is still on user->pending.

In addition, fastrpc_rpmsg_callback() schedules ctx->put_work without
removing ctx from user->pending.  If fastrpc_rpmsg_remove() runs after
fastrpc_rpmsg_callback() while the caller is still in fastrpc_put_args()
(or after an earlier -ERESTARTSYS / -ETIMEDOUT bail left ctx on
user->pending), fastrpc_notify_users() schedules ctx->put_work a second
time, freeing ctx while it is still in use or still linked on
user->pending.  A later patch in the series, commit "misc: fastrpc: fix
context leak and hang on signal-interrupted invoke", addresses the
post-callback cases, but the pre-send and failed-send windows remain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-interrupte=
d-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com?part=3D2
