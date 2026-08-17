Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E540C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4E310E673;
	Mon, 17 Aug 2026 06:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nCl7QzL+";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C914210E30F
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:30:27 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-92edb12cdf2so236779185a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786941027; x=1787545827; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CPLvDivB4c9wVL9RXmPxLXCDhG9sE9mDc6YMqb8U490=;
 b=nCl7QzL+9XugMrKLe64m5tXzPqpQZlKZ4DQ255D3WfrBumzvqcazpRl+C1rsiBdmRl
 d/2FKwvq+MCaveA5uMM4UFOhGVDLlMSdOhRT6O1QsAl5YZ6aElOaVmtJGgMeT2e8Zvri
 vk63a74dYwREMRj4Fl0AXvPK4VaqQq+hh3a1g7uNDSGDPGKtCU6drjREIYSZhb8WNl7U
 uMAqRqihs49oSbgYBHloL3SAv/VH5b6Nvq7L80YWR0BcpNbK+temWWlf3zaF5Bn2Wbuy
 Lw55PFix4K2Z1LHBy42BxcHHpDT+w/4ZCCSeNBzBitnKG+dxbx0xcw4ZfHwgR/Z4X+hy
 WNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786941027; x=1787545827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CPLvDivB4c9wVL9RXmPxLXCDhG9sE9mDc6YMqb8U490=;
 b=O5ItT3SLSY+lBCZcYxyVkW8r+Rl9jQ7SZBmqixwo0uqhhDhSXCHNfFR0f/weGKa7YM
 laSl+WerOGvdx3lhH6w92K48yqNYsy+yNwhsH+N71aMrJ7uk7uvyzOyJtXWK/32o4kcq
 n6HgDcePt+1E1o6GM3GOvWp3L35k5h2dfvx3PtbkuPrtDNsw+Jg6Ii3gSAQLJhL7w8tr
 ZpdywqYw1fniTvRahEOXq3LQk5xB+BPnJt5wBaJLym9Fka9afNAk+sBxklES57SMsYOW
 pdqohJGB+8SgeTAZihyNTBVa9PIYq3FCshwwEGPXpJVcXqRtaEW/qO9feIfFHSDTvvYj
 VsYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rps2rBDxtKge3ph8EoMgmKUJH5SruCPhCa3c0xsKttHMy/8FghgUGW12hrUNbMVIPJ4WEBMR6lafYw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwI79an0gzAcNwioqlmADKcETGkfcM46HogpQM0SG5g9/JPwsgI
 V07lxv8aG8D7VGvk3CBhe211Jg9JXngopOB6qJcxcqxjBYE9QBEy4qAq
X-Gm-Gg: AR+sD10ucc+83q5MkLqN0TAz0DyNfyYxpapFP5MZOlQ4f4KlFtuUk+h6p9hWAA7QMcv
 lwtV1xvkexnku1usYCx2ZFqcyiTJd03KIc59lalTaH3YbtaHbbYBxgu+HVHM2tCRQowRfE3CvsY
 d67ImcwCpAh7TcL4o2TC5oIVDw8mPGekXcV4gYJCb50qS4HVKSm2nIpDMy+9TfNKZImlEsK85gj
 ICA46L3zpTve0CT3R3bMSCzJtVtb9VKL/txR3CxpNWjjr1QdTkYSACiytch7exhOrULfUQ1fiKH
 qArdIMZQSywL6hjdTPDfADCTj2eyy850+Wj5Idu0yKiRvGRJwR+1rH/6KOGeMTVtzA22kULcn6p
 UA98+5qK1NDmmfwt8Rzzzn0nnYSzeTemTNEhvG0JFOPSCj/wfjMfba6JMKeO0mD8xnLscKEkZqw
 BX3gWqbMiET6kDZUpIwNiSqVg7VByYOLcRGoRHAtWDouCG0Nr+o695zHLRblgxa0fKp0cYHNtRZ
 zF/qj9m8lBbznpKjNLz97rZEhk5z6hCcXELBLzcK5k3CjKv95FmDv0Pd6PZmdULY14cCwGd
X-Received: by 2002:a05:620a:45a7:b0:930:a963:da77 with SMTP id
 af79cd13be357-936d22ea9b8mr2233278685a.26.1786941026676; 
 Sun, 16 Aug 2026 21:30:26 -0700 (PDT)
Received: from holowork.tail3176d.ts.net (static-68-235-46-85.cust.tzulo.com.
 [68.235.46.85]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4580f7ebsm1197846d6.5.2026.08.16.21.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:30:26 -0700 (PDT)
From: "holofermes@holowork" <holofermes@gmail.com>
X-Google-Original-From: "holofermes@holowork"
 <1163915+holofermes@users.noreply.github.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Mon, 17 Aug 2026 00:29:54 -0400
Message-ID: <20260817042954.391736-1-1163915+holofermes@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811122603.30773-1-amit.barzilai22@gmail.com>
References: <20260811122603.30773-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 06:55:17 +0000
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

From: Fabio Piparo <holofermes@gmail.com>

Hello Amit,

> - Add a bool cmd_params_are_data to ssd130x_deviceinfo, checked after
>   the first byte is sent to decide how to send the parameters. If it is
>   set, the parameters go through ssd130x_write_data(); otherwise the
>   existing byte-by-byte loop is used.

I have an SPI SSD1322 and I can confirm it also needs this flag, and it also
takes command parameters on the data path. I plan to send SSD1322 support
on top of your v4 soon, but I'm happy to test v4 on that hardware when you post it.

Thanks,
Fabio
