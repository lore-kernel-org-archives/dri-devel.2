Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC702606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=cwooper.dev header.i=@cwooper.dev header.a=rsa-sha256 header.s=key1 header.b=RQ5Vljpm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A5B10E1E3;
	Thu, 19 Nov 2026 01:41:47 +0000 (UTC)
Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185CE112110
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 01:41:39 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=78jCQYAj/2CHdToyXerZ0OobA/hCp5b2KM82DylRDl4=; 
 c=simple/simple; d=cwooper.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795052497; v=1; x=1795657297;
 b=RQ5VljpmayCFOZ2cbXnlw9aVNqmb+FJnHMs/bSCP+PGq1dnMyydBAEclfT/QB2K7AkWRu9v5
 bvbxV2J4GFsLBvDEx+1T9v4cSfOclkrD7a0+zimQqqtCG4lxj5ev3mxSocKu/JYHvVl9Vr4nv54
 C4jcU3R+lY7Yt+jhiSBMQHq/C0A6rEm0DZg5SvAA+a4TOWWzE1iAPimVSXUPCDBrua/rav/iP1h
 dUlSCL9rTkaKo4NwjrxLOwM+VV94MXDz9GxiL0k9pYSnNUTulafRBJHuZP0K4KqbqtfMDqyttMi
 C0F+WiI1h2S322Dqc5H3PXckocAG8prU9TgbHv/WicK8A==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 4d7e63b37adc295c;
 Thu, 19 Nov 2026 01:41:37 +0000
X-Mizu-Trace-ID: 4d7e63b37adc295c
X-Migadu-Flow: FLOW_OUT
From: Cooper Morgan <ext-github@cwooper.dev>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: erenozen@protonmail.com, Wayne.Lin@amd.com, oss@oysterdaisuki.com,
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/amd/display: Fix FreeSync infopacket refresh
 rates above 255 Hz
Date: Wed, 18 Nov 2026 17:41:15 -0800
Message-ID: <20261119014116.3632450-1-ext-github@cwooper.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <HftAWPKURVjBtK_2BmUiLXOb8ghZxaEzAJSg0tlsmy5L3ckJyDWc6g65vrsVGdA3ZcytB6mPuyxaQbsPawfOZmdC1dyAo4lCbaK3Tj7Tm-U=@protonmail.com>
References: <20261113010529.11514-1-ext-github@cwooper.dev>
 <20261117183440.552477-1-ext-github@cwooper.dev>
 <HftAWPKURVjBtK_2BmUiLXOb8ghZxaEzAJSg0tlsmy5L3ckJyDWc6g65vrsVGdA3ZcytB6mPuyxaQbsPawfOZmdC1dyAo4lCbaK3Tj7Tm-U=@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

The copies in drm-fixes-7.4 and drm-next have the same problem Eren
found. Patch 2 there (6a9d5e2f, e1c26823) is missing the
amdgpu_dm_connector.c hunk, and its connector test went with it, so
nothing fails on those branches.

Could you swap in v2 before the fixes pull goes out? It has the hunk,
plus oystersuki's Tested-by and Suggested-by tags.

Thanks,
Cooper
