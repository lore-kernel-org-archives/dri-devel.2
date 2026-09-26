Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1F6C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 17:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC34710E167;
	Sat, 26 Sep 2026 17:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l1duSq7t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D203210E167
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 17:29:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2494602D3;
 Sat, 26 Sep 2026 17:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDDF1F000FF;
 Sat, 26 Sep 2026 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790443791;
 bh=NCTBProfddY6k9PZ9H1f3woNUbAYR4mxf2lBdWvvQpE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l1duSq7tfC4sCNCUu7+y7Jds6GcS4BMZiSsGxB2x9zlskiyyunaruiXZCZ4JL4zQ7
 1HF/0cShhpHITrDQCP1usBq1EyzY6xwyIN3sauJdm3QBVRPKy2pgHYj92qS81aAp9r
 AQdnqDexNkmqTFl7kcnAk181jbEng/dblCBTPhOTnXBu9Lr95kfZh/CoY32us/9yKx
 /Ny5PqkIK7LRUqp+wY3/lawPoju0uKmqJ2EHQeW7iQbw8XUAISxLJ8ipDZOIDGUYG8
 bZD4jNaFtwIUv3cBFxGr8WfgwemIprt1+wAZRhV1QGyAyGPizQaTjbZuvfohOnq+c3
 bXtYPs7QZmvuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink
 import
To: "David Carlier" <devnexen@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260926171625.288519-1-devnexen@gmail.com>
References: <20260926171625.288519-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 17:29:50 +0000
Message-Id: <20260926172951.3DDDF1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] amdgpu: duplicate in-flight NPA-REVOKE bypasses early exit causing=
 NULL deref
- [Medium] amdgpu: in-flight NPA-REVOKE fails to complete npa_done causing =
spurious timeout
--

commit 707623cd9d98bbd57c7b50f6dc2ad0e819566c82
Author: David Carlier <devnexen@gmail.com>

drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink import

This patch modifies the NPA-REVOKE handler to cleanly mark in-flight UALink
imports for teardown rather than crashing by dereferencing a NULL dmabuf.
The importer thread now checks for this teardown state and unwinds safely
if the handle was revoked before the import completed.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ualink.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3288,7 +3289,19 @@ static void amdgpu_ualink_process_npa_revoke_msg(s=
truct amdgpu_device *adev,
>  		return;
>  	}
> =20
> +	node_state =3D READ_ONCE(imp_xa_node->node_state);
>  	WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
> +
> +	/* The import is still in flight: the dmabuf may not exist yet and
> +	 * nothing has been handed to user-space. Leave the node to the
> +	 * importing thread, which sees the teardown state and unwinds.
> +	 */
> +	if (node_state =3D=3D AMDGPU_UALINK_NODE_NOT_READY ||
> +	    node_state =3D=3D AMDGPU_UALINK_NODE_PENDING) {
> +		xa_unlock(&adev->ualink.imp_xa);
> +		goto send_release;
> +	}

[Severity: High]
If a duplicate NPA-REVOKE message arrives for an in-flight import, the
node_state is already AMDGPU_UALINK_NODE_TEARDOWN. Does this bypass the
early exit check here since it only checks for NOT_READY or PENDING?

If it bypasses this check, it will fall through to the GPUVM mappings
invalidation and unconditionally dereference imp_xa_node->dmabuf->priv
(which is NULL at this stage), causing a kernel panic.

[Severity: Medium]
When an NPA-REVOKE message arrives for an in-flight import, it sets the
node state to TEARDOWN just above, but does this strand the importing threa=
d?

If we do not call complete(&imp_xa_node->npa_done) here, and the NPA-RSP
subsequently arrives, the RSP handler skips calling complete() because the
state is no longer NOT_READY:

amdgpu_ualink_process_npa_rsp_msg() {
    if (READ_ONCE(imp_xa_node->node_state) =3D=3D AMDGPU_UALINK_NODE_NOT_RE=
ADY) {
        WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_PENDING);
        complete(&imp_xa_node->npa_done);
    } else {
        ...

Will this cause the importing thread to wait until the timeout expires,
resulting in a spurious timeout and an unnecessary full connection reset
of the vPod?

> +
>  	list_del_init(&imp_xa_node->list);
>  	xa_unlock(&adev->ualink.imp_xa);

[ ... ]

> @@ -3299,6 +3312,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(st=
ruct amdgpu_device *adev,
>  	/* Drop the refcount for the node */
>  	amdgpu_ualink_imp_xa_entry_put(imp_xa_node);

[Severity: High]
If a duplicate revoke bypassed the early exit check above, does it also
drop the reference count a second time here?

This could lead to a double-free when the importing thread eventually cleans
up the node.

> +send_release:
>  	r =3D amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
>  	if (r)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926171625.2885=
19-1-devnexen@gmail.com?part=3D1
