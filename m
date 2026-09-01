Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6E9C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76AE10EA29;
	Tue,  1 Sep 2026 08:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ji8DgA39";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D7410EA29;
 Tue,  1 Sep 2026 08:59:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6862E407FE;
 Tue,  1 Sep 2026 08:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D681F000E9;
 Tue,  1 Sep 2026 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253194;
 bh=I4tVjKFRMCMBEBYtZ/jvpvYXOEsbsYRbHOBLaaKAGe4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ji8DgA394Ucs/DIGdUZvv+n72muWpoqGsh5/E3KwLC2BwopSMEKjDkoZ6/keUiJbk
 ejJGVXlbeSrcUilODOlkpuMRCqeuNR8JM0Xkiy3IDpVCsH4kmRrh9v4IY+9NRMwL/Q
 hlFxEfKaMBeFZwq6oh9qdzOAMiaECP3vNfBxWi61NXMz1UYI6em/b7dxl//4oZAfgf
 O1y/UFAt6WrPOb2xg8V/CjHcsz5PtPcjFqBSh2bdmTPuMj6lmGg9ZyarQoJBnZQ0cg
 h9VOhtMw4kyjex0MhMtmu2bYQYXZTWK93ZstVzxI1L0spDrSHjUO3GbfAl4XQY4GHp
 FP32OZZU9rsnw==
From: Danilo Krummrich <dakr@kernel.org>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind
 error-path bugs
Date: Tue,  1 Sep 2026 10:59:43 +0200
Message-ID: <20260901085943.4360-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
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

On Tue, 11 Aug 2026 16:46:27 +0800, Zhenhao Wan wrote:
> [PATCH v2 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind error-path bugs

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/3] drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      commit: 412a6ceb56d5
[2/3] drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      commit: ccf930812f23
[3/3] drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE
      commit: 38a62306c426

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for Linus's tree and should land in the next -rc
release.
