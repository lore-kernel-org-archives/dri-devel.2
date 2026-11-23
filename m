Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D4606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyE4WWr2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AFD10EC3D;
	Mon, 23 Nov 2026 15:59:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47F310EC3D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:59:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C47446226D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAE81F000EB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795449569;
 bh=z1gOcE4sJDHdxNv2xjdQJHwE41dUt343uBhIQUVlSbo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=NyE4WWr2bYRyPrtQ0BjND99uXDUVHjV+msu5AQC0qgAw9hX/r+VNrMLcx9T7n81fe
 KpKL0RkZox1E86XW7DiiT1SQPvuXfKfEN0AX2YJWgJL2HQHwyGXPfkAdDr3e0Sm1v7
 CTL60zgorXfY0BW9Bs7JUIiB4+PkhBjmBbNpl7PHIchzibkMaGHvn7oFXGHm9tJi3Q
 F09Dfj/3szF+1Af86s15Tzpu7ffaRvExTQBld/V4GjVbowyoPQojKTPKrCWYtq+y7s
 0lTKmCxccJgZ15Hkq/OPevcuuZ5UDqD54fOWLadPibHRFirQpl6nSMXqwdJ6tdz2Ls
 ldSfzOa1P1HHw==
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso2342726c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:59:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErF53elEk0MbF6rubWk6ugLWvvGSSRS2IeNtbMGDH7rtKujwaIYZjkBwnkXUGmtb4SDt7qZ6X1Wx3iQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9agC9iSI63oaiwN059u7839TTXsCaL0V5RWYdCKGRxr9HyZtzc
 TpD1+q63r2u8vTmRpTazjeokLNCcBihMmzSIJi4q477P3BpPuB37drSS8Nij4oOEnAijYft5UGB
 71Gqc+Kk1ETr8rKyTDDSyIhCuObjGPQ==
X-Received: by 2002:a05:7022:1587:b0:1b2:6d5b:36bc with SMTP id
 a92af1059eb24-1b5568efd35mr14176365c88.23.1795449568635; Mon, 23 Nov 2026
 07:59:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <confirmed-20261105-38-2e09963f1b23@gmail.com>
In-Reply-To: <confirmed-20261105-38-2e09963f1b23@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 15:59:15 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8cH0mYNqneRvrLnXoiYfDajs2mC1QDQNLFBbO_h6jzDg@mail.gmail.com>
X-Gm-Features: Aa3M54ouwi-KBChskOnrEwzeqY5DzbDhQkaCtvHg-m39Wxz8dX26BLU8Xe3rDyA
Message-ID: <CAAOTY_8cH0mYNqneRvrLnXoiYfDajs2mC1QDQNLFBbO_h6jzDg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Keep the mutex node reference across
 deferred binds
To: Yige Jiang <yigejiang86@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Yige Jiang <yigejiang86@gmail.com> =E6=96=BC 2026=E5=B9=B411=E6=9C=886=E6=
=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> mtk_drm_probe() acquires private->mutex_node and releases that reference
> on probe failure or in mtk_drm_remove(). The component bind callback does
> not acquire another reference, so it must not put the node when the mutex
> platform device is not available.
>
> If this bind failure propagates through component_master_add_with_match()=
,
> the probe error path puts the same reference again. A bind attempted afte=
r
> probe has returned can also leave the stored node without its reference
> for a later bind or remove.
>
> Remove the bind-time put and leave the node reference with its probe/remo=
ve
> owner.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---
