Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0101F109E557
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 05:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6452B10E266;
	Thu, 26 Mar 2026 05:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fuqEqisZ";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6029A10E266
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:41:16 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-66a922a3a05so835450a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774503675; x=1775108475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeNlsGRjk0j75B4U63/NOgjAHeRo7Cmol6vB5z1mUKQ=;
 b=fuqEqisZVGUfM+oKuvsYejm5hUlqmED3KpTVzlBuGhhvGPDrS7NV3Nha50iR3gXai6
 SkW4r84nqQ/VKiVT+YiUNqtawjLi3NTJVqhnvH8SFcvtwKNh3e//170tM2/rJNw8n1u2
 6pQRe2e0xXrEzhmL5GaUrnSq5h579Xd5+1BH8hRSkL4s+kUkHjWCRbkQu9s1kI4sYZqu
 BrufrW7/my+kJGwpVPfHiW/GcpqJQoHDcqTZlE87sTM/Uz8VRGlf5puPFQuWIDVR/Qhv
 O//yqZAahueU2RnMSn1cX/+ET4px4rJ7kqGcskuxXeUyKQ74JCamGGudsaWgRS/XzQKk
 z4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774503675; x=1775108475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MeNlsGRjk0j75B4U63/NOgjAHeRo7Cmol6vB5z1mUKQ=;
 b=R5N8vZ0L5NKpXKtXIpYU6BA8BT/GwItXxTH/pAqvwUfWKkpZCes/YFYPijCRZ/Ax7k
 g/ypMQZgcsy1ErTcPKn6bmefW0cyfRp6WH8wKx1jFpICeYgKn/iHLQ7GlhMLQCkTl69h
 UHlQ7VZTMVl2FljX3rGOdr1A3inwb3NsvBnxrL3422v+wULfG17rE5+WLdKYeQvsGGdW
 HOeztq02uqgb2cE0/q/Zva563/HYN73Of1uOMxYnBsXfFYKejbLvWTXeuro4DkriCSF+
 sJ3h7T63vieX2MBxXMle9NR3fqCDqcBb1RvQxBRd1+EDApD69SMI7G/wcjNT5K62cvwk
 J1cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDPg3GsHL5qUXJwakiRJ0xIb0jvOMDgGxpYEw2rGrH6ZaLldSEsn6SwxFNNPihUCjeQyIxDkHqAdk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBeAat+FyOb5UvaDmpcnwjEAJcSRSu5QAtN1Kem3OvTpiLT9TW
 XWAD8yoM/JZ/73Jofx0LPv6/ozAkDxhJWCJGl3KAY2IkFyJxvcHr6spf
X-Gm-Gg: ATEYQzyOZaw8/iyzeJdlMmm3tz/+AATA/tkIW5oYH0LaxTKeoBq2q03N07rP7lqEVsh
 PFb17XZ0u7xlJOkMzBi65oZjswTr2LMl2I5P3SDq+clxbw57ZFkt/ECQHdQFmfsg4RQlQtZqD6L
 Kv2WrWpmF5/L6WD2uPnwxvkV21kXTjHoBhUwA9XAubdlMpMtRngPXaZy41RSInMTSdTzw/47TBF
 tV6Ty/DvWP7B0a5wyq4Bqm22BLyC9Gn+yYUnVpzgKQ+BIXv6lnQd3QLnocnvqpDsL3vXEvQcFOK
 /zHe4dpAVvo60Yund7kWabFnvZO02s2QBAyLGWtpq4gUCNDPKRib5KaP14Xu4lAsdAIdx9yO+Hv
 KKmQb9VKG1P0yvqnyvnvgZ9jawQnmpct/kI2XL3PFepG2QsdMyG0FxbKBESJnWr2e4qlhzJ8uvv
 F+ROHdv/aAUNgZ5brsfhg6TEHoi+DBCMK/XRPjNu1s8CHXL64MWYMI8LbLhilob1w=
X-Received: by 2002:a17:907:61a7:b0:b97:464:956e with SMTP id
 a640c23a62f3a-b9a5423686bmr358844066b.34.1774503674498; 
 Wed, 25 Mar 2026 22:41:14 -0700 (PDT)
Received: from JTOLLET-M-FKW7.cisco.com
 ([2603:5004:20a0:100c:6848:c80c:6661:b63f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b2043add3sm72494466b.58.2026.03.25.22.41.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 22:41:13 -0700 (PDT)
From: Jerome Tollet <jerome.tollet@gmail.com>
X-Google-Original-From: Jerome Tollet <jtollet@cisco.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jerome Tollet <jerome.tollet@gmail.com>, dri-devel@lists.freedesktop.org,
 ankit.k.nautiyal@intel.com, ville.syrjala@linux.intel.com
Subject: Re: [RESEND] drm/i915/hdmi: Poll for 200 msec for
 TMDS_Scrambler_Status
Date: Thu, 26 Mar 2026 06:41:12 +0100
Message-ID: <20260326054112.51287-1-jtollet@cisco.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260113143107.1446909-1-ankit.k.nautiyal@intel.com>
References: <20260113143107.1446909-1-ankit.k.nautiyal@intel.com>
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

From: Jerome Tollet <jerome.tollet@gmail.com>

Hi Ankit, Ville,

Following up on this patch.

As previously reported, the SCDC polling approach fixes the 4K@60Hz HDMI
issue on my Alder Lake-N (N100) + Cisco Desk Pro setup, and I have not
seen regressions in testing.

Ville, do you see any remaining concern with this approach, or is there
anything else you would like me to test to help move this forward?

Thanks,
Jerome
