Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2B606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=Yb4ezhdb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8721110EB9E;
	Wed, 18 Nov 2026 08:23:17 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8A210E22F;
 Wed, 18 Nov 2026 04:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1794975116;
 bh=MazwyKBAAJxGApGVQAi7o9vsXSHn/UcdBNWB4c/zyGI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Yb4ezhdbCInBNJHumjYfh/dBYIQbvSsxRvwgz5fGov7/AVv/xOci+04W1B74Hq2Xe
 2IkHo/C5c56CavABeA2wvbz7tmmUWEmr2R1mGEj2LgfKgK2vApslCIiM3jGnSb3g+Y
 PHXwZrJTmCK8QuhGUoM8Uq+00SRxCvchx4fWAN+U=
X-QQ-mid: zesmtpgz5t1794975111t05ee3256
X-QQ-Originating-IP: 1xiKVLEGuFfQiaVeaP4jLsUEFzIgMIkolLwfBOhDrpk=
Received: from exmail.qq.com ( [14.155.219.48])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Nov 2026 12:11:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3286016119200316987
EX-QQ-RecipientCnt: 7
From: Hanson Wang <hanson.wang@ugreen.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dri-devel@lists.freedesktop.org, hanson.wang@ugreen.com
Subject: Re: [PATCH i915] drm/i915/bw: Ignore inactive CRTCs in bandwidth
 calculation
Date: Wed, 18 Nov 2026 12:11:46 +0800
Message-Id: <20261118041146.959672-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016014704.3876294-1-hanson.wang@ugreen.com>
References: <20261016014704.3876294-1-hanson.wang@ugreen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NnhVmA86AxStAwCINlWD8x1Dy/fd0BNORjxD+AO4SDlBBK8kbxGdqzjV
 0LqzsQiMKP5TThySVhlXxrJDwrDkqBwkGDfBfW+pl/JDnsrn16pRSMa5XP/rkA9eg9CbLiz
 EkoUhmEtIdZTSp85q5QW68YQJI1oLmbO5MzTacnIi5ZY/o5koW33/v7PEFs3AiokMfGZSIi
 u8Jr1Ku+CiywQ6S8D+rR4Wyo1PllwLhcgTLOLrWVYiMpn6vA4BPoSeXxkLLJuiC4RTgi/yo
 lBHN8e0mYuyTM/4F+RsSwW+cQytwZlMFp8uORPFD93B+h3ff6IfkVd3muwyLyI/qDa9jwW6
 KiLheMLTKtEHg4S+G8ksdDQL4KIcZbygbJHDGL3/N108F4lF2q7x/ZxXdrPeEnQu/wZhcIQ
 +dbC1+jdbl2vAwAZX85KZm3+/JxZJ0iwbH42Ka3lkoY+xF+fd89c1SucQNbGKhZGo7oMnJC
 jB4DN7P8/A/SbUXtbI0EUhuis4F4CIw6MhP7M5snti/YWIART3UebOb0g0Xoox3KrZ+jlOc
 kBUCB3tkGrKWozKaxnjG1xEmug1zm2rOW3UnaIcW81o5La0bXG0ghGcjj6X+9zU7DbVedAJ
 3WXOWFB7jdB8a6BdmKyaxGtQ0JHz4LUQuh95LH4zEk8ItEO67mwJWvfUBoJonR4+OG2eSo+
 kkqWP3U7LXBTvs/979IlBboO8+3Gn/NooVFFYIi4X7u4MGBzP+TQomRESmDVfzpieXRtRB7
 9iuQtoFvBurABqGXSkK/HjzZBQmPbX21S54JRlXd1ueHrGIXau6xp5ixy43OvzJeqHfsxAP
 UtVntJjQj6FzEzmtsQLEtSfAjYx7gYbuSk8gYUTtL1x3mF/fFwqtlOQJwMUZSPVHtDexQ9e
 BAVNyzxzFBHWUzoEjPPRYvJrS5NxViJ3Sko85zoSZPPD92S17wC8GZDbTMTzhSOuQ4s6esV
 PMBlb2HDIsuVh02vkP/10XvBG5I+rt89Vb5AZ7eG+YFErtuXUeof1juVuIW+YctXQYi4XWM
 HkMIUR6wpGRJs/x5aqo4c8ZsjxIMbgWs2OggEGMiOr3JciPfbu
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please drop this patch. It does not fix the bug, and the approach is wrong.

I tested it on the affected systems. After firmware handoff, DBUF
sanitization disables the inherited plane and clears the CRTC-local
state, but the global BW entry remains. Zeroing bandwidth for every
!hw.active CRTC does not remove that stale global state. It would
also drop the legitimate reservation for a logically enabled but
inactive CRTC.

The failure is phantom global bandwidth left by the non-atomic plane
disable, not an enabled-but-inactive CRTC that should still be counted.

The replacement is a separate patch, not a new version of this one:

  drm/i915/bw: sync global BW after non-atomic plane disable

Link: https://lore.kernel.org/intel-gfx/20261118033312.902366-1-hanson.wang@ugreen.com

Thanks,
Hanson
