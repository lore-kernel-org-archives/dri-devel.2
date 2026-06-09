Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA93CD8C85
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A88B10E064;
	Tue,  9 Jun 2026 03:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f7kVCYNK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A6210E073
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 03:14:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8A04601E1;
 Tue,  9 Jun 2026 03:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6925E1F00893;
 Tue,  9 Jun 2026 03:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780974847;
 bh=fMSpDaUcLpaCbDsO6SxQ6E8t7LppmJY4agXtUWtvvfk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f7kVCYNKnZ+WlqGg3JjtkahV9rWX8oEkUjmvYORU3+MssVR77ZwS69KGVlvoeGd3y
 Y8qD9BhJ+poF8kYXfaWelldIZrwvqgKIjflQOw2J8gEd71Wy4HlEYzTlFFkqop6VAw
 PR82Xp7z9OGmnj2J0d9tGGncENp36hR15RuOvt7bwFcJrWePzU8lBPtVQImzVP4Ll3
 /BTwjTborPk5PiOuzIqFKlH9sCeidr1EgkiwW/1yTaJW5PuxKMRFZTXP5DxWcrSAHs
 klYceQlcI9jeEFAsOjzhao7kj3XALVmrle9oSQtGmfcR2rv+qRdxvPb7q0iFLXc3O5
 eyfD6/6/3kk2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] misc: fastrpc: Fix initial memory allocation for
 Audio PD memory pool
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609025938.457-2-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-2-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:14:07 +0000
Message-Id: <20260609031407.6925E1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] `fastrpc_map_attach()` doubly detaches and frees `map->buf` when e=
rror checks fail after mapping.
- [High] Pending invocation contexts and associated DMA mappings are perman=
ently leaked if the remote DSP crashes.
--

commit c836369bdd9f243155871c03517e477035418fb9
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

misc: fastrpc: Fix initial memory allocation for Audio PD memory pool

This commit fixes an issue where the initial buffer allocated for the
Audio PD memory pool was not registered because pageslen was 0. It updates
pageslen to 1 to ensure the buffer is correctly added to the pool.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a9b2ae44c06f6..96961217b8569 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does fastrpc_map_attach() doubly detach
and free map->buf when error checks fail after mapping?

If an error occurs after map->table is successfully assigned, the error
handling block runs:

fastrpc_map_attach() {
        ...
map_err:
        dma_buf_detach(map->buf, map->attach);
attach_err:
        dma_buf_put(map->buf);
get_err:
        fastrpc_map_put(map);
}

Since fastrpc_map_put() invokes fastrpc_free_map(), which also calls
dma_buf_detach() and dma_buf_put() if map->table is set, does this cause a
double free and reference count underflow?

[Severity: High]
This is a pre-existing issue, but does fastrpc_rpmsg_remove() permanently
leak pending invocation contexts and associated DMA mappings if the remote
DSP crashes?

When fastrpc_invoke_send() sends a message to the DSP, it takes a reference
on the context via fastrpc_context_get(ctx) to represent DSP ownership. If
the DSP crashes, fastrpc_rpmsg_remove() runs:

fastrpc_rpmsg_remove() {
        ...
        list_for_each_entry(user, &cctx->users, user)
                fastrpc_notify_users(user);
        ...
}

Since the rpmsg channel is removed, the callback will never fire. Does
fastrpc_notify_users() wake up waiting threads without dropping the DSP's
reference count, preventing the ctx reference count from ever reaching zero?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609025938.457-=
1-jianping.li@oss.qualcomm.com?part=3D1
