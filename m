Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533E606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 04:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LtdIVG8b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756FC10E104;
	Sat, 28 Nov 2026 04:40:00 +0000 (UTC)
X-Greylist: delayed 85733 seconds by postgrey-1.36 at gabe;
 Sat, 28 Nov 2026 04:39:54 UTC
Received: from mta1.migadu.com (out-153.mta1.migadu.com [95.215.58.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1060710E104
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 04:39:53 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=/KtrdqgSMxLfjdJO9L89s3kUAEIgOvl98/T2RWkfGzI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795840791; v=1; x=1796445591;
 b=LtdIVG8bh0hwGE2YVGQvJhTQgI8w+hmEZqyQ/ex3rGA4qqGlDVXmwOzN0+aozVfNC6KhTmb8
 4GCHTmW8W0EoZ5gWibN+PodSv3GUVgaaQd+otbdio5wHzZnle5J2Z0tCH1ig/r+tQVBJ9LyhbHX
 iNRTYDWB1JuKFERU0IKTH+zs=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 19db7fbb5df56346;
 Sat, 28 Nov 2026 04:39:51 +0000
X-Mizu-Trace-ID: 19db7fbb5df56346
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: blum@kernel.org
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 mitltlatltl@gmail.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, junjie.cao@linux.dev
Subject: Re: [PATCH v2] backlight: aw99706: Clamp negative brightness values
Date: Fri, 27 Nov 2026 22:39:47 -0600
Message-ID: <20261128043947.1375645-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127103341.663905-3-blum@kernel.org>
References: <20261127103341.663905-3-blum@kernel.org>
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
