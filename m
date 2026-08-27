Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC05FC61DCB
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C9E10F162;
	Thu, 27 Aug 2026 19:08:25 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509DE10EFE6
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 17:05:50 +0000 (UTC)
Received: from Mogu.localdomain (unknown [223.73.65.69])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4b9692dc5;
 Fri, 28 Aug 2026 01:05:47 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: Fix job submit error handling
Date: Fri, 28 Aug 2026 01:05:38 +0800
Message-ID: <20260827170538.39179-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ao706o8ReDs-IXqf@rock-5b-plus>
References: <20260813142059.151644-1-Naixumogu@whut.edu.cn>
 <ao706o8ReDs-IXqf@rock-5b-plus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0442f541003a1kunmb006e1c06f573
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTENDVh8YTkNISx1PQx0ZH1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
 pVSktLVUtZBg++
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:08:24 +0000
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

Thanks for testing the patch and for the suggestion.

I have split the three independent fixes into separate patches and will send
a v2 series. I will carry your Tested-by tag.

Regards,
MoGGuU
