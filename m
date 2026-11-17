Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B1606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=pu+Mir/Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5EB210F6E9;
	Tue, 17 Nov 2026 13:05:08 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610D010F6E8;
 Tue, 17 Nov 2026 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=n6HkqSF10bURKOsP5CULCmCv2THN5gLbHs22Jjv2txE=; t=1794920702; x=2110280702; 
 b=pu+Mir/Y3txcd0phioFrzqOlvraBRBgH4y8+8sSHblIBhkWo5FS2zwdTzZSMtFASDlsDLAzREMA
 Ov4HhpHWqIfSLfCVwG4li9fzTj7BjIZ0ABpljM82AluDxA7Gxip2WoEAyAbtKJb2T7vV59iFSRnpY
 233XpL7HzdDBW5fWATB1/19U1VTMndOZBiXBuuknUpj/dJyJQmo1LNxcoCcf0dPS14OlrqUmPdQwN
 MtTtGkXJuxtL1Dp9DQ/QYzrRpDf8927q063Oj2tEz53AmhNI8/MqjuJgpT7Qa6njReXOdnrVWmce7
 ymHSI9BlIvcvEsfjIs0cTNCza6H8cKSSKTKg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xTIrs-00000000ayW-1VNp; Tue, 17 Nov 2026 14:05:00 +0100
Message-ID: <91f421df-4753-4e63-8bc6-daea85c6bb35@igalia.com>
Date: Tue, 17 Nov 2026 13:04:59 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/sched: Ignore stopped entity attempt to change
 its run-queue
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-3-tvrtko.ursulin@igalia.com>
 <fd86312b062767e3434573064aeb267721c7a4f6.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <fd86312b062767e3434573064aeb267721c7a4f6.camel@mailbox.org>
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


On 17/11/2026 11:53, Philipp Stanner wrote:
> On Tue, 2026-11-17 at 10:06 +0000, Tvrtko Ursulin wrote:
>> Jobs submitted to a stopped entity do not go anywhere due how they are
>> handled in drm_sched_rq_add_entity() so there is no point to allow them
>> to change their run-queue.
> 
> Who stops an entity?
> Who submits to a stopped entity?
> Isn't entity_select_rq only called for drm_sched_job_arm()?
> Who's arming jobs for an entity that he has stopped himself?

I extracted this change as separate patch on your request during a 
conversation back in June.

But it is not really required, even less so since I abandoned the 
removal of entity_idle. The only way race could happen if it drivers did 
crazy things.

I can drop it no problem.

Tvrtko

