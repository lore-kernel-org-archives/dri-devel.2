Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762C0C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1F910F2BF;
	Fri, 18 Sep 2026 10:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jBj9YTS8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D1A10F2BF
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:07:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76A6160A59;
 Fri, 18 Sep 2026 10:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BB01F000FF;
 Fri, 18 Sep 2026 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789726072;
 bh=amWrtF5YylKYTYBTBd4Z2A61U41PRF0nvZIEGJTnREs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jBj9YTS8i5+YAis0sKvOENC6wd7w/keLU/NsLRzfHumk3aaEt44dW6ji7QvsLz8iO
 fSABgNUZoC0Du3u+gWmqNK7CYi2XTLVGJ0f2o6dVMn4Eei5fW09EPenIQNzKzGvq5Y
 CGmwL2JjdJSixTMSs2Gb08DQQjHfwudjVi+Hlf/P1x2Xj2WS0k+jYU6jhyZjrLezzG
 4tg3SudQIAanZzCn/HpZzrb/FY7rgU78QYJXBprXUYTn5fNEk9j50u2Gk8JuNeDy2u
 C8NfTANxkHt5FwwG1Ha8CtlIrlucAEd2OSh/zlDShErQYV+swxCJQ7ZUUcu2cy1HAh
 FugeQGaBNyqUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260918095940.2253018-3-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:07:51 +0000
Message-Id: <20260918100751.E1BB01F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918095940.2253=
018-1-honghuan@amd.com?part=3D2

