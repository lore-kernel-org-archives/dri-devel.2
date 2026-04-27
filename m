Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06148FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365BF10E5DB;
	Mon, 27 Apr 2026 07:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MleD5Bdm";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FBF310E5D9
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777275775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZsz7GDMLjRf7lMOmxPPUPIqtgmaEkl8/fhXr102fLk=;
 b=MleD5Bdm2y6pULfHC2/3lA0KvhKrPfINDx7965iEthfS2tQb9dUUw/fdFtRbT9V0dxiLBt
 IpJmfO5m5bHwP0Fe3Thy1UaBnsm697s8T294egxPb7ABXi98JG7Y1zdc/er3kuVsvRKYXf
 GurhwGsafCKnTXtmB9+UhMRj5a7POsU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-rFC3CvBpPmqgZWg---6SRA-1; Mon, 27 Apr 2026 03:42:53 -0400
X-MC-Unique: rFC3CvBpPmqgZWg---6SRA-1
X-Mimecast-MFC-AGG-ID: rFC3CvBpPmqgZWg---6SRA_1777275773
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8e8950b3ee1so2635743685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777275773; x=1777880573;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xZsz7GDMLjRf7lMOmxPPUPIqtgmaEkl8/fhXr102fLk=;
 b=baRc3MtwgavIDYendHjjpTmqIx58um9fK9FL+XSkm+lXxbN/WkuCh+m8Rk9Qno6L+U
 6hIGBmOzNO/3hiihclJ3xptpaHbLw42Wo1FVBczomcc2RNrYScGZJ9/t3QlJ7G3XM4VL
 o9gnoyWDZGhfTvkW2QtLrfxBPxX/jg13cMttBvlF2J6lb0XKFRBVTFxk8SQq6MrLmpAh
 BjFtVcNQxTihRZanW0Aa3c3bEkVqrv9G/6gOQ8VeTdC3gAVw6Rn/WstrMaA17SjtXhkz
 68R77FfpUGyJoyyO9FylxbcxooO3vBhpRO8+2FpiEFEMQAQ7QV0FR6jp26deXvH0l5L8
 ZRNw==
X-Gm-Message-State: AOJu0YyXZE8JdTaCVq1tzKwZ4gtfkh1Eb111I49gyyLAesa+mfaXY443
 RGeelh5D2imaUxijLkah15dIhEVAub3g6GgoQ71TXhH39rwil4/iDYOzqj0JuI0tbPVmbmLS9Sq
 BCRDSZdOCzkxu62UGvOIiqWmyz4i8ikoPOylrPtS+Sz+826rhoUgs7XxUevYINF6q7wlYMA==
X-Gm-Gg: AeBDietGnd5yAnDYppqPCapVBzt2ipHq7TB8t1vF6C6rTs0XXdstcIJhgSdCtqr/uH+
 /1L3Bt8wmbSWudaS5hqwoz5VvVSfJU3sNx5cTL8kQ63P0889DCrAUUgP2opWwCP6DExuEko59I+
 V0dyAiLlDgniXqlxK9uha0FPqoVK+wgISBnFF3nx9m3KjCbV8vGMVRuScZasIRD0qlgXCRUyorP
 NFSI91IgQhWkx80N3AYIM6C5hVDChMuUpgafJtA8aRXTXV/xuPLwYPisSiD3Paq5SJTXPMmt7s+
 yffohYDmh8SANUiS3VHYPO3iO+L1z8YVijOk+ZAC/1DVWMrkV95d/z8us8NBOTSDPGbzpRJ0JP+
 uSL4KuCqUIO2XBlh8DjFYsAK1m9AV8qHYDWXfcAMamuOL89bIX8iJxIYLRI0=
X-Received: by 2002:a05:620a:1720:b0:8ef:ba6:1a4e with SMTP id
 af79cd13be357-8ef0ba6262fmr3528548585a.31.1777275772976; 
 Mon, 27 Apr 2026 00:42:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:8ef:ba6:1a4e with SMTP id
 af79cd13be357-8ef0ba6262fmr3528546885a.31.1777275772581; 
 Mon, 27 Apr 2026 00:42:52 -0700 (PDT)
Received: from localhost ([149.6.131.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe9638sm2571871085a.1.2026.04.27.00.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 00:42:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/5] drm/sysfb: efidrm: Support power management
In-Reply-To: <20260408120722.328769-3-tzimmermann@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
 <20260408120722.328769-3-tzimmermann@suse.de>
Date: Mon, 27 Apr 2026 09:42:50 +0200
Message-ID: <871pg0yhl1.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UC3YVZOUUmI5xh0u6BZB2I_m5MJom1zG1kN7t3GVEKs_1777275773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Set PM ops for the efidrm driver. Suspend and resume the DRM state
> on systems that support it.
>
> Many systems lose the hardware's framebuffer settings on suspend,
> hence resuming doesn't work there. Yet some systems, most notably
> emulators, keep the hardware state across suspend/resume cycles.
> There, DRM's suspend and resume helpers bring back the display on
> resume.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

