Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D299CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43EA10F6A0;
	Fri, 19 Jun 2026 17:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZqhaNj/U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B108510E0F5
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 17:05:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36065601F1;
 Fri, 19 Jun 2026 17:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767021F000E9;
 Fri, 19 Jun 2026 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781888709;
 bh=4hFSJbLjJdVvEruNcpXNrm5TQZw+01r2kmFGRAFhdAs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZqhaNj/UP2341Ok16bAGk6xFLSMMJju51wPHZW/HyF2/yr1/qOBoLEcPh0oFDsr4M
 geYSWYkLaC+2hYznb9gf7l4RNcugt22IxEEtkRwYBoWIsLDksDUjgcySUHd0VCcohd
 bnnShQ4lsvKvnlyxPxSAfXhBn/rKdYnIX9aQ4aNoOoR6IYamuu3fic+0wXirnjOUlD
 X7jY5UwZWTyDvyIINJvXdGw1HSKkjpenXlFAyBlrmiE5/bHR3meJXMBjMfV/fAzs58
 1UyTE9fPENL6r/F4yscIj2lgkQqkq8PnyxqXXG1swrJMjTQksBUBCnCAmIisM4XW/x
 2hYGEG04CCU4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] rust: driver: remove `IdTable::id`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org, robh@kernel.org
In-Reply-To: <20260618-id_info-v1-1-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-1-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:09 +0000
Message-Id: <20260619170509.767021F000E9@smtp.kernel.org>
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

> This is unused.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D1

