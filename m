Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726ED606A332
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O8yOG7EC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FE010EE45;
	Mon, 16 Nov 2026 09:27:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C2D10EE14
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794821256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UeghsTiOb4ju5n7zGZ1nHsTM034u6BwVxNZLSRJoYfw=;
 b=O8yOG7ECcm43MInd7H6L/X28k91eZ2Rd3+TGYWtLGMufYSscasJ7HrvM5gEEtfbQ5mDBH7
 uW7S+SG8Vc3T2cB75fu/m8+qpwQOLEsxNSHE3m3hsqXNoO3R8YAgzSvpwfvcDCYZGIiAgn
 /4aiUiZ4S71FmbYBdzaGVtSCbsXto0Y=
X-MC-Rep: binary re single
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-aZ9R4LWRO7WuosMpnoM7Cw-1; Mon, 16 Nov 2026 04:27:35 -0500
X-MC-Unique: aZ9R4LWRO7WuosMpnoM7Cw-1
X-Mimecast-MFC-AGG-ID: aZ9R4LWRO7WuosMpnoM7Cw_1794821254
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso18378635e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 01:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821254; x=1795426054;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UeghsTiOb4ju5n7zGZ1nHsTM034u6BwVxNZLSRJoYfw=;
 b=vHgNUxhwa6M18f6aJeISciJuIAZdReLtyHFJZNCt1AR6qI6zcGYzq/OqFVqPfkb/vY
 Emq2PENzP0Vg/p/rNxH5mNUj7CHD38G7X9Zh2v9lDBCHVF/gGeg5ngUBRUSoUQPkUtcs
 COGPMt85SxeIKw7aL2yieRY0cP9GNL8tayER1ADxoxU4ovaYAJswgqnB8RPUA9+nKep7
 M6zLmjxrrwfHhbwhOiUmQxVrmopw9odQr1iVw6V5h0az3rM8oQg8B5CvqmoZJgRE4yYj
 RCSrMJUQ9ZDGWb9juyz/9sIfoaeWlSRjcCkArV6riLfFZVsV8dwEjcxqKxCuYS/gDQmB
 4UUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH35OJm2kLEE62o4jUHaJ9ksjeAvav7G0PPVDwAcFWEsP0udqbTNvNZgD3x44QAMGCdPIopj3U2HJI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9UmNs0yfKzgwwFYSGn9X5Ablxhd9vjGMsMmCHUiOsfgrMAYLG2
 sVGOqain69Y5TtacmY3ch+tVK5eYlt5gN+CQUed0iG/OkHroaED/ITqKxHqHGb8oqI6y1Ej5HOj
 M+jeeLKdMqMlqsQ+yB0gep1KDNPiCVremNyXrMJz+1TrF+Eo4D837gG1its6IVMGNum39nA==
X-Gm-Gg: AYBFou1MErgTMnJfQZqJCJzWdNcMmJ5Yf0lcsb9J7wv8k7qB0+jxmDfoii+6LD/gkXs
 aUeSPLGBxJD8CuzDzJRR54//zuJKG4bVIh4a9mk9xIrZ5nK4IzpVslRttk9h/iV1f4b6R1G+ROX
 8WgdIRF33KphdmUH4Ba3yzrSGwrwA0SpVjUkiJ0luGm06zxZ/ykRkDdkZx01IO76j2kktUqyySW
 zXJmcj2a3YPXlQZf3qvvlwgcSmnd6R9nkhCsPhHMByaPTYzEsoDCtrVviKYAtoxpy3hbf9KRUBD
 pQ0njvFO/fk/lCiDvsSM5gdmKJ1KtKLdzH6eAcAsdJtiXtZP7Xh1Kaw8BBnEM43jFL/crHeDtjk
 Nyez2L+BzVD3mSh4omBYRng4G8Hj0lCP6KJafDJoQqPzLG7ry7m8Do6R7Fr4vtwiKTz8YkxeSyN
 +QOBp2tGWaiw9wx7jYkoTqSp+pmoNOdXmYq0h08dM=
X-Received: by 2002:a05:600c:3114:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4bb55a5de41mr207753995e9.21.1794821253832; 
 Mon, 16 Nov 2026 01:27:33 -0800 (PST)
X-Received: by 2002:a05:600c:3114:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4bb55a5de41mr207753235e9.21.1794821253228; 
 Mon, 16 Nov 2026 01:27:33 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb52bab8bbsm280128335e9.13.2026.11.16.01.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:27:32 -0800 (PST)
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
Subject: Re: [PATCH v11 07/12] drm/panel: add connector luminance forwarding
In-Reply-To: <20261103-superm1-backlight-property-v11-7-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-7-00cce7b2ba22@kernel.org>
Date: Mon, 16 Nov 2026 10:27:31 +0100
Message-ID: <xlv1qzglrurg.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -duhHSQAAG65n0xcsOU6Mf1uBzZYhdszhB5uWtCUNIw_1794821254
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
> Add helpers that expose a panel backlight through the connector
> LUMINANCE property and forward connector updates to the backlight
> backend.
>
> Hook the helpers into panel bridges that create their own connector.
> Panels consumed directly, or by a panel bridge attached with
> DRM_BRIDGE_ATTACH_NO_CONNECTOR, remain unchanged. Turning the backlight
> on and off is left to drm_panel_enable() and drm_panel_disable(), which
> already honour self refresh.
>
> The panel backlight remains the hardware backend and keeps its
> /sys/class/backlight device, which is owned by the backlight driver.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

