Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6668CDE007
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31BAA10F13B;
	Thu, 25 Jun 2026 07:03:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFA910E141
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:11:35 +0000 (UTC)
X-UUID: 2be80908703b11f1aa26b74ffac11d73-20260625
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B,
 HR_CTT_MISS
 HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
 DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
 GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:28c332a2-702e-448d-83d3-ba56f2aaac95, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:28c332a2-702e-448d-83d3-ba56f2aaac95, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:6bf237fb64cc35fff2084227c0961fab,
 BulkI
 D:260624112706YSGBNPCQ,BulkQuantity:3,Recheck:0,SF:17|19|64|66|78|80|81|82
 |83|102|127|841|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File
 :nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
 :0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2be80908703b11f1aa26b74ffac11d73-20260625
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <lihongfu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1390390969; Thu, 25 Jun 2026 10:11:26 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org, corbet@lwn.net, dev@lankhorst.se,
 dri-devel@lists.freedesktop.org, hannes@cmpxchg.org, lihongfu@kylinos.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com,
 mripard@kernel.org, natalie.vock@gmx.de, skhan@linuxfoundation.org,
 hongfu.li@linux.dev
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
Date: Thu, 25 Jun 2026 10:10:53 +0800
Message-Id: <20260625021053.488107-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ajwnf0uzT4PMHYZx@slm.duckdns.org>
References: <ajwnf0uzT4PMHYZx@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

Hi, Tejun
Thanks for the review comments.

> > Add dmem.events to report hierarchical low/max event counts per DMEM
> > region.  Increment counters on dmem.max allocation failures and
> > dmem.low protection events.  The file is available for non-root cgroups
> > only.
> 
> Please don't double space in descs or comments. Also, maybe it's obvious but
> it'd help if you list why and how this is useful. Why do we want to add
> this?

I'll fix the double spacing in the commit message and comments.

As for the motivation: dmem already exposes per-region limits and current
usage, but not how often those limits actually matter at runtime. Without
event counters, it's hard to tell whether allocation failures come from
this cgroup, a parent limit, or pressure elsewhere in the hierarchy.
dmem.events provides that visibility for tuning dmem.low/dmem.max and
diagnosing recurring device memory pressure.

I'll expand the commit message to cover this.
 
> > +  dmem.events
> > +	A read-only file that reports the number of times each cgroup
> > +	has hit its configured memory limits.  The format lists each
> > +	region on a single line, followed by the event counters::
> > +
> > +	  drm/0000:03:00.0/vram0 low 0 max 3
> > +	  drm/0000:03:00.0/stolen low 0 max 0
> 
> This isn't a supported file format. Please read the documentation on allowed
> formats.

Thanks for catching this. I'll switch dmem.events to nested-keyed format (region low=N max=M).

Thanks again for the valuable feedback.

Best regards,
Hongfu
