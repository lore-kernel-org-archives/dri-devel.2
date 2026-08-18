Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31143C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D67A10E893;
	Wed, 19 Aug 2026 06:36:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FD810E46A
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:54:36 +0000 (UTC)
X-UUID: 5f0f4aba9a9f11f19a56ed5b684f684d-20260818
X-CID-CACHE: Type:Local,Time:202608180848+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:5590525d-0ecd-43bb-bdf6-14b92fc9c399, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:73029acdd14f5997fa35d963f8f7ebc8,
 BulkI
 D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM
 :-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5f0f4aba9a9f11f19a56ed5b684f684d-20260818
X-User: yuebingkun@kylinos.cn
Received: from tushenkeke2-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yuebingkun@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 353780189; Tue, 18 Aug 2026 08:54:31 +0800
From: yuebingkun <yuebingkun@kylinos.cn>
To: David Laight <david.laight.linux@gmail.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: platinumfb: replace strcpy with strscpy
Date: Tue, 18 Aug 2026 08:54:28 +0800
Message-ID: <20260818005428.47917-1-yuebingkun@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153757.4a683d24@pumpkin>
References: <20260817153757.4a683d24@pumpkin>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

On Mon, 17 Aug 2026, David Laight wrote:
> There is no point using strscpy() to copy quoted strings into arrays.
> Indeed, if the string is too long the kernel build will fail if strcpy()
> is used but strscpy() will silently truncate the strings.
> So strscpy() is actually worse here.

Thank you for the explanation. You are right, for copying a known
string literal into a fixed-size array, strcpy() is actually safer
because the compiler can catch overflow at build time. I will drop
this patch.

---
