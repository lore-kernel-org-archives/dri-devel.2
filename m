Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C94CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 23:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A2A10E13D;
	Mon, 18 May 2026 23:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ITZXHGHa";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F5C10E13D
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lRx5kbohWye5VuObo0S+mUmP9SutsPzV+ip02W8EkuU=; b=ITZXHGHaVgyShRkO8/Zd2VzfeF
 Iz/mjCujhlArfJGi4a3ZjnJYBgWpiqvR2z61g9bqw9dJyqXcY3NtGHpFa+PfZs7JK4rfvrM5FOwRB
 wpC4G7jr0NOnv6ntEJxzED3027P4WijGbAXjdl9D/DroqC30n39vwP5I2w8oxBiSiK3Sn/GWqONoA
 e9xqo9j9gyM0kDRdIaLF5Hv0vca2qTWF+j2l4uxCoExvQmJJH1PcyKRiMVwh7Gze6hfAhebvH+7By
 P9D7DsBTg0n2IonlNJLAxkzIPEHexxrmS8CDYoFLuo9fKGpsrjIUsyMz6rS6r46AMmtz6FP5WGlMM
 LbvZB6jA==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wP70h-002ro2-Bt; Tue, 19 May 2026 01:04:31 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] drm/v3d: Fix CPU job teardown bugs
Date: Mon, 18 May 2026 20:02:55 -0300
Message-ID: <177914536557.3484982.5704242734975270847.b4-ty@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
References: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
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


On Fri, 15 May 2026 12:07:13 -0300, Maíra Canal wrote:
> This series addresses two independent teardown bugs in V3D's CPU job
> submission path:
> 
>  - PATCH 1: A use-after-free on the ioctl's fail label, where the timestamp
>    and performance query arrays are freed through cpu_job after
>    v3d_job_cleanup() has already released the job. It consolidates the CPU
>    job teardown into the job's kref destructor so a single code path covers
>    both the scheduler .free_job and ioctl error paths.
> 
> [...]

Added the `Cc: stable@vger.kernel.org` tag to the patches and applied to
drm-misc-fixes.

[1/2] drm/v3d: Fix use-after-free of CPU job query arrays on error path
      commit: b0fe80c0b9250b35e2211bf3117e7aca814a21b0
[2/2] drm/v3d: Release indirect CSD GEM reference on CPU job free
      commit: 6eb6e5acafa46854d4363e6c34981289995f3ace

Best regards,
- Maíra
