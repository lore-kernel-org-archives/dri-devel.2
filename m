Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86CDC982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 19:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA98B10E0E6;
	Sun, 20 Sep 2026 19:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VxPBeChF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9767310E0E6
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:29:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E0CF600C8;
 Sun, 20 Sep 2026 19:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06891F000FF;
 Sun, 20 Sep 2026 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789932581;
 bh=ZCEb7PWxWjqFXQU9Aa1wIndmD1/mjEbe7eeXsYlBY9E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VxPBeChFm1kfmAHFDzUusOB4q1TVtxvmFtelNjQrvzNZT7nK7y/jXeWqT5QYlLBzo
 Oxmn++OSXhC6H9rBldzloDhSVMf6XbHIqqPLT7OnPQxf7qzMWgZCCIo+JOJdWFp+87
 c61GY5DX1C372ocLv2NjUINUxGbztVs4jrZ/FUzzyeYmnRBc4SZzQQkjVtZmXztd0m
 EzF+YkWbgvofJ4x5cEj1jN6dtJihlUNZbXxk4f/Ls1pQGrFvRk1XZJA4atvjkFBiyb
 yNHEoU1jzZPUhkeR/iZIFebIRWERjbwbAK3fJChQAP+T2ja1CJzUoU2ibtLE+wpKFr
 kNI2KzGbeJagg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/virtio: Open-code drm_simple_encoder_init()
To: "Sebastian von Arx" <linux@sebastianvonarx.ch>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260920184244.464343-2-linux@sebastianvonarx.ch>
References: <20260920184244.464343-1-linux@sebastianvonarx.ch>
 <20260920184244.464343-2-linux@sebastianvonarx.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 19:29:40 +0000
Message-Id: <20260920192940.B06891F000FF@smtp.kernel.org>
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

> drm_simple_encoder_init() only wraps drm_encoder_init() with a
> cleanup callback. Open-code the helper in preparation for removing
> drm_simple_encoder_init().
>=20
> Assisted-by: LLM
> Signed-off-by: Sebastian von Arx <linux@sebastianvonarx.ch>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920184244.4643=
43-2-linux@sebastianvonarx.ch?part=3D1

