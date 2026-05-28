Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6469DCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 06:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8223010EC7E;
	Thu, 28 May 2026 06:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="STHUmUR4";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9764D10EC7E
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:18:39 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so7627043f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 23:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779949118; x=1780553918; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eDowC+J9NkAkNKGl2xFdM++bofz3BCUgA7OJQhuHtSY=;
 b=STHUmUR4PX3Axl4WAbmu85E/NE00MOj5kcCqbBeihkcVTW4iCj0UmnphwSDtXI8lLF
 X7byE5GIswmvE1p7f7jCrVEyTGUKX2wMh9NA6DQICP/X5/rLh046KPOG2as+lKN+1Q6N
 Guk9aaeZe85McaVej9LEjw1U0ZSd2KG2DWhnyGZ0Q9ufIQCDqceaO9z7JaZTwyfnEJUr
 bHeMG07KgG9ogXJ9DCcab0mmFgRvnETIYL9JH3GGCIb922q9xLrEiE715BGceys0ybso
 SXTa2RJyPe5nCaPAl660en384vwpndxeWXYsIFB+5a8Q4+W5/FSwTD1yosBETfb4qxoL
 HBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779949118; x=1780553918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDowC+J9NkAkNKGl2xFdM++bofz3BCUgA7OJQhuHtSY=;
 b=QICbHeiOw0NWVnv0nVyVhYWv3Apvzh/DoH+dO8h4keLwc3UqBWpsP8ODDDqxrQGHuI
 To9Sw0ix3XrEMKnhN7MtnuOt9Dl2HiYMp/5C/lWeF/SpG9EXcXG25qo1tXviODFRtKCw
 sKKRIvREVMdssISDCqu6GZvWlpD0go+M61ab1cxLfRV8XUDZBk1LhgkamCrFcnKWAvLq
 ga+suQm2DmM4TjLqummW24tP8+3TunkpXfCPM8W9XBlJjT7/jH9LPvJm30s9LE3JrXrn
 avef/+TZm1OzX0jCrQHn5dzuBL6xQWBT9hOOzMnyuSYipE4tmIFYrmpGlF+YmJK5NSKH
 Vhmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PjWlfVMb0Tg4+DXUGbbkVHhaUcRkWASsfpxsKqsdLNv+PwsAXrkaFSKgqcoVv3vk9DKiBE04K648=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLMnpfFE7fM61y8ngLRifYbavdDAXNlB8l2CHI/z0GhnVYN/4D
 0joOdddkCwWC03Oy5FSST4vW3NCCle9KcAarMDlsh0vJNzrFosWspjFF
X-Gm-Gg: Acq92OEBspB9fykMWrCmg9pFIkr8tvAHZuO+7ti1yegAbee8kefJ0OWxa+zyPaGpA/X
 5yLeiW44XZRJfUu7HNdlRNGHUVVPQhvZ56xew4WJtSvB2JGNOsv5E4pePtzXOuLIr+U5BrinnGu
 ohL3+pMh2/Vazkv5dnLi9m7NRLY8A7o6uGj8mtLFIDQuftkzrvkbHALBn5SjiaRBvklblpCpbpW
 l1EXVnuOcjz2T4MalHIlkQlmea6uQqUooILUCxci5RvYRgB1HJBjwUffTIDxrFAtuq1AMwRdrzb
 +e7chPAipr6hkE+vrBoSt+c6Lg+F8a92VvffH/QDE5Yquy9CW1egEt6SGvJWdqxgtT7PgaCDClL
 ikgUY6p+q4WSvkQ42qs9bEiqRdSKSsgmL1ExVn7KCF089jCzB0Reb1kFkZI47l5YIzg/jCPSv5u
 9zDbth+B9a4KrzrhUg/vXmmW0SsLjwoLyUkA==
X-Received: by 2002:a05:6000:480f:b0:43f:e43a:f4a6 with SMTP id
 ffacd0b85a97d-45eb3691f71mr43798818f8f.6.1779949118000; 
 Wed, 27 May 2026 23:18:38 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a281dsm10925489f8f.24.2026.05.27.23.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 23:18:37 -0700 (PDT)
Date: Thu, 28 May 2026 09:18:34 +0300
From: Dan Carpenter <error27@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: zynqmp_dp: Fix uninitialized variable in debugfs()
Message-ID: <ahfeOh091V3BuuaB@stanley.mountain>
References: <ahP3Xagt1LJrhmFl@stanley.mountain>
 <935aaec5-5417-3cde-f944-3c04ffbd3458@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935aaec5-5417-3cde-f944-3c04ffbd3458@linux.dev>
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

On Wed, May 27, 2026 at 08:31:59PM -0400, Sean Anderson wrote:
> On 5/25/26 03:16, Dan Carpenter wrote:
> > If the *ppos is non-zero then simple_write_to_buffer() will not
> > initialize the start of the buf[] buffer.  It doesn't really make sense
> > to allow non-zero values for *ppos, so check for that at the start and
> > return -EINVAL.
> 
> non-zero ppos seems to be handled properly by simple_write_to_buffer.
> 

It's not an overflow bug, it's an uninitialized variable bug.

The simple_write_to_buffer() is designed to handle partial writes so it
leaves the first "written" (scare quotes) part of the string as is.  But
in this case, we can't handle a partial write and the first part of
buf[] is left uninitialized.

https://staticthinking.wordpress.com/2026/05/23/simple_write_to_buffer-is-complicated/

Also this appears to be dead code since fops_zynqmp_dp_pattern is never
used.

regards,
dan carpenter

