Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894A7CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA4A10FB27;
	Thu,  8 Oct 2026 19:30:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UZN4l6sn";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C854110FB27
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=3XFkn3NBUR6YE2BST10jSbVhsx/r84jeVgiKXYbvzaM=; b=UZN4l6snwxd3BZaebvtx99VRbS
 sWdaXm8bP8SOfjd9b5z9muGIkl81570uh+6IWuuSPe1gL3QgZR1QlQRbT1+RwmPT8ZgVviYNg57ps
 Vx7bPd2cKOvrxmojBHt2TamRUdbQUBlhJFtKk3t+Eya5xoVo6oqudDMcBH1n+MH6q8289BT3c2vQa
 Jf69KfX640bwXM1iUQZ3YGrxQHh+hEUeiee6mVOBgtbYhFARthUVrMVgcHFxgj5WYxGkIGSQjCgG5
 XltpsSHRbaNbpxpiislhPwJA+6/7bHGX+EJSNsevjue5j8+92WNcA2lDajDqxl7jOaVUF0wXo7Ic9
 1VC+Jd3g==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xEtp5-00EcnV-FB; Thu, 08 Oct 2026 21:30:36 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] drm/vc4: Fix binner slot allocation failing on an idle GPU
Date: Thu,  8 Oct 2026 16:29:48 -0300
Message-ID: <179148775854.3140809.16570032123389144341.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930182204.1877361-1-mcanal@igalia.com>
References: <20260930182204.1877361-1-mcanal@igalia.com>
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


On Wed, 30 Sep 2026 15:20:44 -0300, Maíra Canal wrote:
> A job's binner slots are returned to bin_alloc_used by vc4_complete_exec(),
> which runs from the job_done workqueue, but the seqno
> vc4_v3d_get_bin_slot() waits on is incremented earlier, in the function
> vc4_irq_finish_render_job(). Therefore, a waiter can wake, retry, and still
> find the pool full because the worker has not run. By then, the job might
> have left the render_job_list, so no seqno remains to wait on and the
> allocation fails returning -ENOMEM.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Fix binner slot allocation failing on an idle GPU
      commit: cca01232d94adcb10f7c8c5bb8ce072b045fcb58

Best regards,
- Maíra
