Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF211C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BCB10F4F4;
	Thu,  3 Sep 2026 10:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hvl8VNPz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEEC10F4F1;
 Thu,  3 Sep 2026 10:35:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E8A560211;
 Thu,  3 Sep 2026 10:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06971F00A3D;
 Thu,  3 Sep 2026 10:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788431722;
 bh=oupvZIQLRj2F8pwTGPPDeOgOmjETvsOL7Smn8U24vK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hvl8VNPzvhooruZwipX6WzNUkFFm/74nfalux8huERIDwn31oavj0fOD2RPJntxJc
 gDipr9gn95yhIILgLp8MYQM1fB0jKwMWAl8q/iu1ab+IhFJELc2TLY6qEw6iiKODGo
 c6uLwt+wogqGTOWkxp0nUde21vklI29KvilJPZh90knTaHzTEqQtUJP42pddlwVqLD
 KnSVvMeYHqRWbKaad4sV7+AJ4ekNqd1PKAQfrkw3u21et7bDNnyG2goL/ehRv0nc+D
 k8wTfNJ5VCmwlSN7WilzGLnj716b5S5WBPosLIqBOpa1sAiFrfsQBUVJ9BzBB7FtAO
 Y3vURHxFO5Sjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] mm: rename pointers to software PTE values as
 ptentp
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 damon@lists.linux.dev, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903103002.1091859-3-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-3-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:35:21 +0000
Message-Id: <20260903103521.A06971F00A3D@smtp.kernel.org>
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

> Some interfaces use pte_t * for a software PTE value rather than for an
> entry stored in a PTE table. These pointers must remain pte_t * when
> pointers to PTE table storage are converted to hw_pte_t *.
>=20
> Rename these parameters in the install_pte callback,
> write_protect_page(), and guard_install_set_pte() to ptentp. The later
> Coccinelle conversion skips pointers named ptentp, allowing it to convert
> the remaining PTE table pointers without changing these interfaces.
>=20
> Some functions already use ptentp for such pointers, including:
> - madvise_folio_pte_batch()
> - folio_pte_batch_flags()
> No need to rename them.
>=20
> This patch only renames parameters and makes no functional change.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D2

