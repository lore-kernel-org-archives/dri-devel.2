Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2034CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C0910EAC1;
	Fri, 12 Jun 2026 16:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IuTbxKr4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C9A10EAC1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:46:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 80FCD600B0;
 Fri, 12 Jun 2026 16:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA51F00A3E;
 Fri, 12 Jun 2026 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781282788;
 bh=z3cN2YNTSqj1GppNhVITMb01UlRSfK533h86PTstYe8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IuTbxKr44MkWBs54JcmT2WddU10iS17yV0rdIfw3Y4Ql8jZC1NXfYBLdQMTEdaPkD
 v8tJKzfSbEsZ25prYg5v9daA9Cr1gaCY1KOY1S32INra1cNSz27BUCY8ADsnXFYUR9
 21pvTMvci/EqXeJTfSIe671z1vzaS/+736SrtxDHk5yAek1heuZEfg0Yov1YPsXz8Y
 iKjG5o2AWPCOq9DORioT7zsc7eJuB18/j66Cvcho1Cal5oOW3He9OaGIKl0joU7x1u
 EeNWBxOgPqBAWHOwpU68VB3UwVOdhUZe0QnKUUKg1v0A47H8JF8pItDSkIPsAxqb9I
 HjEPlF3+qtB8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org
In-Reply-To: <20260611161546.4075580-2-zhipingz@meta.com>
References: <20260611161546.4075580-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:46:27 +0000
Message-Id: <20260612164627.F2EA51F00A3E@smtp.kernel.org>
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

> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> therefore accumulate one struct mlx5_st_idx_data per cycle.
>=20
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
>=20
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611161546.4075=
580-1-zhipingz@meta.com?part=3D1

