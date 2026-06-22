Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E080CDB466
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC48910E1F6;
	Mon, 22 Jun 2026 02:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="leEuiZe7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD5710E1F6
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:26:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02EDC431FE;
 Mon, 22 Jun 2026 02:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD62A1F000E9;
 Mon, 22 Jun 2026 02:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782095213;
 bh=0e0u/VLSBMOvioL9Dr2KOqVj6cclk/Ric+KvXA0phko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=leEuiZe7/dhNKIgafbeDgL2r9Guk9KlsjICDhus8dIHDrwlRLmtRztGCeuowCWJ8I
 sAdd5alGzjycDiLyS+KC3MUcyTjLSJwsxlNnfSywc7dGHKtMuXJGkysk+se/THS9p6
 O5fHa02E85V2VUnN/B1kXnGemlVsSP7FBxO1Gmu9NHRhxOB0olV4v0F+1fvQ0dPzAC
 n1SSI3QJa1LrOegIbOyxTzNOsqb1WntWCjmaALz5WbTchZj/g+30TFv4eY9f2HZrEM
 ///wJHTOhymA66GboQ17p6bGZ9Jg6z2y48NIk+Gke85IboUpek5Usnk5+QMZcpiIr1
 ru0K3xiZ0d7kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] nouveau/gsp/rpc: Document RPC function return
 value contracts
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622021207.14764-2-zenghongling@kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <20260622021207.14764-2-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 02:26:53 +0000
Message-Id: <20260622022653.BD62A1F000E9@smtp.kernel.org>
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

New issues:
- [Low] The newly added kernel-doc comments for `r535_gsp_rpc_send` and `r5=
35_gsp_rpc_push` incorrectly document their return values regarding the POL=
L policy.

Pre-existing issues:
- [High] r535_gsp_msgq_recv() returns NULL instead of an error pointer on i=
nvalid RPC length, leading to unchecked propagation and widespread NULL poi=
nter dereferences.
--

commit 0752081ac429b7a0554a2c49b5c123044b8bdc1f
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rpc: Document RPC function return value contracts
   =20
Add kernel-doc comments to document the return value semantics of
RPC functions in r535/rpc.c. This clarifies which functions can return
NULL, error pointers, or both, helping maintainers validate future
changes.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 3ca3de8f43408..35272c1538699 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c

[ ... ]

> @@ -283,6 +300,15 @@ r535_gsp_msgq_recv_one_elem(struct nvkm_gsp *gsp,
>  	return buf;
>  }
> =20
> +/**
> + * r535_gsp_msgq_recv - Receive RPC message(s) from GSP queue
> + * @gsp: GSP device
> + * @gsp_rpc_len: Expected RPC length
> + * @retries: Retry counter
> + *
> + * Return: Pointer to received buffer on success, ERR_PTR() on error,
> + *         or NULL if RPC length is invalid.
> + */
>  static void *
>  r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_len, int *retries)

[Severity: High]
This is a pre-existing issue, but returning NULL here on an invalid
RPC length seems to cause widespread NULL pointer dereferences later on.

If r535_gsp_msgq_recv() returns NULL, it propagates to callers like
r535_gsp_rpc_rm_ctrl_push(), which handles the error like this:

    if (IS_ERR_OR_NULL(rpc)) {
        *params =3D NULL;
        return PTR_ERR(rpc);
    }

Because PTR_ERR(NULL) evaluates to 0, this gets passed up the stack as a
success condition. Wrapper functions like nvkm_gsp_rm_ctrl_rd() receive
the 0 return code and pass the NULL argv pointer back to their callers.

When a downstream caller like r535_disp_get_supported() checks the result:

    ctrl =3D nvkm_gsp_rm_ctrl_rd(&disp->rm.objcom,
                               NV0073_CTRL_CMD_SYSTEM_GET_SUPPORTED,
                               sizeof(*ctrl));
    if (IS_ERR(ctrl))
        return PTR_ERR(ctrl);

    *pmask =3D ctrl->displayMask;

The IS_ERR(NULL) check evaluates to false, causing a kernel panic when
the NULL pointer is dereferenced on the very next line.=20

Could we change r535_gsp_msgq_recv() to return an error pointer like
ERR_PTR(-EINVAL) instead of NULL when the message length is invalid?

[ ... ]

> @@ -574,6 +625,16 @@ r535_gsp_rpc_handle_reply(struct nvkm_gsp *gsp, u32 =
fn,
>  	return repv;
>  }
> =20
> +/**
> + * r535_gsp_rpc_send - Send RPC message and handle reply
> + * @gsp: GSP device
> + * @payload: RPC payload to send
> + * @policy: Reply policy (NOWAIT, NOSEQ, RECV, or POLL)
> + * @gsp_rpc_len: Expected RPC length for reply
> + *
> + * Return: NULL if policy is NOWAIT/NOSEQ (no reply expected),
> + *         pointer to reply data on success, or ERR_PTR() on error.
> + */
>  static void *
>  r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *payload,

[Severity: Low]
Does this documentation miss the POLL policy's NULL return behavior?

The documentation for r535_gsp_rpc_handle_reply() correctly notes that
when the policy is POLL, it returns NULL on successful message processing.
Since r535_gsp_rpc_send() returns the result of r535_gsp_rpc_handle_reply(),
should POLL be included in the list of policies that return NULL here?

[ ... ]

> @@ -628,6 +703,16 @@ r535_gsp_rpc_get(struct nvkm_gsp *gsp, u32 fn, u32 p=
ayload_size)
>  	return rpc->data;
>  }
> =20
> +/**
> + * r535_gsp_rpc_push - Push RPC message to GSP and wait for reply
> + * @gsp: GSP device
> + * @payload: RPC payload to send
> + * @policy: Reply policy (NOWAIT, NOSEQ, RECV, or POLL)
> + * @gsp_rpc_len: Expected RPC length in the reply
> + *
> + * Return: NULL when policy is NOWAIT/NOSEQ (no reply expected),
> + *         pointer to reply data on success, or ERR_PTR() on error.
> + */
>  static void *
>  r535_gsp_rpc_push(struct nvkm_gsp *gsp, void *payload,

[Severity: Low]
Similar to r535_gsp_rpc_send() above, should this also document that the
POLL policy can return NULL on success?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D1
