Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DEDCD6E7C
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7214F11A2DE;
	Thu,  4 Jun 2026 20:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S9G/XZZS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CDA11A2DE
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:20:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C28D40659
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E191F00893;
 Thu,  4 Jun 2026 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604417;
 bh=bGxZFbUliXuOot/Y2cFjMm1EYrL2vkwCUoNyO2rpOtE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S9G/XZZSwvyXiTkoSdzWuZ9Sdvv4nqWcGbt+WlUzCUMZaLAoA0LADqP7zb78H30W/
 WZ/LJOngXs0VhrP+fAxa9IMAWX/eUArsxHO/Lxuaw4FBSHHr2K72cxaN1vRQW+HwjC
 HZRFSgtmkU1VheaWQ8P4m+lMY2Kp5qmE5iRsY0/823F7KzdhcrVAT2v3Km6dp2O6aM
 rMWLE3VPvV7sx7I0h/GATXDmGawdT1HYpj7aouLqZ1IwbbUFskuE0/KbN9oppZjU6X
 DhMJQ+iGs+aM3NbTNjYpWqUpvRGAkp09aR38rh8a3ormdvb/P/NXOyzooSaFjbp9yc
 QLQ0LxOSBGOQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/10] rust: aref: update formatting of use statements
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:20:16 +0000
Message-Id: <20260604202017.33E191F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in the commit message: 'if' instead of 'of'.
--

commit 903f28665e4d9847cce4458bdb8092b6304d076a
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: aref: update formatting of use statements

This commit updates the formatting of the use statements in the aref.rs
module. It expands a single-line use statement into a multi-line format
to prepare for upcoming changes.

> Update formatting if use statements in preparation for next commit.

[Severity: Low]
This isn't a bug, but there is a typo in this sentence ("if" instead of
"of").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D8
