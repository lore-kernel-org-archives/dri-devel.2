Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEEEC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCDA10F66D;
	Thu, 24 Sep 2026 15:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kgXR2NiV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3328C10F66D
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:29:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F09E9437A5;
 Thu, 24 Sep 2026 15:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C751F000FF;
 Thu, 24 Sep 2026 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790263752;
 bh=AGFDYIYEQisoikw+fhq96SX8EJLCskHJldNScxTRxAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kgXR2NiVBVY261qR34oungGAb01AQ4QIxvBxzs4uEsJaU6PZZnjW2b3C2uufxEyqU
 OlOg9jMJaNF6sQQqI/nBTzPNcy/5DjEBH7I7B2neosX86PRmWFyNUY+b9LUMQAn13T
 kfaTzDq2lzAxZT45EcvQBRwZjy0zJwZrrcGrirqO9z+9EAaxAxF1chQs8GvTh86ti9
 q8mDcIVZ3QdP/qKETcHeBetnHR4YhkZzKVld2BWq1Bvo0n9U5i6rxEde5cge9n5LQE
 cLDe7RGkiNjaWHiKqA9nDSgKGhJ5lQRKFRlh/X73ZQlkaffCvrIBCqwPBv07p+EWTs
 sKzDOKgM4Y2wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] dma-buf: Provide dma_buf_set_name()
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20260924152159.49702-4-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-4-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:29:12 +0000
Message-Id: <20260924152912.90C751F000FF@smtp.kernel.org>
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

> Allow exporters to set the name of buffers, during export or for
> subsequent updates.  This is useful to express buffer-specific debug
> information, indicate state particular to the exporter's usage, etc.
> Only exporters and userspace are expected to set names; it isn't
> sensible for importers to do it.
>=20
> Originally, the static dma_buf_set_name() was used for
> DMA_BUF_SET_NAME ioctls, taking a __user string parameter.  Export
> this function as a generic set-name helper, taking a kernel-allocated
> string.  The SET_NAME ioctls now locally duplicate the __user string,
> and use the new function to set the name.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D3

