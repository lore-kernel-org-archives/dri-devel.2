Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E6ECD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 07:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1745E10E666;
	Wed, 27 May 2026 07:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.b="f0HJJt3d";
	dkim-atps=neutral
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Wed, 27 May 2026 02:04:14 UTC
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24F810E21E;
 Wed, 27 May 2026 02:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
 Content-Type; bh=DRewvKHciVqU5Ur9lYxZwRFH8ppi1XJT7zMqz7YMBqM=;
 b=f0HJJt3dRyCyor0k//LxRNSYqgvbW6y809cBfnZneVWcy1CfqQ5id2M27vo7Ly
 60Rt8YIlw3wnh0LS8YWxvVWbTR1e3pJMBHJAk9niZoPFJWrKInJaio8j24jROcNV
 dlejU61ZIxsHex6UsnAJ8JguMfXy/hkf1M/ALRt+6pGe0=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wCXTMNJTxZq_66AAQ--.59386S2; 
 Wed, 27 May 2026 09:56:25 +0800 (CST)
Message-ID: <6A164F51.7010203@126.com>
Date: Wed, 27 May 2026 09:56:33 +0800
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
Subject: Re: [PATCH] nouveau/gsp: fix NULL pointer dereference in r535
 nvenc/ofs alloc
References: <20260526014721.13299-1-zenghongling@kylinos.cn>
 <DISMY2BS8E1D.Q85V8DKCPM1C@kernel.org>
In-Reply-To: <DISMY2BS8E1D.Q85V8DKCPM1C@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXTMNJTxZq_66AAQ--.59386S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4Utw47KF1xWr1rCFy5XFb_yoW8Aw15pa
 y7ur1Yyr1qyrWxKasrW3WrZw1ru34fWFyrur1rWa1DZF90yFyxZrW2qr47Za4jka1rGa10
 qrWfAa40vr1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjksgUUUUU=
X-Originating-IP: [112.64.161.44]
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoAoG1moWT0qxrgAA3c
X-Mailman-Approved-At: Wed, 27 May 2026 07:24:11 +0000
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

Thank you for the feedback. You're right.

  After tracing through the call chain:
nvkm_gsp_rm_alloc_get()
     └─> r535_gsp_rpc_rm_alloc_get()
         └─> r535_gsp_rpc_get()
             └─> r535_gsp_cmdq_get()
                 └─> kvzalloc()

  r535_gsp_cmdq_get() returns ERR_PTR(-ENOMEM)
   on allocation failure, not NULL. So NULL is never actually returned.

   I found a similar issue in sunrpc where IS_ERR_OR_NULL() is actively 
harmful -
   PTR_ERR(NULL) would return 0 (EOF), masking real errors. This 
confirms the pattern
   you identified.

   Should I submit a patch to clean up the IS_ERR_OR_NULL() checks in:
   - nvkm_gsp_rm_alloc_get() / nvkm_gsp_rm_alloc()
   - nvkm_gsp_rpc_rd()
   - All the callers

   Or would you prefer to handle this differently?

   Regards,
   Hongling


在 2026年05月26日 21:16, Danilo Krummrich 写道:
> On Tue May 26, 2026 at 3:47 AM CEST, Hongling Zeng wrote:
>> nvkm_gsp_rm_alloc_get() can return NULL as well as error pointers.
>> The current code only checks for error pointers with IS_ERR(), which
>> would lead to a NULL pointer dereference if NULL is returned.
>>
>> Fix by using IS_ERR_OR_NULL() instead of IS_ERR(), matching the
>> pattern used in nvkm_gsp_rm_alloc().
> There was a similar patch [1] a while ago for another callsite. I replied:
>
> 	Are we sure that this can ever return NULL in the first place? I know
> 	that nvkm_gsp_rm_alloc_get() internally checks for IS_ERR_OR_NULL(), but
> 	I couldn't find anything within the callchain that would actually return
> 	NULL.
> 	
> 	That said, I think IS_ERR_OR_NULL() checks are misleading.
>
> Is there a real case where NULL can be returned? If not, let's remove the
> IS_ERR_OR_NULL() throughout the whole chain instead.
>
> [1] https://lore.kernel.org/lkml/20260418071412.86022-1-sunliming@linux.dev/

