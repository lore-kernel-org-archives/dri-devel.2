Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB5606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HJWT1wOo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CAC10F2C7;
	Tue, 27 Oct 2026 08:06:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8532010F2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793088399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfmt4Rc5J4gF2KexiwvuKzoZFNtTnsgovk9um/e8UYE=;
 b=HJWT1wOo+c5XA90GV3L4R89iJiuuqKCGwSsj6sHBJ3it39rl7lCk0vxPjdY9ADJ0LdsfQq
 yTekCcyzw6sysPgLzIFYvSYjZhWkJIyyq1BS+EAuW3975/5LLNvG1O9tet0n5CNgv/XWTu
 R+qm+t+TOhMU+T302C+tzJ7engZjgi4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-iPEDIyB_O2KoebfRu4gkXQ-1; Tue, 27 Oct 2026 04:06:32 -0400
X-MC-Unique: iPEDIyB_O2KoebfRu4gkXQ-1
X-Mimecast-MFC-AGG-ID: iPEDIyB_O2KoebfRu4gkXQ_1793088391
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b0a199b20so3413044f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 01:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793088391; x=1793693191;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vfmt4Rc5J4gF2KexiwvuKzoZFNtTnsgovk9um/e8UYE=;
 b=L1mKEf12nYxJm2QjMhO/WctLLE9v0jIiTGv+U53EEES0+Hq/am7gOZF1ACyjOH+V+9
 LgKFohBCGu80wTzrg/j784Y3zBss+p1MHc93L+HM7gu8pnDCqZCn56DpLhbwIK39k2Eo
 isWaqt4J7+z2x4M9CFA0beeqgDhy9ejolpC11C5h+AXIYDb4zkPFRZEtnFeW5+o+gqWP
 MmUFpJq1AvRS9G+bN1pcRvgeWz55Hy4z2Ll3KBDgrBOfMpuP3r/57AkRQ7SP2J1sjAqS
 erWaVVtFJ6tiF+sp7gpCUDky1E1kbX4ogipt/XTMX3wtgXtBC/TP4EbkVbjJEn1QGSg/
 QJfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNezugJLdz+e55oTYfq515jOije6lPYaLfkTgefLU63vRyy7WkZt0fWUdDlECBOL4ZSM1qMRx2F+E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIlFLkmY27Mj2E5T1z/BlrYPDkaIV522wfHhAFrYPjio+Bd8j1a
 tNbpYN1wwSzhFRDRKlhwi9LTTxxxV7mVdB8Foq8dLUXjF8WeomHXK/st86BoMwj1qbOayN9rGUG
 av6u4mbP1XVBJ4GxX+zjURXPzCLPE727WS62o2A3XX8ZfEXsPaN9PHWdkGw/r1ZVZz7n8ew==
X-Gm-Gg: AYBFou1HjdtDUYuycdpu7EqLjV5oLzNfUfA1ILukYsUt+lses17hd31rRBjCTnevTlk
 n0LBUGI5Lrsnio09p2zKaHKo5bOKtNFkPmfKmxCfL2h3XUC0rPVnB/KpsObNI/Rd0sCeKKFmcc6
 QlmkPAiMc27zB9UlC6WDqlojI/kT0ktEqfDNVhMSq8kTXRZsQSwQpWkGjbzVCwUoGrZ3Chj5zX2
 dSrFZTCcv2e+KcvIP3t0qnRfIRhBugB7lENmOxqcaP0aOgKFbTjcq5OMhODSF/VyxRRVCr1wkX1
 hQ5CYaLwqXVewQLRmuUWZ2oZBCE9LXQBfAxfuLSDcz2g2x0/pr1YZH7B2DLo4llPR9U=
X-Received: by 2002:a05:6000:27c9:10b0:48e:1299:663f with SMTP id
 ffacd0b85a97d-48e3ebbc92bmr12279659f8f.56.1793088390985; 
 Tue, 27 Oct 2026 01:06:30 -0700 (PDT)
