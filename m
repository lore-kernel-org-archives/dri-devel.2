Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF150606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Rdbzdw8R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA8AE10E483;
	Thu, 22 Oct 2026 18:24:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881F410E055
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=CPMofAB3DMKTZBqS4VtOwyIPfS7fJHErlr20h+BdMW0=; b=Rdbzdw8ROZFJQS2vrXxkODTJFZ
 QlA/EUxfh0NDOvj0R/2zJVLVPSrjXtW+1WfFQf06c2zfPtmtROI0Pi/kjtVnxeq4tQf/IjT0DrqHQ
 oRVgv0gytXcoKT4ahbh8dPHl6o/VD2K7jzagmLc8IhEEHuH+cG9PfUAeLpeCCOLIO0euuSvxH5cVU
 pyy4EwfI/YZsDi+MST8xJ4ScfvXIH3Uvl0NFHDkdo/mBdFhvqLxhxgOuBpjg2F3iLAfIJS3hj40ej
 jRmsEQG2KsZDavrbbHJEhOWLMZY+CTZicpffNrvZdzx+mGnG4moYKuu5m+yqYUGuxktVSuDk/T5qn
 f37bSkCg==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJxSP-0073r2-Ck; Thu, 22 Oct 2026 20:24:05 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/11] drm/vc4: Split and shrink job_lock
Date: Thu, 22 Oct 2026 15:18:41 -0300
Message-ID: <179269311614.381034.2750168686210719855.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sun, 04 Oct 2026 12:42:00 -0300, Maíra Canal wrote:
> vc4->job_lock is a device-wide spinlock taken by the V3D interrupt handler,
> so everything under it runs with interrupts disabled. It currently
> protects several unrelated things: job queues, the binner slot pool, the
> saved hang state, the active perfmon, the attachment of the job fence to
> every BO, and more.
> 
> This series aims to (1) split vc4->job_lock into multiple independent locks
> and (2) shrinks its critical sections when possible.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[01/11] drm/vc4: Publish the output fence outside of job_lock
        commit: 9ee552a42c3905b4547e83173d46413137ec329a
[02/11] drm/vc4: Drop the BO reservations outside of job_lock
        commit: 8ef66514d7b993c9fb96a5886f001e3556610c1c

I'll apply the rest of the patches to drm-misc-next after the merge window.

Best regards,
- Maíra
