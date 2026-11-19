Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75E606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=mCVDZmL+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF98F11218A;
	Thu, 19 Nov 2026 08:37:17 +0000 (UTC)
X-Greylist: delayed 71418 seconds by postgrey-1.36 at gabe;
 Thu, 19 Nov 2026 08:37:11 UTC
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACEE112188
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795077429; x=1795336629;
 bh=xl7rcMmTdkbuwHxBzYDs8H/hB1tr+4M2V6k9uKOsHbU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=mCVDZmL+fy2pFG4vvyjNnh+CdpuVN/gsTVqbJCCqKiobC9JDOmgTzh9J9eJ4dPNV0
 UdkBOSOSntUrE2nSvPOXzDpJCVNpUjNWaAl+eJLtSKVvGwi/MP1dtXv2cHp/z595MN
 Z8vrLIOLJwnK2zS/nrgrK8JrMdC6Yhfn3yoPZ+oxCYH8r2oi5AlzKEIcWQjHAWenfK
 xlvzGhWqrmkzDSSt0iPme8PilxIojjumXroYnYFGegYcv++bpg9W2FsOTJ6Mss+OCh
 Q0lrMf6IcLhjbPVED8M9i267x2CHRUAKQ9k2PRXCTNJK2U15d4BQkwN02zBLkvuxx+
 HDTvquVgw58+g==
Date: Thu, 19 Nov 2026 08:37:03 +0000
To: Wayne Lin <Wayne.Lin@amd.com>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: amd-gfx@lists.freedesktop.org, Cooper Morgan <ext-github@cwooper.dev>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 oystersuki <oss@oysterdaisuki.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Store the AMD VSDB version for DP sinks
 without Replay
Message-ID: <ja6uA6zTorLKM5Utwn3SZsVJYS6parDKb8I9AwY2t21BGeMYuiVKfTcnUvYaWc0VMU_wZXB9pGX0jZrXyRJVPD7veKcrRrGFyPMB97NgdQE=@protonmail.com>
In-Reply-To: <20261119032758.3857304-1-Wayne.Lin@amd.com>
References: <20261119032758.3857304-1-Wayne.Lin@amd.com>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: c508f0d8d8269e25b7a576da45d52801e17f0888
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Wayne,

Thanks for the quick fix. It's the same hunk as in Cooper's v1/v2.

I ran the amdgpu_dm KUnit suite on amd-staging-drm-next 8dd68a79583a
with this change plus the i2c_xfer test fix, so the suite runs to the
end. dm_test_fs_caps_dp_vsdb_version passes again, and all 1931 tests
pass. I haven't tested it on a DP monitor above 255 Hz.

Tested-by: Eren =C3=96zen <erenozen@protonmail.com>

Thanks,
Eren

