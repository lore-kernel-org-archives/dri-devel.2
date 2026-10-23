Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490E606A322
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OdEI9KTG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3B610E5B8;
	Fri, 23 Oct 2026 07:49:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA421129E3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792741734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPEhZ0F8mNaXZvduezb9h2CNrDMhxs3LW/WRILiGKpk=;
 b=OdEI9KTGmLeXo0MZefCACWi+tOOw8k6DtQ2SM933y38spz13IarBLidPNMv52LbEQQG1aB
 JeLoYAjBCMyrMjhhBUhF2BBQovYCYUTciWlUbX07HR4cIZIvmgHgv0f/UFaijDYXHQsUHT
 /WLHZWVeO6pmYLKkRVytuLQ8ygTEph8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-5DD-ulLTNKaC7ZIrdz3V4g-1; Fri, 23 Oct 2026 03:48:51 -0400
X-MC-Unique: 5DD-ulLTNKaC7ZIrdz3V4g-1
X-Mimecast-MFC-AGG-ID: 5DD-ulLTNKaC7ZIrdz3V4g_1792741730
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48dfa054f26so442311f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 00:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792741730; x=1793346530;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nPEhZ0F8mNaXZvduezb9h2CNrDMhxs3LW/WRILiGKpk=;
 b=qS809HmzCXz1lAGT0rXPg5KQ4Bd4q4Gi3f4KgGXRbzR96j3NoCdUQHKM93iLjwYkKt
 TciHTwm24LGGzi6aaEfnkK7DCq/rKLLU68NR9g1KseJvSvxPmNwopR+HYj/D6vGC4vSx
 1jMtW2Vtpqrm6SKcsemdddcSiho++vE87hAI0n7t+/PmZ73jVEiqUEaJib6s7ycgukFs
 cdR1eneMf/Bm9noTc29vEyyPFxbJ86CpYQCqv0zC64Yjj1bcNuWyNHeEkwh6YzYY7AiM
 OxCgsKRqWA92H10+aeRjB/YmuAqZ0gxS5g1/BcYQJsE8O0Z48ImFYnxzNl4/G04dw1LY
 gJcA==
X-Forwarded-Encrypted: i=1;
 AKwUvByOPuFpFEzv43O4ndNgvY5RW3FK1heg+gv/iT2OflrCIMWpu/FKUqK/BWN7jfDQtoJtbmESjJYGuAc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIy/kDRiK8PcInVJolNLr083Q+UJaDK6YnB+xIzyjqG6iA0Xcmp
 94yd4Xw7m8LZfBhwM8eMI7bIKkql1TWO3smwBMe1+j9S02LVh4+LUe/pCR66Yq1R5qxT+QTdkNW
 t+xSDDt/I8jCKgdSbc8CuGFUBZziZGMkQ68zNREX3h54SUHLqa1kIemRGhfYxbZeMZzCc1A==
X-Gm-Gg: AYBFou33tiOQ7ErtM84jDZbGSK+nJSwpaLomR+fLVUDEEy48lHq/UNmA0UQbh7ROvjr
 Dv11t+ESgpLwAN170XdECfaEGEIqR7rNC01UyRktjVIiXmIJ2AvfPk46m6rIrpS4FeFs9541Vje
 bGfgns9rQpvnHsVCau3DWV3Tc+GLC2ygcbC2Fi7EnLrOnIcmD1eAjGYUC6OEAASe2A+/3WcFCri
 D4zbtvk5yZ0VJ/NAIY174l3kEkZxnVVFn2q43bbmQPBOKuQ8PITZi9NGJXyp05fXIBlUllcYyJC
 K0MV6pXdG8BHCaDt2IzrNFZVj1r4dsK5CTys+IyP3ttTqRH0RGTK1GXYO/Ppr5DwtnE=
X-Received: by 2002:a05:6000:188b:b0:487:2387:7c9 with SMTP id
 ffacd0b85a97d-48e385891c3mr2127733f8f.14.1792741729798; 
 Fri, 23 Oct 2026 00:48:49 -0700 (PDT)
