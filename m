Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E58606A32E
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DHVKiFL2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4784D10E634;
	Sat,  7 Nov 2026 14:27:51 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83A510F2A9
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 11:22:46 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso462421f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793964165; x=1794568965;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ieGADuHKQdAMTXfJjcI0pPXfovk5qK/wiv1qHG7Gn7U=;
 b=DHVKiFL2pVrg1KyYae8ETNyuWb+reEHBjgjX7AsN5kberYlJpJ6REUtIfJNZgKJmoD
 tURZ2A32fC926KzqD9ACcB2YDhB6WOAzfOgb/yTMBdEzvTcVQDxmFrEOV0Ji49lDXobs
 cACHhWLLF8m4/iX8WjIUVl5U3/oG4mUh6Jg/oSu6drRYVS2b0RZVeWe8CIBdBNxmGElG
 XioHBtAfDIvNnyfKG5oKsgCfRIq4PwHLQPV803rIslE7X0wqDtJykD4LvHWuccU6td8T
 cIDvSE0xLnQrYpeaT/GIVgwasGtmPaqtB/Hs3ThW19R/MFsCE+1PdP7lbD8gDV8qN5RO
 3ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964165; x=1794568965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ieGADuHKQdAMTXfJjcI0pPXfovk5qK/wiv1qHG7Gn7U=;
 b=UTrWuYBpSq6FzP2RbOrXYuxj6iuuUBiXJAg1AO0BVUb62WLs63IvRJlgYv1BK2UU/R
 4tmNAXJa6pJYBYF4P+UdYkQlBV51X260TdBAP6V8zWxkrtZi8lN5UQ+Fh7tsbbtk98a0
 eO1DINGwuMR74s0YvgijgGMLd4yrxcGbgJXGyaoRBcOyVeXz6snZDObZVC4N6i9KVUDh
 Gg8UqBvFyf4UVb9Aa+dc380WFuTdaFB6Vi3ZCGeiXLQViEkdUa3ikb/1HIqmugtHniw0
 1egZjgMl0W/lZz7lRER1TWvtQ1mCaUSwCFCcSQ3isUFbzaz4MmMhcB2q6959Z70CNrai
 tGVA==
X-Forwarded-Encrypted: i=1;
 AL+hErFUWXFcTwM4QkT4NMdMh3cZO53s2OHqZkV+nP4peqiGEUjMcSmOTOVrpAcSmuZqkhtH97PTISlNI7U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8uP0nqNJVHhh2iOFN31sQkUZ5n/YLiy8yX6LaqUPo+1TalIqL3
 cRqrklfVQjLUaKD9q3Svn05YxJIDWrJ5GSxOloVrg3aZlskaOR0mG2v4UqjFzto5UWk=
X-Gm-Gg: AYBFou2YvhENEeEFHyH3/7JFya0xnPB6SjBmdQY0/ucU6aq11BtGpwibEHFIVmIp40n
 +3pd0bojsYPCQxqmAU0U9j+AnoBGzpfgcqznJ6XcAJmNgzZNOylMIA5fyKA3FD5SfNF3YKqvA7f
 CT0tkSl1yqq95LIGiHQKnSvvjoF/g+ytFJl68mG58u2Y/w2ygxBhgIP3kxbb1JOdPRpFToGFs6D
 5dpDJkmYkPkwbkW6gZfbmqDBvxPMaRUxXNohTcbnM6xf+MPVOnvADImpMr8XYUJBRmmIAEksTUc
 Rymfd7jZZmTxTKG///fFFz21yhGA99nQ69XtXDNmmAr3v0Yus4Oo5ODfhy/5h7dmwShe1bBKX5m
 4Aml8oS+VO84/bp8mCOzHtvapGBx5aIptGYrRJhrWVXr93iQWuyvj8z92Lj4nktBud+IHRHiUjP
 hOAXhyeoshM0nUS35qWdbg3on0mCupna8bFV0etfXqBekcOY8Tul3JlP/cZH53b8K4LipNOMLje
 QGF2moeRG/vh7Oaymdh/6Qkt4IJbfiY+OTngu3/l5b8s5et2TqnHN07rbIQLmAIoyN/VNYI5rBZ
 lvZwdyev6DtvsnQsvItk9Be95rgT2AJ62SwGO7oSVfZLkxDlWkrFwjho1bDxNGwDG1IChJ04NRa
 8/XFfv1rq
X-Received: by 2002:a05:6000:1861:b0:493:803e:800f with SMTP id
 ffacd0b85a97d-493803e802cmr669893f8f.29.1793964165187; 
 Fri, 06 Nov 2026 03:22:45 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5c25:f8d1:d9d7:54c1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-493070bde9bsm2890244f8f.36.2026.11.06.03.22.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 03:22:44 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: display: Add the Ingenic X1600 LCD
 controller
Date: Fri,  6 Nov 2026 12:21:28 +0100
Message-ID: <20261106112128.14213-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <09A3F895-9007-414E-8EE0-17BD18E63F53@goldelico.com>
References: <20261025191640.13592-3-olivier@mgcrea.io>
 <09A3F895-9007-414E-8EE0-17BD18E63F53@goldelico.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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

Hi Nikolaus,

On Thu, Nov 05, 2026 at 11:27:12AM +0100, H. Nikolaus Schaller wrote:
> The manual for the x1600 is a bit ambiguous, but the x2000 and x2600
> documentation identifies this block as the "DPU (Display Processing Unit)
> Display Controller" (located at base address 0x13050000 on all three SoC).
[...]
> Please update the compatible string to "ingenic,x1600-dpu" (with "ingenic,dpu"
> as the fallback) and rename the file to ingenic-dpu.c to reflect that this is
> a scalable DPU driver not limited to "LCD".

Agreed on the name, v3 uses ingenic,x1600-dpu. The X1600 manual says
DPU too in its register and clock names, and when I checked the driver
against the X2000 manual it came out as the X2000's DPU without the
composer.

No ingenic,dpu fallback though: writing-bindings.rst asks for SoC
compatibles rather than family names, so an X2000 would be
ingenic,x2000-dpu, with the X1600's as its fallback if its registers
allow.

The driver keeps its file name for now. It only drives what the X1600
has and what I can test (parallel RGB from one plane), so the split
between the core and the interfaces, and the X2600's rotation, is better
shaped by whoever adds the X2000 with a board to test it on.

> However, this approach triggered a kernel lockup during boot
> right after successfully running lg35583_get_modes().

I can't reproduce it here, the R1 comes up with its panel at every boot
(with v3 again today). With nothing on the pins I don't know yet where
it would hang. If you get a log of it (the last lines with
initcall_debug) I'll have a look.

v3: https://lore.kernel.org/r/20261106112000.1612-1-olivier@mgcrea.io

Thanks for the review,
Olivier
