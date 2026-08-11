Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDD2C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B54210ECE7;
	Tue, 11 Aug 2026 16:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F254jRX/";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC4610ECDD
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 16:52:39 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so20735e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786467158; x=1787071958; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sVCfGD0PlR6xK5qm0z7xLg2t4uabVyupoEAwJ2u3L+o=;
 b=F254jRX/X2HU4fTU0vAcs6SXt+YoZiQspCtpxrENqu76nY/1Tllo9t+qDEqNcnK3Wg
 ldWoPBLpmzujfO5JRtJ9wfj5vkLxLeek7sZV+0Q4BlHlfitT5u9dISnAbPrMAEFTPKFI
 wQiZ42G/TPOmQ6Lt3ydi5A6Pt7bXDSZH5bSGMMCMvRW40NRsF2EaES1k7G8Cuz8JHVjx
 LL6GdQvDaHhmaYwrVsRyaCh1iQhLhpB/Lmyxp2mqSy7IuRl/4KpfdHU7b9gyeewjY3Ph
 8bdFQu6q9ogayXegXDlTp49ISC7Ko4fgdTXTQ/ndvtgn3koozwwgGHJrxphrvV/iB3XR
 cqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786467158; x=1787071958;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sVCfGD0PlR6xK5qm0z7xLg2t4uabVyupoEAwJ2u3L+o=;
 b=cTY/mTgOTf1h1lQI57LtFJJMzR49psWZ6f6qrbBXjOuco95UTJP+OiqH8IlNzL1A4v
 fAXhMFCjirVJP+UUY0El1Bagg/azAXRq8e7lToklzNy59WZrKcr9eZeDyo1yUjq+R1th
 cm+oKFjXAo2pgMkWB9nzivSqpYDV+gnxiN58Xgju+BpISAexVH+2f6jCjA5+pk4KYrvg
 QFD/eAnAbW0nQGWEeMqyH0rAF/DN2bJa5R7ojPpQjdWHNy8TQZNd+d6ZV+zyVs4bz3H1
 3zoRi769AbVM3n21O5WcZV+FktZfa6GH8LCucLuRJQzCuKK9+FNXZ+q1p8pjkI9YvRpV
 lNlw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqjy1oFXBZjKhAwbqTF05C2fpiFrOXY/RLxLNceGufHl2VsU9jPJGRfJb+icmGVhdyVmm6EI6Ef1bs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/U1Cjqi1dZlawI/3EOmthGKig0C9mqKUFzMTFmaa1H/EmchC/
 9FT1Mkm6bS7AJS3WL7dN5q62z4sKRJ/lYc7IuMxxlnqdMBXNPZzdbP04
X-Gm-Gg: AR+sD13nGYQVqaDpoo29Al+rAgTfaWBpMiACqNEyb33p5qsdGHrtOCpyxvD5Dczvf5t
 KvQvySLRx2zMkm6wkYTI1wKehfg6fCMJ9rUxNIwq+xwhVmdVqnARW+aGXIzZxW5E3asH1oQIMQr
 ZJpxcUJvw24s+jRltp34+AVaxXB6IZndtMcx/Dv4Dd7ywlB/mR3tNlFALP5NaOZJMGlFn43KgJQ
 1db4fOHaC13be5u81yldT5Q6I0t+mOjmeLr8mZoW7H6OjfBbz07wacI7k2D7q4i0hbJy2BGKlFg
 mzdYj/A4/U8uzURpRS/tRv0A58XwPY32H2vHpJwnU7jbH0BNks8SBApqP2B7dS2oOis8NYzhuvQ
 svHhxsLI9ILSr2BCivGRml6wRdkBORBDjL+LHxky6n18tEbiRU3wVsTdkBZXOnMdGINZlmLKwxs
 BDR23nB+G+UcFT1hTeRLhUUqXW9oJkIPk1IfKoip+Ni1n0DM+uCQTHej0kNYGN7+ENi3A6H9nus
 lxk4zmIjWrE4DTdr7zO3ZJFppzngJ6O
X-Received: by 2002:a05:600c:1d24:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-49978460326mr65825205e9.9.1786467157921; 
 Tue, 11 Aug 2026 09:52:37 -0700 (PDT)
Received: from osama ([2a02:908:185:7e40:434a:d6cf:4fd1:90b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e0csm987065e9.1.2026.08.11.09.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:52:37 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:52:35 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ondrej Jirman <megi@xff.cz>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] drm/panel: Use devm_mipi_dsi_attach in Himax and
 Ilitek panels
Message-ID: <antTUw4-Jae3P06S@osama>
References: <20260811151000.75038-1-osama.abdelkader@gmail.com>
 <20260811151000.75038-5-osama.abdelkader@gmail.com>
 <8733wkpthm.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8733wkpthm.fsf@ocarina.mail-host-address-is-not-set>
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

On Tue, Aug 11, 2026 at 05:27:49PM +0200, Javier Martinez Canillas wrote:
> Osama Abdelkader <osama.abdelkader@gmail.com> writes:
> 
> Hello Osama,
> 
> > Use the managed MIPI DSI attach helper in Himax and Ilitek panel drivers and drop the corresponding manual detach calls from remove paths.
> 
> Please break these at 74 characters max.
> 
> > ---
> >  drivers/gpu/drm/panel/panel-himax-hx83102.c       | 7 +------
> >  drivers/gpu/drm/panel/panel-himax-hx83112a.c      | 8 +-------
> 
> You are missing a Signed-off-by tag.
> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 

Hello Javier,

Ops, thanks, I don't know how did I forget that.
Thanks for the quick review.

BR,
Osama
