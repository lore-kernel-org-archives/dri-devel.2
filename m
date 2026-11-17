Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE5606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=AmYl0dSY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1EEB10E479;
	Tue, 17 Nov 2026 05:14:30 +0000 (UTC)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6C910E479
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 05:14:24 +0000 (UTC)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-cdb2dfcca94so1867348a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794892464; x=1795497264;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=xB6gMrbIBKBmgVYWMJ+h47vaJ9y40BKuwRrTAbJuvR/fVc1yK4bf0gzxhwufLqf20p
 uziefjfVe9MyZO6APomuKQz012cjS1yIWROlDdHUGzN3iCxS2zdyAqw6ZjzlHGJ33DDD
 z3cpO6wHrCKeh+TB2ZQAwQUtRtPe81nD+Lh5PX9OIbdoISrSCFs7KEYOVjxs4zqnkn7s
 7kQXD/wu5dCj6gwUdZoMScbkY/2jOCWykIg377jCgKZ7gCdYdGQZjb51iCgsjf+fyHry
 RxYfTBUJ6YWnwKhMu+vo7zTl9iFf6wHfXFxOkrzM7E0Oe7vhdo6bRqmeU9RaVbbCoetI
 DZTw==
X-Forwarded-Encrypted: i=1;
 AL+hErHUwCvcaLD7MWo+zNpx45z2mzADv0TiQV/M6joAgC1sUcgDTP9sdU8i1jsSE98r24ldJUOpTN0+2UA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/vVg06KrRtuvnMly4YmR9vXtWAhZZtnqSumNUBqjFgim16+jLe
 1Rb+gT3MEOEzMcLETrjkP2+iC1WICxiqu+hebmb+50yS7QCBI+ghON6elrARdm46XUYcBz+Td0V
 t5yeP1aypKt7naCFDL19/V1SFtzjTWgadZoOus2PwHHb4NgkwvK953UkapPn5exIlV9IygYAuXl
 9lnmSYoUaGbh21KmtDYelF4LjMcDLMrQa/4N2t5mnEF/+wo4ac5ijygJSMoCGADZ4sOZ2wH/yxo
 gm/wy36iz0ZyhPtKSCJ
X-Gm-Gg: AZFdTZcivKs3pTHHNccPGEiODEtPcDJjChE7Hk2c2IKVECdrFVEMpXXeIfYaa47/p4N
 J5CiltJ7D20zOhZCFsIs7wBHG0uMH2De/qLUFqKxnzMePMevl1zS6DS0ZjXMlcWY0/CBQnXariT
 TSzSW8ism35yN+aIvvVJodwPIUtkzr76/uea3DnlD95xbmB8OkV2XBl6/NmkrB6FmAYIt/jTsce
 TRu2CEdxFsllpUNBomPz1MWNX8+NQNM9/WqFTi/BQmo+MOEN9SN14M0ql9CMzR5rXKpivGtWGpx
 n5deF4ZkBChGjyBqAbbtHPyYXBzh3Nv0WXahfa9pEmf6kwPJErLjJ/TdgNbAKAl9oHQet5sellH
 da7CL97E6A3Ed4m++dOrUGuo8F1P2mMEJl6LXHlFMTMps6yyI9h45GM8ZcOz9SDrwtFzyzD7mR+
 MNgjFWONf2PgzgaamBxX2qKv2qnDdg6ECe
X-Received: by 2002:a17:90b:1c81:b0:3b1:7329:a127 with SMTP id
 98e67ed59e1d1-3b1b09f60bemr11298918a91.20.1794892463536; 
 Mon, 16 Nov 2026 21:14:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3ac020c2fsm1133707a91.6.2026.11.16.21.14.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 21:14:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b167bc8e16so3686216a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794892461; x=1795497261;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=AmYl0dSYNG7e18yYg40lkWrZ6WEDC/flv6hvFAGWKv4A9mrMK8Doqdfb+YefaxQvgi
 8oN/qdbO3so+PyyuNxF3xvA6utK1GppVnnqoNN5xgWKzy2ATB4XC4W04x3IuS7/yorA9
 9ApkOFZWkQkyNTsu+RSENh1zOeSdna44a8V3I=
X-Forwarded-Encrypted: i=1;
 AL+hErE7bvL2UfEFcoiqOT4UmOJLbgBdnVxqWJC6DPPmmqbqtDoKt8giU6nnAIYNhumBu4YrVuyU8XttZno=@lists.freedesktop.org
X-Received: by 2002:a17:90b:3d87:b0:3b0:a831:5acc with SMTP id
 98e67ed59e1d1-3b1b0a3a056mr11554928a91.42.1794892461638; 
 Mon, 16 Nov 2026 21:14:21 -0800 (PST)
X-Received: by 2002:a17:90b:3d87:b0:3b0:a831:5acc with SMTP id
 98e67ed59e1d1-3b1b0a3a056mr11554911a91.42.1794892461137; 
 Mon, 16 Nov 2026 21:14:21 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2efd7a586d0sm7827675ad.47.2026.11.16.21.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 21:14:18 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Martin Krastev <martin.krastev@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/vmwgfx: Fix NULL vs error pointer bug in
 vmw_prime_import_sg_table()
Date: Tue, 17 Nov 2026 00:14:16 -0500
Message-ID: <179487959553.2515856.10912427542043749089@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <akPFZ-e9usvsYgf_@stanley.mountain>
References: <akPFZ-e9usvsYgf_@stanley.mountain>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Thank you. Applied to drm-misc-fixes.

z
