Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EA606A68F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YRBbEzIw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BCE10E30B;
	Fri, 27 Nov 2026 04:57:12 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Fri, 27 Nov 2026 04:57:06 UTC
Received: from mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BD810E30B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:57:05 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=GUIAxerpQhJLvh6XFl3jtOcmO7oPZcsLN/6gwcX+K9o=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795755424; v=1; x=1796360224;
 b=YRBbEzIwUKwHQ9MCmt8bIztwq30RUao6AVsbyUaqkOEw4GyA8IShtn1lPMGaw4KuXq2JICj3
 RRYCXN0pmuM2wtEN+WS9Zaf6AdTcMWG4YIYseeJ2Ez/JiZ2h13wp6u+LFKCQ03Uz4mAaAqDcnP1
 IYQOPuMNA1tUGgQtKEqVwg5c=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 24b8cb35b28b4af2;
 Fri, 27 Nov 2026 04:50:59 +0000
X-Mizu-Trace-ID: 24b8cb35b28b4af2
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: blum@kernel.org
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 mitltlatltl@gmail.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, junjie.cao@linux.dev
Subject: Re: [PATCH] backlight: aw99706: Clamp negative max brightness values
Date: Thu, 26 Nov 2026 22:50:48 -0600
Message-ID: <20261127045048.1317758-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127021423.656745-2-blum@kernel.org>
References: <20261127021423.656745-2-blum@kernel.org>
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

Hi Thorsten,

default-brightness is also read into a signed int. With
max-brightness = <100> and default-brightness = <0xffffffff>,
brightness ends up as -1, so the upper-bound check misses it.

Could you clamp both values as u32 before assigning them to bl_props?

Thanks,
Junjie
