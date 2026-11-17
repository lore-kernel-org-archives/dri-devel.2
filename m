Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711F606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=cwooper.dev header.i=@cwooper.dev header.a=rsa-sha256 header.s=key1 header.b=VvPVaEH9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9D210E5DA;
	Tue, 17 Nov 2026 18:35:10 +0000 (UTC)
Received: from mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924E510EB4C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:35:03 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=WdowVhTt2pNe6qG9EqOlUeWTt1BivkEqoKFHuGFn3X8=; 
 c=simple/simple; d=cwooper.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794940501; v=1; x=1795545301;
 b=VvPVaEH9KL6e98hZYELJdx9awLXti+fzdWgjmgA/nJr3pbiHd5uvKMQudhma5L3hrAgfKx41
 u+T6dEaV8vtyMZ8JemS08ameUAx7QiHIA95toCSCtpOVVOxfA1g2GuI3+mB0kGKx9IzzOpqyjfS
 ilgJSD+4c6Qdh0iXxVgOgkZ19/YvAzcmoLki6V8j5TSF4BEDUl5YPAzn9u8Avt4ReNAVxrQt93O
 I6hSvZE+HAmAvF3Ecppszz2bj/bS/EgK3ay2ebOCQXcx/iRwmEhbQTHOSLI62/NjBkEXruMYeW7
 l5LxiEzDKwCmMG6O7FcThr/XoeG4i15aklX5DvUqgLkYA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 1609a2da680e8095;
 Tue, 17 Nov 2026 18:35:00 +0000
X-Mizu-Trace-ID: 1609a2da680e8095
X-Migadu-Flow: FLOW_OUT
From: Cooper Morgan <ext-github@cwooper.dev>
To: Wayne.Lin@amd.com
Cc: oss@oysterdaisuki.com, harry.wentland@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/amd/display: Fix FreeSync infopacket refresh
 rates above 255 Hz
Date: Tue, 17 Nov 2026 10:34:40 -0800
Message-ID: <20261117183440.552477-1-ext-github@cwooper.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113010529.11514-1-ext-github@cwooper.dev>
References: <20261113010529.11514-1-ext-github@cwooper.dev>
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

Hi Wayne,

Thanks for picking these up! I noticed they went into
amd-staging-drm-next from v1 (bedad38a7ddf and ae60ec4dcfc4), not this
v2.

The code is the same, but v2 has oystersuki's Tested-by on both patches
and Suggested-by on patch 1. They tested the series on the 280Hz LG from
issue 5988 and asked to be credited, so I'd like that to make it in. v2
also drops a line from the patch 1 message about my EDID test that
turned out to be wrong.

If there's still time before it goes out in a pull, could you swap in
v2 or add the tags? If it's already set, no worries.

Thanks,
Cooper
