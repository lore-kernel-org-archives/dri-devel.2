Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD88C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4D210F40F;
	Thu, 24 Sep 2026 10:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PAQNTquA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45AE10F40F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:04:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FEF94145B;
 Thu, 24 Sep 2026 10:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BF51F000FF;
 Thu, 24 Sep 2026 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790244275;
 bh=zu0nkgjweQib9jicgTSO8dUt6uxmPAqflJYOqzySfAA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PAQNTquAM13ECSH7uzVzlNYhcBXMy/zohNzRRvOGYbkJf0e4Fwsg0VfVw3uX50SBU
 5nNiUlhTw286uSqosz7rP2h1gIer4lXTuNqY3gXQHdTHZY7rLZQBrXoPCt0uDb7yso
 HkAS/ugVDklRxq2ZlYWAWE4Xhfljben5tNOlnp6Vp4E4/7XD1FnmkIqOdyk00oI8xP
 Hl7Wa5U4sgL9M3Rm9OmllXUT60KueKmeUhVzM/Z1ijNs9ID0x9Gw9Xch7fFZJDoC0t
 ATN1/bZbBun4zro2PdDtbxXV2fZHkQx4Qzo9ahufDlQo+TnspaU/51+JpKWORM3ltx
 lebkVY28MIUwA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 2/4] drm/virtgpu api: add blob userptr resource
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260924095556.1326164-3-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:04:34 +0000
Message-Id: <20260924100435.32BF51F000FF@smtp.kernel.org>
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

> Add a userptr address field so userspace can request a blob backed
> by an existing process mapping. A non-zero userptr selects that
> path; probe VIRTGPU_PARAM_USERPTR before using the field.
>=20
> GPU-readonly backing is requested with the virtio CREATE_BLOB wire
> flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
> VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
> resource. The guest pins without FOLL_WRITE only when the device
> advertised VIRTIO_GPU_F_BLOB_READONLY (VIRTGPU_PARAM_BLOB_READONLY).
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924095556.1326=
164-1-honghuan@amd.com?part=3D2

