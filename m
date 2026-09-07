Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1B0C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6E910E68C;
	Mon,  7 Sep 2026 07:04:46 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFA710E68C
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:04:45 +0000 (UTC)
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
 by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4hddKb45hfzBXKbc;
 Mon,  7 Sep 2026 15:01:55 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Mon, 7 Sep 2026 15:04:39 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <sashiko-bot@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <sashiko-reviews@lists.linux.dev>,
 <shechenglong@xfusion.com>, <chenjialong@xfusion.com>,
 <stone.xulei@xfusion.com>
Subject: Re: [PATCH] drm/client: fix restore of partially initialized client
Date: Mon, 7 Sep 2026 15:04:33 +0800
Message-ID: <20260907070433.1412-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20260907041237.C7E301F00A3A@smtp.kernel.org>
References: <20260907041237.C7E301F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.82.130.100]
X-ClientProxiedBy: wuxpheds03047.xfusion.com (10.32.141.63) To
 wuxpheds03048.xfusion.com (10.32.143.30)
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Could the error handling path be updated to ensure the buffer is properly
> destroyed when this occurs?

Thanks for pointing this out.

This appears to be a pre-existing issue and is not introduced by this
patch. The purpose of the current patch is limited to preventing the
restore callback from dereferencing a partially initialized fbdev
client.

The cleanup concern looks valid. I will inspect the buffer ownership and
error-unwind paths around register_framebuffer() failure. If additional
cleanup is required, I will handle it separately so that the restore fix
remains focused.

Thanks,
Chenglong She
