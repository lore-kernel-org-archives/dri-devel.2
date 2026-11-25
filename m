Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alessandro.zini@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=kBET+WbB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63BB10FF36;
	Thu, 26 Nov 2026 08:09:00 +0000 (UTC)
X-Greylist: delayed 601 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 10:29:50 UTC
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F194310FAFD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:29:50 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2026112510194623182440b8000207ef
 for <dri-devel@lists.freedesktop.org>;
 Wed, 25 Nov 2026 11:19:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WNVlmcLpW9LBKmKONZI8XKOdkMMf6hESclYPJfDWndA=;
 b=kBET+WbBj/wjUuVW1NJxbvJpmn2ugOxfOL+mLhsgusuXxZF83txndMyAG8nnxR12QMHI6E
 9Ax4XAQgLMEIFPFEdELtEVJXKVr4YTkfHnH9axYCibIvDyXgD8dS1Eqxkgirm6sHbBY7HUiG
 An6zW5lDlJ1EnXGfjY4H9pLnBPjNmEoMTF3RmUgPIpN8xPWx4BbMiJ+58XNIKHig5OV01DaW
 YUcRgFK5SYO9oues6AquXVwTb6051Ui9yQ8xGkhbrlURfXemZqrbQ7DImIuvw5h9aqhL6AHS
 t75jfhwcsqwLIcEQIPzRdd6zlUWpwvHvHDinAMvANojl8mkYGPdBwP/Q==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, thierry.reding@gmail.com,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Andrej Valek <andrej.v@skyrain.eu>,
 Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH 0/3] drm/panel: simple: Add Techshine TS-P0700031A panel
Date: Wed, 25 Nov 2026 11:19:33 +0100
Message-ID: <20261125101936.103094-1-alessandro.zini@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Techshine TS-P0700031A panel support into panel-simple driver along
with the required DT bindings documentation, including the vendor prefix.

Alessandro Zini (2):
  dt-bindings: vendor-prefixes: Add Techshine
  dt-bindings: display: simple: Add Techshine TS-P0700031A panel

Andrej Valek (1):
  drm/panel: simple: Add support for Techshine TS-P0700031A panel

 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 32 +++++++++++++++++++
 3 files changed, 36 insertions(+)


base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
-- 
2.56.1

