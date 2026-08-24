Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D776C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C9810E52E;
	Mon, 24 Aug 2026 07:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="V7hazroh";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="V7hazroh";
	dkim-atps=neutral
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D86D10E01F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:30:52 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jjyOmc2K8X0ppmoPKALpru79/0BCrfyz/m43wThbzoU=;
 b=V7hazroh1fKtCcWYtjhxleGaONrY89x2ZBES+112YfpwS4//KpEEq/ETsSTkbF+buk057OSwR
 mq9FJnRTvR7ZLk6/+dgcRTsa4DJvPEH0GhkdY7bsG6FyrwECaxVTwfhEUFxigrjMDY6nVLfh8gN
 d+J6/tMcptJ24Mdqe6OG1Po=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hSxJ402DCz1BFrT
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:30:28 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jjyOmc2K8X0ppmoPKALpru79/0BCrfyz/m43wThbzoU=;
 b=V7hazroh1fKtCcWYtjhxleGaONrY89x2ZBES+112YfpwS4//KpEEq/ETsSTkbF+buk057OSwR
 mq9FJnRTvR7ZLk6/+dgcRTsa4DJvPEH0GhkdY7bsG6FyrwECaxVTwfhEUFxigrjMDY6nVLfh8gN
 d+J6/tMcptJ24Mdqe6OG1Po=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hSx4j5VMbz1T4Fq;
 Mon, 24 Aug 2026 11:20:37 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
 by mail.maildlp.com (Postfix) with ESMTPS id D04B54057F;
 Mon, 24 Aug 2026 11:30:44 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 11:30:44 +0800
From: Yao Kai <yaokai34@huawei.com>
To: <yaokai34@huawei.com>
CC: <airlied@redhat.com>, <dmitry.osipenko@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <gurchetansingh@chromium.org>,
 <jifa@huawei.com>, <kraxel@redhat.com>, <liuyongqiang13@huawei.com>,
 <olvaffe@gmail.com>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH 0/2] drm/virtio: fix control-buffer leaks on queueing
 errors
Date: Mon, 24 Aug 2026 11:50:17 +0800
Message-ID: <20260824035017.2725625-1-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731092236.2262403-1-yaokai34@huawei.com>
References: <20260731092236.2262403-1-yaokai34@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.85.180]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr500006.china.huawei.com (7.185.36.185)
X-Mailman-Approved-At: Mon, 24 Aug 2026 07:42:29 +0000
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

Gentle ping. Any comments on this series?

Thanks,
Yao
