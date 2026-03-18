Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F194103E160
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0411110E0F1;
	Wed, 18 Mar 2026 11:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jyk3QJ2z";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B213B10E0F1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 11:14:37 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c0d36f3888so2732921eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773832477; x=1774437277; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WSatfPeC0eHRV2MFnc3PDRkxRbQqib0YssmyZ7gUdhk=;
 b=Jyk3QJ2zedH5FmAjaG1DRTpU5cSg8HwtIilQoqK+ZLNnkr+wExKXAv/UuUk9ufbHdr
 pZT1H6vQO1ra++aTnwYgymgfPBIZhVTjsI6xV7di76zRUt2lF7FqQS/uwNngrDqF2sZc
 kEL9fPYHBFGuAaLrWCA1SNxarl1x8rYFQWyxzp9xLU12nLMQOqgmz5HJMf8+qK+DKq3v
 6Lp3z9FU4iDqArQxRJ65lTBpGA9JYK7VdfakDEhd+v/IjYtKPMcfYQoiziCu/NKG8gQ7
 Im18zIVxM4rHDnlhiDlnUPh0vYuE9WBgqZBjWyj8lCCv6YhYu7rCMToi++Il01gupryQ
 oqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773832477; x=1774437277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSatfPeC0eHRV2MFnc3PDRkxRbQqib0YssmyZ7gUdhk=;
 b=sA214GLjeieKgkkAja9xm69/P2mM/Y3DLkY7a4AMaw/Hokci4aPzKi2V4WynNqxZlL
 em78lkuhIZSb4tOTnCJFeqYmmcKD+AefNA4sLVYfWmaElYRy6nJ5DY5Je467QPGZRtZ0
 q/9+WMVpv8hvJ1kCT8QMro7Vxy9r9zasmMHHRX0Y7tLUROyJBkqZcQhdhxMF/Q6lfMnu
 nGcSDpJVSNIWsvG3XXP9v6L4SWziVsXRJZ94Ki+yNQ2xeO3hgNG8X3nvDc3XuM1rICv4
 vAUVpt7enDjVD+FOuaFmEQxwYR3WWD+92NhLnMNYRuRKlURjEyqmBWJyonkKudhSxtNn
 GpRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy+DGfQJPH6EIbn6jC9hFvbfNbXXzaAtsIuly1J+sl3zl6r/FwqEywveUsqArL59j7mxJP1MMx1Z0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzix8yeN5EudRn9UaK2LlR6dPAAfjKXW0faRisnzgG6ohIBvHuz
 AtHK5n2KbcdiT8HCCfglJaOoDvTjT2kQwuAhkhypgLYycKjbAwKyzzk+
X-Gm-Gg: ATEYQzzfPCJTGf7HIHkMtLDVjMWhG2yb4lbpbFxLuRBpRZyKyEsWf7+wqky/64kzmMp
 Iq2ddDh9TiNu40jB8fzXevmMPG4OIUP+ujQvaQoWZxSy37b58SrfhSUcZ1luQfGaahnmEDN/Agm
 bMJn8S2R30hbB4CuSlvwZfqr6NruBxgenhOlzRpxXb7TszdMxZqMctq7FY/rw3mNCkwchrtUYgj
 zLIkDK6ptXdR6XiWuhUU1Y/KjAcSIsAM+AOvXkC38ak4aNQq0ce6JxvohhH6ryyB2XslkwnzUDt
 0K1y/lYbiiuN6hRj+rSZnedvl0sAwkIFuYFq87Ub5gAO51pDwlsFHU2V7y9ptOPFQ2PDwJuGtph
 47xvCwjNe74eYi+EXuX8FaH1uN+PfwxwkKLIVZlNlprKlvPvWe9zm9wmc+3c9Od0/NJpYQXwbf6
 Ywg4tdi+1SWVVwOLbMsw7dwCpz7hj7UGMgGn7+LRTdPUEDvtsoMg0SUKU=
X-Received: by 2002:a05:693c:3011:b0:2be:fe8:8b0d with SMTP id
 5a478bee46e88-2c0e5193929mr1379829eec.22.1773832476704; 
 Wed, 18 Mar 2026 04:14:36 -0700 (PDT)
Received: from fedora ([177.73.136.69]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e536896csm3604281eec.3.2026.03.18.04.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 04:14:36 -0700 (PDT)
Date: Wed, 18 Mar 2026 08:14:31 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
Message-ID: <abqHvvsyL5BPA_cn@fedora>
References: <20260316002649.211819-1-pedrodemargomes@gmail.com>
 <20260316152152.1e20d35e@fedora> <20260317183054.5d7030ec@fedora>
 <20260318111649.2912818b@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318111649.2912818b@fedora>
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

On Wed, Mar 18, 2026 at 11:16:49AM +0100, Boris Brezillon wrote:
> On Tue, 17 Mar 2026 18:30:54 +0100
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > > 
> > > I've played a bit with the drm-misc-{next,fixes} versions (with the extra
> > > pfn_mkwrite fixes on top for the -next variant), and below is my preferred
> > > version (pfn insertion is all handled inside the try_insert_pfn() helper,
> > > with order == PMD_ORDER specialized there).  
> > 
> > One last thing, the subject should probably be "drm/shmem-helper: Fix
> > huge page mapping in fault handler" (instead of "Fix Map huge page
> > ..."). Pedro, do you think you'll be able to send a v4 before the end
> > of the week? I'd really like to have that fix in -rc5 or -rc6.
> 
> If you can't, please let me know, I'll post a new version for you.

Should I send a patch for the drm-misc-{next,fixes}, or v7.0-rc4?
I am planning to send it today.
