Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D332606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=KyoFzbNz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C5B10EA1D;
	Mon, 16 Nov 2026 14:12:36 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEB310EA1D;
 Mon, 16 Nov 2026 14:12:30 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSqZ31zCRzKr5X;
 Mon, 16 Nov 2026 15:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1794838347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3Uqf0UNsQWDQhdWSNHEghbo7o7ohUgnt5OAY3jsZaA=;
 b=KyoFzbNz2+YHsUpFjZGZgJ7XBWd0OkU+Oxzb/lz+JsZF3avKlG3IjjUF4WGZb+s+iwuxS8
 r7IyPFfW6BfrRn/d3CVsPB3BGmxyejYn4JY9AFsG/rQn3Pj8NS9yXugrmgUKRMsjr4l64P
 nbZGuWnhcRBzQnJSGjNnq0rL1fP8Wc13m69wF4FG+LeVsmih6SxDfN1o8Ff3+povGzpopM
 7Usr9WYNh497yavk/ZSsOLyjDSnupFzi9vNd/XlIXkIuozeL0U2/mTz6b9wPlRB1atlbDm
 p/c2sUGxIu1tp0ghNSlBXAW7PQVw3ZenTboUrM+kxq8H9O1Hp+PzPaeX+GSD/g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Mon, 16 Nov 2026 14:12:25 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, shivamkalra98@zohomail.in,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Weber <weber.aulendorf@gmail.com>,
 Alex Hung <alex.hung@amd.com>
Message-ID: <1629832733.648780.1794838345723@app.mailbox.org>
In-Reply-To: <ffbea2f6-c2d1-4e61-9e58-fc458d7abf0d@amd.com>
References: <20261111-abm-sysfs-atomic-v2-1-6dfb19c51ebe@zohomail.in>
 <ffbea2f6-c2d1-4e61-9e58-fc458d7abf0d@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: use atomic commit for panel power
 savings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jSqZ31zCRzKr5X
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

Shivam, v3 of "Commit panel_power_savings writes from the kernel"
replaces the v2 Chenyu linked:
https://lore.kernel.org/r/20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es

It adds a fix for an overlay plane dropped while VRR is active, so
please test it on top of "Leave self-refresh before an ABM level
update" v2

Hugo
