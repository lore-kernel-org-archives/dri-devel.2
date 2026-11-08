Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB448606A320
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=D68bcTxb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D66B10E065;
	Sun,  8 Nov 2026 09:16:05 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382A510E065
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 09:15:58 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-372bdb942dbso2055eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 01:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794129358; x=1794734158; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8omgzCyD7VFzEverpSEwRPa7kgr/SLHtu8LlPuCGKek=;
 b=D68bcTxbVU/Qce1FZ1mrmhzCmZC75YxyaO0O6krvMPBZ9nkq8w8wf7giMtpn+xMB/x
 ec0EY6pFNpY9a0zT1CGPJxUbc0BY0AQxVoKU28kheQU8yCer4fDJ2QmytQLzlFXCrD2+
 P0ARNeDKAMYmPdsvEyCrI61P+9WUv3HxTB418=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794129358; x=1794734158;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8omgzCyD7VFzEverpSEwRPa7kgr/SLHtu8LlPuCGKek=;
 b=ZXN9b5ctFyQi51yyCTLFjwDYn5r45gRFPxSG6PGZURpJf4XNv0IEZLuGIgvvu/Ripq
 b03OSN3AvktCidTauX67Le3KrZ8RZOs2jAAkthogYKHanS21qZYB8PyaRYDOBpbM6mPR
 2VNwoRNZoLo7xPLKylBhNZAaNGxWp4j1DZI/hbVddumIbnhaqPLoqygFUuJcivVcq2Ak
 ggylkMbnoE5teaa0ZghvAXEtN4K1gTxqfoDGaxxgvaITtwIWOvL51YJnEpa/AALS2ecF
 KpgCZXgStTfKNU4/1fvVBPEyX1lKQ2W7wl70Onl0BLMm01gz9AD+wEaVKaHaHALvUV9Y
 MT+g==
X-Forwarded-Encrypted: i=1;
 AL+hErGfClU2CQqoVks4FFUGMpVQR0NfH4XELlFL54mguyhs5g7elUxQZKS37GVjAKkbV4UHQhFJ+8FrR34=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8n8LelQj/7MVyVukT25i5O/W1u8J02cHQvydvZK72XO9A64jCR
 S8bw1z+aqb2ehFbjfJm5tXHF1vkS6I8AfTgwe+Mf1R+XgoVB+FdfAI8Tl6ttO7fo1YU=
X-Gm-Gg: AYBFou0zYbLcAJkr3g2oqxWm8Y+Pzx4tYQusepjECROmslMO62M2pZa4WDJoRQjY2VX
 KLMe1wSvjLRSM5LpCEZjKNRObFsYOyc80/XdL0Sa50ghyAa0/xHIozYbny95FRMWqCO2GrhJ3zU
 SZjue9ioHqTNywEnKufVltnajeYYeCz4aqRxMaycvhl++tJGlQpR14gPCm4B9QQlM6VaPQfYSbD
 a/ns7JmfvflBlQR8zziFdwPOC/Z3C4kjWVTXUOYb6RlqhujLbpVMUK0yPS4a5jT376sd6YWcg41
 NNNkhPcR9UCROWftx2KM4yDMY+9k68ewaOlOxkUNBF0W2l0Vv5389Mo52gUGHqtgAEcPuyBrjX4
 8szKRIppnw1CuayQzVa1YlvwFLKYohwn26PdvpkY9SSl8Ko7kEgAiMlIc7JwKNU9vDTz04ekRc/
 nu/FHAY+p5iujSEPUdvsWEnTh0ML8O25p6Nj6tivFa6EnWpofERis3YUVUwJfvQoB8NFPKe6vUM
 u9oG3VpHeaQ35MAyfxOAU6xjhYPVDTt5UZvgtLGccFTy/ILbGmjo74IpghqJ5YGN8qdZ0fNIVn0
 KDdDR2Nhi7FwJ7oUqK3/OBAVY3HM2NMiEsgBDNiAtjtNotQVz5viFzwFyI722yXAosipgCHPv7b
 IQlif+ib/aAw=
X-Received: by 2002:a05:693c:6009:b0:36a:43d9:f2a5 with SMTP id
 5a478bee46e88-372576c22c7mr2293561eec.32.1794129357942; 
 Sun, 08 Nov 2026 01:15:57 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265a179c1sm3728933eec.11.2026.11.08.01.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 01:15:57 -0800 (PST)
Date: Sun, 8 Nov 2026 18:12:40 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: Re: [PATCH 4/7] drm/sched: Remove the single scheduler special case
Message-ID: <avA9ACE9ar1MEdtD@rock-5b-plus>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-5-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106145702.61640-5-tvrtko.ursulin@igalia.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 02:56:59PM +0000, Tvrtko Ursulin wrote:
> @@ -139,7 +141,10 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>  	entity->guilty = guilty;
>  	entity->last_user = current->group_leader;
>  	entity->num_sched_list = num_sched_list;
> -	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
> +	if (num_sched_list == 1)
> +		entity->sched = sched_list[0];
> +	else
> +		entity->sched_list = sched_list;

This breaks rocket. rocket_job_open() passes a kmalloc'ed array of
rdev->num_cores schedulers, and rocket_job_close() does
kfree(entity->sched_list). With only one core bound when the file is
opened (e.g. the other cores probe later), the union now holds
&rdev->cores[0].sched, so close kfree()s a pointer into the devm
allocation. Before this patch it was kfree(NULL) (and the array leaked).

I can send a rocket fix that keeps its own pointer to the array and
frees that instead, so it can go in before this patch, unless you'd
rather carry it in this series.

Thanks,
Sidong
