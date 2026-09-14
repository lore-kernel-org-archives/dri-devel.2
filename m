Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC924C88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2097610EF22;
	Mon, 14 Sep 2026 14:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ARwyPajt";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DBC10EF22
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=seNbymoRcba+dBQzFLFgF5NtopXFYp7K8Fp+GLTKr0Y=; b=ARwyPajtVtGQQ+hX31nzrDmTvM
 1Du3AzxeECCc00B6AVmZcEOKNe23YcyZCLHJT14cDp5/ECsO+Ny0VwvT+f0mMjoloBvhmm6Pv+mkh
 nHxs2y/MXOGZOG06oDznb7j7gdBi329bsgma/SptRzXia4LwH3JP0/6nr4AmNRi7KvB/zzqgnzJxs
 hteTFyE+dIEr/cByN9t74KJHnZ63rRLOVhnQkqInm5q2pgTUzEgQtBGgAaGSPfXO2f3Cna3XKbF+8
 ubeSNWkLrxX5BNBtnAiZa+fXMAtK/scTC7wcf29wzpAafxXb8OaGUoPaa9mg970H2WuG/X5ZxIRj5
 m4SVlwGg==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x67z1-001wqw-GL; Mon, 14 Sep 2026 16:48:35 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/v3d: Fix system freezes by serializing the GPU
 reset
Date: Mon, 14 Sep 2026 11:47:35 -0300
Message-ID: <178939723879.68746.4885647874791336675.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
References: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 28 Jul 2026 23:09:21 -0300, Maíra Canal wrote:
> V3D exposes several independent hardware queues, but it only has a single,
> global reset. Therefore, when a job times out in one queue, the timeout
> handler has to stop, reset and restart the schedulers of every other queue
> as well. As each scheduler queues its timeout work on the system workqueue,
> those handlers run concurrently and can interfere with each other.
> 
> This can be reproduced on a Raspberry Pi 4 or 5 by running glmark2-wayland,
> which keeps the CL queues busy, while a second application triggers a GPU
> reset in the CSD queue every 0.5 seconds. The failure is non-deterministic,
> but it usually shows up after a dozen resets: the DRM scheduler warns about
> a credit imbalance in one of the CL queues,
> 
> [...]

Applied, thanks!

[2/2] drm/v3d: Remove the now-redundant reset lock
      commit: bfae5a8ac53e6d38e882d856000596f1da7df306

Best regards,
- Maíra
