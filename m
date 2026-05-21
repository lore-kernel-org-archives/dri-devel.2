Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93229CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEBC410E4E5;
	Thu, 21 May 2026 14:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ECLexoX1";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D036E10E4E5
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779372786; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SUgO5ws+tBCQT0WUk7m9OqeJjuGaW9dgACsBugEeSGB/2yv/hd2RPPhqWyIrZpSZWHz8XuyQ6sq1by8NhxDzH9YZCntv6mGJ62Sv0A8ZuWYwNyXLUme5mZI0Xuf1ykgrTGQtgarodgrnh3dvc5T5LZmORNpvsYmeMhHc7Ru9Igw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779372786;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=0/jNls64NPl5dO+bgmH5gGf2lVDbjs1vLBYMfjIcFiE=; 
 b=dDOb6h1o7But23QhSbbufq3ToVD3Mk1xgTm5gnpXAfNV7X1BSALI6u8gId5eCa5e7c7wSLDbIscUBJLjiKXISrCYH2NC386gmEZm3mvxXorWhtLkA/rSuEK1sJYtUYy2lhjrbDBHPNPgIJtsAOSU60HnjkGuR1qoXJP7OuYWihs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779372786; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=0/jNls64NPl5dO+bgmH5gGf2lVDbjs1vLBYMfjIcFiE=;
 b=ECLexoX1PJgsNwPtsE/KzzkpHtOtvzyR5q1qdJ6eoFiNkvaVHHQfGwDOuyYYQqFT
 ANvO1RXy9D27Zus2E588s/2b5Bksz8fSlxbvtqIskrFnssGo8kGzah2Vp5QuTBBqr4x
 Lz5U7EbrnpEERhmv/BKjasoFQXchurUzHa3VrtJE=
Received: by mx.zohomail.com with SMTPS id 177937278357391.36330198048734;
 Thu, 21 May 2026 07:13:03 -0700 (PDT)
Message-ID: <9e5063e8-99ba-4e33-b3e6-03656928c475@collabora.com>
Date: Thu, 21 May 2026 17:13:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] drm/virtio: Add support for saving and restoring
 virtio_gpu_objects
To: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
References: <20260429204729.993669-1-dongwon.kim@intel.com>
 <20260429204729.993669-3-dongwon.kim@intel.com>
 <4ec04daf-9665-4b15-9e62-b83eb9aaa7c9@collabora.com>
 <PH0PR11MB5112A54866C6888080137302FA002@PH0PR11MB5112.namprd11.prod.outlook.com>
 <8ff5d9cd-62bc-4136-af00-96acd3a2c07f@collabora.com>
 <PH0PR11MB511260F7209810CD9569E696FA002@PH0PR11MB5112.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <PH0PR11MB511260F7209810CD9569E696FA002@PH0PR11MB5112.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

On 5/19/26 21:28, Kim, Dongwon wrote:
> Hi Dmitry,
> 
>> Subject: Re: [PATCH v8 2/3] drm/virtio: Add support for saving and restoring
>> virtio_gpu_objects
>>
>> On 5/19/26 03:23, Kim, Dongwon wrote:
>>>> Can virtio_gpu_remove_from_restore_list() be moved to
>>>> virtio_gpu_cmd_unref_resource()?
>>> Yes, technically it can be done and we can remove some redundancy but
>>> don't you think adding it or removing it from the list would be better
>>> to be handled outside of vq functions (virtgpu_vq.c) where actual
>>> communication messages are processed?
>>
>> cmd_unref() indeed isn't a good fit
>>
>> Could you please check if list node can now be removed from
>> virtio_gpu_cleanup_object()? IIRC, there was a problem with that in older patch
>> versions.
> 
> Yes, you are talking about patch v7 where removal of the node was done in virtio_gpu_cleanup_object().
> You actually mentioned this at that time,
> 
> " Also, looks wrong to delete object's node from the list by the
> virtio_gpu_cleanup_object() that is invoked from cmd-completion callback. You calling virtio_gpu_object_unref_all() that walks up obj_restore_list while obj already may be in process of async unref'ing?"
> 
> Your concern was valid so I moved node removal right before cmd unref call in v8 (the latest so far).

Thanks for the reminder, let's keep it as in this patch then.

-- 
Best regards,
Dmitry
