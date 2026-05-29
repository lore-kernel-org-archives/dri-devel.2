Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169EBCD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C1010FC07;
	Fri, 29 May 2026 09:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hdlkc/kD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F9C10FBEA
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4QvomIZ7N/3PW0p3XzzBEx6Q0edUNiqonPRYwYLAhl4=; b=hdlkc/kDTKID2X0CcxwMP22h6O
 QbH7D+fEs61Yd4Hf3gLK5sZtipCk03RAMg31lMh214SZwC/i26xguKy0zy6edRvtvAk/0drrvDa/L
 yJ8mw7sb5GceonU1pNN543YSrSU1ue3v4ODB8j/8oXLm6PkJO+ny/SI2BwqXt7z2rM1uyBhPkYO8c
 /d8XLxepW1luCpYexUMceBOg83bjeAHzuCanes+i6QU2UqcnmkYBnzbf++LGH5Egry4OUvEfjwR3x
 yuHumjDTT4SzM//7vc/mjMmyBPgfVHiLu9CK7c06a+ukv3aOWpb5gjFuErZB2AQ9qWgVhTNmBcE1K
 UBmXAOMg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wStfu-009nb1-K1; Fri, 29 May 2026 11:38:42 +0200
Message-ID: <92baad06-9502-4803-8ff8-ef147c1ce4d3@igalia.com>
Date: Fri, 29 May 2026 10:38:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Fix clang build warning in kunit tests
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, kernel test robot <lkp@intel.com>
References: <20260522090129.9385-1-tvrtko.ursulin@igalia.com>
 <23df1e8b17c4ba5a9106b84a65e092ebd54fee42.camel@mailbox.org>
 <f01ffd7e-7a20-496e-9a7a-0f75a500be0c@igalia.com>
 <8a65c09e-c03a-43ce-94af-cbf5c4fcef94@igalia.com>
 <db213e09d23fb2e3315059b9f3c2dd9d3b9bee4e.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <db213e09d23fb2e3315059b9f3c2dd9d3b9bee4e.camel@mailbox.org>
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


On 29/05/2026 10:20, Philipp Stanner wrote:
> On Fri, 2026-05-29 at 08:16 +0100, Tvrtko Ursulin wrote:
>>
>> On 28/05/2026 14:38, Tvrtko Ursulin wrote:
>>>
>>> On 28/05/2026 14:03, Philipp Stanner wrote:
>>>> Yo Tvrtko,
>>>>
>>>> On Fri, 2026-05-22 at 10:01 +0100, Tvrtko Ursulin wrote:
>>>>> Initializing compile time constant struct or arrays from another such
>>>>> variable is a gcc extension, while clang strictly requires a compile
>>>>> time
>>>>> constant literal.
>>>>>
>>>>> As reported by LKP:
>>>>>
>>>>>>> drivers/gpu/drm/scheduler/tests/tests_scheduler.c:675:10: error:
>>>>>>> initializer element is not a compile-time constant
>>>>>                                    drm_sched_scheduler_two_clients_attr),
>>>>>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>      include/kunit/test.h:224:13: note: expanded from macro
>>>>> 'KUNIT_CASE_PARAM_ATTR'
>>>>>                        .attr = attributes, .module_name = KBUILD_MODNAME}
>>>>>                                ^~~~~~~~~~
>>>>>      1 error generated.
>>>>
>>>> Hmm, is it now a build error, or a build warning? The commit title says
>>>> "warning".
>>>>
>>>> Depending on what it really is, where should it go, misc-next or misc-
>>>> fixes?
>>>
>>> Right, warning or error it depends if someone enabled CONFIG_DRM_WERROR.
>>>
>>> According to drm-misc commiter guidelines, since we are in -rc5, it can
>>> go to drm-misc-next.
>>
>> Now it's  drm-misc-next-fixes I think since Maarten sent the last
>> drm-misc-next pull request yesterday.
> 
> Acked-by: Philipp Stanner <phasta@kernel.org>
> 
> Feel free to do that as you see fit

Pushed to drm-misc-next-fixes, thank you!

Regards,

Tvrtko
>>>>> vim +675 drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>>>>>
>>>>>      671
>>>>>      672    static struct kunit_case
>>>>> drm_sched_scheduler_two_clients_tests[] = {
>>>>>      673
>>>>> KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_two_clients_test,
>>>>>      674                      drm_sched_scheduler_two_clients_gen_params,
>>>>>    > 675                      drm_sched_scheduler_two_clients_attr),
>>>>>      676        {}
>>>>>      677    };
>>>>>      678
>>>>>
>>>>> Fix it by using a compound literal as other tests do.
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202605220312.Pu7UO05u-
>>>>> lkp@intel.com/
>>>>> Fixes: 97ef806a5314 ("drm/sched: Add some scheduling quality unit
>>>>> tests")
>>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>>> ---
>>>>>    drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 12 ++----------
>>>>>    1 file changed, 2 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/
>>>>> drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>>>>> index 8b2e4ef9915f..90d31888cf92 100644
>>>>> --- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>>>>> +++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
>>>>> @@ -666,14 +666,10 @@ static void
>>>>> drm_sched_scheduler_two_clients_test(struct kunit *test)
>>>>>        }
>>>>>    }
>>>>> -static const struct kunit_attributes
>>>>> drm_sched_scheduler_two_clients_attr = {
>>>>> -    .speed = KUNIT_SPEED_SLOW,
>>>>> -};
>>>>> -
>>>>>    static struct kunit_case drm_sched_scheduler_two_clients_tests[] = {
>>>>>        KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_two_clients_test,
>>>>>                      drm_sched_scheduler_two_clients_gen_params,
>>>>> -                  drm_sched_scheduler_two_clients_attr),
>>>>> +                  { .speed = KUNIT_SPEED_SLOW }),
>>>>>        {}
>>>>>    };
>>>>> @@ -858,14 +854,10 @@ static void
>>>>> drm_sched_scheduler_many_clients_test(struct kunit *test)
>>>>>            drm_mock_sched_entity_free(client[i].entity);
>>>>>    }
>>>>> -static const struct kunit_attributes
>>>>> drm_sched_scheduler_many_clients_attr = {
>>>>> -    .speed = KUNIT_SPEED_SLOW,
>>>>> -};
>>>>> -
>>>>>    static struct kunit_case drm_sched_scheduler_many_clients_tests[] = {
>>>>>        KUNIT_CASE_PARAM_ATTR(drm_sched_scheduler_many_clients_test,
>>>>>                      drm_sched_scheduler_many_clients_gen_params,
>>>>> -                  drm_sched_scheduler_many_clients_attr),
>>>>> +                  { .speed = KUNIT_SPEED_SLOW }),
>>>>>        {}
>>>>>    };
>>>>
>>>
>>
> 

