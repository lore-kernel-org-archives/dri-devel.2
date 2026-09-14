Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D630C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F5110E037;
	Mon, 14 Sep 2026 13:33:17 +0000 (UTC)
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B0A10E14E
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:33:15 +0000 (UTC)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 9F15A1EAB66; Mon, 14 Sep 2026 21:33:12 +0800 (AWST)
Received: from [IPV6:2001:8003:8802:7000::9c4] (unknown
 [IPv6:2001:8003:8802:7000::9c4])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id B86DF1EAB5E;
 Mon, 14 Sep 2026 21:33:08 +0800 (AWST)
Message-ID: <097243a3-a75c-434e-b215-47a94e8677d2@davidgow.net>
Date: Mon, 14 Sep 2026 21:33:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Increase drm_mock_sched_job_wait_finished
 timeout when CONFIG_HZ=100
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, kunit-dev@googlegroups.com
References: <20260913084155.520015-2-david@davidgow.net>
 <b4f017cc-3dbf-416c-b456-0c19d2f0647a@igalia.com>
 <0ce1883f-7de3-4a16-82f0-c8950459163e@davidgow.net>
 <f570ea7f-164c-4232-85d8-14604baca607@igalia.com>
 <26926372f9d375e1741b16abd2a910f3754a0410.camel@mailbox.org>
 <f86fafc7-3e42-47b2-aca7-e0b4be56b699@igalia.com>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <f86fafc7-3e42-47b2-aca7-e0b4be56b699@igalia.com>
Content-Type: text/plain; charset=UTF-8
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

Le 14/09/2026 à 8:12 PM, Tvrtko Ursulin a écrit :
> 
> On 14/09/2026 12:48, Philipp Stanner wrote:
>> On Mon, 2026-09-14 at 12:21 +0100, Tvrtko Ursulin wrote:
>>> It's not a loss really to
>>> skip the scheduling quality tests on more platforms than strictly
>>> required so I'd say lets go with that.
>>
>> Does that mean you agree with my idea of having two options for
>> building the tests, one for sanity and one for performance-ish things?
> 
> A new kconfig? Makes sense.

This sounds good to me (particularly if it's likely to extend to more
than just the two tests).

If they're behind a separate kconfig, there's no need on my end for
these tests to support UML or other HZ=100 setups (though I don't think
it's a _bad_ idea to have a more friendly skip or error in that case if
you'd particularly like one).

Thanks very much,
-- David
