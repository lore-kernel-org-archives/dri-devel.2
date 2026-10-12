Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911B1CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CD010F0C5;
	Mon, 12 Oct 2026 13:11:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C19010F0EE
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:11:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C4A0602D1;
 Mon, 12 Oct 2026 13:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F3F1F0089B;
 Mon, 12 Oct 2026 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810662;
 bh=OurCOLfCiEt+Kpm0SrAHWEr04uzDPUF7IJOz8rahb6Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oEY/At3T0sliAaJFb+UeYNCwV108mu5w7z/CL0///bw4lIcBCPQZkTYkRJeNvQTNt
 hbFQkfHSFxg73S4aGbnmqvPGPA+m4cYXzZ1hKIwQQdo9D+RW0NbT7YYRMMexIulyWs
 v7eH1667tMVWt9H+Ef2Y3vWe6cfv8woex1tNq1D5dHsBDudSQVUqWlGjhjVlDDkNxx
 hyGzrL0cGU+BQBmaGI8OAhaCK9RQxFFobSruAAbDtrN57HoqH94CNitzL/jBysBKg5
 UHwMeirLLTdz3ti1MzUip2HEm9wdrGqOEy7U6o2Tu0S1k0de7XPlacvdbDQWlRZFDY
 /HyAxjl9LXA9w==
Message-ID: <sashiko-outbox-168145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/18] PCI/P2PDMA: Document the TLP attribute
 assumptions
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-1-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-1-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:11:02 +0000
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

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> P2PDMA selects a mapping without receiving the Request's ordering or
> Address Type attributes. Its ACS handles only strictly ordered Requests
> carrying an Untranslated address.
>=20
> Document that the result is not defined for Relaxed Ordering or
> ATS-translated Requests because those TLP attributes can select different
> routes through the fabric.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D1

