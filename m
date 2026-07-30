Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ABDC54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6072E10E07B;
	Thu, 30 Jul 2026 03:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m51CEsK5";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD1010E0D6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:36:23 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso520445e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 20:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785382581; x=1785987381; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WMWUot9YIJH7LYlDmSCMcZunmhRWRmr2f2dBfnr4TTw=;
 b=m51CEsK5wkEW9pie3el7KWYg2fuXFOPOfqOYuv1nBHJBeA9ygt0LaHTk4H60YvRS7W
 py+0g7nzTpOMcN9XPLfdvVP+Ycv0h9wJAcKHmm925L1u73fII3r4qCo8/1xJpocfKfTu
 Ck7vSYxuPuAxTlNLcrdhZDw0WquIGP/hHkd9KmbAVgfjRfaEw+cqa8RBEvkFD2FQulqP
 AiWtz7ao/wBEnCIXmbcl9ZO+OFbjpF90stovxUleyjOIbzRtm7FOSLiF1d1LfMCS8hqi
 2ShkYsePEGXj2GBhD7+eozIictjXqLz9QnuuOGaMJh3gK3Yel4lLAyNF9HjIUhFU8R45
 RVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785382581; x=1785987381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WMWUot9YIJH7LYlDmSCMcZunmhRWRmr2f2dBfnr4TTw=;
 b=P1uhCK25ETb0VcFpyfPrswTS3Sz7dds2dutYUgU7yTLQvJiaSyW+PDAAJQffPAdQOc
 zS0wR4SRW3B73TmnHtWmZgJ0982XJW1A3ssG9+RWS9mEX6lOSlsuJ1Uxg9IG1F2qoKds
 rZW5j0T3WVcJ/e+2xfR2fbMnU6ZH0X92D7537y0eGiCkllJzqs5E6DrWydKWHEmPlT/Z
 oDacC59uBpx/43LfvVLcIbgMV0+AUC6Mlb3x7yXCTDfeEUAw3llpraCNNLayJa2ei5rj
 Ya4He2BUdNajeeTqAGYWiPe/YHU/E1DelGdhln6lnSSnpu+4yMS6s9qN8+4C++qMx4sg
 5wPw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpp2I1Zko7XkG3ZWrYSC9w8QwSqMSRw8jIRPdV5fwwLikVCZR+Db/80V4JlsSeoPm3qvxvXMhfBB5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrT73wxfRGPPpfxx8BYi/miGPcSKi4+RcR1a2CxI8z7u4f5tdc
 o01yaEAaI36BGCGjlMW7TbMqIcVelO7E4thQqh9YYcAef/adcMOrdmv3
X-Gm-Gg: AR+sD11lX6XjuRwKDeBbf5fJNyJ4ZoemvvlNqRwc+oiYU+XD6f75/3NPFz6xs/NwXyw
 JhplB7ODMeXBKBkLiNxaUySvEW5JK/To0TKh8jU3LHbX/9h6lav1IhUAdOMzTSCsaTHkSTRgg4A
 17iHP6pCOAHgTt7wiLv78OBpGNZsVVcy/Fzkp+0BdLG4Gg4tS7QjQ2Be4DIQfiu8Gr3KPL/DTaP
 RQ9CMHXz/glizAMxAuQiVp6ZMqTAcMg/iCwmbj4WMqFyDSA/c/qw/NeZlfj7Bak2dUuEs++iWVO
 7AnDXviJVE95lWMixZ9ZbNj6YMB1pv5Qegjdu4kIB2KrbZ3zM+Eqhv4eVQSdxVpxdQzDVmVYhDU
 cNbJUcZ43KebJrcR0D6UvTvi5wRzM8OCoePrbhCD1eDJ32kw13g3v6fB7RmQ390TJ20z/krsA5H
 8qnFEbKj0qLP3BODCXsnpNHveM/jWurhI9daXQFUVhecoOLeFBcuUmTB8xTVjjAxzxLNyGNL/ds
 X4DME7u1aYzvuLZXPjBPmFyXeyT0V6vMOLunkPDe+Cb4sB54b8/
X-Received: by 2002:a05:600c:1d19:b0:493:df1d:7488 with SMTP id
 5b1f17b1804b1-49800e81092mr9327545e9.16.1785382581458; 
 Wed, 29 Jul 2026 20:36:21 -0700 (PDT)
Received: from JTOLLET-M-FKW7 (aerospot-mask5-183-3-inet.hub-one.net.
 [149.232.183.3]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496e8e15a52sm67579895e9.0.2026.07.29.20.36.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Jul 2026 20:36:20 -0700 (PDT)
From: Jerome Tollet <jerome.tollet@gmail.com>
To: jani.nikula@linux.intel.com
Cc: ankit.k.nautiyal@intel.com, ville.syrjala@linux.intel.com,
 arun.r.murthy@intel.com, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Jerome Tollet <jerome.tollet@gmail.com>
Subject: Re: Question about drm-intel-next vs drm-intel-next-fixes for HDMI
 scrambling patch
Date: Thu, 30 Jul 2026 05:36:07 +0200
Message-ID: <20260730033607.17136-1-jerome.tollet@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729161606.81668-1-jerome.tollet@gmail.com>
References: <20260729161606.81668-1-jerome.tollet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jani,

Thanks, this clarifies the process.

I understand that the patch was applied to drm-intel-next first, but since it
had neither a Fixes: nor a Cc: stable@vger.kernel.org trailer, it was not
selected for drm-intel-fixes.

Since the patch fixes 4K@60Hz failures on some HDMI 2.0 sinks, and has passed
CI and review, would you consider it appropriate to cherry-pick it into
drm-intel-fixes for Linux 7.2, or should it remain targeted at Linux 7.3?

I am happy to provide any additional testing or information if needed.

Thanks,
Jerome
