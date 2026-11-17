Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96B606A332
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pi8x1Edz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E70D10E0E5;
	Tue, 17 Nov 2026 17:33:19 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D687010E0E5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 17:33:12 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so8120f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794936791; x=1795541591; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wClEush0em0gomV0MbpA2Fe3wVn1p16r90QsMPKpJmk=;
 b=Pi8x1EdzGco939SCM8aHogG3Yw9nvwkHbG2+DZh3wHklnB28WrIbbsDBYl78N4MzWS
 YwCrAtB3CpYv4Lfu3gqEY7c0JpW57j5aQBnDfhsRZXzy432AlHwkSxz54OsgkbqaLNPw
 D6qwlGApTQl09yLtOMCTL0888X2S6IABVz5HnS8/XE8gRc0GYssMb5rtwGSYykrtHUfK
 pWXCs2beRymFSCGdC3ZyZNu92ajHX/OxJx0HyLvlCw66QXF9/8UpvOeEHQgSp1LJbkgC
 fQN43BHz1eJN26SbKmpY/r0ouqw3D9lkcBc3PaiCpNkAD1hHthGm3KRqueTbS4OaxlHZ
 9+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936791; x=1795541591;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wClEush0em0gomV0MbpA2Fe3wVn1p16r90QsMPKpJmk=;
 b=fEXVYEykNi/EW5Lv08nOJL3WGu69BlrgvoRszoABoqsPgNKoZ8Mh64zdx+XIRy/jn4
 4S+6zOhdAsxGjVDXY/wJsci3d2MGtQlNQp5O5xVHV3pwHo1U5+dmcofCLmKjD7NGRMWU
 eyebdeB6XYwGkV/gBic9SZEzZ0TypX8ZcoTEkl3Z2ws6+Sfn/heyY4sb4mHNcXYoyDrm
 HfZAUIPmowMgxX8BfH70KAkRShkuTrlxAd6VUomJ3ctkOPTcb59OjiT8JMJNSanT14b/
 yPwDiUxDxmY8zIB2D/+V3AojCLO0Xhcvc2zBdIvNMxgfLbr7cbcMiLFJny5b8i2X+yDA
 ea+A==
X-Forwarded-Encrypted: i=1;
 AL+hErHB1wUtmGdFFftBsZ7NtqPa7yzCH+UsNJq6odPZAErUDBs3012B3l1JgxXFS6sKAPNpLzHJdhI3sUQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z94JMPkMPEwLZX0T/gHqzdodRqAK5l9XtW+6/AdUxuDl/GpnaIA
 347mMgO2r04QaBcZEpcJyMwrtIpfTEDUh7JIYJ9husf0bHxFRBXk8oLW
X-Gm-Gg: AZFdTZfLyrWYCyCBNMUd9UEBVpznr53qlfgtohgxSf/qm5iU6oYf4tz8KMbVWcUDoUC
 uNEFNmla8E0bajX8cA3mdgwICkL8W2PHipq74i92awbWLqmXib9NeDPFUC7ScdqbFwyyUb48w2H
 zJPujLCOxRlhDGkfD5uVOI8skzVYf0k7ElVM0BZwnaJU+vfY7E9k7slxMca60dCpi6TgSX0TLID
 TAYs/8wN0zmNroUTn3nWmmeuVSlhDFiAxUfgZ69G8mbsljzCXZMfpWVKujaUJ/K03WTBpFAZDtQ
 Wc0nHZWNk8L/pzUN8TGTv2t3pyk4Znd6ZVL9msbhX7GRfofruI95Rovb7LAWOiLBlAbu0GsOrNa
 poZ3UHWE5KOQQhf2r06bJ2QCk16vE3nd66fJZtkuhS/dDl643UjxasW9C5Ml25loXv7ptGYYpfh
 Yzg1OwFQovJ8/dU7Hov5slzgkDeYIvF0K9spN2c8PqZdDxoF9VMQReVwM1xI7M/I80ULoddjx2Q
 QpK/uaKoX1uTAzsH/sYJ9Wk8dd02Pf6+1xSGQEFit6a
X-Received: by 2002:a05:6000:24ca:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-4a63a2d70dfmr399933f8f.31.1794936791043; 
 Tue, 17 Nov 2026 09:33:11 -0800 (PST)
Received: from [127.0.1.1] ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a38b9b986esm5691057f8f.59.2026.11.17.09.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:33:10 -0800 (PST)
Message-ID: <6afc8fd6.f0979b8b.2e230b.cf66@mx.google.com>
Date: Tue, 17 Nov 2026 09:33:10 -0800 (PST)
From: Adil =?utf-8?q?H=C3=BCsrev?= Tepe <tadilhusrev@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: novatek-nt36525: fix v1 review issues
In-Reply-To: <af565a17-f7a1-4c24-bf2a-130a025c68e3@kernel.org>
References: <af565a17-f7a1-4c24-bf2a-130a025c68e3@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

You're right, and I'm sorry - that was a git-management mistake on my
part, not a deliberate choice. v2 should have been a complete,
standalone patch against mainline; instead I sent a diff on top of
v1's own (unmerged) patch, which is exactly the kind of thing git and
b4 are supposed to prevent when used properly.

I've just sent v3 as a proper, self-contained two-patch series
(cover letter + binding + driver), each patch applying cleanly to
v7.4-rc1 on its own, with the full v1->v2->v3 changelog moved below
the "---" line per your and Andy Shevchenko's feedback instead of in
the commit message body. Thanks for catching it - I'll pay closer
attention to this going forward.

Adil
