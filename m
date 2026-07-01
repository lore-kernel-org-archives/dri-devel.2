Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19165C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5439110F1C7;
	Thu,  2 Jul 2026 07:51:32 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D109010E2FF
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:06:05 +0000 (UTC)
X-UUID: b15d4340752311f1aa26b74ffac11d73-20260701
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B,
 HR_CTT_MISS
 HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
 DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:9c10d8d2-2dd5-4dfc-8998-558e32c145ef, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:9c10d8d2-2dd5-4dfc-8998-558e32c145ef, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:1b6a4bfce7ffa0962576b94cc7550798,
 BulkI
 D:260624112706YSGBNPCQ,BulkQuantity:11,Recheck:0,SF:10|64|66|78|80|81|82|8
 3|102|127|841|850|865|898,TC:nil,Content:-10|0|15|50,EDM:-3,IP:-2,URL:0,Fi
 le:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
 KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b15d4340752311f1aa26b74ffac11d73-20260701
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <lihongfu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 940195476; Wed, 01 Jul 2026 16:05:58 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: dev@lankhorst.se
Cc: cgroups@vger.kernel.org, corbet@lwn.net, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org, hongfu.li@linux.dev, lihongfu@kylinos.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com,
 mripard@kernel.org, natalie.vock@gmx.de, skhan@linuxfoundation.org,
 tj@kernel.org
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
Date: Wed,  1 Jul 2026 16:05:11 +0800
Message-Id: <20260701080511.277167-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2021ac83-3f17-4a77-94ec-5156618c00fe@lankhorst.se>
References: <2021ac83-3f17-4a77-94ec-5156618c00fe@lankhorst.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

Hi,

> > >
> > > Shouldn't you be able to deduce this rather trivially from just looking at the current usage together with the low/max limits you already set? I'm not sure I really see anything this events file provides that analysis of current usage and set limits doesn't? If your usage is highly variable, the separately-developed dmem.peak file might also suit your needs, but still, not sure what you can do with dmem.events that you can't already do with these tools. 
> > Thanks for the question.
> > 
> > Besides exposing counters, dmem.events notifies userspace on changes via
> > cgroup_file_notify(). This allows tools to monitor limit-related events
> > (for example, allocation failures or low-protection fallbacks) asynchronously,
> > without the need to periodically poll dmem.current against the limits. While
> > you could infer some conditions from current usage and limits, polling is
> > inefficient and cannot capture transient events in real time. dmem.peak only
> > records the highest usage, not these specific events.
> > 
> > So dmem.events provides both lower overhead and richer, actionable information.
> 
> Agreed, they're separate but both useful.
> 
> The peak tells you what the maximum memory consumption is.
> The events are sent when a limit is reached, but more will also count how often limit is reached and reclaim needs to happen.
> 
> So if you have 4 cgroups, and 1 of them sends a lot of events, that tells you that you may want
> to increase that cgroup's limits dynamically to have a more performant system.

Thanks for the reply. That clarifies the distinction between peak and
events nicely.

While implementing the low event counter, I hit a design mismatch with
how TTM eviction works. TTM keeps BO LRUs per ttm_resource_manager (per
memory type), not per cgroup. During eviction,
dmem_cgroup_state_evict_valuable() is called for each BO on that global
LRU. If we increment the low counter inside this per-BO check for pools
protected by dmem.low, we count once per rejected BO during the scan, not
once per low-protection fallback.

Memory cgroup avoids this: reclaim is per memory cgroup, and MEMCG_LOW is
incremented once per memcg when reclaim enters the low-protection
fallback, before page scanning, not once per page examined.

For dmem, the low counter should be bumped when eviction decides to fall
back, when hit_low triggers a retry with try_low = true, not inside the
per-BO iteration. I'll revise the series accordingly for v2.

Thanks again for your feedback.

Best regards,
Hongfu
