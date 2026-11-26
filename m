Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA14606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zUQe7BIJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41117112835;
	Fri, 27 Nov 2026 08:29:16 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C8611243B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:50:11 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cdb628232d2so3907813a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 05:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795701011; cv=none;
 d=google.com; s=arc-20260327;
 b=Ucwoeg2PpHaDsdFeVUNX9aTgt6OCzo87VOlkEFCANBDGl3VOoIDHNFfVgS9v7/b+9P
 sXo+mSzjLR9dVbvIibDnLVbHAgaAvCzRze++sm3BEHehr4TYD6WCyekXz40Se0JlHcUM
 sjmalWOqg7GEgSwdGr7U6YVq+ajN5wM8EkWPttIAGCDz5lUXTbj8he1s+jAfjc9mgvwA
 Di+W6p7m+KbQe684CtxCmyP7KermXdpDItpOIUK41PxdadzdK1PNz61QUkhOA9T41Bei
 vNEkIvdY7Ey94XND9S/eCfpqTBMHwyc5pLfhTQrC2cgW71qEaTpWcdZv2B7d0/AVrUyQ
 dOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=1Klq8z/vgfrWN4rOlDFNoq3SgJomBqQ7KUVIYpK/M5g=;
 fh=om5UJKXZN5kmIf1T+lY57AoEXbtUKJhMgLzBglR0KKc=;
 b=Tl4x6wQSu/hm6SheeUIOWav57oeCWgbQDR6X99BgjchBnFJ8egQYnSQbZHflprKRRw
 Vz9LUjnpD90qOWdp5H9/eraOpMbGf1G2jEa38/Aqqam1RdXBgIdiDBonMG8J7dSPasE7
 phfzjW+8YEwFbm8WBtcybud8kj6a+S/q0fCHR4SdPe8zHWnUxKM847NCSLyVFkDqJzcR
 Wf3aWkoPp3Z87CWxnO3JrT1e3y5Tdtosco5t5xjAXsl5pBjkw1GEEjr4F81zJBNubnIQ
 5PYMEewZek4Ozd8kkak4CdoEHb/8XNdL15xBVVN7Jb1v0PWcBdtTfc5/RI646WWJfVPJ
 7NYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795701011; x=1796305811; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1Klq8z/vgfrWN4rOlDFNoq3SgJomBqQ7KUVIYpK/M5g=;
 b=zUQe7BIJPOm6CFUNym/kj22tA0ZIsCJ4JArEbTQNhcA0v7FLR/BDSqBPJA0e/cJw2/
 wLLEO/nkxRcMY7uTSxewtZ3Ud5tEPgE5SKWrWc7LoHTWS64+eu2fMY32bWeHKF17b7Zk
 y2LRU0wDj3MAWNQDEidBCsXNwqlDv22S4j8P+GeIPIgyKVXmSesiVyKkv8/Fqqj9YJpK
 mnMGXfi5Y5hHvRcQcKiZNZue0716x2FevabNVjW+GtcFsR+xX9QTXGEfmRvSpHEViy+Z
 jD8LcYgjdjnTPBkkAYZ/JO59jnzEn4F93160Cusp4zdfn5hd3TpJX37HzadHP2CYqAUe
 6yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795701011; x=1796305811;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1Klq8z/vgfrWN4rOlDFNoq3SgJomBqQ7KUVIYpK/M5g=;
 b=KtaUO9aDl36QKD9HAoE4DVRHGSVXH11UjEEVyJ08e3H3yu7PoinChVrpjncSPHe8ZS
 EDvGtj8bJSzqAFZ31ay5Jao3D1QWJc9i0t2+I4Nta1HY9v/BWMDAbizXFdlIlZmedaOe
 aXfuuqFKs8w7pfQ8zMDY8xJnDHyi/DLY3mDyc+aP+W3uhh/Q1NMA4awXLTm+8LnvZphy
 Ke7j8Tdm1y4Byp2+ViiCBrJxqwRTSbCOuHLHgHoZF4guS8N64n8LRzp+R6x2IhYVsvq+
 go7hyQRVeB6qU7X8AZDU/400UhhUPPBup1p8kyKPUYlY+USB3ki8W490/KpFdrXskgn/
 KOaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEX3Um4xoEo2cF7W84vtQnUdCF38urAnEXGj54liMNofLgrXFew5gYMrwFB8IMj1JqNggnPLLzMBfE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8YbI6g+3PHxJTsOptRjNaCdCX+ZWyAonGROu7cfbdXgmSqWBzN
 8StMWoxIEZPA7Yw/zAPptJG5g7bYO6SV9Eor0nD/zCMdrlTXcsgdmOYnwNe8ChJgZ9lVMoc3cOH
 vKe/BipVLuWiPZJ+bRIMEQbwA4+k275c=
X-Gm-Gg: AZFdTZcTUXLIYnmhdEq0bxEnw5oT3hEcNj2XVDEiPkPlGfTwFyZp5ZUyvo8xA+t+TXY
 t5KzGsG6Pw5SyXvtC6+4w1ChmHfFMfVPBmWAmdtwVkq7xlrh31fa74CkmJisqQA93ZcFURzayjn
 oyAu09aoeu6QO/uNq5EXpdR1LBOsjUlxrJbnxxjYWtQulB4vNON5KDDCTXaIDHf6UwoQHVZhpa+
 8hMfWzrmaFEuY92ZF1zQZTIsyBkYEnTEjEnTIC0Br8RKBAHOz91FFHPGES1bACvECXUFsICHjTR
 /N8qmwUqzn+N+hamdi7etl5KPeP4HtlPU5y2IEPRPOcTCGYt2Bzgxk2RgKdisYagQ9HELucXMf2
 Rpmxu+076b4CUlXFP5R6jAr10pUKLBuw9gbE7CFR7ZN7gcqZ/36kZGVWmU5IUC3oejllXI6k+Ms
 RM26JDaiby3b+oyVpRNjwMAz6KUeI=
X-Received: by 2002:a17:90b:258e:b0:3b4:fd89:5f99 with SMTP id
 98e67ed59e1d1-3b4fd896a22mr4557419a91.17.1795701010983; Thu, 26 Nov 2026
 05:50:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6675:45d0:b0:76d:f3ef:71e8 with HTTP; Thu, 26 Nov 2026
 05:50:10 -0800 (PST)
In-Reply-To: <20261125-crosshatch-panel-v4-6-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
 <20261125-crosshatch-panel-v4-6-120adc58e737@ixit.cz>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 26 Nov 2026 14:50:10 +0100
X-Gm-Features: Aa3M54p0b4vfkHrSnT4rdCldYookFinl36Qa3uE9h12jsfMJXBruu2dvUgyIvdM
Message-ID: <CAB1t1CxNvCP4KwrqcSs7TFVOCrO-FuvvEfZBARG_BQgLc9YOCQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] drm/panel: s6e3ha8: Assert reset GPIO in unprepare
To: "david@ixit.cz" <david@ixit.cz>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
 "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000e1f25406612e38e3"
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e1f25406612e38e3
Content-Type: text/plain; charset="UTF-8"

Hi David, all,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Petr

--000000000000e1f25406612e38e3
Content-Type: text/html; charset="UTF-8"

<div>Hi David, all,</div><div><br></div><div>Reviewed-by: Petr Vorel &lt;<a href="mailto:petr.vorel@gmail.com">petr.vorel@gmail.com</a>&gt;<br><br></div><div>Petr</div>

--000000000000e1f25406612e38e3--
