Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F55CA9EBD
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E1110E760;
	Sat, 10 Oct 2026 02:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L9Q3BivJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A6C10E760
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 02:26:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CBA84090D;
 Sat, 10 Oct 2026 02:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB041F000FF;
 Sat, 10 Oct 2026 02:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791599211;
 bh=+2BdXX9pb2cu5Ik6Mw8vmo7JccuGnWYhAvUT6+tnz6Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L9Q3BivJMoC2UMv5pln0GqvpC+H/XAs4+tJllJDgSZESpjlTq+UEPzZJTseJ2kuo9
 Py/c+DJMxKKtN/CEcuspaMEJ/0QN0yCat/lG8dW6ruVHbAn678Q6n2JybChUxlXS/k
 34HhMf+HG9Z+ZlWMugeUnS+cMGfoBTXmxgrK8lj3e3vkccPmmBopE//aiE7WN0xZ+y
 BQmdTuDHQFCVfBxii2pO0BEOClK3aDw5w7FQ8Kq+IelmzMYBEbCfyK2TrUmHr7SCyi
 qFM8JhpOfJ5rc/l3tdoyDXtSN4Ar7TmY/LewwGOEaaq87MgcLajZjzck5V3uZ1yqnh
 O7F+72AS0wlpQ==
Message-ID: <sashiko-outbox-166214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] drm/nouveau: Fix memory leak in debugfs init
 error path
To: liupeng <liupeng01@kylinos.cn>
Cc: linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261010022006.28263-1-liupeng01@kylinos.cn>
References: <b4cd38b48d85298a7a99cf30fbd8cbbdb34a347f.camel@redhat.com>
 <20261010022006.28263-1-liupeng01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 02:26:50 +0000
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

> In nouveau_debugfs_init(), if nvif_object_ctor() fails, the previously
> allocated drm->debugfs is leaked because the function returns the
> error code directly.
>=20
> Fix this by freeing the allocated memory and clearing the pointer on
> the error path.
>=20
> Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for debu=
gfs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: liupeng <liupeng01@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010022006.2826=
3-1-liupeng01@kylinos.cn?part=3D1

