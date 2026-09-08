Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF8EC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A31110E177;
	Tue,  8 Sep 2026 20:24:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K8dE784E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD1510E177
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:24:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6548B601F9;
 Tue,  8 Sep 2026 20:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DE81F00AC4;
 Tue,  8 Sep 2026 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788899083;
 bh=zCUwPL2YAtqeA5bpsElIHpazJ3kO727+A7o8s71Gg4Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K8dE784ETtgxXvs3DyUYH8sXrEex5IBb1Rmh0iAYxtKAr7XtRcAT0BvKqpRPa3CeS
 hUv51alwzCFtmnJGrvnqNO/OBR+Oy7xPN72lJ8F2MHSsd/Imq9Z65zFckt4xNsEtze
 qaW6mpkwCYAAeOH4lkF/I/3jOb1IdB/iLP6MfFjqVpKjggvjrAHx5oEKp6UIIAXpvZ
 /grKrB/HqXyNF/Z33YSKoqjujIbJiL0rtgzuImwZOHz6TnMeVXVbhW5SNJUQqL9xam
 0AnSvYIhjo6Gxte5iJCr09YSJZ3Ua317IMZkpLnGBj3+hKoP+RmKUQZB3/PXpaeeCH
 ZfxCfFqkU0S7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/39] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, selinux@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, bpf@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-5-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-5-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:24:42 +0000
Message-Id: <20260908202442.77DE81F00AC4@smtp.kernel.org>
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

> There's no reason to export the symbols for these functions which are only
> called from internal mm logic, additionally there's no reason for them to
> be declared in mm.h.
>=20
> This patch therefore removes the exports and moves the declarations to
> mm/internal.h.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D5

