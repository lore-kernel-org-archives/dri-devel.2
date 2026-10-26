Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBF606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=K1zWyD5a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFDD10E0F9;
	Mon, 26 Oct 2026 18:57:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177F910E31A;
 Mon, 26 Oct 2026 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=fQo9kNtBhK6ou/kDtDR1zwtvqMc7GoPFTSxU7VhxlaU=; b=K1zWyD5a776NI1+6ZYyv5FMS4A
 zqeHkxFmLpHi7QdiixdCnB+I96t6WFQzjorh37nooEh3qU9Y/CZxg/cO2xCeDZnHHQ6C0YDgYUYLq
 6D8/7N4VkoM4IXGyECZm7vnJJwc3jQnG1lhCtjHtCwD5sjlvRF0V1Xb0sknWd46XySHUxr2X7cpRO
 uqtK9j5AnLe9AgJxmufPaJp/AKH25FJnt4svBYGbSwoP+fppVFJzmPednsx2hcEiKlGc2JMZq5BzC
 rJSRYYqIND+aHOu8CDpkkFDB0a23+s7kzEMgoluvOHwRO1R3dZ7nC+mhvjRdZjHjMmxiB/SbuDiRF
 GTNY0B6w==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xLPsy-00Azuf-Qj; Mon, 26 Oct 2026 19:57:33 +0100
Message-ID: <e076014e-b461-4e27-8220-709722b73ceb@Igalia.com>
Date: Mon, 26 Oct 2026 11:57:26 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add null DC check to hpd init
To: Albert Esteve <aesteve@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Mattia Tadini <info@mtsistemi.it>,
 Roman Li <roman.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, George Zhang <george.zhang@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Geoffrey McRae <geoffrey.mcrae@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20261022173154.2318054-1-John.Harrison@Igalia.com>
 <atsRYJ7XTBY987fr@aesteve-thinkpadp1gen8.rmtes.csb>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <atsRYJ7XTBY987fr@aesteve-thinkpadp1gen8.rmtes.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 00:48, Albert Esteve wrote:
> Hi John,
>
> On Thu, Oct 22, 2026 at 10:31:54AM -0700, John Harrison wrote:
>> A bunch of the KUNIT tests (dm_test_hpd_init_*) expect that the init
>> function can be called with adev->dm.dc set to null. Indeed, the
>> dm_test_hpd_init_fini_with_connectors test has a comment explicitly
>> saying that the null is intentional. Unfortunately, since the patch
>> mentioned below, the first thing that the init function does is access
>> adev->dm.dc->link_count. Thus it is a null pointer dereference and a
>> boom (at least if running with KASAN).
>>
>> I'm not sure if a null DC can ever occur outside of the KUNIT tests,
>> but there is presumably a reason for the KUNITs explicitly testing it.
>> So add a null check around the link_count loop.
> This feels backwards reasoning. The tests assume in comments that
> "a NULL dc that fallback is a safe no-op", which isn't true after
> commit e38159437a91. Also, in amdgpu_dm_init() the DC is created and
> checked, and if it is NULL errors out. Thus, DC is never NULL at
> amdgpu_dm_hpd_init() in production.
>
> The fix should be in the tests, maybe allocating a stub with
> link_count 0?
I was meaning the later comment "DC is absent (NULL), so the HW writes 
are NULL-safe no-ops.". To me that reads as the test is explicitly 
checking that a NULL DC is safe. Also, the 
dm_test_hpd_init_empty_connectors test says "init must complete without 
touching the DC". Which also seems to be saying that a null DC is a 
valid thing to happen and must be allowed.

If you are certain that there is never a possibility nor a reason for 
having a null DC in reality, then sure, the tests can be updated 
instead. This is not code I am especially familiar with - I'm just 
trying to run the tests to ensure that other changes don't break 
existing drivers. I just don't want to go removing test coverage simply 
because a driver change breaks a test - that is generally the backwards 
direction!

John.

> BR,
> Albert
>
>> Fixes: e38159437a91 ("drm/amd/display: only clear the hotplug sources the ASIC has")
>> Cc: Mattia Tadini <info@mtsistemi.it>
>> Cc: Roman Li <roman.li@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Alex Hung <alex.hung@amd.com>
>> Cc: George Zhang <george.zhang@amd.com>
>> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
>> Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
>> Cc: Leo Li <sunpeng.li@amd.com>
>> Cc: "Timur Kristóf" <timur.kristof@gmail.com>
>> Cc: Albert Esteve <aesteve@redhat.com>
>> Cc: Geoffrey McRae <geoffrey.mcrae@amd.com>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
>> ---
>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 26 ++++++++++---------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> index 5b4ff079cd55..427f7bba343d 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> @@ -989,18 +989,20 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>>   	 * has rather than over the whole enum: the unused slots of the DC
>>   	 * interrupt table hold dummy handlers that assert when touched.
>>   	 */
>> -	for (i = 0; i < adev->dm.dc->link_count; i++) {
>> -		const struct dc_link *link = adev->dm.dc->links[i];
>> -
>> -		if (link->irq_source_hpd != DC_IRQ_SOURCE_INVALID &&
>> -		    !amdgpu_dm_irq_set(adev, link->irq_source_hpd, false))
>> -			drm_err(dev, "Failed to clear hpd source=%d on init\n",
>> -				link->irq_source_hpd);
>> -
>> -		if (link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID &&
>> -		    !amdgpu_dm_irq_set(adev, link->irq_source_hpd_rx, false))
>> -			drm_err(dev, "Failed to clear hpdrx source=%d on init\n",
>> -				link->irq_source_hpd_rx);
>> +	if (adev->dm.dc) {
>> +		for (i = 0; i < adev->dm.dc->link_count; i++) {
>> +			const struct dc_link *link = adev->dm.dc->links[i];
>> +
>> +			if (link->irq_source_hpd != DC_IRQ_SOURCE_INVALID &&
>> +			    !amdgpu_dm_irq_set(adev, link->irq_source_hpd, false))
>> +				drm_err(dev, "Failed to clear hpd source=%d on init\n",
>> +					link->irq_source_hpd);
>> +
>> +			if (link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID &&
>> +			    !amdgpu_dm_irq_set(adev, link->irq_source_hpd_rx, false))
>> +				drm_err(dev, "Failed to clear hpdrx source=%d on init\n",
>> +					link->irq_source_hpd_rx);
>> +		}
>>   	}
>>   
>>   	drm_connector_list_iter_begin(dev, &iter);
>> -- 
>> 2.43.0
>>

