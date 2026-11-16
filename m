Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EB606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NX0AFeRu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAAEE10ED5F;
	Mon, 16 Nov 2026 09:53:01 +0000 (UTC)
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com
 [111.22.67.137])
 by gabe.freedesktop.org (Postfix) with ESMTP id B6F3210E1F9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=NX0AFeRuBGf8xNILELAWCIgB8/+mUnQIrjXoiDyA5jHR8jfUeT+jIRVtoZ7wjs7NkMFaJsT2GpEDE
 9DdHzmM/YGtTBkWdoZiMSyABSi2lSBzTsDBP+/DQ+T063Xv0fNjOA8Py2GXshQACA7ohSFOl+EOItH
 oFeIajgECZNS7K6w=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86afad2731e1-9f697;
 Mon, 16 Nov 2026 17:52:51 +0800 (CST)
X-RM-TRANSID: 2ee86afad2731e1-9f697
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.97])
 by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16afad270b12-87bf5;
 Mon, 16 Nov 2026 17:52:51 +0800 (CST)
X-RM-TRANSID: 2ee16afad270b12-87bf5
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/imx/dcss: Fix clock leak on blkctl init failure
Date: Mon, 16 Nov 2026 17:52:49 +0800
Message-ID: <20261116095249.1519-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261030111304.2205-1-laixiangwu@cmss.chinamobile.com>
References: <20261030111304.2205-1-laixiangwu@cmss.chinamobile.com>
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

Hi Laurentiu,

gentle ping on this patch:

  drm/imx/dcss: Fix clock leak on blkctl init failure
  https://lore.kernel.org/all/20261030111304.2205-1-laixiangwu@cmss.chinamobile.com/

dcss_submodules_init() enables the five DCSS clocks before
initializing the submodules, but if the first submodule (blkctl)
fails to initialize it returns directly, leaving all clocks prepared
and enabled.  v2 jumps to err_clocks like the other error paths and
renames the labels to the err_<x> style you suggested; it carries
your Reviewed-by from Oct 30.

It does not seem to have landed in drm-misc yet - is there anything
else needed from my side to get it queued for the v7.5 merge window?

Best regards,
Xiangwu Lai


