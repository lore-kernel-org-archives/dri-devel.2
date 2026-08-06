Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F73C56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3321410E2D6;
	Thu,  6 Aug 2026 14:58:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3100410E2CD
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:06:16 +0000 (UTC)
X-UUID: 1107ce8c917611f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:0f96dbb6-39df-450d-b4d5-8de07c3b0642, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:9b70face06a5294b19641330e8310daa,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|850|865|898,TC:nil,Cont
 ent:0|15|50,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
 l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1107ce8c917611f1aa26b74ffac11d73-20260806
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <gonglinkai@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 965795620; Thu, 06 Aug 2026 17:06:10 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org,
	gonglinkai@kylinos.cn
Subject: Re: [PATCH] drm/mipi-dsi: fix UAF on device_add() failure
Date: Thu,  6 Aug 2026 17:05:57 +0800
Message-Id: <20260806090557.3389418-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806080946.546A11F00A3A@smtp.kernel.org>
References: <20260806080946.546A11F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 14:58:49 +0000
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

On Thu, Aug 06, 2026 at 08:09:45 +0000, sashiko-bot@kernel.org wrote:
> [High] The patch introduces inconsistent ownership semantics for the
> info->node reference on error paths...

Thanks for the review.

The put_device() change is still required: mipi_dsi_device_alloc()
calls device_initialize(), so the error path must release the device
through put_device() rather than kfree().

Regarding of_node: device_set_node(of_fwnode_handle(info->node)) does
not take a reference, while mipi_dsi_dev_release() calls of_node_put().
That imbalance already exists on the success path when the device is
later unregistered; this patch only makes the same release helper run
on the device_add() failure path as well.

I can follow up with a separate change for the of_node refcounting if
the maintainers want that cleaned up. Happy to adjust based on human
reviewer feedback.

Thanks,
Linkai
