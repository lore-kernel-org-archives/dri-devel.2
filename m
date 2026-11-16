Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50F606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=kshO+vjx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA62A10E74C;
	Mon, 16 Nov 2026 14:12:01 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12A110E74C;
 Mon, 16 Nov 2026 14:11:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSqYN2qY7zKnC6;
 Mon, 16 Nov 2026 15:11:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1794838312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27EBgBrbFFlASVSyVER9wm/IKSXbTEK4pD7f5ZtX4VY=;
 b=kshO+vjxICe+BZY4EzzCjo60xoca8VuT/dDDPzocZyijX1b+/XA9BYiqZHVoF1wEb3vSsA
 Jt+80MQjjeqasDBJD6cK0CkuC3bhcTZUmvVKogadGgpsHFYNcIPOswQJ4AofpQSweWRo+N
 UVXBCzTHP+PhS6b3TWaOvd9tSuTCCzYU4BQwXZLMmdKj+BSo2IRNWvjtkcYd0kLGR9TUwD
 aIfx1SDwoX5wBjLxw7v4/2+JxC6r3yntM+bEQR8x5f0CtkIZ8mlTvWyQ9hucG/LlThKxfY
 kAJiWh0FspnMoJksItWDRJlm07jATuiCROvcy6P8DIfop0OLt3Nmgqx04d1yKQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Mon, 16 Nov 2026 14:11:50 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <335815674.648716.1794838310991@app.mailbox.org>
In-Reply-To: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
Subject: Re: [PATCH v2 0/5] drm/amd/display: Commit panel_power_savings
 writes from the kernel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jSqYN2qY7zKnC6
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v3 is out: https://lore.kernel.org/r/20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es

It adds a patch 2. Without the forced modeset, a commit that only
changes the ABM level on a CRTC with VRR active carried only the primary
plane, and DC dropped an active overlay until the next flip. Sashiko
reported it on v2 and I reproduced it on my laptop. Patch 2 adds the
CRTC's planes when the level changes, and the overlay stays with it

Patch 3 now credits David Weber, who sent the same change in August,
and patch 5 says a compositor commit waits for the write instead of
failing with -EBUSY, as Chenyu pointed out

Chenyu, if this week's promotion run hasn't started yet, could you take
v3 instead of v2? "Leave self-refresh before an ABM level update" stays
at v2

Hugo
