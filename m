Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8A606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aq0OXytO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B6110EE68;
	Mon, 16 Nov 2026 09:28:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90B810EE68
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794821293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6O5L7vNOw9tqxoH8eLe9M+49Omq2w8inLzq+ECt/NxU=;
 b=aq0OXytO2XIzcNzvmfahi/9rpI50z0DzNN2TrGmUZCWjznPCtxMLm4GM8P/3fCosJDQWq7
 2z1F9pGKKNsxR6H+n/z37Uadi6LDXxz9ACA01SAHKlG0rik1/nKVCDmIJI6u9+naidI+Z1
 POeItnLl1wtoVhaRv1I8+9e6ZnNCV3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-7xPk8BUDPgmRFc8JqgiZ1g-1; Mon, 16 Nov 2026 04:28:11 -0500
X-MC-Unique: 7xPk8BUDPgmRFc8JqgiZ1g-1
X-Mimecast-MFC-AGG-ID: 7xPk8BUDPgmRFc8JqgiZ1g_1794821290
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1fdde384cso14122135e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 01:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821290; x=1795426090;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6O5L7vNOw9tqxoH8eLe9M+49Omq2w8inLzq+ECt/NxU=;
 b=HCgOjBfwwzqOSW7b33JkbTq1Tnn4yW3OB0cDBe1pMZTHV1tO6e+8/EFDP32F03RIx4
 kmDZniivfofgzxMI1An7b1n5EcrEYxpSzGPeT0RZU6jfo/cZ5HHiFD2qWeBNhEJxSqrp
 LnLHLy1tyNStKYpycLixlbao50/uozByoV8wwhqQyENd4E2DXP98PqqwNsQEsD8xn8vK
 KKkGsw1ZmmTYasoXqb1Py8JrO347dtjL3C9JcF3+OsvOd4OEsjtMAvYhJlm1jqMr3cR3
 dIDfRV5wm5fWgtkDNl9pWIXO5M/x9a/hbRT0t1myPBAyYzppkHX8cU7aGuzD/8UkOG/7
 e4fA==
X-Forwarded-Encrypted: i=1;
 AL+hErHs3oeK/ma1cZyv2yBdmF1rQlHxlgsFkxBMOSQ1p440C+otwPeqAzw5AX7J5rykcz6kgG2kaEJNvUQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9yTg3Fp1NwiEqYwHNW2hH7VdoSKnNLHy7Tt9M557q93QhIX5W5
 mTjRnHCwghoCgq5OwNJjBMiGOxMFqbHzk1WcMPDvy7KvOg5nIzlkqgPVAg7BZUewNCMrfKm51Mt
 9IGltfKMkWbtjpnC5xRvIt3qsykrFdgr0QLWTLiWnHgkRqmAJRZ2cPxc2QgaBs2blj+yi3A==
X-Gm-Gg: AYBFou0Jx4PIq6fuP75HqtVFQVHG5Q7EWVZL37JemoWQ0ZnswixDR0+t88tTI+w4nrP
 hhu+6ERmfyqG/Mn0dDtAZZW/A72D7ULS3VedOEAQV5VBcMWjc3eZFm2LwtuYPtHM1mi8iIxw7sj
 JuEtC6VMi8qy4H4P5bET2mweqCIykJMGJmWP19hHl5wDi67Hu7UCPSW1VlPUrO0utTmIeDTb6mD
 dXceg9c7dMKItuEFVLQFuxaArf63MMvMSZ5YhzbYJOg6jpfJ6+vQanXhGQm6wMMFinJKVySsulk
 Cz3zwmL/V6ow5AqrNlGxKNpvSIJHMB5zY4WEwbYyA5R7H5RdeYYFyPG1/Nj92nSOOxRgVkAQKo3
 IDXDHokP7N1B2hANttTmANwCoxA4kMREaGks7ATH1Zz9Y0hQcq+9YbTx+pg67dIYN4+V9zvX7Wf
 hinlaUnURE1VIpcWj7978NrT/ZIr9V8BaeDIHtl0c=
X-Received: by 2002:a05:600c:1993:b0:4bb:659c:b8db with SMTP id
 5b1f17b1804b1-4bb659cb9e8mr125481935e9.12.1794821289818; 
 Mon, 16 Nov 2026 01:28:09 -0800 (PST)
X-Received: by 2002:a05:600c:1993:b0:4bb:659c:b8db with SMTP id
 5b1f17b1804b1-4bb659cb9e8mr125481505e9.12.1794821289312; 
 Mon, 16 Nov 2026 01:28:09 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5720f6basm139362015e9.4.2026.11.16.01.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:28:08 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Jani
 Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, Xaver Hugl
 <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 08/12] drm/bridge_connector: add luminance support
In-Reply-To: <20261103-superm1-backlight-property-v11-8-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-8-00cce7b2ba22@kernel.org>
Date: Mon, 16 Nov 2026 10:28:07 +0100
Message-ID: <xlv1o6bpruqg.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 38OEBVCmeBdFrlTtL2fySbhnEQWVpyS8BymKfn8j6RE_1794821290
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Mario Limonciello (AMD)" <superm1@kernel.org> writes:

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Discover the last bridge in a chain that owns brightness control, attach
> its relative luminance range to the connector, and forward atomic
> luminance updates to it.
>
> Do not infer panel luminance support from a terminal panel bridge. Panels
> still have direct consumers, so their connector integration must remain
> explicit.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

