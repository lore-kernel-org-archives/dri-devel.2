Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93596082BDD
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x1xB7EzR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DE010F055;
	Mon,  9 Nov 2026 09:31:35 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC38A10E155
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 03:12:32 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so358130eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 19:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794107552; x=1794712352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LHv2Pqb+TQyXv0BOVUqaNYmcgCOkpulObiMNqyQ/8HE=;
 b=x1xB7EzRb1hqZqFXZMjkvvcRu+mC7oZ79liyCHWADfITUoEmFxUlrSf/L++LkkVhTU
 et9Y3mx/NpNniMkj74yGbldHphqBimfIS/vipt0UTKsSuScWuSyjZpkJNtukRCAGlNR/
 Ikvt1lIZNyLeJx/Vsbc2jOayzTE5jvWZ28y34Fr9D9qwLVwSbUExkb3Ibfn/7Vu6ljPl
 I1UrTpzb5l+9AF66hnUwAhScENT4YGEPDIqHccUaRnYcQm4Vbw9fD+zza8W9Ebp18bar
 IoSIDtngob9+kL1DNpoLCexxlpdt0EvT5efvG3rnyN4DuarGzEucCk05ZVSG4Sj/SRVj
 KsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794107552; x=1794712352;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LHv2Pqb+TQyXv0BOVUqaNYmcgCOkpulObiMNqyQ/8HE=;
 b=VhMCu+8OjmwV4meehWtd6HlWDKfGSyXY49aFcP8YbvTM+aORwldEu0tOlzOXYoiO9D
 aTH2y9Zndl4wL9CszYHjSZe6FWiNz0pLzw9FmLgncjsUday9JFMYYcoZmdyAUX/jllM6
 hS44uEJOfwvPK9DWc8ywcuRudAASs81WDWfbnTDQkrCMXa/4o+qi/ghye7zOvBG5gqJp
 WE254kBd0iDIZyoEiUO/xeS8rDlpmiIZCwpNtMWbhp5byJJXdlCaPbnAawtl7RfKYuZh
 zEuG5qlpA+/iL/lae402egGvastffX8gi3zRTKE+Ixey3swy2c+tTSvn0pqHG2ZcyruF
 O3ug==
X-Forwarded-Encrypted: i=1;
 AL+hErHy5CP2/82HexhC1bfRz4d0Nl4GSivIq4n52J20/Tgnx+MzZJ2iyL/kRmpUPt7AW5RZw1rcyCJzfLQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/vwMx4k3DiLq/W0pIdUn4A//IUSZQtYSffPDT7rw6i62fO2mfM
 GL7VSZ+p9L9hfTspu2G+eQo0pFEJwmMQaZ/CkikEN7MBx7sBgHJMLQ/W
X-Gm-Gg: AYBFou2mJZ9T53HAMKKPS+AekCPlLBPjE6eJzOwrMrstJaWEhpnGJn/4ZxdFu/a4IuJ
 4PXFDU/B4PsN422ZHMCnN5G+7BlHC0zevUKR+5LLeM4dzvi9FIrMBbnDByZTS0+XWF06YnXl1QE
 7umk3fDnzq16YHessx/1rSRZb7dsn9zLwcEw3sb/ZrDBZcC6vjCYHdJhfvqialnxmNCQjNUH8nZ
 LeUUx9AL6IAPB7iGh/OjOnAq5zUoXHQSkEOqbTA5kERmh6JmK6QnbkAQcs0c+4F9mNV9u2uiaWJ
 JOgrj+k+cYNo/VeVfPZFRHBQSD5Hz8ngnu28s9c/MKyWS2oFVzHmXjRZbrItUqru0g43fc/+3rJ
 kPf7Evrg6bwumxvyxOIfnoUmYr8/Kj1Z7SmtmhhE2pFq5+axnBCIecEYDXeE2BSk+OZ6I9QMiSF
 qo0V8slADu8sDWPZH/0JykphcejxF3g96Gqdl19AaoCRWTeeGEq6eihzq7G/Pja4fEyJSQLFZvH
 AbPDOq8cbXbBFEDNARt9kpdJd0VBIKeF0KlSq6NbC/8cnagC88mwJH/07h8e0kb9spgy2zvwmDu
 NcSHBJY/kM9Ol+b8iKEDfCGW3mSIziTZet2jNc+xP26xLDROneLfSQGdBlXjyOc4uCdTln+A3PU
 0qBdp2zY=
X-Received: by 2002:a05:7301:640a:b0:370:d7fe:6585 with SMTP id
 5a478bee46e88-37256614894mr1378849eec.11.1794107551969; 
 Sat, 07 Nov 2026 19:12:31 -0800 (PST)
Received: from ?IPV6:2600:8800:1aa1:b100:c803:e868:a462:afb5?
 ([2600:8800:1aa1:b100:c803:e868:a462:afb5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3726039c635sm1998121eec.0.2026.11.07.19.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2026 19:12:30 -0800 (PST)
Message-ID: <097af97e-4d8a-477e-8eae-89f3fe485dc1@gmail.com>
Date: Sat, 7 Nov 2026 20:12:29 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/vkms: make argb_u16_to_RGB565 round resulting
 values
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <20260928005301.367977-2-matheus.aalmeida@inf.ufrgs.br>
Content-Language: en-US
From: Sidharth Saha <ssaha2000@gmail.com>
In-Reply-To: <20260928005301.367977-2-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Matheus,

I wrote a KUnit test for argb_u16_to_RGB565() covering zero and max
values, the channel midpoint (0x8000 -> 16/32/16), the 0->1 rounding
step for a 5-bit channel (1057 -> 0, 1058 -> 1), and distinct values
per channel to catch channel placement.

Without this patch, the midpoint, above-step and distinct cases fail
(e.g. green comes out 31 instead of 32, i.e. truncated). With it, all
six cases pass.

Tested-by: Sidharth Saha ssaha2000@gmail.com

Since this rounding fix was lost once before in a refactor, I'm happy
to send the test as a follow-up patch once this series lands, or you're
welcome to fold it into a v2 if that's easier.

Thanks,
Sidharth

On 9/27/2026 5:52 PM, Matheus Alves de Almeida wrote:
> Currently, argb_u16_to_RGB565() truncates the resulting channel values.

