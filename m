Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A93FED3F6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D8610F673;
	Fri, 24 Apr 2026 17:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T8AmfHxT";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF7010F465
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:42:27 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso7386331f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777023746; x=1777628546; darn=lists.freedesktop.org;
 h=references:in-reply-to:date:cc:to:from:subject
 :content-transfer-encoding:mime-version:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDYc1MW6S1MSpliI1TbPg+1F6w7TIPay6jp2YVrMVdc=;
 b=T8AmfHxTRY2f4esIQh5+OiUIQwHb6wUXVXKYvwqLsvobCAaOFnIbx8RvLI9yg2zJni
 tHG7sJ+RIUpd+WEWJoRlRJ8z+VKi4E42B21KbfX19kell47q9k3HsUsc2n/2MbQeS4ys
 314uY1kcb6hN0+csAaHvCFKvnQjebM+PjgIeAesHVMyegI5Y3/LfY9x+lrrpWDDPgFZT
 H1eCkl1X84dhG/PZCwG19A7Ao7YOImFZOhcSb9mFwPkrMvaPIp7FtoBm+0E3TiOzqvNP
 8xUYDTl06bUjrHzpouaaKh3Gn3amMAiSn+NrBuSy8mNk4VUby/NRNxa9vzEJnAc85v39
 XLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023746; x=1777628546;
 h=references:in-reply-to:date:cc:to:from:subject
 :content-transfer-encoding:mime-version:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hDYc1MW6S1MSpliI1TbPg+1F6w7TIPay6jp2YVrMVdc=;
 b=g1ejF3Xbr3igzoIst0GePEc0xotrgEyT2bCoQRqASPSioIeo7YLTOxJH+yJizqKiOi
 yyRTQ2Fc3a6t1LYNAKprZnFg7qzTt4OlIOGvXpt7tuA6N3R8ZnEc166gLkrerXwpzqEq
 5ffV4lXcxV71z6a8ZKOhH0XrOscywVo/uQLQB3rhcigcqB6yq/hPO1NsUR/LZisN5nVz
 t4r16G114p03g3Mo12MVzVHSWwSoX2uM2XWf/mWzTPbTXP28VJ1XJ8xpWdwlwjy7ORl4
 dDoqXNBcYNm2H0/iAqgKT5syFLzNWNkT+cDdbyGl6rIufsDfdpFQyhG0S5R7txnF8+69
 Ko+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YyajHSeaONTZyM9tuQcIl4DzYbtnf+M5o/1WvsXPUovic/nO3SOL5+iEjuPIOzp20QJbe5lI9/5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGBs92kpZMRDOY6qnqxfSBImy5mHPxF6NYZVKWJ0EvX8qJr9Lq
 HLpiRWrUrrcPIowvPybaHEl4yBS4R2+GtoBSqCYP+g/Bv41TGvnMGtfS
X-Gm-Gg: AeBDievGbVgWUtlFvaRCrvJ2I0zNT65YGkjktAa/UxEvpwdzwssgANSicSVsPE3T8OZ
 YV+wexfYUGUc1NOEUbrgUhLXgxBFxTIJJANxTpfk5tMg6fqM2ocfUV9e7XJy1JGNY36rFzlBpXX
 5TyuAOBoHrzUIrOSHpIc0qFN2LKpByJh9GAVspPR5UaM/6Llp7mzfwHw3n0i7rcTFFMGxYOLHRR
 ixaGtRW489b0Og0D0mAzzw71dmqOSuVt7974rTxiinbPWgQSgBnP3e7u2q2BBoBPicitTa5trkX
 LDinoYFTDMNt3JJpVyAu6XT5E1AlKjAyJaI18P10bkCPJTCmh4NECwHI+4vOmclTJN2T9C9gc1/
 pQwtaR+TQ7YqYpK6ainxRSf/npJOmHLsY2bR+XNoXBF65l8j0oOlhEJ9y2Gtat88MKnoGFimRmp
 bmmASGASPBl4Vy+aGgyzly1prMG9rvMF+HH7wVQk+jCvcTRLEHOT6IKUEQn80T514BkVextIu1r
 PfRizIPN4lb4R6PaAR0UjwXjqPPtmH9ryRGRhCfD8LaDv/f+8vZSLwnz5y2WdUAJWZS
X-Received: by 2002:a05:6000:2303:b0:43e:b020:f8a2 with SMTP id
 ffacd0b85a97d-43fe3dd5208mr45925335f8f.19.1777023746069; 
 Fri, 24 Apr 2026 02:42:26 -0700 (PDT)
Received: from ahossu.localdomain ([5.14.131.42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm19540453f8f.15.2026.04.24.02.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:42:25 -0700 (PDT)
Message-ID: <69eb3b01.5d0a0220.3c3ebd.f35b@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] staging: fbtft: fbtft-bus: replace function-defining
 macro with concrete functions
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Fri, 24 Apr 2026 09:40:48 -0000
In-Reply-To: <aes6JY3Ht6p1VpFa@ashevche-desk.local>
References: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
 <aes6JY3Ht6p1VpFa@ashevche-desk.local>
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

On Fri, Apr 24, 2026 at 12:38:45PM +0300, Andy Shevchenko wrote:
> I'm not sure this patch improves the code. What I see it's harder to follow.
> NAK.

Fair point. Three near-identical functions hide the pattern the macro
makes explicit. I'll drop this approach.

If there's appetite for a minimal fix, I can send a v2 that moves
EXPORT_SYMBOL() outside the macro body only, leaving the function
definition untouched. Otherwise I'll leave it as-is and wait for
Greg's take.

Thanks for the quick review.

Alexandru
