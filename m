Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F32CFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE3F10E87B;
	Tue, 28 Apr 2026 10:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fl9aE3Mp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C751810E321;
 Tue, 28 Apr 2026 10:59:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 25CF361141;
 Tue, 28 Apr 2026 10:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F79C2BCAF;
 Tue, 28 Apr 2026 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777373972;
 bh=nhPS0LRCwd7c4oERcoYYS0MODmHmudGcky7g8cDOQVg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fl9aE3Mp2ep6jjbtGG6jJgbQ1s2YfgZMYA/GqcVi2XFx5nZ0F1fCSRpH72yjps6/r
 V9OTrQ7TEsgL1Tpn37LI1ulHFnEzPw6BTpuL9bKOCrAtbcBETAuZtP/eEyhlYug+ll
 EoVL1OrtkeMC+NeJeF3fAVV6OLhPq11xAdvqikqUoy1E1bNkgG3Se4Aiijtion+XjI
 LGWLruuibGgc7vmRCZsx7DD1RWeqnIbvUK8XS4QxTdYyK3sJcakWv9QQRydJg3HrkB
 Ulap/o9mfx8KtsZbuU9HKZRbQ9JgHTsSCDuFUIwbmryarOIui22yyGxPLNgFoGVbgG
 YumD1RPPEyEvw==
From: Danilo Krummrich <dakr@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 0/2] replaced old wq name,
 added WQ_PERCPU to alloc_workqueue
Date: Tue, 28 Apr 2026 12:59:16 +0200
Message-ID: <20260428105916.6108-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251031102020.95349-1-marco.crivellari@suse.com>
References: <20251031102020.95349-1-marco.crivellari@suse.com>
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

On Fri, 31 Oct 2025 11:20:18 +0100, Marco Crivellari wrote:
> [PATCH 0/2] replaced old wq name, added WQ_PERCPU to alloc_workqueue

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/2] drm/nouveau: replace use of system_unbound_wq with system_dfl_wq
      commit: ef1b53284175
[2/2] drm/nouveau: WQ_PERCPU added to alloc_workqueue users
      commit: c82a16b0caac

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
