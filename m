Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8803CC61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17B710F29D;
	Fri, 28 Aug 2026 07:44:57 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64AF410F27A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:41:28 +0000 (UTC)
Received: from Mogu.localdomain (unknown [223.73.65.69])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4baa740a5;
 Fri, 28 Aug 2026 14:41:25 +0800 (GMT+08:00)
From: Haoming Gao <Naixumogu@whut.edu.cn>
To: Greg KH <greg@kroah.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Sidong Yang <sidong.yang@furiosa.ai>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] accel/rocket: Validate BO handle counts on job
 submission
Date: Fri, 28 Aug 2026 14:41:13 +0800
Message-ID: <20260828064113.37390-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082816-regular-doze-e442@gregkh>
References: <20260828061916.20405-1-Naixumogu@whut.edu.cn>
 <20260828061916.20405-2-Naixumogu@whut.edu.cn>
 <2026082816-regular-doze-e442@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0471a0f7203a1kunm5a7f65548c238
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEwdVh1MQ0hJQx8YSR5PQ1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
 pVSktLVUtZBg++
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
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

Thanks for pointing this out.

My real name is Haoming Gao. I have corrected the author identity and
Signed-off-by tags and will resend the series as v5.

Regards,
Haoming Gao
