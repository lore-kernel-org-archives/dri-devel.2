Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FCFCD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D571310EBAE;
	Wed, 10 Jun 2026 19:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iUloCyA/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6362510EBAE
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 19:03:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85BA6601DC;
 Wed, 10 Jun 2026 19:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FB91F00893;
 Wed, 10 Jun 2026 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781118197;
 bh=WvwQbLxB0UHHe8ux2/5GenrCNn5hMTEqQMNf4b3IkF4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iUloCyA/kbcdbXLVznfNG1X8sHqsKTMYdTOaK7yuObQft4WQ9yLhu7fUKmwmoTuks
 FgwgsEgwBHlj+cs8dtauTTS+IxgQrTO69eLRfLplGmOGOXAMYVLgYeqxn+ddDRwCj/
 DmJNQK0/4WIbKW+KMeDSFbu48JYzCP5xmSRlG48WQ1CchSODjFHmK9CiVDcgV+APNc
 8JjMtJZI/EsvhVMK7kVBazxirHkGmDXnTDuXuYjaISaVlAbFnkC6je4v6DSwgQVoIt
 2UmEytTm02YWEMcDNran2C4DoD+Dy54Th1jTdt0vnXdPiD1PGms/+mFrg2GFyPp/Jb
 ADvX1Do0jBWGA==
From: Danilo Krummrich <dakr@kernel.org>
To: Antonin Malzieu Ridolfi <dev@nanonej.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: Move gsp register definition into
 gsp module
Date: Wed, 10 Jun 2026 21:03:11 +0200
Message-ID: <20260610190311.52106-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140949.152575-1-dev@nanonej.com>
References: <20260607140949.152575-1-dev@nanonej.com>
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

On Sun, 07 Jun 2026 14:10:31 +0000, Antonin Malzieu Ridolfi wrote:
> [PATCH v2] gpu: nova-core: gsp: Move gsp register definition into gsp module

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova-core: gsp: Move gsp register definition into gsp module
      commit: 3e4bac7b8ca7

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
