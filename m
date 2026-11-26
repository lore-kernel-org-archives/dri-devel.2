Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD88606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kT0k/jDO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E588D11284C;
	Fri, 27 Nov 2026 08:29:27 +0000 (UTC)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B029C1121BD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:46:11 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so9347489c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 00:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795682771; x=1796287571; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ly+iwNCEEn75tDRea4ss7xMGDQP2WimRSELcpuIARng=;
 b=kT0k/jDO+v+4VUZ+Zwa7uweoB2czLGpwHvajrUDQRgELQvx2IDou2ktVf2Tl5AlocC
 C+BRUKLhGs92/poVG1hCkDD+emP8uH1XJxQ0YpZmNMttL1zTNp0e67yyNjlHBBHs+8c8
 pV6yaaztdGb3eFG70JnyVc4i3BPa/ztjvkCy+MkeXFt+rsiONZXw18DPwxKIBWFsxoAP
 rAuCSMC0rHqIYmQvnpP+4wZta2jB0ilrkLAh/psoY3euR49Y9eFcltSOxp666Y3GWpjX
 f8KpkGKeMfUCeJaFHscI8oxOy+zEQgON7W08qVRh34bx5VWey4HHsg/0rilWUYmf0trE
 YRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795682771; x=1796287571;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ly+iwNCEEn75tDRea4ss7xMGDQP2WimRSELcpuIARng=;
 b=osyqkuzfJvwrvmlgX5XNCWyi7R+df2sCLbiU6N0YzN0OzUebqg2nyOQZAl6lp6A+eC
 pTX3ZK8fJ0cLSbxcc51HUTURbxYYhC0H/+MSMbCTYg1B3xBvXPnvW/Z2Dhvreh7HrwST
 xI2fNv5fg7iIWuqgFlJsmu3FUfCvu+ft6w5w8pbMqYfY+UEQmBkRlH3nUygDGBSzzKOI
 aIfQ6Rm6x7/TCdPkbXzJS8hYpF5nSl/XTNdO10J/8e0BpglV2AFULccUBCkYp0L7S8ht
 kIWTCtZt1344cLZB80jXbTfPUOwmC9JsB3z/59AWjp3Rm5al9XQH6hecEO0nTIqL+RIR
 av+Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEB9QzX/x/Empv0a92jLkz9qR4LqqbQIXg/zXWfqwQbLdeZl65gfAqRdG8s0Osds1t3Q9N8kvG0g3w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/WrVHyKNHcG4nwmAiV7ttLgKTbNfY0SaACyOCLaCnCmvTCAehy
 gO/Gj8Q6+BFPhPnZzyyWAYBbN+n7AHSJOldisVQ7yccrXHiKX0k7f9Wx
X-Gm-Gg: AZFdTZfTntNuMDSce0RPmF8oECZVlfBAuilKUta/xG1RDHHtrDOTdhuz4X+Rp1FTT1k
 JczCQar4l/DNXIKy/wG/h6l7nJTp2JPORGxoSoi+JpEDiLHbYyjKmTwKwLUlrDbVspl6/bMQwVR
 3WSj7DRU6ZbVh6ElGEm4y7iCepOrYSNarK3LEw1O+Cc8GoQuz/GyW9aez9XcW4gTgg22kNNcmTi
 BYIqQNgFKhz7cDWMt4felNVKwXfS187+/mHdEA3xgA8nu/M159WlVjsHUgTpDJCS93pR1cIpvVU
 F7A0+A4RzX70zOcSLpIzVb4rbGEWNV2M/F05LGlb+bAy3VyWKLp/8xGhuHhJiEyUgMWLxCXuK28
 CzhTWPNwm2xsUR3puZN0+JbDr4aHKwOMufjdXy27AZbHj2/WOcCXLXwd3XR+EvkvtVCJu9Ikt3z
 MqBC1vT3R89od9fYAx5ylPixQsdluhyeEoZKPfdSUZ241wHlIw2C7UMyk5v4jjJqLbx8+aBttUt
 FthDf0E+R8oO7Chi9U74h3HM/yAhxZAa1xX/5qNJs5oOVMP3mIrSaV6AtOIfaYZHAQy5Q4q0X1d
 Gv3qUfmLLuvLhoTMISBrojArtKWl7Y7GnxOyQCdx+ldOKig=
X-Received: by 2002:a05:701a:844d:10b0:1b5:888a:a1ab with SMTP id
 a92af1059eb24-1b5888aa35bmr5436082c88.15.1795682770738; 
 Thu, 26 Nov 2026 00:46:10 -0800 (PST)
Received: from [127.0.1.1] ([2603:c021:8021:f000:0:1865:8c38:18fc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55682d301sm48473417c88.10.2026.11.26.00.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 00:46:10 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH] gpu: host1x: Document the get, put,
 mmap and munmap operations
Date: Thu, 26 Nov 2026 08:46:08 +0000
Message-ID: <179568276877.2784410.11651710233519548918@gmail.com>
In-Reply-To: <UAzdHWBlSIO_jTuii3HiZg@nvidia.com>
References: <20261125172022.2344949-1-takano32@gmail.com>
 <UAzdHWBlSIO_jTuii3HiZg@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mikko,

thanks, I found it now: Amit Patole's "gpu: host1x: document the remaining
host1x_bo_ops callbacks" on 2026-11-05

https://lore.kernel.org/all/20261105-kdoc-host1x-bo-ops-v1-1-cc171c9e36a0@gmail.com/

which is the same four members.  My search looked for the lines I add and
for my own subject, and his wording differs, so nothing matched; I have
added a search by file path to the check.  Please drop mine.

TAKANO