X-Received: by 2002:a05:6000:188b:b0:487:2387:7c9 with SMTP id
 ffacd0b85a97d-48e385891c3mr2127700f8f.14.1792741729316; 
 Fri, 23 Oct 2026 00:48:49 -0700 (PDT)
Received: from localhost ([46.6.57.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e380571c8sm3395873f8f.45.2026.10.23.00.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 00:48:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:48:48 +0200
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
Message-ID: <atsRYJ7XTBY987fr@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261022173154.2318054-1-John.Harrison@Igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022173154.2318054-1-John.Harrison@Igalia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YcXxVkvbW7xlEu9dc-b8OcyyXHwOaewiRJYm5yC_1Ss_1792741730
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

Hi John,

On Thu, Oct 22, 2026 at 10:31:54AM -0700, John Harrison wrote:
> A bunch of the KUNIT tests (dm_test_hpd_init_*) expect that the init
> function can be called with adev->dm.dc set to null. Indeed, the
> dm_test_hpd_init_fini_with_connectors test has a comment explicitly
> saying that the null is intentional. Unfortunately, since the patch
> mentioned below, the first thing that the init function does is access
> adev->dm.dc->link_count. Thus it is a null pointer dereference and a
> boom (at least if running with KASAN).
> 
> I'm not sure if a null DC can ever occur outside of the KUNIT tests,
> but there is presumably a reason for the KUNITs explicitly testing it.
> So add a null check around the link_count loop.

This feels backwards reasoning. The tests assume in comments that
"a NULL dc that fallback is a safe no-op", which isn't true after
commit e38159437a91. Also, in amdgpu_dm_init() the DC is created and
checked, and if it is NULL errors out. Thus, DC is never NULL at
amdgpu_dm_hpd_init() in production.

The fix should be in the tests, maybe allocating a stub with
link_count 0?

BR,
Albert

> 
> Fixes: e38159437a91 ("drm/amd/display: only clear the hotplug sources the ASIC has")
> Cc: Mattia Tadini <info@mtsistemi.it>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: "Timur Kristóf" <timur.kristof@gmail.com>
> Cc: Albert Esteve <aesteve@redhat.com>
> Cc: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 5b4ff079cd55..427f7bba343d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -989,18 +989,20 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>  	 * has rather than over the whole enum: the unused slots of the DC
>  	 * interrupt table hold dummy handlers that assert when touched.
>  	 */
> -	for (i = 0; i < adev->dm.dc->link_count; i++) {
> -		const struct dc_link *link = adev->dm.dc->links[i];
> -
> -		if (link->irq_source_hpd != DC_IRQ_SOURCE_INVALID &&
> -		    !amdgpu_dm_irq_set(adev, link->irq_source_hpd, false))
> -			drm_err(dev, "Failed to clear hpd source=%d on init\n",
> -				link->irq_source_hpd);
> -
> -		if (link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID &&
> -		    !amdgpu_dm_irq_set(adev, link->irq_source_hpd_rx, false))
> -			drm_err(dev, "Failed to clear hpdrx source=%d on init\n",
> -				link->irq_source_hpd_rx);
> +	if (adev->dm.dc) {
> +		for (i = 0; i < adev->dm.dc->link_count; i++) {
> +			const struct dc_link *link = adev->dm.dc->links[i];
> +
> +			if (link->irq_source_hpd != DC_IRQ_SOURCE_INVALID &&
> +			    !amdgpu_dm_irq_set(adev, link->irq_source_hpd, false))
> +				drm_err(dev, "Failed to clear hpd source=%d on init\n",
> +					link->irq_source_hpd);
> +
> +			if (link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID &&
> +			    !amdgpu_dm_irq_set(adev, link->irq_source_hpd_rx, false))
> +				drm_err(dev, "Failed to clear hpdrx source=%d on init\n",
> +					link->irq_source_hpd_rx);
> +		}
>  	}
>  
>  	drm_connector_list_iter_begin(dev, &iter);
> -- 
> 2.43.0
> 

