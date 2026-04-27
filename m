Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1FEFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1A310E5D7;
	Mon, 27 Apr 2026 07:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PVJH66Hw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395A910E5D7
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777275516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f31AOB1kF+hUyt5CN6C4uhQDf4vYH5lVFgw7hvjPKPc=;
 b=PVJH66Hw2ISFqQz9QS3iBzKd/9S4HuS3tR0wM0GsFRbtDwEq2NoCjZGPhf1B5A/FxyUOm0
 aSb7zasKXnvFnQw+O6RylTVj5Aw+9NGvjt/C4ejg5M6O1VG0k9NdMwSFUsxhphhfELGLHR
 cbKiGWqsvUoVglehfSTiF2+30HposGg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Lg7_dbggONCQ4PdAOGQk-A-1; Mon, 27 Apr 2026 03:38:35 -0400
X-MC-Unique: Lg7_dbggONCQ4PdAOGQk-A-1
X-Mimecast-MFC-AGG-ID: Lg7_dbggONCQ4PdAOGQk-A_1777275514
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8d4c2906fdfso1018280685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777275514; x=1777880314;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f31AOB1kF+hUyt5CN6C4uhQDf4vYH5lVFgw7hvjPKPc=;
 b=iv75P/1JAk+Fucz3T2tkDIB22gPDy1PVk4Ly2FhQ3r835qOJW7XgetcMeuN22itZpU
 bohD92FADPnSgzBPV1r4MgXscuumSmzPqdjnNvVplcMyQX8QZJUikgPd8W16GJbU0lqT
 XWTk1El8WaEYqRZ0UUU+f4Ek5XkYxWH6La5rYQrQL+1at6bt5mhrQbaBEg/4k7dYZtKF
 ZovFG3n1aQwoY7JkOurI7XRaM4ad/Swv7DW0tH95xaj7u8E5JSwbzU6RskH/WrL52+en
 HhzWDII0AqfsX1X3JtxGcoLOP6OZhYplv6f5FTiHmxarQIEd7iyOMFWF01k7Ji4FR9N8
 pWag==
X-Gm-Message-State: AOJu0YzQi/JIuQjb+tsMGQMS+8MJHnK4YMo9g29yee/wMNISRZxydwMD
 b1aFpMjJsBTzakqMch2cOgFIiO/YedQwFZzx8FzzqcJehcK9UBttNuhgIkV9L2rj07KkCwFYArc
 SxtjEx+HBNGSHhVngJ4e5Za7Z0vQN7Zlq3f1aKfQdNrTm+fHyBS6NWF43grLfaD6gja2+Gw==
X-Gm-Gg: AeBDieuZL2CbwRTHZgifZLj/jpG55e3moeVNK+EMupoa/1Bj9+tDaba/W/i+ohcF+66
 mUuAglVwajVKznLxioV/duhJAjIJLeoVzP1V+pYBDJQvPi/NAAkd3atczO1KrP+CBL6v2wo7htL
 DUoxCWBHCDSoI6R68bI/fXaPc1WyoTKvhWlrL+rrA9K0AtAIES3wp+MoPdHlug/OExS1QnMQocC
 mD/MWDudpv5xcHikASBp+YWPjoGlUl/A2+l9ktSn/O/9eta49w2A8KFh9MqnRfl9oOsZU+QWJKf
 aVuG8VnsK7ftA6v5SLxqmQpu4ATv9wEzAC8YqGuDsczMXfKSPAnXfPK/YgxvcZhtkwHxocB5Nkq
 w/8Snz8GMS3NGr6Rl9qGlidIqM5jiXla9sOS8CnhGMMULNbfSFeWuLR49B3Y=
X-Received: by 2002:a05:620a:17ac:b0:8ef:3312:a150 with SMTP id
 af79cd13be357-8ef3312b175mr3561066285a.17.1777275514392; 
 Mon, 27 Apr 2026 00:38:34 -0700 (PDT)
X-Received: by 2002:a05:620a:17ac:b0:8ef:3312:a150 with SMTP id
 af79cd13be357-8ef3312b175mr3561063885a.17.1777275513863; 
 Mon, 27 Apr 2026 00:38:33 -0700 (PDT)
Received: from localhost ([149.6.131.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe90a4sm2674759985a.9.2026.04.27.00.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 00:38:33 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/5] drm/sysfb: corebootdrm: Support power management
In-Reply-To: <20260408120722.328769-2-tzimmermann@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
 <20260408120722.328769-2-tzimmermann@suse.de>
Date: Mon, 27 Apr 2026 09:38:26 +0200
Message-ID: <87zf2oont9.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: szQ5b89RkQD3u8y40lzt5OyDlJhBkPDxRf0dA2NG04A_1777275514
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

> Set PM ops for the corebootdrm driver. Suspend and resume the DRM
> state on systems that support it.
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

