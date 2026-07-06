Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B225FC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BCBA10E8BA;
	Mon,  6 Jul 2026 11:19:43 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE3C10E349;
 Mon,  6 Jul 2026 11:19:40 +0000 (UTC)
X-UUID: 9119216e792c11f1aa26b74ffac11d73-20260706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:bf8debb3-4740-4bfb-9248-e8e40d6abf50, IP:0,
 U
 RL:0,TC:0,Content:46,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:26
X-CID-META: VersionHash:e7bac3a, CLOUDID:daed2c6d3ffa59291953ef42d782f047,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:82|83|102|850|865|898,TC:nil,Content:4|1
 5|50,EDM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
 0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9119216e792c11f1aa26b74ffac11d73-20260706
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <lilinmao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1726140942; Mon, 06 Jul 2026 19:19:34 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andi Shyti <andi.shyti@linux.intel.com>,
 Konstantin Khorenko <khorenko@virtuozzo.com>,
 John Harrison <John.C.Harrison@Intel.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/guc: Return NULL for missing multi-lrc parent
Date: Mon,  6 Jul 2026 19:19:25 +0800
Message-Id: <20260706111931.619422-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260706071412.559909-1-lilinmao@kylinos.cn>
References: 
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

Regarding the pre-existing issue flagged by the Sashiko review below:
the report is correct.  logical_sort() scans all MAX_ENGINE_INSTANCE + 1
slots while its only caller initializes just num_engines entries, so the
inner loop can in principle dereference an uninitialized stack pointer.
In practice the logical instances within a class are numbered
contiguously, so every BIT(i) matches within the initialized entries and
the stale slots are never reached.

While confirming this, a second problem in the same function turned up:
the final memcpy() passes *engines and *sorted instead of the arrays
themselves, so it copies engine structure data rather than the pointer
arrays.

Since both are unrelated to this cleanup, I have sent a separate patch
replacing the helper with a plain sort() keyed by the logical mask,
which addresses both and drops the assumption that logical instances
are numbered contiguously: "drm/i915/guc: Sort multi-lrc engines by
logical instance".

This patch itself is unaffected.
