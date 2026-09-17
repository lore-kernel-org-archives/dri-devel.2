Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06786C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3443C10F023;
	Thu, 17 Sep 2026 17:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZU33jod7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF4C10F023
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:32:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B97E60202;
 Thu, 17 Sep 2026 17:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0581F000FF;
 Thu, 17 Sep 2026 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666371;
 bh=L574wte6Fs7YmhZhJzXet7+9C9bbi5o9V+zzEZMvGG0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZU33jod7WpMCH6FHlvETK1W/AvHSl40aIKDxWVAmLabCx9shVa7lGd8tfgv09/VVO
 kG32Y0C2r/w+1Oz2rXRtEQrTPQOh5ijgdTXdoIn9/3maqBS42804IvymeSg7VfA7WM
 b/JoC7yjT7ahTNFlQRYlX7reQYrRKj+Sn3QDE7c6F2HPW0UYsNb7Ei2uk+waVZ6CsK
 iyd+hh+ZK/2QokIt++8JyIx1i2UTb8kQByAqViAC66iI59KnLGB/DXZkPK5hpQIbh2
 wbJKXM+8wUeQ4epRixve0ahhkiVl0T+hXEq8Ebkv0bwRCdm553Nfpx1+YAEMdwy4yK
 OmASN2Rq+WqNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/40] docs: filesystems: update mmap_prepare docs
 for discontig kernel pgs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 selinux@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-trace-kernel@vger.kernel.org,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
 "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, kvmarm@lists.linux.dev, linux-rdma@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-9-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-9-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:32:49 +0000
Message-Id: <20260917173250.6C0581F000FF@smtp.kernel.org>
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

> Describe the newly introduced discontiguous kernel page mapping mechanism,
> detailing how to use it sensibly and how the API looks.
>=20
> Explicitly detail the various discontiguous actions available and how to
> use them.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D9

