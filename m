Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC305CD98CF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE1610E930;
	Tue, 16 Jun 2026 08:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Z/qHMMek";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F0C10E928
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781599692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FLV3dwnxfsWUtnrYURiK7yDU0xjatBfMX7/p7eIbm8Y=;
 b=Z/qHMMekg/jmHTwV4NdspzAOlOpGRDtlSlWTaufZc9etHd2JuZVtJFQI4URDrsbvXtlztT
 A9rQuGcHiRsAM0aefMoLCnNLgkrC8+e33zAOwuCfEFqIz+ov01rJk7WrnRz1nnDNh6uq/Y
 9ZEz/yYDmT7E6GhIqPfHsImqEEpVAQA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-RMgqpkcVNn67fbej7cYpNA-1; Tue, 16 Jun 2026 04:48:11 -0400
X-MC-Unique: RMgqpkcVNn67fbej7cYpNA-1
X-Mimecast-MFC-AGG-ID: RMgqpkcVNn67fbej7cYpNA_1781599690
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49221de4ed4so20064365e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 01:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599690; x=1782204490;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FLV3dwnxfsWUtnrYURiK7yDU0xjatBfMX7/p7eIbm8Y=;
 b=sW8uoNUtvoTIHRxsNYMV+OFKXUsPWfdF2TlXLCm6SXKnqrvcYwgu5GGtuCU4IqX2Ya
 Ia2fs3X3Vh5qFF3pAADCtXDtyvzGTYEeVq6CdM5acZ4f3lnJ5FrVPTGMci5Knac0wph4
 9eFu8ms2B3OQ0bfVJwaQ+9Qc7TNx8dMb1Xm/g2Fp7E5eTsVYkLSUhuempKGrK762wlcF
 CwxCwcMXg8lmoBaMx/1rLyMQ1pfvoKwpZsrVBhr5e89bPDVQbX/Xh3seqCwiqc7jTK5w
 cH35c/z+Bl5Jcy26m/fnen0/F9imh8Bi5/+nVHn+pzMLYVAV992lL5MzAFBsIJkOjiUA
 J9aw==
X-Gm-Message-State: AOJu0YzZX6Yum7rwU50qS2zNPPQmFO1VO9VF/EfxyVLKS4V6gtxrywkP
 Wq/93ylZ739pNalf0vF6SDAoW4DaRqfkn6f24KgfhmNtw14f+3gbaamxRw3sqLNn2KlnMxtRmkF
 P9A2gTcDdJz8Ed7iCntrGC2D17b/13yebVQe4Razoavg4H/t8FNDqbFmRjaIWNIhMKtYMsQ==
X-Gm-Gg: Acq92OEk8VZwMAwJODTv0afaJzNZRhTByulSY8U+DPx24xvC0i7GBPYkDTzX6Y2iEcj
 ScCqa/GEzYhqT3hWotn8VC+K3OSxaVbAJPtt8Vv5CsgiiaZ28JJbHoWl2541M8eSdHDLauv/PhW
 7tpSSuasPmOUH98Yt2RQn+COJIMxxk1wnVhlFc6g527Q0etBnmIzuy0U/L2C3lFrQGvSzA+hSu7
 RfSyI6SUFPWjJvz2fglXPHi46+i1TwHeulvuSOHM/50zg3fCpDGh7iLarScevdSns073oPF0n4D
 Q2UqjBV1S+6XJ7+en4fq/HfTc56uHUnkPvmJoNLWFKuiqZW2vNjKldN//nHiiWTbi6z2guAydU6
 w3WscsYN75ulspPLY1dYdpEi2uNX7ZaWtO2KCpGy+/qCuShuky7XfozjBiz+cc3sbcTxb8FsXoO
 sv0k9g
X-Received: by 2002:a05:600c:6749:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-4922ffa2367mr38343475e9.16.1781599690090; 
 Tue, 16 Jun 2026 01:48:10 -0700 (PDT)
X-Received: by 2002:a05:600c:6749:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-4922ffa2367mr38342815e9.16.1781599689402; 
 Tue, 16 Jun 2026 01:48:09 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm42464485e9.4.2026.06.16.01.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:48:08 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Alberto
 Ruiz <aruiz@redhat.com>
Subject: Re: [PATCH 0/4] drm/solomon: batch command sequences for
 SSD130x/132x/133x init
In-Reply-To: <87o6hfzg98.fsf@ocarina.mail-host-address-is-not-set>
References: <20260612-ssd-batchcmd-v1-0-c61e5f7c24bc@redhat.com>
 <87o6hfzg98.fsf@ocarina.mail-host-address-is-not-set>
Date: Tue, 16 Jun 2026 10:48:07 +0200
Message-ID: <87fr2mzxa0.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hT8luJuqoNfIROcNtFx5AHBVVoF_Ng3cnwcWpnLwpzg_1781599690
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org> writes:
>
> Hello Alberto,
>
> Thanks for the patches. Nice cleanup!
>
>> The ssd130x_init(), ssd132x_init(), and ssd133x_init() functions each
>> issue long chains of individual ssd130x_write_cmd() calls, each
>> followed by its own error check.  This is verbose and makes the init
>> sequences harder to read and maintain.
>>
>> This series introduces ssd130x_run_cmd_seq(), which interprets a flat
>> byte array of length-prefixed command entries terminated by a zero
>> byte, and converts the three init functions to use it.  The result is
>> a net reduction of ~110 lines, with the hardware programming sequences
>> now expressed as compact, declarative tables rather than imperative
>> call-and-check chains.
>>
>> Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
>> ---
>> Alberto Ruiz (4):
>>       drm/solomon: add ssd130x_run_cmd_seq() for batch command execution
>>       drm/solomon: use ssd130x_run_cmd_seq() in ssd130x_init()
>>       drm/solomon: use ssd130x_run_cmd_seq() in ssd132x_init()
>>       drm/solomon: use ssd130x_run_cmd_seq() in ssd133x_init()
>
> For all the patches:
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: Javier Martinez Canillas <javierm@redhat.com>
>
> I'll wait for a few days to merge them, in case someone else have comments.
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

