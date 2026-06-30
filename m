Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B122DC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC1610EC6E;
	Tue, 30 Jun 2026 12:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O8MgRWRl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648FD10EC5C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DD4F43F23;
 Tue, 30 Jun 2026 12:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F391F00A3A;
 Tue, 30 Jun 2026 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823225;
 bh=BZDn9zyhiAJotKucvTyzRFglPuTMZiR6GF5jquk1YIU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O8MgRWRlM7TURdKX9dsYCFwnrzKbKGN4zl9zy/P3fqFj2FEGG4ruZYuRnJC5XLbc8
 H9htLP7mqxikcDlwylWoDMnbNTC/Ats8f5zNpBFnHZJOv3kUdXWfUm7deMO0gvZC1W
 2s6RT1ygnjzcxrhBu3zl9Qtmyc4/NzenDJ6ocf37NKdxOUmq9w3tTF7tTeY2N0mEzs
 uh/T8jc1ERU1YpwNDpCGU6BsJL1szfJ4N+pQ+kI2k/+1GyLuN1uAuS9OptiL5UlKv8
 QP3hDYgpREuLfBNKo1U5wQCES2F13bXcUrIQMN8/mDCn6Uu3AhFCds/sceNT1ZrN0P
 y1UZU0sliTc5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/11] RFC: rust: driver: support map-like syntax for
 ID table
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:23 +0000
Message-Id: <20260630124024.A7F391F00A3A@smtp.kernel.org>
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

> The device ID table and its associated info is really just a map. Add a
> syntax to `module_device_table` macro that reflects that.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D11

