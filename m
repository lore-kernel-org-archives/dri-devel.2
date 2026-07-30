Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97915C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C5710E4D5;
	Thu, 30 Jul 2026 16:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FY28KLPy";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976EE10EFDE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:31:27 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so18883475e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785429086; x=1786033886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tDC5/bw3cdRDVjrpZelwvclb9nIKaQHdJQFlUccO1NY=;
 b=FY28KLPyoZ2Oa/1uBJnFLBitUJPwVHzsfCDYGukdWIY8qAJCrLxEkp24Vr8hZsRxrw
 YUVuuk19Q6ROE53dFT93pE8ObfPZvffNPUEX1aRa0Mj75EC6bfiEAZ1Q1UBzI8XlKekO
 kxEk9UzGt1Ljvv6FoEyTkK91QJ54B9yiR1JdNZl9WwHHHexw3K2IvOi5rY6kkcbxwPvG
 /5o1WaAOWJW7hyc18HSRHTQaj+vEEhFSvMZ/c2cWbAi4qYi4S3Sw/TXManorUr05/ih1
 GFvJpfPPzWMnR0b7+FSsn7UyYwzmMT6Se4lqefUsbBXWdw/n42GTgZfplRAJFU7FzpPm
 LNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785429086; x=1786033886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tDC5/bw3cdRDVjrpZelwvclb9nIKaQHdJQFlUccO1NY=;
 b=IvIstqFNAq6DD5nglG2mdd6ExkXHZ7m1nOyvTAHH4PT8HWok+RZX1nD2lsVGv+Tx7Y
 BX9poiVHaqa/nbjYUThYrcp2eAZ9EEOzPat1yS/dNl2k0E5pkVteeGuJICBbAxqsaGsv
 Fp3R4Cj1hxXnQ12HZ2uOGYGIm715WPr5G3yhyTFAzw/0RUB1SjBjdkaJntKCPIDKkEN1
 c3wrMmWpWFM1ygtUacAtP18F8RpkXazRq9qIfDaHwjhIzz8lJANrRTs84HvvvLfO4blI
 i65lrxYOXfnMUhreNnJuo7MJQDTq51fhRN7B6006KTKJEhhRBaErCcjm6pLGiUeMYZMy
 Z8Qg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rplkz4c0bVaIstR7SmdHVKWQJZAOgBS9Jx0+S1WEi9qo+ruOZutjx41clLvF2We03d0B3KFz8kKbq4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpFq9QhuGj6LLlb/c1BTEcpzv8cNoCABz5ShXa7MkknAr476cB
 jcYl8dkjpjSUQWa5ePvx9Rxhd1Y8M2e2Z3CFo6Gqlkz7s95vvZfjceaO
X-Gm-Gg: AR+sD11kDicJMIYvROrw7mNa3d+h7CoRc+murGAP3Tue9buLnaFoJAgWwHH7MhCiBqo
 JVh9IZjKW54ZeUin6ncQUTvWUsdQ5a4xEcfiDGVqPHm0jPEN+4NKh/d1ftqx0OAVwATvAvpmqU2
 J8HPxFI8Ju4CEaDC7WEd+OfZTxzu8MYm+Xnh7M/HDHM7DX6hLPtNajPiQhIa3e9KxZzMP5QIRRk
 E8sJlMvFCTBfOMOStV4c5eQ6Irw7uQDRcx/UwAhHOE/rv85xrM9l17NhedH9FaYa3zNHWpQCaEZ
 AyEf+atFvMTX4vQOXfMNrxGJJ/XY+2c/BLbLw2qpQPUkfeUbUuPx8ywLOOJzFP5MpIqCmCnJIXB
 Txt1w1LTMBA2mwH9iyIWUeIOfwr+ndw46/Ody+of+jZSyApON3Notg6ztVrU16ltOGCctdl6g1V
 7NZOAQcHSBVqKp1eA7E5ckN6wSBf8arAF6FDAapYDKZat0exSLDeHhlPOEza44XQtz+heBso8xD
 QvHFjYzSYLQs6YQSafTDg==
X-Received: by 2002:a05:600c:4248:b0:493:f78f:cd70 with SMTP id
 5b1f17b1804b1-49800ebefc7mr30365705e9.18.1785429085720; 
 Thu, 30 Jul 2026 09:31:25 -0700 (PDT)
Received: from JTOLLET-M-FKW7 ([195.77.44.211])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cc3asm8155790f8f.23.2026.07.30.09.31.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jul 2026 09:31:25 -0700 (PDT)
From: Jerome Tollet <jerome.tollet@gmail.com>
To: rodrigo.vivi@intel.com
Cc: jani.nikula@linux.intel.com, ankit.k.nautiyal@intel.com,
 ville.syrjala@linux.intel.com, arun.r.murthy@intel.com,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jerome Tollet <jerome.tollet@gmail.com>
Subject: Re: Question about drm-intel-next vs drm-intel-next-fixes for HDMI
 scrambling patch
Date: Thu, 30 Jul 2026 18:31:23 +0200
Message-ID: <20260730163123.32157-1-jerome.tollet@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730033607.17136-1-jerome.tollet@gmail.com>
References: <20260730033607.17136-1-jerome.tollet@gmail.com>
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

Hi Rodrigo,

Yes, I agree that this is the appropriate Fixes tag:

Fixes: 15953637886d ("drm/i915: enable scrambling")

Thank you very much for picking this up for v7.2.

Best regards,
Jerome
