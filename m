Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E57CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D5E10E59B;
	Mon, 22 Jun 2026 09:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FCAXY3kU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AD510E59B
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:18:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B3FA418F0;
 Mon, 22 Jun 2026 09:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1171F000E9;
 Mon, 22 Jun 2026 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782119913;
 bh=FjPs0M2QPPibXQkfaHc2roooYDCYXm7i1plgyrkzkcE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FCAXY3kUhFxnqUaSnxjc/frJd8d9v40p51uD8UJfjHfca5knEu1RHsoeviDur1KSB
 /zA9Ikx0N1yLK8zbbbIfc12044cykkq8ggv/Owjq0ZqF+rRdPlu94iRPopqlV0zrqu
 F8LNWCa/3HghNe3Png7/bRN8O9lYp6vq1EvddM6pLqFTJoR2CDEoSZfv4AfFnA9CvF
 ZxLB/E1+4flX+Qt8WK/I6ET/4wtb1RXfO839YbNkSt1He2slBx9vu7c0ANuoRroONz
 cnBVhpQDWI6Lx6RNiwTAccRLZ9NpyPGfwHAhMganTtvwl91nzu+aSmkOHth9uDqLXa
 UFsFPosNn/azQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119053310022.17263.seg@mailgw.kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <1782119053310022.17263.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:18:32 +0000
Message-Id: <20260622091832.DA1171F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Heap buffer overflow due to integer underflow when parsing GSP RPC=
 messages.
--

commit 87c0818f37bba3a580cd4e8905cc4819a930a1c7
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage

This commit cleans up r535_gsp_rpc_rm_free() by replacing IS_ERR_OR_NULL()
with IS_ERR(). This matches the behavior of nvkm_gsp_rpc_get() which only
returns valid pointers or error pointers, never NULL.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c b/dr=
ivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> index 46e3a29f2ad7f..c9f86c0e9b255 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the RPC
parsing code, could the GSP message queue handling be vulnerable to an
integer underflow?

In r535_gsp_msgq_recv() in rpc.c, the firmware-provided rpc->length is read
from the untrusted GSP shared memory message queue:

r535_gsp_msgq_recv() {
        ...
        rpc =3D r535_gsp_msgq_peek(gsp, sizeof(*rpc), info.retries);
        if (IS_ERR(rpc)) {
                kvfree(buf);
                return rpc;
        }

        info.gsp_rpc_len =3D rpc->length;
        info.continuation =3D true;
        ...
}

If this length is not validated to be at least sizeof(struct nvfw_gsp_rpc),
it appears we could underflow the length calculation in
r535_gsp_msgq_recv_one_elem() when processing continuation messages:

r535_gsp_msgq_recv_one_elem() {
        ...
        len =3D min_t(u32, expected, len);

        if (info->continuation)
                memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
                       len - sizeof(struct nvfw_gsp_rpc));
        ...
}

If rpc->length (and therefore len) is less than sizeof(struct nvfw_gsp_rpc),
does len - sizeof(struct nvfw_gsp_rpc) underflow to a massive positive valu=
e,
leading to an out-of-bounds read and a massive heap buffer overflow into
buf during the memcpy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D3
