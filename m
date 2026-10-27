Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3E606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SXSoVBju
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705C8112059;
	Thu, 29 Oct 2026 07:59:15 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6061110E4A0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 22:09:20 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so303750f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793138958; x=1793743758;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/PLmL+V/SYmlIq7ZPKJzSVA7G2MVgEzQyQAcifW2km0=;
 b=SXSoVBjuFJD97B4PNC4Cl0kLq13iB+rneR6qL5gziPb8j9VlXFCOEKrww7e97DZ74L
 J5u+ib8H/ozIlAy7RUYJgS9/AdVga5U9NjWEigfSbF5IXt8Diq+AQX5FAQARSUjU1IqT
 82eenQ5ctGTG2D5KT2cN2torqOD9RCdDhp7zacxLFfLlfEalGI22Os2lmMx3kTonevEh
 Zt6oNwQXxvs7Inmpgxx4aZ/VYmy195kRA+EH46V8djv9B4DDE/FeIy+YBIj2tLtbypXr
 pKJdfz0N7KPVe38DyIYvy4XvwP6MbLT5qzPmooAfoUHxI1D4vTzbNTjcEs+8/FjQ58LQ
 swtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793138958; x=1793743758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/PLmL+V/SYmlIq7ZPKJzSVA7G2MVgEzQyQAcifW2km0=;
 b=Iru2dFhdvPPde2yJn4wMQ5FbwlyleeZA3BIUyzrqvLkRHWyoUXmpDZ7UbUQlaPzlKj
 vfHgHDCZPn7KJtQ/WjPvMAJ13vslfH2E5tgs2qoKXk4x4bK3r1tVlPBK6S3DPpkAAY4W
 S7sW/sQZwMssvco2TkCswQE2JZiX4Dg25LXx1WT9kS8AqlvCF99LbDoBuHKHVijLOApi
 ySnIlaxIym/m5eEzzkQbfAt3i8fD3oJV2PEGI32+xx8ic6yaJBzQIqWfyC97AD4qK4Sh
 w3i/OVGTt9Xnb6lOmk+zyDfRbL8E0iHfFHELkqymAxkbELUywJykcz65s/RxDvWNCJTf
 Pm2w==
X-Forwarded-Encrypted: i=1;
 AKwUvByFRt/TweHTCvs//yerAkIyd5n/HOIluud7k9TLdRRUGGQe+JYosiEPLp4tbBKwWr3/fWKYbfJD5Oo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJXEUKtMoam3WM5pZWmxa9tKUeTf6awzIuefMm2jGQ7feMRE9hn
 uwdMw7cDR8eM2vRQP10ngwrhwQFfceRpB/GDlHadw0ChIsdJWnx/EYWKpWvl8MNZH+c=
X-Gm-Gg: AYBFou1DZwi3AtjoZR867CWlRxlN44fESG9VsujjvBI84HIuyfo2lQhAMezuFM+e5Ie
 Ny1ZLEqljTP9sxTMJDMdU33Af2mgr1oy+ympFRnFMeP5U7npjM0OwIZYy8jvVz+iI4uITmyvE9F
 VZBTulf9QPUBnliuabhlkgrq2+sfU0Al4ABbtPCHhG4wdJtAr+Bwtm1Fi/EZoRTAf1GS33NW/GO
 6SphYVdZK+HWes+DXn/mD3o23RuWIj9sSe4lCNMDx9YPBQJ88K0F4SbyR9sAutnqRJmw9NKH+hv
 OF+1FPaE+U/wmeb/8Mm26fgNo21CLs8ElZf/poY4TcKZGjSzGk5xL7M0BB3tIzWRCSXKyhCMKgm
 c1kC37pIyKvZOPlcmWUN/6z4iTaiHErnlsBS6OtY/E5mMZuVkdHFC4WumGqf7UTeaoRfVwye9NN
 etADOqttX301pwB3/XZ7KrxTnRh4rAT15dW5poA4IRi/8IKlRk4PKCr/FuHWSWLd3OpYqGaee0B
 6DgAuM/QYglBXIIAOuuVWxJXWlfPRITjTY6ocPW5ucpYbTYmlLRHfTFtEgrzfuRA7M2vYMSOD/R
 jNCTHE1NTtHf
X-Received: by 2002:a05:6000:46c6:b0:48e:6f:19b2 with SMTP id
 ffacd0b85a97d-48e55a51a7dmr5924445f8f.25.1793138958515; 
 Tue, 27 Oct 2026 15:09:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5cfb:af57:9834:741b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb958sm25306661f8f.21.2026.10.27.15.09.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 15:09:17 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Krzysztof Kozlowski <krzk@kernel.org>, Paul Cercueil <paul@crapouillou.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "H. Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: Add the Ingenic X1600 LCD
 controller
Date: Tue, 27 Oct 2026 23:08:02 +0100
Message-ID: <20261027220802.56348-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <465cb935-2648-458b-9cfc-9b7fd5dc53c5@kernel.org>
References: <270ef5220fdd5ec3e0b88ba5c4ce044992fca41a.camel@crapouillou.net>
 <465cb935-2648-458b-9cfc-9b7fd5dc53c5@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:57 +0000
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

No, it does not. The X1600's controller fetches its frames from memory
itself, through its own descriptors and DMA (programming manual,
section 10.3.1 and Figure 10-1: AXI -> DMA -> async FIFO -> TFT/SLCD),
and the manual has no IPU or other block in front of it.

So the only link in its datapath is the output, to the panel or bridge,
which the binding's port describes.

Will send a v3 with your other points after -rc1.

Thanks,
Olivier
