Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14F7CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC36810E1C3;
	Thu, 25 Jun 2026 10:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YS85pXB5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5063210E1C3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:21:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07D3940837
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962E61F000E9;
 Thu, 25 Jun 2026 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782382903;
 bh=074e0TgLmJQfzaqTBszKxclwp3fTaS/OFFpWZxEGbwQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YS85pXB5q7B4dCmOJiycqAkGhIgPpRgDLOhv+MekWF6RaCBSneLAMoIDn4zYDnkhO
 VhBFLiAFKX1X55YSV1UBAztu5YngDni1UieKSowNroLhk+Q2hXKGNuZs3bYWUhhAtT
 S8syEs5Hq7JRo3LZPvipJo3PP3QcZvnD5IP5c7nl0xQmdohLXEa8iiO1dFGlXnqaZZ
 zAxuYYBjsjO6U2IviLzh7yLGkyf9hZdRFdpJEJREhlkG0EOwHDEJN4Fc4BST30EFvX
 E2zde+CEpioBeDF0ysu0xq7dNDkl/P9Qf9fZ94PUtImX2w/e0yueX71eGcoMsLjfYx
 jxmhYb5P0CQJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 6/8] rust: Add missing SAFETY documentation for
 `ARef` example
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260625-unique-ref-v18-6-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-6-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:21:43 +0000
Message-Id: <20260625102143.962E61F000E9@smtp.kernel.org>
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

> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D6

