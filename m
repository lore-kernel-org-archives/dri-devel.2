Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD30C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1DA10EF58;
	Wed,  5 Aug 2026 16:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JQAHtMwj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89F610EF58
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:51:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D88660A5A;
 Wed,  5 Aug 2026 16:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F681F000E9;
 Wed,  5 Aug 2026 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948688;
 bh=fP8aIm5ucdJdsxoDwpH9JoffWb3YynVHVGPzpppRIsM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JQAHtMwjmfGrr/H9oR/QGrlcK0If186NTrIq7VO1K8O61el3L+6qeraeGG9IIKWkS
 yQTXoa+fZaS6M2ZI535n53/6/uqKBM5h1akoSmzzAQBsyoYhhvi1Lp0QO9cLOylD9f
 S/hE5kRXMjvm9T3VnskgmELxUYlTOS2A6kK4c3e7hP3ZYqMeUNmGWhzlhri9lTimcH
 JAnXYnVhcp83qd+v9X5+rz32Z03kMO6n9nw7gj1d1yxh8SKAJzDr8e/XhqSLyCYTQN
 G3Z+TO+LHkPIy7ylj5Oh6h8qfir9ZCPZYr02LrkGdmmVszK4XRyfyTQjIKdG7Ov+C3
 r9R4DKgtGzHLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/16] rust: io: register: remove relative registers
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260805-typed_register-v2-14-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-14-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:51:28 +0000
Message-Id: <20260805165128.91F681F000E9@smtp.kernel.org>
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

> Relative registers can be better served by projection to subregion instead
> of ad-hoc handling in register macro. Projection composes better (e.g. it
> natively allows relative registers of relative registers without needing
> additional support).
>=20
> Remove relative register support, and update the documentation to
> demonstrate how projection and subregions can be used to achieve this
> instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D14

