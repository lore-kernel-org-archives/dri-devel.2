Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD17C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49FA10E823;
	Mon, 29 Jun 2026 10:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="ZqMU3iUY";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28CC10E823
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782730665; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BkbVJITAPwQFXs4/u1JEeOTsThTOX8pta7Hs269NmF1osUGplm2ETC/4iCRcef3v78nYA5q/OvfF2rF0punO9mWg1mxD4U0bc6LKhStWcg+WSkwUKaBSdPWBV6cahI/fugEQz+JfnoJ9phZoTidwtXnoKZM2EIeXUlIqpX9yqkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782730665;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=19RTSflVgvo88/yrwDtItoGYw5ZjSN4k4EfVGh02NZw=; 
 b=W4AMf1Pfq/mIDeCeebNKBB5+7+fhNhEyzFaKVyr5xCTKv6lLFKijKlqsjnrVSEEDvv/ttsn65qpRu4Vj4Q3WzdxNUUL7xR/hglpJuZbWuG2aJXkbV9XXgqBKg4EsnYgKOJ0TE1EOqzp0dw1d2tRQOBnMTF0HD5jWQFE0zfpljp4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782730665; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=19RTSflVgvo88/yrwDtItoGYw5ZjSN4k4EfVGh02NZw=;
 b=ZqMU3iUYJkhAZ/vvAnqVZvpXeh64LctSdwWaS6o8MAvEbdABNvaei7WWS1BLD8ew
 QqI3FGU5xowVAru1AQ6FsyCtLRgirYvZZfAFYezIDbhDrryHPX/hZTwC1CiL6svBlaZ
 IeDtCfHVMA9L2mSvme8uEKntLEpBSN4YsQsyl5PU=
Received: by mx.zohomail.com with SMTPS id 1782730664166322.5930790747236;
 Mon, 29 Jun 2026 03:57:44 -0700 (PDT)
Message-ID: <bc41095d-8956-4c3e-8f99-f4bda41f81e7@collabora.com>
Date: Mon, 29 Jun 2026 12:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20260627105725.9083-1-robert.mader@collabora.com>
 <CABXGCsPHdi3=Tpg2uZhZMuLNmg8r9Bg=OgD39eyMc=pv8gc_TQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <CABXGCsPHdi3=Tpg2uZhZMuLNmg8r9Bg=OgD39eyMc=pv8gc_TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Mikhail,

On 27.06.26 13:11, Mikhail Gavrilov wrote:
> Hi Robert,
>
> Thanks for catching this. You're right -- with DMA_ATTR_SKIP_CPU_SYNC
> in get_sg_table(), the first begin_cpu_udmabuf() call no longer gets
> the implicit CPU sync that the dma_map path used to provide, and the
> explicit sync in the old else-branch only ran when ubuf->sg already
> existed.
>
> The fix correctly moves dma_sync_sgtable_for_cpu() so it runs in both
> cases. The logic looks right to me.
>
> This wouldn't reproduce on x86 since DMA is cache-coherent there
> (dma_sync_* is a no-op), which is why I missed it -- it only matters
> on non-coherent architectures. My apologies for the regression.
>
> Reviewed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

thanks for the quick review! And no worries, I was very happy about your 
patch, which is why I looked deeper into it in the first place.

Given the patch fixes a newly introduced regression (and is very 
simple), do you think there's a chance to still get it into 7.1 - or 
would it need to go via the usual 7.2/7.3 release schedule + backport?

Best regards

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

