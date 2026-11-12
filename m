Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7646606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E11E11254F;
	Fri, 13 Nov 2026 13:43:50 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4FB10E65A
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 20:02:39 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b32b2e691aso12870767b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794513759; x=1795118559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m4cNkNN0zPomANLU7iiqWZuUEPKCVypeIaShvu3dZqI=;
 b=AFQ6nq3S1QiMG93ouv+sZ6kVwjKDwzUZoheyS6uyjLeg1brTvMQecAGHMtJTQvWCzj
 5QZS27HY4hGXXm6UJuWL6kFW3/nfUPcFO2nDVTslBkI9aiZv/E9jDp21FDdL9+LzOfyU
 yBuf+YFhzgt8j8kyz+U4RGE4JH7P01oMp94WWIoKApdrH1v6ORh2GukYNKVkJkuo5U4o
 a6AQRFUkQYaCIpPXzBwyMTDHz52HgwnK0GWFCpLjvIWMsmHEAXYNZ7/ObAyN/8a6kvp7
 Av/pPKCsIPp1IrIO+o9S70oGtdUUMaZAl2W3/67p9wjW0FvWHIzbV9Gn4VyO4ctuC7lD
 dqIQ==
X-Forwarded-Encrypted: i=1;
 AL+hErESJC55GVe9/5kdkQ+CH1fO3yE20MEX2LtEHDvo74kvR3rP3DNJowXASLhKmKNs4hTmoqk2xJarODU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/j0Y0eP8sQ/E0fDgRbzouy0xZetED4JixZhBb0qZ1iTlPaLZkC
 lhb5CPY9KEPcgF77pOoszrOc78Bqv0YURPPDiAyNxVkLYT5zLcHadNyu
X-Gm-Gg: AYBFou2EnqCYxTJ844eiQTpZpg6dgmBqcdkpolCojBZo/0fBEQdgXq1szy6lLP+YVlz
 xgiRjaYzuFLyGi7wIlXG+cO2Ff1BKnI02ZzErxnEXDmnr4tsh1uM5CMA6sv2FRtAnwl92m2nLjr
 MqBtdfbnrSHv64LbRwalzm9kcjn3Lt5NwqMHbxasX8SXLF8gGFTYCMUCsPutCewQfScORStHIZC
 2CUfRCEVxGRO6LaAnW/nB/P4ZMF/82Yo6lskwJJ3o/2dILXnjAGJKfa7oAcRnpHz/e3GKXI2nTI
 h3EjYK2CSxG8kybECZJBrAn32z9jGHbAiORcK/NANHEVYkLJEVWUBLi3NWdGbYIh3/2XPKx/Ipv
 1BcKCBhxeideEH5wDUQsFbaZtEl3ZyHS3B7M1hylJljs1+tGeSDEW7YBpQ8sSBJNO/bkPNHnvoC
 dtJDNORj7Z3letsTD7x3N+Uxt7E9pgggLFo0KlmaivSwr9Q+UO9/DU7bmvLGujmpDHwCzXhvzbC
 d479c94NQ/91xK0oooQTak8Z55+ML980zvIO4DSOta9iKK9qDarIZY5YQd/q8UwonOGpDLwrBYm
 PEDoA+vnphPfWSB/TU0lRlyWXEvOx8emJLKpHUN14UeIbA8N46B1JxkfCZ4WzK9R7QOUCIiBLWq
 xcztPNYeTJJact49Tg/3scvKK2RxOjGCq
X-Received: by 2002:a05:690c:c504:b0:8b3:209d:f8ce with SMTP id
 00721157ae682-8b3bb04e444mr26143357b3.11.1794513758648; 
 Thu, 12 Nov 2026 12:02:38 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa98caffsm3945957b3.27.2026.11.12.12.02.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 12:02:38 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
Date: Thu, 12 Nov 2026 15:02:18 -0500
Message-ID: <20261112200219.6239-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAMeQTsb4+9NiSYzWVWxRt-_Q-t3E8qsC1jb6E_xD3ruGmao9Cw@mail.gmail.com>
References: <CAMeQTsb4+9NiSYzWVWxRt-_Q-t3E8qsC1jb6E_xD3ruGmao9Cw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Message-ID: <20261112200218.aFS5i8zA_BMGasl66gjtTDZPn1VOJFgsiOuXuXeG74w@z>

On Thu, Nov 12, 2026 at 9:24 AM Patrik Jakobsson wrote:
> Alongside Poulsbo, the gma500 driver also supports Oaktrail (improved
> SGX535) and Cedarview (SGX545). It would be nice to support 3D on them
> as well.

Cedarview's SGX545 already runs 3D with a driver I've been writing:
powervr_sgx, a render-only DRM driver, plus a Mesa Gallium driver and
an open GPU microkernel, so no vendor firmware is involved.

It runs on both of the SGX545's platforms: the Atom CE5300, where the
SGX is a PCI function of its own outside gma500, and Cedarview, where
testers have it running on four machines so far. That is why it's a
separate driver; on Cedarview gma500 keeps display and hands the SGX
over as an auxiliary device.

The code is at https://github.com/The1TrueJoe/powervr_sgx

Gabriel, on your SGX544MP2 question: the driver keeps a table of
cores, so the SGX544 could be an entry there rather than another
driver. Happy to compare notes.

I'll post the kernel and Mesa RFCs together here soon, with you both
on Cc.

Joseph
