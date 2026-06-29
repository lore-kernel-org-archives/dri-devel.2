Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D3BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD8F10E021;
	Mon, 29 Jun 2026 06:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dLOAGF/z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589A610E021
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:24:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E61A60054;
 Mon, 29 Jun 2026 06:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFEA1F000E9;
 Mon, 29 Jun 2026 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782714293;
 bh=aM/fEHBwOE0lymo4oDwfQufex/DqafXe9rPrJOipAI0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dLOAGF/zWXVpvbByDN51dBCN04lFjULPGmO1TrJJXfr9mpg5POkpw+J9O6JKN26IL
 bOhRyDSpSrJCTjQdC1DcGXd134nSy7sZIy+ylcvZ1LLOsFZRYvOP3d/ETRe6//8CWB
 hZbMjtCUY551GbR+jYfFTBdHRl5bk7uRPyxGon5mffPtfcCQ3G41mBcpWlicljyMIR
 QzhNPdP+DAabiI6i6dN1hYKD27A1iCv1Wr/uuNjMKlZ/JOUXBnRkjNFmTPvaL+F7fa
 i4tVWI+nsZA719wCMn3m9W8SK6A7IQTMrHeu4CJcqN9h9MQGvkZEqCnwomB0AyuR41
 ec1SdnX1yqfCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/32] treewide: convert rdmsrq() from a macro to an
 inline function
To: "Juergen Gross" <jgross@suse.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org,
 linux-hwmon@vger.kernel.org, cassel@kernel.org,
 linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260629060526.3638272-32-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-32-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:24:49 +0000
Message-Id: <20260629062452.8DFEA1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629060526.3638=
272-1-jgross@suse.com?part=3D31

