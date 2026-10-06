Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634C8CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 22:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA0810E061;
	Tue,  6 Oct 2026 22:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z/j1WNC1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E7210E061
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 22:19:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DB7D600C8;
 Tue,  6 Oct 2026 22:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA841F0089B;
 Tue,  6 Oct 2026 22:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791325149;
 bh=Dsw+Om99HBmxjd0KI/89CLMDxJNPm3Znm2nWLVCGV60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z/j1WNC1IyFZkN/FIWqLEnFtpIxtrIOb3ev1tnmwP9R+jHTMFQCahDb5BB6YSmoc0
 S2/1VF69m2htIe+Zx1OIE+W1B6SIcjB4UJGZ8HL9iaWkCp+4VCEiGFzUga3O0N/UBf
 Hw3g51IbZ9fSYAWMRn9b9NmaWYn8AV7nnTJaiInB7W3Xk5Tz7cpcBI/43/gbKpbLsv
 lgAbWBrG+abnb+yUIX+OWNYaEH1Y05DXa54+iyaXdxFhmHSzxIDeiC9vcgcC3UONFN
 CFDGwhxn5+AxLmJqGVRYlWMI63H2U4WzTyLfLbX8Q67qmmhtgbFoQuGMrlJai3nui9
 OZ3oc0sKA/mEw==
From: Danilo Krummrich <dakr@kernel.org>
To: Thorsten Blum <blum@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eliot Courtney <ecourtney@nvidia.com>,
 Gary Guo <gary@garyguo.net>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: nova-core: gsp: use KVVec::zeroed() for payload
 buffers
Date: Wed,  7 Oct 2026 00:19:02 +0200
Message-ID: <20261006221902.41227-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006115311.92873-3-blum@kernel.org>
References: <20261006115311.92873-3-blum@kernel.org>
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

On Tue,  6 Oct 2026 13:53:06 +0200, Thorsten Blum wrote:
> [PATCH] gpu: nova-core: gsp: use KVVec::zeroed() for payload buffers

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova-core: gsp: use KVVec::zeroed() for payload buffers
      commit: 6148fb2fc4d3

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
