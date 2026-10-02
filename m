Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE42CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A7810E598;
	Fri,  2 Oct 2026 12:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IjaP78s2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A374510E598
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790945464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uT1TzvdktEC1eT/y91LI9yVzdqB1qQfdlDD+ACCdd3I=;
 b=IjaP78s2zYtq5ZRLduP3gSoVUAV6s0jFAkTpOPueiHzIQKylJ05Wif3BRFwibWSwgchzMu
 IAdIPStuPoGXEtBOkSfGNemsto2YpDHHCilpfcIGmabqm3ieJTQAIc7OAhsif/9Em6Rncg
 x3ROL1sYZaIdkFzocK16ZDh9iPTxudE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-1Tc9Jr_NPuOUKmz5dvi_sQ-1; Fri, 02 Oct 2026 08:51:03 -0400
X-MC-Unique: 1Tc9Jr_NPuOUKmz5dvi_sQ-1
X-Mimecast-MFC-AGG-ID: 1Tc9Jr_NPuOUKmz5dvi_sQ_1790945462
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49fcc575709so74053535e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 05:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945462; x=1791550262;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uT1TzvdktEC1eT/y91LI9yVzdqB1qQfdlDD+ACCdd3I=;
 b=LDODhrvEpsqBUf0Ef4gyNxoAgXpxKhrYkmqJyAZvu5FXvZOMxwpvCnH++kVPNzUKWa
 zIAgLkHMO/hI3M4WQLyW/x+b9dO56PEkDcKR50ehWax57cPnlG4f8x5JNVGcSrGsgeBC
 bdQxi0w8DIXW4eHiQY3cJcbN9rmnIeIGqd6r3h8kQI6STzIMwZIpUsrdo9el96nc7xXn
 /v4XwAcMnYZsfI8DZnZCqWGqFUnTQzlli+WODvu5DG6hYuxUpLzwVtoC+mpJnRquc6At
 HWwKHpWlEQNbYSdpqJjM3ohQASPEybT3W+p1CwzoiAwd6sDV7+LHftDGFUHZ7WLRuHCU
 1H+A==
X-Gm-Message-State: AFuF++lF9kSd0raInzXGqFxOnsSKVKjMrF1QAbW8ykouEgCFRnl143Ew
 4NaXOZH9peEGEfXQEQs5DB/Cn4zA07UGEqhv5gUc+7l/jIFsGw48vP3jCcpb05cGJBHTtzQw9Rx
 Wy/IpW1ns9YR1u6NndRv78bryCH4seL5mxTZDZ5Mp6TjSgIIULlLVGRdyOn6JioXFAL+nWw==
X-Gm-Gg: AYBFou1rTd5YW03g9pYtvWZihISGZT6qHnvbOsBUeKteuKDQ6yS9WHoRuCC44nsCsOi
 3k9tqzCIcL5FJECCJ/4v8/DGXWCTHpxwfG/msE+o31ITsO0s1aRlmTGKLtTG699e2NxkNoedVtF
 yCK7rDwop7bdtxJTvHgtYX160vxPU/2l31yLfiyuY4cEGsyRxrRs9Cst2+DkDss2VdO+SZ+UU24
 LUppMsUohSZ5rHHcytifhly0jvweY8L3bNu2Wbziidrf1dzLXud7b2TusfNMBtGaA+tODaGbJ68
 nNRcQXW5xvycBn3sMHiyQpGBlQ7hTVL+ISJIE61oPtlVqeXvoBMlnf6f/T25AQ5mF0/towLlfIH
 eIagWXl1I2BGqJqbAJ5X4W5Bgh0nmupMgaBVJ8Maa3987VxkAkRED6ysu8MbLqvrnTw==
X-Received: by 2002:a05:600c:5306:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a0275863cemr44975815e9.30.1790945462114; 
 Fri, 02 Oct 2026 05:51:02 -0700 (PDT)
X-Received: by 2002:a05:600c:5306:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a0275863cemr44975435e9.30.1790945461642; 
 Fri, 02 Oct 2026 05:51:01 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bfafasm82137655e9.8.2026.10.02.05.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 05:51:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 3/7] drm/bridge: Do not include
 <drm/drm_simple_kms_helper.h>
In-Reply-To: <20261002124456.741011-4-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-4-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:51:00 +0200
Message-ID: <xlv1h5j46zbf.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F2vf0amUnnj-vu_JJi6pAu_-AcwUtxnKNuDopmCvolU_1790945462
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

> The bridge code does not require anything from the simple-kms
> header. Do not include it.
>
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

