Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7A0CD6E62
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7772A11316A;
	Mon,  1 Jun 2026 10:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bkvFyqP6";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464F5113168
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hD1h4dJE66yskCwSbjuaF026xxijLvV5fH5oqPl0EUY=;
 b=bkvFyqP64A7n9sXJfArZ7i8OGrLfKXxra9KhXKMyfpmWJ7xxVn5sTqFRrpye7PI9IeKvpm
 0VmnIhtndI/P35aPmJXQMKCohP0M1fdwhHP3TZA015VWaVMHy1JUAM9ssoWIbhZlZyPuVd
 DQ8lw9fAaga3E6dgu1bey4L7XuzyI2E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-PVx7ZwwfMuGFzpe-h_EfDw-1; Mon, 01 Jun 2026 06:27:48 -0400
X-MC-Unique: PVx7ZwwfMuGFzpe-h_EfDw-1
X-Mimecast-MFC-AGG-ID: PVx7ZwwfMuGFzpe-h_EfDw_1780309667
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4600cf05f07so944321f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309667; x=1780914467;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hD1h4dJE66yskCwSbjuaF026xxijLvV5fH5oqPl0EUY=;
 b=jfxEfAlCnLEIhptN6QMZZ7zJR4dhPxZJM4lwI9SJqbUlyo6HcHvGEiJPSZe9RQyOmD
 o0ZT14CGTYWizqLHKM9huYlQva3TPuX/3IBBjVxkYUYRltrDRb4qH9UZwTLq4XXnKEYW
 FjuKTkvjeVCrQv2Un+1FPFjdjVxNDVtL7bCd+MQwb0CiMg4Lybv5LpQJIXRIa8RBnLo3
 dKiLNws1SkaKbhIXPbt7iay9MVcf2hMDTMR6k3IsSyTTrH/G9oncnt90jUFR5qE+LiM3
 q9XST6sxBuRDv2A84cffPj3Hhm7/VvVMPA8qphTr5ippvHO+70Vnbwjdz2RhXa+zMD0n
 +Yqw==
X-Gm-Message-State: AOJu0YwVWUfMGQSvFJcYTDsVyPSrrlycEPwqHB/Eq2ofPalIUiUcMOwl
 B4LvbHZYPn9JMbku9ebfocZuBGmP7Rcv7JN9MMpSG+0r0jqf3yRZ8xDKrllugJvYXBca77NYEgx
 MSzHBc2WLBxVinenszaSlI/kmG0HFhmoKQ/ywFYYLU8ViSJ65EHkhcSUtsDqV4IEYC6B86A==
X-Gm-Gg: Acq92OH943O558TnazOA0s7pYjLLedckkW40Z70mAQMs22dBPh5c4vSrA6X2ktqMH1n
 5Iyy3GVsyhykS/mlflxkCo1wQ7zxfvV878XiPqk3EzFx0Wx5Kt6zHc+K/7IfZtjWHX/Z42nosvm
 MRpuAjsvRtMCbxXcED7GRkYu5IkA27zwDoX73fygZvlUmKHdKSLuKtKXX/KaHD+LlAT3PIEIOIZ
 mrDVOlDMTwmXfc5+KrtQ1u5oCPMKVgIy6ce71UPVJ2MjsoYlRrn3iB+ial/lWbQjEaD2ipjErlB
 YJOqlkvFCZUaJOMp2bvl26N3GsYu4qE1JJoIAx+uPbNr0sqlTQjFWI1yZ1PXlKyjKqDG0TEDCF5
 1dhg2sUarxXJfQErSt3OW92MWK1lDHhPTzD88wEbvwvhluO868hK3so2ZI2vPMPEVgnU++vmtio
 fOd3WYkwqJ/a2up7U=
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id
 5b1f17b1804b1-490a2933355mr153783245e9.12.1780309666751; 
 Mon, 01 Jun 2026 03:27:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id
 5b1f17b1804b1-490a2933355mr153782735e9.12.1780309666314; 
 Mon, 01 Jun 2026 03:27:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef32fabcasm23690022f8f.0.2026.06.01.03.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:27:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 06/10] drm/damage-helper: Test src coord in
 drm_atomic_helper_check_plane_damage()
In-Reply-To: <20260530185716.65688-7-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-7-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:27:44 +0200
Message-ID: <87jysilfmn.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BAWGk-86l7A9ULyuH-YVSgzGvg6nB6OCkBi7wFLeTPM_1780309667
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

> Planes require a full update if the source coordinates change across
> atomic commits. Evaluate this during the atomic-check and set the flag
> ignore_damage_clips in the plane state, if so. Remove the check from
> drm_atomic_helper_damage_iter_init().
>
> This will help with removing the old state from the atomic-commit phase
> and simplify atomic_update helpers a bit.
>
> Several unit tests check against the change of the src coordinate. Drop
> them as they do no longer serve a purpose. If the src coordinate changes
> across commits, atomic helpers will set the plane state's
> ignore_damage_clips flag, for which a separate unit test exists.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

