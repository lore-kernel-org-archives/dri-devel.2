Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C6DCCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0B710E893;
	Mon, 19 Oct 2026 08:37:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB1910E898;
 Mon, 19 Oct 2026 08:37:12 +0000 (UTC)
X-UUID: 439bde90cb9811f19a56ed5b684f684d-20261019
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:40f6eb13-f796-4f05-8a77-5e38376972e8, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:7db8b62, CLOUDID:8f3520c8e780fa2c22df261c230c53de,
 BulkI
 D:nil,BulkQuantity:0,SF:80|81|82|83|102|123|850|865|898,TC:nil,Content:0|1
 5|50|99,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 439bde90cb9811f19a56ed5b684f684d-20261019
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 15019227; Mon, 19 Oct 2026 16:37:05 +0800
From: yaolu@kylinos.cn
To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 andrealmeid@igalia.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, yaolu@kylinos.cn
Subject: Re: Re: [PATCH] drm/amdgpu: Fix out-of-bounds write in
 amdgpu_debugfs_gfxoff_count_read()
Date: Mon, 19 Oct 2026 16:36:58 +0800
Message-Id: <20261019083658.259000-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b6ce551d-b37c-40a7-a2b0-07eae754a156@amd.com>
References: <b6ce551d-b37c-40a7-a2b0-07eae754a156@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

So, may I need to make the change? Such as a conversion of all gfxoff handlers
to seq_file text output, following amdgpu_debugfs_test_ib_show() in this file.

Another issue is switching these files from raw u32/u64 to text
changes what existing consumers read.Is this approach acceptable?

Regards,
Lu
>Regards,
>Christian.
>
>>  	}
>>  
>>  	r = result;
