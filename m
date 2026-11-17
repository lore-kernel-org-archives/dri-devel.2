Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB3606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=ES/qqLct
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499A710EED8;
	Tue, 17 Nov 2026 08:08:30 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1900F10EADD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 02:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1794882478;
 bh=YFEMt68OTUAuLc8xbBf8qhNhrtZH4z9jKejIQ0be8PA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=ES/qqLctPecyl6Qm4ltPhJVTDibqXSXODRdx/bQCVmUPK5zhQIw62qRv5NRm5MEMF
 eyPazDT5CoYS7vChOcTLHwOlLJ5K1/zYtOKs3TasucoXiauNrxLEhJOJ36vvLP7L1Q
 gfXLNxeF7OYa3+M6Gs6KI9fDQkOVBzxur//Sv2zw=
X-QQ-mid: zesmtpgz6t1794882123t8dfc0e95
X-QQ-Originating-IP: sQqB+ujerewejO2er3hRMdg9WLwDzslkW/qZ6voe2Yc=
Received: from localhost.localdomain ( [1.202.39.170])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 17 Nov 2026 10:20:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4569123318179278308
From: Xue Haolin <xuehaolin@uniontech.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: sstfb: Error out if pixclock equals zero
Date: Tue, 17 Nov 2026 10:20:31 +0800
Message-Id: <20261117022031.252357-1-xuehaolin@uniontech.com>
X-Mailer: git-send-email 2.20.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OE2SNMSfMbmOkbcXtbV6xEXhgffGg4Q6JEDvh2xvbnjUCoAQJRu9zYX/
 slXsqg46L7AOvOhu/Wd6LqcjwlSObMfkM96Zg7sbL7GqWZYQDDUL/+0AgL7yeSMq0Kw9qjI
 xZldi5hM4ODMHlCTDJ05IqN7RSbv3eB+gwp2/crzE/aZvFrd7rcOLgLWhOAO09GDNAPNCql
 TRhJGmKLXfJ99JK9TzROCK39G35FqoSZ2CbrkS9C9vm5ETopPAWD59CL6PtZvzIIvn89IAn
 MCh2ToWnMhZVFQXOizzq8tLm8ywGjL7z/Jc8N4o6FsCPDCJuNtE+mrNhNVyEYVEDmnBKpau
 0pDbw0IS7V/VGLYaVrKqr4BHuSve2DmMbXjB5Lt7ll4CJz7GUuG41SnKt9W7k38u2MWErL+
 Qz1rxHd66FslN9Ry2I6TFSaH71JkCU5JM4vuokxZrokbHbcH3CetvZN5rLLU+5YIjgj/xH+
 00HtH9VglGojgUjxLaTcwXpm15DjgxwXjWHD9gX+VRz+rFbDaYZInRJFKyt6iFdzGj8eqiM
 Fc84ayzivAC73O2ArQ6Csr6QKYpB9D+k11b3dEQzPWJpjwSuttdR4XnV0IgIYXbhIp2tp1J
 dEdSZxmXPDUoLsjWfPhRAfzwyWjQS/8hP+xWTR9IyEHlz4KMO67ylIYhuprlbl8+9/g0ATM
 gX/e5PwTvKk3Ea+rj+Tm3FLE/ttTP6A+Y8wmTIqHgACUYKto9JltECaeHSBFsp7ULgLdBtL
 cuGN+uicz4r+SSYuaEcOMtyPskEPgHI9kiFSPXaYdO+MZJpz8kWGZGyh+SYhHW8BZ++irTS
 0pTVckcpPeAmEpJpwVa8+VxpIfdnj7DSX7M/4aQc+C7DatkgQHxlaReoWaUlSmacQYd8MRs
 YQGAK1uY+I/D/q+gSgX9O7kaYv9ZQcemL/RYELkyKf+99Z3HlQZlE3uwoixBpzjddsJqfTz
 ISSHan7jJDzv9edlPdqeFIqYFXayeEVEwzxDwMC7P/Js0+ltwZOQQFXGv2wHMjVD5yl/ly+
 g0dE3OvHTnn0gCgxUtKhp2OBk3hQgUq15vgu3evQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:19 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: xuehaolin <xuehaolin@uniontech.com>

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of pixclock,
it may cause divide-by-zero error.

sstfb_check_var() calls PICOS2KHZ(var->pixclock) which expands to
1000000000UL / var->pixclock. If var->pixclock is zero, this causes
a divide-by-zero exception.

Fix this by checking whether pixclock is zero at the beginning of
sstfb_check_var(), before it is used as a divisor.

This is similar to CVE-2022-3061 in i740fb which was fixed by
commit 15cf0b82271b ("video: fbdev: i740fb: Error out if
'pixclock' equals zero"), and the fix in savagefb by
commit 04e5eac8f3ab ("fbdev: savage: Error out if pixclock equals zero").

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: xuehaolin <xuehaolin@uniontech.com>
---
 drivers/video/fbdev/sstfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 8e2c2421028d..de0769eb4a2f 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -359,6 +359,9 @@ static int sstfb_check_var(struct fb_var_screeninfo *var,
 	int tiles_in_X, real_length;
 	unsigned int freq;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (sst_calc_pll(PICOS2KHZ(var->pixclock), &freq, &par->pll)) {
 		printk(KERN_ERR "sstfb: Pixclock at %ld KHZ out of range\n",
 				PICOS2KHZ(var->pixclock));
-- 
2.43.0
