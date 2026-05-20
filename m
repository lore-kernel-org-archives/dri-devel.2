Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955CDCD4F5B
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 02:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0450D10E622;
	Wed, 20 May 2026 02:55:57 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9C210E622
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:55:55 +0000 (UTC)
X-UUID: 67eab38453f711f1aa26b74ffac11d73-20260520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:ac6fe59b-c39f-4cfd-b4ec-66397558d3d2, IP:0,
 U
 RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:3
X-CID-META: VersionHash:e7bac3a, CLOUDID:76d88fe4dfed9b1d6ba784b9d3b7a7dd,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|123|850|865|898,TC:nil,C
 ontent:4|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 67eab38453f711f1aa26b74ffac11d73-20260520
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1602025270; Wed, 20 May 2026 10:55:49 +0800
From: yaolu@kylinos.cn
To: deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 yaolu@kylinos.cn
Subject: Re: [PATCH] fbcon: don't suspend/resume when vc is graphics mode
Date: Wed, 20 May 2026 10:55:46 +0800
Message-Id: <20260520025546.71982-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67a1f756-996c-404b-8eff-f705ff151ed3@gmx.de>
References: <67a1f756-996c-404b-8eff-f705ff151ed3@gmx.de>
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

On 2026/5/19 16:10, Helge Deller wrote:
Hello Helge,
> Hello Lu,
>
> On 4/30/26 08:01, yaolu@kylinos.cn wrote:
>> From: Lu Yao <yaolu@kylinos.cn>
>>
>> Don't need to do suspend/resume for fbcon in graphic mode. 
>
> Do you still have the possibility to test this issue?
>
Yes, I  still can test this issue.Do you have any other items to test?
>  
>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>> ---
>>   drivers/video/fbdev/core/fbcon.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index b0e3e765360d..450e690d0bd2 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -2602,8 +2602,9 @@ void fbcon_suspended(struct fb_info *info)
>>           return;
>>       vc = vc_cons[par->currcon].d;
>>   -    /* Clear cursor, restore saved data */
>> -    fbcon_cursor(vc, false);
>> +    /* Don't need to clear cursor and restore saved data in graphic mode */
>> +    if (vc->vc_mode != KD_GRAPHICS)
>> +        fbcon_cursor(vc, false); 
>
> I think checking for "== KD_TEXT" is probably better.
> And, maybe using con_is_visible(vc).
> So:
>
> +    if (con_is_visible(vc) && (vc->vc_mode == KD_TEXT))
> +        fbcon_cursor(vc, false);
>
It seems more reasonable. I'll submit a new patch soon.
>
> Helge 
Lu Yao
