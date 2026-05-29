Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB84CD5BD1
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 00:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8887510F74A;
	Fri, 29 May 2026 00:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m5fD351W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056FF10F74A
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 00:21:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56F6F60213;
 Fri, 29 May 2026 00:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AF31F000E9;
 Fri, 29 May 2026 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780014078;
 bh=Z0qTRr3KqRK1NzIfE8N5z7PK58O6VcU5Mn53C8VSlY4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m5fD351W6dJL8sRlP3QvsNoqMbm7+GL1uy1pq5rcLLpJ4EhlfF3HingZ4IFrW4nMU
 6fQH8yd78EkVlGNxqxFf/S+06+wWY3frQzyx3F1ZuXf6MJYj9W84kNgLUgq6Gi2vJx
 G809zIp3ifQT+Uq1T2lLPh5rCLLF1/PIOy1m0pXqJEQYgeTXX74Aj/4rv665m3ghdK
 rx+ZCJ6xErTHjS62M65nWioEOsJIkjnB7IVfNVc81eW8Ur5Tm0LJpnLlXbJVkdN+NY
 XnlIg5YTJENkFpW5GhXZuk+F5HltfwED4WcBsmBwCB7Z4UYhRemL72G2iIRrcNK7Qe
 PHaGopNC7q1OQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, aliceryhl@google.com, jhubbard@nvidia.com,
 ecourtney@nvidia.com, ttabi@nvidia.com, joelagnelf@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] gpu: nova: adopt driver lifetime infrastructure
Date: Fri, 29 May 2026 02:21:13 +0200
Message-ID: <20260529002113.2305989-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525225838.276108-1-dakr@kernel.org>
References: <20260525225838.276108-1-dakr@kernel.org>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 26 May 2026 00:58:28 +0200, Danilo Krummrich wrote:
> [PATCH 0/5] gpu: nova: adopt driver lifetime infrastructure

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/5] gpu: nova-core: use lifetime for Bar
      commit: 88b70f5a05af
[2/5] gpu: nova-core: unregister sysmem flush page from Drop
      commit: d8143c9e988b
[3/5] gpu: nova-core: replace ARef<Device> with &'bound Device in SysmemFlush
      commit: 17b6544ec141
[4/5] gpu: nova-core: gsp: replace ARef<Device> with &'a Device in sequencer
      commit: 859805f070bb
[5/5] gpu: nova: separate driver type from driver data
      commit: dc395c2831b5

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
