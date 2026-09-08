Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9348CC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC7D10E81A;
	Tue,  8 Sep 2026 08:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O6WZZ5om";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF1810E81A;
 Tue,  8 Sep 2026 08:58:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D5B8A601DB;
 Tue,  8 Sep 2026 08:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CFB1F00A3D;
 Tue,  8 Sep 2026 08:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788857920;
 bh=aH26wH+fJnU5hoJxue/sRsPR364h/BpWw8xFR/sa41c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O6WZZ5omvqycjzOrmuQtRTSL44Vwxx6ma94i6qr3G//x3LriJ/aXdvH9FWKZusk7b
 I1M2b53+vZkdvxTxWAIL93f/v6tyncT9sFy7R0+swQqLEfqyswyRszeP8Uz2k877p1
 zBp2GstyI8qgF+t2ns9vQTXh0hWRBB8XzpnlYbL67g7EiEKHhuHdF0dqkOfDzG0rbt
 sTC2rSCJADrd86ONW6vRf21OIHxphaeUDLQAolna0OXMxMEcVZ3rGJRudZpHcj9WcY
 EQNFvOEu9sT3fZfzXM7zDjqWcew2rc+SPai8yKuLyp6c9cJwlSQqkOr4efw6xIqSMO
 K5wgGsEnbmcxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] drm: Add drm_work_fence helper
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260908084627.352535-2-srinivasan.shanmugam@amd.com>
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
 <20260908084627.352535-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 08:58:39 +0000
Message-Id: <20260908085840.57CFB1F00A3D@smtp.kernel.org>
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
- [Critical] Race conditions in dma-fence signaling and callback addition a=
llow deferred work to be queued after cancellation completes, leading to Us=
e-After-Free.
--

commit 43b8d6b8cd3ff463894478af19fe890e4879d181
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: drm: Add drm_work_fence helper

GPU drivers often need to queue work when a dma-fence signals
because certain operations (copy_to_user, eventfd_signal, memory
allocation) cannot run in IRQ context. This helper handles the
dma-fence-callback-to-workqueue pattern.

> diff --git a/drivers/gpu/drm/drm_work_fence.c b/drivers/gpu/drm/drm_work_=
fence.c
> index 0000000000000..ac66ba129ffff
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_work_fence.c
[ ... ]
> +static void drm_work_fence_cb(struct dma_fence *fence, struct dma_fence_=
cb *cb)
> +{
> +	struct drm_work_fence *wfence =3D
> +		container_of(cb, struct drm_work_fence, cb);
> +
> +	drm_work_fence_queue(wfence);
> +	/* Single ref: wfence->fence released in drm_work_fence_destroy(). */
> +}

[Severity: Critical]
Does this callback execution leave a race window?

The callback in drm_work_fence_cb() executes asynchronously. Between its
execution and the call to queue_work(), there appears to be no state indica=
ting
to cancel_work_sync() that the work is active.

[ ... ]
> +int drm_work_fence_add_callback(struct drm_work_fence *wfence,
> +				struct dma_fence *fence)
> +{
> +	int err;
> +
> +	drm_work_fence_get(wfence);
> +	wfence->fence =3D fence;	/* transfer caller's ref =E2=80=94 single ref,=
 no get */
> +
> +	err =3D dma_fence_add_callback(fence, &wfence->cb, drm_work_fence_cb);
> +	if (err =3D=3D -ENOENT) {
> +		drm_work_fence_queue(wfence);
> +		err =3D 0;

[Severity: Critical]
Does this -ENOENT fast path also contain the same race window?

If drm_work_fence_cancel_sync() is called by a teardown thread just before
drm_work_fence_queue() is executed here, it seems cancel_work_sync() could
fail to wait for the work to finish.

[ ... ]
> +void drm_work_fence_cancel_sync(struct drm_work_fence *wfence)
> +{
> +	if (drm_work_fence_cancel(wfence))
> +		return;
> +	if (cancel_work_sync(&wfence->work))
> +		drm_work_fence_put(wfence);
> +}

[Severity: Critical]
Could this logic lead to a use-after-free regression during teardown?

This function seems to assume that if the callback is not in the list, eith=
er
the work is already pending/running, or the work has finished. It appears to
ignore the window where the work is about to be queued but is not yet pendi=
ng.

Can this sequence occur when an unprivileged userspace application concurre=
ntly
signals a fence and destroys the context?

CPU1 (signaling thread or -ENOENT path)
Removes callback from the list, then executes drm_work_fence_cb() but is
preempted before calling queue_work().

CPU2 (teardown thread) sees this in drm_work_fence_cancel_sync():
    if (drm_work_fence_cancel(wfence))
        // Returns false because callback is not in the list

    if (cancel_work_sync(&wfence->work))
        // Returns false immediately because work hasn't been queued yet

Function returns, allowing the driver to tear down resources.

CPU1 resumes:
Calls queue_work(), and the worker executes, accessing the freed driver
resources.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908084627.3525=
35-1-srinivasan.shanmugam@amd.com?part=3D1
