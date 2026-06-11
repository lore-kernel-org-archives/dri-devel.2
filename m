Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32889CD98D4
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4ED10EDA5;
	Thu, 11 Jun 2026 09:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hWzLwX4V";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4719C10EDA5
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mANNLFli+Qqln8O18mym5e67ud5lXKMPf5ZJaH21+oI=;
 b=hWzLwX4VXjCUqS5qtbDv6lGOGThYZ3P8LDuWUoUPqRmLnJvWoZXskrHXhLjJGvVwXx7A3g
 msTjn45sEMTUvJuTZ4Pk1yIvyPfHVvq7OB2naI2Wb/1GbpXx5a57ZzQMvgOfWrkZ4t4Cm4
 NlxBWWrWE751uWjozo8N4/H2OxbrIRM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-sRA_ZjvhNt26IFKBzOS2oA-1; Thu, 11 Jun 2026 05:46:49 -0400
X-MC-Unique: sRA_ZjvhNt26IFKBzOS2oA-1
X-Mimecast-MFC-AGG-ID: sRA_ZjvhNt26IFKBzOS2oA_1781171208
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b5d2e394so58037165e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 02:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171208; x=1781776008;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mANNLFli+Qqln8O18mym5e67ud5lXKMPf5ZJaH21+oI=;
 b=Bn1FIE1qUDMMct6eiRpi/kfF0FjmDegsCWpzO7kmNguuzosxCkBGbLD5frKe/MY6yG
 721vVOP0K1BJ3pywTpwgnDoNB9/poH2q9MS6rJQbqz/bbPdYy17NuG129WZx/58D9Kzf
 d1FQ15skGNFyz0OQK2MeCnvmVFfnw1vzVwU5NaPno0XoTEG0vJOHBvPLAc+1asp0w2eQ
 JcvPREcsNqE1Xmdbv/XvJbVcdjsS6+SvgAxpSBQjtQMVFVdDlcTYEEv5IcS/j3wLjy6T
 GogapvBmI48WDeYzu9ddSDeGz06oSz1ICweUpJPfdDZ8cqmLwxTODSw18qxU0QxhK/qJ
 2sHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4QGqxUNjV1jab3+hGFmybQIwSN0U5nmNKxI9w6o7U6He3WbyKUYMjbWO9lQHLWZbatxJ2/dWQXp4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdDSMhajlO6d2AIgRKgqkflsyltFyKG/g9CW+un7jPntCcCnC8
 iavCu4hRVgg8KbJtLsbDIqVTFEdd8f7dgINl2BgtuvI90AHtCnNTZruEtV5ItFCm0F5s30CU1Jp
 mMGM4J8QJNJo+o1uwjSBobgN2Trd0PDXubZABTrH+55lTuUfxPU0Pt+VTmsia+NKhNJhE0DC4Ga
 DnuQ==
X-Gm-Gg: Acq92OH+AP6cKzaH9nPsDyt1YTL6Us0FyEDCFWexeRef1CbfCF/lmC2ZgNEsIyntJcL
 gYFm4I86VMpSrCK/MK89j7VkZzKOfbE1vryRMIitzSwTlDoUYVdlFwHHv3wh25atvZfWH+hlARu
 tdk8T5cZn2d7tfxi1cJczS+wzOHUha1APC3QGOPasjCMgkjQrYMb8rNTy7rdf2St/1KuM4PsEkS
 mkQMTglN45kcH2orZ8NmPylApxxR3mLuAfrDieHNXF4r23ZfKHoqAiSSRQ9DOk3gvp7Q0tJccby
 YvsDqPzeZb+Nj5QaYm3neUNAodVfCvUo5SwMbW81xZHAjEDx3ZnBDFr/vgzpa23fFNRdFolj1F0
 dqEsEVZ4advQXEGMXnj1XHjaxWidxwtdTQ08+lkeDyIbGC4/xMWGspc9So9q32/WYu7ItGpqh0v
 sBGaEU0ZEA4Nmv8os=
X-Received: by 2002:a05:600d:8489:10b0:490:bfda:7d7e with SMTP id
 5b1f17b1804b1-490e55cc58amr16296595e9.3.1781171207833; 
 Thu, 11 Jun 2026 02:46:47 -0700 (PDT)
X-Received: by 2002:a05:600d:8489:10b0:490:bfda:7d7e with SMTP id
 5b1f17b1804b1-490e55cc58amr16296365e9.3.1781171207508; 
 Thu, 11 Jun 2026 02:46:47 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e5153feesm37373695e9.0.2026.06.11.02.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:46:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH] sysfb: correct CONFIG_SYSFB_SIMPLEFB macro name in
 #endif comment
In-Reply-To: <20260610195248.19442-1-enelsonmoore@gmail.com>
References: <20260610195248.19442-1-enelsonmoore@gmail.com>
Date: Thu, 11 Jun 2026 11:46:45 +0200
Message-ID: <871ped76ka.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EBBzHCjQY4zrNzDstrqBJBQuA33eKFN37x9iMxkqknc_1781171208
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

Ethan Nelson-Moore <enelsonmoore@gmail.com> writes:

Hello Ethan,

> A comment in <linux/sysfb.h> incorrectly refers to CONFIG_SYSFB_SIMPLE
> instead of CONFIG_SYSFB_SIMPLEFB. Correct it.
>
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