X-Received: by 2002:a05:6000:27c9:10b0:48e:1299:663f with SMTP id
 ffacd0b85a97d-48e3ebbc92bmr12279608f8f.56.1793088390519; 
 Tue, 27 Oct 2026 01:06:30 -0700 (PDT)
Received: from localhost ([46.6.57.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd47basm23211838f8f.32.2026.10.27.01.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 01:06:29 -0700 (PDT)
Date: Tue, 27 Oct 2026 09:06:28 +0100
From: Albert Esteve <aesteve@redhat.com>
To: John Harrison <John.Harrison@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Mattia Tadini <info@mtsistemi.it>,
 Roman Li <roman.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, George Zhang <george.zhang@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Leo Li <sunpeng.li@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Geoffrey McRae <geoffrey.mcrae@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add null DC check to hpd init
Message-ID: <auBbhHo5SQNt_jK9@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261022173154.2318054-1-John.Harrison@Igalia.com>
 <atsRYJ7XTBY987fr@aesteve-thinkpadp1gen8.rmtes.csb>
 <e076014e-b461-4e27-8220-709722b73ceb@Igalia.com>
 <ee303a21-32f9-42ed-a351-35a23d6de202@Igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ee303a21-32f9-42ed-a351-35a23d6de202@Igalia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ui5CuttrOn8xcKffzKPcbqslJCd0RwY6_ooWYYJTfQk_1793088391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 01:16:34PM -0700, John Harrison wrote:
> On 10/26/26 11:57, John Harrison wrote:
> > On 10/23/26 00:48, Albert Esteve wrote:
> > > Hi John,
> > > 
> > > On Thu, Oct 22, 2026 at 10:31:54AM -0700, John Harrison wrote:
> > > > A bunch of the KUNIT tests (dm_test_hpd_init_*) expect that the init
> > > > function can be called with adev->dm.dc set to null. Indeed, the
> > > > dm_test_hpd_init_fini_with_connectors test has a comment explicitly
> > > > saying that the null is intentional. Unfortunately, since the patch
> > > > mentioned below, the first thing that the init function does is access
> > > > adev->dm.dc->link_count. Thus it is a null pointer dereference and a
> > > > boom (at least if running with KASAN).
> > > > 
> > > > I'm not sure if a null DC can ever occur outside of the KUNIT tests,
> > > > but there is presumably a reason for the KUNITs explicitly testing it.
> > > > So add a null check around the link_count loop.
> > > This feels backwards reasoning. The tests assume in comments that
> > > "a NULL dc that fallback is a safe no-op", which isn't true after
> > > commit e38159437a91. Also, in amdgpu_dm_init() the DC is created and
> > > checked, and if it is NULL errors out. Thus, DC is never NULL at
> > > amdgpu_dm_hpd_init() in production.
> > > 
> > > The fix should be in the tests, maybe allocating a stub with
> > > link_count 0?
> > I was meaning the later comment "DC is absent (NULL), so the HW writes
> > are NULL-safe no-ops.". To me that reads as the test is explicitly
> > checking that a NULL DC is safe. Also, the
> > dm_test_hpd_init_empty_connectors test says "init must complete without
> > touching the DC". Which also seems to be saying that a null DC is a
> > valid thing to happen and must be allowed.
> > 
> > If you are certain that there is never a possibility nor a reason for
> > having a null DC in reality, then sure, the tests can be updated
> > instead. This is not code I am especially familiar with - I'm just
> > trying to run the tests to ensure that other changes don't break
> > existing drivers. I just don't want to go removing test coverage simply
> > because a driver change breaks a test - that is generally the backwards
> > direction!

I am as certain as the code exploration allowed me to be, which means to a
limited extent... Also, not wanting to remove test coverage is a
valid point. I mean, to me changing production code just because a test
needs fixing tickles my spidy sense so I questioned it...

> > 
> > John.
> I'm finding more and more tests that explicitly test a null DC. Also, a stub
> DC with a link_count of zero is not sufficient. All the IRQ code goes boom
> trying to configure interrupts because dc->res_pool->irqs is
> dc->[null]->[null]. Hacking up a fake res_pool and a fake irq structure
> would presumably be possible but then the driver will be attempting to
> enable interrupts in a non-hardware kunit test. I haven't gone further than
> that to see if anything else goes boom with a partial DC yet.
> 
> It seems like trying to force a fake DC is an unravelling thread that will
> mean a lot of changes to a lot of tests and maybe to the driver too.
> 
> As the driver currently stands, the tests explode with null pointer
> dereferences. Fixing up the one patch that broke a fundamental requirement
> of so many tests by adding a simple null-pointer check and returning the
> original functionality seems like a sensible first step. We get the test
> coverage back with no real downside to the driver. If the people that really
> know this code want to do a more involved fix then that is up to them to
> decide how it should be done.

... but you are right here. Checking for NULL is a defensive check with no
real downside. Plus all the problems you raised with changing the test.
Thanks for exploring that further.

Reviewed-by: Albert Esteve <aesteve@redhat.com>

Thanks!
Albert

> 
> John.
> 
> > 
> > > BR,
> > > Albert
> > > 
> > > > Fixes: e38159437a91 ("drm/amd/display: only clear the hotplug
> > > > sources the ASIC has")
> > > > Cc: Mattia Tadini <info@mtsistemi.it>
> > > > Cc: Roman Li <roman.li@amd.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: Alex Hung <alex.hung@amd.com>
> > > > Cc: George Zhang <george.zhang@amd.com>
> > > > Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> > > > Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
> > > > Cc: Leo Li <sunpeng.li@amd.com>
> > > > Cc: "Timur Kristóf" <timur.kristof@gmail.com>
> > > > Cc: Albert Esteve <aesteve@redhat.com>
> > > > Cc: Geoffrey McRae <geoffrey.mcrae@amd.com>
> > > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > > Signed-off-by: John Harrison <John.Harrison@Igalia.com>
> > > > ---
> > > >   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 26
> > > > ++++++++++---------
> > > >   1 file changed, 14 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git
> > > > a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > > > index 5b4ff079cd55..427f7bba343d 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > > > @@ -989,18 +989,20 @@ void amdgpu_dm_hpd_init(struct
> > > > amdgpu_device *adev)
> > > >        * has rather than over the whole enum: the unused slots
> > > > of the DC
> > > >        * interrupt table hold dummy handlers that assert when touched.
> > > >        */
> > > > -    for (i = 0; i < adev->dm.dc->link_count; i++) {
> > > > -        const struct dc_link *link = adev->dm.dc->links[i];
> > > > -
> > > > -        if (link->irq_source_hpd != DC_IRQ_SOURCE_INVALID &&
> > > > -            !amdgpu_dm_irq_set(adev, link->irq_source_hpd, false))
> > > > -            drm_err(dev, "Failed to clear hpd source=%d on init\n",
> > > > -                link->irq_source_hpd);
> > > > -
> > > > -        if (link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID &&
> > > > -            !amdgpu_dm_irq_set(adev, link->irq_source_hpd_rx, false))
> > > > -            drm_err(dev, "Failed to clear hpdrx source=%d on init\n",
> > > > -                link->irq_source_hpd_rx);
> > > > +    if (adev->dm.dc) {
> > > > +        for (i = 0; i < adev->dm.dc->link_count; i++) {
> > > > +            const struct dc_link *link = adev->dm.dc->links[i];
> > > > +
> > > > +            if (link->irq_source_hpd != DC_IRQ_SOURCE_INVALID &&
> > > > +                !amdgpu_dm_irq_set(adev, link->irq_source_hpd, false))
> > > > +                drm_err(dev, "Failed to clear hpd source=%d on
> > > > init\n",
> > > > +                    link->irq_source_hpd);
> > > > +
> > > > +            if (link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID &&
> > > > +                !amdgpu_dm_irq_set(adev,
> > > > link->irq_source_hpd_rx, false))
> > > > +                drm_err(dev, "Failed to clear hpdrx source=%d
> > > > on init\n",
> > > > +                    link->irq_source_hpd_rx);
> > > > +        }
> > > >       }
> > > >         drm_connector_list_iter_begin(dev, &iter);
> > > > -- 
> > > > 2.43.0
> > > > 
> > 
> 

