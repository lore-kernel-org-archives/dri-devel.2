Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43097606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+eIapUd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A074510EE32;
	Mon, 16 Nov 2026 10:16:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5CD10EE1A;
 Mon, 16 Nov 2026 10:16:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77D78626BD;
 Mon, 16 Nov 2026 10:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AA91F000C4;
 Mon, 16 Nov 2026 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794824161;
 bh=q4d263XXglI0iqpL8mpE7A6pZt/pDzsX4AunwdC2UEw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V+eIapUdbPOyQuRXEyb2TCgUjwso8Fj7arBAuXeX0Vxe4e2SbEGr2YSDg+ahcU7aT
 IhTga7Kzf9bKk2f1vHkMM+9+0Gn1U9Dr5vxyZvN+cMjO2QoCF58aLWrYQioFILxedM
 0FSrn+TFRzFI9Ctlx68zaLBDcgBc6MRmMp92j4zblNKGspBk9NIo4pFulJrrfMRD14
 SmZIW4OWKZYOA7ituF5ZgkYtsWvWXRXAqygSAgqqbZV9nRJ/5zlJ3RrULyH0zwaxFz
 4LOQXx1k3LU4zZLnVt7h+yH2BRCqW+OvloeTmSBdhbrWCz8gib7FkXj2YWAwgSO3l2
 w4Zd5Ci1oguPw==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, Maxime Ripard <mripard@kernel.org>
Cc: Daniel Stone <daniels@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@redhat.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>,
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, freedreno@lists.freedesktop.org,
 Oarora Etimis <oaroraetimis@gmail.com>
Subject: Re: (subset) [PATCH v10 0/9] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Mon, 16 Nov 2026 11:15:56 +0100
Message-ID: <179482414984.70626.579928766697794355.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
References: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 17:31:49 +0100, Maxime Ripard wrote:
> Userspace currently has no atomic way to bring a display pipeline back
> to a pristine state. A compositor that wants to start from a known
> baseline must explicitly set every property on every KMS object to its
> default value, which requires tracking which properties exist and what
> their defaults are. This is fragile and must be updated every time a
> new property is added to the kernel.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[1/9] drm/amd/display: Fix planes atomic_create_state implementation
      commit: 02d46912debff86b107519f9557557b3f9c13df4

Thanks!
Maxime
