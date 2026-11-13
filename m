Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71A606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=PSVkmRd0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1333B1124CD;
	Fri, 13 Nov 2026 10:44:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474DC1121F6;
 Fri, 13 Nov 2026 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:From:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=oNu/GGyFXmG2cPr4/KkzstC9nJlwlOT32BbxZz3vwmw=; t=1794566654; x=2109926654; 
 b=PSVkmRd088+LQzeZAaT4qbdk/REcYiB/I1FfIcXmRovoZ0HbUISh0MJkrbtfRiTC7Qv1FODIu2D
 8A+E3t8RiUuM1+6SCoIrxdB38xt2VK4BuI4h/M/cIN6e9waPec71Nrtq/AzZ5N35ASgDOn+ZSe1DR
 LAdRiszmYifMhVKXJLqVie6kbZo1uu+0ndzX/VwlvGCkQLkL4iesNk/Vmz95dhze0GEVwMNdokCwB
 5/W0S3V/0wtXaEk6Vz/AghCqGdInjUvc92HVTBaW9zIlJaGyKNk7mXgqwlYO01qMrb90Eo67akPRp
 yvbZZuO/22d2yrV4P4sO25+i9LgeXE33HoEQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xRolP-00A8oZ-OP; Fri, 13 Nov 2026 11:44:11 +0100
Message-ID: <aff2d7c2-8da8-46be-8130-7addb8ac0853@igalia.com>
Date: Fri, 13 Nov 2026 10:44:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/sched: Reject double scheduler initialization
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20261104123441.34842-1-tvrtko.ursulin@igalia.com>
 <20261104123441.34842-2-tvrtko.ursulin@igalia.com>
 <f02d51dd1d0f72951f9860f2a23fa6b53bf4b0ab.camel@mailbox.org>
 <18165b2c-8e8b-4e5a-afec-0cc8b2a24fd9@igalia.com>
Content-Language: en-GB
In-Reply-To: <18165b2c-8e8b-4e5a-afec-0cc8b2a24fd9@igalia.com>
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


On 04/11/2026 12:56, Tvrtko Ursulin wrote:
> 
> On 04/11/2026 12:51, Philipp Stanner wrote:
>> On Wed, 2026-11-04 at 12:34 +0000, Tvrtko Ursulin wrote:
>>> There is no point in having code and logging whose only purpose is to
>>> notify developers of incorrect usage of the API while bringing up a new
>>> driver. Lets simply return an error and let the developers figure it 
>>> out.
>>
>> What's your merge plan here, were those branched out of the previous
>> series? Is this a v2?
> 
> These three are independent from that series and since you don't like me 
> sending bags of patches I've extracted these three to make a smaller 
> bag. ;) They are all in drm_sched_init() and I don't see why they 
> couldn't be merged decoupled from any other work.

Gentle ping on these three. I think it's good to reduce the number of 
allowed init combinations and remove some then and now pointless log 
messages from the codebase.

Tvrtko



