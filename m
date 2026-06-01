Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C6ACD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA5910EA04;
	Mon,  1 Jun 2026 22:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.b="SQuf0+UC";
	dkim-atps=neutral
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E03E10E64F;
 Mon,  1 Jun 2026 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
 Content-Type; bh=GpqjxkI6HTsNPXTHknXZXvJU5tQpuWx9d1v/8ydLUPY=;
 b=SQuf0+UC/7nFo/+HlOKZzqH/gWx8d2ASi+g6yJSc2qaaqNMhs2D3lo8Q0xEGyS
 KJ7estbu2mNLl6XsvrrXb6gI5cvKxsBxXbyDyXeWoXbv+2a1QjIZZghL8FDWf2xM
 vtD1tFTW73rY9CLYQseJxjUPcMKyU+iVUp0re0P8YQQcE=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDn106zVx1q+XTYAg--.13632S2; 
 Mon, 01 Jun 2026 17:58:12 +0800 (CST)
Message-ID: <6A1D57B9.6000504@126.com>
Date: Mon, 01 Jun 2026 17:58:17 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To: Danilo Krummrich <dakr@kernel.org>
CC: =?UTF-8?B?5pu+57qi546y?= <zenghongling@kylinos.cn>, 
 Timur Tabi <ttabi@nvidia.com>, "lyude@redhat.com" <lyude@redhat.com>, 
 "rongqianfeng@vivo.com" <rongqianfeng@vivo.com>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "kees@kernel.org" <kees@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Zhi Wang <zhiw@nvidia.com>, 
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIIDAvNV0gUmV2ZXJ0IGNsZWFudXA=?=
 =?UTF-8?B?cyBmb3IgSVNfRVJSX09SX05VTEwoKSB1c2FnZQ==?=
References: DIULSRTZPQ0H.39RB5RF1NTFYA@kernel.org
 <823rnittrvj-82932fejdy8@nsmail8.2--kylin--1>
In-Reply-To: <823rnittrvj-82932fejdy8@nsmail8.2--kylin--1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn106zVx1q+XTYAg--.13632S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4xJw13WFWrury8Jw4rGrg_yoWrWFW7pw
 13K3yqka1qkF93tFy2va1rA3WfAr4fKF48uas3ta9xZw15XF9xJF40qF1Y9a4rCr4rua1j
 q39FgFWrZw1DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5PEfUUUUU=
X-Originating-IP: [112.64.161.44]
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrxTktWodV7Q1eQAA3y
X-Mailman-Approved-At: Mon, 01 Jun 2026 22:13:44 +0000
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

   I apologize for the confusion with my previous patch submission. 
Please disregard the  patches I submitted earlier.

   I have now regenerated a v2 patch series following your requirements 
to properly document return value contracts and clean up IS_ERR_OR_NULL
   usage.

   Return value analysis:
   - r535_gsp_msgq_peek(): Never returns NULL
   - r5sp_msgq_recv_one_elem(): Never returns NULL
   - r535_gsp_msgq_recv(): CAN return NULL (when RPC length invalid)
   - r535_gsp_msg_recv(): CAN return NULL (queue drained/no matching 
message)
   - r535_gsp_rpc_get(): Never returns NULL
   - r535_gsp_rpc_handle_reply(): CAN return NULL (NOWAIT/NOSEQ policies)
   - r535_gsp_rpc_send(): CAN return NULL (via handle_reply)
   - r535_gsp_rpc_push(): CAN return NULL (via handle_reply)

   I've been careful to only clean up IS_ERR_OR_NULL() for functions 
that actually never return NULL, while preserving the checks for functions
   that can return NULL (like r5_gsp_msg_recv() and r535_gsp_msg_recv()).

   Could you please review if this approach is correct?

   Thanks,
   Hongling



在 2026年05月29日 17:40, 曾红玲 写道:
>
> Hi Danilo Krummrich:
>
> like this?
>
>  1. r535_gsp_msgq_peek(): ERR_PTR on error, valid pointer on success, 
> never NULL
> 2. r535_gsp_msgq_recv_one_elem(): ERR_PTR on error, valid pointer on 
> success, never NULL
> 3. r535_gsp_msgq_recv(): ERR_PTR on error, valid pointer on success, 
> never NULL
> 4. r535_gsp_msg_recv(): ERR_PTR on error, valid pointer on success, 
> NULL for queue drained or no payload
> 5. r535_gsp_rpc_get(): ERR_PTR on error, valid pointer on success, 
> never NULL
> 6. r535_gsp_rpc_handle_reply(): Depends on policy, can return NULL
>
> TKS!
>
>
>
>
> *主   题：*Re: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
> *日   期：*2026年05月29日04:48
> *发件人：*Danilo Krummrich
> *收件人：*Timur Tabi,Danilo Krummrich
> *抄送 
> 人：*lyude@redhat.com,rongqianfeng@vivo.com,airlied@gmail.com,kees@kernel.org,simona@ffwll.ch,dri- 
> devel@lists.freedesktop.org,Zhi 
> Wang,nouveau@lists.freedesktop.org,airlied@redhat.com,maarten.lankhorst@linux.intel.com,tzimmermann@suse.de,linux-kernel@vger.kernel.org,mripard@kernel.org
>
> On Thu May 28, 2026 at 10:23 PM CEST, Timur Tabi wrote: > On Thu, 
> 2026-05-28 at 21:44 +0200, Danilo Krummrich wrote: >> >> @Timur: I do 
> think cleaning this up is the right call in general though, and I >> 
> also don't think that the whole driver necessarily needs to be 
> consistent on >> whether IS_ERR_OR_NULL() or IS_ERR() is used -- it 
> depends on the context >> (although I usually prefer not to mix up 
> NULL and ERR semantics in the first >> place). >> >> It should however 
> be consistent in terms of what functions can actually return. >> >> 
> ret = foo(); >> if (IS_ERR_OR_NULL(ret)) >> return ret; >> >> If foo() 
> can never return NULL, the above is misleading, as it puts an >> 
> obligation on the caller to somehow handle the NULL case and come up 
> with an >> actual error code for it. > > Sure, I get that. My point is 
> that it's often not clear whether foo() actually can never return > 
> NULL. > > It's been a while since I've dug through the RPC call chains 
> in Nouveau, so my memory is a little > hazy here. I do remember 
> noticing that Nouveau frequently has situations where foo() call 
> bar1() > and bar2(), where bar1() can return NULL but bar2() can't. So 
> the question is not whether foo() can > return NULL, it's whether 
> bar1() should not return NULL, or whether bar2() should. If there are 
> multiple, it has to be the superset of course. >> So, I think it is 
> the right call to align that to what functions can actually >> return, 
> but while doing this, the contract should be properly documented, such 
> >> that subsequent changes can be properly validated. > > "Properly 
> documented" and "Nouveau" are not two things that go together. 
> Unfortunately -- but the changes submitted by Hongling can add the 
> documentation for the places that are touched. @Hongling, can you 
> consider this in a v2 please? Thanks, Danilo
>
>
> ---
>

