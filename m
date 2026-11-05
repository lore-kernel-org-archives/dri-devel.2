Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA546606F977
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBQt/1Pt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237B9112896;
	Thu,  5 Nov 2026 15:55:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46AD11290F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793894107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2AwBFO4JiuQ/FV/CMMmSCfjX/nAyzoMuTgXb5GZYKk=;
 b=FBQt/1PtKetof1TCf9mfxFV5OFSqFszQjXLV4mnJn0fEXM6vDexWgoSG202xcG/K0oRPsv
 /eCvG794Ez0dcJtOvKadYdU91GQBVc9GvXPAxPuXmIT6ntBh6vOW97A9bW+piJKrMzD0An
 a6/cDIngQaZUF3wbGgM5ha/QI3hpUrk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-dIi_Cf0VMTuLDI7M2jWI7w-1; Thu, 05 Nov 2026 10:55:04 -0500
X-MC-Unique: dIi_Cf0VMTuLDI7M2jWI7w-1
X-Mimecast-MFC-AGG-ID: dIi_Cf0VMTuLDI7M2jWI7w_1793894103
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so23301485e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894103; x=1794498903;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e2AwBFO4JiuQ/FV/CMMmSCfjX/nAyzoMuTgXb5GZYKk=;
 b=cjZiu6MeqlBLyoXRv4StiicMNxvKH8t4VNvb6ZeowudSdteJn1NilxgDIlBTvFsfgO
 +zT5e0EAlu89LrjZO42+cjfeBAm6Mh/Sjaluw5wJuK5/StLPCcd61pI9HMCTq/yKabvP
 eG8OPthU1ICkxvWyU/B5n7149jrIL0zrNgKkS/KwyXaqapH/5QKu1D/CCs84vKpEev5o
 nrEf9r1DWiuZMAg2YjyRodNQC9WokmKv2lX7pM8Xfdp+5LQL1T35C1cFvwI3+VRFKqEC
 VOuzVYELuuAGOmhdC6tUAqyTO47ZtNNymgRul7IbbEOhK/PazzsDeXRnliI/pK5myMgk
 g+9A==
X-Forwarded-Encrypted: i=1;
 AKwUvByEPYDyjFoEbZ4z9d3ZZI/ksrmEHub2hqO2c7EQU0RogFH2j3c+7fb9dTIycBFjtac2j0JDPCUzK/o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+EYg7hPQ7QA497bt94JAB5nviFUrx0jjn8Td/5XRcdCpCd0vfX
 h6hWEnLQOxVfPmUcs5J3TBMrl9SK8Yb8lB4pNMHMv5XNwO0urynozpysC8rdTE4Cb0IC7MdDjKN
 Pr9E5uSGK2GfEJRiNKnK6GSDlS3sjIu+UqWbk9eDYgxsfakOelY6ayu1ZplML5TBvICvGCFxwqk
 3zUQ==
X-Gm-Gg: AYBFou1ytqrhV0Qt1t67UXT6HO5l59Ehb9eWPHXsyNYoRPmIJaZOEKd9jINanwkxtzB
 O6SVVVpRMzoqMpiNHKhz3QG6p+bs60rAqbmQkgpZEdMOq4HIilItDT3+YIjlv7btLf8GC3rk0AQ
 ZSoZFlrrr9d4oxEPfvRTBntQL9820hyzu3CGwq6jcfQ40aGgFmyF07IgD34SGSw8tAmaqXVaFPG
 piJVPwC5o+DhLMTTGE6B7VTeHfUww8gorw8Fhm7WxunsbqgMGbyJZ8bOzoehonx7mBI6cEqvhWn
 RzXwZbV+GLEAHsgVjknv6U+hOfzTQPXBedTmE70k9wt/oczTjHGUoEssQRSKIOaerttvv7/AXis
 6xx5Q/OuG6lrfeDZKNum6d0/+i7oIr9OHOi3JNjkZqYJvtPYG7pq0AvFYjsWk7z9+86OI9bteLU
 IJ4p5UF/T6iMmMOSThllW1HSFa5oV3mB9wAcGHItg=
X-Received: by 2002:a05:600c:8b55:b0:4a1:f736:79f3 with SMTP id
 5b1f17b1804b1-4ac17ffb30fmr422209245e9.5.1793894103352; 
 Thu, 05 Nov 2026 07:55:03 -0800 (PST)
X-Received: by 2002:a05:600c:8b55:b0:4a1:f736:79f3 with SMTP id
 5b1f17b1804b1-4ac17ffb30fmr422208535e9.5.1793894102710; 
 Thu, 05 Nov 2026 07:55:02 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4532916f2sm153207505e9.5.2026.11.05.07.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:55:01 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 49/83] drm/efidrm: Switch to
 drm_mode_config_create_initial_state
In-Reply-To: <20261105-drm-no-more-config-reset-v1-49-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-49-1f58d1e33380@kernel.org>
Date: Thu, 05 Nov 2026 16:55:00 +0100
Message-ID: <xlv14idvff3f.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QFb53_VbS1qo8U5VRIXmOdOsc6pasOZKTX2RxSgPqBo_1793894103
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Maxime Ripard <mripard@kernel.org> writes:

> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

