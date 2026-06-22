Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57D1CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D5210E9F3;
	Tue, 23 Jun 2026 08:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.b="Tdn9R6c3";
	dkim-atps=neutral
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F5E10E40F;
 Mon, 22 Jun 2026 01:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
 Content-Type; bh=u3ZmX/mjzL9Zl05VnH4RZ3rLeDtK6oQHdc6LujnLA90=;
 b=Tdn9R6c3y1nVFFiNKPjTCpU6hgPK9uN7+uduy6sAIRPMd3Ot+OzE9X8iBLcMBQ
 6lhSLBdpA560O6d7XihN2t05aQUS+xiy8qBs3kLNVTpzeprQY/+1NetBYuEO8uay
 Zp77BpSvVxvdbalgivW88TDj7vPAAQqKTEc/skE+/HduY=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wDnryQvkDhq+HghCA--.54830S2; 
 Mon, 22 Jun 2026 09:30:23 +0800 (CST)
Message-ID: <6A38902B.2080808@126.com>
Date: Mon, 22 Jun 2026 09:30:19 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To: Danilo Krummrich <dakr@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: lyude@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
 simona@ffwll.ch, airlied@redhat.com, ttabi@nvidia.com, 
 bskeggs@nvidia.com, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nouveau/gsp: Clean up IS_ERR vs IS_ERR_OR_NULL
 usage
References: <20260601095403.228220-1-zenghongling@kylinos.cn>
 <DJEQVST8KK4D.1DX65CF227WWC@kernel.org>
In-Reply-To: <DJEQVST8KK4D.1DX65CF227WWC@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnryQvkDhq+HghCA--.54830S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF48Kr15AFWDur4DJw1fZwb_yoWfXFg_Wr
 W7AayfJ3yIkFWDAr4qkF4aqFW2ga4kXr40v39a9wnI9FW7Zry3WrsIkry3Xrn7trZ29rna
 gFn8J39YgF17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8n2-5UUUUU==
X-Originating-IP: [112.64.161.44]
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrhDYqWo4kDAXrgAA3E
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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

   Hi Danilo,
                 I've reviewed Sashiko's feedback and she's absolutely 
right about the documentation issues. I will send the v3 patch, However, 
I want to clarify that these are pre-existing issues in the  code, not 
problems introduced by my patch series， Unlike the previous kernel 
panic  issue  that we identified and fixed.

   Thanks,
   Hongling

在 2026年06月21日 21:00, Danilo Krummrich 写道:
> On Mon Jun 1, 2026 at 11:53 AM CEST, Hongling Zeng wrote:
>> >Hongling Zeng (5):
>> >   nouveau/gsp/rpc: Document RPC function return value contracts
>> >   nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c
>> >   nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
>> >   nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage
>> >   nouveau/gsp: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd()
> There are a few more comments from Sashiko, did you check them?
>
> Thanks,
> Danilo

