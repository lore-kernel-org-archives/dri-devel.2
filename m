Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0835CD35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BD910EFE7;
	Wed,  1 Apr 2026 12:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldZpXaL1";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5BA10ED57
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 12:26:34 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-66c5b2e41c1so2861212a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775046393; x=1775651193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNPoJV1+9P6HlUjxEIUEsSTm7esF137eU6g0yQ13nXA=;
 b=ldZpXaL1YlebOumO+8omK2Oac3H0fKq1uZYsyhY0xZXYsihiuxHAlGFghjpNUUyWib
 0paZBLZss4Cv5tdkqNv07TiG9vtpnl7SXZ51vxQ/x5yz+2lZ6/BgZUoJWuSLqaeXze+v
 LGfnwjgEx/F3oOA0Z4H92pBLxMwqtG2nyxfmmYbeVW2tiXMDONyCtHV31b15p1ZrdF5V
 zD3AshJJ05izxCKR+31Wokk2voSlXKApxEpSwXmAHIpqQTuFV+h8ogRgjsxMWGOBQEAj
 wKl1EDZkGP5aHQ5yLRzbJHh988SdltT5sMG4s3p/KtlcWkvYDPYNUql7NWycPOb376/i
 51WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775046393; x=1775651193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gNPoJV1+9P6HlUjxEIUEsSTm7esF137eU6g0yQ13nXA=;
 b=Dwzci+X38gJVrwCpHHk5IBQZrff0xrDMiTV0l/vFDC7KGOexcVeAlGf0FtqlEJFU0R
 uR+8Z8TUruEiobTOIlukBRYBoKtIKbHSIrFKOablTGl/5xVNky/6vVbjStPWh4pVbp7F
 xdZgn1q5xl4EDVkcmQOWgEuZgoZ+t8L/EZp0CUpJ1G0J0ApG8tkkGMT5WE4CP4npT3Ep
 OjzOIdqSe93n08hWUIXEiHosJZcIvHYxtwtOCJSsp853/Ld9RpzxoMZrYqTknII3V5mV
 spRTc9o5LbzPEUmwNDkBhbsK8E88G4Lbj7zkIW+oQcCgVcWPCB+USHbxA9I8MfcFbbYs
 KMJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9vj7RbKzATjPKC7g7wRtW5G+nvF4+1BNRZR8OLgSF4tNVf+Dgnw1PfL2eqE5MiatAyYXqk9BcUpY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn5xy6SSv0nig78Q65d4jdricVaOXuQIU48bvLhW7MSNLDEKHj
 NjuDm+O8pkwZrJYmJOspRnhoZM6nI+rquWQFRkDloXEc5+ZBCr8b3nAC
X-Gm-Gg: ATEYQzwDUhjlZnMhdsnH1x9lf2mT0q5JQ2TmzU0gDn+aj/FX3WcoMA3ZhgTsg/o6oqn
 A1ccE2wOLI8dsJpK20nnKWLyPaZooqla/57DqOQ3jesQVo8PcNY76dmrJgnoTdmjn9X94vVFzSk
 g0DRhGoqP/UhxKxq7Ol0X/zOueMZuuylmhyhnoEKfM7CuIHz6POdAAE3bLaE+yz6j9rDB9++HS4
 Z0aXAIc6nmYgg8ymaEoX47K5MgH/RR23E8mo6BpWacSR4BCGUAHT9DiqVWivKoiVxdl1aiWtg6P
 Csd70XgZk/hI8en36D4vu0PNLGxzrlIbkIgqTuXWJFEh/Fa5P5db4+U2W+iprjTA860QUyApNJw
 3G4MLZKZKd791ysNI33HL1nXiAfjJHmZjJCwettFOQeJUvdaLQEO90jPuTDUm7qd1WhDzQaD5T8
 bhplY8YxPTO3yOVta0Oq36PkiX5Fq7PvGflXJ6CVfSqrHxX7X0pg6s/qoDLuOW8pw=
X-Received: by 2002:a17:906:dc9:b0:b96:996c:8605 with SMTP id
 a640c23a62f3a-b9c1391fdbemr175359966b.23.1775046392631; 
 Wed, 01 Apr 2026 05:26:32 -0700 (PDT)
Received: from JTOLLET-M-FKW7.cisco.com
 ([2603:5004:20a0:100a:a4bc:ddcb:75a8:39fd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5924sm518156666b.32.2026.04.01.05.26.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 05:26:32 -0700 (PDT)
From: Jerome Tollet <jerome.tollet@gmail.com>
X-Google-Original-From: Jerome Tollet <jtollet@cisco.com>
To: ville.syrjala@linux.intel.com
Cc: arun.r.murthy@intel.com, ankit.k.nautiyal@intel.com,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jerome Tollet <jtollet@cisco.com>
Subject: Re: [RESEND] drm/i915/hdmi: Poll for 200 msec for
 TMDS_Scrambler_Status
Date: Wed,  1 Apr 2026 14:26:13 +0200
Message-ID: <20260401122613.76354-1-jtollet@cisco.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ac0AQ_74Tukshr__@intel.com>
References: <ac0AQ_74Tukshr__@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Ville, Ankit,

Thanks for the review.

Ankit, Arun Murthy also reviewed the patch (in the [PATCH v2] thread)
and asked for the HDMI 2.0 spec section reference in the code comment.
The requirement comes from Section 10.4.1 (SCDC scrambling enable
sequence), Table 10-19, register 0x21 (TMDS_Scrambler_Status), bit 0.
Could you confirm the exact sub-section in your copy of the spec and
add it to the comment in v3?

Thanks,
Jérôme
