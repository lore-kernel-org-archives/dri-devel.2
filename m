Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF14DCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFA010F67D;
	Fri, 19 Jun 2026 17:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a5t9GqxG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5659B10E0D9
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 17:05:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FC7D4046E;
 Fri, 19 Jun 2026 17:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44141F00A3D;
 Fri, 19 Jun 2026 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781888707;
 bh=Hj/ZXpvdzv+03lGtx43cYavr8FbG7nggy5+aEmqkaeU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a5t9GqxGtQkgti+GBubCXRYnOyzoq34zgUD3QCC5OUEOyXVwEco4TcAqM5ew3Bd/K
 G1+7uFLdlxi+LyvJ2pZ0KFrpOXurB2cf4hYPDxVgayIlEqbTVjimOwK4okwspjHhis
 WyIKCBbNhMUDVDzOkMZkvZ+4ij9Silv6vDA80YQ+uNQyP4A16PKbzueds3TvDhZgou
 nNZU7i8seFiiz5LzfZMh0g+J6hB0dkI83BIN2Iwj8vF9ulLXUqmF954NqPGuDRr6a8
 d9Vi0tiQn29dHu8Vm3CrYLLOWrfcIJMgJnOP0PXZTZi5UR+C8HrPQXvQi0HKcPR29z
 AxCXND31NJNzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] rust: net/phy: remove expansion from doc
To: "Gary Guo" <gary@garyguo.net>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260618-id_info-v1-4-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-4-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:06 +0000
Message-Id: <20260619170506.A44141F00A3D@smtp.kernel.org>
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

> The expansion serves little purpose and it can easily diverge.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D4

