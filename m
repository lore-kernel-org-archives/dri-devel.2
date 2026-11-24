Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A3606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=enKs106V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFC510F9E9;
	Wed, 25 Nov 2026 08:41:21 +0000 (UTC)
X-Greylist: delayed 560 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 13:37:07 UTC
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490EB10E594;
 Tue, 24 Nov 2026 13:37:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B12081D8145A; Tue, 24 Nov 2026 14:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
 t=1795526863; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xGe8Byqtdet6m9b6JcFfd7IFIJu9dIrTGmJqkbX0I3I=;
 b=enKs106VKN6gDLYipo/qpiLQktAD0vnahiwO8I1bgRbdHdVTvzDV54vxoypjXHPMbx7tYD
 BdwQGGEbztjT7N6gtgbbijg0V26+iOGC04h9iORn3A3FlLfBVPg8cBAWx2xJd+hpi1NwUl
 wD9fyLH7NSRhpnR8XVY0hQPoTft1N+U2HuQnTRcaxUW9x/+qdZVcZvPRkL6ZfqsMfk9pjD
 sIT/zjIDj8M/27X5HfdcUQ9RGfKFnXp5Udwirs1oDBN0YxNheIDCQ2zFEO01RiVDLJb4gF
 6uynGgmIawPOQKfMmGmU4/fDQMpgilUaNJh4dqUNHYCPG6cPHwg6KCOub3zgMQ==
From: Michael Auer <mick@yoxcu.de>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Haitao Xu <haitao.xu@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/8] drm/msm: Attach a driver to GMU
Date: Tue, 24 Nov 2026 14:27:29 +0100
Message-ID: <20261124132729.1763111-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Akhil,

I tested v2 on a OnePlus 6 (SDM845, A630) on a 7.1-rc1 based kernel.

The series does not apply there, because it builds on the
separate_gpu_kms auto mode from next. I dropped 4/8 and used
msm_gpu_no_components() in place of msm_separate_gpu_kms_components()
in 1/8, 5/8, 6/8 and 8/8. In 6/8 I moved of_node_put(node) in
a6xx_gpu_init() after the gmu_is_wrapper check, as node is not
__free() there.

Without the series this phone needs fw_devlink.sync_state=timeout:
nothing binds to the GMU, so gcc and gpucc never get sync_state and
their GDSCs stay on. With the series and without that option:

- the GMU binds to adreno_gmu, the gcc and gpucc links to it are
  active, and both reach state_synced without "Timed out. Forcing
  sync_state()"
- the GDSCs end up in the same state as with the timeout (the
  hlos1_vote_*_tbu GDSCs and ufs_card_gdsc off, gpu_cx and gpu_gx off
  when idle)
- the UI renders under KWin, GPU devfreq changes frequency, and there
  were no GMU or HFI errors over 332 suspend/resume cycles
- in a 7 hour suspend test the SoC was in CX collapse for 87 % of the
  suspended time, the same as with the timeout option

Tested-by: Michael Auer <mick@yoxcu.de> # sdm845-oneplus-enchilada

Michael
