Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B218A606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=PunTzMD2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0FD10FBB6;
	Wed,  4 Nov 2026 12:56:27 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27B010E772;
 Wed,  4 Nov 2026 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=CquK3h3bMLwexU22f2EYIG/a8fkTjnog139S4tmblkc=; t=1793796981; x=2109156981; 
 b=PunTzMD2G8KKB3YSuQjOdMsJjQ1K3fKYac99t1lGLv8d5vQKx0sej0yVmhhXLFQDIaErR9Mguo2
 Elfzi+Sw7hx7q82H6rBpZZ5vaZtHL1GzlyGZG9Tv2bwE+4q6wZ2GGCkgjMdRVsgZAyCT8wEPYnPAU
 wbqMEGCFnfGUKb/gMy0PRvpGqY1VJcfmL+xlCNpkE+Na+lNjeDZO5L+R2RmKuelpbc3z5hNzPviKU
 k3F3eQuXDbQdlqJuu1tmKhZbgFyewuVFvxWCzX9jhlHG3aU47fIEiWCV+WtP8mgiePgNiQdJTm/IY
 pSFYPE/BaHRDHRowWZgZQqO+/x0VAa7rNUbw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOaXL-002Gm5-19; Wed, 04 Nov 2026 13:56:19 +0100
Message-ID: <18165b2c-8e8b-4e5a-afec-0cc8b2a24fd9@igalia.com>
Date: Wed, 4 Nov 2026 12:56:18 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/sched: Reject double scheduler initialization
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20261104123441.34842-1-tvrtko.ursulin@igalia.com>
 <20261104123441.34842-2-tvrtko.ursulin@igalia.com>
 <f02d51dd1d0f72951f9860f2a23fa6b53bf4b0ab.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <f02d51dd1d0f72951f9860f2a23fa6b53bf4b0ab.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 04/11/2026 12:51, Philipp Stanner wrote:
> On Wed, 2026-11-04 at 12:34 +0000, Tvrtko Ursulin wrote:
>> There is no point in having code and logging whose only purpose is to
>> notify developers of incorrect usage of the API while bringing up a new
>> driver. Lets simply return an error and let the developers figure it out.
> 
> What's your merge plan here, were those branched out of the previous
> series? Is this a v2?

These three are independent from that series and since you don't like me 
sending bags of patches I've extracted these three to make a smaller 
bag. ;) They are all in drm_sched_init() and I don't see why they 
couldn't be merged decoupled from any other work.

Regards,

Tvrtko

> 
> https://lore.kernel.org/dri-devel/20261020154123.33631-4-tvrtko.ursulin@igalia.com/
> 
> 
> P.

