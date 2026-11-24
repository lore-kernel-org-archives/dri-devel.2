Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9027F606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wc3lcipV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C4A10E0AB;
	Tue, 24 Nov 2026 04:42:18 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8458010E0AB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=wc3lcipVFh6bJnNTgKIFdZ5LzsBhmG4Bg5H5Xw2bXdJotKnP3pCpvlQ6kBhwid31u+YKqYG523/u8
 Y1ugxKx6hOrpfdDAWlXKulJ+eytanHZfxPe4kZCDUKKu37EhDleGWgZcylowBCnWY6rDYxo/Kw0beu
 1U2eLHMcFy+9Q9Pw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56b05159518c-40fb2;
 Tue, 24 Nov 2026 12:41:57 +0800 (CST)
X-RM-TRANSID: 2ee56b05159518c-40fb2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36b0515935ca-13776;
 Tue, 24 Nov 2026 12:41:57 +0800 (CST)
X-RM-TRANSID: 2ee36b0515935ca-13776
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: dpaux: Fix VDD supply and AUX channel leak on
 attach failure
Date: Tue, 24 Nov 2026 12:41:55 +0800
Message-ID: <20261124023000.1211-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261110065254.1211-1-laixiangwu@cmss.chinamobile.com>
References: <20261110065254.1211-1-laixiangwu@cmss.chinamobile.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hello Thierry, Mikko,

A gentle ping on this patch, sent two weeks ago on Nov 10:

  drm/tegra: dpaux: Fix VDD supply and AUX channel leak on attach failure
  https://lore.kernel.org/all/20261110065254.1211-1-laixiangwu@cmss.chinamobile.com/

The patch fixes tegra_dpaux_probe() error paths after drm_dp_aux_attach():
when the channel AUX lookup fails or drm_dp_aux_register() fails, the VDD
supply and the AUX channel acquired earlier are never released, leaking
one regulator and one AUX channel reference on each deferred/failed probe.

It applies cleanly on top of the current drm-misc tree. Please let me
know if anything else is needed, or whether the patch is queued somewhere
I missed.

Thanks,
Xiangwu Lai


