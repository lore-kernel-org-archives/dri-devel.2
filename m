Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263E7C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 03:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A3C10EC0D;
	Wed, 22 Jul 2026 03:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iVANWGcE";
	dkim-atps=neutral
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3EC10E4C1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 03:58:18 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-92e7632b193so924716785a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784692697; x=1785297497; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0jeICyQW2fPpNALJsCTGYlCb9AbcZZPQ0wg+u4yTtyc=;
 b=iVANWGcEHu90rEVacwRE+qwuYHkYprj/w0lor547S+/KvL6A8cNkiCnQfV5ET+wPCr
 /4rOgqJgD9C3vbRWpNelHEtuS49NDY15IPvEU9FEK+dZiIjvIQ1St9x+4Src0NtbZ7qS
 hrJyq0E4x9/an0qqZUKqINzo4dUpNtE8uledNBUyNjPg1g7AXs+IzzuFK658zSR+IKZW
 iaIbo+4EAkYQdnw2zGni8bpNR6OjdGPEzBwp1Fmz/BVpfvDZixr0phVKMVfvG0T/yR8B
 /4So/+ygNdqMAbLhSz+551dfhBbZzhjBbY0h/DsLgzjN+uRn/BNCtJ1Pa3vV2nEGtRcw
 tIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784692697; x=1785297497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0jeICyQW2fPpNALJsCTGYlCb9AbcZZPQ0wg+u4yTtyc=;
 b=Lu5qyni5TC+ueujquX7GJFXHtw5KvDcC5KQYoLw3REyYSsMO0NVtbWIE75T8O8p/SH
 gFFXj7GauZMxmoAHRccnhzniyxwgdCv5PEg2UyBhal2K4xqsVGTmLlmm6Falm020v/lO
 YAPp5pzZzCFhN/lY2c3rMFMbBKG4YuT4EMV0O0BaWacS8FDKy8nwDhjNBFR9soOyGnNR
 hjgsRrLSCka3ys49EU1D8L68aKNoWy13iVn7RDTPhlPfXZr+bS0sCA9FTOZYFAyu6uAP
 9rtxLoml5eq/vFHgIoOp3WYrBiTVGfjTEUyyNcuSRrveNhAVroL/2f/CsPnhnio5wcXR
 hFnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWRN18FXUlWnSm/HIns6j/c3Huhz+e/HieHeVmXcyIaGfGZbJR5jRPBPVbwDVhVlfX72LQHB6/fNQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybiPEtl7OAm3PfkGULu2WO54WMT1uVARkQJPtYPBxBWD9qwBnX
 07+yoagczqFXWoDHvavH4fMUVtSFMD0cn3YNuY1KEJJ7G3uwDE6wZbZL
X-Gm-Gg: AR+sD10Rsl2l0l93a11eHQSZUuXLKa8IZ8wednqHTv2M6BhUaYAAgtYp8Pyz9ybJACG
 mD5jq4ttwcH27GR1dApKtBvUrBi71GDqzyah933mLcNxoXwW3C/J6WFA95rAhqWJvcdq9P2nmEz
 N64reMYVD3zD0uT6Ogm2zcs7PYdppHYm6diMRNwnFBAczQJp6cjc/g4V9jo1Z/mdTC9YZNmsok7
 yfMYBhKG7UggSbjWOUMfO9hYXUmlTkRUd2H+0ZI/83GCcwisC8okSnFOHHRw1Cn/o/yj0w0p41P
 /KtbTu2CkYr/F2mK7/MMdjtygrqgxngaRJ+Zt2gl6LMNta3069OWbT/M96WM/Rc5XVZXXLduuJv
 9zdyJ4evLmkUo6mBDbNiEPC9PdH5goxsEpYHRxGagDc/EAbx9RUm7O1EHeO9mBxcM/Avw0GQdC+
 4hZtrTyY8MozjsPngUJPzwr7XCqmHvoSHchynSO2AeBlQOxTkWhdqIKA==
X-Received: by 2002:a05:620a:1a1b:b0:92e:cd21:447c with SMTP id
 af79cd13be357-930b3f3e243mr2072924785a.38.1784692696928; 
 Tue, 21 Jul 2026 20:58:16 -0700 (PDT)
Received: from thinker (syn-072-043-128-189.biz.spectrum.com. [72.43.128.189])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930f68c67d6sm65916085a.17.2026.07.21.20.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 20:58:16 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: airlied@gmail.com, andy@kernel.org, azuddinadam@gmail.com,
 chintanlike@gmail.com, conor+dt@kernel.org, deller@gmx.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, javierm@redhat.com, krzk+dt@kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Wed, 22 Jul 2026 06:57:31 +0300
Message-ID: <20260722035734.14981-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <alil0p_s9-dM9j_t@ashevche-desk.local>
References: 
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

Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

>>  	{ "ssd1327", SSD1327_ID },
>>  	/* ssd133x family */
>>  	{ "ssd1331", SSD1331_ID },
>> +	/* ssd135x family */
>> +	{ "ssd1351", SSD1351_ID },
>>  	{ /* sentinel */ }
>
> To avoid conflicts it's better to convert this ID table to use C99 initialisers
> (so Uwe will be happy).

No problem, adding a designated patch to v4.

-- 
Thanks,
Amit
