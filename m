Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FF606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jaHFhKZd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3C010E41A;
	Sat, 28 Nov 2026 09:44:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1D810E5E0
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 09:44:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B50FB41410;
 Sat, 28 Nov 2026 09:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ECD1F00897;
 Sat, 28 Nov 2026 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795859067;
 bh=lr+v4ROKdlHbsY0t/6Pw8ZOBYX00SENHM0V9FRDf0xA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jaHFhKZd41pKVBz+AfdiuwDRkq7y+aVF/Um0dA8VYauul+T//Pt5K57Op24o7uYQq
 Uq/K8Uee+bYXpRz744KAx4EfKCV43lDm5A/0HFeN+c4IWerid54vuniv4w5oO8UpCX
 8grGZQ32PcAu7WPhcklp4NdlcQOuCEVlltgqeyO/QBbmpbGhbIUuiPOT4iyZ2bPj+u
 6F5Zw4i4wp9AhE1nSn7O2j04XuD/4VxnygMZXk1EuXVP3naZxJ/QZDD20ni6Gt1Jpc
 OIIyNmLyzcsCJ+wtgNGx3eU9uQwQyuFVBI6Ay2Po07R05e9dYhr1xTk0ohOYc6LbkH
 BkOEiGV0X66UQ==
Message-ID: <sashiko-outbox-238596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/qaic: Free the DBC buffer on management transfer
 errors
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261128093322.1217738-1-haoxiang_li2024@163.com>
References: <20261128093322.1217738-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 09:44:26 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] accel/qaic: memory leak in encode_activate() [1]
--

commit 48133c97c10bb67d1f23799c52aaf49134fd456e
Author: Haoxiang Li <haoxiang_li2024@163.com>

accel/qaic: Free the DBC buffer on management transfer errors

This commit frees the DBC buffer allocated during message encoding when
a management transfer fails in qaic_manage_msg_xfer().

> diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_=
control.c
> index 2ccc55486aac0..f322887ec53e8 100644
> --- a/drivers/accel/qaic/qaic_control.c
> +++ b/drivers/accel/qaic/qaic_control.c
> @@ -1250,6 +1250,8 @@ static int qaic_manage_msg_xfer(struct qaic_device =
*qdev, struct qaic_user *usr,
> =20
>  lock_failed:
>  	free_dma_xfers(qdev, resources);
> +	if (ret)
> +		free_dbc_buf(qdev, resources);
>  encode_failed:
>  	spin_lock(&wrappers->lock);
>  	list_for_each_entry_safe(wrapper, w, &wrappers->list, list)

[Severity: High]
This problem wasn't introduced by this patch, but can encode_activate()
leak the DMA buffer in resources->buf [1] when a management message
contains more than one QAIC_TRANS_ACTIVATE_FROM_USR transaction?

encode_message() loops over user_msg->count transactions and calls
encode_activate() for each QAIC_TRANS_ACTIVATE_FROM_USR entry.  Each call
allocates a coherent DMA buffer and overwrites resources->buf and
resources->dma_addr without checking whether a buffer was already
allocated for an earlier transaction in the same ioctl:

drivers/accel/qaic/qaic_control.c:encode_activate() {
	...
	buf =3D dma_alloc_coherent(&qdev->pdev->dev, size, &dma_addr, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;
	...
	resources->buf =3D buf;
	resources->dma_addr =3D dma_addr;
	...
}

Any earlier allocation in the same message is lost and cannot be freed by
free_dbc_buf(), allowing userspace to exhaust coherent DMA memory.

[1] https://sashiko.dev/#/bug/linux-ad70f5f2-e579-4654-84f6-691a5c89ecc1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128093322.1217=
738-1-haoxiang_li2024@163.com?part=3D1
