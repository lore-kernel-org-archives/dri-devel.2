Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E454FF8873
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE6D10F18B;
	Wed, 29 Apr 2026 21:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q3YaWcxd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B675F10F18B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 21:50:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DB7506015B;
 Wed, 29 Apr 2026 21:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD099C19425;
 Wed, 29 Apr 2026 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777499415;
 bh=ODlGdXyDhiXyEVfT2TgZg3gVDBJjq2N48Ef268SDmWA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q3YaWcxdyYTi0RIwOgWlnM0awzjG/bALbM1i0CWv8QthY1MbwnIjAROiJ7HzdYiW0
 DEeV6FUDtiK1V6aXS69UEoTb5jBSOWxqWb40X56xrU2OjV8SBvxbHNwleUy9NYEWSp
 R2cKbYoit/vhnXDSDeB/uJL9DOu3Lq3Pv5rZoRUectFuuMH/1bonlYybCwVtWxyh99
 +e7CQ2M3vq6/qDqtCPG6A/BeSS2VM/kUZSFRaokrXCMlZTOWWQQv1RQhzrpdGrO/lt
 T1Tamf6MaAEtXMc8Gk7fX3BssDpQl2R///qMm31h4Tv/exwT+9afa+j/qt0KMY9SlK
 Y7qmMDyQGGsfg==
From: Danilo Krummrich <dakr@kernel.org>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpu: nova: require little endian
Date: Wed, 29 Apr 2026 23:50:10 +0200
Message-ID: <20260429215010.3181390-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
References: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
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

On Tue, 07 Apr 2026 12:59:50 +0900, Eliot Courtney wrote:
> [PATCH v2] gpu: nova: require little endian

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova: require little endian
      commit: d39e22cf87b6

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
