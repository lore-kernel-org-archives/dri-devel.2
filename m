Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1BCC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A583D10F683;
	Fri, 26 Jun 2026 14:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gXngImC3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBA310F683
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:53:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7708F42AC4;
 Fri, 26 Jun 2026 14:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E423C1F000E9;
 Fri, 26 Jun 2026 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485632;
 bh=jbc4hSqLknC659WftQfiApIpJ5hr7aBtZAQhdOmcfM4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gXngImC3AafpRBBcjLMi86XgXpfh1GhHszFHxri+YLQ2cvusdLdaSnQhQmqNRyBER
 SxMp9Sq2Vwhxv7S1AwSYv67TvMRvjTh2QBFC3+NIKLJA7TIbPQwqkWxFpI7nhT0A/H
 tw7CmTywx8Y+iMHvr51OpkiQhGB6G8yzADeHbs/x+Y2c5jdMzrWqQIP9ImuihqeqNW
 UsFNJaWiqWzhPVK0uazLmmLA5odee3KDOWQceBaS5SIBqnqI5Q6gkiB0eJnDgsyCrl
 T9MIM9TzVCnP16APPIbOomaeFayPmuh1AxqNt4CFk48O3RDLH+H5kxdwn4ZBJ2jV1q
 afov52rFK5oJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/20] rust: io: remove `MmioOwned`
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:53:51 +0000
Message-Id: <20260626145351.E423C1F000E9@smtp.kernel.org>
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

> `Io` trait is now very easy to implement. Thus, implement it on `Bar` and
> `IoMem` directly and remove the `MmioOwned` struct.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D11

