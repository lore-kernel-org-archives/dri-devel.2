Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDD3CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F0010E755;
	Mon,  1 Jun 2026 09:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S8YPXwfz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44BC10E18B
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 09:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L6XPT/pU31Y1afSilvCFB7Yb+ExUBczIilxhk0dt7jU=; b=S8YPXwfztTNfaEDGINIDzk7pS6
 jd/k/6wSqn0ub5D5m3ENZUByQP/8PsCKIhvt+L14lF2gcQQfT1/HBZISSlzIxJnkCo9j4ZtOAv3lX
 aDYsRosjMIrA4mdArsfTN63EfFFsU/nIqUVoKEliKmtRcGHdpIH9SYbV0Nh3xpWp8fCoHOI5M7wpX
 pm4kJDfyqILLp4uHbsix3e8xhM4bk/G5OkH/75184tMLJdU+5zzETEdbW8VT/STmhyGKWi/7Dy30B
 cu2lhaxrjhiE3OuXuwv7L6iyzY0ZZZ2Nf69TlxBIUHsfT2EeVRU+NaRKzFFfb7MzcLME/8bRVfKE1
 EdJsvCAA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wTyfF-00AuHX-Mu; Mon, 01 Jun 2026 11:10:29 +0200
Message-ID: <6bbcb4c1-f629-4a6a-b001-f9df5f0e8fea@igalia.com>
Date: Mon, 1 Jun 2026 10:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/todo: clarify drm_syncobj error TODOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 michel.daenzer@mailbox.org, dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260601085132.683087-1-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260601085132.683087-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 01/06/2026 09:51, Christian König wrote:
> Before I get another mail asking if somebody is already working on this
> clarify that the kernel parts are already implemented and we only need
> the userspace parts done.
> 
> Add Michel as additional contact since he wrote a really good summary
> how that could potentially be used by compositors.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   Documentation/gpu/todo.rst | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index f5a6139356da..f85c4585750d 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -896,10 +896,11 @@ complection of submission.
>   One minor feature still missing is a generic DRM IOCTL to query the error
>   status of binary and timeline drm_syncobj.
>   
> -This should probably be improved by implementing the necessary kernel interface
> -and adding support for that in the userspace stack.
> +This was already improved by implementing the necessary kernel interface
> +(patches are on the dri-devel mailing list ) but adding support for that in the
> +userspace stack is still missing.
>   
> -Contact: Christian König
> +Contact: Christian König, Michel Dänzer
>   
>   Level: Starter
>   

Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Might be worth adding a lore link to aid finding it in the future and 
fix the stray space while pushing.

Regards,

Tvrtko

