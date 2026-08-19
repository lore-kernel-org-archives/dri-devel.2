Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07713C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8E110EDA7;
	Wed, 19 Aug 2026 10:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bMqXAres";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87FE10EDA7
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:44:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C03F41782;
 Wed, 19 Aug 2026 10:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4296E1F000E9;
 Wed, 19 Aug 2026 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787136263;
 bh=ey57vTEolivXAyrb04IJdMPT5EBqIxWjHkgX1fQRjcY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bMqXAres/GFMOupsum4EnVhV94y30XPluIBDR9KgA0WwzL0lRAc+aZVXlW0gBU5ax
 ScIzejDTtrWrR3FBAA8k5tfPdyyhA8pC3WpL0drA+GXjNFblLhRgweusdiN+6m82ea
 pZBpanhVlyRLZn+WAksa8tthy7wkR5V9PRG7F/NbvfYwsoSl+M0JYxR6UelB05s7rv
 aSfqWjebFDQA3ZwNiDDnlBCJ19NXGJu5irgEA8QDEnUPkxGDctiINs/9tX40qOG+uQ
 Ye8fnbYHlfgZZhXnGN9iW1cLXJCy+p7olKfDYj8pVh2FZo/lpuZLnUtUHUTHmCovUM
 gYDgYssVpdwQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
To: "Juergen Gross" <jgross@suse.com>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, cassel@kernel.org, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Michael
 Walle" <mwalle@kernel.org>, dri-devel@lists.freedesktop.org, dlemoal@kernel.org,
 "Pratyush
 Yadav" <pratyush@kernel.org>, "Richard Weinberger" <richard@nod.at>,
 linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260819102314.1499258-13-jgross@suse.com>
References: <20260819102314.1499258-1-jgross@suse.com>
 <20260819102314.1499258-13-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:44:21 +0000
Message-Id: <20260819104422.4296E1F000E9@smtp.kernel.org>
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

> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
>=20
> Convert rdmsrq() to an inline function returning the MSR value.
>=20
> The users have been converted using the following semantic patch:
>=20
>   // Options: --include-headers
>=20
>   virtual patch
>   virtual report
>=20
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val =3D rdmsrq(msr)
>   )
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819102314.1499=
258-1-jgross@suse.com?part=3D12

