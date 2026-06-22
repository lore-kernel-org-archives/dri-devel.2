Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B97CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A81D10E537;
	Mon, 22 Jun 2026 08:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I53hm69d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4DC10E537
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:27:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B92F740DEC;
 Mon, 22 Jun 2026 08:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF5B1F000E9;
 Mon, 22 Jun 2026 08:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782116857;
 bh=BYHAUpTJiVhLCqaNNQZfgG0s632pELqkTFMo+jPQw2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I53hm69dC86eMrdK4oq+9wZAZ4l7q+AeYfcZY8fpi2XoNphQUkPZphs0rb/ivJ8yA
 J78aRfzfvB44mrrjC1WwZ90CGSr7r8f1anueYVaUeR1yvZuTejkUuxZwi++nmwiBfM
 redqulVqNgBSdwXWTAJG67sImYODDGwoIrplKCqYbbb+AVkwMYMxL5ssgK/VBEXHMS
 NhJa0ktqEvt78V0aATSh0BUi+BRsU6ycR+yLe8mJQ/LHa/UIskIFfWbQFW+8l/XUYA
 R5biJhFZuFH5dscdHulm1hIk8tLQcELqTX+C3jA6Mb1+f7oJgjMnZ3Ah+4f+pYiYhB
 edJb60yLw6beg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] nouveau/gsp/rpc: Cleanup incorrect
 IS_ERR_OR_NULL in  rpc.c
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622081136.61695-3-zenghongling@kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <20260622081136.61695-3-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:27:37 +0000
Message-Id: <20260622082737.7CF5B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing upper and lower bounds checks on the untrusted `rpc->l=
ength` field from GSP messages causes severe integer underflows and heap bu=
ffer overflows.
- [High] Returning NULL on message length error in `r535_gsp_msgq_recv()` l=
eads to false success reporting.
- [High] Early returns on error paths in GSP message reception fail to adva=
nce the read pointer, causing a permanently deadlocked queue.
- [High] Memory leak of large GSP RPC messages on error paths in `r535_gsp_=
rpc_push`.
- [High] Missing read memory barrier (`smp_rmb`) when polling the GSP messa=
ge queue write pointer allows out-of-order reads of stale payload data.
--

commit b9953ccb9eee21566520494158c392c95237ec17
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c

This commit cleans up incorrect IS_ERR_OR_NULL() usage for functions
that never return NULL, such as r535_gsp_msgq_peek() and
r535_gsp_msgq_recv_one_elem(). It updates them to be checked with
IS_ERR() instead.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index b4b2b5c00ab4e..5b89c8835a2e4 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> @@ -350,7 +350,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_=
len, int *retries)
>  		u32 size;
> =20
>  		rpc =3D r535_gsp_msgq_peek(gsp, sizeof(*rpc), info.retries);

[Severity: High]
This isn't a bug introduced by this patch, but earlier in r535_gsp_msgq_rec=
v(),
if the message length is invalid, it returns NULL:

	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;

Since callers like nvkm_gsp_rm_alloc_wr() use IS_ERR() to check for failure=
s,
does this cause the caller to incorrectly treat the operation as a success
because IS_ERR(NULL) evaluates to false?

[Severity: High]
This is a pre-existing issue, but do the early returns on error paths in
GSP message reception fail to advance the read pointer?

For example, in r535_gsp_msgq_recv():

	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;

And in r535_gsp_msgq_recv_one_elem():

	if (rpc->function !=3D NV_VGPU_MSG_FUNCTION_CONTINUATION_RECORD) {
		nvkm_error(&gsp->subdev,
			   "Not a continuation of a large RPC\n");
		r535_gsp_msg_dump(gsp, rpc, NV_DBG_ERROR);
		return ERR_PTR(-EIO);
	}

Since they return without advancing *gsp->msgq.rptr, will subsequent attemp=
ts
to process the queue peek the exact same malformed message and hit the same
error, causing a permanently deadlocked queue?

> -		if (IS_ERR_OR_NULL(rpc)) {
> +		if (IS_ERR(rpc)) {
>  			kvfree(buf);
>  			return rpc;
>  		}
> @@ -359,7 +359,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_=
len, int *retries)
>  		info.continuation =3D true;
> =20
>  		rpc =3D r535_gsp_msgq_recv_one_elem(gsp, &info);

[Severity: Critical]
This is a pre-existing issue, but does this code lack upper and lower bounds
checks on the untrusted rpc->length field from GSP messages?

If a compromised GSP provides a small length for a continuation record, it
looks like len - sizeof(struct nvfw_gsp_rpc) in r535_gsp_msgq_recv_one_elem=
()
could underflow:

	if (info->continuation)
		memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
		       len - sizeof(struct nvfw_gsp_rpc));

Additionally, a few lines below this hunk in r535_gsp_msgq_recv():

		size =3D info.gsp_rpc_len - sizeof(*rpc);
		expected -=3D size;
		info.gsp_rpc_buf +=3D size;

Could this overflow the kvmalloc-allocated buffer since there is no upper
bound check ensuring rpc->length does not exceed expected?

> -		if (IS_ERR_OR_NULL(rpc)) {
> +		if (IS_ERR(rpc)) {
>  			kvfree(buf);
>  			return rpc;
>  		}

[ ... ]

> @@ -499,7 +499,7 @@ r535_gsp_msg_recv(struct nvkm_gsp *gsp, int fn, u32 g=
sp_rpc_len)
> =20
>  retry:
>  	rpc =3D r535_gsp_msgq_peek(gsp, sizeof(*rpc), &retries);
> -	if (IS_ERR_OR_NULL(rpc))
> +	if (IS_ERR(rpc))
>  		return rpc;
> =20
>  	rpc =3D r535_gsp_msgq_recv(gsp, gsp_rpc_len, &retries);

[Severity: High]
This is a pre-existing issue, but does r535_gsp_rpc_push() leak large GSP R=
PC
messages on error paths?

If the payload size exceeds max_payload_size, the message is chunked and the
original msg must be freed manually. However, the error paths seem to bypass
this:

r535_gsp_rpc_push() {
...
done:
	mutex_unlock(&gsp->cmdq.mutex);
	return repv;
}

If any intermediate chunk allocation or sending step fails and triggers the
goto done path, does this bypass the kvfree(msg) call and leak the large
message allocation?

[Severity: High]
This isn't a bug introduced by this patch, but does r535_gsp_msgq_wait()
miss a read memory barrier when polling the GSP message queue write pointer?

r535_gsp_msgq_wait() {
...
	if (WARN_ON(!*ptime))
		return -ETIMEDOUT;

	return used;
}

Since there is no smp_rmb() between checking the write pointer and reading
the payload from shared memory, could the CPU speculatively execute the
payload reads before the pointer read completes on weakly ordered architect=
ures,
observing stale memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D2
