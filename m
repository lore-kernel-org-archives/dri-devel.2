Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5F606A333
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eA7+k7bT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0C510E190;
	Sat, 21 Nov 2026 15:28:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58FA710E190
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 15:27:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 264C46140D;
 Sat, 21 Nov 2026 15:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E191F000C0;
 Sat, 21 Nov 2026 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795274873;
 bh=zgQymTj5zj6QQGl9fTcd/jbTu80sUikQ+ngEqSrA6rE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eA7+k7bTNtTpV1N/bkZ1z4PZuxwDiplB2sYoFcgIe/S0eC1hhYoKSGaYM+iy3JDDB
 WTOMpBEkz6xH3Fo034BN06/CgOoXYGnU7g+5gkOxMxIyiRYI5GLtid8o0esX03chIt
 OJXVyK1Y44elW393MsK8BKGcp4+XoWZCvsRIyBOsdNxX4W69n7pk6qAfhospcZFcu9
 UoiH2sVNI5ln6Iwu1RkayeTIuBBdj2bivXLC467raQlH5BMRmybtfScFjbXYWQRpUL
 FJzgdLDEZaHUS21xyb3PdwcIDYow3oe60RR/oNcGqb3jSzKC0C+qBGixXYlmRBjBhW
 uAsgwQTBr/viA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, deller@gmx.de,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 mlbnkm1@gmail.com, simona@ffwll.ch, Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [6.18.y] Please pick three fbdev mode-sysfs fixes
Date: Sat, 21 Nov 2026 10:27:34 -0500
Message-ID: <2026-11-21-1-daily-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120201003.42046-1-artem@trailofbits.com>
References: <20261120201003.42046-1-artem@trailofbits.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Please pick these fbdev fixes for 6.18.y, in this order:
>
>   d15d51fb26e830af58f3f21964f1c09c239077ea (CVE-2026-80580)
>   ("fbdev: bound mode sysfs output to the sysfs buffer")
>   95e647d2a5304a8fd11f1ba3c8502de700650131 (CVE-2026-80579)
>   ("fbdev: clear fb_info->mode before deleting a videomode")
>   061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2 (CVE-2026-80785)
>   ("fbdev: serialize mode sysfs access with lock_fb_info()")

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
