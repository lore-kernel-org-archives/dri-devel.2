Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E2606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUERUiMH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A9310F18E;
	Tue, 17 Nov 2026 09:52:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40DC10F18E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:52:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8F8E63391;
 Tue, 17 Nov 2026 09:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7136C1F000C6;
 Tue, 17 Nov 2026 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794909156;
 bh=x4pbA/L+Ymw8Na6QG//ogZfD4YivVNajYDJRlqVEB6E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PUERUiMHGt0SG8bOJaQuDIphbqRW5lAUFpzcD53nFRkcZ/Dxqn86TDDII5vwcaNkG
 lhKIWpVHubAF6tAhA54OpsA90v5iB6jGJkt+So7Da3Bz1V4O58zNOnZzAPmyuBL6eu
 8GNFF/pTWGuCdUvxKO7mMqsISKuxA453j5xROHC2zqDZfYhcN9Pqe/iHobNoQyCuwL
 g9WWcbGhKXYVCbtbZWfgHCV+BRLsyJE7FOeBndXpoqiiC5eMGo0g9MdVOPDI3fdDef
 5YEzHo1PSYjFE/eOAloVkdy6VQ3FwbUMuX66UclZO87Wc6qrdrRBymhDxd8kovFJi4
 rWB7+KNOm4qoA==
Message-ID: <sashiko-outbox-218543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] misc: fastrpc: remove dead context drain in
 fastrpc_user_free()
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-interrupted-invoke-v4-v4-1-2320a8a7eda2@oss.qualcomm.com>
References: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
 <20261117-interrupted-invoke-v4-v4-1-2320a8a7eda2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:52:36 +0000
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
- [Low] misc: fastrpc: unused forward declaration of
  fastrpc_context_put()
--

commit 8ed1609862d2b846e6b55b9095d296720f5399b3
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: remove dead context drain in fastrpc_user_free()

This commit removes the unreachable loop over fl->pending in
fastrpc_user_free() because each invoke context holds a reference on fl
and unlinks itself from fl->pending before dropping that reference.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9e760f68bcaf2..bb0c30419611c 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -568,17 +568,11 @@ static void fastrpc_context_put(struct fastrpc_invo=
ke_ctx *ctx);
>  static void fastrpc_user_free(struct kref *ref)
>  {
>  	struct fastrpc_user *fl =3D container_of(ref, struct fastrpc_user, refc=
ount);
> -	struct fastrpc_invoke_ctx *ctx, *n;
>  	struct fastrpc_map *map, *m;
>  	struct fastrpc_buf *buf, *b;
> =20
>  	fastrpc_buf_free(fl->init_mem);
> =20
> -	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
> -		list_del(&ctx->node);
> -		fastrpc_context_put(ctx);
> -	}

[Severity: Low]
Can the forward declaration of fastrpc_context_put() right above
fastrpc_user_free() also be removed now that fastrpc_user_free() no
longer calls it before its definition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-interrupte=
d-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com?part=3D1
