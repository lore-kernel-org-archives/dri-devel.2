Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DC2CD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACBE10E030;
	Sun, 21 Jun 2026 13:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I5CfqH6g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995DA10E030;
 Sun, 21 Jun 2026 13:13:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5CC3942DCD;
 Sun, 21 Jun 2026 13:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40C91F000E9;
 Sun, 21 Jun 2026 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782047601;
 bh=dzuTGsXHWnUFFlf4w6v0xDSvKV+lTAJBsA0LpxaiREM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I5CfqH6gPdXXucwP6yOGU4artKH2QLhVG0qGr/JwlXZc4DSn0XQajzUomOB9brj6m
 UgrCst2nHkoNdmOhbATdqCjhaIKUTJPZ/isy2ymJRAvmujj1jIeXp5y1k4A+z/ikY+
 ppaFj71DqvYSWPBDpUET/WOi68CjCvtSGOabTH+ivznSH4hNmZt2dM4oNsuip23zVm
 eSs6KJT1cv9JHcRZ3o07pJDk0sSkGA6r8r46MNZcYQBexvsUuBgio1Q5DCifTBc1e3
 zUJn9sSjHQnLZ/wz3tyr04dd0yjom5s+foVfZj8FZ9XFmyMw9qrBEVMsr5XW4Db6RR
 DV4CjQn8QyV5g==
From: Danilo Krummrich <dakr@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/acr: fix missing nvkm_done() in error path of
 nvkm_acr_oneinit()
Date: Sun, 21 Jun 2026 15:13:10 +0200
Message-ID: <20260621131310.5004-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606155606.77593-1-vulab@iscas.ac.cn>
References: <20260606155606.77593-1-vulab@iscas.ac.cn>
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

On Sat,  6 Jun 2026 15:56:06 +0000, Wentao Liang wrote:
> [PATCH] drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()
      commit: c3027973f692

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
